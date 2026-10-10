-- ==============================================================================
--  CHILLI HUB V2 - DYNAMIC ISLAND V12.0 (THE ULTIMATE AUTO FARM ENGINE)
--  Tối ưu hóa:
--    1. OMNI-CLICK ENGINE: Hàm ép click xuyên phá 100% các lớp bảo vệ của nút gạt.
--    2. TRUE STATE SYNC: Chắc chắn Bật/Tắt chuẩn xác các chức năng (Sự kiện Bướm, Cướp, Máy tập...).
--    3. ZERO-LAG SPAWN: Tự động khởi tạo Dynamic Island mượt mà, không crash.
--    4. MODULAR DROPDOWN SYNC: Chọn đúng tùy chọn (Đuổi theo, Gần nhất, Bí Ẩn...).
--    5. LIQUID SPRING EXPANSION: Kéo bung mượt mà, khung cầu vồng xoay 360 độ.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat task.wait() until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
end

-- ==================== 1. HÀM LẤY VÙNG CHỨA GUI AN TOÀN ====================
local function getSafeGuiContainer()
    local container = nil
    pcall(function() if gethui then container = gethui() end end)
    if container then return container end

    pcall(function()
        if CoreGui and pcall(function() return CoreGui:GetChildren() end) then
            container = CoreGui
        end
    end)
    if container then return container end

    pcall(function() container = LocalPlayer:WaitForChild("PlayerGui", 5) end)
    return container
end

-- ==================== 2. NẠP SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== 3. TỪ ĐIỂN DỊCH THUẬT VÀ LÕI SOFT BLUE ====================
local currentLanguage = "VI"
local FastCache = {}

local EXACT_MATCH_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Hop"] = "Đổi Server", ["Join"] = "Vào Phòng", ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại", ["Add"] = "Thêm", ["Sell"] = "Bán", ["Favorite"] = "Khóa", ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI", ["All"] = "Tất cả", ["ALL"] = "TẤT CẢ", ["Any"] = "Tất cả", ["None"] = "Không có",
    ["Off"] = "Tắt", ["OFF"] = "TẮT", ["On"] = "Bật", ["ON"] = "BẬT", ["Idle"] = "Đang chờ", ["IDLE"] = "ĐANG CHỜ",
    ["Stand"] = "Đứng yên", ["Chase"] = "Đuổi theo", ["Circle"] = "Xoay vòng", ["Patrol"] = "Tuần tra",
    ["Rarest"] = "Hiếm nhất", ["Nearest"] = "Gần nhất", ["Always"] = "Luôn luôn", ["Never"] = "Không bao giờ",
    ["Value"] = "Giá trị", ["Cosmic"] = "Vũ Trụ (Cosmic)", ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)", ["Mythic"] = "Thần Thoại (Mythic)", ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)", ["Rare"] = "Hiếm (Rare)", ["Uncommon"] = "Thường (Uncommon)", ["Common"] = "Phổ Thông (Common)",
    ["Secret"] = "Bí Ẩn (Secret)", ["Least Players"] = "Ít người chơi nhất", ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm", ["Rarity And Value"] = "Độ hiếm & Giá trị", ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước", ["Lowest To Highest"] = "Từ thấp đến cao", ["Highest To Lowest"] = "Từ cao đến thấp",
    ["Match All"] = "Khớp tất cả", ["Match Any"] = "Khớp bất kỳ", ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất", ["3 - Rare"] = "3 - Hiếm (Rare)", ["6 - Mythic"] = "6 - Thần Thoại (Mythic)",
    ["EGGS"] = "TRỨNG", ["READY"] = "SẴN SÀNG", ["GROWING"] = "ĐANG LỚN", ["IN BAG"] = "TRONG TÚI",
    ["TOTAL / S"] = "TỔNG / GIÂY", ["SCRAMBLED"] = "ĐÃ BIẾN ĐỔI", ["GOLDEN"] = "VÀNG", ["SILVER"] = "BẠC", ["RAINBOW"] = "CẦU VỒNG"
}

