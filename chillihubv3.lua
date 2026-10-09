-- ==============================================================================
--  DYNAMIC ISLAND PRO (RAINBOW RGB & EXPANDABLE SUITE)
--  Kiến trúc tối ưu:
--    1. ZERO GC RGB RAINBOW: Xoay UIGradient.Rotation O(1), không cấp phát RAM rác.
--    2. DYNAMIC SPRING MOTION: Co giãn từ Pill (110x32) -> Island (260x88) chuẩn Apple.
--    3. MODULAR CONTAINER: Sẵn khung UIListLayout để anh nhét thêm nút sau này.
--    4. DUAL-SEGMENT LANG TOGGLE: Tích hợp sẵn nút VIE / ENG đàn hồi cực mượt.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Hủy UI cũ nếu đang chạy
local old = CoreGui:FindFirstChild("Dynamic_Island_Suite")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dynamic_Island_Suite"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = CoreGui

-- ==================== 1. KHỞI TẠO KHUNG DYNAMIC ISLAND ====================
-- Trạng thái kích thước
local SIZE_COLLAPSED = UDim2.new(0, 115, 0, 32)
local SIZE_EXPANDED  = UDim2.new(0, 260, 0, 88)

local Island = Instance.new("CanvasGroup")
Island.Name = "Island"
Island.Size = SIZE_COLLAPSED
Island.AnchorPoint = Vector2.new(0.5, 0)
Island.Position = UDim2.new(0.5, 0, 0, 12)
Island.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Island.BackgroundTransparency = 0.05
Island.GroupTransparency = 0
Island.Parent = ScreenGui

local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(0, 16)
IslandCorner.Parent = Island

-- ==================== 2. HIỆU ỨNG VIỀN CẦU VỒNG (RAINBOW RGB) ====================
local IslandStroke = Instance.new("UIStroke")
IslandStroke.Thickness = 1.8
IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
IslandStroke.Parent = Island

local RainbowGradient = Instance.new("UIGradient")
RainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 140, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 230, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 120)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})
RainbowGradient.Rotation = 0
RainbowGradient.Parent = IslandStroke

-- Luồng xoay viền cầu vồng siêu nhẹ O(1) - Không leak RAM
local RAINBOW_SPEED = 90 -- Độ/giây
RunService.RenderStepped:Connect(function(dt)
    RainbowGradient.Rotation = (RainbowGradient.Rotation + dt * RAINBOW_SPEED) % 360
end)

-- ==================== 3. GIAO DIỆN KHI THU GỌN (COLLAPSED) ====================
local CollapsedView = Instance.new("Frame")
CollapsedView.Name = "CollapsedView"
CollapsedView.Size = UDim2.new(1, 0, 1, 0)
CollapsedView.BackgroundTransparency = 1
CollapsedView.Parent = Island

local MoonIcon = Instance.new("TextLabel")
MoonIcon.Size = UDim2.new(0, 24, 1, 0)
MoonIcon.Position = UDim2.new(0, 8, 0, 0)
MoonIcon.BackgroundTransparency = 1
MoonIcon.Text = "🌙"
MoonIcon.TextSize = 14
MoonIcon.Parent = CollapsedView

local MiniTitle = Instance.new("TextLabel")
MiniTitle.Size = UDim2.new(1, -38, 1, 0)
MiniTitle.Position = UDim2.new(0, 32, 0, 0)
MiniTitle.BackgroundTransparency = 1
MiniTitle.Text = "Chilli Hub"
MiniTitle.Font = Enum.Font.GothamBold
MiniTitle.TextSize = 11
MiniTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniTitle.TextXAlignment = Enum.TextXAlignment.Left
MiniTitle.Parent = CollapsedView

-- ==================== 4. GIAO DIỆN KHI BUNG RỘNG (EXPANDED) ====================
local ExpandedView = Instance.new("Frame")
ExpandedView.Name = "ExpandedView"
ExpandedView.Size = UDim2.new(1, 0, 1, 0)
ExpandedView.BackgroundTransparency = 1
ExpandedView.Visible = false
ExpandedView.Parent = Island

