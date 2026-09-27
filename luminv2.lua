-- ==============================================================================
--  LUMIN V2 [NEW] - IMMORTAL TRANSLATION ENGINE (EN/VI)
--  Tối ưu hóa:
--    1. REBRANDING: Đổi tên thành Lumin V2, xóa sạch link Discord gốc.
--    2. RICH TEXT INJECTION: Ép thẻ <font> tạo hiệu ứng chữ [ NEW ] màu xanh lục.
--    3. Nạp tự động loadstring gốc: http://luminon.top/loader.lua
--    4. Nút bấm Frosted Slate Top-Center (Y=15) - Chỉ bật/tắt giữa 2 ngôn ngữ.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP SCRIPT LUMIN HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("http://luminon.top/loader.lua"))()
    end)
end)

-- ==================== 2. TỪ ĐIỂN LUMIN V2 (TIẾNG VIỆT) ====================
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
    -- REBRANDING & XÓA DISCORD
    ["discord.gg/luminhub"] = " ",
    ["Lumin / Farm"] = "Lumin V2 / Cày Cuốc\n<font size='12' color='#00FF00'>[ NEW ]</font>",
    ["Lumin / Automation"] = "Lumin V2 / Tự Động Hóa\n<font size='12' color='#00FF00'>[ NEW ]</font>",
    ["Lumin / Intel"] = "Lumin V2 / Tình Báo\n<font size='12' color='#00FF00'>[ NEW ]</font>",
    ["Lumin / Events"] = "Lumin V2 / Sự Kiện\n<font size='12' color='#00FF00'>[ NEW ]</font>",
    ["Lumin / System"] = "Lumin V2 / Hệ Thống\n<font size='12' color='#00FF00'>[ NEW ]</font>",
    
    -- CÁC MỤC HEADER
    ["Auto Farm"] = "Tự Động Cày Cuốc",
    ["Filters"] = "Bộ Lọc",
    ["Inventory"] = "Túi Đồ",
    ["Automation"] = "Tự Động Hóa",
    ["Codes"] = "Mã Quà Tặng (Codes)",
    ["Task Priority"] = "Ưu Tiên Nhiệm Vụ",
    ["Actions"] = "Hành Động",
    ["Egg Finder"] = "Máy Dò Trứng",
    ["Spawn Predictor"] = "Tiên Đoán Trứng Ra",
    ["Visuals"] = "Trực Quan",
    ["Intel"] = "Tình Báo",
    ["Limited Events"] = "Sự Kiện Giới Hạn",
    ["Rift & Boss"] = "Rift & Boss",
    
    -- THÔNG SỐ ĐỘNG (Micro-parser)
    ["Laboratory:"] = "Phòng Thí Nghiệm:",
    ["Speed Power:"] = "Sức Mạnh Tốc Độ:",
    ["Recipe:"] = "Công Thức:",
    ["Pity:"] = "Bảo Hiểm:",
    ["Free refreshes:"] = "Lượt làm mới free:",
    ["Boss:"] = "Boss:",
    ["Zone rift:"] = "Zone Rift:",
    ["Health:"] = "Máu:",
    ["Mastery:"] = "Tinh Thông:",
    ["Tokens:"] = "Huy Hiệu:",
    ["Capture The Egg:"] = "Cướp Trứng:",
    ["Event reward:"] = "Thưởng sự kiện:",
    ["Your score: awaiting server standings"] = "Điểm của bạn: Đang chờ xếp hạng server",
    ["Egg reset: --"] = "Làm Mới Trứng: --",
    
    -- TRẠNG THÁI SCRAMBLE & BOSS
    ["Scramble Boss: inactive"] = "Scramble Boss: chưa kích hoạt",
    ["phase none"] = "giai đoạn: không",
    ["Kills:"] = "Hạ gục:",
    ["Scramble: parts "] = "Scramble: phụ tùng ",
    [", samples "] = ", mẫu vật ",
    [", drops "] = ", đồ rơi ",
    [", drones "] = ", drone ",
    ["window closed"] = "cửa sổ đang đóng",
    ["vault reward ready"] = "quà hầm đã sẵn sàng",
    ["Anti AFK: Active (input every "] = "Chống AFK: Đang chạy (nhập mỗi ",
    ["GodMode: off"] = "Bất Tử: Tắt",
    
    -- FARM TAB
    ["Insta PP"] = "Nhặt Nhanh (Insta PP)",
    ["Ride a Guardian"] = "Cưỡi Vệ Sĩ",
    ["Anti Hit"] = "Chống Bị Đánh",
    ["Steal Glide Speed"] = "Tốc Độ Bay Cướp",
    ["Target Priority"] = "Ưu Tiên Mục Tiêu",
    ["Highest Rarity"] = "Độ Hiếm Cao Nhất",
    ["Minimum Rarity"] = "Độ Hiếm Tối Thiểu",
    ["Select..."] = "Chọn...",
    ["Exact Rarities"] = "Chính Xác Độ Hiếm",
    ["Zones"] = "Khu Vực",
    ["Auto Steal Selected"] = "Tự Động Cướp Đã Chọn",
    ["Auto Return to Base"] = "Tự Động Về Căn Cứ",
    ["Anti Trap"] = "Chống Bẫy",
    ["Avoid Rifts"] = "Tránh Khu Vực Rift",
    ["Auto Dismount Treadmill"] = "Tự Xuống Máy Tập",
    ["Specific Eggs"] = "Trứng Cụ Thể",
    ["Specific Trứng"] = "Trứng Cụ Thể",
    ["Min Egg Weight"] = "Trọng Lượng Trứng Min",
    ["Minimum Egg Size"] = "Kích Thước Trứng Min",
    ["Any Size"] = "Mọi Kích Thước",
    ["Mutation Requirement"] = "Yêu Cầu Đột Biến",
    ["Last Steal: Retrying"] = "Cướp Lần Cuối: Đang Thử Lại",
    ["Last issue: none"] = "Lỗi gần nhất: Không có",
    ["Notify Steal Bugs Only"] = "Chỉ Báo Cáo Lỗi Cướp",
    ["Copy Last Steal Issue"] = "Chép Lỗi Cướp Gần Nhất",
    ["Auto Steal All"] = "Tự Động Cướp Tất Cả",
    ["Auto Complete Index"] = "Tự Hoàn Thành Sách Pet",
    ["Unequip After Index Hatch"] = "Tháo Pet Sau Khi Ấp Sách",
    ["Select All Zones"] = "Chọn Tất Cả Khu Vực",
    ["Clear Zones"] = "Xóa Khu Vực",
    ["Teleport to Base"] = "Dịch Chuyển Về Căn Cứ",
    ["Drop Held Egg"] = "Vứt Trứng Đang Bê",
    ["Drop Held Trứng"] = "Vứt Trứng Đang Bê",
    ["Place All Eggs"] = "Đặt Tất Cả Trứng",
    ["Place All Trứng"] = "Đặt Tất Cả Trứng",
    ["Teleport to Lobby"] = "Dịch Chuyển Về Sảnh",
    ["Bat Aura"] = "Vòng Sâu Bọ",
    ["Auto Drop Held Egg"] = "Tự Vứt Trứng Đang Bê",
    ["Auto Drop Held Trứng"] = "Tự Vứt Trứng Đang Bê",
    ["Global Auto Farm"] = "Cày Cuốc Toàn Bản Đồ",
    ["Farm Up To"] = "Cày Lên Tới",
    ["Seconds Per Area"] = "Giây Mỗi Khu Vực",
    ["Skip Guarded Areas"] = "Bỏ Qua Khu Có Vệ Sĩ",
    ["Plot Radius"] = "Bán Kính Bãi Cỏ",
    ["Minimum Swing Gap"] = "Độ Trễ Đánh Tối Thiểu",
    ["Equip Best Bat"] = "Trang Bị Gậy Tốt Nhất",
    
    -- INTEL TAB
    ["Enable Spawn Predictor"] = "Bật Tiên Đoán Trứng Ra",
    ["Forecast Area"] = "Khu Vực Tiên Đoán",
    ["All Areas"] = "Tất Cả Khu Vực",
    ["Forecast Results"] = "Số Lượng Tiên Đoán",
    ["Notify On Server Commit"] = "Báo Cáo Khi Server Lưu",
    ["Refresh Seconds"] = "Giây Làm Mới",
    ["Rows Shown"] = "Số Hàng Hiển Thị",
    ["Egg Finder is off."] = "Máy Dò Trứng đang tắt.",
    ["Travel To Best"] = "Dịch Chuyển Tới Tốt Nhất",
    ["Copy Finder List"] = "Chép Danh Sách Dò",
    ["Refresh Forecast"] = "Làm Mới Tiên Đoán",
    ["Guard Threat Radar"] = "Radar Cảnh Báo Vệ Sĩ",
    ["Copy Server Intel"] = "Chép Tình Báo Server",
    
    -- EVENTS TAB
    ["Dodge Attacks"] = "Né Đòn Tấn Công",
    ["Claim Mastery Rewards"] = "Nhận Thưởng Tinh Thông",
    ["Wanted Offers"] = "Ưu Đãi Đang Tìm",
    ["Max Price (10^n)"] = "Giá Tối Đa (10^n)",
    ["Preferred Team"] = "Đội Ưu Tiên",
    ["Light"] = "Ánh Sáng (Light)",
    ["Auto Select Team"] = "Tự Động Chọn Đội",
    ["Auto Collect Rings"] = "Tự Động Nhặt Nhẫn",
    ["Auto Collect Power-ups"] = "Tự Động Nhặt Năng Lượng",
    ["Auto Claim Milestones"] = "Tự Nhận Thưởng Mốc",
    ["Avoid Boss Attacks"] = "Né Đòn Boss",
    ["Auto Quest (Discover + Parts + Vault)"] = "Tự Làm Nhiệm Vụ (Khám Phá + Phụ Tùng + Hầm)",
    ["Auto Collect Drops"] = "Tự Nhặt Vật Phẩm Rơi",
    ["Teleport To Drops"] = "Dịch Chuyển Đến Vật Phẩm",
    ["Auto Farm Drones"] = "Tự Động Cày Drone",
    ["Auto Boss Battle"] = "Tự Động Đánh Boss",
    ["Enter Zone Rift When Open"] = "Vào Zone Rift Khi Mở",
    ["Destroy Shield Crystals"] = "Phá Pha Lê Khiên",
    ["Attack Boss"] = "Tấn Công Boss",
    ["Auto Longest Hold Egg"] = "Tự Động Bê Trứng Lâu Nhất",
    ["Auto Longest Hold Trứng"] = "Tự Động Bê Trứng Lâu Nhất",
    ["Egg Holding Mode"] = "Chế Độ Bê Trứng",
    ["Collect and Hold"] = "Nhặt và Bê",
    ["Shop Item"] = "Vật Phẩm Cửa Hàng",
    ["Buy Selected Item"] = "Mua Vật Phẩm Đã Chọn",
    ["Refresh Shop"] = "Làm Mới Cửa Hàng",
    ["Drone Priority"] = "Ưu Tiên Drone",
    ["Movement Speed"] = "Tốc Độ Di Chuyển",
    ["Above 500 may get snapped back."] = "Trên 500 có thể bị giật lùi về (Lag).",
    ["Auto Buy Offers"] = "Tự Động Mua Ưu Đãi",
    ["Auto Use Mutation Consumables"] = "Tự Dùng Thuốc Đột Biến",
    ["Auto Laboratory Trade-In"] = "Tự Đổi Đồ Phòng Thí Nghiệm",
    ["Placed Trứng"] = "Trứng Đã Đặt",
    ["Refresh Placed Trứng"] = "Làm Mới Trứng Đã Đặt",
    ["Use One Mutation Consumable"] = "Dùng 1 Lọ Thuốc Đột Biến",
    ["Event Status"] = "Trạng Thái Sự Kiện",
    ["Collect Ingredient Trứng"] = "Nhặt Trứng Nguyên Liệu",
    ["Trade Matching Trứng"] = "Trao Đổi Trứng Trùng Khớp",
    ["Use Free Refreshes (Collection Off)"] = "Dùng Lượt Làm Mới Free (Tắt Nhặt)",
    ["Collect Laboratory Rewards"] = "Nhận Thưởng Phòng Thí Nghiệm",
    ["Maximum Trade Rarity"] = "Độ Hiếm Đổi Tối Đa",
    ["Keep Per Trứng"] = "Số Lượng Giữ Lại Mỗi Trứng",
    ["Keep Mutated Trứng"] = "Giữ Trứng Đột Biến",
    ["Auto Scramble Boss"] = "Tự Đánh Scramble Boss",
    ["Enter Arena When Live"] = "Vào Đấu Trường Khi Mở",
    
    -- SYSTEM TAB
    ["GodMode"] = "Bất Tử (GodMode)",
    ["Anti AFK"] = "Chống Treo Máy (AFK)",
    ["No Animations"] = "Tắt Hoạt Ảnh",
    ["Anti Ragdoll"] = "Chống Ngã (Ragdoll)",
    ["Anti Die"] = "Chống Chết (Anti Die)",
    ["FPS Boost"] = "Tăng Tốc FPS",
    ["Low Graphics"] = "Đồ Họa Thấp",
    ["Black Screen"] = "Màn Hình Đen",
    ["Disable 3D Rendering"] = "Tắt Render 3D",
    ["Limit FPS"] = "Giới Tranh FPS",
    ["FPS Cap"] = "Mức Giới Hạn FPS",
    ["Reset Character"] = "Hồi Sinh Nhân Vật",
    ["No Gameplay Paused"] = "Không Bị Dừng Game",
    ["Import / export"] = "Nhập / Xuất Cấu Hình",
    ["Config link or code"] = "Link hoặc mã cấu hình",
    ["Paste a download link or shared config"] = "Dán link tải hoặc cấu hình được chia sẻ",
    ["Save as"] = "Lưu thành",
    ["Configs"] = "Cấu Hình (Configs)",
    ["Config name"] = "Tên cấu hình",
    ["Saved configs"] = "Cấu hình đã lưu",
    ["Create config"] = "Tạo cấu hình mới",
    
    -- AUTOMATION TAB
    ["Auto Open Ready Egg"] = "Tự Mở Trứng Sẵn Sàng",
    ["Auto Open Ready Trứng"] = "Tự Mở Trứng Sẵn Sàng",
    ["Auto Place Carried Egg"] = "Tự Đặt Trứng Đang Bê",
    ["Auto Place Carried Trứng"] = "Tự Đặt Trứng Đang Bê",
    ["Auto Equip Best Pets"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Exact Sell Rarities"] = "Bán Chính Xác Độ Hiếm",
    ["Never Sell Mutated"] = "Không Bán Đột Biến",
    ["Never Sell Equipped"] = "Không Bán Pet Đang Trang Bị",
    ["Auto Sell Pets"] = "Tự Động Bán Pet",
    ["Auto Favorite Rares"] = "Tự Khóa Pet Hiếm",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Tối Thiểu",
    ["Place / Hatch Rarities"] = "Độ Hiếm Đặt / Ấp",
    ["Place / Hatch Mutations"] = "Đột Biến Đặt / Ấp",
    ["Sell Now"] = "Bán Ngay",
    ["Sell Lowest"] = "Bán Thấp Nhất",
    ["Sell Mutations"] = "Bán Đột Biến",
    ["Maximum Scale to Sell"] = "Tỷ Lệ Bán Tối Đa",
    ["Pet Sell Interval"] = "Độ Trễ Bán Pet",
    ["Codes (comma separated)"] = "Mã Quà Tặng (Cách nhau dấu phẩy)",
    ["code1, code2"] = "mã1, mã2",
    ["Redeem Codes"] = "Nhập Mã Ngay",
    ["Auto Sell Eggs"] = "Tự Động Bán Trứng",
    ["Tự động bán Trứng"] = "Tự Động Bán Trứng",
    ["Egg Sell Rarities"] = "Độ Hiếm Bán Trứng",
    ["Egg Sell Mutations"] = "Đột Biến Bán Trứng",
    ["Never Sell Mutated Eggs"] = "Không Bán Trứng Đột Biến",
    ["Never Sell Mutated Trứng"] = "Không Bán Trứng Đột Biến",
    ["Put Auto Equip Best before Auto Fuse and enable Never Fuse Equipped to protect your equipped pets."] = "Ghi chú: Đặt Tự Trang Bị Pet Tốt Nhất lên trước Tự Động Ghép để bảo vệ pet đang dùng.",
    ["Priority 1"] = "Ưu Tiên 1",
    ["Priority 2"] = "Ưu Tiên 2",
    ["Priority 3"] = "Ưu Tiên 3",
    ["Priority 4"] = "Ưu Tiên 4",
    ["Priority 5"] = "Ưu Tiên 5",
    ["Priority 6"] = "Ưu Tiên 6",
    ["Priority 7"] = "Ưu Tiên 7",
    ["Priority 8"] = "Ưu Tiên 8",
    ["Dr. Scramble Drones"] = "Săn Drone Dr. Scramble",
    ["Dr. Scramble"] = "Sự Kiện Dr. Scramble",
    ["Auto Steal Eggs"] = "Tự Động Cướp Trứng",
    ["Auto Steal Trứng"] = "Tự Động Cướp Trứng",
    ["Auto Place Eggs"] = "Tự Động Đặt Trứng",
    ["Auto Place Trứng"] = "Tự Động Đặt Trứng",
    ["Never Sell Parasite Eggs"] = "Không Bán Trứng Ký Sinh",
    ["Never Sell Parasite Trứng"] = "Không Bán Trứng Ký Sinh",
    ["Egg Sell Interval"] = "Độ Trễ Bán Trứng",
    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Auto Treadmill"] = "Tự Động Chạy Máy Tập",
    ["Auto Equip Best"] = "Tự Trang Bị Tốt Nhất",
    ["Auto Fuse"] = "Tự Động Ghép (Fuse)",
    
    -- RARITIES
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)",
    ["Rare"] = "Hiếm (Rare)",
    ["Uncommon"] = "Thường (Uncommon)",
    ["Common"] = "Phổ Thông (Common)"
}

