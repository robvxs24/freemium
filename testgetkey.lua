-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 1/6)
--   CẤU HÌNH HỆ THỐNG · LƯU TRỮ CỘNG GIỜ KEY · CHU KỲ 00:00 GMT+7
-- =========================================================================

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local KeyUrl = "https://link4m.net/m2JAFv"
local TutorialUrl = "https://craftvip.github.io/free/getkey.html"
local TargetScriptUrl = "https://luauforge-antiraw.netlify.app/raw/b2GaCbtITNxIA6Qayyauq1a"

local ChilliAvatarId = "rbxassetid://92622270383869"  -- Hình quả ớt cho Menu Get Key bên ngoài
local GiftBoxAssetId = "rbxassetid://115116611981430" -- Hình hộp quà cho Mini-game bên trong

local KeyFileName = "ChilliV5_KeyData.json"
local TrialFileName = "ChilliV5_TrialData.json"
local GachaFileName = "ChilliV5_GachaData.json"
local SpinFileName = "ChilliV5_SpinData.json"
local TRIAL_DURATION = 120 -- Dùng thử 2 phút (120 giây)

local InitialGuis = {}
local ScriptConnections = {}
local ActiveBlurEffect = nil
local InputBlockerScreen = nil
local OpenKeySystemUI = nil

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({ GiftBoxAssetId, ChilliAvatarId })
    end)
end)

local CIPHER_KEY = 127

local function EncryptData(str: string): string
    local hex = {}
    for i = 1, #str do
        table.insert(hex, string.format("%02X", bit32.bxor(string.byte(str, i), CIPHER_KEY)))
    end
    return table.concat(hex)
end

local function DecryptData(hexStr: string): string?
    local res = {}
    for i = 1, #hexStr, 2 do
        local b = tonumber(hexStr:sub(i, i + 1), 16)
        if not b then return nil end
        table.insert(res, string.char(bit32.bxor(b, CIPHER_KEY)))
    end
    return table.concat(res)
end

local function GetCurrentDateGMT7(): string
    local vnTime = os.time() + (7 * 3600)
    local d = os.date("!*t", vnTime)
    return string.format("%04d-%02d-%02d", d.year, d.month, d.day)
end

local function GetSecondsUntilMidnightGMT7(): number
    local vnTime = os.time() + (7 * 3600)
    local d = os.date("!*t", vnTime)
    local elapsed = (d.hour * 3600) + (d.min * 60) + d.sec
    return 86400 - elapsed
end

-- QUẢN LÝ HỘP QUÀ (1 LẦN / NGÀY)
local function CanPlayGachaToday(): boolean
    if isfile and readfile and isfile(GachaFileName) then
        local ok, raw = pcall(readfile, GachaFileName)
        if ok and raw and raw ~= "" then
            local dec = DecryptData(raw)
            if dec then
                local parseOk, data = pcall(function() return HttpService:JSONDecode(dec) end)
                if parseOk and type(data) == "table" and data.LastGachaDate then
                    if data.LastGachaDate == GetCurrentDateGMT7() then
                        return false
                    end
                end
            end
        end
    end
    return true
end

local function SaveGachaPlayed()
    if writefile then
        pcall(function()
            local data = { LastGachaDate = GetCurrentDateGMT7(), Timestamp = os.time() }
            writefile(GachaFileName, EncryptData(HttpService:JSONEncode(data)))
        end)
    end
end

-- QUẢN LÝ VÒNG QUAY CỘNG GIỜ (1 LẦN / NGÀY)
local function LoadSpinDataToday(): { Played: boolean, BonusHours: number, Claimed: boolean }
    if isfile and readfile and isfile(SpinFileName) then
        local ok, raw = pcall(readfile, SpinFileName)
        if ok and raw and raw ~= "" then
            local dec = DecryptData(raw)
            if dec then
                local parseOk, data = pcall(function() return HttpService:JSONDecode(dec) end)
                if parseOk and type(data) == "table" and data.LastSpinDate == GetCurrentDateGMT7() then
                    return {
                        Played = true,
                        BonusHours = tonumber(data.BonusHours) or 0,
                        Claimed = data.Claimed == true
                    }
                end
            end
        end
    end
    return { Played = false, BonusHours = 0, Claimed = false }
end

local function SaveSpinResult(bonusHours: number, claimed: boolean)
    if writefile then
        pcall(function()
            local data = {
                LastSpinDate = GetCurrentDateGMT7(),
                BonusHours = bonusHours,
                Claimed = claimed,
                Timestamp = os.time()
            }
            writefile(SpinFileName, EncryptData(HttpService:JSONEncode(data)))
        end)
    end
end

local function LoadTrialData()
    if isfile and readfile and isfile(TrialFileName) then
        local ok, raw = pcall(readfile, TrialFileName)
        if ok and raw and raw ~= "" then
            local dec = DecryptData(raw)
            if dec then
                local parseOk, data = pcall(function() return HttpService:JSONDecode(dec) end)
                if parseOk and type(data) == "table" and data.StartTime and data.LastSeen then
                    if os.time() < data.LastSeen then
                        return { StartTime = 0, LastSeen = os.time(), Tampered = true }
                    end
                    return data
                end
            end
        end
    end
    return nil
end

local function SaveTrialData(startTime: number, lastSeen: number?)
    if writefile then
        pcall(function()
            local data = { StartTime = startTime, LastSeen = lastSeen or os.time(), Duration = TRIAL_DURATION }
            writefile(TrialFileName, EncryptData(HttpService:JSONEncode(data)))
        end)
    end
end

local function GetKeyRemainingTime(): number?
    if isfile and readfile and isfile(KeyFileName) then
        local ok, content = pcall(readfile, KeyFileName)
        if ok and content and content ~= "" then
            local decOk, data = pcall(function() return HttpService:JSONDecode(content) end)
            if decOk and type(data) == "table" and data.ExpireTimestamp then
                local left = data.ExpireTimestamp - os.time()
                if left > 0 then return left end
            end
        end
    end
    return nil
end

-- LƯU KEY 24H KÈM TỰ ĐỘNG CỘNG THÊM GIỜ QUAY TRÚNG TRONG NGÀY
local function Save24hKey(customDuration: number?): number
    local spinInfo = LoadSpinDataToday()
    local bonusSeconds = 0
    if spinInfo.Played and not spinInfo.Claimed and spinInfo.BonusHours > 0 then
        bonusSeconds = spinInfo.BonusHours * 3600
        SaveSpinResult(spinInfo.BonusHours, true)
    end
    local totalDuration = (customDuration or 86400) + bonusSeconds
    if writefile then
        pcall(function()
            writefile(KeyFileName, HttpService:JSONEncode({ ExpireTimestamp = os.time() + totalDuration }))
        end)
    end
    return spinInfo.BonusHours
end

local function VerifyChilliV5Key(rawInput: string): boolean
    if not rawInput or rawInput == "" then return false end
    local clean = string.lower(string.gsub(rawInput, "[%s%c]", ""))
    clean = clean:gsub("^chillihubv5%-", ""):gsub("^chilliv5beta%-", ""):gsub("^chilliv5%-", "")

    local vnTime = os.time() + (7 * 3600)
    for _, t in ipairs({ vnTime, vnTime - 86400, vnTime + 3600 }) do
        local d = os.date("!*t", t)
        local v1 = (d.day * 4339 + d.month * 3187 + d.year * 173) % 65535
        local v2 = (d.day * 6823 + d.month * 4931 + d.year * 293) % 65535
        local v3 = (d.day * 8513 + d.month * 7109 + d.year * 431) % 65535
        if clean == string.format("%04x-%04x-%04x", v1, v2, v3) then
            return true
        end
    end
    return false
end
-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 2/6)
--   SNAPSHOT UI · KHÓA MÀN HÌNH BẢO MẬT · LIVE TOAST THỜI GIAN THỰC
-- =========================================================================

local function TakeGuiSnapshot()
    table.clear(InitialGuis)
    local containers = { CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }
    for _, c in ipairs(containers) do
        if c then
            for _, child in ipairs(c:GetChildren()) do
                InitialGuis[child] = true
            end
        end
    end
end

local function ApplyScreenLockdown()
    if not ActiveBlurEffect then
        ActiveBlurEffect = Instance.new("BlurEffect")
        ActiveBlurEffect.Name = "ChilliV5_LockdownBlur"
        ActiveBlurEffect.Size = 24
        ActiveBlurEffect.Parent = Lighting
    end

    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum then
            hum.WalkSpeed = 0
            hum.JumpPower = 0
            hum.PlatformStand = true
        end
        if hrp then
            hrp.Anchored = true
        end
    end

    if not InputBlockerScreen then
        InputBlockerScreen = Instance.new("ScreenGui")
        InputBlockerScreen.Name = "ChilliV5_InputBlocker"
        InputBlockerScreen.ResetOnSpawn = false
        pcall(function() InputBlockerScreen.Parent = CoreGui end)
        if not InputBlockerScreen.Parent then InputBlockerScreen.Parent = LocalPlayer:WaitForChild("PlayerGui") end

        local shield = Instance.new("TextButton")
        shield.Size = UDim2.new(1, 0, 1, 0)
        shield.Position = UDim2.new(0, 0, 0, 0)
        shield.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
        shield.BackgroundTransparency = 0.45
        shield.Text = ""
        shield.AutoButtonColor = false
        shield.Active = true
        shield.ZIndex = 15
        shield.Parent = InputBlockerScreen
    end
end

