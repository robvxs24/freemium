-- ==============================================================================
--  RONNEI HUB - 60 FPS SMOOTH & INSTANT MODE-SWITCH INGESTION (ZERO LAG)
--  Theme: Luxury Obsidian & Cyber Mint
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn sạch phiên bản cũ nếu đang chạy
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
    WindowBG    = Color3.fromRGB(14, 16, 22),       -- Nền chính Obsidian tối sâu
    SidebarBG   = Color3.fromRGB(10, 12, 16),       -- Nền Sidebar kính mờ
    CardBG      = Color3.fromRGB(22, 26, 36),       -- Nền thẻ tính năng
    Border      = Color3.fromRGB(45, 55, 75),       -- Viền kim loại mảnh
    AccentMint  = Color3.fromRGB(0, 230, 120),      -- Xanh ngọc lục bảo (Cyber Mint)
    AccentGlow  = Color3.fromRGB(100, 255, 180),    -- Phát sáng viền
    TextMain    = Color3.fromRGB(245, 248, 255),    -- Chữ chính
    TextSub     = Color3.fromRGB(150, 160, 180),    -- Chữ phụ
    FontM       = Enum.Font.GothamMedium,
    FontB       = Enum.Font.GothamBold
}

-- Hàm kéo thả giao diện mượt mà (Draggable)
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

-- 1. NÚT AVATAR TRÒN MỞ MENU NGOÀI MÀN HÌNH
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

makeDraggable(ToggleBtn, ToggleBtn)

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 630, 0, 360)
MainFrame.Position = UDim2.new(0.5, -315, 0.5, -180)
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

-- Avatar trên Header
local HeaderAvatar = Instance.new("ImageLabel", Header)
HeaderAvatar.Size = UDim2.new(0, 32, 0, 32)
HeaderAvatar.Position = UDim2.new(0, 12, 0.5, 0)
HeaderAvatar.AnchorPoint = Vector2.new(0, 0.5)
HeaderAvatar.BackgroundTransparency = 1
HeaderAvatar.Image = BRAND.Avatar
Instance.new("UICorner", HeaderAvatar).CornerRadius = UDim.new(1, 0)

-- Tiêu đề
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
TikTokBadge.ZIndex = 50
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
TikTokLabel.ZIndex = 51

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

-- FPS & Ping nhẹ nhàng (Tối ưu hóa phần cứng)
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

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- 4. SIDEBAR & VÙNG CHỨA NỘI DUNG
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
ContentArea.ClipsDescendants = true

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

-- ==================== 6. BỘ XỬ LÝ ẨN VĨNH VIỄN NÚT NINJA ====================
local function purgeNinjaButton(obj)
    if not obj or not obj:IsA("GuiObject") then return end
    obj.Visible = false
    obj.Position = UDim2.new(0, -9999, 0, -9999)
    obj.Size = UDim2.new(0, 0, 0, 0)
    
    if not obj:GetAttribute("Purged") then
        obj:SetAttribute("Purged", true)
        obj:GetPropertyChangedSignal("Visible"):Connect(function()
            if obj.Visible then obj.Visible = false end
        end)
        obj:GetPropertyChangedSignal("Position"):Connect(function()
            if obj.Position.X.Offset ~= -9999 then
                obj.Position = UDim2.new(0, -9999, 0, -9999)
            end
        end)
    end
end

-- ==================== 7. HÀM NHÚNG CHÍNH XÁC VÀ BẢO VỆ GIAO DIỆN ====================
local activeLennonWindow = nil

