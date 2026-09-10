-- ==============================================================================
--  RONNEI HUB - STEAL AN EGG (VERSION 3.6 - ANTI TRAP ONLY)
--  Chạy ngầm: Anti Trap | Bảng Update v3.6 | Viền Cầu Vồng RGB | Âm Thanh CoreGui
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CẤU HÌNH THƯƠNG HIỆU & ÂM THANH
local CONFIG = {
    Version     = "v3.6",
    LogoAssetID = "rbxassetid://124285855971647",
    TikTokURL   = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
    ToggleOnSFX  = "rbxassetid://9114223175",
    ToggleOffSFX = "rbxassetid://9114223204",
    ClickSFX     = "rbxassetid://9114223164",
    SuccessSFX   = "rbxassetid://9114223245"
}

-- ==================== 1. ENGINE PHÁT ÂM THANH ====================
local function playSFX(soundId, volume, pitch)
    task.spawn(function()
        pcall(function()
            local snd = Instance.new("Sound")
            snd.SoundId = soundId
            snd.Volume = volume or 1.0
            snd.PlaybackSpeed = pitch or 1.0
            SoundService:PlayLocalSound(snd)
            task.delay(1.5, function() snd:Destroy() end)
        end)
    end)
end

-- ==================== 2. MODULE ANTI-TRAP (CHẠY NGẦM) ====================
task.spawn(function()
    local trapKeywords = {"trap", "beartrap", "subspace", "mine", "landmine", "turret", "spike"}

    local function neutralizeTrap(inst)
        pcall(function()
            local name = inst.Name:lower()
            local isTrap = false

            for _, kw in ipairs(trapKeywords) do
                if name:find(kw, 1, true) then
                    isTrap = true
                    break
                end
            end

            if isTrap then
                if inst:IsA("BasePart") then
                    inst.CanTouch = false
                    inst.CanCollide = false
                    local touch = inst:FindFirstChildOfClass("TouchTransmitter")
                    if touch then touch:Destroy() end
                elseif inst:IsA("Model") then
                    for _, part in ipairs(inst:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                            part.CanCollide = false
                            local touch = part:FindFirstChildOfClass("TouchTransmitter")
                            if touch then touch:Destroy() end
                        end
                    end
                end
            end
        end)
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do neutralizeTrap(obj) end
    Workspace.DescendantAdded:Connect(neutralizeTrap)
end)

-- ==================== 3. KHỞI CHẠY SCRIPT GỐC NGẦM ====================
task.spawn(function()
    pcall(function()
        script_key = "Trial"
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()
    end)
end)

-- Dọn sạch bản cũ
local parentTarget = (gethui and gethui()) or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")) or CoreGuiService
local oldGui = parentTarget:FindFirstChild("Ronnei_StealAnEgg_Master")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Ronnei_StealAnEgg_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = parentTarget

local THEME = {
    MainBG     = Color3.fromRGB(13, 15, 22),
    CardBG     = Color3.fromRGB(22, 26, 36),
    CardHover  = Color3.fromRGB(30, 36, 50),
    AccentMint = Color3.fromRGB(0, 230, 120),
    Gold       = Color3.fromRGB(255, 200, 40),
    Border     = Color3.fromRGB(45, 55, 75),
    ToggleOff  = Color3.fromRGB(38, 43, 56),
    TextMain   = Color3.fromRGB(245, 248, 255),
    TextSub    = Color3.fromRGB(150, 165, 185)
}

local RainbowSeq = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 70)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})

-- ==================== 4. DIỆT TẬN GỐC MENU EQUINOZ & NÚT HORIZON ====================
local originalEquinozBtn = nil
local targetEquinozGui = nil

local function purgeEquinoz(inst)
    pcall(function()
        if inst:IsDescendantOf(ScreenGui) or inst == ScreenGui then return end
        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            local txt = inst.Text:upper()
            if txt:find("EQUINOZ") or txt:find("STEAL AN EGG V1") or txt:find("ANTI HIT") or txt:find("4HPFT") then
                if txt:find("ANTI HIT") then
                    originalEquinozBtn = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton")
                end
                local sg = inst:FindFirstAncestorOfClass("ScreenGui")
                if sg and sg ~= ScreenGui then
                    targetEquinozGui = sg
                    sg.Enabled = false
                    for _, c in ipairs(sg:GetDescendants()) do
                        if c:IsA("GuiObject") then
                            c.Visible = false
                            c.Position = UDim2.new(10, 0, 10, 0)
                        end
                    end
                end
            end
        end
    end)
end