local function RemoveScreenLockdown()
    if ActiveBlurEffect then
        ActiveBlurEffect:Destroy()
        ActiveBlurEffect = nil
    end
    if InputBlockerScreen then
        InputBlockerScreen:Destroy()
        InputBlockerScreen = nil
    end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
            hum.PlatformStand = false
        end
        if hrp then
            hrp.Anchored = false
        end
    end
end

local function TerminateTargetScript()
    getgenv().ChilliV5_Active = false
    getgenv().ChilliV5_TrialExpired = true

    for _, conn in ipairs(ScriptConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end
    table.clear(ScriptConnections)

    local containers = { CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }
    for _, c in ipairs(containers) do
        if c then
            for _, child in ipairs(c:GetChildren()) do
                if not InitialGuis[child] and child.Name ~= "ChilliV5_GetKeyUI" and child.Name ~= "ChilliV5_ToastUI" and child.Name ~= "ChilliV5_InputBlocker" then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end
end

local function LaunchTargetScriptWithWatcher()
    TakeGuiSnapshot()
    getgenv().ChilliV5_Active = true

    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet(TargetScriptUrl))()
        end)
    end)
end

local function FormatTime(seconds: number): string
    if seconds < 0 then seconds = 0 end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then
        return string.format("%02dh %02dp %02ds", h, m, s)
    end
    return string.format("%02d:%02d", m, s)
end

local ActiveToastLabel = nil

local function ShowLiveToast(titleText: string, initialSeconds: number, color: Color3)
    if CoreGui:FindFirstChild("ChilliV5_ToastUI") then CoreGui.ChilliV5_ToastUI:Destroy() end
    if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("ChilliV5_ToastUI") then
        LocalPlayer.PlayerGui.ChilliV5_ToastUI:Destroy()
    end

    local ToastGui = Instance.new("ScreenGui")
    ToastGui.Name = "ChilliV5_ToastUI"
    ToastGui.ResetOnSpawn = false
    pcall(function() ToastGui.Parent = CoreGui end)
    if not ToastGui.Parent then ToastGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ToastFrame = Instance.new("Frame")
    ToastFrame.Size = UDim2.new(0, 340, 0, 60)
    ToastFrame.Position = UDim2.new(0.5, -170, 0, -80)
    ToastFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    ToastFrame.BorderSizePixel = 0
    ToastFrame.ZIndex = 50
    ToastFrame.Parent = ToastGui

    Instance.new("UICorner", ToastFrame).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", ToastFrame)
    Stroke.Thickness = 1
    Stroke.Color = color or Color3.fromRGB(225, 29, 72)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 36, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌶️"
    Icon.TextSize = 18
    Icon.ZIndex = 51
    Icon.Parent = ToastFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -55, 0, 18)
    Title.Position = UDim2.new(0, 44, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Color3.fromRGB(248, 250, 252)
    Title.TextSize = 11.5
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 51
    Title.Parent = ToastFrame

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, -55, 0, 16)
    Msg.Position = UDim2.new(0, 44, 0, 28)
    Msg.BackgroundTransparency = 1
    Msg.Text = "Thời hạn còn lại: " .. FormatTime(initialSeconds)
    Msg.TextColor3 = Color3.fromRGB(148, 163, 184)
    Msg.TextSize = 10.5
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextXAlignment = Enum.TextXAlignment.Left
    Msg.ZIndex = 51
    Msg.Parent = ToastFrame

    ActiveToastLabel = Msg

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -24, 0, 2)
    BarBg.Position = UDim2.new(0, 12, 1, -5)
    BarBg.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
    BarBg.BorderSizePixel = 0
    BarBg.ZIndex = 51
    BarBg.Parent = ToastFrame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, 0, 1, 0)
    Bar.BackgroundColor3 = color or Color3.fromRGB(225, 29, 72)
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 52
    Bar.Parent = BarBg

    TweenService:Create(ToastFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -170, 0, 18) }):Play()
    TweenService:Create(Bar, TweenInfo.new(10, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 1, 0) }):Play()

    task.delay(10, function()
        if ToastFrame and ToastFrame.Parent then
            local t = TweenService:Create(ToastFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(0.5, -170, 0, -80) })
            t:Play()
            t.Completed:Connect(function()
                if ToastGui and ToastGui.Parent then ToastGui:Destroy() end
                ActiveToastLabel = nil
            end)
        end
    end)
end
-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 3/6)
--   TỪ ĐIỂN SONG NGỮ VI/EN · GIAO DIỆN CHÍNH DARK SLATE · Ô NHẬP KEY
-- =========================================================================

local Languages = {
    VI = {
        LangBtnText = "🇻🇳 VI",
        Title = "Key Steam Chilli Hub V5 - steal an egg 🥚",
        Subtitle = "chilli hub v5 được tạo bởi ronnei7.htk",
        CenterTitle = "CHILLI HUB V5 × RONNEI",
        CenterSub = "Steal An Egg 🥚 Edition",
        Placeholder = "Dán mã key tại đây...",
        QuickPaste = "Dán",
        GetKey = "Lấy Key (24 Tiếng)",
        CheckKey = "Kích Hoạt V5",
        Tutorial = "📖 Hướng dẫn vượt link lấy key",
        MiniGameBox = "mini game ( getkey or nokey ) 🤑",
        MiniGameBoxLocked = "🔒 Hộp quà (00:00)",
        MiniGameSpin = "🎡 Vòng Quay (+Giờ) 🔥",
        MiniGameSpinLocked = "🔒 Đã quay (+%dH)",
        Notice = "📌 Link getkey 24 tiếng thao tác nhanh gọn (chỉ 1 phút). Key hoạt động đúng 24 giờ sau khi kích hoạt.",
        CopiedLink = "Đã sao chép link getkey 24 tiếng vào clipboard!",
        CopiedTutorial = "Đã sao chép link hướng dẫn vào clipboard!",
        Checking = "Đang xác nhận...",
        CheckingMsg = "Đang đối soát mã key...",
        Success = "Xác nhận thành công! Đang tải Chilli Hub V5...",
        Error = "Mã Key không hợp lệ hoặc đã hết hạn!",
        -- Hộp quà
        GachaTitle = "🎁 HỘP QUÀ MAY MẮN (1 LẦN/NGÀY)",
        GachaSub = "Chọn 1 hộp bất kỳ. Trúng NoKey sẽ vào thẳng script không cần GetKey!",
        Rate5050 = "TỈ LỆ: 50% - 50%",
        Box1Name = "HỘP QUÀ #1",
        Box2Name = "HỘP QUÀ #2",
        OpenBoxBtn = "MỞ HỘP",
        OpeningBox = "ĐANG MỞ...",
        BoxBannerIdle = "Bấm vào 1 trong 2 hộp quà phía trên để thử vận may!",
        BoxBannerOpening = "⏳ Đang mở hộp quà...",
        BoxWonTitle = "🎉 TRÚNG NOKEY!",
        BoxWonBtn = "VÀO SCRIPT NGAY",
        BoxWonBanner = "🎉 Chúc mừng! Bạn trúng NoKey! Đang tải script...",
        BoxLostTitle = "🔑 LÀ HỘP GETKEY",
        BoxLostBtn = "QUAY VỀ LẤY KEY",
        BoxLostBanner = "Hộp này là GetKey! Vui lòng vượt link để nhận key nhé.",
        -- Vòng quay
        SpinTitle = "🎡 VÒNG QUAY CỘNG GIỜ (1 LẦN/NGÀY)",
        SpinSub = "Tất cả các ô đều có cơ hội ngang nhau (50% - 50%)! Bấm QUAY ngay!",
        SpinNote = "💡 Ghi chú: sau khi bạn getkey, thời gian bạn quay ra sẽ được cộng vào thời gian key sử dụng của bạn",
        SpinBtnText = "QUAY NGAY",
        SpinningText = "ĐANG QUAY...",
        SpinDoneText = "ĐÃ QUAY",
        Prize2H = "+2 TIẾNG",
        Prize3H = "+3 GIỜ",
        Prize4H = "+4 GIỜ",
        Prize12H = "+12 GIỜ",
        PrizeSub = "Thời gian sử dụng",
        Msg2H = "ngon thí 😋 (+2 tiếng vào Key)",
        Msg3H = "ngon thííííí😲 (+3 giờ vào Key)",
        Msg4H = "bạn biết không bạn đã may mắn hơn 70% mọi người rồi đó🤑 (+4 giờ)",
        Msg12H = "ôi trời đấy quỷ thần ơi sao trên đời lại có người hên đến vậy chứ 😱 (+12 giờ)"
    },
    EN = {
        LangBtnText = "🇺🇸 EN",
        Title = "Key Steam Chilli Hub V5 - steal an egg 🥚",
        Subtitle = "chilli hub v5 created by ronnei7.htk",
        CenterTitle = "CHILLI HUB V5 × RONNEI",
        CenterSub = "Steal An Egg 🥚 Edition",
        Placeholder = "Paste your license key here...",
        QuickPaste = "Paste",
        GetKey = "Get Key (24 Hours)",
        CheckKey = "Activate V5",
        Tutorial = "📖 How to bypass link tutorial",
        MiniGameBox = "mini game ( getkey or nokey ) 🤑",
        MiniGameBoxLocked = "🔒 Box Opened (00:00)",
        MiniGameSpin = "🎡 Lucky Spin (+Hours) 🔥",
        MiniGameSpinLocked = "🔒 Spun (+%dH)",
        Notice = "📌 24-hour key link takes about 1 min. Valid for exactly 24 hours after activation.",
        CopiedLink = "24-hour key link copied to clipboard!",
        CopiedTutorial = "Tutorial link copied to clipboard!",
        Checking = "Checking...",
        CheckingMsg = "Verifying license key...",
        Success = "Verified! Launching Chilli Hub V5...",
        Error = "Invalid key or expired license!",
        -- Mystery Box
        GachaTitle = "🎁 MYSTERY BOX (1 TIME/DAY)",
        GachaSub = "Pick any box. Winning NoKey launches the script immediately without GetKey!",
        Rate5050 = "RATE: 50% - 50%",
        Box1Name = "MYSTERY BOX #1",
        Box2Name = "MYSTERY BOX #2",
        OpenBoxBtn = "OPEN BOX",
        OpeningBox = "OPENING...",
        BoxBannerIdle = "Click one of the 2 boxes above to test your luck!",
        BoxBannerOpening = "⏳ Opening mystery box...",
        BoxWonTitle = "🎉 WON NOKEY!",
        BoxWonBtn = "LAUNCH SCRIPT",
        BoxWonBanner = "🎉 Congrats! You won NoKey! Loading script...",
        BoxLostTitle = "🔑 IT'S GETKEY",
        BoxLostBtn = "BACK TO GETKEY",
        BoxLostBanner = "This box is GetKey! Please complete the link to get your key.",
        -- Spin Wheel
        SpinTitle = "🎡 BONUS TIME WHEEL (1 TIME/DAY)",
        SpinSub = "All slots have an equal 50% - 50% chance! Press SPIN now!",
        SpinNote = "💡 Note: after you getkey, the time you spin will be added to your key usage time",
        SpinBtnText = "SPIN NOW",
        SpinningText = "SPINNING...",
        SpinDoneText = "COMPLETED",
        Prize2H = "+2 HOURS",
        Prize3H = "+3 HOURS",
        Prize4H = "+4 HOURS",
        Prize12H = "+12 HOURS",
        PrizeSub = "Usage Time",
        Msg2H = "Pretty sweet! 😋 (+2 hours added to Key)",
        Msg3H = "Soooo sweet! 😲 (+3 hours added to Key)",
        Msg4H = "Did you know you're luckier than 70% of people?! 🤑 (+4 hours)",
        Msg12H = "Oh my goodness, how can someone in this world be this lucky?! 😱 (+12 hours)"
    }
}
local CurrentLang = "VI"

