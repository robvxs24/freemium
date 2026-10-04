-- ==============================================================================
--  CHILLI HUB - MASTER TRANSLATION ENGINE V4.0 (FULL SUITE EDITION)
--  Tối ưu hóa:
--    1. Nạp tự động script gốc: https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua
--    2. BỔ SUNG 100%: Egg Predictor, Fuse Predictor, Auto Progression, Server, Performance, Egg Finder Auto Hop.
--    3. STRICT TOKEN MATCHING: Chống lỗi dịch đè các nút ngắn (Hop, Join, Copy, Rejoin).
--    4. PREDICTOR DYNAMIC COUNTERS: Đồng bộ số liệu thời gian thực cho thẻ trứng và phòng Lab.
--    5. LIQUID CYBER CAPSULE: Giữ nguyên nút chuyển đổi ngôn ngữ nổi siêu mượt.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== 2. TỪ ĐIỂN DỊCH THUẬT MASTER ====================
local currentLanguage = "VI"
local FastCache = {}

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

local MAP_VI = {
    -- MENU CHÍNH
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Khác",
    ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt & Key",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...",
    ["Search"] = "Tìm kiếm",

    -- TIÊU ĐỀ KHU VỰC & MODULE
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble",
    ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp",
    ["Auto Steal"] = "Tự Động Cướp Trứng",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Auto Treadmill"] = "Tự Động Máy Tập",
    ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị",
    ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Pet",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet",
    ["Auto Favorite"] = "Tự Động Khóa Pet",
    ["Priority"] = "Ưu Tiên Nhiệm Vụ",
    ["ESP"] = "Định Vị (ESP)",
    ["Movement"] = "Di Chuyển",
    ["Character"] = "Nhân Vật",
    ["Combat"] = "Chiến Đấu",
    ["Discord Webhook"] = "Cài Đặt Webhook Discord",
    ["Egg Predictor"] = "Dự Đoán Trứng",
    ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp",
    ["Auto Progression"] = "Tự Động Tiến Trình",
    ["Performance"] = "Hiệu Năng",
    ["Utility"] = "Tiện Ích",
    ["Egg Finder"] = "Dò Tìm Trứng",

    -- EGG PREDICTOR (ẢNH 6135_2)
    ["Search eggs..."] = "Tìm kiếm trứng...",
    ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",
    ["TOTAL / S"] = "TỔNG / GIÂY",
    ["EGGS"] = "TRỨNG",
    ["READY"] = "SẴN SÀNG",
    ["GROWING"] = "ĐANG LỚN",
    ["IN BAG"] = "TRONG TÚI",

    -- LAB PREDICTOR & FUSE PREDICTOR (ẢNH 6136_2 & 6137)
    ["Biohazard Pets"] = "Pet Phóng Xạ (Biohazard)",
    ["ACTIVE"] = "ĐANG CHẠY",
    ["CURRENT RECIPE"] = "CÔNG THỨC HIỆN TẠI",
    ["REWARD ODDS - BIOHAZARD PETS"] = "TỈ LỆ THƯỞNG - PET PHÓNG XẠ",
    ["Chase pet"] = "Đuổi bắt pet",
    ["Machine is empty"] = "Máy đang trống",
    ["Load 3 pets of the same species to see the result odds"] = "Đặt 3 pet cùng loài vào máy để xem tỉ lệ kết quả",

    -- AUTO PROGRESSION (ẢNH 6138)
    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng (Trail)",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng có sẵn khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim"] = "Tự Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền tích lũy offline & thưởng sách pet",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Sách Pet",
    ["Claim index rewards as soon as they unlock"] = "Tự động nhận thưởng sách ngay khi mở khóa",

    -- SERVER TAB (ẢNH 6139 & 6140)
    ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Least Players"] = "Ít người chơi nhất",
    ["Server Hop"] = "Đổi Server",
    ["Job ID"] = "Mã Phòng (Job ID)",
    ["Paste a server Job ID..."] = "Dán mã Job ID của server...",
    ["Join Job ID"] = "Vào Bằng Job ID",
    ["Copy Current Job ID"] = "Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Server",
    ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",

    -- PERFORMANCE & UTILITY (ẢNH 6141 & 6142)
    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D",
    ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",

    -- AUTO HOP & EGG FINDER (ẢNH 6143 & 6144)
    ["Joins new servers to find eggs that match the filters below"] = "Tự đổi server để tìm trứng khớp bộ lọc bên dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Server để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server",
    ["Steal Then Hop"] = "Cướp Xong Đổi Server",
    ["Rarity To Wait For"] = "Độ Hiếm Cần Giữ Chân",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ nếu xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với mục Tự Động Cướp",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Value To Find"] = "Giá Trị Trứng Min Cần Tìm",
    ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá trị nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu",
    ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",

    -- CÁC NÚT ĐƠN (STRICT TOKEN MATCHING)
    ["Hop"] = "Đổi Server",
    ["Join"] = "Tham Gia",
    ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại",
    ["Add"] = "Thêm",
    ["Sell"] = "Bán",
    ["Favorite"] = "Khóa",
    ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI",

    -- CÁC TÍNH NĂNG ĐÃ TỔNG HỢP TRƯỚC ĐÓ
    ["Speed Boost"] = "Tăng Tốc Chạy",
    ["Boost Speed"] = "Tốc Độ Tăng Tốc",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)",
    ["Makes you invisible to other players"] = "Làm bạn vô hình trước người chơi khác",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)",
    ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không thể bắt được bạn",
    ["Instant Prompts"] = "Tương Tác Nhanh (Instant E)",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất",
    ["Auto Hit Egg Holders"] = "Tự Đánh Người Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định",
    ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
    ["Chase Cài Đặt"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh",
    ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Mục Tiêu (Hit Lead)",
    ["Hit Sweep"] = "Quét Đòn Đánh (Hit Sweep)",
    ["Add/Remove Hits On Quick Bar 2"] = "Thêm/Bỏ Đòn Đánh Vào Quick Bar 2",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng",
    ["Post every egg you bring home"] = "Gửi thông báo mỗi quả trứng mang về thành công",
    ["Sort By"] = "Sắp Xếp Theo",
    ["Preview Card"] = "Thẻ Xem Trước",
    ["ESP Eggs"] = "ESP Trứng",
    ["ESP Fixed Size"] = "Cỡ ESP Cố Định",
    ["ESP Own Base Eggs"] = "Hiện Trứng Căn Cứ Mình",
    ["ESP Min Rarity"] = "Độ Hiếm ESP Min",
    ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["Min ESP Value"] = "Giá Trị ESP Min",
    ["ESP Egg Size"] = "Cỡ ESP Trứng",
    ["ESP Guards"] = "ESP Vệ Sĩ",
    ["ESP Guard Size"] = "Cỡ ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi",
    ["ESP Players"] = "ESP Người Chơi",
    ["ESP Player Info"] = "Thông Tin ESP Người Chơi",
    ["ESP Player Size"] = "Cỡ ESP Người Chơi",
    ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Steal Value"] = "Giá Trị Cướp Min",
    ["Target Specific Eggs"] = "Mục Tiêu Trứng Chỉ Định",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu",
    ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Carry Speed"] = "Tốc Độ Bê Trứng",
    ["Anti Guard Panel"] = "Bảng Anti Vệ Sĩ",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)",
    ["Instant Steal Steps"] = "Số Bước Cướp",
    ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Đặt",
    ["Min Place Value"] = "Giá Trị Đặt Min",
    ["Stay On Treadmill"] = "Luôn Ở Trên Máy Tập",
    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Ấp",
    ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Pet Max Rarity"] = "Độ Hiếm Bán Pet Max",
    ["Pet Sell Value"] = "Giá Trị Bán Pet",
    ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["Sell Eggs Now"] = "Bán Trứng Ngay",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Bán Trứng Max",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng",
    ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng",
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab",
    ["Lab Egg Max Rarity"] = "Độ Hiếm Trứng Lab Max",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab",
    ["No three matching pets"] = "Không đủ 3 pet trùng khớp",
    ["Fuse Priority Mode"] = "Ưu Tiên Dung Hợp",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước",
    ["Pets To Use"] = "Loại Pet Sử Dụng",
    ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Dung Hợp",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến",
    ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ",
    ["Auto Favorite Pet"] = "Tự Động Khóa Pet",
    ["Favorite Pets Now"] = "Khóa Pet Ngay",
    ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Steal Filter Eggs"] = "Cướp Trứng Theo Bộ Lọc",
    ["Mech Boss"] = "Săn Boss Robot (Mech)",
    ["Steal Wisp Quest Eggs"] = "Cướp Trứng Nhiệm Vụ Wisp",

    -- GIÁ TRỊ TÙY CHỌN
    ["Highest Value"] = "Giá trị cao nhất",
    ["Rarity Only"] = "Chỉ theo độ hiếm",
    ["Rarity And Value"] = "Độ hiếm & Giá trị",
    ["Value Only"] = "Chỉ theo giá trị",
    ["Match All"] = "Khớp tất cả",
    ["Match Any"] = "Khớp bất kỳ",
    ["Always"] = "Luôn luôn",
    ["selected"] = "đã chọn",
    ["None"] = "Không có",
    ["Any"] = "Tất cả",
    ["All"] = "Tất cả",
    ["Off"] = "Tắt",
    ["On"] = "Bật",
    ["Idle"] = "Đang chờ",
    ["IDLE"] = "ĐANG CHỜ"
}