local MAP_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Farm"] = "Cày Cuốc", ["Player"] = "Người Chơi", ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình", ["Server"] = "Máy Chủ", ["Misc"] = "Khác", ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord", ["Quick & Keys"] = "Phím Tắt & Key", ["Settings"] = "Cài Đặt", ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...", ["Search"] = "Tìm kiếm",
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble", ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp", ["Auto Steal"] = "Tự Động Cướp Trứng", ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Auto Treadmill"] = "Tự Động Máy Tập", ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị", ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Pet", ["Auto Sell Egg"] = "Tự Động Bán Trứng", ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet", ["Auto Favorite"] = "Tự Động Khóa Pet", ["Priority"] = "Ưu Tiên Nhiệm Vụ",
    ["ESP"] = "Định Vị (ESP)", ["Movement"] = "Di Chuyển", ["Character"] = "Nhân Vật", ["Combat"] = "Chiến Đấu",
    ["Discord Webhook"] = "Cài Đặt Webhook Discord", ["Egg Predictor"] = "Dự Đoán Trứng", ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp", ["Auto Progression"] = "Tự Động Tiến Trình", ["Performance"] = "Hiệu Năng",
    ["Utility"] = "Tiện Ích", ["Egg Finder"] = "Dò Tìm Trứng", ["Quick Bar 1"] = "Thanh Phím Nhanh 1", ["Quick Bar 2"] = "Thanh Phím Nhanh 2",
    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm", ["Catch Mode"] = "Chế Độ Bắt", ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Only for Chase mode"] = "Chỉ dùng cho chế độ Đuổi theo", ["Catch Butterflies"] = "Chọn Bướm Cần Bắt",
    ["Radiant Butterfly"] = "Bướm Rực Rỡ", ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím", ["Sapphire Butterfly"] = "Bướm Lam Ngọc (Sapphire)",
    ["Emerald Butterfly"] = "Bướm Lục Bảo (Emerald)", ["Tween Speed"] = "Tốc Độ Bay (Tween)", ["Auto Trade Up"] = "Tự Nâng Cấp Bướm",
    ["Trade Up Tiers"] = "Bậc Nâng Cấp", ["Smart Trade For Essence"] = "Đổi Bướm Lấy Tinh Chất Thông Minh",
    ["Going to the middle of the bloom"] = "Đang đi tới trung tâm khu bướm nở", ["Auto Craft Essence"] = "Tự Chế Tạo Tinh Chất",
    ["Auto Use Enchanted Essence"] = "Tự Dùng Tinh Chất Phù Phép", ["Essence Min Rarity"] = "Độ Hiếm Nhận Tinh Chất Min",
    ["Only eggs of this rarity and above get the essence"] = "Chỉ trứng đạt độ hiếm này trở lên mới nhận tinh chất",
    ["Essence Min Value"] = "Giá Trị Nhận Tinh Chất Min", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị nhỏ hơn mức này (0 = tắt)",
    ["Essence Target Eggs"] = "Mục Tiêu Trứng Nhận Tinh Chất", ["Only use the essence on these eggs (empty = all)"] = "Chỉ dùng tinh chất lên trứng này (trống = tất cả)",
    ["Essence Priority"] = "Ưu Tiên Dùng Tinh Chất", ["Which egg gets the essence first"] = "Trứng nào được ưu tiên nhận tinh chất trước",
    ["Essence Skip Enchanted Eggs"] = "Bỏ Qua Trứng Đã Phù Phép", ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "Bỏ qua trứng đã phù phép, đột biến khác vẫn nhận tinh chất",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)", ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc", ["Higher is safer but takes longer"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",
    ["Target Areas"] = "Khu Vực Mục Tiêu", ["Min Steal Value"] = "Giá Trị Cướp Min", ["Target Specific Eggs"] = "Chọn Đích Danh Trứng Cần Cướp",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu", ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp cả trứng còn thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp", ["Carry Speed"] = "Tốc Độ Bê Trứng", ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ", ["Place Egg Rule"] = "Quy Tắc Đặt Trứng", ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng", ["Only place eggs of the picked rarities (empty = all)"] = "Chỉ đặt trứng thuộc các độ hiếm đã chọn (trống = tất cả)",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Cần Đặt", ["Only place these eggs (empty = all)"] = "Chỉ đặt các trứng này (trống = tất cả)",
    ["Min Place Value"] = "Giá Trị Đặt Min", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị thấp hơn mức này (0 = tắt)",
    ["Stay On Treadmill"] = "Cố Định Trên Máy Tập", ["Auto Hatch"] = "Tự Động Ấp Trứng", ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "Ấp trứng từ độ hiếm đã chọn trở lên", ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Cần Ấp", ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Equip Best when a better pet appears"] = "Tự trang bị khi có pet mạnh hơn xuất hiện", ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell matching pets once"] = "Bán các pet khớp điều kiện một lần", ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Which checks must pass to sell"] = "Các điều kiện bắt buộc để bán", ["Pet Max Rarity"] = "Độ Hiếm Pet Max Cần Bán",
    ["Sell pets at or below this rarity"] = "Bán pet từ độ hiếm này trở xuống", ["Pet Sell Value"] = "Giá Trị Bán Pet Min",
    ["Sell pets worth less than this (0 = off)"] = "Bán pet có giá trị nhỏ hơn mức này (0 = tắt)", ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Never sell mutated pets"] = "Không bao giờ bán pet có đột biến", ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["These pets are never sold"] = "Những pet này sẽ không bao giờ bị bán", ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi khớp quy tắc dưới",
    ["Sell Eggs Now"] = "Bán Trứng Ngay", ["Sell matching eggs once"] = "Bán một lần các trứng khớp điều kiện", ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Trứng Max Cần Bán", ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng Min", ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến", ["Never sell mutated eggs"] = "Không bao giờ bán trứng có đột biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng", ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "Bán trứng đổi từ Dr Scramble khớp bộ lọc dưới",
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay", ["Sell matching Lab eggs once"] = "Bán một lần các trứng Lab khớp điều kiện",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab", ["Lab Egg Max Rarity"] = "Độ Hiếm Trứng Lab Max Cần Bán",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "Bán trứng Lab từ độ hiếm này trở xuống (Off = tắt)",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab Min", ["Sell Lab eggs worth less than this (0 = off)"] = "Bán trứng Lab giá trị thấp hơn mức này (0 = tắt)",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến", ["Never sell mutated Lab eggs"] = "Không bao giờ bán trứng Lab có đột biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab", ["Lab eggs of these pets are never sold"] = "Trứng Lab của những pet này sẽ không bao giờ bị bán",
    ["No three matching pets"] = "Không đủ 3 pet trùng khớp", ["Fuse 3 same pets into an egg, nonstop"] = "Ghép 3 pet cùng loại thành 1 trứng liên tục",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Dung Hợp", ["Pets To Use"] = "Loại Pet Sử Dụng", ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Cần Dung Hợp", ["Only fuse these species (empty = all)"] = "Chỉ ghép loài này (trống = tất cả)",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến", ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ", ["Take out pets that can't make a set"] = "Đẩy ra các pet không thể ghép đủ bộ 3",
    ["Auto Favorite Pet"] = "Tự Động Khóa Pet", ["Favorite pets matching the rules below"] = "Khóa các pet khớp quy tắc bên dưới",
    ["Favorite Pets Now"] = "Khóa Pet Ngay", ["Favorite matching pets once"] = "Khóa các pet khớp điều kiện một lần",
    ["Favorite Rule"] = "Quy Tắc Khóa", ["Pass any check or all checks"] = "Thỏa mãn một hoặc tất cả điều kiện",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min", ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "Khóa pet từ độ hiếm đã chọn trở lên (Off = bỏ qua)",
    ["Favorite Mutations"] = "Đột Biến Cần Khóa", ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (trống = bỏ qua)",
    ["Min Favorite Value"] = "Giá Trị Khóa Min", ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Các Loài Này", ["Always favorite these species"] = "Luôn luôn khóa những loài này",
    ["Auto Favorite Equipped"] = "Tự Khóa Pet Đang Dùng", ["Keep equipped pets favorited"] = "Luôn giữ pet đang trang bị được khóa",
    ["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Pet Đang Dùng", ["Unfavorite equipped pets not in the rules"] = "Mở khóa pet đang trang bị nếu không đúng quy tắc",
    ["Favorite Equipped Now"] = "Khóa Pet Đang Dùng Ngay", ["Favorite all equipped pets once"] = "Khóa tất cả pet đang trang bị một lần",
    ["Unfavorite Equipped Now"] = "Bỏ Khóa Pet Đang Dùng Ngay", ["Unfavorite all equipped pets once"] = "Mở khóa tất cả pet đang trang bị một lần",
    ["Auto Mech Boss"] = "Tự Động Đánh Boss Robot", ["Mech Tween Speed"] = "Tốc Độ Bay Đánh Boss",
    ["Main Weapon Hold"] = "Thời Gian Giữ Vũ Khí Chính", ["Scrambler Hold"] = "Thời Gian Giữ Súng Biến Đổi",
    ["Swap Two Weapons"] = "Tự Đổi Qua Lại 2 Vũ Khí", ["Boss Server Hop"] = "Tự Đổi Server Săn Boss",
    ["After each boss, hops to a less crowded server to fight again"] = "Sau mỗi boss, đổi sang server vắng hơn để đánh tiếp",
    ["Keep Hopping For"] = "Thời Gian Đổi Server Liên Tục", ["Keeps fighting every boss it finds and hopping for this long"] = "Liên tục săn boss tìm được và đổi server trong thời gian này",
    ["Auto Claim Mastery"] = "Tự Nhận Thưởng Tinh Thông Boss", ["Claims Boss Mastery rewards as soon as they unlock"] = "Tự nhận thưởng Tinh Thông Boss ngay khi mở khóa",
    ["Lab Banners"] = "Biểu Ngữ Phòng Lab", ["Only trade and steal for these banners (empty = all)"] = "Chỉ đổi và cướp các biểu ngữ này (trống = tất cả)",
    ["Auto Lab Trade-In"] = "Tự Đổi Đồ Phòng Thí Nghiệm", ["Auto Reroll Lab Recipe"] = "Tự Đổi Công Thức Phòng Lab",
    ["Auto Place Lab Reward Eggs"] = "Tự Đặt Trứng Thưởng Lab", ["Places the reward eggs from Lab trades"] = "Tự động đặt trứng thưởng nhận từ đổi đồ phòng lab",
    ["Auto Buy Scramble Shop"] = "Tự Mua Shop Dr. Scramble", ["Buy the picked items with Samples"] = "Dùng Mẫu Vật (Samples) mua các vật phẩm đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble", ["Keep Samples"] = "Giữ Lại Mẫu Vật Tối Thiểu",
    ["Never spend below this many Samples"] = "Không bao giờ tiêu hao dưới mức mẫu vật này",
    ["Auto Use Scrambled"] = "Tự Dùng Thuốc Biến Đổi Scrambled", ["Turn it on to start applying Scrambled"] = "Bật lên để bắt đầu áp dụng thuốc Scrambled",
    ["Auto Buy Scrambled"] = "Tự Mua Thêm Scrambled Khi Hết", ["Buy another Scrambled from the event shop when you run out"] = "Tự mua thêm Scrambled từ shop sự kiện khi dùng hết",
    ["Mutation Min Rarity"] = "Độ Hiếm Đột Biến Min", ["Only eggs of this rarity and above are used"] = "Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Value"] = "Giá Trị Đột Biến Min", ["Mutation Priority"] = "Ưu Tiên Đột Biến",
    ["Which egg gets the consumable first"] = "Trứng nào được ưu tiên dùng thuốc trước",
    ["Mutation Target Eggs"] = "Mục Tiêu Trứng Đột Biến", ["Only use the consumable on these eggs (empty = all)"] = "Chỉ dùng thuốc lên các trứng này (trống = tất cả)",
    ["Auto Wisp"] = "Tự Động Nhặt Wisp", ["Auto Banjo Cricket"] = "Tự Động Bắt Dế Banjo",
    ["Chase Settings"] = "Cài Đặt Đuổi Đánh", ["Chase Cài Đặt"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh", ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Đòn Đánh (Hit Lead)", ["Stand further ahead of the target (i.e. or closer to them)"] = "Đứng đón đầu mục tiêu xa hơn (hoặc áp sát gần hơn)",
    ["Hit Sweep"] = "Góc Quét Đòn Đánh (Hit Sweep)", ["How far you swipe back and forth in front of the target"] = "Khoảng cách vung vũ khí quét qua lại trước mục tiêu",
    ["Add/Remove Hits On Quick Bar 2"] = "Thêm/Bỏ Nút Đánh Vào Quick Bar 2", ["Pin or unpin the hit toggles on Quick Bar 2"] = "Ghim hoặc bỏ ghim các nút đánh trên Quick Bar 2",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất", ["Auto Hit Egg Holders"] = "Tự Đánh Người Đang Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định", ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)", ["Instant Prompts"] = "Tương Tác Phím Nhanh (Instant E)",
    ["Speed Boost"] = "Tăng Tốc Chạy", ["Boost Speed"] = "Tốc Độ Tăng Tốc", ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)", ["Makes you invisible to other players"] = "Làm bạn vô hình trước người chơi khác",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)", ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không thể bắt được bạn",
    ["ESP Eggs"] = "ESP Trứng", ["ESP Fixed Size"] = "Cỡ ESP Cố Định", ["ESP Own Base Eggs"] = "Hiện Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiển thị cả trứng đã đặt tại căn cứ của bạn",
    ["ESP Min Rarity"] = "Độ Hiếm ESP Min", ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm đã chọn trở lên",
    ["ESP Show Info"] = "Hiện Thông Tin ESP", ["Min ESP Value"] = "Giá Trị ESP Min",
    ["ESP Egg Size"] = "Cỡ ESP Trứng", ["ESP Guards"] = "ESP Vệ Sĩ", ["ESP Guard Size"] = "Cỡ ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi", ["ESP Players"] = "ESP Người Chơi",
    ["ESP Player Info"] = "Thông Tin ESP Người Chơi", ["ESP Player Size"] = "Cỡ ESP Người Chơi",
    ["Search eggs..."] = "Tìm kiếm trứng...", ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",
    ["Biohazard Pets"] = "Pet Phóng Xạ (Biohazard)", ["CURRENT RECIPE"] = "CÔNG THỨC HIỆN TẠI",
    ["REWARD ODDS - BIOHAZARD PETS"] = "TỈ LỆ THƯỞNG - PET PHÓNG XẠ", ["Chase pet"] = "Đuổi bắt pet",
    ["Machine is empty"] = "Máy đang trống", ["Load 3 pets of the same species to see the result odds"] = "Đặt 3 pet cùng loài vào máy để xem tỉ lệ kết quả",
    ["Sort By"] = "Sắp Xếp Theo", ["Preview Card"] = "Thẻ Xem Trước",
    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng (Trail)", ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng có sẵn khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ", ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập", ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim"] = "Tự Nhận Thưởng", ["Claim offline money & index rewards"] = "Nhận tiền tích lũy offline & thưởng sách pet",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Sách Pet", ["Claim index rewards as soon as they unlock"] = "Tự động nhận thưởng sách ngay khi mở khóa",
    ["Auto Load Script"] = "Tự Động Nạp Script", ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Server Hop"] = "Đổi Server", ["Job ID"] = "Mã Phòng (Job ID)", ["Paste a server Job ID..."] = "Dán mã Job ID của server...",
    ["Join Job ID"] = "Vào Bằng Job ID", ["Copy Current Job ID"] = "Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Server", ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",
    ["FPS Cap"] = "Giới Hạn FPS", ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping", ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D", ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",
    ["Joins new servers to find eggs that match the filters below"] = "Tự đổi server để tìm trứng khớp bộ lọc bên dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Server để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server", ["Rarity To Wait For"] = "Độ Hiếm Cần Giữ Chân",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ nếu xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp", ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với mục Tự Động Cướp",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Value To Find"] = "Giá Trị Trứng Min Cần Tìm", ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu", ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",
    ["Webhook URL"] = "Đường Dẫn Webhook", ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng", ["Post every egg you bring home"] = "Gửi thông báo mỗi quả trứng mang về thành công",
    ["selected"] = "đã chọn"
}