for _, c in ipairs({CoreGuiService, gethui and gethui(), LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")}) do
    if c then
        for _, d in ipairs(c:GetDescendants()) do purgeEquinoz(d) end
        c.DescendantAdded:Connect(purgeEquinoz)
    end
end

RunService.RenderStepped:Connect(function()
    if targetEquinozGui and targetEquinozGui.Parent then
        targetEquinozGui.Enabled = false
    end
end)

-- HÀM KÉO THẢ GIAO DIỆN
local function makeDraggable(targetFrame, dragBar)
    local dragging, dragStart, startPos = false, nil, nil
    dragBar = dragBar or targetFrame

    dragBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = targetFrame.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragBar.InputChanged:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = inp.Position - dragStart
            targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== 5. MENU CHÍNH (MAIN FRAME) ====================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "RonneiMainCard"
MainFrame.Size = UDim2.new(0, 280, 0, 225)
MainFrame.Position = UDim2.new(1, -300, 0, 45)
MainFrame.BackgroundColor3 = THEME.MainBG
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2.5
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local MainRainbowGrad = Instance.new("UIGradient", MainStroke)
MainRainbowGrad.Color = RainbowSeq

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 0, 20)
Title.Position = UDim2.new(0, 14, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "RONNEI HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = THEME.TextMain
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", Header)
Subtitle.Size = UDim2.new(1, -50, 0, 14)
Subtitle.Position = UDim2.new(0, 14, 0, 24)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "STEAL AN EGG • SPECIAL " .. CONFIG.Version
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 10
Subtitle.TextColor3 = THEME.AccentMint
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(0, 0.5)
CloseBtn.BackgroundColor3 = THEME.CardBG
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.TextColor3 = THEME.TextSub
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

makeDraggable(MainFrame, Header)

local Divider = Instance.new("Frame", MainFrame)
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 44)
Divider.BackgroundColor3 = THEME.Border
Divider.BorderSizePixel = 0

local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -24, 0, 168)
Content.Position = UDim2.new(0, 12, 0, 50)
Content.BackgroundTransparency = 1

-- NÚT 1: ANTI GUARDS WAKE UP (PREMIUM TOGGLE)
local GuardCard = Instance.new("Frame", Content)
GuardCard.Size = UDim2.new(1, 0, 0, 46)
GuardCard.BackgroundColor3 = THEME.CardBG
GuardCard.BorderSizePixel = 0
Instance.new("UICorner", GuardCard).CornerRadius = UDim.new(0, 8)

local GuardStroke = Instance.new("UIStroke", GuardCard)
GuardStroke.Color = THEME.Border
GuardStroke.Thickness = 1

local GuardTitle = Instance.new("TextLabel", GuardCard)
GuardTitle.Size = UDim2.new(1, -65, 0, 20)
GuardTitle.Position = UDim2.new(0, 10, 0, 5)
GuardTitle.BackgroundTransparency = 1
GuardTitle.Text = "Anti Guards Wake Up"
GuardTitle.Font = Enum.Font.GothamBold
GuardTitle.TextSize = 11
GuardTitle.TextColor3 = THEME.TextMain
GuardTitle.TextXAlignment = Enum.TextXAlignment.Left

local PremTag = Instance.new("TextLabel", GuardCard)
PremTag.Size = UDim2.new(1, -65, 0, 14)
PremTag.Position = UDim2.new(0, 10, 0, 24)
PremTag.BackgroundTransparency = 1
PremTag.Text = "👑 PREMIUM MODE"
PremTag.Font = Enum.Font.GothamBold
PremTag.TextSize = 9
PremTag.TextColor3 = THEME.Gold
PremTag.TextXAlignment = Enum.TextXAlignment.Left

local Switch = Instance.new("TextButton", GuardCard)
Switch.Size = UDim2.new(0, 42, 0, 22)
Switch.Position = UDim2.new(1, -10, 0.5, 0)
Switch.AnchorPoint = Vector2.new(1, 0.5)
Switch.BackgroundColor3 = THEME.ToggleOff
Switch.Text = ""
Switch.AutoButtonColor = false
Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

local Knob = Instance.new("Frame", Switch)
Knob.Size = UDim2.new(0, 16, 0, 16)
Knob.Position = UDim2.new(0, 3, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.BorderSizePixel = 0
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

local isAntiGuardEnabled = false

local function setSwitchVisual(state, playSound)
    isAntiGuardEnabled = state
    if playSound then
        playSFX(isAntiGuardEnabled and CONFIG.ToggleOnSFX or CONFIG.ToggleOffSFX, 1.0, 1.0)
    end
    if isAntiGuardEnabled then
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0.5, 0)}):Play()
        TweenService:Create(GuardStroke, TweenInfo.new(0.2), {Color = THEME.AccentMint}):Play()
    else
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, 0)}):Play()
        TweenService:Create(GuardStroke, TweenInfo.new(0.2), {Color = THEME.Border}):Play()
    end