-- BỘ BÓC TÁCH REGEX NÂNG CAO CHO CÁC THẺ SỐ LIỆU ĐỘNG
local DYNAMIC_PATTERNS = {
    -- Predictor Sub-Tabs
    {
        pattern = "^ALL (%d+)$",
        format = function(lang, c) return lang == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end
    },
    {
        pattern = "^READY (%d+)$",
        format = function(lang, c) return lang == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end
    },
    {
        pattern = "^GROWING (%d+)$",
        format = function(lang, c) return lang == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end
    },
    {
        pattern = "^IN BAG (%d+)$",
        format = function(lang, c) return lang == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end
    },
    -- Auto Hop Status
    {
        pattern = "^Players (%d+)/(%d+)$",
        format = function(lang, p1, p2)
            return lang == "VI" and string.format("Người chơi %s/%s", p1, p2) or string.format("Players %s/%s", p1, p2)
        end
    },
    -- Time formats
    {
        pattern = "^Ends in (%d+h %d+m %d+s)",
        format = function(lang, tStr) return lang == "VI" and ("Kết thúc sau " .. tStr) or ("Ends in " .. tStr) end
    },
    {
        pattern = "^in (%d+h %d+m)",
        format = function(lang, tStr) return lang == "VI" and ("sau " .. tStr) or ("in " .. tStr) end
    },
    {
        pattern = "^Banner chance (%d+%.?%d*%%)",
        format = function(lang, cStr) return lang == "VI" and ("Tỉ lệ Banner " .. cStr) or ("Banner chance " .. cStr) end
    },
    {
        pattern = "^Pity (%d+)/(%d+)",
        format = function(lang, p1, p2) return lang == "VI" and string.format("Bảo hiểm %s/%s", p1, p2) or string.format("Pity %s/%s", p1, p2) end
    },
    {
        pattern = "^Free rerolls (%d+)",
        format = function(lang, rStr) return lang == "VI" and ("Đổi miễn phí " .. rStr) or ("Free rerolls " .. rStr) end
    },
    {
        pattern = "^Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag$",
        format = function(lang, p1, p2, p3, p4, p5)
            if lang == "VI" then
                return string.format("Trứng đã đặt %s/%s - %s/%s pet trang bị, %s trong túi", p1, p2, p3, p4, p5)
            end
            return string.format("Eggs placed %s/%s - %s/%s pets equipped, %s in bag", p1, p2, p3, p4, p5)
        end
    },
    {
        pattern = "^Off %| Next Mech portal in (%d+:%d+)$",
        format = function(lang, timeStr) return lang == "VI" and ("Tắt | Cổng Robot mở sau " .. timeStr) or ("Off | Next Mech portal in " .. timeStr) end
    },
    {
        pattern = "^Next Butterfly Bloom in (%d+:%d+)$",
        format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Bướm nở sau " .. timeStr) or ("Next Butterfly Bloom in " .. timeStr) end
    }
}

