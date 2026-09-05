-- ==============================================================================
--  RONNEI HUB - ZERO-LAG OVERLAY ARCHITECTURE (60 FPS & 100% PERSISTENT MODES)
--  Theme: Luxury Obsidian & Cyber Mint
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn dẹp bản cũ nếu đang chạy
if CoreGui:FindFirstChild("RonneiHub_Master") then
    CoreGui.RonneiHub_Master:Destroy()
end

-- ==================== CẤU HÌNH NHÃN HIỆU ====================
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

-- ==================== SCREEN GUI CHÍNH ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RonneiHub_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- 1. NÚT AVATAR TRÒN BẬT/TẮT MENU DUY NHẤT NGOÀI MÀN HÌNH
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "RonneiAvatarToggle"
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0, 20, 0, 150)
ToggleBtn.BackgroundColor3 = THEME.WindowBG
ToggleBtn.Image = BRAND.Avatar
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = THEME.AccentMint
ToggleStroke.Thickness = 2.4
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 630, 0, 360)
MainFrame.Position = UDim2.new(0.5, -315, 0.5, -180)
MainFrame.BackgroundColor3 = THEME.WindowBG
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = THEME.Border
MainStroke.Thickness = 1.4
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Hàm kéo thả giao diện
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

makeDraggable(ToggleBtn, ToggleBtn)

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
        task.wait(0.04)
    end
end)

-- FPS & Ping nhẹ (60 FPS)
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
    local lastTime = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastTime >= 1 then
            local fps = math.round(frameCount / (now - lastTime))
            frameCount = 0
            lastTime = now
            local ping = 40
            pcall(function()
                ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
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

-- 4. SIDEBAR & VÙNG NỘI DUNG
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

-- 5. KHỞI CHẠY LENNON HUB GỐC
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhub/main/stealaegg.lua"))()
    end)
end)

-- 6. BỘ ĐIỀU PHỐI GHÉP NỐI SONG HÀNH (OVERLAY ALIGNMENT - ZERO LAG & LIVE PET)
local trackedLennonWindows = {}

local function setupLennonWindow(window)
    if trackedLennonWindows[window] then return end
    trackedLennonWindows[window] = true

    window.Draggable = false
    window.Active = false
    window.BackgroundTransparency = 1
    window.BorderSizePixel = 0

    -- Xóa bỏ viền xanh lá cũ
    local oldStroke = window:FindFirstChildOfClass("UIStroke")
    if oldStroke then oldStroke.Enabled = false end

    -- Ẩn Topbar cũ của Lennon (Chữ Lennon Hub, logo tròn, Discord)
    for _, ch in ipairs(window:GetChildren()) do
        if ch:IsA("GuiObject") then
            local isOldHeader = false
            for _, s in ipairs(ch:GetDescendants()) do
                if s:IsA("TextLabel") and (s.Text:find("LENNON") or s.Text == "BEST EGG SYSTEM") then
                    isOldHeader = true
                    break
                end
            end
            if isOldHeader then
                ch.Visible = false
                ch.Size = UDim2.new(0, 0, 0, 0)
            end
        end
    end
end

-- Vòng lặp khóa tọa độ thời gian thực (Zero-lag RenderStepped)
RunService.RenderStepped:Connect(function()
    if not MainFrame.Visible then
        for win in pairs(trackedLennonWindows) do
            if win.Parent then win.Visible = false end
        end
        return
    end

    local pos = ContentArea.AbsolutePosition
    local size = ContentArea.AbsoluteSize

    for win in pairs(trackedLennonWindows) do
        if win.Parent then
            win.Visible = true
            win.Position = UDim2.new(0, pos.X + 8, 0, pos.Y + 10)
            win.Size = UDim2.new(0, size.X - 16, 0, size.Y - 20)
        end
    end
end)

-- Bật/tắt menu
local function toggleVisibility()
    MainFrame.Visible = not MainFrame.Visible
    for win in pairs(trackedLennonWindows) do
        if win.Parent then win.Visible = MainFrame.Visible end
    end
end

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    for win in pairs(trackedLennonWindows) do
        if win.Parent then win.Visible = false end
    end
end)

ToggleBtn.MouseButton1Click:Connect(toggleVisibility)

-- 7. GIÁM SÁT TỰ ĐỘNG: BẮT CỬA SỔ & ẨN NÚT NINJA (CHẠY 0.5s/LẦN SIÊU NHẸ)
task.spawn(function()
    while true do
        pcall(function()
            local searchList = {CoreGui}
            if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                table.insert(searchList, LocalPlayer.PlayerGui)
            end
            if gethui then table.insert(searchList, gethui()) end

            for _, cont in ipairs(searchList) do
                for _, scr in ipairs(cont:GetChildren()) do
                    if scr:IsA("ScreenGui") and scr ~= ScreenGui then
                        -- 7.1. Ẩn triệt để nút Ninja ngoài màn hình
                        for _, child in ipairs(scr:GetChildren()) do
                            if child:IsA("GuiObject") and child.AbsoluteSize.X <= 90 and child.AbsoluteSize.Y <= 90 then
                                child.Visible = false
                                child.Position = UDim2.new(0, -9999, 0, -9999)
                            end
                        end

                        -- 7.2. Nhận diện cửa sổ Lennon và nạp vào danh sách điều khiển
                        for _, d in ipairs(scr:GetDescendants()) do
                            if d:IsA("TextLabel") and d.Text == "BEST EGG SYSTEM" then
                                local cur = d
                                while cur and cur.Parent and cur.Parent ~= scr do
                                    cur = cur.Parent
                                end
                                if cur and cur:IsA("Frame") then
                                    setupLennonWindow(cur)
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)