end

local function toggleAntiGuard()
    if originalEquinozBtn then
        pcall(function()
            if firesignal then
                firesignal(originalEquinozBtn.MouseButton1Click)
                firesignal(originalEquinozBtn.Activated)
            elseif getconnections then
                for _, conn in ipairs(getconnections(originalEquinozBtn.MouseButton1Click)) do conn:Fire() end
                for _, conn in ipairs(getconnections(originalEquinozBtn.Activated)) do conn:Fire() end
            end
        end)
    else
        setSwitchVisual(not isAntiGuardEnabled, true)
    end
end

Switch.MouseButton1Click:Connect(toggleAntiGuard)
GuardCard.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        toggleAntiGuard()
    end
end)

task.spawn(function()
    while true do
        if originalEquinozBtn then
            pcall(function()
                local t = originalEquinozBtn.Text:upper()
                if t:find("ON") and not isAntiGuardEnabled then
                    setSwitchVisual(true, true)
                elseif t:find("OFF") and isAntiGuardEnabled then
                    setSwitchVisual(false, true)
                end
            end)
        end
        task.wait(0.25)
    end
end)

-- NÚT 2: SAO CHÉP LINK TIKTOK
local TikTokBtn = Instance.new("TextButton", Content)
TikTokBtn.Size = UDim2.new(1, 0, 0, 42)
TikTokBtn.Position = UDim2.new(0, 0, 0, 52)
TikTokBtn.BackgroundColor3 = THEME.CardBG
TikTokBtn.Text = ""
TikTokBtn.AutoButtonColor = false
Instance.new("UICorner", TikTokBtn).CornerRadius = UDim.new(0, 8)

local TTStroke = Instance.new("UIStroke", TikTokBtn)
TTStroke.Color = THEME.Border
TTStroke.Thickness = 1

local TTIcon = Instance.new("ImageLabel", TikTokBtn)
TTIcon.Size = UDim2.new(0, 24, 0, 24)
TTIcon.Position = UDim2.new(0, 10, 0.5, 0)
TTIcon.AnchorPoint = Vector2.new(0, 0.5)
TTIcon.BackgroundTransparency = 1
TTIcon.Image = CONFIG.LogoAssetID
TTIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
TTIcon.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", TTIcon).CornerRadius = UDim.new(0, 6)

local TTLabel = Instance.new("TextLabel", TikTokBtn)
TTLabel.Size = UDim2.new(1, -48, 1, 0)
TTLabel.Position = UDim2.new(0, 42, 0, 0)
TTLabel.BackgroundTransparency = 1
TTLabel.Text = "TikTok: @ronnei7.htk"
TTLabel.Font = Enum.Font.GothamBold
TTLabel.TextSize = 11
TTLabel.TextColor3 = THEME.TextMain
TTLabel.TextXAlignment = Enum.TextXAlignment.Left

TikTokBtn.MouseButton1Click:Connect(function()
    playSFX(CONFIG.SuccessSFX, 1.0, 1.0)
    if setclipboard then pcall(function() setclipboard(CONFIG.TikTokURL) end)
    elseif toclipboard then pcall(function() toclipboard(CONFIG.TikTokURL) end) end

    TTLabel.Text = "✓ Đã sao chép link TikTok!"
    TTLabel.TextColor3 = THEME.AccentMint
    TweenService:Create(TikTokBtn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.CardHover}):Play()
    TweenService:Create(TTStroke, TweenInfo.new(0.15), {Color = THEME.AccentMint}):Play()

    task.delay(2, function()
        if TikTokBtn.Parent then
            TTLabel.Text = "TikTok: @ronnei7.htk"
            TTLabel.TextColor3 = THEME.TextMain
            TweenService:Create(TikTokBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.CardBG}):Play()
            TweenService:Create(TTStroke, TweenInfo.new(0.2), {Color = THEME.Border}):Play()
        end
    end)
end)