local function PlaySpringButton(btn: GuiButton)
    local origSize = btn.Size
    local origPos = btn.Position
    local shrinkSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 4, origSize.Y.Scale, origSize.Y.Offset - 2)
    local shrinkPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 2, origPos.Y.Scale, origPos.Y.Offset + 1)

    local t1 = TweenService:Create(btn, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = shrinkSize, Position = shrinkPos })
    local t2 = TweenService:Create(btn, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = origSize, Position = origPos })
    t1:Play()
    t1.Completed:Connect(function() t2:Play() end)
end

OpenKeySystemUI = function()
    if CoreGui:FindFirstChild("ChilliV5_GetKeyUI") then CoreGui.ChilliV5_GetKeyUI:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ChilliV5_GetKeyUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 440, 0, 455)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.ZIndex = 30
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18)

    local MainScale = Instance.new("UIScale", MainFrame)
    MainScale.Scale = 1.0

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 1
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Color = Color3.fromRGB(38, 43, 54)

    -- HEADER
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, -28, 0, 40)
    HeaderBar.Position = UDim2.new(0, 14, 0, 10)
    HeaderBar.BackgroundTransparency = 1
    HeaderBar.ZIndex = 31
    HeaderBar.Parent = MainFrame

    local MiniLogo = Instance.new("Frame")
    MiniLogo.Size = UDim2.new(0, 28, 0, 28)
    MiniLogo.Position = UDim2.new(0, 0, 0.5, -14)
    MiniLogo.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
    MiniLogo.ClipsDescendants = true
    MiniLogo.ZIndex = 32
    MiniLogo.Parent = HeaderBar
    Instance.new("UICorner", MiniLogo).CornerRadius = UDim.new(1, 0)
    local MiniLogoStroke = Instance.new("UIStroke", MiniLogo)
    MiniLogoStroke.Color = Color3.fromRGB(225, 29, 72)
    MiniLogoStroke.Thickness = 1

    local MiniLogoImg = Instance.new("ImageLabel")
    MiniLogoImg.Size = UDim2.new(1, 0, 1, 0)
    MiniLogoImg.BackgroundTransparency = 1
    MiniLogoImg.Image = ChilliAvatarId
    MiniLogoImg.ScaleType = Enum.ScaleType.Fit
    MiniLogoImg.ZIndex = 33
    MiniLogoImg.Parent = MiniLogo

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 0, 18)
    TitleLabel.Position = UDim2.new(0, 36, 0, 2)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Languages[CurrentLang].Title
    TitleLabel.TextColor3 = Color3.fromRGB(241, 245, 249)
    TitleLabel.TextSize = 11.5
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 32
    TitleLabel.Parent = HeaderBar

    local SubTitleLabel = Instance.new("TextLabel")
    SubTitleLabel.Size = UDim2.new(1, -100, 0, 14)
    SubTitleLabel.Position = UDim2.new(0, 36, 0, 20)
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Text = Languages[CurrentLang].Subtitle
    SubTitleLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
    SubTitleLabel.TextSize = 9.5
    SubTitleLabel.Font = Enum.Font.GothamMedium
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubTitleLabel.ZIndex = 32
    SubTitleLabel.Parent = HeaderBar

    local OpenLangBtn = Instance.new("TextButton")
    OpenLangBtn.Size = UDim2.new(0, 60, 0, 26)
    OpenLangBtn.Position = UDim2.new(1, -60, 0.5, -13)
    OpenLangBtn.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
    OpenLangBtn.Text = Languages[CurrentLang].LangBtnText
    OpenLangBtn.TextColor3 = Color3.fromRGB(226, 232, 240)
    OpenLangBtn.TextSize = 10.5
    OpenLangBtn.Font = Enum.Font.GothamBold
    OpenLangBtn.AutoButtonColor = false
    OpenLangBtn.ZIndex = 32
    OpenLangBtn.Parent = HeaderBar
    Instance.new("UICorner", OpenLangBtn).CornerRadius = UDim.new(0, 6)
    local LangStroke = Instance.new("UIStroke", OpenLangBtn)
    LangStroke.Color = Color3.fromRGB(45, 52, 68)
    LangStroke.Thickness = 1

    -- AVATAR QUẢ ỚT CHÍNH GIỮA
    local CenterLogoBox = Instance.new("Frame")
    CenterLogoBox.Size = UDim2.new(0, 52, 0, 52)
    CenterLogoBox.Position = UDim2.new(0.5, -26, 0, 52)
    CenterLogoBox.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
    CenterLogoBox.ClipsDescendants = true
    CenterLogoBox.ZIndex = 31
    CenterLogoBox.Parent = MainFrame
    Instance.new("UICorner", CenterLogoBox).CornerRadius = UDim.new(0, 14)
    local CenterLogoStroke = Instance.new("UIStroke", CenterLogoBox)
    CenterLogoStroke.Color = Color3.fromRGB(225, 29, 72)
    CenterLogoStroke.Thickness = 1.2

    local CenterLogoImg = Instance.new("ImageLabel")
    CenterLogoImg.Size = UDim2.new(0.9, 0, 0.9, 0)
    CenterLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterLogoImg.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterLogoImg.BackgroundTransparency = 1
    CenterLogoImg.Image = ChilliAvatarId
    CenterLogoImg.ScaleType = Enum.ScaleType.Fit
    CenterLogoImg.ZIndex = 32
    CenterLogoImg.Parent = CenterLogoBox

    local CenterTitle = Instance.new("TextLabel")
    CenterTitle.Size = UDim2.new(1, -30, 0, 18)
    CenterTitle.Position = UDim2.new(0, 15, 0, 110)
    CenterTitle.BackgroundTransparency = 1
    CenterTitle.Text = Languages[CurrentLang].CenterTitle
    CenterTitle.TextColor3 = Color3.fromRGB(248, 250, 252)
    CenterTitle.TextSize = 13
    CenterTitle.Font = Enum.Font.GothamBold
    CenterTitle.ZIndex = 31
    CenterTitle.Parent = MainFrame

    local CenterSub = Instance.new("TextLabel")
    CenterSub.Size = UDim2.new(1, -30, 0, 15)
    CenterSub.Position = UDim2.new(0, 15, 0, 129)
    CenterSub.BackgroundTransparency = 1
    CenterSub.Text = Languages[CurrentLang].CenterSub
    CenterSub.TextColor3 = Color3.fromRGB(148, 163, 184)
    CenterSub.TextSize = 10
    CenterSub.Font = Enum.Font.GothamMedium
    CenterSub.ZIndex = 31
    CenterSub.Parent = MainFrame

    -- KHUNG NHẬP LIỆU & NÚT DÁN NHANH
    local InputContainer = Instance.new("Frame")
    InputContainer.Size = UDim2.new(1, -36, 0, 38)
    InputContainer.Position = UDim2.new(0, 18, 0, 150)
    InputContainer.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
    InputContainer.ZIndex = 31
    InputContainer.Parent = MainFrame
    Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 10)
    local InputStroke = Instance.new("UIStroke", InputContainer)
    InputStroke.Color = Color3.fromRGB(42, 48, 62)
    InputStroke.Thickness = 1

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -75, 1, 0)
    InputBox.Position = UDim2.new(0, 12, 0, 0)
    InputBox.BackgroundTransparency = 1
    InputBox.TextColor3 = Color3.fromRGB(248, 250, 252)
    InputBox.PlaceholderColor3 = Color3.fromRGB(100, 116, 139)
    InputBox.PlaceholderText = Languages[CurrentLang].Placeholder
    InputBox.Text = ""
    InputBox.TextSize = 11.5
    InputBox.Font = Enum.Font.GothamMedium
    InputBox.TextXAlignment = Enum.TextXAlignment.Left
    InputBox.ClearTextOnFocus = false
    InputBox.ZIndex = 32
    InputBox.Parent = InputContainer

    local QuickPasteBtn = Instance.new("TextButton")
    QuickPasteBtn.Size = UDim2.new(0, 54, 0, 26)
    QuickPasteBtn.Position = UDim2.new(1, -60, 0.5, -13)
    QuickPasteBtn.BackgroundColor3 = Color3.fromRGB(32, 37, 49)
    QuickPasteBtn.Text = Languages[CurrentLang].QuickPaste
    QuickPasteBtn.TextColor3 = Color3.fromRGB(226, 232, 240)
    QuickPasteBtn.TextSize = 10.5
    QuickPasteBtn.Font = Enum.Font.GothamBold
    QuickPasteBtn.AutoButtonColor = false
    QuickPasteBtn.ZIndex = 33
    QuickPasteBtn.Parent = InputContainer
    Instance.new("UICorner", QuickPasteBtn).CornerRadius = UDim.new(0, 6)
  -- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 4/6)