local function secureEmbed(window)
    if not window or not window:IsA("Frame") or window.Parent == ContentArea then return end
    activeLennonWindow = window

    -- Ẩn Topbar cũ của Lennon (Logo, Discord, Title)
    for _, ch in ipairs(window:GetChildren()) do
        if ch:IsA("GuiObject") then
            local isOldHeader = false
            for _, s in ipairs(ch:GetDescendants()) do
                if s:IsA("TextLabel") and (s.Text == "BEST EGG SYSTEM" or s.Text == "LENNON HUB") then
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

    -- Gỡ bỏ viền xanh lá cũ của Lennon
    local oldStroke = window:FindFirstChildOfClass("UIStroke")
    if oldStroke then oldStroke.Enabled = false end

    -- Gỡ bỏ ràng buộc kích thước
    for _, c in ipairs(window:GetDescendants()) do
        if c:IsA("UISizeConstraint") or c:IsA("UIAspectRatioConstraint") then
            c.Enabled = false
        end
    end

    -- Nhúng trực tiếp vào ContentArea
    window.Parent = ContentArea
    window.Draggable = false
    window.Active = false
    window.BackgroundTransparency = 1
    window.BorderSizePixel = 0
    window.Position = UDim2.new(0, 8, 0, 10)
    window.Size = UDim2.new(1, -16, 1, -20)
    window.Visible = MainFrame.Visible

    -- Định dạng thẻ con theo theme Obsidian
    for _, card in ipairs(window:GetChildren()) do
        if card:IsA("GuiObject") and card.Visible and card.Size.Y.Offset > 25 then
            card.BackgroundColor3 = THEME.CardBG
            local cardStroke = card:FindFirstChildOfClass("UIStroke")
            if cardStroke then
                cardStroke.Color = THEME.Border
                cardStroke.Thickness = 1
            end
        end
    end

    -- Khóa giữ chỗ chống văng khi đổi chế độ
    if not window:GetAttribute("EmbedLocked") then
        window:SetAttribute("EmbedLocked", true)
        window:GetPropertyChangedSignal("Parent"):Connect(function()
            if window.Parent ~= ContentArea then
                task.defer(function()
                    window.Parent = ContentArea
                    window.Position = UDim2.new(0, 8, 0, 10)
                    window.Size = UDim2.new(1, -16, 1, -20)
                end)
            end
        end)
    end
end

-- ==================== 8. BỘ ĐIỀU PHỐI ĐÓN ĐẦU (EVENT-DRIVEN ZERO LAG) ====================
MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    for _, child in ipairs(ContentArea:GetChildren()) do
        if child:IsA("GuiObject") then
            child.Visible = MainFrame.Visible
        end
    end
end)

local function hookLennonGui(gui)
    if not gui:IsA("ScreenGui") or gui == ScreenGui then return end

    local function inspect(desc)
        -- Kiểm tra nếu là cửa sổ chính Lennon Hub
        if desc:IsA("Frame") then
            local isMain = false
            for _, sub in ipairs(desc:GetDescendants()) do
                if sub:IsA("TextLabel") and (sub.Text == "BEST EGG SYSTEM" or sub.Text == "TELEGUIADO" or sub.Text == "TELEPORT") then
                    isMain = true
                    break
                end
            end

            if isMain then
                task.defer(secureEmbed, desc)
                return
            end
        end

        -- Nhận diện và loại bỏ nút Ninja trôi nổi
        if desc:IsA("GuiButton") or (desc:IsA("GuiObject") and desc.AbsoluteSize.X <= 90 and desc.AbsoluteSize.Y <= 90) then
            if desc.Parent == gui then
                purgeNinjaButton(desc)
            end
        end
    end

    -- Bắt các thành phần hiện tại
    for _, child in ipairs(gui:GetChildren()) do
        inspect(child)
    end

    -- Lắng nghe khi Lennon Hub tái tạo giao diện (khi bấm đổi chế độ ⇄)
    gui.ChildAdded:Connect(function(newChild)
        task.wait(0.05)
        inspect(newChild)
    end)
end

-- Giám sát các container chứa GUI
local function scanContainers()
    local containers = {CoreGui}
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        table.insert(containers, LocalPlayer.PlayerGui)
    end
    if gethui then table.insert(containers, gethui()) end

    for _, c in ipairs(containers) do
        for _, g in ipairs(c:GetChildren()) do
            hookLennonGui(g)
        end
        c.ChildAdded:Connect(function(newGui)
            task.wait(0.1)
            hookLennonGui(newGui)
        end)
    end
end

scanContainers()

-- Vòng lặp duy trì siêu nhẹ (Mỗi 0.8s, không tốn tài nguyên)
task.spawn(function()
    while true do
        task.wait(0.8)
        pcall(function()
            if activeLennonWindow and activeLennonWindow.Parent == ContentArea then
                activeLennonWindow.Visible = MainFrame.Visible
            end
        end)
    end
end)
