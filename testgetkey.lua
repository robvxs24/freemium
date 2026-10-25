-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 1/6)
--   BẢO MẬT 3 TẦNG CHỐNG XÓA FILE · ĐỒNG BỘ 00:00 GMT+7 · ZERO-LAG
-- =========================================================================

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local LogService = game:GetService("LogService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local KeyUrl = "https://link4m.net/m2JAFv"
local TutorialUrl = "https://craftvip.github.io/free/getkey.html"
local TargetScriptUrl = "https://luauforge-antiraw.netlify.app/raw/b2GaCbtITNxIA6Qayyauq1a"

local ChilliAvatarId = "rbxassetid://92622270383869"  -- Hình quả ớt ngoài Menu
local GiftBoxAssetId = "rbxassetid://115116611981430" -- Hình hộp quà bên trong

local TRIAL_DURATION = 120 -- Dùng thử 2 phút (120 giây)
local SystemTerminated = false
local ActiveBlurEffect = nil
local InputBlockerScreen = nil
local OpenKeySystemUI = nil

-- DANH SÁCH FILE ĐỒNG BỘ ĐA ĐIỂM (XÓA FILE NÀY TỰ PHỤC HỒI TỪ FILE KIA & RAM)
local VaultFiles = {
    "ChilliV5_AuthCache.json",
    "rbx_telemetry_cache.dat",
    "core_shader_state.bin"
}
local ATTR_NAME = "RBX_Engine_State_" .. tostring(LocalPlayer.UserId % 9973)

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({ GiftBoxAssetId, ChilliAvatarId })
    end)
end)

-- MÃ HÓA HEX-XOR GẮN KÈM USERID (CHỐNG COPY FILE GIỮA CÁC TÀI KHOẢN)
local CIPHER_KEY = (LocalPlayer.UserId % 199) + 37

local function EncryptVault(str: string): string
    local hex = {}
    for i = 1, #str do
        local k = (CIPHER_KEY + i * 7) % 255
        table.insert(hex, string.format("%02X", bit32.bxor(string.byte(str, i), k)))
    end
    return table.concat(hex)
end

local function DecryptVault(hexStr: string): string?
    if type(hexStr) ~= "string" or #hexStr == 0 or (#hexStr % 2 ~= 0) then return nil end
    local res = {}
    local idx = 1
    for i = 1, #hexStr, 2 do
        local b = tonumber(hexStr:sub(i, i + 1), 16)
        if not b then return nil end
        local k = (CIPHER_KEY + idx * 7) % 255
        table.insert(res, string.char(bit32.bxor(b, k)))
        idx += 1
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

-- HỆ THỐNG ĐỌC/GHI VAULT 3 TẦNG TỰ PHỤC HỒI KHI BỊ XÓA FILE
local function SaveUnifiedVault(vaultTable: table)
    local ok, json = pcall(function() return HttpService:JSONEncode(vaultTable) end)
    if not ok or not json then return end
    local encrypted = EncryptVault(json)

    -- Tầng 1: Lưu vào RAM Global của Executor
    if getgenv then
        getgenv()._CHILLI_V5_VAULT = encrypted
    end

    -- Tầng 2: Lưu vào Attribute ẩn của Roblox Service (Xóa file cũng không mất)
    pcall(function() LogService:SetAttribute(ATTR_NAME, encrypted) end)
    pcall(function() CoreGui:SetAttribute(ATTR_NAME, encrypted) end)

    -- Tầng 3: Ghi đồng loạt ra các file phân tán
    if writefile then
        for _, fName in ipairs(VaultFiles) do
            pcall(function() writefile(fName, encrypted) end)
        end
    end
end

local function LoadUnifiedVault(): table
    local candidates = {}

    if getgenv and type(getgenv()._CHILLI_V5_VAULT) == "string" then
        table.insert(candidates, getgenv()._CHILLI_V5_VAULT)
    end
    pcall(function()
        local a1 = LogService:GetAttribute(ATTR_NAME)
        if type(a1) == "string" then table.insert(candidates, a1) end
        local a2 = CoreGui:GetAttribute(ATTR_NAME)
        if type(a2) == "string" then table.insert(candidates, a2) end
    end)

    if isfile and readfile then
        for _, fName in ipairs(VaultFiles) do
            pcall(function()
                if isfile(fName) then
                    local raw = readfile(fName)
                    if raw and raw ~= "" then
                        table.insert(candidates, raw)
                    end
                end
            end)
        end
    end

    for _, enc in ipairs(candidates) do
        local dec = DecryptVault(enc)
        if dec then
            local ok, data = pcall(function() return HttpService:JSONDecode(dec) end)
            if ok and type(data) == "table" then
                -- Tự động khôi phục lại toàn bộ các file nếu người dùng vừa xóa 1 file
                SaveUnifiedVault(data)
                return data
            end
        end
    end

    return {}
end
-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 2/6)
--   QUẢN LÝ TRẠNG THÁI · CHỐNG HIỆN TƯỢNG GIẬT LAG · CHẮN TƯƠNG TÁC TỰ NHIÊN
-- =========================================================================

local function CanPlayGachaToday(): boolean
    local v = LoadUnifiedVault()
    return v.LastGachaDate ~= GetCurrentDateGMT7()
end

local function SaveGachaPlayed()
    local v = LoadUnifiedVault()
    v.LastGachaDate = GetCurrentDateGMT7()
    SaveUnifiedVault(v)
end

local function LoadSpinDataToday(): { Played: boolean, BonusHours: number, Claimed: boolean }
    local v = LoadUnifiedVault()
    if v.LastSpinDate == GetCurrentDateGMT7() then
        return {
            Played = true,
            BonusHours = tonumber(v.BonusHours) or 0,
            Claimed = (v.SpinClaimed == true)
        }
    end
    return { Played = false, BonusHours = 0, Claimed = false }
end

local function SaveSpinResult(bonusHours: number, claimed: boolean)
    local v = LoadUnifiedVault()
    v.LastSpinDate = GetCurrentDateGMT7()
    v.BonusHours = bonusHours
    v.SpinClaimed = claimed
    SaveUnifiedVault(v)
end

local function GetKeyRemainingTime(): number?
    local v = LoadUnifiedVault()
    if v.KeyExpire and type(v.KeyExpire) == "number" then
        local left = v.KeyExpire - os.time()
        if left > 0 then return left end
    end
    return nil
end

local function Save24hKey(customDuration: number?): number
    local v = LoadUnifiedVault()
    local today = GetCurrentDateGMT7()
    local bonusSeconds = 0
    local bonusHours = 0

    if v.LastSpinDate == today and not v.SpinClaimed and (tonumber(v.BonusHours) or 0) > 0 then
        bonusHours = tonumber(v.BonusHours) or 0
        bonusSeconds = bonusHours * 3600
        v.SpinClaimed = true
    end

    v.KeyExpire = os.time() + (customDuration or 86400) + bonusSeconds
    SaveUnifiedVault(v)
    return bonusHours
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

