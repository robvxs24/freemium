-- ==============================================================================
--  RONNEI HUB - CLEAN LENNON EMBEDDER (ZERO EXECUTOR LEAK & PROPER INGEST)
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
    SubTitle   = "v1.0 • Steal An Egg",
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

-- Hàm kéo thả
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

-- 1. NÚT AVATAR TRÒN BẬT/TẮT MENU
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
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -180)
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

-- Huy hiệu TikTok phát sáng ở Header
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

-- FPS / Ping
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

-- Nút đóng và mở menu
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

-- 4. SIDEBAR & VÙNG NỘI DUNG CHỨA TÍNH NĂNG
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -48)
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.BackgroundColor3 = THEME.SidebarBG
Sidebar.BorderSizePixel = 0

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -140, 1, -48)
ContentArea.Position = UDim2.new(0, 140, 0, 48)
ContentArea.BackgroundTransparency = 1

local HostPage = Instance.new("ScrollingFrame", ContentArea)
HostPage.Name = "HostPage"
HostPage.Size = UDim2.new(1, 0, 1, 0)
HostPage.BackgroundTransparency = 1
HostPage.ScrollBarThickness = 3
HostPage.ScrollBarImageColor3 = THEME.AccentMint
HostPage.BorderSizePixel = 0

local PageLayout = Instance.new("UIListLayout", HostPage)
PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
PageLayout.Padding = UDim.new(0, 10)

local PagePad = Instance.new("UIPadding", HostPage)
PagePad.PaddingTop = UDim.new(0, 14)
PagePad.PaddingLeft = UDim.new(0, 14)
PagePad.PaddingRight = UDim.new(0, 14)
PagePad.PaddingBottom = UDim.new(0, 14)

-- Nút Tab Sidebar
local MainTabBtn = Instance.new("TextButton", Sidebar)
MainTabBtn.Size = UDim2.new(1, -16, 0, 36)
MainTabBtn.Position = UDim2.new(0, 8, 0, 12)
MainTabBtn.BackgroundColor3 = THEME.CardBG
MainTabBtn.Text = "  ⚡ Chức Năng"
MainTabBtn.Font = THEME.FontB
MainTabBtn.TextSize = 13
MainTabBtn.TextColor3 = THEME.AccentMint
MainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
MainTabBtn.AutoButtonColor = false
Instance.new("UICorner", MainTabBtn).CornerRadius = UDim.new(0, 6)

-- 5. KHỞI CHẠY LENNON HUB
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhub/main/stealaegg.lua"))()
    end)
end)

-- 6. BỘ BÓC TÁCH VÀ NHÚNG CHÍNH XÁC (KHÔNG BẮT NHẦM EXECUTOR)
task.spawn(function()
    local embedded = false

    while true do
        pcall(function()
            local searchList = {CoreGui}
            if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                table.insert(searchList, LocalPlayer.PlayerGui)
            end
            if gethui then table.insert(searchList, gethui()) end

            for _, container in ipairs(searchList) do
                for _, gui in ipairs(container:GetChildren()) do
                    -- CHỈ XÉT GUI NÀO CÓ CHỨA CHỮ "BEST EGG SYSTEM" CỦA LENNON HUB
                    if gui:IsA("ScreenGui") and gui ~= ScreenGui then
                        local isLennonGui = false
                        for _, d in ipairs(gui:GetDescendants()) do
                            if d:IsA("TextLabel") and d.Text == "BEST EGG SYSTEM" then
                                isLennonGui = true
                                break
                            end
                        end

                        if isLennonGui then
                            -- 6.1. Ẩn nút Ninja và Reset GUIs của Lennon
                            for _, d in ipairs(gui:GetDescendants()) do
                                if d:IsA("GuiObject") then
                                    local t = (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text:upper() or ""
                                    local n = d.Name:lower()
                                    if t:find("RESET GUI") or (t == "≡" and d.AbsoluteSize.X < 65) or n:find("logo") then
                                        d.Visible = false
                                        d.Position = UDim2.new(50, 0, 50, 0)
                                    end
                                end
                            end

                            -- 6.2. Dò tìm cửa sổ chính của Lennon Hub
                            local lennonWindow = nil
                            for _, d in ipairs(gui:GetDescendants()) do
                                if d:IsA("TextLabel") and d.Text == "LENNON HUB" then
                                    local parent = d.Parent
                                    while parent and parent ~= gui do
                                        if parent:IsA("Frame") and parent.AbsoluteSize.X >= 250 then
                                            lennonWindow = parent
                                            break
                                        end
                                        parent = parent.Parent
                                    end
                                end
                            end

                            -- 6.3. Bốc tách thẻ Best Egg và Teleguiado vào Ronnei Hub
                            if lennonWindow and not embedded then
                                for _, child in ipairs(lennonWindow:GetChildren()) do
                                    -- Bỏ qua thanh Topbar có chữ Lennon Hub và nút Discord
                                    local isHeader = false
                                    for _, sub in ipairs(child:GetDescendants()) do
                                        if sub:IsA("TextLabel") and (sub.Text == "LENNON HUB" or sub.Text == "BEST EGG SYSTEM") then
                                            isHeader = true
                                            break
                                        end
                                    end

                                    -- Nhúng các thẻ tính năng thật vào trang của Ronnei Hub
                                    if child:IsA("GuiObject") and not isHeader then
                                        child.Parent = HostPage
                                        child.Size = UDim2.new(1, 0, 0, child.AbsoluteSize.Y > 30 and child.AbsoluteSize.Y or 60)
                                        child.BackgroundColor3 = THEME.CardBG

                                        local stroke = child:FindFirstChildOfClass("UIStroke")
                                        if stroke then
                                            stroke.Color = THEME.Border
                                            stroke.Thickness = 1
                                        end
                                    end
                                end

                                -- Ẩn hoàn toàn khung nền xanh rỗng của Lennon Hub
                                lennonWindow.Visible = false
                                lennonWindow.Position = UDim2.new(50, 0, 50, 0)
                                embedded = true
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)
