-- ==============================================================================
--  RONNEI HUB - LUXURY UI FRAMEWORK WITH LANGUAGE TOGGLE (VI/EN)
--  Theme: Luxury Obsidian & Cyber Mint
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

-- Dọn dẹp phiên bản cũ nếu đang chạy
if CoreGui:FindFirstChild("RonneiHub_NewMaster") then
    CoreGui.RonneiHub_NewMaster:Destroy()
end

-- ==================== CẤU HÌNH NHÃN HIỆU & ĐA NGÔN NGỮ ====================
local BRAND = {
    Name       = "Ronnei Hub",
    SubTitle   = "v2.0 • Premium Edition",
    Avatar     = "rbxassetid://125111940452696",
    TikTokTag  = "TikTok: ronnei7.htk"
}

-- Từ điển dịch thuật (English <-> Tiếng Việt)
local TRANSLATIONS = {
    ["Overview"]  = "Tổng quan",
    ["Steal"]     = "Trộm cắp",
    ["Egg Panel"] = "Bảng Trứng",
    ["Inventory"] = "Túi đồ",
    ["Eggs"]      = "Trứng",
    ["Rewards"]   = "Phần thưởng",
    ["Visuals"]   = "Giao diện",
    ["Webhook"]   = "Webhook",
    ["Settings"]  = "Cài đặt",
    ["Auto Steal"]= "Tự động trộm",
    ["Speed"]     = "Tốc độ",
    ["Language"]  = "Ngôn ngữ: Tiếng Việt"
}

local CurrentLanguage = "EN" -- Mặc định OFF (English), ON là VI

local THEME = {
    WindowBG    = Color3.fromRGB(14, 16, 22),       -- Nền Obsidian tối sâu
    SidebarBG   = Color3.fromRGB(10, 12, 16),       -- Nền Sidebar kính mờ
    CardBG      = Color3.fromRGB(22, 26, 36),       -- Nền thẻ tính năng
    CardHover   = Color3.fromRGB(30, 36, 50),       -- Hiệu ứng hover
    Border      = Color3.fromRGB(45, 55, 75),       -- Viền kim loại mảnh
    AccentMint  = Color3.fromRGB(0, 230, 120),      -- Xanh ngọc lục bảo (Cyber Mint)
    ToggleOff   = Color3.fromRGB(35, 40, 52),       -- Nút tắt
    TextMain    = Color3.fromRGB(245, 248, 255),    -- Chữ chính
    TextSub     = Color3.fromRGB(150, 160, 180),    -- Chữ phụ
    FontM       = Enum.Font.GothamMedium,
    FontB       = Enum.Font.GothamBold
}

-- Hàm kéo thả (Draggable)
local function makeDraggable(topbar, object)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== SCREEN GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RonneiHub_NewMaster"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- 1. NÚT AVATAR TRÒN MỞ MENU
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "RonneiAvatarToggle"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0, 150)
ToggleBtn.BackgroundColor3 = THEME.WindowBG
ToggleBtn.Image = BRAND.Avatar
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = THEME.AccentMint
ToggleStroke.Thickness = 2.2
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

makeDraggable(ToggleBtn, ToggleBtn)

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 390)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -195)
MainFrame.BackgroundColor3 = THEME.WindowBG
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = THEME.Border
MainStroke.Thickness = 1.4
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- 3. THANH HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = THEME.SidebarBG
Header.BorderSizePixel = 0
Header.Parent = MainFrame

makeDraggable(Header, MainFrame)

local HeaderLine = Instance.new("Frame", Header)
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.Position = UDim2.new(0, 0, 1, 0)
HeaderLine.BackgroundColor3 = THEME.Border
HeaderLine.BorderSizePixel = 0

-- Avatar Header
local HeaderAvatar = Instance.new("ImageLabel", Header)
HeaderAvatar.Size = UDim2.new(0, 32, 0, 32)
HeaderAvatar.Position = UDim2.new(0, 12, 0.5, 0)
HeaderAvatar.AnchorPoint = Vector2.new(0, 0.5)
HeaderAvatar.BackgroundTransparency = 1
HeaderAvatar.Image = BRAND.Avatar
Instance.new("UICorner", HeaderAvatar).CornerRadius = UDim.new(1, 0)