-- CHẮN TƯƠNG TÁC TRONG SUỐT TỰ NHIÊN (KHÔNG CÓ KHUNG ĐEN CÔNG NGHIỆP)
local function ApplyScreenLockdown()
    if not ActiveBlurEffect then
        ActiveBlurEffect = Instance.new("BlurEffect")
        ActiveBlurEffect.Name = "ChilliV5_LockdownBlur"
        ActiveBlurEffect.Size = 15
        ActiveBlurEffect.Parent = Lighting
    end

    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum then
            hum.WalkSpeed = 0
            hum.JumpPower = 0
        end
        if hrp then
            hrp.Anchored = true
        end
    end

    if not InputBlockerScreen then
        InputBlockerScreen = Instance.new("ScreenGui")
        InputBlockerScreen.Name = "ChilliV5_InputBlocker"
        InputBlockerScreen.IgnoreGuiInset = true
        InputBlockerScreen.ResetOnSpawn = false
        pcall(function() InputBlockerScreen.Parent = CoreGui end)
        if not InputBlockerScreen.Parent then InputBlockerScreen.Parent = LocalPlayer:WaitForChild("PlayerGui") end

        -- Nút chắn cảm ứng hoàn toàn trong suốt (BackgroundTransparency = 1)
        local shield = Instance.new("TextButton")
        shield.Size = UDim2.new(1, 0, 1, 0)
        shield.BackgroundTransparency = 1
        shield.Text = ""
        shield.Modal = true
        shield.Active = true
        shield.ZIndex = 10
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
        end
        if hrp then
            hrp.Anchored = false
        end
    end
end

-- TẮT HOÀN TOÀN MENU GETKEY VÀ GIẢI PHÓNG RAM TRƯỚC KHI CHẠY SCRIPT GỐC
local function CleanupAllGetKeyUI()
    RemoveScreenLockdown()
    local containers = { CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }
    for _, c in ipairs(containers) do
        if c then
            for _, uiName in ipairs({ "ChilliV5_GetKeyUI", "ChilliV5_InputBlocker", "ChilliV5_ToastUI" }) do
                local found = c:FindFirstChild(uiName)
                if found then pcall(function() found:Destroy() end) end
            end
        end
    end
end

local function LaunchTargetScriptCleanly(isFullLicense: boolean)
    if isFullLicense then
        SystemTerminated = true -- Ngắt vĩnh viễn mọi tiến trình ngầm của GetKey
        CleanupAllGetKeyUI()
    end
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet(TargetScriptUrl))()
        end)
    end)
end
-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 3/6)
--   TOAST NHẸ NHÀNG · TỪ ĐIỂN SONG NGỮ VI/EN · MÀU SẮC DỊU MẮT KHÔNG CHÓI
-- =========================================================================

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

local function ShowLiveToast(titleText: string, initialSeconds: number)
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
    ToastFrame.Size = UDim2.new(0, 320, 0, 54)
    ToastFrame.Position = UDim2.new(0.5, -160, 0, -70)
    ToastFrame.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
    ToastFrame.BorderSizePixel = 0
    ToastFrame.ZIndex = 50
    ToastFrame.Parent = ToastGui

    Instance.new("UICorner", ToastFrame).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", ToastFrame)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(45, 52, 66)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -24, 0, 18)
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = "🌶️ " .. titleText
    Title.TextColor3 = Color3.fromRGB(226, 232, 240)
    Title.TextSize = 11
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 51
    Title.Parent = ToastFrame

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, -24, 0, 16)
    Msg.Position = UDim2.new(0, 12, 0, 27)
    Msg.BackgroundTransparency = 1
    Msg.Text = "Thời gian còn lại: " .. FormatTime(initialSeconds)
    Msg.TextColor3 = Color3.fromRGB(148, 163, 184)
    Msg.TextSize = 10
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextXAlignment = Enum.TextXAlignment.Left
    Msg.ZIndex = 51
    Msg.Parent = ToastFrame

    ActiveToastLabel = Msg

    TweenService:Create(ToastFrame, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -160, 0, 14) }):Play()

    task.delay(6, function()
        if ToastFrame and ToastFrame.Parent then
            local t = TweenService:Create(ToastFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(0.5, -160, 0, -70) })
            t:Play()
            t.Completed:Connect(function()
                if ToastGui and ToastGui.Parent then ToastGui:Destroy() end
                ActiveToastLabel = nil
            end)
        end
    end)