--   CỤM NÚT CHÍNH · HÀNG ĐÔI MINI-GAME · GIAO DIỆN MODAL HỘP QUÀ
-- =========================================================================

    local ButtonsRow = Instance.new("Frame")
    ButtonsRow.Size = UDim2.new(1, -36, 0, 40)
    ButtonsRow.Position = UDim2.new(0, 18, 0, 196)
    ButtonsRow.BackgroundTransparency = 1
    ButtonsRow.ZIndex = 31
    ButtonsRow.Parent = MainFrame

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.5, -6, 1, 0)
    GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(225, 29, 72)
    GetKeyBtn.Text = Languages[CurrentLang].GetKey
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyBtn.TextSize = 11.5
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.AutoButtonColor = false
    GetKeyBtn.ZIndex = 32
    GetKeyBtn.Parent = ButtonsRow
    Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

    local CheckKeyBtn = Instance.new("TextButton")
    CheckKeyBtn.Size = UDim2.new(0.5, -6, 1, 0)
    CheckKeyBtn.Position = UDim2.new(0.5, 6, 0, 0)
    CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
    CheckKeyBtn.TextColor3 = Color3.fromRGB(226, 232, 240)
    CheckKeyBtn.TextSize = 11.5
    CheckKeyBtn.Font = Enum.Font.GothamBold
    CheckKeyBtn.AutoButtonColor = false
    CheckKeyBtn.ZIndex = 32
    CheckKeyBtn.Parent = ButtonsRow
    Instance.new("UICorner", CheckKeyBtn).CornerRadius = UDim.new(0, 10)
    local CheckStroke = Instance.new("UIStroke", CheckKeyBtn)
    CheckStroke.Color = Color3.fromRGB(55, 65, 81)
    CheckStroke.Thickness = 1

    local TutorialBtn = Instance.new("TextButton")
    TutorialBtn.Size = UDim2.new(1, -36, 0, 32)
    TutorialBtn.Position = UDim2.new(0, 18, 0, 244)
    TutorialBtn.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    TutorialBtn.Text = Languages[CurrentLang].Tutorial
    TutorialBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
    TutorialBtn.TextSize = 11
    TutorialBtn.Font = Enum.Font.GothamBold
    TutorialBtn.AutoButtonColor = false
    TutorialBtn.ZIndex = 32
    TutorialBtn.Parent = MainFrame
    Instance.new("UICorner", TutorialBtn).CornerRadius = UDim.new(0, 8)
    local TutorialStroke = Instance.new("UIStroke", TutorialBtn)
    TutorialStroke.Color = Color3.fromRGB(38, 43, 56)
    TutorialStroke.Thickness = 1

    local NoticeCard = Instance.new("Frame")
    NoticeCard.Size = UDim2.new(1, -36, 0, 50)
    NoticeCard.Position = UDim2.new(0, 18, 0, 284)
    NoticeCard.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    NoticeCard.ZIndex = 31
    NoticeCard.Parent = MainFrame
    Instance.new("UICorner", NoticeCard).CornerRadius = UDim.new(0, 10)
    local NoticeStroke = Instance.new("UIStroke", NoticeCard)
    NoticeStroke.Color = Color3.fromRGB(32, 37, 49)
    NoticeStroke.Thickness = 1

    local NoticeText = Instance.new("TextLabel")
    NoticeText.Size = UDim2.new(1, -16, 1, -6)
    NoticeText.Position = UDim2.new(0, 8, 0, 3)
    NoticeText.BackgroundTransparency = 1
    NoticeText.Text = Languages[CurrentLang].Notice
    NoticeText.TextColor3 = Color3.fromRGB(148, 163, 184)
    NoticeText.TextSize = 10
    NoticeText.Font = Enum.Font.GothamMedium
    NoticeText.TextWrapped = true
    NoticeText.TextYAlignment = Enum.TextYAlignment.Center
    NoticeText.TextXAlignment = Enum.TextXAlignment.Left
    NoticeText.ZIndex = 32
    NoticeText.Parent = NoticeCard

    -- HÀNG NÚT ĐÔI MINI-GAME: HỘP QUÀ (TRÁI) & VÒNG QUAY CỘNG GIỜ (PHẢI)
    local MiniGamesRow = Instance.new("Frame")
    MiniGamesRow.Size = UDim2.new(1, -36, 0, 40)
    MiniGamesRow.Position = UDim2.new(0, 18, 0, 342)
    MiniGamesRow.BackgroundTransparency = 1
    MiniGamesRow.ZIndex = 31
    MiniGamesRow.Parent = MainFrame

    local MiniGameBtn = Instance.new("TextButton")
    MiniGameBtn.Size = UDim2.new(0.54, -4, 1, 0)
    MiniGameBtn.Position = UDim2.new(0, 0, 0, 0)
    MiniGameBtn.BackgroundColor3 = CanPlayGachaToday() and Color3.fromRGB(24, 28, 38) or Color3.fromRGB(18, 20, 27)
    MiniGameBtn.Text = CanPlayGachaToday() and Languages[CurrentLang].MiniGameBox or Languages[CurrentLang].MiniGameBoxLocked
    MiniGameBtn.TextColor3 = CanPlayGachaToday() and Color3.fromRGB(226, 232, 240) or Color3.fromRGB(100, 116, 139)
    MiniGameBtn.TextSize = 10.5
    MiniGameBtn.Font = Enum.Font.GothamBold
    MiniGameBtn.AutoButtonColor = false
    MiniGameBtn.ZIndex = 32
    MiniGameBtn.Parent = MiniGamesRow
    Instance.new("UICorner", MiniGameBtn).CornerRadius = UDim.new(0, 10)
    local MiniGameStroke = Instance.new("UIStroke", MiniGameBtn)
    MiniGameStroke.Color = CanPlayGachaToday() and Color3.fromRGB(225, 29, 72) or Color3.fromRGB(38, 43, 56)
    MiniGameStroke.Thickness = 1

    local initSpin = LoadSpinDataToday()
    local SpinGameBtn = Instance.new("TextButton")
    SpinGameBtn.Size = UDim2.new(0.46, -4, 1, 0)
    SpinGameBtn.Position = UDim2.new(0.54, 4, 0, 0)
    SpinGameBtn.BackgroundColor3 = (not initSpin.Played) and Color3.fromRGB(28, 24, 38) or Color3.fromRGB(18, 20, 27)
    SpinGameBtn.Text = (not initSpin.Played) and Languages[CurrentLang].MiniGameSpin or string.format(Languages[CurrentLang].MiniGameSpinLocked, initSpin.BonusHours)
    SpinGameBtn.TextColor3 = (not initSpin.Played) and Color3.fromRGB(253, 224, 71) or Color3.fromRGB(100, 116, 139)
    SpinGameBtn.TextSize = 10.5
    SpinGameBtn.Font = Enum.Font.GothamBold
    SpinGameBtn.AutoButtonColor = false
    SpinGameBtn.ZIndex = 32
    SpinGameBtn.Parent = MiniGamesRow
    Instance.new("UICorner", SpinGameBtn).CornerRadius = UDim.new(0, 10)
    local SpinGameStroke = Instance.new("UIStroke", SpinGameBtn)
    SpinGameStroke.Color = (not initSpin.Played) and Color3.fromRGB(234, 179, 8) or Color3.fromRGB(38, 43, 56)
    SpinGameStroke.Thickness = 1

    local StatusMsg = Instance.new("TextLabel")
    StatusMsg.Size = UDim2.new(1, -36, 0, 20)
    StatusMsg.Position = UDim2.new(0, 18, 0, 392)
    StatusMsg.BackgroundTransparency = 1
    StatusMsg.Text = "Chilli Hub V5 • Steal An Egg 🥚 • by ronnei7.htk"
    StatusMsg.TextColor3 = Color3.fromRGB(100, 116, 139)
    StatusMsg.TextSize = 9.5
    StatusMsg.Font = Enum.Font.GothamMedium
    StatusMsg.ZIndex = 31
    StatusMsg.Parent = MainFrame

    -- MODAL HỘP QUÀ GACHA (TỈ LỆ THỰC: 5% NOKEY / 95% GETKEY)
    local GachaModal = Instance.new("Frame")
    GachaModal.Name = "GachaModal"
    GachaModal.Size = UDim2.new(1, 0, 1, 0)
    GachaModal.Position = UDim2.new(0, 0, 1, 0)
    GachaModal.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    GachaModal.ZIndex = 45
    GachaModal.ClipsDescendants = true
    GachaModal.Parent = MainFrame
    Instance.new("UICorner", GachaModal).CornerRadius = UDim.new(0, 18)

    local GachaHeader = Instance.new("TextLabel")
    GachaHeader.Size = UDim2.new(1, -60, 0, 24)
    GachaHeader.Position = UDim2.new(0, 18, 0, 12)
    GachaHeader.BackgroundTransparency = 1
    GachaHeader.Text = Languages[CurrentLang].GachaTitle
    GachaHeader.TextColor3 = Color3.fromRGB(248, 250, 252)
    GachaHeader.TextSize = 12
    GachaHeader.Font = Enum.Font.GothamBold
    GachaHeader.TextXAlignment = Enum.TextXAlignment.Left
    GachaHeader.ZIndex = 46
    GachaHeader.Parent = GachaModal

    local GachaCloseBtn = Instance.new("TextButton")
    GachaCloseBtn.Size = UDim2.new(0, 26, 0, 26)
    GachaCloseBtn.Position = UDim2.new(1, -36, 0, 12)
    GachaCloseBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    GachaCloseBtn.Text = "✕"
    GachaCloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
    GachaCloseBtn.TextSize = 11
    GachaCloseBtn.Font = Enum.Font.GothamBold
    GachaCloseBtn.ZIndex = 46
    GachaCloseBtn.Parent = GachaModal
    Instance.new("UICorner", GachaCloseBtn).CornerRadius = UDim.new(0, 6)

    local GachaSubText = Instance.new("TextLabel")
    GachaSubText.Size = UDim2.new(1, -36, 0, 20)
    GachaSubText.Position = UDim2.new(0, 18, 0, 38)
    GachaSubText.BackgroundTransparency = 1
    GachaSubText.Text = Languages[CurrentLang].GachaSub
    GachaSubText.TextColor3 = Color3.fromRGB(148, 163, 184)
    GachaSubText.TextSize = 10
    GachaSubText.Font = Enum.Font.GothamMedium
    GachaSubText.TextXAlignment = Enum.TextXAlignment.Left
    GachaSubText.ZIndex = 46
    GachaSubText.Parent = GachaModal

    local BoxesContainer = Instance.new("Frame")
    BoxesContainer.Size = UDim2.new(1, -36, 0, 225)
    BoxesContainer.Position = UDim2.new(0, 18, 0, 64)
    BoxesContainer.BackgroundTransparency = 1
    BoxesContainer.ZIndex = 46
    BoxesContainer.Parent = GachaModal

    local function CreateMysteryBox(name: string, posXScale: number, posXOffset: number, boxTitle: string)
        local BoxCard = Instance.new("TextButton")
        BoxCard.Name = name
        BoxCard.Size = UDim2.new(0.5, -6, 1, 0)
        BoxCard.Position = UDim2.new(posXScale, posXOffset, 0, 0)
        BoxCard.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
        BoxCard.Text = ""
        BoxCard.AutoButtonColor = false
        BoxCard.ZIndex = 47
        BoxCard.Parent = BoxesContainer
        Instance.new("UICorner", BoxCard).CornerRadius = UDim.new(0, 14)
        local BoxStroke = Instance.new("UIStroke", BoxCard)
        BoxStroke.Color = Color3.fromRGB(45, 52, 68)
        BoxStroke.Thickness = 1

        local Tag5050 = Instance.new("TextLabel")
        Tag5050.Size = UDim2.new(1, -16, 0, 18)
        Tag5050.Position = UDim2.new(0, 8, 0, 8)
        Tag5050.BackgroundColor3 = Color3.fromRGB(28, 33, 44)
        Tag5050.Text = Languages[CurrentLang].Rate5050
        Tag5050.TextColor3 = Color3.fromRGB(226, 232, 240)
        Tag5050.TextSize = 9
        Tag5050.Font = Enum.Font.GothamBold
        Tag5050.ZIndex = 48
        Tag5050.Parent = BoxCard
        Instance.new("UICorner", Tag5050).CornerRadius = UDim.new(0, 6)

        local CropMask = Instance.new("Frame")
        CropMask.Name = "CropMask"
        CropMask.AnchorPoint = Vector2.new(0.5, 0)
        CropMask.Size = UDim2.new(0, 100, 0, 100)
        CropMask.Position = UDim2.new(0.5, 0, 0, 32)
        CropMask.BackgroundTransparency = 1
        CropMask.BorderSizePixel = 0
        CropMask.ClipsDescendants = false
        CropMask.ZIndex = 48
        CropMask.Parent = BoxCard

        local GiftImage = Instance.new("ImageLabel")
        GiftImage.Name = "GiftImage"
        GiftImage.AnchorPoint = Vector2.new(0.5, 0.5)
        GiftImage.Size = UDim2.new(0.85, 0, 0.85, 0)
        GiftImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        GiftImage.BackgroundTransparency = 1
        GiftImage.Image = GiftBoxAssetId
        GiftImage.ScaleType = Enum.ScaleType.Fit
        GiftImage.ZIndex = 49
        GiftImage.Parent = CropMask

        local Aspect = Instance.new("UIAspectRatioConstraint", GiftImage)
        Aspect.AspectRatio = 1

        local Title = Instance.new("TextLabel")
        Title.Name = "BoxTitle"
        Title.Size = UDim2.new(1, 0, 0, 18)
        Title.Position = UDim2.new(0, 0, 0, 138)
        Title.BackgroundTransparency = 1
        Title.Text = boxTitle
        Title.TextColor3 = Color3.fromRGB(248, 250, 252)
        Title.TextSize = 11.5
        Title.Font = Enum.Font.GothamBold
        Title.ZIndex = 48
        Title.Parent = BoxCard

        local ActionHint = Instance.new("TextLabel")
        ActionHint.Name = "ActionHint"
        ActionHint.Size = UDim2.new(1, -20, 0, 26)
        ActionHint.Position = UDim2.new(0, 10, 0, 172)
        ActionHint.BackgroundColor3 = Color3.fromRGB(225, 29, 72)
        ActionHint.Text = Languages[CurrentLang].OpenBoxBtn
        ActionHint.TextColor3 = Color3.fromRGB(255, 255, 255)
        ActionHint.TextSize = 10.5
        ActionHint.Font = Enum.Font.GothamBold
        ActionHint.ZIndex = 48
        ActionHint.Parent = BoxCard
        Instance.new("UICorner", ActionHint).CornerRadius = UDim.new(0, 8)

        return BoxCard, BoxStroke, CropMask, Title, ActionHint, Tag5050
    end

    local Box1, Box1Stroke, Box1Mask, Box1Title, Box1Hint, Box1Tag = CreateMysteryBox("Box1", 0, 0, Languages[CurrentLang].Box1Name)
    local Box2, Box2Stroke, Box2Mask, Box2Title, Box2Hint, Box2Tag = CreateMysteryBox("Box2", 0.5, 6, Languages[CurrentLang].Box2Name)

    local GachaResultBanner = Instance.new("TextLabel")
    GachaResultBanner.Size = UDim2.new(1, -36, 0, 36)
    GachaResultBanner.Position = UDim2.new(0, 18, 0, 298)
    GachaResultBanner.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    GachaResultBanner.Text = Languages[CurrentLang].BoxBannerIdle
    GachaResultBanner.TextColor3 = Color3.fromRGB(226, 232, 240)
    GachaResultBanner.TextSize = 10.5
    GachaResultBanner.Font = Enum.Font.GothamMedium
    GachaResultBanner.ZIndex = 46
    GachaResultBanner.Parent = GachaModal
    Instance.new("UICorner", GachaResultBanner).CornerRadius = UDim.new(0, 10)
  -- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 5/6)