local DYNAMIC_PATTERNS = {
    { pattern = "Catching a (.+) butterfly, (%d+) studs %| (%d+) flying", format = function(lang, name, st, fl) return lang == "VI" and string.format("Đang bắt bướm %s, %s studs | %s đang bay", name, st, fl) or string.format("Catching a %s butterfly, %s studs | %s flying", name, st, fl) end },
    { pattern = "ALL (%d+)", format = function(lang, c) return lang == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end },
    { pattern = "READY (%d+)", format = function(lang, c) return lang == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end },
    { pattern = "GROWING (%d+)", format = function(lang, c) return lang == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end },
    { pattern = "IN BAG (%d+)", format = function(lang, c) return lang == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end },
    { pattern = "#(%d+) of (%d+) eggs by value", format = function(lang, r, total) return lang == "VI" and string.format("Hạng #%s/%s trứng theo giá trị", r, total) or string.format("#%s of %s eggs by value", r, total) end },
    { pattern = "1 in ([%d%.]+)", format = function(lang, val) return lang == "VI" and ("Tỉ lệ 1/" .. val) or ("1 in " .. val) end },
    { pattern = "Ends in (%d+h %d+m %d+s)", format = function(lang, tStr) return lang == "VI" and ("Kết thúc sau " .. tStr) or ("Ends in " .. tStr) end },
    { pattern = "in (%d+h %d+m)", format = function(lang, tStr) return lang == "VI" and ("sau " .. tStr) or ("in " .. tStr) end },
    { pattern = "Banner chance (%d+%.?%d*%%)", format = function(lang, cStr) return lang == "VI" and ("Tỉ lệ Banner " .. cStr) or ("Banner chance " .. cStr) end },
    { pattern = "Pity (%d+)/(%d+)", format = function(lang, p1, p2) return lang == "VI" and string.format("Bảo hiểm %s/%s", p1, p2) or string.format("Pity %s/%s", p1, p2) end },
    { pattern = "Free rerolls (%d+)", format = function(lang, rStr) return lang == "VI" and ("Đổi miễn phí " .. rStr) or ("Free rerolls " .. rStr) end },
    { pattern = "rotates in (%d+:%d+)", format = function(lang, timeStr) return lang == "VI" and ("xoay vòng sau " .. timeStr) or ("rotates in " .. timeStr) end },
    { pattern = "Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag", format = function(lang, p1, p2, p3, p4, p5) return lang == "VI" and string.format("Trứng đã đặt %s/%s - %s/%s pet trang bị, %s trong túi", p1, p2, p3, p4, p5) or string.format("Eggs placed %s/%s - %s/%s pets equipped, %s in bag", p1, p2, p3, p4, p5) end },
    { pattern = "Pet matches %- (%d+) pets? for %$(.+)", format = function(lang, count, val) return lang == "VI" and string.format("Khớp pet - %s pet giá $%s", count, val) or string.format("Pet matches - %s pets for $%s", count, val) end },
    { pattern = "Egg matches %- (%d+) eggs? for %$(.+)", format = function(lang, count, val) return lang == "VI" and string.format("Khớp trứng - %s trứng giá $%s", count, val) or string.format("Egg matches - %s eggs for $%s", count, val) end },
    { pattern = "Lab egg matches %- (%d+) eggs? for %$(.+)", format = function(lang, count, val) return lang == "VI" and string.format("Khớp trứng Lab - %s trứng giá $%s", count, val) or string.format("Lab egg matches - %s eggs for $%s", count, val) end },
    { pattern = "Favorite matches %- (%d+) pets?, (%d+) to mark %| (%d+) favorited", format = function(lang, c1, c2, c3) return lang == "VI" and string.format("Khớp yêu thích - %s pet, %s cần lưu | %s đã khóa", c1, c2, c3) or string.format("Favorite matches - %s pets, %s to mark | %s favorited", c1, c2, c3) end },
    { pattern = "Charges (%d+) Eggs (%d+)/(%d+) Tries (%d+) Applied (%d+)", format = function(lang, c, e1, e2, t, a) return lang == "VI" and string.format("Số lần sạc %s Trứng %s/%s Thử %s Đã dùng %s", c, e1, e2, t, a) or string.format("Charges %s Eggs %s/%s Tries %s Applied %s", c, e1, e2, t, a) end },
    { pattern = "Players (%d+)/(%d+)", format = function(lang, p1, p2) return lang == "VI" and string.format("Người chơi %s/%s", p1, p2) or string.format("Players %s/%s", p1, p2) end },
    { pattern = "Next Mech portal in (%d+:%d+)", format = function(lang, timeStr) return lang == "VI" and ("Cổng Robot mở sau " .. timeStr) or ("Next Mech portal in " .. timeStr) end },
    { pattern = "Next Butterfly Bloom in (%d+:%d+)", format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Bướm nở sau " .. timeStr) or ("Next Butterfly Bloom in " .. timeStr) end },
    { pattern = "Butterfly Bloom live, (%d+:%d+) left", format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Bướm đang diễn ra, còn " .. timeStr) or ("Butterfly Bloom live, " .. timeStr .. " left") end },
    { pattern = "Caught (.+)! %((%d+) owned%)", format = function(lang, name, count) return lang == "VI" and string.format("Đã bắt %s! (Đang có %s con)", name, count) or string.format("Caught %s! (%s owned)", name, count) end }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        local res = replaceAll(raw, "Chilli Hub", "Chilli Hub V2")
        FastCache[cacheKey] = res
        return res
    end

    local trimmed = raw:match("^%s*(.-)%s*$") or raw
    if EXACT_MATCH_VI[trimmed] then
        local res = raw:gsub(trimmed, EXACT_MATCH_VI[trimmed], 1)
        FastCache[cacheKey] = res
        return res
    end

    local result = raw
    local matched = false
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        if result:find(item.pattern) then
            result = result:gsub(item.pattern, function(...) return item.format(currentLanguage, ...) end)
            matched = true
        end
    end

    for _, item in ipairs(SortedVI) do
        if result:find(item.en, 1, true) then
            result = replaceAll(result, item.en, item.out)
            matched = true
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local function applyTranslation(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        pcall(function() inst:SetAttribute("OriginalRawText", original) end)
    end

    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        pcall(function()
            inst:SetAttribute("__IsTranslating", true)
            inst:SetAttribute("__LastTranslatedText", mappedText)
            inst.Text = mappedText
            inst:SetAttribute("__IsTranslating", false)
        end)
    end
end

local function hookElement(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    pcall(function() inst:SetAttribute("HasTranslateHook", true) end)

    task.defer(function() if inst and inst.Parent then applyTranslation(inst) end end)
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        local current = inst.Text
        if current == inst:GetAttribute("__LastTranslatedText") then return end
        pcall(function() inst:SetAttribute("OriginalRawText", current) end)
        applyTranslation(inst)
    end)
end

-- ==================== 4. LÕI ĐỔI MÀU SOFT PASTEL BLUE ====================
local COLOR_FACE_TOP     = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM  = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW = Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["cày cuốc"] = true, ["farm"] = true, ["người chơi"] = true, ["player"] = true,
    ["dự đoán"] = true, ["predictor"] = true, ["tiến trình"] = true, ["progress"] = true,
    ["máy chủ"] = true, ["server"] = true, ["khác"] = true, ["misc"] = true,
    ["tự đổi máy chủ"] = true, ["tự đổi server"] = true, ["auto hop"] = true,
    ["discord"] = true, ["phím tắt & key"] = true, ["quick & keys"] = true,
    ["cài đặt"] = true, ["settings"] = true, ["cấu hình"] = true, ["config"] = true
}

local function recolorSingleButton(btnContainer, labelObj)
    if not btnContainer then return end
    local grad = btnContainer:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = btnContainer
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    btnContainer.BackgroundColor3 = COLOR_FACE_BOTTOM
    if btnContainer.Parent and btnContainer.Parent:IsA("Frame") and btnContainer.Parent ~= btnContainer then
        local p = btnContainer.Parent
        local pCol = p.BackgroundColor3
        if pCol and (pCol.R > 0.4 and pCol.G < 0.35) then p.BackgroundColor3 = COLOR_BEVEL_SHADOW end
    end
    if labelObj and (labelObj:IsA("TextLabel") or labelObj:IsA("TextButton")) then
        labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function recolorHeaderBar(headerFrame, titleObj)
    if not headerFrame then return end
    local grad = headerFrame:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = headerFrame
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    headerFrame.BackgroundColor3 = COLOR_FACE_BOTTOM
    if headerFrame.Parent and headerFrame.Parent:IsA("Frame") then
        local p = headerFrame.Parent
        if p.BackgroundColor3.R > 0.4 and p.BackgroundColor3.G < 0.35 then p.BackgroundColor3 = COLOR_BEVEL_SHADOW end
    end
    if titleObj and (titleObj:IsA("TextLabel") or titleObj:IsA("TextButton")) then
        titleObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    for _, item in ipairs(headerFrame:GetDescendants()) do
        if item:IsA("TextButton") or item:IsA("ImageButton") then
            item.BackgroundColor3 = COLOR_FACE_BOTTOM
            local xGrad = item:FindFirstChildOfClass("UIGradient")
            if xGrad then
                xGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
                    ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
                })
            end
            if item:IsA("TextButton") then item.TextColor3 = Color3.fromRGB(255, 255, 255) end
        end
    end
end

local function inspectAndApplySoftBlue(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end
    local success, textRaw = pcall(function() return inst.Text:lower():match("^%s*(.-)%s*$") or "" end)
    if not success then return end

    if textRaw:find("chilli hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then recolorHeaderBar(headerFrame, inst) end
        return
    end
    if TARGET_BUTTON_KEYWORDS[textRaw] then
        local btnTarget = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton") or inst:FindFirstAncestorOfClass("Frame")
        if btnTarget then recolorSingleButton(btnTarget, inst) end
        return
    end
end

-- ==================== 5. HỆ THỐNG AUTO FARM (OMNI-CLICK OVERRIDE) ====================
local function forceTriggerClick(target)
    if not target then return end
    local targetsToClick = {target}
    if target.Parent then
        table.insert(targetsToClick, target.Parent)
        for _, sib in ipairs(target.Parent:GetChildren()) do
            if sib:IsA("GuiObject") then table.insert(targetsToClick, sib) end
        end
    end
    for _, t in ipairs(targetsToClick) do
        pcall(function()
            if getconnections then
                for _, conn in ipairs(getconnections(t.MouseButton1Click)) do conn:Fire() end
                for _, conn in ipairs(getconnections(t.Activated)) do conn:Fire() end
                for _, conn in ipairs(getconnections(t.InputBegan)) do
                    conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                    conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
                end
                task.wait(0.01)
                for _, conn in ipairs(getconnections(t.InputEnded)) do
                    conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.End})
                    conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.End})
                end
            end
        end)
    end