end

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
        MiniGameBoxLocked = "🔒 Hộp quà (Reset 00:00)",
        MiniGameSpin = "mini game (vòng quay +thời gian sử dụng)",
        MiniGameSpinLocked = "🔒 Đã quay (+%dH) • Reset 00:00",
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
        BoxBannerOpening = "Đang mở hộp quà...",
        BoxWonTitle = "TRÚNG NOKEY!",
        BoxWonBtn = "VÀO SCRIPT",
        BoxWonBanner = "Chúc mừng! Bạn trúng NoKey! Đang tải script...",
        BoxLostTitle = "LÀ HỘP GETKEY",
        BoxLostBtn = "VỀ LẤY KEY",
        BoxLostBanner = "Hộp này là GetKey! Vui lòng vượt link để nhận key nhé.",
        -- Vòng quay tròn
        SpinTitle = "🎡 VÒNG QUAY +THỜI GIAN SỬ DỤNG (1 LẦN/NGÀY)",
        SpinSub = "4 ô trên vòng quay đều có tỉ lệ ngang nhau (50% - 50%)",
        SpinNote = "Ghi chú: sau khi bạn getkey, thời gian bạn quay ra sẽ được cộng vào thời gian key sử dụng của bạn",
        SpinBtnText = "QUAY VÒNG QUAY NGAY",
        SpinningText = "VÒNG QUAY ĐANG CHẠY...",
        SpinDoneText = "HÔM NAY ĐÃ QUAY (RESET 00:00)",
        Prize2H = "+2 TIẾNG",
        Prize3H = "+3 GIỜ",
        Prize4H = "+4 GIỜ",
        Prize12H = "+12 GIỜ",
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
        MiniGameBoxLocked = "🔒 Box Opened (Resets 00:00)",
        MiniGameSpin = "mini game (spin wheel +usage time)",
        MiniGameSpinLocked = "🔒 Spun (+%dH) • Resets 00:00",
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
        BoxBannerOpening = "Opening mystery box...",
        BoxWonTitle = "WON NOKEY!",
        BoxWonBtn = "LAUNCH SCRIPT",
        BoxWonBanner = "Congrats! You won NoKey! Loading script...",
        BoxLostTitle = "IT'S GETKEY",
        BoxLostBtn = "BACK TO GETKEY",
        BoxLostBanner = "This box is GetKey! Please complete the link to get your key.",
        -- Spin Wheel
        SpinTitle = "🎡 +USAGE TIME SPIN WHEEL (1 TIME/DAY)",
        SpinSub = "All 4 sections on the wheel share an equal 50% - 50% rate",
        SpinNote = "Note: after you getkey, the time you spin will be added to your key usage time",
        SpinBtnText = "SPIN THE WHEEL NOW",
        SpinningText = "WHEEL IS SPINNING...",
        SpinDoneText = "SPUN TODAY (RESETS 00:00)",
        Prize2H = "+2 HOURS",
        Prize3H = "+3 HOURS",
        Prize4H = "+4 HOURS",
        Prize12H = "+12 HOURS",
        Msg2H = "Pretty sweet! 😋 (+2 hours added to Key)",
        Msg3H = "Soooo sweet! 😲 (+3 hours added to Key)",
        Msg4H = "Did you know you're luckier than 70% of people?! 🤑 (+4 hours)",
        Msg12H = "Oh my goodness, how can someone in this world be this lucky?! 😱 (+12 hours)"
    }
}
local CurrentLang = "VI"
-- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 4/6)
--   MENU CHÍNH TỐI GIẢN KHÔNG CHÓI · NÚT MINI GAME ĐÚNG TÊN YÊU CẦU
-- =========================================================================

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
    MainFrame.Size = UDim2.new(0, 440, 0, 475)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.ZIndex = 30
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

    local MainScale = Instance.new("UIScale", MainFrame)
    MainScale.Scale = 1.0

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 1
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Color = Color3.fromRGB(38, 43, 54)

    -- HEADER
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, -28, 0, 38)
    HeaderBar.Position = UDim2.new(0, 14, 0, 10)
    HeaderBar.BackgroundTransparency = 1
    HeaderBar.ZIndex = 31
    HeaderBar.Parent = MainFrame

    local MiniLogo = Instance.new("Frame")
    MiniLogo.Size = UDim2.new(0, 28, 0, 28)
    MiniLogo.Position = UDim2.new(0, 0, 0.5, -14)
    MiniLogo.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
    MiniLogo.ClipsDescendants = true
    MiniLogo.ZIndex = 32
    MiniLogo.Parent = HeaderBar
    Instance.new("UICorner", MiniLogo).CornerRadius = UDim.new(1, 0)
    local MiniLogoStroke = Instance.new("UIStroke", MiniLogo)
    MiniLogoStroke.Color = Color3.fromRGB(160, 35, 65)
    MiniLogoStroke.Thickness = 1

    local MiniLogoImg = Instance.new("ImageLabel")
    MiniLogoImg.Size = UDim2.new(1, 0, 1, 0)
    MiniLogoImg.BackgroundTransparency = 1
    MiniLogoImg.Image = ChilliAvatarId
    MiniLogoImg.ScaleType = Enum.ScaleType.Fit
    MiniLogoImg.ZIndex = 33
    MiniLogoImg.Parent = MiniLogo

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 0, 16)
    TitleLabel.Position = UDim2.new(0, 36, 0, 2)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Languages[CurrentLang].Title
    TitleLabel.TextColor3 = Color3.fromRGB(215, 222, 232)
    TitleLabel.TextSize = 11.5
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 32
    TitleLabel.Parent = HeaderBar

    local SubTitleLabel = Instance.new("TextLabel")
    SubTitleLabel.Size = UDim2.new(1, -100, 0, 14)
    SubTitleLabel.Position = UDim2.new(0, 36, 0, 19)
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Text = Languages[CurrentLang].Subtitle
    SubTitleLabel.TextColor3 = Color3.fromRGB(130, 142, 160)
    SubTitleLabel.TextSize = 9.5
    SubTitleLabel.Font = Enum.Font.GothamMedium
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 32
    SubTitleLabel.Parent = HeaderBar

    local OpenLangBtn = Instance.new("TextButton")
    OpenLangBtn.Size = UDim2.new(0, 58, 0, 24)
    OpenLangBtn.Position = UDim2.new(1, -58, 0.5, -12)
    OpenLangBtn.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
    OpenLangBtn.Text = Languages[CurrentLang].LangBtnText
    OpenLangBtn.TextColor3 = Color3.fromRGB(203, 213, 225)
    OpenLangBtn.TextSize = 10
    OpenLangBtn.Font = Enum.Font.GothamBold
    OpenLangBtn.AutoButtonColor = false
    OpenLangBtn.ZIndex = 32
    OpenLangBtn.Parent = HeaderBar
    Instance.new("UICorner", OpenLangBtn).CornerRadius = UDim.new(0, 6)
    local LangStroke = Instance.new("UIStroke", OpenLangBtn)
    LangStroke.Color = Color3.fromRGB(42, 48, 62)
    LangStroke.Thickness = 1

    -- AVATAR QUẢ ỚT CHÍNH GIỮA
    local CenterLogoBox = Instance.new("Frame")
    CenterLogoBox.Size = UDim2.new(0, 48, 0, 48)
    CenterLogoBox.Position = UDim2.new(0.5, -24, 0, 50)
    CenterLogoBox.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
    CenterLogoBox.ClipsDescendants = true
    CenterLogoBox.ZIndex = 31
    CenterLogoBox.Parent = MainFrame
    Instance.new("UICorner", CenterLogoBox).CornerRadius = UDim.new(0, 12)
    local CenterLogoStroke = Instance.new("UIStroke", CenterLogoBox)
    CenterLogoStroke.Color = Color3.fromRGB(160, 35, 65)
    CenterLogoStroke.Thickness = 1

    local CenterLogoImg = Instance.new("ImageLabel")
    CenterLogoImg.Size = UDim2.new(0.88, 0, 0.88, 0)
    CenterLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterLogoImg.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterLogoImg.BackgroundTransparency = 1
    CenterLogoImg.Image = ChilliAvatarId
    CenterLogoImg.ScaleType = Enum.ScaleType.Fit
    CenterLogoImg.ZIndex = 32
    CenterLogoImg.Parent = CenterLogoBox

    local CenterTitle = Instance.new("TextLabel")
    CenterTitle.Size = UDim2.new(1, -30, 0, 18)
    CenterTitle.Position = UDim2.new(0, 15, 0, 102)
    CenterTitle.BackgroundTransparency = 1
    CenterTitle.Text = Languages[CurrentLang].CenterTitle
    CenterTitle.TextColor3 = Color3.fromRGB(226, 232, 240)
    CenterTitle.TextSize = 12.5
    CenterTitle.Font = Enum.Font.GothamBold
    CenterTitle.ZIndex = 31
    CenterTitle.Parent = MainFrame

    local CenterSub = Instance.new("TextLabel")
    CenterSub.Size = UDim2.new(1, -30, 0, 14)
    CenterSub.Position = UDim2.new(0, 15, 0, 120)
    CenterSub.BackgroundTransparency = 1
    CenterSub.Text = Languages[CurrentLang].CenterSub
    CenterSub.TextColor3 = Color3.fromRGB(130, 142, 160)
    CenterSub.TextSize = 9.5
    CenterSub.Font = Enum.Font.GothamMedium
    CenterSub.ZIndex = 31
    CenterSub.Parent = MainFrame

    -- Ô NHẬP KEY + NÚT DÁN NHANH
    local InputContainer = Instance.new("Frame")
    InputContainer.Size = UDim2.new(1, -36, 0, 36)
    InputContainer.Position = UDim2.new(0, 18, 0, 140)
    InputContainer.BackgroundColor3 = Color3.fromRGB(21, 24, 32)
    InputContainer.ZIndex = 31
    InputContainer.Parent = MainFrame
    Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 9)
    local InputStroke = Instance.new("UIStroke", InputContainer)
    InputStroke.Color = Color3.fromRGB(40, 46, 58)
    InputStroke.Thickness = 1

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -72, 1, 0)
    InputBox.Position = UDim2.new(0, 12, 0, 0)
    InputBox.BackgroundTransparency = 1
    InputBox.TextColor3 = Color3.fromRGB(226, 232, 240)
    InputBox.PlaceholderColor3 = Color3.fromRGB(100, 112, 130)
    InputBox.PlaceholderText = Languages[CurrentLang].Placeholder
    InputBox.Text = ""
    InputBox.TextSize = 11
    InputBox.Font = Enum.Font.GothamMedium
    InputBox.TextXAlignment = Enum.TextXAlignment.Left
    InputBox.ClearTextOnFocus = false
    InputBox.ZIndex = 32
    InputBox.Parent = InputContainer

    local QuickPasteBtn = Instance.new("TextButton")
    QuickPasteBtn.Size = UDim2.new(0, 52, 0, 24)
    QuickPasteBtn.Position = UDim2.new(1, -58, 0.5, -12)
    QuickPasteBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 46)
    QuickPasteBtn.Text = Languages[CurrentLang].QuickPaste
    QuickPasteBtn.TextColor3 = Color3.fromRGB(203, 213, 225)
    QuickPasteBtn.TextSize = 10
    QuickPasteBtn.Font = Enum.Font.GothamBold
    QuickPasteBtn.AutoButtonColor = false
    QuickPasteBtn.ZIndex = 33
    QuickPasteBtn.Parent = InputContainer
    Instance.new("UICorner", QuickPasteBtn).CornerRadius = UDim.new(0, 6)

    -- HÀNG NÚT CHÍNH: LẤY KEY & KÍCH HOẠT V5
    local ButtonsRow = Instance.new("Frame")
    ButtonsRow.Size = UDim2.new(1, -36, 0, 38)
    ButtonsRow.Position = UDim2.new(0, 18, 0, 184)
    ButtonsRow.BackgroundTransparency = 1
    ButtonsRow.ZIndex = 31
    ButtonsRow.Parent = MainFrame

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
    GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(190, 24, 60) -- Đỏ trầm không chói
    GetKeyBtn.Text = Languages[CurrentLang].GetKey
    GetKeyBtn.TextColor3 = Color3.fromRGB(241, 245, 249)
    GetKeyBtn.TextSize = 11
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.AutoButtonColor = false
    GetKeyBtn.ZIndex = 32
    GetKeyBtn.Parent = ButtonsRow
    Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 9)

    local CheckKeyBtn = Instance.new("TextButton")
    CheckKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
    CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 0)
    CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
    CheckKeyBtn.TextColor3 = Color3.fromRGB(215, 222, 232)
    CheckKeyBtn.TextSize = 11
    CheckKeyBtn.Font = Enum.Font.GothamBold
    CheckKeyBtn.AutoButtonColor = false
    CheckKeyBtn.ZIndex = 32
    CheckKeyBtn.Parent = ButtonsRow
    Instance.new("UICorner", CheckKeyBtn).CornerRadius = UDim.new(0, 9)
    local CheckStroke = Instance.new("UIStroke", CheckKeyBtn)
    CheckStroke.Color = Color3.fromRGB(48, 56, 72)
    CheckStroke.Thickness = 1

    -- NÚT HƯỚNG DẪN
    local TutorialBtn = Instance.new("TextButton")
    TutorialBtn.Size = UDim2.new(1, -36, 0, 30)
    TutorialBtn.Position = UDim2.new(0, 18, 0, 228)
    TutorialBtn.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    TutorialBtn.Text = Languages[CurrentLang].Tutorial
    TutorialBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
    TutorialBtn.TextSize = 10.5
    TutorialBtn.Font = Enum.Font.GothamBold
    TutorialBtn.AutoButtonColor = false
    TutorialBtn.ZIndex = 32
    TutorialBtn.Parent = MainFrame
    Instance.new("UICorner", TutorialBtn).CornerRadius = UDim.new(0, 8)
    local TutorialStroke = Instance.new("UIStroke", TutorialBtn)
    TutorialStroke.Color = Color3.fromRGB(36, 41, 52)
    TutorialStroke.Thickness = 1

    -- BẢNG LƯU Ý
    local NoticeCard = Instance.new("Frame")
    NoticeCard.Size = UDim2.new(1, -36, 0, 48)
    NoticeCard.Position = UDim2.new(0, 18, 0, 264)
    NoticeCard.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
    NoticeCard.ZIndex = 31
    NoticeCard.Parent = MainFrame
    Instance.new("UICorner", NoticeCard).CornerRadius = UDim.new(0, 9)
    local NoticeStroke = Instance.new("UIStroke", NoticeCard)
    NoticeStroke.Color = Color3.fromRGB(32, 37, 48)
    NoticeStroke.Thickness = 1

    local NoticeText = Instance.new("TextLabel")
    NoticeText.Size = UDim2.new(1, -16, 1, -6)
    NoticeText.Position = UDim2.new(0, 8, 0, 3)
    NoticeText.BackgroundTransparency = 1
    NoticeText.Text = Languages[CurrentLang].Notice
    NoticeText.TextColor3 = Color3.fromRGB(140, 152, 170)
    NoticeText.TextSize = 9.5
    NoticeText.Font = Enum.Font.GothamMedium
    NoticeText.TextWrapped = true
    NoticeText.TextYAlignment = Enum.TextYAlignment.Center
    NoticeText.TextXAlignment = Enum.TextXAlignment.Left
    NoticeText.ZIndex = 32
    NoticeText.Parent = NoticeCard

    -- 2 NÚT MINI GAME XẾP DỌC RÕ RÀNG (HIỂN THỊ TRỌN VẸN TÊN DÀI, CHỮ DỊU MẮT)
    local MiniGameBtn = Instance.new("TextButton")
    MiniGameBtn.Size = UDim2.new(1, -36, 0, 34)
    MiniGameBtn.Position = UDim2.new(0, 18, 0, 320)
    MiniGameBtn.BackgroundColor3 = CanPlayGachaToday() and Color3.fromRGB(23, 26, 36) or Color3.fromRGB(18, 20, 27)
    MiniGameBtn.Text = CanPlayGachaToday() and Languages[CurrentLang].MiniGameBox or Languages[CurrentLang].MiniGameBoxLocked
    MiniGameBtn.TextColor3 = CanPlayGachaToday() and Color3.fromRGB(203, 213, 225) or Color3.fromRGB(100, 112, 130)
    MiniGameBtn.TextSize = 11
    MiniGameBtn.Font = Enum.Font.GothamBold
    MiniGameBtn.AutoButtonColor = false
    MiniGameBtn.ZIndex = 32
    MiniGameBtn.Parent = MainFrame
    Instance.new("UICorner", MiniGameBtn).CornerRadius = UDim.new(0, 9)
    local MiniGameStroke = Instance.new("UIStroke", MiniGameBtn)
    MiniGameStroke.Color = CanPlayGachaToday() and Color3.fromRGB(140, 35, 60) or Color3.fromRGB(36, 41, 52)
    MiniGameStroke.Thickness = 1

    local initSpin = LoadSpinDataToday()
    local SpinGameBtn = Instance.new("TextButton")
    SpinGameBtn.Size = UDim2.new(1, -36, 0, 34)
    SpinGameBtn.Position = UDim2.new(0, 18, 0, 360)
    SpinGameBtn.BackgroundColor3 = (not initSpin.Played) and Color3.fromRGB(23, 26, 36) or Color3.fromRGB(18, 20, 27)
    SpinGameBtn.Text = (not initSpin.Played) and Languages[CurrentLang].MiniGameSpin or string.format(Languages[CurrentLang].MiniGameSpinLocked, initSpin.BonusHours)
    SpinGameBtn.TextColor3 = (not initSpin.Played) and Color3.fromRGB(203, 213, 225) or Color3.fromRGB(100, 112, 130)
    SpinGameBtn.TextSize = 11
    SpinGameBtn.Font = Enum.Font.GothamBold
    SpinGameBtn.AutoButtonColor = false
    SpinGameBtn.ZIndex = 32
    SpinGameBtn.Parent = MainFrame
    Instance.new("UICorner", SpinGameBtn).CornerRadius = UDim.new(0, 9)
    local SpinGameStroke = Instance.new("UIStroke", SpinGameBtn)
    SpinGameStroke.Color = (not initSpin.Played) and Color3.fromRGB(65, 80, 110) or Color3.fromRGB(36, 41, 52)
    SpinGameStroke.Thickness = 1

    local StatusMsg = Instance.new("TextLabel")
    StatusMsg.Size = UDim2.new(1, -36, 0, 18)
    StatusMsg.Position = UDim2.new(0, 18, 0, 402)
    StatusMsg.BackgroundTransparency = 1
    StatusMsg.Text = "Chilli Hub V5 • Steal An Egg 🥚 • by ronnei7.htk"
    StatusMsg.TextColor3 = Color3.fromRGB(100, 112, 130)
    StatusMsg.TextSize = 9.5
    StatusMsg.Font = Enum.Font.GothamMedium
    StatusMsg.ZIndex = 31
    StatusMsg.Parent = MainFrame
    -- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 5/6)
