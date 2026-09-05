-- ==============================================================================
--  RONNEI HUB - UNIFIED LENNON EMBEDDER (ZERO DETACHMENT & FIXED BLACK SCREEN)
--  Theme: Luxury Obsidian & Cyber Mint
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn dẹp phiên bản cũ
if CoreGui:FindFirstChild("RonneiHub_Master") then
    CoreGui.RonneiHub_Master:Destroy()
end

-- ==================== CẤU HÌNH NHÃN HIỆU & THEME ====================
local BRAND = {
    Name       = "Ronnei Hub",
    SubTitle   = "v1.0 • Lennon Edition",
    Avatar     = "rbxassetid://125111940452696",
    TikTokTag  = "TikTok: ronnei7.htk"
}

local THEME = {
    WindowBG    = Color3.fromRGB(14, 16, 22),
    SidebarBG   = Color3.fromRGB(10, 12, 16),
    CardBG      = Color3.fromRGB(22, 26, 36),
    Border      = Color3.fromRGB(45, 55, 75),
    AccentMint  = Color3.fromRGB(0, 230, 120),
    AccentGlow  = Color3.fromRGB(100, 255, 180),
    TextMain    = Color3.fromRGB(245, 248, 255),
    TextSub     = Color3.fromRGB(150, 160, 180),
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

-- ==================== SCREEN GUI CHÍNH ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RonneiHub_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- ==================== 1. NÚT AVATAR TRÒN MỞ MENU ====================
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

-- ==================== 2. KHUNG MENU CHÍNH ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 410)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -205)
MainFrame.BackgroundColor3 = THEME.WindowBG
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = THEME.Border
MainStroke.Thickness = 1.4
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- ==================== 3. THANH HEADER ====================
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

local HeaderAvatar = Instance.new("ImageLabel", Header)
HeaderAvatar.Size = UDim2.new(0, 32, 0, 32)
HeaderAvatar.Position = UDim2.new(0, 12, 0.5, 0)
HeaderAvatar.AnchorPoint = Vector2.new(0, 0.5)
HeaderAvatar.BackgroundTransparency = 1
HeaderAvatar.Image = BRAND.Avatar
Instance.new("UICorner", HeaderAvatar).CornerRadius = UDim.new(1, 0)

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

-- Huy hiệu TikTok phát sáng cố định ở Header
local TikTokBadge = Instance.new("Frame", Header)
TikTokBadge.Name = "TikTokBadge"
TikTokBadge.Size = UDim2.new(0, 160, 0, 24)
TikTokBadge.Position = UDim2.new(0.53, 0, 0.5, 0)
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

-- Chỉ số FPS / Ping
local StatBadge = Instance.new("TextLabel", Header)
StatBadge.Size = UDim2.new(0, 100, 0, 22)
StatBadge.Position = UDim2.new(1, -75, 0.5, 0)
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

-- Nút đóng và Bật/Tắt Menu
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

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== 4. SIDEBAR & VÙNG NỘI DUNG ====================
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

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -48)
ContentArea.Position = UDim2.new(0, 150, 0, 48)
ContentArea.BackgroundTransparency = 1

-- Tab 1: Menu chức năng chính
local PageMain = Instance.new("Frame", ContentArea)
PageMain.Name = "Page_Main"
PageMain.Size = UDim2.new(1, 0, 1, 0)
PageMain.BackgroundTransparency = 1
PageMain.Visible = true

-- Tab 2: Top 4 & Best Egg
local PageRadar = Instance.new("Frame", ContentArea)
PageRadar.Name = "Page_Radar"
PageRadar.Size = UDim2.new(1, 0, 1, 0)
PageRadar.BackgroundTransparency = 1
PageRadar.Visible = false