end

local function isToggleActive(label)
    if not label then return false end
    local row = label.Parent
    if not row then return false end
    local function checkGreen(c) return c and (c.G > 0.45 and c.G > c.R * 1.3 and c.G > c.B * 1.3) end
    
    local elements = {label, row}
    for _, child in ipairs(row:GetDescendants()) do table.insert(elements, child) end
    for _, el in ipairs(elements) do
        if el:IsA("GuiObject") and checkGreen(el.BackgroundColor3) then return true end
    end
    return false
end

local PRESET_TOGGLES = {
    { id = "AutoButterfly", target = true, patterns = {"tự động bắt bướm", "auto butterfly bloom"} },
    { id = "AutoSteal", target = true, patterns = {"tự động cướp trứng", "auto steal"}, exclude = {"v2", "zones", "khu vực"} },
    { id = "InstantStealV1", target = false, patterns = {"cướp siêu tốc (instant steal)", "instant steal"}, exclude = {"v2", "steps", "zones", "bước", "khu vực"} },
    { id = "InstantStealV2", target = true, patterns = {"cướp siêu tốc (instant steal) v2", "instant steal v2"} },
    { id = "TeleportToEgg", target = true, patterns = {"teleport to egg", "dịch chuyển đến trứng"} },
    { id = "DropSafeZone", target = false, patterns = {"drop eggs at safe zone", "thả trứng tại vùng an toàn"} },
    { id = "AntiGuardPanel", target = true, patterns = {"bảng chống vệ sĩ", "anti guard panel"} },
    { id = "AutoTreadmill", target = true, patterns = {"tự động máy tập", "auto treadmill"}, exclude = {"cố định", "stay", "nâng cấp", "upgrade"} },
    { id = "StayTreadmill", target = true, patterns = {"cố định trên máy tập", "stay on treadmill"} }
}