--   GIAO DIỆN VÒNG QUAY 4 Ô BẰNG NHAU · THUẬT TOÁN QUAY 50/30/18/2
-- =========================================================================

    local SpinModal = Instance.new("Frame")
    SpinModal.Name = "SpinModal"
    SpinModal.Size = UDim2.new(1, 0, 1, 0)
    SpinModal.Position = UDim2.new(0, 0, 1, 0)
    SpinModal.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    SpinModal.ZIndex = 55
    SpinModal.ClipsDescendants = true
    SpinModal.Parent = MainFrame
    Instance.new("UICorner", SpinModal).CornerRadius = UDim.new(0, 18)

    local SpinHeader = Instance.new("TextLabel")
    SpinHeader.Size = UDim2.new(1, -60, 0, 24)
    SpinHeader.Position = UDim2.new(0, 18, 0, 12)
    SpinHeader.BackgroundTransparency = 1
    SpinHeader.Text = Languages[CurrentLang].SpinTitle
    SpinHeader.TextColor3 = Color3.fromRGB(253, 224, 71)
    SpinHeader.TextSize = 12
    SpinHeader.Font = Enum.Font.GothamBold
    SpinHeader.TextXAlignment = Enum.TextXAlignment.Left
    SpinHeader.ZIndex = 56
    SpinHeader.Parent = SpinModal

    local SpinCloseBtn = Instance.new("TextButton")
    SpinCloseBtn.Size = UDim2.new(0, 26, 0, 26)
    SpinCloseBtn.Position = UDim2.new(1, -36, 0, 12)
    SpinCloseBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    SpinCloseBtn.Text = "✕"
    SpinCloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
    SpinCloseBtn.TextSize = 11
    SpinCloseBtn.Font = Enum.Font.GothamBold
    SpinCloseBtn.ZIndex = 56
    SpinCloseBtn.Parent = SpinModal
    Instance.new("UICorner", SpinCloseBtn).CornerRadius = UDim.new(0, 6)

    local SpinSubText = Instance.new("TextLabel")
    SpinSubText.Size = UDim2.new(1, -36, 0, 18)
    SpinSubText.Position = UDim2.new(0, 18, 0, 36)
    SpinSubText.BackgroundTransparency = 1
    SpinSubText.Text = Languages[CurrentLang].SpinSub
    SpinSubText.TextColor3 = Color3.fromRGB(148, 163, 184)
    SpinSubText.TextSize = 10
    SpinSubText.Font = Enum.Font.GothamMedium
    SpinSubText.TextXAlignment = Enum.TextXAlignment.Left
    SpinSubText.ZIndex = 56
    SpinSubText.Parent = SpinModal

    local WheelBoard = Instance.new("Frame")
    WheelBoard.Size = UDim2.new(1, -36, 0, 210)
    WheelBoard.Position = UDim2.new(0, 18, 0, 58)
    WheelBoard.BackgroundColor3 = Color3.fromRGB(19, 22, 30)
    WheelBoard.ZIndex = 56
    WheelBoard.Parent = SpinModal
    Instance.new("UICorner", WheelBoard).CornerRadius = UDim.new(0, 16)
    local BoardStroke = Instance.new("UIStroke", WheelBoard)
    BoardStroke.Color = Color3.fromRGB(42, 48, 62)
    BoardStroke.Thickness = 1

    local function CreateWheelSlot(posScaleX: number, posOffsetX: number, posScaleY: number, posOffsetY: number, iconTxt: string, titleTxt: string)
        local Slot = Instance.new("Frame")
        Slot.Size = UDim2.new(0.5, -14, 0.5, -14)
        Slot.Position = UDim2.new(posScaleX, posOffsetX, posScaleY, posOffsetY)
        Slot.BackgroundColor3 = Color3.fromRGB(25, 29, 40)
        Slot.ZIndex = 57
        Slot.Parent = WheelBoard
        Instance.new("UICorner", Slot).CornerRadius = UDim.new(0, 12)

        local SlotStroke = Instance.new("UIStroke", Slot)
        SlotStroke.Color = Color3.fromRGB(52, 60, 78)
        SlotStroke.Thickness = 1.4

        local RateBadge = Instance.new("TextLabel")
        RateBadge.Size = UDim2.new(0, 56, 0, 15)
        RateBadge.Position = UDim2.new(1, -62, 0, 6)
        RateBadge.BackgroundColor3 = Color3.fromRGB(34, 40, 54)
        RateBadge.Text = "50% - 50%"
        RateBadge.TextColor3 = Color3.fromRGB(226, 232, 240)
        RateBadge.TextSize = 8.5
        RateBadge.Font = Enum.Font.GothamBold
        RateBadge.ZIndex = 58
        RateBadge.Parent = Slot
        Instance.new("UICorner", RateBadge).CornerRadius = UDim.new(0, 4)

        local IconLbl = Instance.new("TextLabel")
        IconLbl.Size = UDim2.new(0, 32, 0, 32)
        IconLbl.Position = UDim2.new(0, 10, 0, 10)
        IconLbl.BackgroundTransparency = 1
        IconLbl.Text = iconTxt
        IconLbl.TextSize = 20
        IconLbl.ZIndex = 58
        IconLbl.Parent = Slot

        local MainLbl = Instance.new("TextLabel")
        MainLbl.Size = UDim2.new(1, -20, 0, 22)
        MainLbl.Position = UDim2.new(0, 10, 0, 44)
        MainLbl.BackgroundTransparency = 1
        MainLbl.Text = titleTxt
        MainLbl.TextColor3 = Color3.fromRGB(248, 250, 252)
        MainLbl.TextSize = 14
        MainLbl.Font = Enum.Font.GothamBold
        MainLbl.TextXAlignment = Enum.TextXAlignment.Left
        MainLbl.ZIndex = 58
        MainLbl.Parent = Slot

        local SubLbl = Instance.new("TextLabel")
        SubLbl.Size = UDim2.new(1, -20, 0, 14)
        SubLbl.Position = UDim2.new(0, 10, 0, 66)
        SubLbl.BackgroundTransparency = 1
        SubLbl.Text = Languages[CurrentLang].PrizeSub
        SubLbl.TextColor3 = Color3.fromRGB(148, 163, 184)
        SubLbl.TextSize = 9.5
        SubLbl.Font = Enum.Font.GothamMedium
        SubLbl.TextXAlignment = Enum.TextXAlignment.Left
        SubLbl.ZIndex = 58
        SubLbl.Parent = Slot

        return Slot, SlotStroke, MainLbl, SubLbl
    end

    local Slot1, Stroke1, Title1, Sub1 = CreateWheelSlot(0, 10, 0, 10, "⏱️", Languages[CurrentLang].Prize2H)
    local Slot2, Stroke2, Title2, Sub2 = CreateWheelSlot(0.5, 4, 0, 10, "⚡", Languages[CurrentLang].Prize3H)
    local Slot3, Stroke3, Title3, Sub3 = CreateWheelSlot(0.5, 4, 0.5, 4, "💎", Languages[CurrentLang].Prize4H)
    local Slot4, Stroke4, Title4, Sub4 = CreateWheelSlot(0, 10, 0.5, 4, "👑", Languages[CurrentLang].Prize12H)

    local WheelSlots = {
        { Frame = Slot1, Stroke = Stroke1, Title = Title1, Sub = Sub1, Hours = 2, MsgKey = "Msg2H" },
        { Frame = Slot2, Stroke = Stroke2, Title = Title2, Sub = Sub2, Hours = 3, MsgKey = "Msg3H" },
        { Frame = Slot3, Stroke = Stroke3, Title = Title3, Sub = Sub3, Hours = 4, MsgKey = "Msg4H" },
        { Frame = Slot4, Stroke = Stroke4, Title = Title4, Sub = Sub4, Hours = 12, MsgKey = "Msg12H" }
    }

    local CenterSpinBtn = Instance.new("TextButton")
    CenterSpinBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterSpinBtn.Size = UDim2.new(0, 88, 0, 88)
    CenterSpinBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterSpinBtn.BackgroundColor3 = (not initSpin.Played) and Color3.fromRGB(225, 29, 72) or Color3.fromRGB(38, 43, 56)
    CenterSpinBtn.Text = (not initSpin.Played) and ("🎡\n" .. Languages[CurrentLang].SpinBtnText) or ("🔒\n" .. Languages[CurrentLang].SpinDoneText)
    CenterSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CenterSpinBtn.TextSize = 11
    CenterSpinBtn.Font = Enum.Font.GothamBold
    CenterSpinBtn.AutoButtonColor = false
    CenterSpinBtn.ZIndex = 60
    CenterSpinBtn.Parent = WheelBoard
    Instance.new("UICorner", CenterSpinBtn).CornerRadius = UDim.new(1, 0)

    local CenterSpinStroke = Instance.new("UIStroke", CenterSpinBtn)
    CenterSpinStroke.Color = Color3.fromRGB(253, 224, 71)
    CenterSpinStroke.Thickness = 2.2

    local SpinResultBanner = Instance.new("TextLabel")
    SpinResultBanner.Size = UDim2.new(1, -36, 0, 40)
    SpinResultBanner.Position = UDim2.new(0, 18, 0, 276)
    SpinResultBanner.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    SpinResultBanner.Text = initSpin.Played and string.format("✔ Hôm nay bạn đã quay trúng +%d giờ thời gian sử dụng Key!", initSpin.BonusHours) or "✨ Bấm nút QUAY NGAY ở giữa vòng quay để nhận giờ sử dụng miễn phí!"
    SpinResultBanner.TextColor3 = initSpin.Played and Color3.fromRGB(74, 222, 128) or Color3.fromRGB(248, 250, 252)
    SpinResultBanner.TextSize = 10.5
    SpinResultBanner.Font = Enum.Font.GothamBold
    SpinResultBanner.TextWrapped = true
    SpinResultBanner.ZIndex = 56
    SpinResultBanner.Parent = SpinModal
    Instance.new("UICorner", SpinResultBanner).CornerRadius = UDim.new(0, 10)
    local SpinBannerStroke = Instance.new("UIStroke", SpinResultBanner)
    SpinBannerStroke.Color = Color3.fromRGB(42, 48, 62)
    SpinBannerStroke.Thickness = 1

    local SpinFooterNote = Instance.new("TextLabel")
    SpinFooterNote.Size = UDim2.new(1, -36, 0, 34)
    SpinFooterNote.Position = UDim2.new(0, 18, 0, 322)
    SpinFooterNote.BackgroundTransparency = 1
    SpinFooterNote.Text = Languages[CurrentLang].SpinNote
    SpinFooterNote.TextColor3 = Color3.fromRGB(148, 163, 184)
    SpinFooterNote.TextSize = 10
    SpinFooterNote.Font = Enum.Font.GothamMedium
    SpinFooterNote.TextWrapped = true
    SpinFooterNote.ZIndex = 56
    SpinFooterNote.Parent = SpinModal

    local isRollingMutex = false
    local isSpinningMutex = false

    local function OpenGachaModal()
        TweenService:Create(GachaModal, TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    end
    local function CloseGachaModal()
        TweenService:Create(GachaModal, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(0, 0, 1, 0) }):Play()
    end
    local function OpenSpinModal()
        TweenService:Create(SpinModal, TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    end
    local function CloseSpinModal()
        TweenService:Create(SpinModal, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(0, 0, 1, 0) }):Play()
    end

    GachaCloseBtn.MouseButton1Click:Connect(function()
        if isRollingMutex then return end
        PlaySpringButton(GachaCloseBtn)
        CloseGachaModal()
    end)

    SpinCloseBtn.MouseButton1Click:Connect(function()
        if isSpinningMutex then return end
        PlaySpringButton(SpinCloseBtn)
        CloseSpinModal()
    end)

    MiniGameBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(MiniGameBtn)
        if not CanPlayGachaToday() then
            local secsLeft = GetSecondsUntilMidnightGMT7()
            local hoursLeft = math.floor(secsLeft / 3600)
            local minsLeft = math.floor((secsLeft % 3600) / 60)
            StatusMsg.Text = string.format("⏳ Hộp quà đã mở hôm nay! Reset sau %02d:%02d (00:00)", hoursLeft, minsLeft)
            StatusMsg.TextColor3 = Color3.fromRGB(244, 63, 94)
            return
        end
        OpenGachaModal()
    end)

    SpinGameBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(SpinGameBtn)
        OpenSpinModal()
    end)

    -- XỬ LÝ VÒNG QUAY MAY MẮN: 50% (+2H) | 30% (+3H) | 18% (+4H) | 2% (+12H)
    CenterSpinBtn.MouseButton1Click:Connect(function()
        if isSpinningMutex then return end
        local currentSpin = LoadSpinDataToday()
        if currentSpin.Played then
            local secsLeft = GetSecondsUntilMidnightGMT7()
            local h = math.floor(secsLeft / 3600)
            local m = math.floor((secsLeft % 3600) / 60)
            SpinResultBanner.Text = string.format("⏳ Bạn đã quay hôm nay (+%dH)! Vòng quay hồi lại sau %02d:%02d (00:00)", currentSpin.BonusHours, h, m)
            SpinResultBanner.TextColor3 = Color3.fromRGB(244, 63, 94)
            return
        end

        isSpinningMutex = true
        PlaySpringButton(CenterSpinBtn)

        local roll = math.random(1, 100)
        local targetIndex = 1
        if roll <= 50 then
            targetIndex = 1 -- +2 tiếng (50%)
        elseif roll <= 80 then
            targetIndex = 2 -- +3 giờ (30%)
        elseif roll <= 98 then
            targetIndex = 3 -- +4 giờ (18%)
        else
            targetIndex = 4 -- +12 giờ (2%)
        end

        local wonSlot = WheelSlots[targetIndex]
        SaveSpinResult(wonSlot.Hours, false)

        local activeKeyLeft = GetKeyRemainingTime()
        if activeKeyLeft and activeKeyLeft > 0 then
            Save24hKey(activeKeyLeft)
        end

        SpinGameBtn.Text = string.format(Languages[CurrentLang].MiniGameSpinLocked, wonSlot.Hours)
        SpinGameBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
        SpinGameBtn.TextColor3 = Color3.fromRGB(100, 116, 139)
        SpinGameStroke.Color = Color3.fromRGB(38, 43, 56)

        CenterSpinBtn.Text = "⏳\n" .. Languages[CurrentLang].SpinningText
        CenterSpinBtn.BackgroundColor3 = Color3.fromRGB(217, 119, 6)
        SpinResultBanner.Text = "🎡 Vòng quay đang chạy... Chúc bạn thật nhiều may mắn!"
        SpinResultBanner.TextColor3 = Color3.fromRGB(253, 224, 71)

        local totalSteps = (4 * 5) + targetIndex
        local currentHighlight = 1

        for step = 1, totalSteps do
            currentHighlight = ((step - 1) % 4) + 1
            for idx, s in ipairs(WheelSlots) do
                if idx == currentHighlight then
                    s.Frame.BackgroundColor3 = Color3.fromRGB(48, 24, 38)
                    s.Stroke.Color = Color3.fromRGB(253, 224, 71)
                    s.Stroke.Thickness = 2.2
                else
                    s.Frame.BackgroundColor3 = Color3.fromRGB(25, 29, 40)
                    s.Stroke.Color = Color3.fromRGB(52, 60, 78)
                    s.Stroke.Thickness = 1.4
                end
            end

            local progress = step / totalSteps
            local delayTime = 0.04 + (progress * progress * 0.24)
            task.wait(delayTime)
        end

        wonSlot.Frame.BackgroundColor3 = Color3.fromRGB(20, 52, 36)
        wonSlot.Stroke.Color = Color3.fromRGB(74, 222, 128)
        wonSlot.Stroke.Thickness = 2.5

        CenterSpinBtn.Text = "✔\n" .. Languages[CurrentLang].SpinDoneText
        CenterSpinBtn.BackgroundColor3 = Color3.fromRGB(22, 163, 74)

        SpinResultBanner.Text = "🎉 " .. Languages[CurrentLang][wonSlot.MsgKey]
        SpinResultBanner.TextColor3 = Color3.fromRGB(74, 222, 128)
        SpinBannerStroke.Color = Color3.fromRGB(34, 197, 94)

        StatusMsg.Text = string.format("🎁 Đã lưu +%d giờ thưởng! Sẽ tự động cộng khi bạn Kích Hoạt Key.", wonSlot.Hours)
        StatusMsg.TextColor3 = Color3.fromRGB(74, 222, 128)

        isSpinningMutex = false
    end)
  -- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 6/6)
