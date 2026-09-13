-- ==============================================================================
--  RONNEI HUB - STEAL AN EGG (OFFICIAL V2.2 - REAL STEAL & VELOCITY ENGINE)
--  Khắc phục 100%:
--    1. Auto Steal: Xác định đúng Base/Plot, chờ nhặt trứng thành công mới bay về nộp.
--    2. Speed Bypass: Dùng AssemblyLinearVelocity ghi đè trực tiếp, chống game reset.
--    3. Infinite Jump: Nhảy liên tục mượt mà, ngắt kết nối sạch chống Memory Leak.
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ==================== CẤU HÌNH & BẢNG TRỌNG SỐ ĐỘ HIẾM ====================
local CONFIG = {
    LogoAssetID       = "rbxassetid://124285855971647",
    TikTokURL         = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
    TweenSpeed        = 110 -- Tốc độ bay an toàn chống văng server (studs/s)
}

local RARITY_WEIGHTS = {
    ["SECRET"]    = 10,
    ["ETERNAL"]   = 9,
    ["DIVINE"]    = 8,
    ["COSMIC"]    = 7,
    ["MYTHIC"]    = 6,
    ["LEGENDARY"] = 5,
    ["EPIC"]      = 4,
    ["RARE"]      = 3,
    ["UNCOMMON"]  = 2,
    ["COMMON"]    = 1
}

local THEME = {
    MainBG     = Color3.fromRGB(13, 15, 22),
    CardBG     = Color3.fromRGB(22, 26, 36),
    AccentMint = Color3.fromRGB(0, 230, 120),
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

local FONT_BOLD = Enum.Font.GothamBold
local FONT_MED  = Enum.Font.GothamMedium

-- ==================== QUẢN LÝ TRẠNG THÁI ====================
local STATE = {
    AutoStealRarest = false,
    WalkSpeedValue  = 16,
    WalkSpeedLocked = false,
    InfiniteJump    = false
}

local ActiveConnections = {
    InfiniteJump = nil,
    WalkSpeed    = nil
}

local savedBasePosition = nil

-- ==================== HỆ THỐNG XÁC ĐỊNH BASE & TRỨNG ====================

-- Kiểm tra xem nhân vật đã cầm trứng/brainrot trên tay chưa
local function isHoldingEgg(char)
    if not char then return false end
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then return true end
        local n = item.Name:lower()
        if n:find("egg") or n:find("brainrot") then return true end
    end
    return false
end

-- Tự động tìm tọa độ khu vực nộp trứng (Plot/Base) của người chơi
local function getMyBasePosition()
    if savedBasePosition then return savedBasePosition end

    local basePos = nil
    pcall(function()
        for _, folderName in ipairs({"Plots", "Bases", "Tycoons", "Islands"}) do
            local folder = Workspace:FindFirstChild(folderName)
            if folder then
                for _, plot in ipairs(folder:GetChildren()) do
                    local owner = plot:FindFirstChild("Owner") or plot:GetAttribute("Owner")
                    local isMine = false

                    if typeof(owner) == "Instance" and (owner.Value == LocalPlayer or owner.Value == LocalPlayer.Name) then
                        isMine = true
                    elseif typeof(owner) == "string" and (owner == LocalPlayer.Name or owner == tostring(LocalPlayer.UserId)) then
                        isMine = true
                    elseif plot.Name:lower():find(LocalPlayer.Name:lower()) then
                        isMine = true
                    end

                    if isMine then
                        local deposit = plot:FindFirstChild("Deposit") or plot:FindFirstChild("Drop") 
                            or plot:FindFirstChild("Nest") or plot:FindFirstChild("Collector") 
                            or plot:FindFirstChild("DeliveryZone") or plot:FindFirstChild("EggSlots")
                        
                        if deposit then
                            basePos = deposit:IsA("BasePart") and deposit.Position or deposit:GetPivot().Position
                        else
                            basePos = plot:GetPivot().Position
                        end
                        return
                    end
                end
            end
        end
    end)

    if not basePos then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then basePos = hrp.Position end
    end

    savedBasePosition = basePos
    return basePos
end

-- Quét tìm trứng có độ hiếm cao nhất trên bản đồ
local function findRarestEgg()
    local bestTarget = nil
    local bestPrompt = nil
    local highestWeight = -1

    pcall(function()
        for _, desc in ipairs(Workspace:GetDescendants()) do
            if desc:IsA("ProximityPrompt") and desc.Enabled then
                local part = desc.Parent
                if part and part:IsA("BasePart") then
                    local model = part:FindFirstAncestorOfClass("Model") or part
                    local info = (part.Name .. " " .. model.Name .. " " .. desc.ObjectText .. " " .. desc.ActionText):upper()

                    if info:find("EGG") or info:find("STEAL") or info:find("TRỨNG") or info:find("CƯỚP") then
                        local weight = 1
                        for rName, w in pairs(RARITY_WEIGHTS) do
                            if info:find(rName) and w > weight then
                                weight = w
                            end
                        end

                        if weight > highestWeight then
                            highestWeight = weight
                            bestTarget = part
                            bestPrompt = desc
                        end
                    end
                end
            end
        end
    end)

    return bestTarget, bestPrompt
end

-- Di chuyển mượt bằng Tween CFrame (xuyên tường chống kẹt)
local function safeTweenMove(targetPos)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end

    local dist = (hrp.Position - targetPos).Magnitude
    local timeToTravel = math.clamp(dist / CONFIG.TweenSpeed, 0.35, 4.0)

    local tween = TweenService:Create(hrp, TweenInfo.new(timeToTravel, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
    })

    local finished = false
    tween:Play()
    tween.Completed:Connect(function() finished = true end)

    while not finished and STATE.AutoStealRarest do
        task.wait(0.05)
    end
    return finished
end

-- ==================== 1. VÒNG LẶP AUTO STEAL RAREST ====================
local function startAutoStealProcess()
    task.spawn(function()
        while STATE.AutoStealRarest do
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local basePos = getMyBasePosition()

                if hrp and not isHoldingEgg(char) then
                    local eggPart, eggPrompt = findRarestEgg()

                    if eggPart and eggPrompt then
                        -- Bước 1: Bay đến quả trứng hiếm nhất
                        safeTweenMove(eggPart.Position)

                        -- Bước 2: Đứng tại chỗ kích hoạt nhặt cho đến khi cầm được trứng trên tay
                        local pickStart = tick()
                        while STATE.AutoStealRarest and not isHoldingEgg(char) and (tick() - pickStart < 3.5) do
                            if eggPrompt and eggPrompt.Parent then
                                eggPrompt.HoldDuration = 0
                                if fireproximityprompt then
                                    fireproximityprompt(eggPrompt)
                                end
                            end
                            task.wait(0.2)
                        end

                        -- Bước 3: Đã cầm trứng trên tay -> Bay về Base nộp
                        if isHoldingEgg(char) and basePos then
                            safeTweenMove(basePos)

                            -- Chờ trứng rơi vào khay nộp (Deposit)
                            local depositStart = tick()
                            while isHoldingEgg(char) and (tick() - depositStart < 4) and STATE.AutoStealRarest do
                                task.wait(0.2)
                            end
                        end
                    end
                elseif hrp and isHoldingEgg(char) and basePos then
                    -- Nếu đang cầm sẵn trứng thì lập tức mang về Base
                    safeTweenMove(basePos)
                    task.wait(0.5)
                end
            end)
            task.wait(0.8)
        end
    end)