--   MODAL HỘP QUÀ (5/95) · VÒNG QUAY TRÒN BÌNH THƯỜNG XOAY MƯỢT KHÔNG ĐÈ CHỮ
-- =========================================================================

    -- 1. MODAL HỘP QUÀ GACHA
    local GachaModal = Instance.new("Frame")
    GachaModal.Name = "GachaModal"
    GachaModal.Size = UDim2.new(1, 0, 1, 0)
    GachaModal.Position = UDim2.new(0, 0, 1, 0)
    GachaModal.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
    GachaModal.ZIndex = 45
    GachaModal.ClipsDescendants = true
    GachaModal.Parent = MainFrame
    Instance.new("UICorner", GachaModal).CornerRadius = UDim.new(0, 16)

    local GachaHeader = Instance.new("TextLabel")
    GachaHeader.Size = UDim2.new(1, -60, 0, 24)
    GachaHeader.Position = UDim2.new(0, 18, 0, 12)
    GachaHeader.BackgroundTransparency = 1
    GachaHeader.Text = Languages[CurrentLang].GachaTitle
    GachaHeader.TextColor3 = Color3.fromRGB(215, 222, 232)
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
    GachaSubText.Size = UDim2.new(1, -36, 0, 18)
    GachaSubText.Position = UDim2.new(0, 18, 0, 38)
    GachaSubText.BackgroundTransparency = 1
    GachaSubText.Text = Languages[CurrentLang].GachaSub
    GachaSubText.TextColor3 = Color3.fromRGB(130, 142, 160)
    GachaSubText.TextSize = 10
    GachaSubText.Font = Enum.Font.GothamMedium
    GachaSubText.TextXAlignment = Enum.TextXAlignment.Left
    GachaSubText.ZIndex = 46
    GachaSubText.Parent = GachaModal

    local BoxesContainer = Instance.new("Frame")
    BoxesContainer.Size = UDim2.new(1, -36, 0, 235)
    BoxesContainer.Position = UDim2.new(0, 18, 0, 64)
    BoxesContainer.BackgroundTransparency = 1
    BoxesContainer.ZIndex = 46
    BoxesContainer.Parent = GachaModal

    local function CreateMysteryBox(name: string, posXScale: number, posXOffset: number, boxTitle: string)
        local BoxCard = Instance.new("TextButton")
        BoxCard.Name = name
        BoxCard.Size = UDim2.new(0.5, -6, 1, 0)
        BoxCard.Position = UDim2.new(posXScale, posXOffset, 0, 0)
        BoxCard.BackgroundColor3 = Color3.fromRGB(21, 24, 32)
        BoxCard.Text = ""
        BoxCard.AutoButtonColor = false
        BoxCard.ZIndex = 47
        BoxCard.Parent = BoxesContainer
        Instance.new("UICorner", BoxCard).CornerRadius = UDim.new(0, 14)
        local BoxStroke = Instance.new("UIStroke", BoxCard)
        BoxStroke.Color = Color3.fromRGB(42, 48, 62)
        BoxStroke.Thickness = 1

        local Tag5050 = Instance.new("TextLabel")
        Tag5050.Size = UDim2.new(1, -16, 0, 18)
        Tag5050.Position = UDim2.new(0, 8, 0, 8)
        Tag5050.BackgroundColor3 = Color3.fromRGB(28, 32, 42)
        Tag5050.Text = Languages[CurrentLang].Rate5050
        Tag5050.TextColor3 = Color3.fromRGB(185, 195, 210)
        Tag5050.TextSize = 9
        Tag5050.Font = Enum.Font.GothamBold
        Tag5050.ZIndex = 48
        Tag5050.Parent = BoxCard
        Instance.new("UICorner", Tag5050).CornerRadius = UDim.new(0, 6)

        local CropMask = Instance.new("Frame")
        CropMask.Name = "CropMask"
        CropMask.AnchorPoint = Vector2.new(0.5, 0)
        CropMask.Size = UDim2.new(0, 100, 0, 100)
        CropMask.Position = UDim2.new(0.5, 0, 0, 34)
        CropMask.BackgroundTransparency = 1
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
        Title.Position = UDim2.new(0, 0, 0, 142)
        Title.BackgroundTransparency = 1
        Title.Text = boxTitle
        Title.TextColor3 = Color3.fromRGB(215, 222, 232)
        Title.TextSize = 11.5
        Title.Font = Enum.Font.GothamBold
        Title.ZIndex = 48
        Title.Parent = BoxCard

        local ActionHint = Instance.new("TextLabel")
        ActionHint.Name = "ActionHint"
        ActionHint.Size = UDim2.new(1, -20, 0, 26)
        ActionHint.Position = UDim2.new(0, 10, 0, 180)
        ActionHint.BackgroundColor3 = Color3.fromRGB(175, 24, 55)
        ActionHint.Text = Languages[CurrentLang].OpenBoxBtn
        ActionHint.TextColor3 = Color3.fromRGB(241, 245, 249)
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
    GachaResultBanner.Size = UDim2.new(1, -36, 0, 38)
    GachaResultBanner.Position = UDim2.new(0, 18, 0, 312)
    GachaResultBanner.BackgroundColor3 = Color3.fromRGB(21, 24, 32)
    GachaResultBanner.Text = Languages[CurrentLang].BoxBannerIdle
    GachaResultBanner.TextColor3 = Color3.fromRGB(185, 195, 210)
    GachaResultBanner.TextSize = 10.5
    GachaResultBanner.Font = Enum.Font.GothamMedium
    GachaResultBanner.ZIndex = 46
    GachaResultBanner.Parent = GachaModal
    Instance.new("UICorner", GachaResultBanner).CornerRadius = UDim.new(0, 9)

    -- =========================================================================
    --   2. MODAL VÒNG QUAY TRÒN BÌNH THƯỜNG (XOAY MƯỢT 360 ĐỘ, KIM CHỈ ĐỈNH)
    -- =========================================================================
    local SpinModal = Instance.new("Frame")
    SpinModal.Name = "SpinModal"
    SpinModal.Size = UDim2.new(1, 0, 1, 0)
    SpinModal.Position = UDim2.new(0, 0, 1, 0)
    SpinModal.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
    SpinModal.ZIndex = 55
    SpinModal.ClipsDescendants = false
    SpinModal.Parent = MainFrame
    Instance.new("UICorner", SpinModal).CornerRadius = UDim.new(0, 16)

    local SpinHeader = Instance.new("TextLabel")
    SpinHeader.Size = UDim2.new(1, -60, 0, 22)
    SpinHeader.Position = UDim2.new(0, 18, 0, 10)
    SpinHeader.BackgroundTransparency = 1
    SpinHeader.Text = Languages[CurrentLang].SpinTitle
    SpinHeader.TextColor3 = Color3.fromRGB(215, 222, 232)
    SpinHeader.TextSize = 11.5
    SpinHeader.Font = Enum.Font.GothamBold
    SpinHeader.TextXAlignment = Enum.TextXAlignment.Left
    SpinHeader.ZIndex = 56
    SpinHeader.Parent = SpinModal

    local SpinCloseBtn = Instance.new("TextButton")
    SpinCloseBtn.Size = UDim2.new(0, 26, 0, 26)
    SpinCloseBtn.Position = UDim2.new(1, -36, 0, 10)
    SpinCloseBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    SpinCloseBtn.Text = "✕"
    SpinCloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
    SpinCloseBtn.TextSize = 11
    SpinCloseBtn.Font = Enum.Font.GothamBold
    SpinCloseBtn.ZIndex = 56
    SpinCloseBtn.Parent = SpinModal
    Instance.new("UICorner", SpinCloseBtn).CornerRadius = UDim.new(0, 6)

    local SpinSubText = Instance.new("TextLabel")
    SpinSubText.Size = UDim2.new(1, -36, 0, 16)
    SpinSubText.Position = UDim2.new(0, 18, 0, 32)
    SpinSubText.BackgroundTransparency = 1
    SpinSubText.Text = Languages[CurrentLang].SpinSub
    SpinSubText.TextColor3 = Color3.fromRGB(130, 142, 160)
    SpinSubText.TextSize = 9.5
    SpinSubText.Font = Enum.Font.GothamMedium
    SpinSubText.TextXAlignment = Enum.TextXAlignment.Left
    SpinSubText.ZIndex = 56
    SpinSubText.Parent = SpinModal

    -- KHUNG CHỨA VÒNG QUAY TRÒN (ĐƯỜNG KÍNH 186PX)
    local WheelArea = Instance.new("Frame")
    WheelArea.AnchorPoint = Vector2.new(0.5, 0)
    WheelArea.Size = UDim2.new(0, 186, 0, 186)
    WheelArea.Position = UDim2.new(0.5, 0, 0, 56)
    WheelArea.BackgroundTransparency = 1
    WheelArea.ZIndex = 56
    WheelArea.Parent = SpinModal

    -- Kim chỉ cố định ở đỉnh 12 giờ (▼)
    local PointerArrow = Instance.new("TextLabel")
    PointerArrow.AnchorPoint = Vector2.new(0.5, 0.5)
    PointerArrow.Size = UDim2.new(0, 24, 0, 24)
    PointerArrow.Position = UDim2.new(0.5, 0, 0, -2)
    PointerArrow.BackgroundTransparency = 1
    PointerArrow.Text = "▼"
    PointerArrow.TextColor3 = Color3.fromRGB(190, 24, 60)
    PointerArrow.TextSize = 18
    PointerArrow.Font = Enum.Font.GothamBlack
    PointerArrow.ZIndex = 63
    PointerArrow.Parent = WheelArea

    -- Đĩa tròn xoay 360 độ
    local WheelDisc = Instance.new("Frame")
    WheelDisc.AnchorPoint = Vector2.new(0.5, 0.5)
    WheelDisc.Size = UDim2.new(1, 0, 1, 0)
    WheelDisc.Position = UDim2.new(0.5, 0, 0.5, 0)
    WheelDisc.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
    WheelDisc.ZIndex = 57
    WheelDisc.Parent = WheelArea
    Instance.new("UICorner", WheelDisc).CornerRadius = UDim.new(1, 0)

    local WheelOuterStroke = Instance.new("UIStroke", WheelDisc)
    WheelOuterStroke.Color = Color3.fromRGB(52, 60, 78)
    WheelOuterStroke.Thickness = 2.5

    -- 2 Đường kẻ chéo 45° & 135° chia đĩa tròn thành 4 múi quạt 90° đều nhau
    local LineA = Instance.new("Frame")
    LineA.AnchorPoint = Vector2.new(0.5, 0.5)
    LineA.Size = UDim2.new(1, 0, 0, 1.5)
    LineA.Position = UDim2.new(0.5, 0, 0.5, 0)
    LineA.BackgroundColor3 = Color3.fromRGB(45, 52, 68)
    LineA.BorderSizePixel = 0
    LineA.Rotation = 45
    LineA.ZIndex = 58
    LineA.Parent = WheelDisc

    local LineB = Instance.new("Frame")
    LineB.AnchorPoint = Vector2.new(0.5, 0.5)
    LineB.Size = UDim2.new(1, 0, 0, 1.5)
    LineB.Position = UDim2.new(0.5, 0, 0.5, 0)
    LineB.BackgroundColor3 = Color3.fromRGB(45, 52, 68)
    LineB.BorderSizePixel = 0
    LineB.Rotation = 135
    LineB.ZIndex = 58
    LineB.Parent = WheelDisc

    local function CreatePieLabel(posX: number, posY: number, titleText: string)
        local Holder = Instance.new("Frame")
        Holder.AnchorPoint = Vector2.new(0.5, 0.5)
        Holder.Size = UDim2.new(0, 68, 0, 32)
        Holder.Position = UDim2.new(posX, 0, posY, 0)
        Holder.BackgroundTransparency = 1
        Holder.ZIndex = 59
        Holder.Parent = WheelDisc

        local MainTxt = Instance.new("TextLabel")
        MainTxt.Size = UDim2.new(1, 0, 0, 16)
        MainTxt.BackgroundTransparency = 1
        MainTxt.Text = titleText
        MainTxt.TextColor3 = Color3.fromRGB(226, 232, 240)
        MainTxt.TextSize = 11
        MainTxt.Font = Enum.Font.GothamBold
        MainTxt.ZIndex = 60
        MainTxt.Parent = Holder

        local SubRate = Instance.new("TextLabel")
        SubRate.Size = UDim2.new(1, 0, 0, 12)
        SubRate.Position = UDim2.new(0, 0, 0, 16)
        SubRate.BackgroundTransparency = 1
        SubRate.Text = "50% - 50%"
        SubRate.TextColor3 = Color3.fromRGB(130, 142, 160)
        SubRate.TextSize = 8.5
        SubRate.Font = Enum.Font.GothamMedium
        SubRate.ZIndex = 60
        SubRate.Parent = Holder

        return MainTxt
    end

    -- 4 Múi phần thưởng: Đỉnh (12h), Phải (3h), Đáy (6h), Trái (9h)
    local SliceTitle1 = CreatePieLabel(0.5, 0.22, Languages[CurrentLang].Prize2H)  -- Đỉnh (0°)
    local SliceTitle2 = CreatePieLabel(0.78, 0.5, Languages[CurrentLang].Prize3H)  -- Phải (270° dừng ở đỉnh)
    local SliceTitle3 = CreatePieLabel(0.5, 0.78, Languages[CurrentLang].Prize4H)  -- Đáy (180° dừng ở đỉnh)
    local SliceTitle4 = CreatePieLabel(0.22, 0.5, Languages[CurrentLang].Prize12H) -- Trái (90° dừng ở đỉnh)

    -- Tâm trục nhỏ ở giữa vòng quay (26px) không bao giờ che chữ
    local CenterCap = Instance.new("Frame")
    CenterCap.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterCap.Size = UDim2.new(0, 26, 0, 26)
    CenterCap.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterCap.BackgroundColor3 = Color3.fromRGB(32, 38, 52)
    CenterCap.ZIndex = 61
    CenterCap.Parent = WheelDisc
    Instance.new("UICorner", CenterCap).CornerRadius = UDim.new(1, 0)
    local CapStroke = Instance.new("UIStroke", CenterCap)
    CapStroke.Color = Color3.fromRGB(160, 35, 65)
    CapStroke.Thickness = 1.5

    -- NÚT QUAY ĐẶT TÁCH BIỆT BÊN DƯỚI VÒNG QUAY (DỄ BẤM, KHÔNG CHE VÒNG QUAY)
    local ActionSpinBtn = Instance.new("TextButton")
    ActionSpinBtn.Size = UDim2.new(1, -36, 0, 36)
    ActionSpinBtn.Position = UDim2.new(0, 18, 0, 250)
    ActionSpinBtn.BackgroundColor3 = (not initSpin.Played) and Color3.fromRGB(175, 24, 55) or Color3.fromRGB(24, 28, 38)
    ActionSpinBtn.Text = (not initSpin.Played) and Languages[CurrentLang].SpinBtnText or Languages[CurrentLang].SpinDoneText
    ActionSpinBtn.TextColor3 = (not initSpin.Played) and Color3.fromRGB(241, 245, 249) or Color3.fromRGB(100, 112, 130)
    ActionSpinBtn.TextSize = 11
    ActionSpinBtn.Font = Enum.Font.GothamBold
    ActionSpinBtn.AutoButtonColor = false
    ActionSpinBtn.ZIndex = 58
    ActionSpinBtn.Parent = SpinModal
    Instance.new("UICorner", ActionSpinBtn).CornerRadius = UDim.new(0, 9)

    local SpinResultBanner = Instance.new("TextLabel")
    SpinResultBanner.Size = UDim2.new(1, -36, 0, 36)
    SpinResultBanner.Position = UDim2.new(0, 18, 0, 294)
    SpinResultBanner.BackgroundColor3 = Color3.fromRGB(21, 24, 32)
    SpinResultBanner.Text = initSpin.Played and string.format("✔ Hôm nay bạn đã quay trúng +%d giờ thời gian sử dụng Key!", initSpin.BonusHours) or "Bấm nút QUAY bên trên để thử vận may nhận thêm giờ sử dụng!"
    SpinResultBanner.TextColor3 = Color3.fromRGB(195, 205, 220)
    SpinResultBanner.TextSize = 10
    SpinResultBanner.Font = Enum.Font.GothamMedium
    SpinResultBanner.TextWrapped = true
    SpinResultBanner.ZIndex = 56
    SpinResultBanner.Parent = SpinModal
    Instance.new("UICorner", SpinResultBanner).CornerRadius = UDim.new(0, 9)

    local SpinFooterNote = Instance.new("TextLabel")
    SpinFooterNote.Size = UDim2.new(1, -36, 0, 30)
    SpinFooterNote.Position = UDim2.new(0, 18, 0, 336)
    SpinFooterNote.BackgroundTransparency = 1
    SpinFooterNote.Text = Languages[CurrentLang].SpinNote
    SpinFooterNote.TextColor3 = Color3.fromRGB(130, 142, 160)
    SpinFooterNote.TextSize = 9.5
    SpinFooterNote.Font = Enum.Font.GothamMedium
    SpinFooterNote.TextWrapped = true
    SpinFooterNote.ZIndex = 56
    SpinFooterNote.Parent = SpinModal
    -- =========================================================================
