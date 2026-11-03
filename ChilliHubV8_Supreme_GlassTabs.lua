--!strict
local function InitializeProfessionalDashboard()
    -- ==========================================
    -- 1. IMPORT CÁC DỊCH VỤ HỆ THỐNG
    -- ==========================================
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        warn("[Dashboard] Cần chạy trong môi trường Client (LocalScript).")
        return
    end

    local playerGui = localPlayer:WaitForChild("PlayerGui")

    -- ==========================================
    -- 2. HẰNG SỐ & BẢNG MÀU GIAO DIỆN (PALETTE)
    -- ==========================================
    local BG_MAIN = Color3.fromRGB(18, 20, 26)
    local BG_SECONDARY = Color3.fromRGB(25, 29, 38)
    local BG_CARD = Color3.fromRGB(30, 35, 47)
    local BORDER_COLOR = Color3.fromRGB(48, 55, 72)
    local ACCENT_GREEN = Color3.fromRGB(65, 220, 125)
    local ACCENT_RED = Color3.fromRGB(215, 55, 65)
    local ACCENT_BLUE = Color3.fromRGB(50, 125, 235)
    local TEXT_PRIMARY = Color3.fromRGB(245, 248, 255)
    local TEXT_MUTED = Color3.fromRGB(150, 160, 180)

    local VALUE_KEYWORDS = { "value", "money", "$/s", "multiplier", "rate", "income" }
    local WEIGHT_KEYWORDS = { "weight", "kg", "mass", "size" }
    local SCAN_INTERVAL = 3
    local POOL_SIZE = 8

    -- ==========================================
    -- 3. ĐỊNH NGHĨA KIỂU DỮ LIỆU
    -- ==========================================
    type ScannedEntity = {
        ModelName: string,
        ValueRate: number,
        Weight: number,
        IsAvailable: boolean,
    }

    type PooledRow = {
        Instance: Frame,
        Icon: ImageLabel,
        TitleLabel: TextLabel,
        ValueLabel: TextLabel,
        WeightLabel: TextLabel,
        StatusButton: TextButton,
        ActiveConnection: RBXScriptConnection?,
    }

    -- ==========================================
    -- 4. THUẬT TOÁN QUÉT DỮ LIỆU THỰC TẾ
    -- ==========================================
    local function matchesAny(str: string, list: { string }): boolean
        local lower = string.lower(str)
        for _, key in ipairs(list) do
            if string.find(lower, key, 1, true) then return true end
        end
        return false
    end

    local function ScanWorkspace(): { ScannedEntity }
        local list: { ScannedEntity } = {}
        local visited: { [Model]: boolean } = {}

        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") and not visited[descendant] then
                if descendant == localPlayer.Character then continue end

                local foundValue = 0
                local foundWeight = 0
                local isValidTarget = false

                for _, child in ipairs(descendant:GetChildren()) do
                    if child:IsA("NumberValue") or child:IsA("IntValue") then
                        if matchesAny(child.Name, VALUE_KEYWORDS) then
                            foundValue = math.max(foundValue, child.Value)
                            isValidTarget = true
                        elseif matchesAny(child.Name, WEIGHT_KEYWORDS) then
                            foundWeight = child.Value
                        end
                    end
                end

                if isValidTarget then
                    visited[descendant] = true
                    table.insert(list, {
                        ModelName = descendant.Name,
                        ValueRate = foundValue,
                        Weight = foundWeight > 0 and foundWeight or 1.0,
                        IsAvailable = true,
                    })
                end
            end
        end

        table.sort(list, function(a, b) return a.ValueRate > b.ValueRate end)
        return list
    end

    -- ==========================================
    -- 5. XÂY DỰNG GIAO DIỆN DASHBOARD CHUYÊN NGHIỆP
    -- ==========================================
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ProfessionalServerDashboard"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Main Container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 480, 0, 540)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -270)
    mainFrame.BackgroundColor3 = BG_MAIN
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = BORDER_COLOR
    mainStroke.Thickness = 1.5
    mainStroke.Parent = mainFrame

    -- HEADER: Title & Close Button
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 44)
    headerFrame.BackgroundColor3 = BG_SECONDARY
    headerFrame.BorderSizePixel = 0
    headerFrame.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = headerFrame

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0.7, 0, 1, 0)
    titleText.Position = UDim2.new(0, 14, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 14
    titleText.TextColor3 = TEXT_PRIMARY
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Text = "HỆ THỐNG THEO DÕI TÀI SẢN (LIVE)"
    titleText.Parent = headerFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -36, 0.5, -13)
    closeBtn.BackgroundColor3 = ACCENT_RED
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextSize = 12
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = headerFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.Activated:Connect(function()
        mainFrame.Visible = false
    end)

    -- SUB-HEADER: Reset Countdown & Manual Refresh
    local subHeader = Instance.new("Frame")
    subHeader.Name = "SubHeader"
    subHeader.Size = UDim2.new(1, -24, 0, 32)
    subHeader.Position = UDim2.new(0, 12, 0, 52)
    subHeader.BackgroundColor3 = BG_SECONDARY
    subHeader.BorderSizePixel = 0
    subHeader.Parent = mainFrame

    local subCorner = Instance.new("UICorner")
    subCorner.CornerRadius = UDim.new(0, 8)
    subCorner.Parent = subHeader

    local countdownLabel = Instance.new("TextLabel")
    countdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
    countdownLabel.Position = UDim2.new(0, 10, 0, 0)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.Font = Enum.Font.RobotoMono
    countdownLabel.TextSize = 12
    countdownLabel.TextColor3 = TEXT_MUTED
    countdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    countdownLabel.Text = "LÀM MỚI TRONG: 00:03"
    countdownLabel.Parent = subHeader

    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0, 80, 0.75, 0)
    refreshBtn.Position = UDim2.new(1, -86, 0.125, 0)
    refreshBtn.BackgroundColor3 = ACCENT_BLUE
    refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.Text = "REFRESH"
    refreshBtn.TextSize = 11
    refreshBtn.TextColor3 = Color3.new(1, 1, 1)
    refreshBtn.BorderSizePixel = 0
    refreshBtn.Parent = subHeader

    local refCorner = Instance.new("UICorner")
    refCorner.CornerRadius = UDim.new(0, 6)
    refCorner.Parent = refreshBtn

    -- SCROLLING FRAME (List Container)
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ItemsList"
    scrollFrame.Size = UDim2.new(1, -24, 0, 320)
    scrollFrame.Position = UDim2.new(0, 12, 0, 92)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = BORDER_COLOR
    scrollFrame.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame

    -- FOOTER: Điều hướng & Các nút tác vụ lớn
    local footerFrame = Instance.new("Frame")
    footerFrame.Name = "Footer"
    footerFrame.Size = UDim2.new(1, -24, 0, 105)
    footerFrame.Position = UDim2.new(0, 12, 1, -117)
    footerFrame.BackgroundTransparency = 1
    footerFrame.Parent = mainFrame

    -- Hàng nút lọc phụ (Sub-controls)
    local function createTabButton(text: string, xPos: number, width: number): TextButton
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, width, 0, 32)
        btn.Position = UDim2.new(0, xPos, 0, 0)
        btn.BackgroundColor3 = BG_SECONDARY
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextSize = 11
        btn.TextColor3 = TEXT_MUTED
        btn.BorderSizePixel = 0
        btn.Parent = footerFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn

        local stroke = Instance.new("UIStroke")
        stroke.Color = BORDER_COLOR
        stroke.Thickness = 1
        stroke.Parent = btn
        return btn
    end

    createTabButton("ALL ITEMS", 0, 140)
    createTabButton("MY SERVER", 150, 140)
    createTabButton("MIN VALUE", 300, 156)

    -- Nút bấm đỏ đô lớn "JOIN RANDOM SERVER"
    local actionBtn = Instance.new("TextButton")
    actionBtn.Name = "ActionButtonLarge"
    actionBtn.Size = UDim2.new(1, 0, 0, 48)
    actionBtn.Position = UDim2.new(0, 0, 0, 44)
    actionBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 35) -- Đỏ đô
    actionBtn.Font = Enum.Font.GothamBold
    actionBtn.Text = "JOIN RANDOM SERVER"
    actionBtn.TextSize = 13
    actionBtn.TextColor3 = Color3.new(1, 1, 1)
    actionBtn.BorderSizePixel = 0
    actionBtn.Parent = footerFrame

    local actionCorner = Instance.new("UICorner")
    actionCorner.CornerRadius = UDim.new(0, 8)
    actionCorner.Parent = actionBtn

    local actionStroke = Instance.new("UIStroke")
    actionStroke.Color = Color3.fromRGB(200, 50, 60)
    actionStroke.Thickness = 1.2
    actionStroke.Parent = actionBtn

    -- ==========================================
    -- 6. OBJECT POOLING CHO HÀNG DỮ LIỆU (ROWS)
    -- ==========================================
    local poolList: { PooledRow } = {}

    local function createTemplateRow(): PooledRow
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -6, 0, 56)
        row.BackgroundColor3 = BG_CARD
        row.BorderSizePixel = 0

        local rCorner = Instance.new("UICorner")
        rCorner.CornerRadius = UDim.new(0, 8)
        rCorner.Parent = row

        local rStroke = Instance.new("UIStroke")
        rStroke.Color = BORDER_COLOR
        rStroke.Thickness = 1
        rStroke.Parent = row

        -- Icon bên trái
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 40, 0, 40)
        icon.Position = UDim2.new(0, 8, 0.5, -20)
        icon.BackgroundColor3 = BG_SECONDARY
        icon.Image = "rbxassetid://10888371607" -- Asset Icon placeholder
        icon.BorderSizePixel = 0
        icon.Parent = row

        local iconCorner = Instance.new("UICorner")
        iconCorner.CornerRadius = UDim.new(0, 6)
        iconCorner.Parent = icon

        -- Tên vật phẩm
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(0.55, 0, 0, 20)
        title.Position = UDim2.new(0, 56, 0, 8)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 13
        title.TextColor3 = TEXT_PRIMARY
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextTruncate = Enum.TextTruncate.AtEnd
        title.Parent = row

        -- Value ($/s màu xanh lá)
        local valLabel = Instance.new("TextLabel")
        valLabel.Size = UDim2.new(0.3, 0, 0, 16)
        valLabel.Position = UDim2.new(0, 56, 0, 30)
        valLabel.BackgroundTransparency = 1
        valLabel.Font = Enum.Font.GothamBold
        valLabel.TextSize = 12
        valLabel.TextColor3 = ACCENT_GREEN
        valLabel.TextXAlignment = Enum.TextXAlignment.Left
        valLabel.Parent = row

        -- Weight (KG)
        local wtLabel = Instance.new("TextLabel")
        wtLabel.Size = UDim2.new(0.25, 0, 0, 16)
        wtLabel.Position = UDim2.new(0, 180, 0, 30)
        wtLabel.BackgroundTransparency = 1
        wtLabel.Font = Enum.Font.GothamMedium
        wtLabel.TextSize = 11
        wtLabel.TextColor3 = TEXT_MUTED
        wtLabel.TextXAlignment = Enum.TextXAlignment.Left
        wtLabel.Parent = row

        -- Nút trạng thái bên phải
        local statusBtn = Instance.new("TextButton")
        statusBtn.Size = UDim2.new(0, 84, 0, 30)
        statusBtn.Position = UDim2.new(1, -92, 0.5, -15)
        statusBtn.BackgroundColor3 = ACCENT_RED
        statusBtn.Font = Enum.Font.GothamBold
        statusBtn.Text = "TAKEN"
        statusBtn.TextSize = 11
        statusBtn.TextColor3 = Color3.new(1, 1, 1)
        statusBtn.BorderSizePixel = 0
        statusBtn.Parent = row

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = statusBtn

        row.Visible = false
        row.Parent = scrollFrame

        return {
            Instance = row,
            Icon = icon,
            TitleLabel = title,
            ValueLabel = valLabel,
            WeightLabel = wtLabel,
            StatusButton = statusBtn,
            ActiveConnection = nil,
        }
    end

    for _ = 1, POOL_SIZE do
        table.insert(poolList, createTemplateRow())
    end

    local function updateDashboardList(dataList: { ScannedEntity })
        local total = #dataList

        if total > #poolList then
            for _ = #poolList + 1, total do
                table.insert(poolList, createTemplateRow())
            end
        end

        for i, row in ipairs(poolList) do
            if row.ActiveConnection then
                row.ActiveConnection:Disconnect()
                row.ActiveConnection = nil
            end

            if i <= total then
                local data = dataList[i]
                row.TitleLabel.Text = data.ModelName
                row.ValueLabel.Text = string.format("+$%s/s", tostring(data.ValueRate))
                row.WeightLabel.Text = string.format("%.1f KG", data.Weight)

                row.StatusButton.Text = data.IsAvailable and "OPEN" or "FULL"
                row.StatusButton.BackgroundColor3 = data.IsAvailable and ACCENT_BLUE or ACCENT_RED

                row.ActiveConnection = row.StatusButton.Activated:Connect(function()
                    print(string.format("[Dashboard] Tương tác mục: %s", data.ModelName))
                end)

                row.Instance.Visible = true
            else
                row.Instance.Visible = false
            end
        end
    end

    -- ==========================================
    -- 7. TIẾN TRÌNH LÀM MỚI VÀ ĐẾM NGƯỢC
    -- ==========================================
    local function executeRefresh()
        local success, results = pcall(ScanWorkspace)
        if success and results then
            updateDashboardList(results)
        end
    end

    refreshBtn.Activated:Connect(executeRefresh)

    task.spawn(function()
        local timer = SCAN_INTERVAL
        while true do
            task.wait(1)
            timer -= 1
            countdownLabel.Text = string.format("LÀM MỚI TRONG: 00:%02d", math.max(0, timer))

            if timer <= 0 then
                timer = SCAN_INTERVAL
                executeRefresh()
            end
        end
    end)
end

-- Thực thi khởi tạo
InitializeProfessionalDashboard()