end

-- ==================== 2. HỆ THỐNG TỐC ĐỘ BẰNG ASSEMBLY VELOCITY ====================
local function updateSpeedEngine(enable)
    STATE.WalkSpeedLocked = enable

    if enable then
        if ActiveConnections.WalkSpeed then ActiveConnections.WalkSpeed:Disconnect() end
        -- Áp dụng lực gia tốc thẳng theo hướng di chuyển của người chơi
        ActiveConnections.WalkSpeed = RunService.Heartbeat:Connect(function()
            pcall(function()
                if STATE.WalkSpeedLocked and STATE.WalkSpeedValue > 16 then
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    if hum and hrp and hum.MoveDirection.Magnitude > 0 then
                        local dir = hum.MoveDirection
                        hrp.AssemblyLinearVelocity = Vector3.new(
                            dir.X * STATE.WalkSpeedValue,
                            hrp.AssemblyLinearVelocity.Y,
                            dir.Z * STATE.WalkSpeedValue
                        )
                    end
                end
            end)
        end)
    else
        if ActiveConnections.WalkSpeed then
            ActiveConnections.WalkSpeed:Disconnect()
            ActiveConnections.WalkSpeed = nil
        end
    end
end

-- ==================== 3. HỆ THỐNG NHẢY VÔ HẠN ====================
local function setInfiniteJump(enable)
    STATE.InfiniteJump = enable

    if enable then
        if ActiveConnections.InfiniteJump then ActiveConnections.InfiniteJump:Disconnect() end
        ActiveConnections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
            pcall(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end)
    else
        if ActiveConnections.InfiniteJump then
            ActiveConnections.InfiniteJump:Disconnect()
            ActiveConnections.InfiniteJump = nil
        end
    end