--   🌶️ CHILLI HUB V5 X RONNEI - STEAL AN EGG 🥚 (PHẦN 6/6)
--   XOAY ĐĨA TRÒN 360 ĐỘ · HỘP QUÀ 5/95 · TỰ HỦY MENU KHI VÀO SCRIPT GỐC
-- =========================================================================

    local isRollingMutex = false
    local isSpinningMutex = false

    local function OpenGachaModal()
        TweenService:Create(GachaModal, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    end
    local function CloseGachaModal()
        TweenService:Create(GachaModal, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(0, 0, 1, 0) }):Play()
    end
    local function OpenSpinModal()
        TweenService:Create(SpinModal, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    end
    local function CloseSpinModal()
        TweenService:Create(SpinModal, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(0, 0, 1, 0) }):Play()
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
            local h = math.floor(secsLeft / 3600)
            local m = math.floor((secsLeft % 3600) / 60)
            StatusMsg.Text = string.format("Hộp quà đã mở hôm nay! Reset sau %02d:%02d (00:00)", h, m)
            return
        end
        OpenGachaModal()
    end)

    SpinGameBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(SpinGameBtn)
        OpenSpinModal()
    end)

    -- =========================================================================
    --   XỬ LÝ XOAY VÒNG QUAY TRÒN: 50% (+2H) | 30% (+3H) | 18% (+4H) | 2% (+12H)
    -- =========================================================================
    ActionSpinBtn.MouseButton1Click:Connect(function()
        if isSpinningMutex then return end
        local currentSpin = LoadSpinDataToday()
        if currentSpin.Played then
            local secsLeft = GetSecondsUntilMidnightGMT7()
            local h = math.floor(secsLeft / 3600)
            local m = math.floor((secsLeft % 3600) / 60)
            SpinResultBanner.Text = string.format("Bạn đã quay hôm nay (+%dH)! Hồi lại sau %02d:%02d (00:00)", currentSpin.BonusHours, h, m)
            return
        end

        isSpinningMutex = true
        PlaySpringButton(ActionSpinBtn)

        -- Góc dừng tương ứng với kim chỉ ở đỉnh 12h:
        -- +2H (Đỉnh): 0° | +3H (Phải -> Đỉnh): 270° | +4H (Đáy -> Đỉnh): 180° | +12H (Trái -> Đỉnh): 90°
        local roll = math.random(1, 100)
        local wonHours = 2
        local targetStopAngle = 0
        local msgKey = "Msg2H"

        if roll <= 50 then
            wonHours = 2
            targetStopAngle = 0
            msgKey = "Msg2H"
        elseif roll <= 80 then
            wonHours = 3
            targetStopAngle = 270
            msgKey = "Msg3H"
        elseif roll <= 98 then
            wonHours = 4
            targetStopAngle = 180
            msgKey = "Msg4H"
        else
            wonHours = 12
            targetStopAngle = 90
            msgKey = "Msg12H"
        end

        -- Ghi ngay vào Vault 3 tầng chống xóa file hoặc thoát game
        SaveSpinResult(wonHours, false)

        local activeKeyLeft = GetKeyRemainingTime()
        if activeKeyLeft and activeKeyLeft > 0 then
            Save24hKey(activeKeyLeft)
        end

        SpinGameBtn.Text = string.format(Languages[CurrentLang].MiniGameSpinLocked, wonHours)
        SpinGameBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
        SpinGameBtn.TextColor3 = Color3.fromRGB(100, 112, 130)
        SpinGameStroke.Color = Color3.fromRGB(36, 41, 52)

        ActionSpinBtn.Text = Languages[CurrentLang].SpinningText
        ActionSpinBtn.BackgroundColor3 = Color3.fromRGB(32, 38, 52)
        SpinResultBanner.Text = "Vòng quay đang quay..."

        -- Xoay 6 vòng trọn vẹn (2160 độ) + góc dừng chính xác tại kim chỉ
        WheelDisc.Rotation = 0
        local finalRotation = (360 * 6) + targetStopAngle
        local spinTween = TweenService:Create(WheelDisc, TweenInfo.new(3.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Rotation = finalRotation
        })
        spinTween:Play()
        spinTween.Completed:Wait()

        ActionSpinBtn.Text = Languages[CurrentLang].SpinDoneText
        ActionSpinBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
        ActionSpinBtn.TextColor3 = Color3.fromRGB(100, 112, 130)

        SpinResultBanner.Text = Languages[CurrentLang][msgKey]
        SpinResultBanner.TextColor3 = Color3.fromRGB(110, 215, 155)

        StatusMsg.Text = string.format("Đã lưu +%d giờ thưởng vào tài khoản của bạn!", wonHours)
        isSpinningMutex = false
    end)

    -- =========================================================================
    --   XỬ LÝ MỞ HỘP QUÀ: 5% NOKEY / 95% GETKEY
    -- =========================================================================
    local function ExecuteBoxRoll(chosenBox: TextButton, otherBox: TextButton, chosenStroke: UIStroke, chosenMask: Frame, chosenTitle: TextLabel, chosenHint: TextLabel)
        if isRollingMutex then return end
        isRollingMutex = true

        SaveGachaPlayed()
        MiniGameBtn.Text = Languages[CurrentLang].MiniGameBoxLocked
        MiniGameBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
        MiniGameBtn.TextColor3 = Color3.fromRGB(100, 112, 130)
        MiniGameStroke.Color = Color3.fromRGB(36, 41, 52)

        TweenService:Create(otherBox, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { BackgroundTransparency = 0.65 }):Play()
        otherBox.Active = false

        chosenHint.Text = Languages[CurrentLang].OpeningBox
        GachaResultBanner.Text = Languages[CurrentLang].BoxBannerOpening

        for i = 1, 6 do
            local angle = (i % 2 == 0) and 5 or -5
            TweenService:Create(chosenMask, TweenInfo.new(0.06, Enum.EasingStyle.Quad), { Rotation = angle }):Play()
            task.wait(0.065)
        end
        TweenService:Create(chosenMask, TweenInfo.new(0.08, Enum.EasingStyle.Back), { Rotation = 0 }):Play()
        task.wait(0.2)

        local roll = math.random(1, 100)
        local isNoKeyWon = (roll <= 5)

        if isNoKeyWon then
            chosenTitle.Text = Languages[CurrentLang].BoxWonTitle
            chosenHint.Text = Languages[CurrentLang].BoxWonBtn
            GachaResultBanner.Text = Languages[CurrentLang].BoxWonBanner

            Save24hKey(GetSecondsUntilMidnightGMT7())
            task.wait(0.8)
            -- Tắt hoàn toàn menu GetKey và chạy script gốc không gây lag
            LaunchTargetScriptCleanly(true)
        else
            chosenTitle.Text = Languages[CurrentLang].BoxLostTitle
            chosenHint.Text = Languages[CurrentLang].BoxLostBtn
            GachaResultBanner.Text = Languages[CurrentLang].BoxLostBanner

            task.wait(1.3)
            CloseGachaModal()
            isRollingMutex = false
            StatusMsg.Text = "Mở trúng GetKey! Bấm 'Lấy Key (24 Tiếng)' để tiếp tục."
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
        if not pasted then InputBox:CaptureFocus() end
    end)

    local isTutorialDebounce = false
    TutorialBtn.MouseButton1Click:Connect(function()
        if isTutorialDebounce then return end
        isTutorialDebounce = true
        PlaySpringButton(TutorialBtn)
        if setclipboard then setclipboard(TutorialUrl) elseif toclipboard then toclipboard(TutorialUrl) end
        TutorialBtn.Text = "✔ Đã chép link HD"
        StatusMsg.Text = Languages[CurrentLang].CopiedTutorial
        task.delay(2, function()
            if TutorialBtn and TutorialBtn.Parent then
                TutorialBtn.Text = Languages[CurrentLang].Tutorial
            end
            isTutorialDebounce = false
        end)
    end)

    GetKeyBtn.MouseButton1Click:Connect(function()
        PlaySpringButton(GetKeyBtn)
        if setclipboard then setclipboard(KeyUrl) elseif toclipboard then toclipboard(KeyUrl) end
        GetKeyBtn.Text = "✔ Đã Chép Link (24H)"
        StatusMsg.Text = Languages[CurrentLang].CopiedLink
        task.delay(2, function()
            if GetKeyBtn and GetKeyBtn.Parent then
                GetKeyBtn.Text = Languages[CurrentLang].GetKey
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

        task.wait(0.25)
        local isKeyValid = VerifyChilliV5Key(InputBox.Text)

        if isKeyValid then
            local bonusAdded = Save24hKey()
            CheckKeyBtn.Text = "✔ Thành Công"
            if bonusAdded and bonusAdded > 0 then
                StatusMsg.Text = string.format("Kích hoạt thành công! (24H + %dH = %d Giờ)", bonusAdded, 24 + bonusAdded)
            else
                StatusMsg.Text = Languages[CurrentLang].Success
            end
            task.wait(0.3)
            -- Giải phóng 100% tài nguyên menu GetKey và chạy script gốc
            LaunchTargetScriptCleanly(true)
        else
            isChecking = false
            CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
            StatusMsg.Text = Languages[CurrentLang].Error
            local origOffset = MainFrame.Position.X.Offset
            for _, off in ipairs({ -5, 5, -3, 3, 0 }) do
                MainFrame.Position = UDim2.new(0.5, off, 0.5, 0)
                task.wait(0.04)
            end
            MainFrame.Position = UDim2.new(0.5, origOffset, 0.5, 0)
        end
    end)

    -- CHUYỂN NGÔN NGỮ VI <-> EN
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
        SliceTitle1.Text = data.Prize2H
        SliceTitle2.Text = data.Prize3H
        SliceTitle3.Text = data.Prize4H
        SliceTitle4.Text = data.Prize12H
        ActionSpinBtn.Text = (not sp.Played) and data.SpinBtnText or data.SpinDoneText
    end)
