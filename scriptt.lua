-- ==============================================================================
--  RONNEI HUB - STEAL AN EGG (OFFICIAL V1.3 - CLEAN HOOK & HIDE THIRD-PARTY)
--  Ẩn sạch: Menu Equinoz Hub + Logo Ninja Horizon | Giữ 100% logic Ronnei Hub
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CẤU HÌNH HỆ THỐNG V1.3
local CONFIG = {
    Version           = "V1.3",
    LogoAssetID       = "rbxassetid://124285855971647",
    TikTokURL         = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
    StealHoldDuration = 0.12,
    InvisibleDepth    = 12,
    InvisibleRotation = 226,
    ToggleOnSFX       = "rbxassetid://9114223175",
    ToggleOffSFX      = "rbxassetid://9114223204",
    ClickSFX          = "rbxassetid://9114223164",
    SuccessSFX        = "rbxassetid://9114223245"
}

local FONT_BOLD = Enum.Font.GothamBold
local FONT_MED  = Enum.Font.GothamMedium

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

-- ==================== 2. KHỞI TẠO GIAO DIỆN CHÍNH ====================
local parentTarget = (gethui and gethui()) or CoreGuiService or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui"))
local oldGui = parentTarget:FindFirstChild("Ronnei_StealAnEgg_Master")
if oldGui then pcall(function() oldGui:Destroy() end) end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Ronnei_StealAnEgg_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = parentTarget

-- ==================== 3. CƠ CHẾ GIẤU SẠCH EQUINOZ & HORIZON ====================
local originalEquinozBtn = nil
local hiddenTargetFrames = {}

local function scanAndHideThirdParty(inst)
    pcall(function()
        if inst:IsDescendantOf(ScreenGui) or inst == ScreenGui then return end

        local ownerSg = inst:FindFirstAncestorOfClass("ScreenGui")
        if not ownerSg or ownerSg == ScreenGui then return end

        local isThirdParty = false

        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            local txt = inst.Text:upper()
            if txt:find("EQUINOZ") or txt:find("HORIZON") or txt:find("VEUURTUMWE") or txt:find("ANTI HIT") then
                isThirdParty = true
                if txt:find("ANTI HIT") then
                    originalEquinozBtn = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton")
                end
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            -- Bắt nút logo Ninja của Horizon / Equinoz
            local pName = inst.Parent and inst.Parent.Name:lower() or ""
            if pName:find("logo") or pName:find("open") or pName:find("toggle") or inst.Name:lower():find("logo") then
                isThirdParty = true
            end
        end

        -- Nếu phát hiện thuộc Equinoz/Horizon, gom toàn bộ Frame gốc để đẩy ra khỏi màn hình
        if isThirdParty then
            for _, child in ipairs(ownerSg:GetChildren()) do
                if child:IsA("GuiObject") then
                    hiddenTargetFrames[child] = true
                    child.Visible = false
                    child.Position = UDim2.new(50, 0, 50, 0)
                end
            end
        end
    end)
end

-- Quét toàn bộ CoreGui và PlayerGui
for _, c in ipairs({CoreGuiService, gethui and gethui(), LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")}) do
    if c then
        for _, desc in ipairs(c:GetDescendants()) do scanAndHideThirdParty(desc) end
        c.DescendantAdded:Connect(scanAndHideThirdParty)
    end
end

-- Khóa cứng tọa độ ngoài màn hình mỗi frame (chống script đối thủ tự hiện lại)
RunService.RenderStepped:Connect(function()
    for frame in pairs(hiddenTargetFrames) do
        if frame and frame.Parent then
            frame.Visible = false
            frame.Position = UDim2.new(50, 0, 50, 0)
        else
            hiddenTargetFrames[frame] = nil
        end
    end
end)

-- ==================== 4. MODULE CƯỚP TRỨNG (0.12S HOLD DELAY) ====================
task.spawn(function()
    local function tunePrompt(prompt)
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = CONFIG.StealHoldDuration
            prompt.RequiresLineOfSight = false
            pcall(function()
                prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 25)
            end)
        end
    end

    for _, desc in ipairs(Workspace:GetDescendants()) do tunePrompt(desc) end
    Workspace.DescendantAdded:Connect(tunePrompt)

    ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        pcall(function()
            prompt.HoldDuration = CONFIG.StealHoldDuration
            task.delay(CONFIG.StealHoldDuration, function()
                if fireproximityprompt then
                    fireproximityprompt(prompt)
                end
            end)
        end)
    end)
end)