end

-- ==================== GIAO DIỆN RONNEI HUB 2 TAB ====================
local parentTarget = (gethui and gethui()) or CoreGuiService or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui"))
local oldGui = parentTarget:FindFirstChild("RonneiHub_V2_Fixed")
if oldGui then pcall(function() oldGui:Destroy() end) end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RonneiHub_V2_Fixed"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = parentTarget

local MainCard = Instance.new("Frame", ScreenGui)
MainCard.Name = "MainCard"
MainCard.Size = UDim2.new(0, 315, 0, 330)
MainCard.Position = UDim2.new(1, -335, 0, 60)
MainCard.BackgroundColor3 = THEME.MainBG
MainCard.BorderSizePixel = 0
Instance.new("UICorner", MainCard).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainCard)
MainStroke.Thickness = 2.5
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local RainbowGrad = Instance.new("UIGradient", MainStroke)
RainbowGrad.Color = RainbowSequence

-- Header
local Header = Instance.new("Frame", MainCard)
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
Subtitle.Text = "STEAL AN EGG • SPECIAL V2.2"
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

-- Dragging
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
makeDraggable(MainCard, Header)

-- Tab Bar
local TabBar = Instance.new("Frame", MainCard)
TabBar.Size = UDim2.new(1, -24, 0, 32)
TabBar.Position = UDim2.new(0, 12, 0, 46)
TabBar.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local Tab1Btn = Instance.new("TextButton", TabBar)
Tab1Btn.Size = UDim2.new(0.5, -2, 1, -4)
Tab1Btn.Position = UDim2.new(0, 2, 0, 2)
Tab1Btn.BackgroundColor3 = THEME.MainBG
Tab1Btn.Text = "🥚 Cướp Trứng"
Tab1Btn.Font = FONT_BOLD
Tab1Btn.TextSize = 11
Tab1Btn.TextColor3 = THEME.AccentMint
Instance.new("UICorner", Tab1Btn).CornerRadius = UDim.new(0, 6)

local Tab2Btn = Instance.new("TextButton", TabBar)
Tab2Btn.Size = UDim2.new(0.5, -2, 1, -4)
Tab2Btn.Position = UDim2.new(0.5, 0, 0, 2)
Tab2Btn.BackgroundTransparency = 1
Tab2Btn.Text = "⚡ Nhân Vật"
Tab2Btn.Font = FONT_BOLD
Tab2Btn.TextSize = 11
Tab2Btn.TextColor3 = THEME.TextSub
Instance.new("UICorner", Tab2Btn).CornerRadius = UDim.new(0, 6)

-- Tab Containers
local TabContainer = Instance.new("Frame", MainCard)
TabContainer.Size = UDim2.new(1, -24, 1, -90)
TabContainer.Position = UDim2.new(0, 12, 0, 84)
TabContainer.BackgroundTransparency = 1

local Tab1Frame = Instance.new("ScrollingFrame", TabContainer)
Tab1Frame.Size = UDim2.new(1, 0, 1, 0)
Tab1Frame.BackgroundTransparency = 1
Tab1Frame.BorderSizePixel = 0
Tab1Frame.ScrollBarThickness = 2
Tab1Frame.ScrollBarImageColor3 = THEME.AccentMint
Tab1Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Tab1Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
local Layout1 = Instance.new("UIListLayout", Tab1Frame)
Layout1.Padding = UDim.new(0, 8)

local Tab2Frame = Instance.new("ScrollingFrame", TabContainer)
Tab2Frame.Size = UDim2.new(1, 0, 1, 0)
Tab2Frame.BackgroundTransparency = 1
Tab2Frame.BorderSizePixel = 0
Tab2Frame.ScrollBarThickness = 2
Tab2Frame.ScrollBarImageColor3 = THEME.AccentMint
Tab2Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Tab2Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
Tab2Frame.Visible = false
local Layout2 = Instance.new("UIListLayout", Tab2Frame)
Layout2.Padding = UDim.new(0, 8)