end

-- =========================================================================
--   LUỒNG KHỞI CHẠY CHÍNH: KIỂM TRA KEY -> DÙNG THỬ 2 PHÚT -> KHÓA
-- =========================================================================

local keyTimeLeft = GetKeyRemainingTime()
if keyTimeLeft and keyTimeLeft > 0 then
    ShowLiveToast("CHILLI HUB V5 (KEY ACTIVE)", keyTimeLeft)
    LaunchTargetScriptCleanly(true)
    return
end

local vault = LoadUnifiedVault()
if not vault.TrialStart then
    vault.TrialStart = os.time()
    vault.LastSeen = os.time()
    SaveUnifiedVault(vault)
end

if os.time() < (vault.LastSeen or 0) then
    ApplyScreenLockdown()
    OpenKeySystemUI()
    return
end

local remainingTrial = (vault.TrialStart + TRIAL_DURATION) - os.time()

if remainingTrial <= 0 then
    ApplyScreenLockdown()
    OpenKeySystemUI()
    return
else
    ShowLiveToast("CHILLI HUB V5 (DÙNG THỬ 2 PHÚT)", remainingTrial)
    LaunchTargetScriptCleanly(false)

    task.spawn(function()
        while not SystemTerminated do
            task.wait(1)
            if SystemTerminated or GetKeyRemainingTime() then
                SystemTerminated = true
                return
            end

            local left = (vault.TrialStart + TRIAL_DURATION) - os.time()
            if ActiveToastLabel and ActiveToastLabel.Parent then
                ActiveToastLabel.Text = "Thời gian còn lại: " .. FormatTime(left)
            end

            if left <= 0 then
                local vNow = LoadUnifiedVault()
                vNow.LastSeen = os.time()
                SaveUnifiedVault(vNow)
                ApplyScreenLockdown()
                OpenKeySystemUI()
                break
            end
        end
    end)
end
