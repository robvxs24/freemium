-- ==============================================================================
--  RONNEI HUB - 100% FULL LOCALIZATION FOR ONHUB (INCLUDING CONFIG TAB)
--  Khắc phục vĩnh viễn lỗi mất nút ON/OFF | Việt hóa toàn diện 100% Cấu Hình
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn sạch phiên bản cũ
local cleanList = {
    "Ronnei_ONhub_DockedMaster",
    "Ronnei_HeaderDockedMaster",
    "Ronnei_PerfectDockMaster",
    "Ronnei_ONhub_CompactMaster",
    "Ronnei_ONhub_UltimateConfig"
}
for _, name in ipairs(cleanList) do
    pcall(function()
        if CoreGuiService:FindFirstChild(name) then CoreGuiService[name]:Destroy() end
        if gethui and gethui():FindFirstChild(name) then gethui()[name]:Destroy() end
    end)
end

local THEME = {
    BarBG      = Color3.fromRGB(15, 25, 18),       -- Nền xanh rêu tối sâu chuẩn tone ONhub
    CardBG     = Color3.fromRGB(20, 36, 26),       -- Nền thẻ nút
    Border     = Color3.fromRGB(40, 80, 50),       -- Viền kim loại xanh
    AccentMint = Color3.fromRGB(0, 230, 120),      -- Xanh ngọc Cyber Mint
    ToggleOff  = Color3.fromRGB(38, 43, 56),       -- Nút khi tắt (OFF)
    TextMain   = Color3.fromRGB(245, 248, 255),    -- Màu chữ chính
    TextSub    = Color3.fromRGB(150, 180, 160),    -- Màu chữ phụ
    FontB      = Enum.Font.GothamBold,
    FontM      = Enum.Font.GothamMedium
}

