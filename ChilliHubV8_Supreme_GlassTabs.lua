--!strict
local function InitializeDynamicInspector()
    -- ==========================================
    -- 1. IMPORT DỊCH VỤ HỆ THỐNG
    -- ==========================================
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        warn("[Inspector] Script này cần chạy ở môi trường LocalScript (Client).")
        return
    end

    local playerGui = localPlayer:WaitForChild("PlayerGui")

    -- ==========================================
    -- 2. HẰNG SỐ VÀ CẤU HÌNH QUÉT
    -- ==========================================
    local REFRESH_RATE = 2 -- Chu kỳ quét lại: 2 giây
    local POOL_SIZE = 6

    -- Các từ khóa mục tiêu cần nhận diện (viết thường để so sánh không phân biệt hoa/thường)
    local VALUE_KEYWORDS = { "value", "money", "$/s", "multiplier", "rate", "income" }
    local RARITY_KEYWORDS = { "rarity", "tier", "grade", "rank" }

    local GLASS_NORMAL_COLOR = Color3.fromRGB(255, 255, 255)
    local GLASS_HOVER_COLOR = Color3.fromRGB(210, 230, 255)
    local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- ==========================================
    -- 3. ĐỊNH NGHĨA KIỂU DỮ LIỆU
    -- ==========================================
    type ScannedEntity = {
        ModelName: string,
        NumericValue: number,
        RarityText: string,
        InstanceRef: Model,
    }

    type DisplayItem = {
        Title: string,
        SubText: string,
        ButtonText: string,
        OnClicked: () -> (),
    }

    type PooledFrame = {
        Instance: Frame,
        TitleLabel: TextLabel,
        SubLabel: TextLabel,
        ActionButton: TextButton,
        ActiveConnection: RBXScriptConnection?,
    }

    -- ==========================================
    -- 4. THUẬT TOÁN AUTO-DETECT QUÉT SÂU WORKSPACE
    -- ==========================================
    -- Hàm kiểm tra xem tên của ValueObject có chứa từ khóa mục tiêu không
    local function matchesKeywords(name: string, keywords: { string }): boolean
        local lowerName = string.lower(name)
        for _, keyword in ipairs(keywords) do
            if string.find(lowerName, keyword, 1, true) then
                return true
            end
        end
        return false
    end

    -- Quét toàn bộ Workspace và lọc ra các Model chứa thông số tài sản
    local function ScanWorkspaceEntities(): { ScannedEntity }
        local detectedEntities: { ScannedEntity } = {}
        local processedModels: { [Model]: boolean } = {}

        -- Duyệt qua toàn bộ cây đối tượng trong Workspace
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") and not processedModels[descendant] then
                -- Bỏ qua Character của người chơi hiện tại để tránh nhận diện nhầm
                if descendant == localPlayer.Character then
                    continue
                end

                local primaryNumeric = 0
                local primaryRarity = "None"
                local hasTargetValues = false

                -- Quét các đối tượng con trực tiếp bên trong Model để tìm NumberValue / StringValue
                for _, child in ipairs(descendant:GetChildren()) do
                    if child:IsA("NumberValue") or child:IsA("IntValue") then
                        if matchesKeywords(child.Name, VALUE_KEYWORDS) then
                            -- Lấy giá trị số lớn nhất nếu Model có nhiều thuộc tính giá trị
                            if child.Value > primaryNumeric then
                                primaryNumeric = child.Value
                                hasTargetValues = true
                            end
                        end
                    elseif child:IsA("StringValue") then
                        if matchesKeywords(child.Name, RARITY_KEYWORDS) then
                            primaryRarity = child.Value
                            hasTargetValues = true
                        end
                    end
                end

                -- Nếu Model đạt tiêu chuẩn thì đưa vào danh sách
                if hasTargetValues then
                    processedModels[descendant] = true
                    table.insert(detectedEntities, {
                        ModelName = descendant.Name,
                        NumericValue = primaryNumeric,
                        RarityText = primaryRarity,
                        InstanceRef = descendant,
                    })
                end
            end
        end

        -- Sắp xếp danh sách giảm dần theo giá trị tài sản
        table.sort(detectedEntities, function(a, b)
            return a.NumericValue > b.NumericValue
        end)

        return detectedEntities
    end

    -- ==========================================
    -- 5. THIẾT KẾ GIAO DIỆN VÀ OBJECT POOLING
    -- ==========================================
    local poolList: { PooledFrame } = {}

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DynamicWorkspaceInspector"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainPanel"
    mainFrame.Size = UDim2.new(0, 390, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -195, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainFrame.BackgroundTransparency = 0.25
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 1.5
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Transparency = 0.7
    mainStroke.Parent = mainFrame

    -- Tiêu đề bảng
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundTransparency = 1
    header.Font = Enum.Font.GothamBold
    header.TextSize = 14
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Text = "WORKSPACE ASSET INSPECTOR"
    header.Parent = mainFrame

    -- Scrolling Frame chứa danh sách
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "CardList"
    scrollFrame.Size = UDim2.new(1, -20, 1, -50)
    scrollFrame.Position = UDim2.new(0, 10, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame

    -- Nhãn trạng thái khi chưa có dữ liệu
    local emptyStateLabel = Instance.new("TextLabel")
    emptyStateLabel.Name = "EmptyState"
    emptyStateLabel.Size = UDim2.new(1, 0, 0, 60)
    emptyStateLabel.Position = UDim2.new(0, 0, 0.4, 0)
    emptyStateLabel.BackgroundTransparency = 1
    emptyStateLabel.Font = Enum.Font.GothamMedium
    emptyStateLabel.TextSize = 13
    emptyStateLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
    emptyStateLabel.Text = "Đang quét dữ liệu Workspace..."
    emptyStateLabel.Visible = true
    emptyStateLabel.Parent = scrollFrame

    -- Hàm khởi tạo Frame trong Pool
    local function createPooledCard(): PooledFrame
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -6, 0, 56)
        card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        card.BackgroundTransparency = 0.9
        card.BorderSizePixel = 0

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = card

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Transparency = 0.7
        stroke.Parent = card

        local title = Instance.new("TextLabel")
        title.Name = "TitleLabel"
        title.Size = UDim2.new(0.68, 0, 0, 22)
        title.Position = UDim2.new(0, 10, 0, 6)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 13
        title.TextColor3 = Color3.fromRGB(245, 245, 245)
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextTruncate = Enum.TextTruncate.AtEnd
        title.Parent = card

        local sub = Instance.new("TextLabel")
        sub.Name = "SubLabel"
        sub.Size = UDim2.new(0.68, 0, 0, 18)
        sub.Position = UDim2.new(0, 10, 0, 30)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.GothamMedium
        sub.TextSize = 11
        sub.TextColor3 = Color3.fromRGB(150, 200, 255)
        sub.TextXAlignment = Enum.TextXAlignment.Left
        sub.Parent = card

        local button = Instance.new("TextButton")
        button.Name = "ActionButton"
        button.Size = UDim2.new(0.24, 0, 0.62, 0)
        button.Position = UDim2.new(0.73, 0, 0.19, 0)
        button.BackgroundColor3 = GLASS_NORMAL_COLOR
        button.BackgroundTransparency = 0.8
        button.Font = Enum.Font.GothamBold
        button.TextSize = 11
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.AutoButtonColor = false
        button.Parent = card

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = button

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Transparency = 0.5
        btnStroke.Parent = button

        -- Hiệu ứng Hover
        local tweenIn = TweenService:Create(button, TWEEN_INFO, {
            BackgroundTransparency = 0.45,
            BackgroundColor3 = GLASS_HOVER_COLOR
        })
        local tweenOut = TweenService:Create(button, TWEEN_INFO, {
            BackgroundTransparency = 0.8,
            BackgroundColor3 = GLASS_NORMAL_COLOR
        })

        button.MouseEnter:Connect(function() tweenIn:Play() end)
        button.MouseLeave:Connect(function() tweenOut:Play() end)

        card.Visible = false
        card.Parent = scrollFrame

        return {
            Instance = card,
            TitleLabel = title,
            SubLabel = sub,
            ActionButton = button,
            ActiveConnection = nil,
        }
    end

    -- Khởi tạo sẵn Pool
    for _ = 1, POOL_SIZE do
        table.insert(poolList, createPooledCard())
    end

    -- Cập nhật Frame từ danh sách
    local function updateUIList(items: { DisplayItem })
        local totalItems = #items

        -- Ẩn/Hiện thông báo rỗng
        emptyStateLabel.Visible = (totalItems == 0)

        -- Mở rộng Pool nếu cần
        if totalItems > #poolList then
            for _ = #poolList + 1, totalItems do
                table.insert(poolList, createPooledCard())
            end
        end

        for index, pooledCard in ipairs(poolList) do
            if pooledCard.ActiveConnection then
                pooledCard.ActiveConnection:Disconnect()
                pooledCard.ActiveConnection = nil
            end

            if index <= totalItems then
                local data = items[index]
                pooledCard.TitleLabel.Text = data.Title
                pooledCard.SubLabel.Text = data.SubText
                pooledCard.ActionButton.Text = data.ButtonText

                pooledCard.ActiveConnection = pooledCard.ActionButton.Activated:Connect(data.OnClicked)
                pooledCard.Instance.Visible = true
            else
                pooledCard.Instance.Visible = false
            end
        end
    end

    -- ==========================================
    -- 6. VÒNG LẶP REAL-TIME ĐỒNG BỘ DỮ LIỆU
    -- ==========================================
    task.spawn(function()
        while true do
            local success, detectedData = pcall(ScanWorkspaceEntities)

            if success and detectedData then
                local displayItems: { DisplayItem } = {}

                for _, entity in ipairs(detectedData) do
                    local formattedSub = string.format("Giá trị: %s | Độ hiếm: %s", 
                        tostring(entity.NumericValue), 
                        entity.RarityText
                    )

                    table.insert(displayItems, {
                        Title = entity.ModelName,
                        SubText = formattedSub,
                        ButtonText = "Vào ngay",
                        OnClicked = function()
                            print(string.format("[Inspect] Đã tương tác với đối tượng: %s", entity.ModelName))
                        end
                    })
                end

                updateUIList(displayItems)
            else
                warn("[Inspector] Lỗi trong quá trình quét đối tượng:", detectedData)
            end

            task.wait(REFRESH_RATE)
        end
    end)
end

-- Khởi động hệ thống
InitializeDynamicInspector()