local PRESET_DROPDOWNS = {
    { id = "CatchMode", targetText = {"đuổi theo", "chase"}, rowPatterns = {"chế độ bắt", "catch mode"} },
    { id = "CatchPriority", targetText = {"gần nhất", "nearest"}, rowPatterns = {"ưu tiên bắt", "catch priority"} },
    { id = "MinRarity", targetText = {"bí ẩn (secret)", "secret"}, rowPatterns = {"min rarity", "độ hiếm min", "độ hiếm"} },
    { id = "CatchButterflies", selectAll = true, rowPatterns = {"chọn bướm cần bắt", "catch butterflies"}, itemPatterns = {"radiant", "amethyst", "sapphire", "emerald"} }
}

local function stripTags(str) return str:gsub("<[^>]+>", "") end

local function findMatchingLabel(patterns, excludeList)
    local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
    pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
    for _, root in ipairs(searchRoots) do
        if root then
            for _, desc in ipairs(root:GetDescendants()) do
                if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and not desc:FindFirstAncestor("Chilli_Dynamic_Island") then
                    local t = stripTags(desc.Text:lower())
                    local matched = false
                    for _, p in ipairs(patterns) do
                        if t == p:lower() or t:find(p:lower(), 1, true) then matched = true; break end
                    end
                    if matched and excludeList then
                        for _, ex in ipairs(excludeList) do
                            if t:find(ex:lower(), 1, true) then matched = false; break end
                        end
                    end
                    if matched then return desc end
                end
            end
        end
    end
    return nil