-- ==================== BẢNG TỪ ĐIỂN TỔNG HỢP TOÀN BỘ CÁC TAB ====================
local RAW_TRANSLATIONS = {
    -- 1. TAB CẤU HÌNH: BỘ LỌC MỤC TIÊU (TARGET FILTER)
    {"Fast mode (grab the closest)", "Chế độ nhanh (nhặt trứng gần nhất)"},
    {"Selected pets only", "Chỉ nhặt thú cưng đã chọn"},
    {"Mutated eggs only", "Chỉ nhặt trứng đột biến"},
    {"Skip eggs with a player within [PvP]:", "Bỏ qua trứng có người chơi gần [PvP]:"},
    {"Skip eggs with a player within [PvP]", "Bỏ qua trứng có người chơi gần [PvP]"},
    {"Minimum rarity:", "Độ hiếm tối thiểu:"},
    {"Minimum rarity", "Độ hiếm tối thiểu"},
    {"Maximum target distance:", "Khoảng cách mục tiêu tối đa:"},
    {"Maximum target distance", "Khoảng cách mục tiêu tối đa"},
    {"TARGET FILTER", "BỘ LỌC MỤC TIÊU"},

    -- 2. TAB CẤU HÌNH: TRỌNG SỐ ƯU TIÊN MỤC TIÊU (RANKING WEIGHTS)
    {"On, the ranking is $/s by the game's own formula and the weights above are inert (distance only counts when the instant TP is unusable).", "Khi bật, mục tiêu xếp theo $/s theo công thức của game và các trọng số trên sẽ tắt (khoảng cách chỉ tính khi không thể dùng TP tức thì)."},
    {"Rank by pure $/s", "Ưu tiên thuần theo $/giây"},
    {"Rarity weight:", "Trọng số độ hiếm:"},
    {"Rarity weight", "Trọng số độ hiếm"},
    {"Mutation weight:", "Trọng số đột biến:"},
    {"Mutation weight", "Trọng số đột biến"},
    {"Size weight:", "Trọng số kích thước:"},
    {"Size weight", "Trọng số kích thước"},
    {"Distance penalty:", "Phạt khoảng cách:"},
    {"Distance penalty", "Phạt khoảng cách"},
    {"RANKING WEIGHTS", "TRỌNG SỐ ƯU TIÊN MỤC TIÊU"},

    -- 3. TAB CẤU HÌNH: DI CHUYỂN & AN TOÀN (MOVEMENT AND SAFETY)
    {"Approach radius (server accepts 9):", "Bán kính tiếp cận (server nhận 9):"},
    {"Approach radius (server accepts 9)", "Bán kính tiếp cận (server nhận 9)"},
    {"Approach radius", "Bán kính tiếp cận"},
    {"server accepts 9", "server nhận 9"},
    {"Max time per trip:", "Thời gian tối đa mỗi chuyến:"},
    {"Max time per trip", "Thời gian tối đa mỗi chuyến"},
    {"Stop the farm on rollback", "Dừng cày khi bị giật lùi (rollback)"},
    {"MOVEMENT AND SAFETY", "DI CHUYỂN & AN TOÀN"},

    -- 4. TAB CẤU HÌNH: DI CHUYỂN NHANH (FAST TRAVEL)
    {"Fast hop (chained CFrame steps)", "Nhảy nhanh (bước CFrame liên tục)"},
    {"Instant TP (uses the ragdoll window)", "TP tức thì (dùng khe hở ragdoll)"},
    {"Minimum distance for TP:", "Khoảng cách tối thiểu để TP:"},
    {"Minimum distance for TP", "Khoảng cách tối thiểu để TP"},
    {"Hop step (lower = safer):", "Độ dài bước nhảy (thấp = an toàn):"},
    {"Hop step (lower = safer)", "Độ dài bước nhảy (thấp = an toàn)"},
    {"Hop interval (higher = safer):", "Thời gian chờ mỗi bước (cao = an toàn):"},
    {"Hop interval (higher = safer)", "Thời gian chờ mỗi bước (cao = an toàn)"},
    {"Timestamp rewind per step:", "Tua ngược thời gian mỗi bước:"},
    {"Timestamp rewind per step", "Tua ngược thời gian mỗi bước"},
    {"FAST TRAVEL", "DI CHUYỂN NHANH (TELEPORT)"},

    -- Các đoạn giải thích kỹ thuật trong FAST TRAVEL
    {"The anti-cheat validates distance divided by time. The hop rewinds the timestamp of its samples before every step:", "Chống hack kiểm tra khoảng cách chia cho thời gian. Bước nhảy tua lại mốc thời gian trước mỗi bước:"},
    {"The anti-cheat validates distance divided by time.", "Chống hack kiểm tra khoảng cách chia cho thời gian."},
    {"A raw step passes at 85", "Bước thô qua ở 85"},
    {"and reverts at 100.", "và bị lùi lại ở 100."},
    {"The instant TP needs a ragdoll window opened by the SERVER. It uses a first-area egg as the ticket but does NOT consume it: the strike only DROPS that egg and it returns to its own slot, so the real cost is the ~0.5s to walk over and grab it, not an egg.", "TP tức thì cần khe hở ragdoll do SERVER mở. Nó dùng trứng khu 1 làm vé nhưng KHÔNG mất: đòn đánh chỉ làm RƠI trứng về chỗ cũ, chi phí thực chỉ là ~0.5s đi lại nhặt, không mất trứng."},
    {"One window = ONE leg of the trip. Measured: the server refuses to pick up any egg for the whole ragdoll (cannot carry eggs while knocked down) and the position exemption dies the instant the ragdoll ends - a TP written 51ms after EndRagdoll already gets relocated. So the TP covers the way OUT and the way back with the egg is always the chained hop.", "Một khe hở = 1 lượt đi. Server từ chối nhặt trứng khi đang ragdoll (không thể cầm trứng khi ngã) và quyền miễn trừ vị trí mất ngay khi hết ragdoll - TP sau 51ms đã bị kéo về. Vì vậy TP dùng cho lượt ĐI, còn lượt VỀ ôm trứng luôn là nhảy bước CFrame."},
    {"No metatable hook is used: __namecall got a kick in a direct test.", "Không dùng hook metatable: __namecall đã bị kick khi thử nghiệm."},
    {"Travel speed is step divided by interval. Default 80 / 0.08 = 1000", "Tốc độ di chuyển = bước chia cho thời gian chờ. Mặc định 80 / 0.08 = 1000"},
    {"GETTING ROLLBACK? Raise the rewind first as it inflates the distance the client-side detector allows per step and costs nothing. Only then lower the step, or raise the interval.", "BỊ GIẬT LÙI? Hãy tăng tua ngược thời gian trước vì nó mở rộng khoảng cách cho phép mỗi bước. Sau đó mới giảm bước hoặc tăng thời gian chờ."},
    {"Do NOT raise the step hoping to go faster: measured 130", "ĐỪNG tăng bước quá cao để đi nhanh: đo 130"},
    {"gave 25 reverts and the average COLLAPSED to 135", "bị lùi 25 lần và tốc độ TỤT còn 135"},
    {"Every revert forces a retry, so a big step is slower in practice.", "Mỗi lần lùi phải thử lại nên bước lớn thực tế lại chậm hơn."},
    {"When it does revert the hub already shrinks the step on its own (80 -> 56 -> 39 -> 30) instead of dropping to walking.", "Khi bị lùi hub sẽ tự giảm bước (80 -> 56 -> 39 -> 30) thay vì chuyển sang đi bộ."},

    -- 5. TAB CẤU HÌNH: RIFT & GIAO DIỆN (INTERFACE)
    {"Count pets you already own", "Tính cả thú cưng bạn đã có"},
    {"Plant recipe eggs on the plot", "Đặt trứng công thức lên khu đất"},
    {"Plant index eggs on the plot", "Đặt trứng sưu tập lên khu đất"},
    {"The machine CONSUMES the 3 pets on trade-in. With the first option on, a pet you already have free in the inventory closes that slot and the hub will not hunt that animal - the bar shows the count (p = pet, o = egg, eq = placed). Turn it off to hunt all three from scratch and keep the pets you have.", "Máy RIFT sẽ TIÊU THỤ 3 thú cưng khi đổi. Bật tùy chọn đầu, thú cưng có sẵn trong túi sẽ lấp ô đó và hub không cần săn con đó nữa - thanh hiển thị số lượng (p = thú, o = trứng, eq = đã đặt). Tắt đi nếu muốn săn mới cả 3 và giữ lại thú cưng đang có."},
    {"Floating button (show/hide)", "Nút tròn nổi (hiện/ẩn)"},
    {"Interface scale:", "Tỷ lệ giao diện:"},
    {"Interface scale", "Tỷ lệ giao diện"},
    {"Platform: mobile (touch, no keyboard). The scale starts automatic from the resolution (base window 620x420 shrunk to fit 92%x 88% of the screen). Touching the slider pins the", "Nền tảng: di động (cảm ứng, không phím). Tỷ lệ tự động theo độ phân giải màn hình (cửa sổ 620x420 thu gọn vừa 92%x 88% màn hình). Chạm thanh trượt để cố định"},
    {"INTERFACE", "GIAO DIỆN"},
    {"RIFT", "MÁY RIFT"},

    -- 6. CÁC MỤC TAB CÀY TIỀN (FARM) & RUNTIME
    {"no mode: farming by $/s. RIFT hunts the machine recipe. INDEX hunts what your codex is missing", "Cơ bản: cày theo $/s. RIFT: săn công thức máy. SƯU TẬP: săn trứng thiếu"},
    {"no mode: farming by $/s. RIFT hunts the machine. INDEX hunts what your codex is missing", "Cơ bản: cày theo $/s. RIFT: săn máy. SƯU TẬP: săn trứng thiếu"},
    {"hunts what your codex is missing", "săn trứng còn thiếu"},
    {"RIFT hunts the machine recipe", "RIFT săn công thức máy"},
    {"RIFT hunts the machine", "RIFT săn máy"},
    {"no mode: farming by $/s.", "Cơ bản: cày theo $/s."},
    {"START FARM", "BẮT ĐẦU CÀY"},
    {"STOP FARM", "DỪNG CÀY"},
    {"BEST TARGETS RIGHT NOW", "MỤC TIÊU TỐT NHẤT HIỆN TẠI"},
    {"CLEAR TARGET", "HỦY MỤC TIÊU"},
    {"click to lock", "bấm để khóa"},
    {"locked", "đã khóa"},
    {"per second", "/giây"},
    {"RIFT: OFF", "RIFT: TẮT"},
    {"RIFT: ON", "RIFT: BẬT"},
    {"INDEX: OFF", "SƯU TẬP: TẮT"},
    {"INDEX: ON", "SƯU TẬP: BẬT"},

    -- 7. THANH TABS BÊN TRÁI
    {"FARM", "CÀY TIỀN"},
    {"PETS", "THÚ CƯNG"},
    {"CONFIG", "CẤU HÌNH"},

    -- 8. THÔNG SỐ RUNTIME & TRẠNG THÁI
    {"heading to Koi", "Đang tới Cá Koi"},
    {"heading to", "Đang tới"},
    {"delivered", "đã giao"},
    {"failed", "thất bại"},
    {"lost", "mất"},
    {"idle", "đang chờ"},
    {"studs", "mét"},

    -- 9. TÊN THÚ CƯNG
    {"Burrowing Owl", "Cú Hang"},
    {"Bladehide", "Thằn Lằn Gai"},
    {"Bronto", "Khủng Long Cổ Dài"},
    {"Chicken", "Gà"},
    {"Dog", "Chó"},
    {"Rhinotaur", "Tê Giác Quái"},
    {"Mantaris", "Bọ Ngựa Quái"},
    {"Triceratops", "Khủng Long 3 Sừng"},
    {"Whale Shark", "Cá Mập Voi"},
    {"Beluga Whale", "Cá Voi Trắng"},
    {"Koi", "Cá Koi"},

    -- 10. ĐỘ HIẾM & KHU VỰC
    {"Common", "Thường"},
    {"Rare", "Hiếm"},
    {"Epic", "Sử Thi"},
    {"Legendary", "Huyền Thoại"},
    {"Mythic", "Thần Thoại"},
    {"Divine", "Thần Thánh"},
    {"Cosmic", "Vũ Trụ"},
    {"Secret", "Bí Mật"},
    {"Cherry Blossom", "Hoa Anh Đào"},
    {"Forest", "Rừng Rậm"},
    {"Desert", "Sa Mạc"},
    {"Titan Temple", "Đền Titan"},
    {"Abyss Ocean", "Biển Vực Sâu"},
    {"Prehistoric", "Tiền Sử"}
}

