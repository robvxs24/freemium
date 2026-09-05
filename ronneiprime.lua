-- ==============================================================================
--  RONNEI HUB - 100% CLEAN EMBEDDED LENNON (NO LEAKS, NO NINJA LOGO, NO DETACH)
--  Theme: Luxury Obsidian & Cyber Mint
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn dẹp phiên bản cũ nếu đang chạy
if CoreGui:FindFirstChild("RonneiHub_Master") then
    CoreGui.RonneiHub_Master:Destroy()
end

-- ==================== CẤU HÌNH THƯƠNG HIỆU & THEME ====================
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

-- Hàm kéo thả giao diện mượt mà
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

makeDraggable(ToggleBtn, ToggleBtn)

-- 2. KHUNG MENU CHÍNH (ĐÃ MỞ RỘNG VỪA KHÍT TÍNH NĂNG)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 620, 0, 360)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -180)
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

-- Nút đóng và Bật/Tắt
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

-- 4. SIDEBAR & VÙNG CHỨA NỘI DUNG CHỐNG TRÀN VIỀN
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
ContentArea.ClipsDescendants = true -- Triệt tiêu 100% hiện tượng lòi ra ngoài

local MainTabBtn = Instance.new("TextButton", Sidebar)
MainTabBtn.Size = UDim2.new(1, -16, 0, 36)
MainTabBtn.Position = UDim2.new(0, 8, 0, 12)
MainTabBtn.BackgroundColor3 = THEME.CardBG
MainTabBtn.Text = "  ⚡ STEAL EGG FAST"
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

-- 6. BỘ ĐIỀU PHỐI: TIÊU DIỆT NÚT NINJA, KHÓA CHẶT MENU VÀ CHỐNG TRÀN
task.spawn(function()
    local embeddedFrame = nil

    -- Đồng bộ trạng thái đóng/mở của Lennon theo Ronnei Hub
    MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
        if embeddedFrame then
            embeddedFrame.Visible = MainFrame.Visible
        end
    end)

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
                        local isLennonGui = false

                        -- Nhận diện ScreenGui của Lennon bằng các nhãn đặc trưng
                        for _, d in ipairs(gui:GetDescendants()) do
                            if d:IsA("TextLabel") or d:IsA("TextButton") then
                                local clean = d.Text:upper():gsub("%s+", "")
                                if clean:find("BESTEGG") or clean:find("TELEGUIADO") or clean:find("TELEPORT") or clean:find("ONESHOT") then
                                    isLennonGui = true
                                    break
                                end
                            end
                        end

                        if isLennonGui then
                            -- 6.1. DÒ TÌM VÀ TIÊU DIỆT TOÀN BỘ NÚT NINJA & RESET GUIS
                            for _, child in ipairs(gui:GetChildren()) do
                                local isWindow = false
                                for _, sub in ipairs(child:GetDescendants()) do
                                    if sub:IsA("TextLabel") and (sub.Text:upper():find("BEST") or sub.Text:upper():find("TELE")) then
                                        isWindow = true
                                        break
                                    end
                                end

                                -- Bất kỳ đối tượng trôi nổi nào không phải là cửa sổ chức năng đều bị tiêu diệt
                                if not isWindow and child:IsA("GuiObject") then
                                    child.Visible = false
                                    child:Destroy()
                                end
                            end

                            -- Tiêu diệt thêm nếu nút Ninja nằm ẩn trong các container khác
                            for _, desc in ipairs(gui:GetDescendants()) do
                                if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) and desc.Name ~= "HeaderAvatar" then
                                    local sz = desc.AbsoluteSize
                                    if sz.X >= 20 and sz.X <= 80 and math.abs(sz.X - sz.Y) <= 15 then
                                        local p = desc:FindFirstAncestorWhichIsA("GuiButton") or desc.Parent
                                        if p and p:IsA("GuiObject") and p.Parent == gui then
                                            p:Destroy()
                                        end
                                    end
                                end
                            end

                            -- 6.2. DÒ TÌM CỬA SỔ CHÍNH VÀ NHÚNG CHẶT VÀO CONTENTAREA
                            if not embeddedFrame then
                                for _, d in ipairs(gui:GetDescendants()) do
                                    if d:IsA("TextLabel") and (d.Text:upper():find("BEST EGG") or d.Text:upper():find("TELE")) then
                                        local cur = d
                                        while cur and cur.Parent and cur.Parent ~= gui do
                                            cur = cur.Parent
                                        end

                                        if cur and cur:IsA("Frame") then
                                            embeddedFrame = cur

                                            -- Ẩn toàn bộ Topbar cũ của Lennon (Logo tròn, chữ LENNON HUB, Discord, nút X)
                                            for _, ch in ipairs(embeddedFrame:GetChildren()) do
                                                if ch:IsA("GuiObject") then
                                                    local isOldHeader = false
                                                    for _, s in ipairs(ch:GetDescendants()) do
                                                        if s:IsA("TextLabel") and (s.Text:upper():find("LENNON") or s.Text:upper():find("SYSTEM")) then
                                                            isOldHeader = true
                                                            break
                                                        end
                                                    end
                                                    if isOldHeader then
                                                        ch.Visible = false
                                                        ch:Destroy()
                                                    end
                                                end
                                            end

                                            -- Gỡ bỏ viền xanh lá cũ của Lennon
                                            local oldStroke = embeddedFrame:FindFirstChildOfClass("UIStroke")
                                            if oldStroke then
                                                oldStroke.Enabled = false
                                                oldStroke:Destroy()
                                            end

                                            -- Chuyển Parent vào ContentArea
                                            embeddedFrame.Parent = ContentArea
                                            embeddedFrame.Draggable = false
                                            embeddedFrame.Active = false
                                            embeddedFrame.BackgroundTransparency = 1
                                            embeddedFrame.BorderSizePixel = 0
                                            embeddedFrame.Position = UDim2.new(0, 10, 0, 12)
                                            embeddedFrame.Size = UDim2.new(1, -20, 1, -24)
                                            embeddedFrame.Visible = MainFrame.Visible

                                            -- Khóa cứng vị trí và Parent chống bị Lennon Hub tự động kéo văng ra ngoài
                                            embeddedFrame:GetPropertyChangedSignal("Position"):Connect(function()
                                                if embeddedFrame.Position ~= UDim2.new(0, 10, 0, 12) then
                                                    embeddedFrame.Position = UDim2.new(0, 10, 0, 12)
                                                end
                                            end)

                                            embeddedFrame:GetPropertyChangedSignal("Parent"):Connect(function()
                                                if embeddedFrame.Parent ~= ContentArea then
                                                    embeddedFrame.Parent = ContentArea
                                                end
                                            end)

                                            -- Định dạng lại màu sắc các thẻ bên trong cho tiệp với màu Obsidian
                                            for _, card in ipairs(embeddedFrame:GetChildren()) do
                                                if card:IsA("GuiObject") and card.Visible then
                                                    card.BackgroundColor3 = THEME.CardBG
                                                    local cardStroke = card:FindFirstChildOfClass("UIStroke")
                                                    if cardStroke then
                                                        cardStroke.Color = THEME.Border
                                                        cardStroke.Thickness = 1
                                                    end
                                                end
                                            end

                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.25)
    end
end)