end

local function findDropdownOptionGlobal(targets)
    local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
    pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
    for _, root in ipairs(searchRoots) do
        if root then
            for _, desc in ipairs(root:GetDescendants()) do
                if (desc:IsA("TextButton") or desc:IsA("TextLabel")) and not desc:FindFirstAncestor("Chilli_Dynamic_Island") then
                    local dt = stripTags(desc.Text:lower())
                    for _, opt in ipairs(targets) do
                        if dt == opt:lower() or dt:find(opt:lower(), 1, true) then
                            local btn = desc:IsA("TextButton") and desc or desc:FindFirstAncestorOfClass("TextButton")
                            if btn then return btn end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function selectDropdownOption(cfg)
    local label = findMatchingLabel(cfg.rowPatterns)
    if not label then return end
    
    if cfg.selectAll and cfg.itemPatterns then
        forceTriggerClick(label)
        task.wait(0.2)
        for _, itemPat in ipairs(cfg.itemPatterns) do
            local optBtn = findDropdownOptionGlobal({itemPat})
            if optBtn and not isToggleActive(optBtn) then 
                forceTriggerClick(optBtn); task.wait(0.05) 
            end
        end
    elseif cfg.targetText then
        local optBtn = findDropdownOptionGlobal(cfg.targetText)
        if optBtn then
            if not isToggleActive(optBtn) then forceTriggerClick(optBtn) end
        else
            forceTriggerClick(label)
            task.wait(0.2)
            local retryBtn = findDropdownOptionGlobal(cfg.targetText)
            if retryBtn then forceTriggerClick(retryBtn) end
        end
    end
end

local SavedState = { toggles = {} }
local isAutoFarmActive = false