-- Thanh Header thu nhỏ bên trong
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, -20, 0, 24)
Header.Position = UDim2.new(0, 10, 0, 8)
Header.BackgroundTransparency = 1
Header.Parent = ExpandedView

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 120, 1, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Chilli Hub V2"
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 12
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local HeaderStatus = Instance.new("TextLabel")
HeaderStatus.Size = UDim2.new(1, -125, 1, 0)
HeaderStatus.Position = UDim2.new(0, 125, 0, 0)
HeaderStatus.BackgroundTransparency = 1
HeaderStatus.Text = "● Đang chạy"
HeaderStatus.Font = Enum.Font.GothamMedium
HeaderStatus.TextSize = 10
HeaderStatus.TextColor3 = Color3.fromRGB(0, 255, 140)
HeaderStatus.TextXAlignment = Enum.TextXAlignment.Right
HeaderStatus.Parent = Header

-- KHUNG CHỨA TÍNH NĂNG (MODULAR CONTAINER DỄ DÀNG THÊM NÚT)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -20, 0, 42)
ContentContainer.Position = UDim2.new(0, 10, 0, 36)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = ExpandedView

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.FillDirection = Enum.FillDirection.Horizontal
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ContentContainer

-- ==================== 5. NÚT ĐỔI NGÔN NGỮ CYBER DUAL-SEGMENT ====================
local LangCapsule = Instance.new("Frame")
LangCapsule.Name = "LangCapsule"
LangCapsule.Size = UDim2.new(0, 150, 0, 30)
LangCapsule.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
LangCapsule.BackgroundTransparency = 0.2
LangCapsule.BorderSizePixel = 0
LangCapsule.Parent = ContentContainer

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(1, 0)
LangCorner.Parent = LangCapsule

local LangStroke = Instance.new("UIStroke")
LangStroke.Thickness = 1
LangStroke.Color = Color3.fromRGB(50, 80, 120)
LangStroke.Parent = LangCapsule

-- Con trượt Active Indicator
local LangSlider = Instance.new("Frame")
LangSlider.Size = UDim2.new(0, 71, 0, 24)
LangSlider.Position = UDim2.new(0, 3, 0.5, -12) -- Vị trí VIE
LangSlider.BackgroundColor3 = Color3.fromRGB(30, 115, 235) -- Xanh Sapphire dịu
LangSlider.BorderSizePixel = 0
LangSlider.Parent = LangCapsule

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = LangSlider

local TabVI = Instance.new("TextButton")
TabVI.Size = UDim2.new(0, 71, 1, 0)
TabVI.Position = UDim2.new(0, 3, 0, 0)
TabVI.BackgroundTransparency = 1
TabVI.Text = "🇻🇳 VIE"
TabVI.Font = Enum.Font.GothamBold
TabVI.TextSize = 10
TabVI.TextColor3 = Color3.fromRGB(255, 255, 255)
TabVI.ZIndex = 5
TabVI.Parent = LangCapsule

local TabEN = Instance.new("TextButton")
TabEN.Size = UDim2.new(0, 71, 1, 0)
TabEN.Position = UDim2.new(1, -74, 0, 0)
TabEN.BackgroundTransparency = 1
TabEN.Text = "🌐 ENG"
TabEN.Font = Enum.Font.GothamBold
TabEN.TextSize = 10
TabEN.TextColor3 = Color3.fromRGB(140, 155, 180)
TabEN.ZIndex = 5
TabEN.Parent = LangCapsule