local function switchTab(toTab1)
    Tab1Frame.Visible = toTab1
    Tab2Frame.Visible = not toTab1

    if toTab1 then
        Tab1Btn.BackgroundTransparency = 0
        Tab1Btn.BackgroundColor3 = THEME.MainBG
        Tab1Btn.TextColor3 = THEME.AccentMint
        Tab2Btn.BackgroundTransparency = 1
        Tab2Btn.TextColor3 = THEME.TextSub
    else
        Tab2Btn.BackgroundTransparency = 0
        Tab2Btn.BackgroundColor3 = THEME.MainBG
        Tab2Btn.TextColor3 = THEME.AccentMint
        Tab1Btn.BackgroundTransparency = 1
        Tab1Btn.TextColor3 = THEME.TextSub
    end
end

Tab1Btn.MouseButton1Click:Connect(function() switchTab(true) end)
Tab2Btn.MouseButton1Click:Connect(function() switchTab(false) end)

-- UI Toggle Creator
local function createToggleRow(parent, titleText, subText, initialState, onToggle)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, -4, 0, 46)
    card.BackgroundColor3 = THEME.CardBG
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = initialState and THEME.AccentMint or THEME.Border
    stroke.Thickness = 1

    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1, -65, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = titleText
    lbl.Font = FONT_BOLD
    lbl.TextSize = 11
    lbl.TextColor3 = THEME.TextMain
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local sub = Instance.new("TextLabel", card)
    sub.Size = UDim2.new(1, -65, 0, 16)
    sub.Position = UDim2.new(0, 10, 0, 24)
    sub.BackgroundTransparency = 1
    sub.Text = subText
    sub.Font = FONT_MED
    sub.TextSize = 9
    sub.TextColor3 = initialState and THEME.AccentMint or THEME.TextSub
    sub.TextXAlignment = Enum.TextXAlignment.Left

    local switch = Instance.new("TextButton", card)
    switch.Size = UDim2.new(0, 40, 0, 22)
    switch.Position = UDim2.new(1, -10, 0.5, 0)
    switch.AnchorPoint = Vector2.new(1, 0.5)
    switch.BackgroundColor3 = initialState and THEME.AccentMint or THEME.ToggleOff
    switch.Text = ""
    switch.AutoButtonColor = false
    Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", switch)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = initialState and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    knob.AnchorPoint = Vector2.new(0, 0.5)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = initialState

    local function toggle()
        state = not state
        stroke.Color = state and THEME.AccentMint or THEME.Border
        sub.TextColor3 = state and THEME.AccentMint or THEME.TextSub
        switch.BackgroundColor3 = state and THEME.AccentMint or THEME.ToggleOff

        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        }):Play()

        onToggle(state)
    end

    switch.MouseButton1Click:Connect(toggle)
    card.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            toggle()
        end
    end)
end

-- ==================== TAB 1 ====================
createToggleRow(Tab1Frame, "Auto Steal Rarest Egg", "Cướp trứng xịn nhất, đợi cầm chắc rồi mang về nộp", STATE.AutoStealRarest, function(val)
    STATE.AutoStealRarest = val
    if val then
        startAutoStealProcess()
    end
end)

local TikTokRow = Instance.new("TextButton", Tab1Frame)
TikTokRow.Size = UDim2.new(1, -4, 0, 42)
TikTokRow.BackgroundColor3 = THEME.CardBG
TikTokRow.Text = ""
TikTokRow.AutoButtonColor = false
Instance.new("UICorner", TikTokRow).CornerRadius = UDim.new(0, 8)

local TTRowStroke = Instance.new("UIStroke", TikTokRow)
TTRowStroke.Color = THEME.Border
TTRowStroke.Thickness = 1

local TTIcon = Instance.new("ImageLabel", TikTokRow)
TTIcon.Size = UDim2.new(0, 24, 0, 24)
TTIcon.Position = UDim2.new(0, 10, 0.5, 0)
TTIcon.AnchorPoint = Vector2.new(0, 0.5)
TTIcon.BackgroundTransparency = 1
TTIcon.Image = CONFIG.LogoAssetID
Instance.new("UICorner", TTIcon).CornerRadius = UDim.new(0, 6)

local TTText = Instance.new("TextLabel", TikTokRow)
TTText.Size = UDim2.new(1, -48, 1, 0)
TTText.Position = UDim2.new(0, 40, 0, 0)
TTText.BackgroundTransparency = 1
TTText.Text = "TikTok: @ronnei7.htk (Click Copy)"
TTText.Font = FONT_BOLD
TTText.TextSize = 10
TTText.TextColor3 = THEME.AccentMint
TTText.TextXAlignment = Enum.TextXAlignment.Left