-- NÚT 3: BẬT BẢNG GHI CHÚ CẬP NHẬT V3.6
local ChangelogBtn = Instance.new("TextButton", Content)
ChangelogBtn.Size = UDim2.new(1, 0, 0, 36)
ChangelogBtn.Position = UDim2.new(0, 0, 0, 100)
ChangelogBtn.BackgroundColor3 = THEME.CardBG
ChangelogBtn.Text = "📋  Nhật Ký Cập Nhật " .. CONFIG.Version
ChangelogBtn.Font = Enum.Font.GothamBold
ChangelogBtn.TextSize = 11
ChangelogBtn.TextColor3 = THEME.AccentMint
ChangelogBtn.AutoButtonColor = false
Instance.new("UICorner", ChangelogBtn).CornerRadius = UDim.new(0, 8)

local NoteStroke = Instance.new("UIStroke", ChangelogBtn)
NoteStroke.Color = THEME.Border
NoteStroke.Thickness = 1

-- Trạng thái ngầm hiển thị nhỏ
local RunningTag = Instance.new("TextLabel", Content)
RunningTag.Size = UDim2.new(1, 0, 0, 16)
RunningTag.Position = UDim2.new(0, 0, 0, 142)
RunningTag.BackgroundTransparency = 1
RunningTag.Text = "🟢 Anti Trap: Đang chạy ngầm"
RunningTag.Font = Enum.Font.GothamMedium
RunningTag.TextSize = 9
RunningTag.TextColor3 = THEME.TextSub
RunningTag.TextXAlignment = Enum.TextXAlignment.Center

-- ==================== 6. BẢNG GHI CHÚ CẬP NHẬT (CHANGELOG BOARD) ====================
local NoteCard = Instance.new("Frame", ScreenGui)
NoteCard.Name = "RonneiChangelogCard"
NoteCard.Size = UDim2.new(0, 290, 0, 230)
NoteCard.Position = UDim2.new(0.5, -145, 0.5, -115)
NoteCard.BackgroundColor3 = THEME.MainBG
NoteCard.BorderSizePixel = 0
NoteCard.Visible = false
Instance.new("UICorner", NoteCard).CornerRadius = UDim.new(0, 12)

local NoteRainbowStroke = Instance.new("UIStroke", NoteCard)
NoteRainbowStroke.Thickness = 2.5
NoteRainbowStroke.Color = Color3.fromRGB(255, 255, 255)
NoteRainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local NoteRainbowGrad = Instance.new("UIGradient", NoteRainbowStroke)
NoteRainbowGrad.Color = RainbowSeq

local NoteHeader = Instance.new("Frame", NoteCard)
NoteHeader.Size = UDim2.new(1, 0, 0, 38)
NoteHeader.BackgroundTransparency = 1

local NoteTitle = Instance.new("TextLabel", NoteHeader)
NoteTitle.Size = UDim2.new(1, -40, 1, 0)
NoteTitle.Position = UDim2.new(0, 14, 0, 0)
NoteTitle.BackgroundTransparency = 1
NoteTitle.Text = "NHẬT KÝ CẬP NHẬT " .. CONFIG.Version
NoteTitle.Font = Enum.Font.GothamBold
NoteTitle.TextSize = 13
NoteTitle.TextColor3 = THEME.TextMain
NoteTitle.TextXAlignment = Enum.TextXAlignment.Left

local NoteClose = Instance.new("TextButton", NoteHeader)
NoteClose.Size = UDim2.new(0, 24, 0, 24)
NoteClose.Position = UDim2.new(1, -30, 0.5, 0)
NoteClose.AnchorPoint = Vector2.new(0, 0.5)
NoteClose.BackgroundColor3 = THEME.CardBG
NoteClose.Text = "✕"
NoteClose.Font = Enum.Font.GothamBold
NoteClose.TextSize = 11
NoteClose.TextColor3 = THEME.TextSub
Instance.new("UICorner", NoteClose).CornerRadius = UDim.new(0, 6)

makeDraggable(NoteCard, NoteHeader)

local NoteDivider = Instance.new("Frame", NoteCard)
NoteDivider.Size = UDim2.new(1, -24, 0, 1)
NoteDivider.Position = UDim2.new(0, 12, 0, 38)
NoteDivider.BackgroundColor3 = THEME.Border
NoteDivider.BorderSizePixel = 0