-- Sắp xếp chuỗi dài lên trước để không bị nuốt chuỗi con
table.sort(RAW_TRANSLATIONS, function(a, b)
    return #a[1] > #b[1]
end)

local function replacePlain(str, findStr, repStr)
    if typeof(str) ~= "string" or typeof(findStr) ~= "string" or str == "" or findStr == "" then return str end
    local s, e = string.find(str, findStr, 1, true)
    if not s then return str end
    local res = {}
    while s do
        table.insert(res, string.sub(str, 1, s - 1))
        table.insert(res, repStr)
        str = string.sub(str, e + 1)
        s, e = string.find(str, findStr, 1, true)
    end
    table.insert(res, str)
    return table.concat(res)
end

local function translateText(raw)
    if typeof(raw) ~= "string" or raw == "" then return raw end
    local res = raw
    for _, item in ipairs(RAW_TRANSLATIONS) do
        res = replacePlain(res, item[1], item[2])
    end
    return res
end

-- ==================== TẠO THANH GHIM (310PX GỌN GÀNG) ====================
local isVietnamese = true
local OriginalTexts = {}
local targetOnhubWindow = nil
local isApplyingTranslation = false

local PinGui = Instance.new("ScreenGui")
PinGui.Name = "Ronnei_ONhub_UltimateConfig"
PinGui.ResetOnSpawn = false
PinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PinGui.DisplayOrder = 999999
PinGui.Parent = (gethui and gethui()) or CoreGuiService