-- Tên Hub
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 130, 0, 18)
Title.Position = UDim2.new(0, 52, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = BRAND.Name
Title.Font = THEME.FontB
Title.TextSize = 15
Title.TextColor3 = THEME.AccentMint
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel", Header)
SubTitle.Size = UDim2.new(0, 130, 0, 14)
SubTitle.Position = UDim2.new(0, 52, 0, 26)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = BRAND.SubTitle
SubTitle.Font = THEME.FontM
SubTitle.TextSize = 10
SubTitle.TextColor3 = THEME.TextSub
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Huy hiệu TikTok phát sáng
local TikTokBadge = Instance.new("Frame", Header)
TikTokBadge.Name = "TikTokBadge"
TikTokBadge.Size = UDim2.new(0, 150, 0, 24)
TikTokBadge.Position = UDim2.new(0.50, 0, 0.5, 0)
TikTokBadge.AnchorPoint = Vector2.new(0.5, 0.5)
TikTokBadge.BackgroundColor3 = THEME.CardBG
TikTokBadge.BorderSizePixel = 0
Instance.new("UICorner", TikTokBadge).CornerRadius = UDim.new(1, 0)

local BadgeStroke = Instance.new("UIStroke", TikTokBadge)
BadgeStroke.Color = THEME.AccentMint
BadgeStroke.Thickness = 1.4
BadgeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local BadgeStrokeGrad = Instance.new("UIGradient", BadgeStroke)
BadgeStrokeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 230, 120))
})

local TikTokLabel = Instance.new("TextLabel", TikTokBadge)
TikTokLabel.Size = UDim2.new(1, 0, 1, 0)
TikTokLabel.BackgroundTransparency = 1
TikTokLabel.Text = BRAND.TikTokTag
TikTokLabel.Font = THEME.FontB
TikTokLabel.TextSize = 11
TikTokLabel.TextColor3 = THEME.TextMain

local TextGrad = Instance.new("UIGradient", TikTokLabel)
TextGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 255, 210)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})

task.spawn(function()
    local rot = 0
    while TikTokBadge.Parent do
        rot = (rot + 3) % 360
        BadgeStrokeGrad.Rotation = rot
        TextGrad.Rotation = rot
        task.wait(0.03)
    end
end)

-- FPS & Ping
local StatBadge = Instance.new("TextLabel", Header)
StatBadge.Size = UDim2.new(0, 95, 0, 22)
StatBadge.Position = UDim2.new(1, -70, 0.5, 0)
StatBadge.AnchorPoint = Vector2.new(1, 0.5)
StatBadge.BackgroundColor3 = THEME.CardBG
StatBadge.Font = THEME.FontM
StatBadge.TextSize = 11
StatBadge.TextColor3 = THEME.TextSub
StatBadge.Text = "60 FPS | 40ms"
Instance.new("UICorner", StatBadge).CornerRadius = UDim.new(0, 6)

task.spawn(function()
    local lastUpdate = tick()
    local frames = 0
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastUpdate >= 1 then
            local fps = frames
            frames = 0
            lastUpdate = tick()
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            StatBadge.Text = string.format("%d FPS | %dms", fps, ping)
        end
    end)
end)

-- Nút đóng
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -34, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(0, 0.5)
CloseBtn.BackgroundColor3 = THEME.CardBG
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = THEME.TextSub
CloseBtn.Font = THEME.FontB
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==================== 4. SIDEBAR & THANH GHIM NGÔN NGỮ (ON/OFF) ====================
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -48)
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.BackgroundColor3 = THEME.SidebarBG
Sidebar.BorderSizePixel = 0

local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = THEME.Border
SidebarLine.BorderSizePixel = 0

local TabListLayout = Instance.new("UIListLayout", Sidebar)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

local TabPadding = Instance.new("UIPadding", Sidebar)
TabPadding.PaddingTop = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 8)
TabPadding.PaddingRight = UDim.new(0, 8)