--   MỞ HỘP QUÀ (5%/95%) · SỰ KIỆN NÚT · CHUYỂN NGÔN NGỮ · LUỒNG 2 PHÚT
-- =========================================================================

    local function ExecuteBoxRoll(chosenBox: TextButton, otherBox: TextButton, chosenStroke: UIStroke, chosenMask: Frame, chosenTitle: TextLabel, chosenHint: TextLabel)
        if isRollingMutex then return end
        isRollingMutex = true

        SaveGachaPlayed()
        MiniGameBtn.Text = Languages[CurrentLang].MiniGameBoxLocked
        MiniGameBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
        MiniGameBtn.TextColor3 = Color3.fromRGB(100, 116, 139)
        MiniGameStroke.Color = Color3.fromRGB(38, 43, 56)

        TweenService:Create(otherBox, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { BackgroundTransparency = 0.65 }):Play()
        otherBox.Active = false

        chosenStroke.Color = Color3.fromRGB(245, 158, 11)
        chosenHint.Text = Languages[CurrentLang].OpeningBox
        chosenHint.BackgroundColor3 = Color3.fromRGB(217, 119, 6)
        GachaResultBanner.Text = Languages[CurrentLang].BoxBannerOpening
        GachaResultBanner.TextColor3 = Color3.fromRGB(253, 224, 71)

        for i = 1, 6 do
            local angle = (i % 2 == 0) and 5 or -5
            TweenService:Create(chosenMask, TweenInfo.new(0.06, Enum.EasingStyle.Quad), { Rotation = angle }):Play()
            task.wait(0.065)
        end
        TweenService:Create(chosenMask, TweenInfo.new(0.08, Enum.EasingStyle.Back), { Rotation = 0 }):Play()
        task.wait(0.2)

        -- TỈ LỆ MỚI: 5% NOKEY (<= 5) VÀ 95% GETKEY (> 5)
        local roll = math.random(1, 100)
        local isNoKeyWon = (roll <= 5)

        if isNoKeyWon then
            chosenStroke.Color = Color3.fromRGB(34, 197, 94)
            chosenTitle.Text = Languages[CurrentLang].BoxWonTitle
            chosenTitle.TextColor3 = Color3.fromRGB(74, 222, 128)
            chosenHint.Text = Languages[CurrentLang].BoxWonBtn
            chosenHint.BackgroundColor3 = Color3.fromRGB(22, 163, 74)

            GachaResultBanner.Text = Languages[CurrentLang].BoxWonBanner
            GachaResultBanner.TextColor3 = Color3.fromRGB(74, 222, 128)

            Save24hKey(GetSecondsUntilMidnightGMT7())

            task.wait(1.2)
            RemoveScreenLockdown()
            LaunchTargetScriptWithWatcher()

            TweenService:Create(MainScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.8 }):Play()
            task.wait(0.2)
            ScreenGui:Destroy()
        else
            chosenStroke.Color = Color3.fromRGB(225, 29, 72)
            chosenTitle.Text = Languages[CurrentLang].BoxLostTitle
            chosenTitle.TextColor3 = Color3.fromRGB(251, 113, 133)
            chosenHint.Text = Languages[CurrentLang].BoxLostBtn
            chosenHint.BackgroundColor3 = Color3.fromRGB(159, 18, 57)

            GachaResultBanner.Text = Languages[CurrentLang].BoxLostBanner
            GachaResultBanner.TextColor3 = Color3.fromRGB(251, 113, 133)

            task.wait(1.5)
            CloseGachaModal()
            isRollingMutex = false

            StatusMsg.Text = "📌 Mở trúng GetKey! Bấm 'Lấy Key (24 Tiếng)' để tiếp tục."
            StatusMsg.TextColor3 = Color3.fromRGB(251, 113, 133)
        end
    end

    Box1.MouseButton1Click:Connect(function()
        ExecuteBoxRoll(Box1, Box2, Box1Stroke, Box1Mask, Box1Title, Box1Hint)
    end)

    Box2.MouseButton1Click:Connect(function()
        ExecuteBoxRoll(Box2, Box1, Box2Stroke, Box2Mask, Box2Title, Box2Hint)
    end)

    QuickPasteBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(QuickPasteBtn)
        local pasted = false
        pcall(function()
            if getclipboard then
                InputBox.Text = getclipboard()
                pasted = true
            elseif fromclipboard then
                InputBox.Text = fromclipboard()
                pasted = true
            end
        end)
        if not pasted then
            InputBox:CaptureFocus()
        end
    end)

    local isTutorialDebounce = false
    TutorialBtn.MouseButton1Click:Connect(function()
        if isTutorialDebounce then return end
        isTutorialDebounce = true
        PlaySpringButton(TutorialBtn)

        if setclipboard then setclipboard(TutorialUrl) elseif toclipboard then toclipboard(TutorialUrl) end

        TutorialBtn.Text = "✔ Đã chép link HD"
        TutorialBtn.TextColor3 = Color3.fromRGB(52, 211, 153)
        StatusMsg.Text = Languages[CurrentLang].CopiedTutorial
        StatusMsg.TextColor3 = Color3.fromRGB(52, 211, 153)

        task.delay(2.2, function()
            if TutorialBtn and TutorialBtn.Parent then
                TutorialBtn.Text = Languages[CurrentLang].Tutorial
                TutorialBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
                StatusMsg.Text = "Chilli Hub V5 • Steal An Egg 🥚 • by ronnei7.htk"
                StatusMsg.TextColor3 = Color3.fromRGB(100, 116, 139)
            end
            isTutorialDebounce = false
        end)
    end)

    GetKeyBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(GetKeyBtn)
        if setclipboard then setclipboard(KeyUrl) elseif toclipboard then toclipboard(KeyUrl) end

        GetKeyBtn.Text = "✔ Đã Chép Link (24H)"
        GetKeyBtn.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
        StatusMsg.Text = Languages[CurrentLang].CopiedLink
        StatusMsg.TextColor3 = Color3.fromRGB(52, 211, 153)

        task.delay(2.2, function()
            if GetKeyBtn and GetKeyBtn.Parent then
                GetKeyBtn.Text = Languages[CurrentLang].GetKey
                GetKeyBtn.BackgroundColor3 = Color3.fromRGB(225, 29, 72)
                StatusMsg.Text = "Chilli Hub V5 • Steal An Egg 🥚 • by ronnei7.htk"
                StatusMsg.TextColor3 = Color3.fromRGB(100, 116, 139)
            end
        end)
    end)

    local isChecking = false
    CheckKeyBtn.MouseButton1Click:Connect(function()
        if isChecking then return end
        isChecking = true
        PlaySpringButton(CheckKeyBtn)

        CheckKeyBtn.Text = Languages[CurrentLang].Checking
        StatusMsg.Text = Languages[CurrentLang].CheckingMsg
        StatusMsg.TextColor3 = Color3.fromRGB(226, 232, 240)

        task.wait(0.3)
        local isKeyValid = VerifyChilliV5Key(InputBox.Text)

        if isKeyValid then
            local bonusAdded = Save24hKey()
            CheckKeyBtn.Text = "✔ Thành Công"
            CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(22, 163, 74)
            if bonusAdded and bonusAdded > 0 then
                StatusMsg.Text = string.format("✔ Kích hoạt thành công! (24H + %dH Vòng Quay = %d Giờ)", bonusAdded, 24 + bonusAdded)
            else
                StatusMsg.Text = Languages[CurrentLang].Success
            end
            StatusMsg.TextColor3 = Color3.fromRGB(74, 222, 128)

            RemoveScreenLockdown()
            LaunchTargetScriptWithWatcher()

            task.wait(0.4)
            TweenService:Create(MainScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.8 }):Play()
            task.wait(0.2)
            ScreenGui:Destroy()
        else
            isChecking = false
            CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
            StatusMsg.Text = Languages[CurrentLang].Error
            StatusMsg.TextColor3 = Color3.fromRGB(244, 63, 94)

            InputStroke.Color = Color3.fromRGB(225, 29, 72)
            local origOffset = MainFrame.Position.X.Offset
            for _, off in ipairs({ -6, 6, -4, 4, -2, 2, 0 }) do
                local t = TweenService:Create(MainFrame, TweenInfo.new(0.04, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(0.5, off, 0.5, 0)
                })
                t:Play()
                t.Completed:Wait()
            end
            MainFrame.Position = UDim2.new(0.5, origOffset, 0.5, 0)
            task.wait(0.5)
            InputStroke.Color = Color3.fromRGB(42, 48, 62)
        end
    end)

    -- ĐỔI NGÔN NGỮ SONG NGỮ TOÀN DIỆN (VI <-> EN)
    OpenLangBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(OpenLangBtn)
        CurrentLang = (CurrentLang == "VI") and "EN" or "VI"
        local data = Languages[CurrentLang]
        local sp = LoadSpinDataToday()

        OpenLangBtn.Text = data.LangBtnText
        TitleLabel.Text = data.Title
        SubTitleLabel.Text = data.Subtitle
        CenterTitle.Text = data.CenterTitle
        CenterSub.Text = data.CenterSub
        InputBox.PlaceholderText = data.Placeholder
        QuickPasteBtn.Text = data.QuickPaste
        GetKeyBtn.Text = data.GetKey
        CheckKeyBtn.Text = data.CheckKey
        TutorialBtn.Text = data.Tutorial
        MiniGameBtn.Text = CanPlayGachaToday() and data.MiniGameBox or data.MiniGameBoxLocked
        SpinGameBtn.Text = (not sp.Played) and data.MiniGameSpin or string.format(data.MiniGameSpinLocked, sp.BonusHours)
        NoticeText.Text = data.Notice

        GachaHeader.Text = data.GachaTitle
        GachaSubText.Text = data.GachaSub
        Box1Tag.Text = data.Rate5050
        Box2Tag.Text = data.Rate5050
        Box1Title.Text = data.Box1Name
        Box2Title.Text = data.Box2Name
        Box1Hint.Text = data.OpenBoxBtn
        Box2Hint.Text = data.OpenBoxBtn
        GachaResultBanner.Text = data.BoxBannerIdle

        SpinHeader.Text = data.SpinTitle
        SpinSubText.Text = data.SpinSub
        SpinFooterNote.Text = data.SpinNote
        Title1.Text = data.Prize2H
        Title2.Text = data.Prize3H
        Title3.Text = data.Prize4H
        Title4.Text = data.Prize12H
        Sub1.Text = data.PrizeSub
        Sub2.Text = data.PrizeSub
        Sub3.Text = data.PrizeSub
        Sub4.Text = data.PrizeSub
        CenterSpinBtn.Text = (not sp.Played) and ("🎡\n" .. data.SpinBtnText) or ("🔒\n" .. data.SpinDoneText)
    end)

    MainFrame.BackgroundTransparency = 1
    MainScale.Scale = 0.85
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(MainScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1.0 }):Play()
end