local PinBar = Instance.new("Frame", PinGui)
PinBar.Name = "RonneiCompactBar"
PinBar.Size = UDim2.new(0, 310, 0, 28)
PinBar.Position = UDim2.new(0, 0, 0, -100)
PinBar.BackgroundColor3 = THEME.BarBG
PinBar.BorderSizePixel = 0
PinBar.Visible = false

Instance.new("UICorner", PinBar).CornerRadius = UDim.new(0, 6)
local BarStroke = Instance.new("UIStroke", PinBar)
BarStroke.Color = THEME.AccentMint
BarStroke.Thickness = 1.2

-- Kéo thanh ghim để di chuyển toàn bộ cửa sổ ONhub
local dragging, dragStart, startWinPos = false, nil, nil
PinBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if targetOnhubWindow and targetOnhubWindow.Parent then
            dragging = true
            dragStart = input.Position
            startWinPos = targetOnhubWindow.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if targetOnhubWindow and targetOnhubWindow.Parent then
            local delta = input.Position - dragStart
            targetOnhubWindow.Position = UDim2.new(startWinPos.X.Scale, startWinPos.X.Offset + delta.X, startWinPos.Y.Scale, startWinPos.Y.Offset + delta.Y)
        end
    end
end)

-- Huy hiệu TikTok Ronnei Hub
local TikTokBadge = Instance.new("Frame", PinBar)
TikTokBadge.Size = UDim2.new(0, 135, 0, 20)
TikTokBadge.Position = UDim2.new(0, 4, 0.5, 0)
TikTokBadge.AnchorPoint = Vector2.new(0, 0.5)
TikTokBadge.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", TikTokBadge).CornerRadius = UDim.new(1, 0)