-- ==================== 5. MODULE TÀNG HÌNH & GIẤU TRỨNG (FE SINK) ====================
task.spawn(function()
    local activeRootJoint = nil
    local defaultC0 = nil

    local function setupInvisibleEngine(char)
        if not char then return end
        local hrp = char:WaitForChild("HumanoidRootPart", 6)
        local hum = char:WaitForChild("Humanoid", 6)
        if not hrp or not hum then return end

        task.wait(0.15)
        if hum.RigType == Enum.RigType.R15 then
            local lowerTorso = char:WaitForChild("LowerTorso", 6)
            activeRootJoint = lowerTorso and lowerTorso:WaitForChild("Root", 6)
        else
            activeRootJoint = hrp:WaitForChild("RootJoint", 6)
        end

        if activeRootJoint then
            defaultC0 = activeRootJoint.C0
        end
    end

    if LocalPlayer.Character then setupInvisibleEngine(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(setupInvisibleEngine)

    RunService.PreSimulation:Connect(function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")

            if activeRootJoint and defaultC0 then
                activeRootJoint.C0 = defaultC0 
                    * CFrame.new(0, -CONFIG.InvisibleDepth, 0) 
                    * CFrame.Angles(0, math.rad(CONFIG.InvisibleRotation), 0)
            end

            if hrp then
                for _, obj in ipairs(hrp:GetChildren()) do
                    if obj:IsA("JointInstance") and obj.Name ~= "RootJoint" then
                        obj.C0 = CFrame.new(0, -CONFIG.InvisibleDepth, 0)
                    end
                end

                for _, item in ipairs(char:GetChildren()) do
                    if item:IsA("Tool") or item:IsA("Model") or item.Name:lower():find("egg") or item.Name:lower():find("brainrot") then
                        for _, part in ipairs(item:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                                part.CFrame = hrp.CFrame * CFrame.new(0, -CONFIG.InvisibleDepth, 0)
                            end
                        end
                    end
                end
            end
        end)
    end)
end)

-- ==================== 6. MODULE ANTI-TRAP VOID (-500M CHẠY NGẦM) ====================
task.spawn(function()
    local trapKeywords = {"trap", "beartrap", "subspace", "mine", "landmine", "turret", "spike"}
    local voidedTraps = {}

    local function banishTrap(inst)
        pcall(function()
            local name = inst.Name:lower()
            local isTrap = false
            for _, kw in ipairs(trapKeywords) do
                if name:find(kw, 1, true) then
                    isTrap = true
                    break
                end
            end

            if isTrap and not voidedTraps[inst] then
                voidedTraps[inst] = true
                if inst:IsA("BasePart") then
                    inst.CanTouch = false
                    inst.CanCollide = false
                    inst.CFrame = inst.CFrame - Vector3.new(0, 500, 0)
                    local touch = inst:FindFirstChildOfClass("TouchTransmitter")
                    if touch then touch:Destroy() end
                elseif inst:IsA("Model") then
                    for _, part in ipairs(inst:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                            part.CanCollide = false
                            part.CFrame = part.CFrame - Vector3.new(0, 500, 0)
                            local touch = part:FindFirstChildOfClass("TouchTransmitter")
                            if touch then touch:Destroy() end
                        end
                    end
                end
            end
        end)
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do banishTrap(obj) end
    Workspace.DescendantAdded:Connect(banishTrap)
end)

-- ==================== 7. KHỞI CHẠY SCRIPT GỐC ====================
task.spawn(function()
    pcall(function()
        script_key = "Trial"
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()
    end)
end)

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

-- ==================== 8. MÀN HÌNH LOADING BLACKOUT ====================
local isCurrentlyLoading = false

local function showLoadingScreen(onComplete)
    isCurrentlyLoading = true

    local LoadGui = Instance.new("ScreenGui")
    LoadGui.Name = "Ronnei_Blackout_Overlay"
    LoadGui.DisplayOrder = 2147483647
    LoadGui.IgnoreGuiInset = true
    LoadGui.ResetOnSpawn = false
    LoadGui.Parent = parentTarget

    local LoadOverlay = Instance.new("Frame", LoadGui)
    LoadOverlay.Size = UDim2.new(1, 0, 1, 0)
    LoadOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LoadOverlay.BackgroundTransparency = 0
    LoadOverlay.BorderSizePixel = 0

    local CenterBox = Instance.new("Frame", LoadOverlay)
    CenterBox.Size = UDim2.new(0, 340, 0, 160)
    CenterBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterBox.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterBox.BackgroundTransparency = 1

    local Spinner = Instance.new("Frame", CenterBox)
    Spinner.Size = UDim2.new(0, 52, 0, 52)
    Spinner.Position = UDim2.new(0.5, 0, 0, 5)
    Spinner.AnchorPoint = Vector2.new(0.5, 0)
    Spinner.BackgroundTransparency = 1
    Instance.new("UICorner", Spinner).CornerRadius = UDim.new(1, 0)

    local SpinnerStroke = Instance.new("UIStroke", Spinner)
    SpinnerStroke.Thickness = 4
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
    LoadTitle.Position = UDim2.new(0, 0, 0, 72)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.Text = "ANTI GUARDS WAKE UP V1"
    LoadTitle.Font = FONT_BOLD
    LoadTitle.TextSize = 16
    LoadTitle.TextColor3 = THEME.TextMain

    local LoadSub = Instance.new("TextLabel", CenterBox)
    LoadSub.Size = UDim2.new(1, 0, 0, 20)
    LoadSub.Position = UDim2.new(0, 0, 0, 102)
    LoadSub.BackgroundTransparency = 1
    LoadSub.Text = "chưa follow tiktok ronnei7.htk là gay"
    LoadSub.Font = FONT_MED
    LoadSub.TextSize = 12
    LoadSub.TextColor3 = Color3.fromRGB(255, 95, 115)

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

        local tw = TweenService:Create(LoadOverlay, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        TweenService:Create(LoadTitle, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(LoadSub, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(SpinnerStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        
        tw:Play()
        tw.Completed:Connect(function()
            LoadGui:Destroy()
            isCurrentlyLoading = false
            if onComplete then onComplete() end
        end)
    end)
end

-- ==================== 9. GIAO DIỆN CHÍNH (MAIN MENU) ====================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "RonneiMainCard"
MainFrame.Size = UDim2.new(0, 275, 0, 210)
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
Subtitle.Text = "STEAL AN EGG • SPECIAL " .. CONFIG.Version
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
Content.Size = UDim2.new(1, -24, 0, 155)
Content.Position = UDim2.new(0, 12, 0, 50)
Content.BackgroundTransparency = 1

-- NÚT 1: ANTI GUARDS WAKE UP
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
GuardTitle.Font = FONT_BOLD
GuardTitle.TextSize = 11
GuardTitle.TextColor3 = THEME.TextMain
GuardTitle.TextXAlignment = Enum.TextXAlignment.Left

local PremTag = Instance.new("TextLabel", GuardCard)
PremTag.Size = UDim2.new(1, -65, 0, 14)
PremTag.Position = UDim2.new(0, 10, 0, 24)
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
local syncCooldownUntil = 0

local function setSwitchVisualInstant(state)
    isAntiGuardEnabled = state

    if isAntiGuardEnabled then
        Switch.BackgroundColor3 = THEME.AccentMint
        Knob.Position = UDim2.new(1, -19, 0.5, 0)
        GuardStroke.Color = THEME.AccentMint
    else
        playSFX(CONFIG.ToggleOffSFX, 1.0, 1.0)
        Switch.BackgroundColor3 = THEME.ToggleOff
        Knob.Position = UDim2.new(0, 3, 0.5, 0)
        GuardStroke.Color = THEME.Border
    end
end

local function fireOriginalEquinozAsync()
    task.spawn(function()
        if not originalEquinozBtn then return end
        pcall(function()
            if firesignal then
                firesignal(originalEquinozBtn.MouseButton1Click)
                firesignal(originalEquinozBtn.Activated)
            elseif getconnections then
                for _, conn in ipairs(getconnections(originalEquinozBtn.MouseButton1Click)) do conn:Fire() end
                for _, conn in ipairs(getconnections(originalEquinozBtn.Activated)) do conn:Fire() end
            end
        end)
    end)
end

local function handleToggleAntiGuard()
    if isCurrentlyLoading then return end

    if not isAntiGuardEnabled then
        setSwitchVisualInstant(true)
        syncCooldownUntil = tick() + 3.0

        showLoadingScreen(function()
            fireOriginalEquinozAsync()
        end)
    else
        syncCooldownUntil = tick() + 3.0
        setSwitchVisualInstant(false)
        fireOriginalEquinozAsync()
    end
end

Switch.MouseButton1Click:Connect(handleToggleAntiGuard)
GuardCard.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        handleToggleAntiGuard()
    end
end)

-- Vòng lặp đồng bộ trạng thái ngầm từ nút Equinoz
task.spawn(function()
    while true do
        if originalEquinozBtn and not isCurrentlyLoading and tick() > syncCooldownUntil then
            pcall(function()
                local t = originalEquinozBtn.Text:upper()
                if t:find("ON") and not isAntiGuardEnabled then
                    setSwitchVisualInstant(true)
                elseif t:find("OFF") and isAntiGuardEnabled then
                    setSwitchVisualInstant(false)
                end
            end)
        end
        task.wait(0.5)
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

-- NÚT 3: BẬT BẢNG NHẬT KÝ
local ChangelogBtn = Instance.new("TextButton", Content)
ChangelogBtn.Size = UDim2.new(1, 0, 0, 36)
ChangelogBtn.Position = UDim2.new(0, 0, 0, 100)
ChangelogBtn.BackgroundColor3 = THEME.CardBG
ChangelogBtn.Text = "📋  Nhật Ký Cập Nhật " .. CONFIG.Version
ChangelogBtn.Font = FONT_BOLD
ChangelogBtn.TextSize = 11
ChangelogBtn.TextColor3 = THEME.AccentMint
ChangelogBtn.AutoButtonColor = false
Instance.new("UICorner", ChangelogBtn).CornerRadius = UDim.new(0, 8)

local NoteBtnStroke = Instance.new("UIStroke", ChangelogBtn)
NoteBtnStroke.Color = THEME.Border
NoteBtnStroke.Thickness = 1

-- ==================== 10. BẢNG NHẬT KÝ ====================
local NoteCard = Instance.new("Frame", ScreenGui)
NoteCard.Name = "RonneiChangelogCard"
NoteCard.Size = UDim2.new(0, 290, 0, 255)
NoteCard.Position = UDim2.new(0.5, -145, 0.5, -127)
NoteCard.BackgroundColor3 = THEME.MainBG
NoteCard.BorderSizePixel = 0
NoteCard.Visible = false
Instance.new("UICorner", NoteCard).CornerRadius = UDim.new(0, 12)

local NoteRainbowStroke = Instance.new("UIStroke", NoteCard)
NoteRainbowStroke.Thickness = 2.5
NoteRainbowStroke.Color = Color3.fromRGB(255, 255, 255)
NoteRainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local NoteRainbowGrad = Instance.new("UIGradient", NoteRainbowStroke)
NoteRainbowGrad.Color = RainbowSequence

local NoteHeader = Instance.new("Frame", NoteCard)
NoteHeader.Size = UDim2.new(1, 0, 0, 38)
NoteHeader.BackgroundTransparency = 1

local NoteTitle = Instance.new("TextLabel", NoteHeader)
NoteTitle.Size = UDim2.new(1, -40, 1, 0)
NoteTitle.Position = UDim2.new(0, 14, 0, 0)
NoteTitle.BackgroundTransparency = 1
NoteTitle.Text = "NHẬT KÝ BẢN " .. CONFIG.Version
NoteTitle.Font = FONT_BOLD
NoteTitle.TextSize = 13
NoteTitle.TextColor3 = THEME.TextMain
NoteTitle.TextXAlignment = Enum.TextXAlignment.Left

local NoteClose = Instance.new("TextButton", NoteHeader)
NoteClose.Size = UDim2.new(0, 24, 0, 24)
NoteClose.Position = UDim2.new(1, -30, 0.5, 0)
NoteClose.AnchorPoint = Vector2.new(0, 0.5)
NoteClose.BackgroundColor3 = THEME.CardBG
NoteClose.Text = "✕"
NoteClose.Font = FONT_BOLD
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
NoteScroll.Size = UDim2.new(1, -20, 1, -48)
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
    item.Size = UDim2.new(1, -8, 0, 46)
    item.BackgroundColor3 = THEME.CardBG
    item.BorderSizePixel = 0
    item.LayoutOrder = order
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)

    local iTitle = Instance.new("TextLabel", item)
    iTitle.Size = UDim2.new(1, -12, 0, 18)
    iTitle.Position = UDim2.new(0, 8, 0, 4)
    iTitle.BackgroundTransparency = 1
    iTitle.Text = icon .. " " .. title
    iTitle.Font = FONT_BOLD
    iTitle.TextSize = 10
    iTitle.TextColor3 = THEME.AccentMint
    iTitle.TextXAlignment = Enum.TextXAlignment.Left

    local iDesc = Instance.new("TextLabel", item)
    iDesc.Size = UDim2.new(1, -12, 0, 20)
    iDesc.Position = UDim2.new(0, 8, 0, 22)
    iDesc.BackgroundTransparency = 1
    iDesc.Text = desc
    iDesc.Font = FONT_MED
    iDesc.TextSize = 9
    iDesc.TextColor3 = THEME.TextSub
    iDesc.TextXAlignment = Enum.TextXAlignment.Left
end

createChangelogItem("⚡", "Smooth Steal (0.12s Delay)", "Tối ưu nhặt nhanh nhạy vừa phải, chống lỗi server và vượt mặt anti-cheat", 1)
createChangelogItem("👻", "FE Invisible Steal", "Dìm RootJoint -12 studs + xoay 226°, người khác & bảo vệ không thấy người & trứng", 2)
createChangelogItem("🪤", "Anti-Trap Void (-500m)", "Tự động dời toàn bộ bẫy gấu, mìn, turret xuống sâu 500m dưới lòng đất", 3)
createChangelogItem("👑", "Anti Guards Wake Up [PREMIUM]", "Tối ưu hóa né đòn, fix triệt để đơ lag khi bật", 4)
createChangelogItem("🎬", "True Blackout Loading", "Che phủ đen kịt 100% toàn màn hình khi bật, mở ra là kích hoạt ngay", 5)
createChangelogItem("🌈", "Rainbow Chroma Frame", "Viền cầu vồng 360 độ siêu nét quanh bảng điều khiển", 6)
createChangelogItem("🔊", "Cyber Audio Engine", "Âm thanh CoreGui 2D chuẩn khi click, bật/tắt và sao chép link", 7)

ChangelogBtn.MouseButton1Click:Connect(function()
    playSFX(CONFIG.ClickSFX, 1.0, 1.0)
    NoteCard.Visible = not NoteCard.Visible
end)

NoteClose.MouseButton1Click:Connect(function()
    playSFX(CONFIG.ClickSFX, 1.0, 0.9)
    NoteCard.Visible = false
end)

-- ==================== 11. NÚT TRÒN MỞ MENU (FLOATING LOGO) ====================
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

local isMenuOpen = true
local function setMenuVisible(state)
    isMenuOpen = state
    playSFX(CONFIG.ClickSFX, 1.0, isMenuOpen and 1.1 or 0.9)

    if isMenuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 275, 0, 210)
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