-- Nút bấm Tab 1
local TabBtn1 = Instance.new("TextButton", Sidebar)
TabBtn1.Size = UDim2.new(1, -16, 0, 36)
TabBtn1.Position = UDim2.new(0, 8, 0, 12)
TabBtn1.BackgroundColor3 = THEME.CardBG
TabBtn1.Text = "  ⚡ Menu Tính Năng"
TabBtn1.Font = THEME.FontB
TabBtn1.TextSize = 12
TabBtn1.TextColor3 = THEME.AccentMint
TabBtn1.TextXAlignment = Enum.TextXAlignment.Left
TabBtn1.AutoButtonColor = false
Instance.new("UICorner", TabBtn1).CornerRadius = UDim.new(0, 6)

-- Nút bấm Tab 2
local TabBtn2 = Instance.new("TextButton", Sidebar)
TabBtn2.Size = UDim2.new(1, -16, 0, 36)
TabBtn2.Position = UDim2.new(0, 8, 0, 54)
TabBtn2.BackgroundColor3 = THEME.CardBG
TabBtn2.BackgroundTransparency = 1
TabBtn2.Text = "  🥚 Top 4 & Trứng"
TabBtn2.Font = THEME.FontM
TabBtn2.TextSize = 12
TabBtn2.TextColor3 = THEME.TextSub
TabBtn2.TextXAlignment = Enum.TextXAlignment.Left
TabBtn2.AutoButtonColor = false
Instance.new("UICorner", TabBtn2).CornerRadius = UDim.new(0, 6)

local function switchTab(tabIndex)
    if tabIndex == 1 then
        PageMain.Visible = true
        PageRadar.Visible = false
        TabBtn1.BackgroundTransparency = 0
        TabBtn1.TextColor3 = THEME.AccentMint
        TabBtn1.Font = THEME.FontB
        TabBtn2.BackgroundTransparency = 1
        TabBtn2.TextColor3 = THEME.TextSub
        TabBtn2.Font = THEME.FontM
    else
        PageMain.Visible = false
        PageRadar.Visible = true
        TabBtn2.BackgroundTransparency = 0
        TabBtn2.TextColor3 = THEME.AccentMint
        TabBtn2.Font = THEME.FontB
        TabBtn1.BackgroundTransparency = 1
        TabBtn1.TextColor3 = THEME.TextSub
        TabBtn1.Font = THEME.FontM
    end
end

TabBtn1.MouseButton1Click:Connect(function() switchTab(1) end)
TabBtn2.MouseButton1Click:Connect(function() switchTab(2) end)

-- ==================== 5. KHỞI CHẠY LENNON HUB ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhub/main/stealaegg.lua"))()
    end)
end)

-- ==================== 6. BỘ ĐIỀU PHỐI VÀ NHÚNG TỰ ĐỘNG ====================
local function simulateClick(btn)
    pcall(function()
        if firesignal then
            firesignal(btn.MouseButton1Click)
            firesignal(btn.Activated)
        end
    end)
    pcall(function()
        if getconnections then
            for _, c in ipairs(getconnections(btn.MouseButton1Click)) do c:Fire() end
            for _, c in ipairs(getconnections(btn.Activated)) do c:Fire() end
        end
    end)
end

