--!strict
local function InitializeDataScannerSystem()
    -- ==========================================
    -- 1. IMPORT DỊCH VỤ HỆ THỐNG
    -- ==========================================
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        warn("[System] Cần khởi chạy script trong môi trường Client.")
        return
    end

    local playerGui = localPlayer:WaitForChild("PlayerGui")

    -- ==========================================
    -- 2. HẰNG SỐ & CẤU HÌNH
    -- ==========================================
    local MIN_THRESHOLD = 1_000_000 -- Mốc giá trị lọc: 1 Triệu
    local TARGET_CATEGORY = "Rare"
    local SCAN_INTERVAL = 3
    local POOL_SIZE = 5

    local GLASS_NORMAL_COLOR = Color3.fromRGB(255, 255, 255)
    local GLASS_HOVER_COLOR = Color3.fromRGB(200, 225, 255)
    local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- ==========================================
    -- 3. ĐỊNH NGHĨA KIỂU DỮ LIỆU
    -- ==========================================
    type ScannedResult = {
        Node: Instance,
        Name: string,
        NumericValue: number,
        Category: string,
    }

    type DisplayItem = {
        Title: string,
        ButtonText: string,
        OnClicked: () -> (),
    }

    type PooledFrame = {
        Instance: Frame,
        TitleLabel: TextLabel,
        ActionButton: TextButton,
        ActiveConnection: RBXScriptConnection?,
    }

    -- ==========================================
    -- 4. THUẬT TOÁN QUÉT VÀ LỌC DỮ LIỆU
    -- ==========================================
    --[[
        Hàm SearchNodes duyệt qua các đối tượng con của thư mục đích,
        kiểm tra sự tồn tại của NumberValue và StringValue để đối soát điều kiện.
    ]]
    local function SearchNodes(targetFolder: Instance): { ScannedResult }
        local matchedResults: { ScannedResult } = {}

        for _, child in ipairs(targetFolder:GetChildren()) do
            -- Tìm kiếm thuộc tính dữ liệu gắn kèm
            local numValObj = child:FindFirstChildOfClass("NumberValue")
            local strValObj = child:FindFirstChildOfClass("StringValue")

            local numericValue = numValObj and numValObj.Value or 0
            local categoryValue = strValObj and strValObj.Value or "Standard"

            -- Tiêu chí lọc: Vượt ngưỡng giá trị hoặc thuộc nhóm mong muốn
            local isHighValue = numericValue >= MIN_THRESHOLD
            local isTargetCategory = categoryValue == TARGET_CATEGORY

            if isHighValue or isTargetCategory then
                table.insert(matchedResults, {
                    Node = child,
                    Name = child.Name,
                    NumericValue = numericValue,
                    Category = categoryValue,
                })
            end
        end

        return matchedResults
    end

    -- ==========================================
    -- 5. GIAO DIỆN & OBJECT POOLING
    -- ==========================================
    local poolList: { PooledFrame } = {}

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DataScannerGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ResultContainer"
    scrollFrame.Size = UDim2.new(0, 380, 0, 400)
    scrollFrame.Position = UDim2.new(0.5, -190, 0.5, -200)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    scrollFrame.BackgroundTransparency = 0.3
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.Parent = screenGui

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = scrollFrame

    -- Tạo 1 Frame mẫu với Liquid Glassmorphism
    local function createTemplateFrame(): PooledFrame
        local card = Instance.new("Frame")
        card.Size = UDim2.new(0.94, 0, 0, 52)
        card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        card.BackgroundTransparency = 0.88
        card.BorderSizePixel = 0

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = card

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.2
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Transparency = 0.65
        stroke.Parent = card

        local label = Instance.new("TextLabel")
        label.Name = "TitleLabel"
        label.Size = UDim2.new(0.68, 0, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 13
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = ""
        label.Parent = card

        local button = Instance.new("TextButton")
        button.Name = "ActionButton"
        button.Size = UDim2.new(0.25, 0, 0.65, 0)
        button.Position = UDim2.new(0.72, 0, 0.175, 0)
        button.BackgroundColor3 = GLASS_NORMAL_COLOR
        button.BackgroundTransparency = 0.8
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.AutoButtonColor = false
        button.Parent = card

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = button

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Transparency = 0.5
        btnStroke.Parent = button

        -- Hiệu ứng Hover đổi màu
        local tweenIn = TweenService:Create(button, TWEEN_INFO, {
            BackgroundTransparency = 0.5,
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
            TitleLabel = label,
            ActionButton = button,
            ActiveConnection = nil,
        }
    end

    -- Khởi tạo Pool ban đầu
    for _ = 1, POOL_SIZE do
        table.insert(poolList, createTemplateFrame())
    end

    -- Cập nhật danh sách từ dữ liệu đầu vào
    local function updateUIList(dataList: { DisplayItem })
        local totalData = #dataList

        if totalData > #poolList then
            for _ = #poolList + 1, totalData do
                table.insert(poolList, createTemplateFrame())
            end
        end

        for index, pooledItem in ipairs(poolList) do
            if pooledItem.ActiveConnection then
                pooledItem.ActiveConnection:Disconnect()
                pooledItem.ActiveConnection = nil
            end

            if index <= totalData then
                local data = dataList[index]
                pooledItem.TitleLabel.Text = data.Title
                pooledItem.ActionButton.Text = data.ButtonText

                pooledItem.ActiveConnection = pooledItem.ActionButton.Activated:Connect(data.OnClicked)
                pooledItem.Instance.Visible = true
            else
                pooledItem.Instance.Visible = false
            end
        end
    end

    -- ==========================================
    -- 6. STATE LOOP & CALLBACK XỬ LÝ
    -- ==========================================
    local isScanning = true

    -- Hàm callback chuẩn bị sẵn để xử lý khi không có dữ liệu
    local function OnDataExhausted()
        print("[State] No data found, transitioning...")
    end

    -- Khởi chạy vòng lặp ngầm bằng task.spawn
    task.spawn(function()
        print("[System] Bắt đầu quét Workspace...")

        while isScanning do
            task.wait(SCAN_INTERVAL)
            if not isScanning then break end

            local foundNodes = SearchNodes(Workspace)

            if #foundNodes > 0 then
                isScanning = false
                print(string.format("[System] Tìm thấy %d đối tượng hợp lệ! Dừng quét.", #foundNodes))

                -- Chuyển đổi dữ liệu quét sang format hiển thị trên UI
                local displayData: { DisplayItem } = {}
                for _, result in ipairs(foundNodes) do
                    table.insert(displayData, {
                        Title = string.format("%s\nGiá trị: %d | [%s]", result.Name, result.NumericValue, result.Category),
                        ButtonText = "Vào ngay", -- Có thể linh hoạt đổi sang "Join"
                        OnClicked = function()
                            print(string.format("Đã chọn đối tượng: %s", result.Name))
                        end
                    })
                end

                updateUIList(displayData)
                break
            else
                OnDataExhausted()
            end
        end
    end)
end

-- Tự động chạy hệ thống
InitializeDataScannerSystem()