local BadgeStroke = Instance.new("UIStroke", TikTokBadge)
BadgeStroke.Color = THEME.AccentMint
BadgeStroke.Thickness = 1.2

local BadgeGrad = Instance.new("UIGradient", BadgeStroke)
BadgeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 230, 120))
})

local TikTokText = Instance.new("TextLabel", TikTokBadge)
TikTokText.Size = UDim2.new(1, 0, 1, 0)
TikTokText.BackgroundTransparency = 1
TikTokText.Text = "TikTok: ronnei7.htk"
TikTokText.Font = THEME.FontB
TikTokText.TextSize = 10
TikTokText.TextColor3 = THEME.TextMain

task.spawn(function()
    local rot = 0
    while TikTokBadge.Parent do
        rot = (rot + 3) % 360
        BadgeGrad.Rotation = rot
        task.wait(0.04)
    end
end)

-- Nút gạt chuyển đổi ngôn ngữ ON / OFF
local ControlBox = Instance.new("Frame", PinBar)
ControlBox.Size = UDim2.new(0, 160, 0, 22)
ControlBox.Position = UDim2.new(1, -4, 0.5, 0)
ControlBox.AnchorPoint = Vector2.new(1, 0.5)
ControlBox.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 6)

local BoxStroke = Instance.new("UIStroke", ControlBox)
BoxStroke.Color = THEME.Border
BoxStroke.Thickness = 1

local StatusLabel = Instance.new("TextLabel", ControlBox)
StatusLabel.Size = UDim2.new(1, -40, 1, 0)
StatusLabel.Position = UDim2.new(0, 6, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Tiếng Việt (ON)"
StatusLabel.Font = THEME.FontB
StatusLabel.TextSize = 10
StatusLabel.TextColor3 = THEME.AccentMint
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SwitchBtn = Instance.new("TextButton", ControlBox)
SwitchBtn.Size = UDim2.new(0, 30, 0, 14)
SwitchBtn.Position = UDim2.new(1, -34, 0.5, 0)
SwitchBtn.AnchorPoint = Vector2.new(0, 0.5)
SwitchBtn.BackgroundColor3 = THEME.AccentMint
SwitchBtn.Text = ""
SwitchBtn.AutoButtonColor = false
Instance.new("UICorner", SwitchBtn).CornerRadius = UDim.new(1, 0)

local Knob = Instance.new("Frame", SwitchBtn)
Knob.Size = UDim2.new(0, 10, 0, 10)
Knob.Position = UDim2.new(1, -12, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.BorderSizePixel = 0
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

local function updateLanguage(state)
    isVietnamese = state
    if isVietnamese then
        StatusLabel.Text = "Tiếng Việt (ON)"
        StatusLabel.TextColor3 = THEME.AccentMint
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -12, 0.5, 0)}):Play()
    else
        StatusLabel.Text = "English (OFF)"
        StatusLabel.TextColor3 = THEME.TextSub
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
    end
end

SwitchBtn.MouseButton1Click:Connect(function() updateLanguage(not isVietnamese) end)
ControlBox.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        updateLanguage(not isVietnamese)
    end
end)

-- Khởi chạy script ONhub gốc
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua", true))()
    end)
end)

-- ==================== BỘ QUÉT TẦNG SÂU VÀ DỊCH TỨC THỜI (ZERO-FLICKER) ====================
local function applyElemTranslation(elem)
    if isApplyingTranslation then return end
    if not (elem:IsA("TextLabel") or elem:IsA("TextButton")) then return end
    if elem:IsDescendantOf(PinGui) then return end

    local cur = elem.Text
    if not cur or cur == "" then return end

    local lastApplied = elem:GetAttribute("Ronnei_LastApplied")
    if cur ~= lastApplied then
        OriginalTexts[elem] = cur
    end

    local orig = OriginalTexts[elem] or cur

    if isVietnamese then
        local vi = translateText(orig)
        if elem.Text ~= vi then
            isApplyingTranslation = true
            elem:SetAttribute("Ronnei_LastApplied", vi)
            elem.Text = vi
            isApplyingTranslation = false
        end
    else
        if elem.Text ~= orig then
            isApplyingTranslation = true
            elem:SetAttribute("Ronnei_LastApplied", nil)
            elem.Text = orig
            isApplyingTranslation = false
        end
    end