-- Dòng ghim ngôn ngữ (Language Toggle Row) nằm ở đỉnh Sidebar
local LangContainer = Instance.new("Frame", Sidebar)
LangContainer.Name = "LangContainer"
LangContainer.Size = UDim2.new(1, 0, 0, 36)
LangContainer.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", LangContainer).CornerRadius = UDim.new(0, 6)

local LangStroke = Instance.new("UIStroke", LangContainer)
LangStroke.Color = THEME.AccentMint
LangStroke.Thickness = 1

local LangLabel = Instance.new("TextLabel", LangContainer)
LangLabel.Size = UDim2.new(1, -46, 1, 0)
LangLabel.Position = UDim2.new(0, 8, 0, 0)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = "Tiếng Việt"
LangLabel.Font = THEME.FontB
LangLabel.TextSize = 11
LangLabel.TextColor3 = THEME.AccentMint
LangLabel.TextXAlignment = Enum.TextXAlignment.Left

local LangSwitch = Instance.new("TextButton", LangContainer)
LangSwitch.Size = UDim2.new(0, 32, 0, 18)
LangSwitch.Position = UDim2.new(1, -38, 0.5, 0)
LangSwitch.AnchorPoint = Vector2.new(0, 0.5)
LangSwitch.BackgroundColor3 = THEME.AccentMint
LangSwitch.Text = ""
LangSwitch.AutoButtonColor = false
Instance.new("UICorner", LangSwitch).CornerRadius = UDim.new(1, 0)

local LangKnob = Instance.new("Frame", LangSwitch)
LangKnob.Size = UDim2.new(0, 14, 0, 14)
LangKnob.Position = UDim2.new(1, -16, 0.5, 0)
LangKnob.AnchorPoint = Vector2.new(0, 0.5)
LangKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LangKnob.BorderSizePixel = 0
Instance.new("UICorner", LangKnob).CornerRadius = UDim.new(1, 0)

-- ==================== 5. KHUNG NỘI DUNG CHÍNH (PAGES) ====================
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -48)
ContentArea.Position = UDim2.new(0, 150, 0, 48)
ContentArea.BackgroundTransparency = 1

local AllTabs = {}
local AllLocalizedTexts = {} -- Lưu trữ để cập nhật ngôn ngữ live