local function applyAutoFarmSettings(enable)
    if enable then
        SavedState.toggles = {}
        for _, cfg in ipairs(PRESET_TOGGLES) do
            local label = findMatchingLabel(cfg.patterns, cfg.exclude)
            if label then SavedState.toggles[cfg.id] = isToggleActive(label) end
        end

        for _, cfg in ipairs(PRESET_TOGGLES) do
            local label = findMatchingLabel(cfg.patterns, cfg.exclude)
            if label and isToggleActive(label) ~= cfg.target then
                forceTriggerClick(label); task.wait(0.05)
            end
        end

        for _, cfg in ipairs(PRESET_DROPDOWNS) do
            selectDropdownOption(cfg); task.wait(0.05)
        end
    else
        for _, cfg in ipairs(PRESET_TOGGLES) do
            local saved = SavedState.toggles[cfg.id]
            if saved ~= nil then
                local label = findMatchingLabel(cfg.patterns, cfg.exclude)
                if label and isToggleActive(label) ~= saved then
                    forceTriggerClick(label); task.wait(0.05)
                end
            end
        end
    end
end

-- ==================== 6. RAINBOW DYNAMIC ISLAND UI ====================
local function createDynamicIslandUI()
    pcall(function()
        if CoreGui:FindFirstChild("Chilli_Dynamic_Island") then CoreGui.Chilli_Dynamic_Island:Destroy() end
        if LocalPlayer.PlayerGui:FindFirstChild("Chilli_Dynamic_Island") then LocalPlayer.PlayerGui.Chilli_Dynamic_Island:Destroy() end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Dynamic_Island"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    AttachSafeUI(ScreenGui)

    local Island = Instance.new("Frame")
    Island.Name = "Island"
    Island.Size = UDim2.new(0, 150, 0, 32)
    Island.AnchorPoint = Vector2.new(0.5, 0)
    Island.Position = UDim2.new(0.5, 0, 0, 12)
    Island.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    Island.BackgroundTransparency = 0.05
    Island.BorderSizePixel = 0
    Island.ClipsDescendants = true
    Island.Parent = ScreenGui

    Instance.new("UICorner", Island).CornerRadius = UDim.new(0, 16)

    local IslandStroke = Instance.new("UIStroke")
    IslandStroke.Thickness = 2
    IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    IslandStroke.Parent = Island

    local RainbowGradient = Instance.new("UIGradient")
    RainbowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 60, 60)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 160, 40)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 230, 50)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 240, 120)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(45, 180, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(180, 70, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 60, 60))
    })
    RainbowGradient.Parent = IslandStroke

    RunService.RenderStepped:Connect(function()
        RainbowGradient.Rotation = (RainbowGradient.Rotation + 2) % 360
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 32)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Island

    local IconBadge = Instance.new("Frame")
    IconBadge.Size = UDim2.new(0, 22, 0, 22)
    IconBadge.Position = UDim2.new(0, 6, 0.5, -11)
    IconBadge.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    IconBadge.BorderSizePixel = 0
    IconBadge.Parent = TopBar
    Instance.new("UICorner", IconBadge).CornerRadius = UDim.new(1, 0)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌶️"
    Icon.TextSize = 13
    Icon.Parent = IconBadge

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -65, 1, 0)
    Title.Position = UDim2.new(0, 32, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Chilli V2"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 11
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local StatusDot = Instance.new("Frame")
    StatusDot.Size = UDim2.new(0, 7, 0, 7)
    StatusDot.Position = UDim2.new(1, -38, 0.5, -3.5)
    StatusDot.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
    StatusDot.BorderSizePixel = 0
    StatusDot.Parent = TopBar
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    local ArrowBadge = Instance.new("TextLabel")
    ArrowBadge.Size = UDim2.new(0, 20, 1, 0)
    ArrowBadge.Position = UDim2.new(1, -26, 0, 0)
    ArrowBadge.BackgroundTransparency = 1
    ArrowBadge.Text = "▼"
    ArrowBadge.Font = Enum.Font.GothamBold
    ArrowBadge.TextSize = 10
    ArrowBadge.TextColor3 = Color3.fromRGB(180, 195, 220)
    ArrowBadge.Parent = TopBar

    local TriggerBtn = Instance.new("TextButton")
    TriggerBtn.Size = UDim2.new(1, 0, 1, 0)
    TriggerBtn.BackgroundTransparency = 1
    TriggerBtn.Text = ""
    TriggerBtn.ZIndex = 15
    TriggerBtn.Parent = TopBar

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -16, 0, 96)
    ContentFrame.Position = UDim2.new(0, 8, 0, 36)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Island

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)
    Layout.Parent = ContentFrame

    local LangSegment = Instance.new("Frame")
    LangSegment.Size = UDim2.new(1, 0, 0, 28)
    LangSegment.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
    LangSegment.BorderSizePixel = 0
    LangSegment.LayoutOrder = 1
    LangSegment.Parent = ContentFrame
    Instance.new("UICorner", LangSegment).CornerRadius = UDim.new(1, 0)

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -3, 1, -4)
    LangSlider.Position = UDim2.new(0, 2, 0.5, -12)
    LangSlider.BackgroundColor3 = COLOR_FACE_BOTTOM
    LangSlider.BorderSizePixel = 0
    LangSlider.Parent = LangSegment
    Instance.new("UICorner", LangSlider).CornerRadius = UDim.new(1, 0)

    local SliderGrad = Instance.new("UIGradient")
    SliderGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLOR_FACE_TOP), ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)})
    SliderGrad.Rotation = 90
    SliderGrad.Parent = LangSlider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 VIE"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = LangSegment

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENG"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
    BtnEN.ZIndex = 5
    BtnEN.Parent = LangSegment

    local function setLanguage(lang)
        if currentLanguage == lang then return end
        currentLanguage = lang
        if lang == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -12), BackgroundColor3 = COLOR_FACE_BOTTOM}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 1, 0.5, -12), BackgroundColor3 = Color3.fromRGB(50, 65, 90)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        end
        local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
        for _, root in ipairs(searchRoots) do
            if root then
                for _, desc in ipairs(root:GetDescendants()) do
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        task.defer(function() applyTranslation(desc) end)
                    end
                end
            end
        end
    end

    BtnVI.Activated:Connect(function() setLanguage("VI") end)
    BtnEN.Activated:Connect(function() setLanguage("EN") end)

    local AutoFarmCard = Instance.new("Frame")
    AutoFarmCard.Size = UDim2.new(1, 0, 0, 42)
    AutoFarmCard.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
    AutoFarmCard.BorderSizePixel = 0
    AutoFarmCard.LayoutOrder = 2
    AutoFarmCard.Parent = ContentFrame
    Instance.new("UICorner", AutoFarmCard).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", AutoFarmCard).Color = Color3.fromRGB(45, 60, 85)

    local FarmTitle = Instance.new("TextLabel")
    FarmTitle.Size = UDim2.new(1, -55, 0, 18)
    FarmTitle.Position = UDim2.new(0, 8, 0, 4)
    FarmTitle.BackgroundTransparency = 1
    FarmTitle.Text = "Settings Auto Farm"
    FarmTitle.Font = Enum.Font.GothamBold
    FarmTitle.TextSize = 10
    FarmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmTitle.TextXAlignment = Enum.TextXAlignment.Left
    FarmTitle.Parent = AutoFarmCard

    local FarmSub = Instance.new("TextLabel")
    FarmSub.Size = UDim2.new(1, -55, 0, 14)
    FarmSub.Position = UDim2.new(0, 8, 0, 22)
    FarmSub.BackgroundTransparency = 1
    FarmSub.Text = "Chuẩn theo 4 ảnh (Bật/Khôi phục)"
    FarmSub.Font = Enum.Font.GothamMedium
    FarmSub.TextSize = 8
    FarmSub.TextColor3 = Color3.fromRGB(130, 150, 180)
    FarmSub.TextXAlignment = Enum.TextXAlignment.Left
    FarmSub.Parent = AutoFarmCard

    local FarmToggle = Instance.new("TextButton")
    FarmToggle.Size = UDim2.new(0, 36, 0, 20)
    FarmToggle.Position = UDim2.new(1, -42, 0.5, -10)
    FarmToggle.BackgroundColor3 = Color3.fromRGB(38, 44, 58)
    FarmToggle.Text = ""
    FarmToggle.ZIndex = 12
    FarmToggle.Parent = AutoFarmCard
    Instance.new("UICorner", FarmToggle).CornerRadius = UDim.new(1, 0)

    local FarmKnob = Instance.new("Frame")
    FarmKnob.Size = UDim2.new(0, 14, 0, 14)
    FarmKnob.Position = UDim2.new(0, 3, 0.5, -7)
    FarmKnob.BackgroundColor3 = Color3.fromRGB(200, 205, 215)
    FarmKnob.BorderSizePixel = 0
    FarmKnob.Parent = FarmToggle
    Instance.new("UICorner", FarmKnob).CornerRadius = UDim.new(1, 0)

    FarmToggle.Activated:Connect(function()
        isAutoFarmActive = not isAutoFarmActive
        if isAutoFarmActive then
            TweenService:Create(FarmKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(FarmToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 205, 110)}):Play()
            FarmSub.Text = "Đang áp dụng cấu hình..."
            TweenService:Create(FarmSub, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(90, 240, 150)}):Play()
            TweenService:Create(StatusDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 255, 120)}):Play()
            task.spawn(function()
                applyAutoFarmSettings(true)
                FarmSub.Text = "Đã bật cấu hình chuẩn 4 ảnh"
            end)
        else
            TweenService:Create(FarmKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Color3.fromRGB(200, 205, 215)}):Play()
            TweenService:Create(FarmToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(38, 44, 58)}):Play()
            FarmSub.Text = "Đang khôi phục ban đầu..."
            TweenService:Create(FarmSub, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 150, 180)}):Play()
            TweenService:Create(StatusDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 130, 150)}):Play()
            task.spawn(function()
                applyAutoFarmSettings(false)
                FarmSub.Text = "Đã khôi phục trạng thái cũ"
            end)
        end
    end)

    local isExpanded = false
    local isTweening = false

    local function toggleIsland()
        if isTweening then return end
        isTweening = true
        isExpanded = not isExpanded
        TweenService:Create(Island, TweenInfo.new(0.08), {Size = UDim2.new(0, isExpanded and 140 or 255, 0, isExpanded and 30 or 120)}):Play()
        task.wait(0.08)
        if isExpanded then
            TweenService:Create(ArrowBadge, TweenInfo.new(0.3), {Rotation = 180}):Play()
            local tweenExp = TweenService:Create(Island, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 245, 0, 120)})
            tweenExp:Play()
            tweenExp.Completed:Connect(function() isTweening = false end)
        else
            TweenService:Create(ArrowBadge, TweenInfo.new(0.3), {Rotation = 0}):Play()
            local tweenCol = TweenService:Create(Island, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 150, 0, 32)})
            tweenCol:Play()
            tweenCol.Completed:Connect(function() isTweening = false end)
        end
    end

    TriggerBtn.Activated:Connect(toggleIsland)

    local dragging, dragStart, startPos = false, nil, nil
    Island.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Island.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Island.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            if delta.Magnitude > 8 then
                local cam = workspace.CurrentCamera
                local maxX = cam and cam.ViewportSize.X - 245 or 800
                local maxY = cam and cam.ViewportSize.Y - 120 or 600
                local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)
                Island.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
            end
        end
    end)
end

-- ==================== 7. KHỞI ĐỘNG VÀ QUÉT ĐA TẦNG ====================
task.spawn(function()
    createDynamicIslandUI()
    local function processRootChunked(root)
        if not root then return end
        local function inspectTree(parent)
            local children = parent:GetChildren()
            for i, desc in ipairs(children) do
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                    inspectAndApplySoftBlue(desc)
                end
                if i % 30 == 0 then RunService.RenderStepped:Wait() end
                inspectTree(desc)
            end
        end
        pcall(function() inspectTree(root) end)
        root.DescendantAdded:Connect(function(desc)
            task.defer(function()
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                    inspectAndApplySoftBlue(desc)
                end
            end)
        end)
    end
    local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
    pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
    for _, r in ipairs(searchRoots) do processRootChunked(r) end
end)