-- Sắp xếp theo độ dài giảm dần để ưu tiên cụm từ dài trước
local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

-- ==================== 3. LÕI DỊCH THUẬT SIÊU TỐC O(1) ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
    end

    local result = raw
    local matched = false

    -- 1. Quét biểu thức chính quy (Regex) biến thiên động
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        if result:find(item.pattern) then
            result = result:gsub(item.pattern, function(...)
                return item.format(currentLanguage, ...)
            end)
            matched = true
            break
        end
    end

    -- 2. Quét từ điển tĩnh
    if not matched then
        for _, item in ipairs(SortedVI) do
            if result:find(item.en, 1, true) then
                result = replaceAll(result, item.en, item.out)
                matched = true
            end
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Liquid_Capsule") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        inst:SetAttribute("__IsTranslating", true)
        inst:SetAttribute("__LastTranslatedText", mappedText)
        pcall(function() inst.Text = mappedText end)
        inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(TrackedElements, inst)
    task.defer(function() applyTranslation(inst) end)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        local current = inst.Text
        if current == inst:GetAttribute("__LastTranslatedText") then return end
        inst:SetAttribute("OriginalRawText", current)
        applyTranslation(inst)
    end)
end

local function updateAllActive()
    for i = #TrackedElements, 1, -1 do
        local el = TrackedElements[i]
        if el and el.Parent then
            applyTranslation(el)
        else
            table.remove(TrackedElements, i)
        end
    end