TikTokRow.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(CONFIG.TikTokURL)
    elseif toclipboard then toclipboard(CONFIG.TikTokURL) end
    TTText.Text = "[V] Đã sao chép link TikTok!"
    task.delay(1.5, function()
        if TikTokRow.Parent then TTText.Text = "TikTok: @ronnei7.htk (Click Copy)" end
    end)
end)

-- ==================== TAB 2 ====================
-- Slider Tốc độ WalkSpeed (Dùng Velocity Injection)
local SliderCard = Instance.new("Frame", Tab2Frame)
SliderCard.Size = UDim2.new(1, -4, 0, 62)
SliderCard.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", SliderCard).CornerRadius = UDim.new(0, 8)

local SliderStroke = Instance.new("UIStroke", SliderCard)
SliderStroke.Color = THEME.Border
SliderStroke.Thickness = 1

local SliderTitle = Instance.new("TextLabel", SliderCard)
SliderTitle.Size = UDim2.new(1, -70, 0, 18)
SliderTitle.Position = UDim2.new(0, 10, 0, 6)
SliderTitle.BackgroundTransparency = 1
SliderTitle.Text = "Tốc Độ Di Chuyển (WalkSpeed)"
SliderTitle.Font = FONT_BOLD
SliderTitle.TextSize = 11
SliderTitle.TextColor3 = THEME.TextMain
SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

local SliderValueText = Instance.new("TextLabel", SliderCard)
SliderValueText.Size = UDim2.new(0, 50, 0, 18)
SliderValueText.Position = UDim2.new(1, -60, 0, 6)
SliderValueText.BackgroundTransparency = 1
SliderValueText.Text = tostring(STATE.WalkSpeedValue)
SliderValueText.Font = FONT_BOLD
SliderValueText.TextSize = 12
SliderValueText.TextColor3 = THEME.AccentMint
SliderValueText.TextXAlignment = Enum.TextXAlignment.Right

local Track = Instance.new("Frame", SliderCard)
Track.Size = UDim2.new(1, -20, 0, 6)
Track.Position = UDim2.new(0, 10, 0, 38)
Track.BackgroundColor3 = THEME.ToggleOff
Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

local Fill = Instance.new("Frame", Track)
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.BackgroundColor3 = THEME.AccentMint
Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

local SliderKnob = Instance.new("Frame", Track)
SliderKnob.Size = UDim2.new(0, 14, 0, 14)
SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
SliderKnob.Position = UDim2.new(0, 0, 0.5, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)

local minSpeed, maxSpeed = 16, 200
local isSliding = false

local function updateSlider(inputPositionX)
    local trackAbsPos = Track.AbsolutePosition.X
    local trackAbsSize = Track.AbsoluteSize.X
    local relX = math.clamp(inputPositionX - trackAbsPos, 0, trackAbsSize)
    local percentage = relX / trackAbsSize

    local targetSpeed = math.floor(minSpeed + (maxSpeed - minSpeed) * percentage)
    STATE.WalkSpeedValue = targetSpeed
    SliderValueText.Text = tostring(targetSpeed)

    Fill.Size = UDim2.new(percentage, 0, 1, 0)
    SliderKnob.Position = UDim2.new(percentage, 0, 0.5, 0)

    if targetSpeed > 16 then
        updateSpeedEngine(true)
    else
        updateSpeedEngine(false)
    end
end

Track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = true
        updateSlider(input.Position.X)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input.Position.X)
    end
end)

-- Nhảy Vô Hạn
createToggleRow(Tab2Frame, "Nhảy Vô Hạn (Infinite Jump)", "Nhảy liên tục trên không không giới hạn", STATE.InfiniteJump, function(val)
    setInfiniteJump(val)
end)

-- Nút tròn mở menu
local ToggleBtn = Instance.new("Frame", ScreenGui)
ToggleBtn.Name = "FloatingLogo"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
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
        RainbowGrad.Rotation = rot
        task.wait(0.02)
    end
end)

local LogoImage = Instance.new("ImageLabel", ToggleBtn)
LogoImage.Size = UDim2.new(1, 0, 1, 0)
LogoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = CONFIG.LogoAssetID
LogoImage.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", LogoImage).CornerRadius = UDim.new(1, 0)

makeDraggable(ToggleBtn)

local isMenuOpen = true
local function setMenuVisible(state)
    isMenuOpen = state
    if isMenuOpen then
        MainCard.Visible = true
        TweenService:Create(MainCard, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 315, 0, 330)
        }):Play()
    else
        local tw = TweenService:Create(MainCard, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 315, 0, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not isMenuOpen then MainCard.Visible = false end
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