local DYNAMIC_PATTERNS = {
    -- Đổi tên FPS Bar (Chữ NEW nằm ngang để không vỡ khung)
    {
        pattern = "^Lumin Hub %| (.+)$",
        format  = function(lang, stats)
            if lang == "VI" then return "Lumin V2 <font color='#00FF00'>[ NEW ]</font> | " .. stats end
            return "Lumin V2 <font color='#00FF00'>[ NEW ]</font> | " .. stats
        end
    },
    {
        pattern = "^Bat Aura: (.+)$",
        format  = function(lang, state) 
            if lang == "VI" then
                if state:lower() == "idle" then return "Vòng Sâu Bọ: Đang chờ" end
                return "Vòng Sâu Bọ: " .. state
            end
            return "Bat Aura: " .. state 
        end
    },
    {
        pattern = "^Rotation: (.+)$",
        format  = function(lang, state) 
            if lang == "VI" then
                if state:lower() == "idle" then return "Xoay Vòng: Đang chờ" end
                return "Xoay Vòng: " .. state
            end
            return "Rotation: " .. state 
        end
    },
    {
        pattern = "^Placement: (.+)$",
        format  = function(lang, state) 
            if lang == "VI" then
                if state:lower() == "idle" then return "Đặt Trứng: Đang chờ" end
                return "Đặt Trứng: " .. state
            end
            return "Placement: " .. state 
        end
    },
    {
        pattern = "^Last Sell: (.+)$",
        format  = function(lang, state) 
            if lang == "VI" then
                if state:lower() == "idle" then return "Bán Gần Nhất: Đang chờ" end
                return "Bán Gần Nhất: " .. state
            end
            return "Last Sell: " .. state 
        end
    },
    {
        pattern = "^Next reset in (.+) %| luck (.+)$",
        format  = function(lang, timeStr, luck) 
            if lang == "VI" then return "Làm mới sau " .. timeStr .. " | May mắn " .. luck end
            return "Next reset in " .. timeStr .. " | luck " .. luck
        end
    },
    {
        pattern = "^Last reset: (%d+) eggs %| (.+)$",
        format  = function(lang, eggs, details) 
            if lang == "VI" then return "Làm mới trước: " .. eggs .. " trứng | " .. details end
            return "Last reset: " .. eggs .. " eggs | " .. details
        end
    },
    {
        pattern = "^Server (.+) %| admin (.+) %| (%d+) areas$",
        format  = function(lang, srv, admin, areas) 
            if lang == "VI" then return "Máy chủ " .. srv .. " | admin " .. admin .. " | " .. areas .. " khu vực" end
            return "Server " .. srv .. " | admin " .. admin .. " | " .. areas .. " areas"
        end
    },
    {
        pattern = "^(%d+) eggs up$",
        format  = function(lang, eggs) 
            if lang == "VI" then return "Đã ra " .. eggs .. " trứng" end
            return eggs .. " eggs up"
        end
    },
    {
        pattern = "^Best: (.+) %[(.+)%] (.+) in (.+)$",
        format  = function(lang, name, rarity, weight, area) 
            if lang == "VI" then return "Tốt nhất: " .. name .. " [" .. rarity .. "] " .. weight .. " ở " .. area end
            return "Best: " .. name .. " [" .. rarity .. "] " .. weight .. " in " .. area
        end
    },
    {
        pattern = "^Players %((%d+)%):$",
        format  = function(lang, num) 
            if lang == "VI" then return "Người chơi (" .. num .. "):" end
            return "Players (" .. num .. "):"
        end
    },
    {
        pattern = "^Guards: (.+)$",
        format  = function(lang, state) 
            if lang == "VI" then return "Vệ sĩ: " .. state end
            return "Guards: " .. state
        end
    }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

-- ==================== 3. LÕI DỊCH THUẬT (IMMORTAL) ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    local result = raw
    local matched = false

    -- XỬ LÝ REBRANDING KHI Ở TIẾNG ANH
    if currentLanguage == "EN" then
        result = replaceAll(result, "discord.gg/luminhub", " ")
        result = replaceAll(result, "Lumin / Farm", "Lumin V2 / Farm\n<font size='12' color='#00FF00'>[ NEW ]</font>")
        result = replaceAll(result, "Lumin / Automation", "Lumin V2 / Automation\n<font size='12' color='#00FF00'>[ NEW ]</font>")
        result = replaceAll(result, "Lumin / Intel", "Lumin V2 / Intel\n<font size='12' color='#00FF00'>[ NEW ]</font>")
        result = replaceAll(result, "Lumin / Events", "Lumin V2 / Events\n<font size='12' color='#00FF00'>[ NEW ]</font>")
        result = replaceAll(result, "Lumin / System", "Lumin V2 / System\n<font size='12' color='#00FF00'>[ NEW ]</font>")
        
        local trimmed = result:gsub("^%s*(.-)%s*$", "%1")
        local matches = {trimmed:match("^Lumin Hub %| (.+)$")}
        if #matches > 0 then
            result = "Lumin V2 <font color='#00FF00'>[ NEW ]</font> | " .. matches[1]
        end

        FastCache[cacheKey] = result
        return result
    end

    -- NẾU LÀ TIẾNG VIỆT
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local trimmed = result:gsub("^%s*(.-)%s*$", "%1")
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            result = item.format(currentLanguage, unpack(matches))
            matched = true
            break
        end
    end

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
local DebounceTracker = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Lumin_LangToggle_Slate") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    local mappedText = translateText(original)
    
    if inst.Text ~= mappedText then
        inst:SetAttribute("__IsTranslating", true)
        pcall(function() 
            -- Ép bật RichText nếu đoạn dịch có chứa thẻ <font> (Để hiển thị chữ NEW màu sắc)
            if mappedText:find("<font") then
                inst.RichText = true
            end
            inst.Text = mappedText 
        end)
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

        if DebounceTracker[inst] and tick() - DebounceTracker[inst] < 0.1 then return end
        DebounceTracker[inst] = tick()

        local current = inst.Text
        local isKnown = false
        
        if currentLanguage == "VI" then
            for _, translated in pairs(MAP_VI) do
                if current:find(translated, 1, true) then
                    isKnown = true
                    break
                end
            end
            
            if not isKnown then
                for _, item in ipairs(DYNAMIC_PATTERNS) do
                    local trimmed = current:gsub("^%s*(.-)%s*$", "%1")
                    local matches = {trimmed:match(item.pattern)}
                    if #matches > 0 then
                        isKnown = true 
                        break
                    end
                end
            end
        else
            -- Check cho tiếng Anh có dính Rebranding
            isKnown = current:find("Lumin V2") or current == inst:GetAttribute("OriginalRawText")
        end

        if not isKnown then
            inst:SetAttribute("OriginalRawText", current)
        end
        
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

-- ==================== 4. NÚT ĐỔI NGÔN NGỮ (VI / EN) ====================
local function createLangToggleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Lumin_LangToggle_Slate")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Lumin_LangToggle_Slate"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Container = Instance.new("Frame", ScreenGui)
    Container.Size = UDim2.new(0, 136, 0, 28)
    Container.AnchorPoint = Vector2.new(0.5, 0)
    Container.Position = UDim2.new(0.5, 0, 0, 15)
    Container.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    Container.BackgroundTransparency = 0.2
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke", Container)
    Stroke.Color = Color3.fromRGB(45, 160, 85) 
    Stroke.Thickness = 1.0

    local Icon = Instance.new("TextLabel", Container)
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌐"
    Icon.TextSize = 14

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -36, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Tiếng Việt"
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(130, 240, 170)
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ClickBtn = Instance.new("TextButton", Container)
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""

    local dragging, dragStart, startPos = false, nil, nil
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Container.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Container.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    ClickBtn.MouseButton1Click:Connect(function()
        if currentLanguage == "VI" then
            currentLanguage = "EN"
            Label.Text = "English"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(215, 180, 180)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 45, 45)}):Play()
        else
            currentLanguage = "VI"
            Label.Text = "Tiếng Việt"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 240, 170)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 160, 85)}):Play()
        end
        updateAllActive()
    end)
end

-- ==================== 5. BỘ QUÉT DEFER BẢO MẬT ====================
task.delay(3, function()
    createLangToggleUI()

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
            if i % 20 == 0 then RunService.RenderStepped:Wait() end
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