local function CreateTab(nameEN)
    local Page = Instance.new("ScrollingFrame", ContentArea)
    Page.Name = nameEN .. "_Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = THEME.AccentMint
    Page.BorderSizePixel = 0
    Page.Visible = false

    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)

    local PagePad = Instance.new("UIPadding", Page)
    PagePad.PaddingTop = UDim.new(0, 12)
    PagePad.PaddingLeft = UDim.new(0, 14)
    PagePad.PaddingRight = UDim.new(0, 14)
    PagePad.PaddingBottom = UDim.new(0, 12)

    -- Nút bấm trên Sidebar
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Name = nameEN .. "_TabBtn"
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = THEME.CardBG
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = "     " .. nameEN
    TabBtn.Font = THEME.FontM
    TabBtn.TextSize = 12
    TabBtn.TextColor3 = THEME.TextSub
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    table.insert(AllLocalizedTexts, {Obj = TabBtn, Key = nameEN, Type = "Tab", EN = nameEN})

    local function Activate()
        for _, t in pairs(AllTabs) do
            t.Page.Visible = false
            TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = THEME.TextSub}):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextColor3 = THEME.AccentMint, BackgroundColor3 = THEME.CardBG}):Play()
    end

    TabBtn.MouseButton1Click:Connect(Activate)
    table.insert(AllTabs, {Page = Page, Btn = TabBtn, EN = nameEN})

    if #AllTabs == 1 then
        Activate()
    end

    local Elements = {}

    function Elements:AddSection(sectionText)
        local Sec = Instance.new("TextLabel", Page)
        Sec.Size = UDim2.new(1, 0, 0, 22)
        Sec.BackgroundTransparency = 1
        Sec.Text = sectionText:upper()
        Sec.Font = THEME.FontB
        Sec.TextSize = 11
        Sec.TextColor3 = THEME.AccentMint
        Sec.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(AllLocalizedTexts, {Obj = Sec, Key = sectionText, Type = "Upper", EN = sectionText})
    end

    function Elements:AddToggle(titleText, defaultState, callback)
        local state = defaultState or false
        local Card = Instance.new("Frame", Page)
        Card.Size = UDim2.new(1, 0, 0, 40)
        Card.BackgroundColor3 = THEME.CardBG
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
        local CardStroke = Instance.new("UIStroke", Card)
        CardStroke.Color = THEME.Border
        CardStroke.Thickness = 1

        local Label = Instance.new("TextLabel", Card)
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = titleText
        Label.Font = THEME.FontM
        Label.TextSize = 12
        Label.TextColor3 = THEME.TextMain
        Label.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(AllLocalizedTexts, {Obj = Label, Key = titleText, Type = "Normal", EN = titleText})

        local Switch = Instance.new("TextButton", Card)
        Switch.Size = UDim2.new(0, 42, 0, 20)
        Switch.Position = UDim2.new(1, -52, 0.5, 0)
        Switch.AnchorPoint = Vector2.new(0, 0.5)
        Switch.BackgroundColor3 = state and THEME.AccentMint or THEME.ToggleOff
        Switch.Text = ""
        Switch.AutoButtonColor = false
        Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

        local Knob = Instance.new("Frame", Switch)
        Knob.Size = UDim2.new(0, 14, 0, 14)
        Knob.Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        Knob.AnchorPoint = Vector2.new(0, 0.5)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.BorderSizePixel = 0
        Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

        Switch.MouseButton1Click:Connect(function()
            state = not state
            TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = state and THEME.AccentMint or THEME.ToggleOff}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
            if callback then callback(state) end
        end)
    end

    return Elements
end

-- ==================== HỆ THỐNG CHUYỂN ĐỔI NGÔN NGỮ (ON/OFF) ====================
local function UpdateLanguage()
    if CurrentLanguage == "VI" then
        LangLabel.Text = "Tiếng Việt (ON)"
        TweenService:Create(LangSwitch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(LangKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, 0)}):Play()
    else
        LangLabel.Text = "English (OFF)"
        TweenService:Create(LangSwitch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(LangKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
    end

    -- Cập nhật chữ trên toàn giao diện
    for _, item in ipairs(AllLocalizedTexts) do
        local translated = TRANSLATIONS[item.EN] or item.EN
        if CurrentLanguage == "VI" then
            if item.Type == "Tab" then
                item.Obj.Text = "     " .. translated
            elseif item.Type == "Upper" then
                item.Obj.Text = translated:upper()
            else
                item.Obj.Text = translated
            end
        else
            if item.Type == "Tab" then
                item.Obj.Text = "     " .. item.EN
            elseif item.Type == "Upper" then
                item.Obj.Text = item.EN:upper()
            else
                item.Obj.Text = item.EN
            end
        end
    end
end

LangSwitch.MouseButton1Click:Connect(function()
    CurrentLanguage = (CurrentLanguage == "EN") and "VI" or "EN"
    UpdateLanguage()
end)

LangContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        CurrentLanguage = (CurrentLanguage == "EN") and "VI" or "EN"
        UpdateLanguage()
    end
end)

-- ==================== TẠO CÁC TAB MẪU ====================
local Tab1 = CreateTab("Overview")
Tab1:AddSection("Auto Steal")
Tab1:AddToggle("Auto Steal", false, function(val) end)

local Tab2 = CreateTab("Steal")
Tab2:AddSection("Settings")
Tab2:AddToggle("Speed", true, function(val) end)

local Tab3 = CreateTab("Egg Panel")
local Tab4 = CreateTab("Inventory")
local Tab5 = CreateTab("Eggs")
local Tab6 = CreateTab("Rewards")
local Tab7 = CreateTab("Visuals")
local Tab8 = CreateTab("Webhook")
local Tab9 = CreateTab("Settings")

-- Khởi chạy trạng thái mặc định (EN)
UpdateLanguage()