local NoteScroll = Instance.new("ScrollingFrame", NoteCard)
NoteScroll.Size = UDim2.new(1, -20, 1, -50)
NoteScroll.Position = UDim2.new(0, 10, 0, 44)
NoteScroll.BackgroundTransparency = 1
NoteScroll.BorderSizePixel = 0
NoteScroll.ScrollBarThickness = 3
NoteScroll.ScrollBarImageColor3 = THEME.AccentMint
NoteScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
NoteScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local ListLayout = Instance.new("UIListLayout", NoteScroll)
ListLayout.Padding = UDim.new(0, 6)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createChangelogItem(icon, title, desc, order)
    local item = Instance.new("Frame", NoteScroll)
    item.Size = UDim2.new(1, -8, 0, 44)
    item.BackgroundColor3 = THEME.CardBG
    item.BorderSizePixel = 0
    item.LayoutOrder = order
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)

    local iTitle = Instance.new("TextLabel", item)
    iTitle.Size = UDim2.new(1, -12, 0, 18)
    iTitle.Position = UDim2.new(0, 8, 0, 4)
    iTitle.BackgroundTransparency = 1
    iTitle.Text = icon .. " " .. title
    iTitle.Font = Enum.Font.GothamBold
    iTitle.TextSize = 10
    iTitle.TextColor3 = THEME.AccentMint
    iTitle.TextXAlignment = Enum.TextXAlignment.Left

    local iDesc = Instance.new("TextLabel", item)
    iDesc.Size = UDim2.new(1, -12, 0, 18)
    iDesc.Position = UDim2.new(0, 8, 0, 20)
    iDesc.BackgroundTransparency = 1
    iDesc.Text = desc
    iDesc.Font = Enum.Font.GothamMedium
    iDesc.TextSize = 9
    iDesc.TextColor3 = THEME.TextSub
    iDesc.TextXAlignment = Enum.TextXAlignment.Left
end

-- Danh sách tính năng update v3.6 (Đã gỡ Anti Ragdoll)
createChangelogItem("🪤", "Anti Trap (Chạy ngầm)", "Vô hiệu hóa bẫy gấu, mìn subspace, turret trên toàn bản đồ", 1)
createChangelogItem("👑", "Anti Guards Wake Up [PREMIUM]", "Tối ưu hóa khả năng né đòn đánh của bảo vệ Steal an Egg", 2)
createChangelogItem("🌈", "Rainbow Chroma Frame", "Viền cầu vồng quang phổ xoay 360 độ siêu nét", 3)
createChangelogItem("🔊", "Cyber Audio Engine", "Âm thanh CoreGui 2D chuẩn khi click, bật/tắt và sao chép link", 4)
createChangelogItem("🚫", "Purge Foreign UI", "Xóa sạch 100% cửa sổ Equinoz Hub và icon Horizon cũ", 5)

ChangelogBtn.MouseButton1Click:Connect(function()
    playSFX(CONFIG.ClickSFX, 1.0, 1.0)
    NoteCard.Visible = not NoteCard.Visible
end)

NoteClose.MouseButton1Click:Connect(function()
    playSFX(CONFIG.ClickSFX, 1.0, 0.9)
    NoteCard.Visible = false
end)

-- ==================== 7. NÚT TRÒN MỞ MENU (FLOATING LOGO) ====================
local ToggleBtn = Instance.new("Frame", ScreenGui)
ToggleBtn.Name = "RonneiFloatingLogo"
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0, 20, 0.35, 0)
ToggleBtn.BackgroundColor3 = THEME.CardBG
ToggleBtn.ClipsDescendants = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", ToggleBtn)
LogoStroke.Thickness = 2.5
LogoStroke.Color = Color3.fromRGB(255, 255, 255)
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local LogoRainbowGrad = Instance.new("UIGradient", LogoStroke)
LogoRainbowGrad.Color = RainbowSeq

-- Vòng lặp xoay viền cầu vồng 60 FPS
task.spawn(function()
    local rot = 0
    while ScreenGui.Parent do
        rot = (rot + 2.5) % 360
        LogoRainbowGrad.Rotation = rot
        MainRainbowGrad.Rotation = rot
        NoteRainbowGrad.Rotation = rot
        task.wait(0.02)
    end
end)

local LogoImage = Instance.new("ImageLabel", ToggleBtn)
LogoImage.Size = UDim2.new(1, 0, 1, 0)
LogoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = CONFIG.LogoAssetID
LogoImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoImage.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", LogoImage).CornerRadius = UDim.new(1, 0)

makeDraggable(ToggleBtn)

-- Đóng / Mở menu
local isMenuOpen = true
local function setMenuVisible(state)
    isMenuOpen = state
    playSFX(CONFIG.ClickSFX, 1.0, isMenuOpen and 1.1 or 0.9)
    if isMenuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 225)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 280, 0, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not isMenuOpen then MainFrame.Visible = false end
        end)
    end
end

ToggleBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        setMenuVisible(not isMenuOpen)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() setMenuVisible(false) end)