-- Logic đổi ngôn ngữ
local currentLang = "VI"
local function setLanguage(lang)
    if currentLang == lang then return end
    currentLang = lang

    if lang == "VI" then
        TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, -12),
            BackgroundColor3 = Color3.fromRGB(30, 115, 235)
        }):Play()
        TweenService:Create(TabVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(TabEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 155, 180)}):Play()
        HeaderTitle.Text = "Chilli Hub V2"
        HeaderStatus.Text = "● Đang chạy"
    else
        TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -74, 0.5, -12),
            BackgroundColor3 = Color3.fromRGB(50, 65, 90)
        }):Play()
        TweenService:Create(TabEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(TabVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 155, 180)}):Play()
        HeaderTitle.Text = "Chilli Hub V2"
        HeaderStatus.Text = "● Running"
    end

    -- Hook biến toàn cục để engine dịch bắt sự kiện
    _G.Chilli_CurrentLanguage = lang
end

TabVI.MouseButton1Click:Connect(function() setLanguage("VI") end)
TabEN.MouseButton1Click:Connect(function() setLanguage("EN") end)

-- ==================== 6. LOGIC CO GIÃN ĐÀN HỒI (DYNAMIC ANIMATION) ====================
local isExpanded = false
local autoCollapseThread = nil

local function toggleIsland()
    isExpanded = not isExpanded

    -- Hủy timer tự đóng nếu bấm thủ công
    if autoCollapseThread then
        task.cancel(autoCollapseThread)
        autoCollapseThread = nil
    end

    if isExpanded then
        -- Chuyển trạng thái: Thu gọn -> Bung rộng
        CollapsedView.Visible = false
        ExpandedView.Visible = true

        TweenService:Create(Island, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = SIZE_EXPANDED
        }):Play()

        -- Tự động thu nhỏ lại sau 5 giây nếu không tương tác
        autoCollapseThread = task.delay(5, function()
            if isExpanded then
                toggleIsland()
            end
        end)
    else
        -- Chuyển trạng thái: Bung rộng -> Thu gọn
        ExpandedView.Visible = false
        CollapsedView.Visible = true

        TweenService:Create(Island, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = SIZE_COLLAPSED
        }):Play()
    end
end

-- Vùng cảm ứng tương tác
local Hitbox = Instance.new("TextButton")
Hitbox.Name = "Hitbox"
Hitbox.Size = UDim2.new(1, 0, 1, 0)
Hitbox.BackgroundTransparency = 1
Hitbox.Text = ""
Hitbox.Parent = Island

Hitbox.MouseButton1Click:Connect(function()
    toggleIsland()
end)

-- Chặn chạm nhầm vào các nút con bên trong làm kích hoạt Hitbox đóng đảo
LangCapsule.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        -- Reset lại timer 5s nếu người dùng đang chỉnh ngôn ngữ
        if autoCollapseThread then
            task.cancel(autoCollapseThread)
            autoCollapseThread = task.delay(5, function()
                if isExpanded then toggleIsland() end
            end)
        end
    end
end)

-- ==================== 7. HÀM MẪU ĐỂ ANH THÊM NÚT SAU NÀY ====================
-- Anh chỉ cần gọi hàm này: AddIslandButton("Tên nút", function() print("Click") end)
_G.AddIslandButton = function(btnText, callback)
    local ExtraBtn = Instance.new("TextButton")
    ExtraBtn.Size = UDim2.new(0, 80, 0, 30)
    ExtraBtn.BackgroundColor3 = Color3.fromRGB(24, 30, 45)
    ExtraBtn.Text = btnText
    ExtraBtn.Font = Enum.Font.GothamBold
    ExtraBtn.TextSize = 10
    ExtraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExtraBtn.Parent = ContentContainer

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = ExtraBtn

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Thickness = 1
    BtnStroke.Color = Color3.fromRGB(50, 80, 120)
    BtnStroke.Parent = ExtraBtn

    ExtraBtn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    -- Tự tăng bề rộng của Island để chứa vừa nút mới
    SIZE_EXPANDED = UDim2.new(0, SIZE_EXPANDED.X.Offset + 88, 0, SIZE_EXPANDED.Y.Offset)
    if isExpanded then
        Island.Size = SIZE_EXPANDED
    end
end