end

-- ==================== 4. LIQUID CYBER CAPSULE UI (TOP-CENTER) ====================
local function createLiquidCapsuleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_Liquid_Capsule")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Liquid_Capsule"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    -- Khung Vỏ Viên Nang
    local Capsule = Instance.new("Frame")
    Capsule.Name = "Capsule"
    Capsule.Size = UDim2.new(0, 176, 0, 36)
    Capsule.AnchorPoint = Vector2.new(0.5, 0)
    Capsule.Position = UDim2.new(0.5, 0, 0, 12)
    Capsule.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
    Capsule.BackgroundTransparency = 0.15
    Capsule.BorderSizePixel = 0
    Capsule.Parent = ScreenGui

    local CapsuleCorner = Instance.new("UICorner")
    CapsuleCorner.CornerRadius = UDim.new(1, 0)
    CapsuleCorner.Parent = Capsule

    local CapsuleStroke = Instance.new("UIStroke")
    CapsuleStroke.Thickness = 1.4
    CapsuleStroke.Color = Color3.fromRGB(255, 50, 50)
    CapsuleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    CapsuleStroke.Parent = Capsule

    -- Con trượt Active Slider
    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Size = UDim2.new(0, 84, 0, 28)
    Slider.Position = UDim2.new(0, 4, 0.5, -14)
    Slider.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
    Slider.BorderSizePixel = 0
    Slider.Parent = Capsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = Slider

    local SliderGlow = Instance.new("UIStroke")
    SliderGlow.Thickness = 1
    SliderGlow.Color = Color3.fromRGB(255, 140, 140)
    SliderGlow.Transparency = 0.3
    SliderGlow.Parent = Slider

    -- Tab Tiếng Việt
    local BtnVI = Instance.new("TextButton")
    BtnVI.Name = "BtnVI"
    BtnVI.Size = UDim2.new(0, 84, 1, 0)
    BtnVI.Position = UDim2.new(0, 4, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 TIẾNG VIỆT"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = Capsule

    -- Tab English
    local BtnEN = Instance.new("TextButton")
    BtnEN.Name = "BtnEN"
    BtnEN.Size = UDim2.new(0, 84, 1, 0)
    BtnEN.Position = UDim2.new(1, -88, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(140, 145, 160)
    BtnEN.ZIndex = 5
    BtnEN.Parent = Capsule

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target

        TweenService:Create(Capsule, TweenInfo.new(0.08), {Size = UDim2.new(0, 170, 0, 34)}):Play()
        task.delay(0.08, function()
            TweenService:Create(Capsule, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 176, 0, 36)}):Play()
        end)

        if target == "VI" then
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 4, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(220, 35, 35)
            }):Play()
            TweenService:Create(CapsuleStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 50, 50)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 145, 160)}):Play()
        else
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -88, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(45, 55, 75)
            }):Play()
            TweenService:Create(CapsuleStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(80, 110, 160)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 145, 160)}):Play()
        end

        updateAllActive()
    end

    BtnVI.MouseButton1Click:Connect(function() switchMode("VI") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)

    -- Kéo thả tự do kèm kẹp biên Viewport
    local dragging, dragStart, startPos = false, nil, nil
    Capsule.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Capsule.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    Capsule.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            local cam = workspace.CurrentCamera
            local maxX = cam and cam.ViewportSize.X - 180 or 800
            local maxY = cam and cam.ViewportSize.Y - 45 or 600

            local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)

            Capsule.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

-- ==================== 5. BỘ QUÉT TẢI TRÌ HOÃN (DEFER SCANNER) ====================
task.delay(2.5, function()
    createLiquidCapsuleUI()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then pcall(function() scanUIChunked(root) end) end
    end

    for _, root in ipairs(searchRoots) do
        if root then
            root.DescendantAdded:Connect(function(desc)
                task.defer(function()
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        hookElement(desc)
                    end
                end)
            end)
        end
    end
end)
