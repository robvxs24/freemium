--!strict
local function InitializeSystem()
    -- ==========================================
    -- 1. IMPORT CÁC DỊCH VỤ CẦN THIẾT
    -- ==========================================
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        warn("[System] Không tìm thấy LocalPlayer. Script cần chạy ở Client.")
        return
    end

    local playerGui = localPlayer:WaitForChild("PlayerGui")

    -- ==========================================
    -- 2. HẰNG SỐ VÀ CẤU HÌNH (LOCAL CONSTANTS)
    -- ==========================================
    local GLASS_NORMAL_COLOR = Color3.fromRGB(255, 255, 255)
    local GLASS_HOVER_COLOR = Color3.fromRGB(200, 220, 255)
    local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local POOL_SIZE = 5
    local LOOP_INTERVAL = 5

    -- ==========================================
    -- 3. ĐỊNH NGHĨA KIỂU DỮ LIỆU (TYPES)
    -- ==========================================
    type ItemData = {
        Title: string,
        ButtonText: string?,
        OnClicked: (() -> ())?,
    }

    type PooledFrame = {
        Instance: Frame,
        TitleLabel: TextLabel,
        ActionButton: TextButton,
        ActiveConnection: RBXScriptConnection?,
    }

    -- ==========================================
    -- 4. LOGIC GIAO DIỆN & OBJECT POOLING
    -- ==========================================
    local poolList: { PooledFrame } = {}

    -- Tạo ScreenGui & ScrollingFrame
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EncapsulatedUIDisplay"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "Container"
    scrollFrame.Size = UDim2.new(0, 360, 0, 380)
    scrollFrame.Position = UDim2.new(0.5, -180, 0.5, -190)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    scrollFrame.BackgroundTransparency = 0.35
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.Parent = screenGui

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = scrollFrame

    -- Hàm khởi tạo 1 Frame với hiệu ứng Liquid Glass
    local function createTemplateFrame(): PooledFrame
        local card = Instance.new("Frame")
        card.Size = UDim2.new(0.92, 0, 0, 50)
        card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        card.BackgroundTransparency = 0.85
        card.BorderSizePixel = 0

        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 10)
        cardCorner.Parent = card

        local cardStroke = Instance.new("UIStroke")
        cardStroke.Thickness = 1.2
        cardStroke.Color = Color3.fromRGB(255, 255, 255)
        cardStroke.Transparency = 0.6
        cardStroke.Parent = card

        local label = Instance.new("TextLabel")
        label.Name = "TitleLabel"
        label.Size = UDim2.new(0.65, 0, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 14
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = ""
        label.Parent = card

        local button = Instance.new("TextButton")
        button.Name = "ActionButton"
        button.Size = UDim2.new(0.28, 0, 0.65, 0)
        button.Position = UDim2.new(0.69, 0, 0.175, 0)
        button.BackgroundColor3 = GLASS_NORMAL_COLOR
        button.BackgroundTransparency = 0.8
        button.Font = Enum.Font.GothamBold
        button.TextSize = 13
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.AutoButtonColor = false
        button.Parent = card

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = button

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Transparency = 0.4
        btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        btnStroke.Parent = button

        -- Hiệu ứng Hover
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

    -- Khởi tạo sẵn các item vào Pool
    for _ = 1, POOL_SIZE do
        table.insert(poolList, createTemplateFrame())
    end

    -- Hàm cập nhật dữ liệu UI
    local function updateUIList(dataList: { ItemData })
        local totalData = #dataList

        -- Mở rộng Pool nếu danh sách dữ liệu truyền vào lớn hơn dung lượng hiện tại
        if totalData > #poolList then
            for _ = #poolList + 1, totalData do
                table.insert(poolList, createTemplateFrame())
            end
        end

        for index, item in ipairs(poolList) do
            -- Dọn dẹp kết nối cũ để không bị nhân bản listener
            if item.ActiveConnection then
                item.ActiveConnection:Disconnect()
                item.ActiveConnection = nil
            end

            if index <= totalData then
                local data = dataList[index]
                item.TitleLabel.Text = data.Title
                item.ActionButton.Text = data.ButtonText or "Join"

                if data.OnClicked then
                    item.ActiveConnection = item.ActionButton.Activated:Connect(data.OnClicked)
                end

                item.Instance.Visible = true
            else
                item.Instance.Visible = false
            end
        end
    end

    -- ==========================================
    -- 5. LOGIC STATE MANAGEMENT & VÒNG LẶP
    -- ==========================================
    local isRunning = true
    local attemptCount = 0
    local mockDataItems: { ItemData } = {
        { Title = "Mục kiểm tra ban đầu", ButtonText = "Join", OnClicked = function() print("Click mục mặc định") end }
    }

    -- Cập nhật trạng thái hiển thị ban đầu
    updateUIList(mockDataItems)

    -- Hàm giả lập điều kiện
    local function checkSimulationCondition(): boolean
        attemptCount += 1
        -- Giả lập: Trả về true sau 3 lần kiểm tra
        return attemptCount >= 3
    end

    local function onCheckFailed(attempts: number)
        print(string.format("[System] Chưa đạt điều kiện (Lần %d). Đang thử lại...", attempts))
    end

    local function onCheckSuccess()
        print("[System] Điều kiện đạt! Đang làm mới dữ liệu...")
        table.insert(mockDataItems, {
            Title = string.format("Vật phẩm mới tìm thấy (#%d)", attemptCount),
            ButtonText = "Vào ngay",
            OnClicked = function()
                print("Đã xác nhận mở vật phẩm mới!")
            end
        })
        updateUIList(mockDataItems)
    end

    -- Khởi chạy vòng lặp bất đồng bộ bằng task.spawn
    task.spawn(function()
        print("[System] Bắt đầu tiến trình kiểm tra trạng thái ngầm...")

        while isRunning do
            task.wait(LOOP_INTERVAL)
            if not isRunning then break end

            local success, isConditionMet = pcall(checkSimulationCondition)

            if success and isConditionMet then
                isRunning = false
                onCheckSuccess()
                break
            else
                onCheckFailed(attemptCount)
                -- Delay ngắn an toàn chống nghẽn thread
                task.wait(0.5)
            end
        end
    end)
end

-- ==========================================
-- 6. TỰ ĐỘNG THỰC THI HÀM KHỞI CHẠY
-- ==========================================
InitializeSystem()