-- =========================================================================
--   LUỒNG CHÍNH: DÙNG THỬ 2 PHÚT & KHÓA MÀN HÌNH TỰ ĐỘNG
-- =========================================================================

local keyTimeLeft = GetKeyRemainingTime()
if keyTimeLeft and keyTimeLeft > 0 then
    ShowLiveToast("CHILLI HUB V5 (KEY ACTIVE)", keyTimeLeft, Color3.fromRGB(225, 29, 72))
    LaunchTargetScriptWithWatcher()
    return
end

local trialData = LoadTrialData()

if not trialData then
    trialData = { StartTime = os.time(), LastSeen = os.time() }
    SaveTrialData(trialData.StartTime, trialData.LastSeen)
end

if trialData.Tampered then
    ApplyScreenLockdown()
    ShowLiveToast("PHÁT HIỆN CHỈNH GIỜ THIẾT BỊ", 0, Color3.fromRGB(239, 68, 68))
    OpenKeySystemUI()
    return
end

local targetEndTime = trialData.StartTime + TRIAL_DURATION
local remaining = targetEndTime - os.time()

if remaining <= 0 then
    ApplyScreenLockdown()
    ShowLiveToast("HẾT THỜI GIAN DÙNG THỬ (2 PHÚT)", 0, Color3.fromRGB(225, 29, 72))
    OpenKeySystemUI()
    return
else
    ShowLiveToast("CHILLI HUB V5 (DÙNG THỬ 2 PHÚT)", remaining, Color3.fromRGB(225, 29, 72))
    LaunchTargetScriptWithWatcher()

    task.spawn(function()
        local saveInterval = 0

        while true do
            task.wait(1)
            local currentRemaining = targetEndTime - os.time()

            if ActiveToastLabel and ActiveToastLabel.Parent then
                ActiveToastLabel.Text = "Thời gian dùng thử: " .. FormatTime(currentRemaining)
            end

            saveInterval = saveInterval + 1
            if saveInterval >= 10 then
                saveInterval = 0
                SaveTrialData(trialData.StartTime, os.time())
            end

            if GetKeyRemainingTime() then return end

            if currentRemaining <= 0 then
                SaveTrialData(trialData.StartTime, os.time())
                TerminateTargetScript()
                ApplyScreenLockdown()
                ShowLiveToast("HẾT THỜI GIAN DÙNG THỬ (2 PHÚT)", 0, Color3.fromRGB(225, 29, 72))
                task.wait(0.25)
                OpenKeySystemUI()
                break
            end
        end
    end)
end