end

local function hookElement(elem)
    if (elem:IsA("TextLabel") or elem:IsA("TextButton")) and not elem:IsDescendantOf(PinGui) then
        applyElemTranslation(elem)
        if not elem:GetAttribute("Ronnei_Hooked") then
            elem:SetAttribute("Ronnei_Hooked", true)
            elem:GetPropertyChangedSignal("Text"):Connect(function()
                applyElemTranslation(elem)
            end)
        end
    end
end

-- ==================== BỘ TÌM KIẾM ĐA TAB (KHÔNG BAO GIỜ LẠC CỬA SỔ) ====================
local IDENTIFIERS = {
    "FARM", "CÀY TIỀN",
    "PETS", "THÚ CƯNG",
    "CONFIG", "CẤU HÌNH",
    "START FARM", "BẮT ĐẦU CÀY",
    "TARGET FILTER", "BỘ LỌC MỤC TIÊU",
    "onhub"
}

local function findOnhubWindow()
    local function scanRoot(root)
        if not root then return nil end
        local ok, descs = pcall(function() return root:GetDescendants() end)
        if not ok or not descs then return nil end
        for _, obj in ipairs(descs) do
            if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and not obj:IsDescendantOf(PinGui) then
                local t = obj.Text
                if t and #t > 0 then
                    for _, id in ipairs(IDENTIFIERS) do
                        if t == id or t:find(id, 1, true) then
                            local p = obj
                            while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= root do
                                p = p.Parent
                            end
                            if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 300 and p.AbsoluteSize.Y > 150 then
                                return p
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

    local found = nil
    if gethui then found = scanRoot(gethui()) end
    if not found then found = scanRoot(CoreGuiService) end
    if not found and LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then found = scanRoot(LocalPlayer.PlayerGui) end
    if not found and getinstances then
        for _, ins in ipairs(getinstances()) do
            if (ins:IsA("TextLabel") or ins:IsA("TextButton")) and not ins:IsDescendantOf(PinGui) then
                local t = ins.Text
                if t == "CONFIG" or t == "CẤU HÌNH" or t == "FARM" or t == "CÀY TIỀN" or t == "START FARM" or t:find("onhub", 1, true) then
                    local p = ins
                    while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= game do
                        p = p.Parent
                    end
                    if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 300 and p.AbsoluteSize.Y > 150 then
                        return p
                    end
                end
            end
        end
    end
    return found
end

-- ==================== ĐỒNG BỘ HIỂN THỊ TỰ ĐỘNG THEO CỬA SỔ (CHỐNG MẤT NÚT) ====================
RunService.RenderStepped:Connect(function()
    if targetOnhubWindow and targetOnhubWindow.Parent then
        local winSize = targetOnhubWindow.AbsoluteSize
        local winPos = targetOnhubWindow.AbsolutePosition

        -- Điều kiện thực tế: ONhub đang mở và hiển thị trên màn hình
        local isActuallyVisible = targetOnhubWindow.Visible and winSize.Y > 100 and winPos.Y > -200 and winPos.Y < 2000

        if isActuallyVisible then
            PinBar.Visible = true
            -- Đặt gọn 310px ở góc trái mép trên: hở trọn vẹn status giữa và 2 nút [-] [X]
            PinBar.Position = UDim2.new(0, winPos.X + 4, 0, winPos.Y + 3)
            PinBar.Size = UDim2.new(0, 310, 0, 28)
        else
            PinBar.Visible = false
        end
    else
        PinBar.Visible = false
    end
end)

-- Vòng lặp duy trì dịch và gắn bộ lắng nghe chống trôi
task.spawn(function()
    while true do
        pcall(function()
            if not targetOnhubWindow or not targetOnhubWindow.Parent then
                targetOnhubWindow = findOnhubWindow()
            end

            if targetOnhubWindow then
                for _, elem in ipairs(targetOnhubWindow:GetDescendants()) do
                    hookElement(elem)
                end
            end
        end)
        task.wait(0.2)
    end
end)