task.spawn(function()
    local mainEmbedded = false
    local radarEmbedded = false
    local ninjaHandled = false

    while true do
        pcall(function()
            local searchList = {CoreGui}
            if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                table.insert(searchList, LocalPlayer.PlayerGui)
            end
            if gethui then table.insert(searchList, gethui()) end

            for _, container in ipairs(searchList) do
                for _, gui in ipairs(container:GetChildren()) do
                    if gui:IsA("ScreenGui") and gui ~= ScreenGui then
                        for _, desc in ipairs(gui:GetDescendants()) do
                            -- 6.1. Dọn sạch nút Reset GUIs trôi nổi
                            if desc:IsA("TextButton") or desc:IsA("TextLabel") then
                                local t = desc.Text:upper()
                                if t:find("RESET GUI") or (t == "≡" and desc.AbsoluteSize.X < 65) then
                                    local rootBtn = desc:FindFirstAncestorWhichIsA("GuiButton") or desc
                                    rootBtn.Visible = false
                                    rootBtn.Position = UDim2.new(50, 0, 50, 0)
                                end
                            end

                            -- 6.2. Kích hoạt nút Ninja để mở Menu rồi ẩn nó đi
                            if not ninjaHandled and (desc:IsA("ImageButton") or desc:IsA("ImageLabel")) then
                                local sz = desc.AbsoluteSize
                                if sz.X >= 24 and sz.X <= 75 and math.abs(sz.X - sz.Y) <= 12 then
                                    local p = desc:FindFirstAncestorWhichIsA("GuiButton") or (desc:IsA("GuiButton") and desc)
                                    if p and p.Parent and p.Parent:IsA("ScreenGui") then
                                        simulateClick(p)
                                        p.Visible = false
                                        p.Position = UDim2.new(50, 0, 50, 0)
                                        ninjaHandled = true
                                    end
                                end
                            end

                            -- 6.3. Bắt đúng Cửa sổ Menu chính của Lennon Hub đưa vào Tab 1
                            if not mainEmbedded and desc:IsA("Frame") and desc.Parent and desc.Parent:IsA("ScreenGui") then
                                local isMainMenu = false
                                -- Nhận diện cửa sổ có kích thước lớn và chứa nhiều chức năng
                                if desc.AbsoluteSize.X >= 260 and desc.AbsoluteSize.Y >= 180 then
                                    for _, sub in ipairs(desc:GetDescendants()) do
                                        if sub:IsA("TextLabel") or sub:IsA("TextButton") then
                                            local txt = sub.Text:upper()
                                            if txt:find("AUTO STEAL") or txt:find("TELEPORT") or txt:find("MAIN") or txt:find("LENNON") then
                                                isMainMenu = true
                                                break
                                            end
                                        end
                                    end
                                end

                                if isMainMenu then
                                    -- Gỡ bỏ các ràng buộc kích thước nếu có
                                    for _, child in ipairs(desc:GetChildren()) do
                                        if child:IsA("UISizeConstraint") or child:IsA("UIAspectRatioConstraint") then
                                            child:Destroy()
                                        end
                                    end

                                    desc.Parent = PageMain
                                    desc.Position = UDim2.new(0, 0, 0, 0)
                                    desc.Size = UDim2.new(1, 0, 1, 0)
                                    desc.BackgroundTransparency = 1
                                    desc.Draggable = false
                                    desc.Active = true
                                    desc.Visible = true

                                    local stroke = desc:FindFirstChildOfClass("UIStroke")
                                    if stroke then stroke.Color = THEME.Border end

                                    mainEmbedded = true
                                end
                            end

                            -- 6.4. Bắt khung Top 4 / Best Egg đưa vào Tab 2
                            if not radarEmbedded and desc:IsA("Frame") and desc.Parent and desc.Parent:IsA("ScreenGui") then
                                local isRadarBox = false
                                for _, sub in ipairs(desc:GetDescendants()) do
                                    if sub:IsA("TextLabel") and (sub.Text:find("TOP 4") or sub.Text:find("BEST EGG") or sub.Text:find("TELEPORT")) then
                                        isRadarBox = true
                                        break
                                    end
                                end

                                if isRadarBox and desc ~= PageMain:FindFirstChildOfClass("Frame") then
                                    desc.Parent = PageRadar
                                    desc.Position = UDim2.new(0.5, 0, 0.5, 0)
                                    desc.AnchorPoint = Vector2.new(0.5, 0.5)
                                    desc.Size = UDim2.new(0.95, 0, 0.9, 0)
                                    desc.Draggable = false
                                    desc.Active = true
                                    desc.Visible = true

                                    local stroke = desc:FindFirstChildOfClass("UIStroke")
                                    if stroke then stroke.Color = THEME.AccentMint end

                                    radarEmbedded = true
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)
