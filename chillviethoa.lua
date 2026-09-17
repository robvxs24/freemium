-- ==============================================================================
--  CHILLI HUB - ZERO-LAG TRIPLE LANGUAGE ENGINE V6.0 (EN / VI / PH)
--  Tối ưu hóa:
--    1. Nạp đúng luồng script gốc Chilli Hub (StealAnEgg).
--    2. Bổ sung ngôn ngữ Filipino (Philippines) với chuẩn Taglish game thủ.
--    3. Plain-Text Replacer: Chống lỗi 100% ký tự đặc biệt (), $.
--    4. Vòng xoay ngôn ngữ 3 chế độ (Anh -> Việt -> Phi).
--    5. Nút bấm Frosted Slate tối giản, không tụt FPS khi khởi chạy.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local currentLanguage = "VI" -- Bắt đầu bằng Tiếng Việt (EN, VI, PH)
local translationLock = false
local FastCache = {}

local function safeReplace(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    if startIdx then
        return str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
    end
    return str
end

-- ==================== 1. TỪ ĐIỂN TIẾNG VIỆT ====================
local MAP_VI = {
    ["Farm"] = "Cày Cuốc", ["Player"] = "Người Chơi", ["Egg Finder"] = "Máy Dò Trứng",
    ["Predictor"] = "Soi Trứng", ["Progress"] = "Tiến Độ", ["Server"] = "Máy Chủ",
    ["Misc"] = "Linh Tinh", ["Creator"] = "Tác Giả", ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt", ["Settings"] = "Cài Đặt", ["Config"] = "Cấu Hình",
    ["Farm Tab > Auto Steal"] = "Tab Cày Cuốc > Tự Động Cướp",
    ["Farm Tab > Auto Place Egg"] = "Tab Cày Cuốc > Tự Đặt Trứng",
    ["Farm Tab > Auto Treadmill"] = "Tab Cày Cuốc > Tự Chạy Máy Tập",
    ["Farm Tab > Auto Hatch & Equip"] = "Tab Cày Cuốc > Tự Ấp & Thay Thú",
    ["Farm Tab > Auto Sell"] = "Tab Cày Cuốc > Tự Động Bán",
    ["Farm Tab > Auto Fuse Machine"] = "Tab Cày Cuốc > Tự Máy Ghép",
    ["Farm Tab > Auto Favorite"] = "Tab Cày Cuốc > Tự Khóa Thú",
    ["Farm Tab > Auto Rift & Boss"] = "Tab Cày Cuốc > Tự Động Rift & Boss",
    ["Player Tab > ESP"] = "Tab Người Chơi > Xuyên Tường (ESP)",
    ["Player Tab > Movement"] = "Tab Người Chơi > Di Chuyển",
    ["Player Tab > Character"] = "Tab Người Chơi > Nhân Vật",
    ["Egg Finder Tab > Egg Finder"] = "Tab Tìm Trứng > Máy Dò Trứng",
    ["Predictor Tab > Discord Webhook"] = "Tab Dự Đoán > Webhook Discord",
    ["Predictor Tab > Egg Predictor"] = "Tab Dự Đoán > Soi Trứng",
    ["Predictor Tab > Fuse Predictor"] = "Tab Dự Đoán > Soi Tỷ Lệ Ghép",
    ["Progress Tab > Auto Progression"] = "Tab Tiến Độ > Tự Động Thăng Tiến",
    ["Server Tab > Server"] = "Tab Máy Chủ > Máy Chủ",
    ["Misc Tab > Performance"] = "Tab Linh Tinh > Hiệu Năng",
    ["Misc Tab > Utility"] = "Tab Linh Tinh > Tiện Ích",
    ["Discord Tab > Creator Event"] = "Tab Discord > Sự Kiện Tác Giả",
    ["Discord Tab > Community"] = "Tab Discord > Cộng Đồng",
    ["Quick & Keys Tab > Quick Access"] = "Tab Phím Tắt > Truy Cập Nhanh",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Tab Phím Tắt > Thanh Nhanh & Gán Phím",
    ["Settings Tab > Interface"] = "Tab Cài Đặt > Giao Diện",
    ["Settings Tab > Defaults"] = "Tab Cài Đặt > Mặc Định",
    ["Config Tab > Config"] = "Tab Cấu Hình > Cấu Hình",
    ["Config Tab > Profiles"] = "Tab Cấu Hình > Hồ Sơ",
    ["Config Tab > Import/Export"] = "Tab Cấu Hình > Nhập/Xuất",
    ["Auto Steal"] = "Tự Động Cướp", ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Rarity"] = "Độ Hiếm Tối Thiểu", ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng từ độ hiếm đã chọn trở lên",
    ["Min Value To Steal"] = "Giá Trị Cướp Tối Thiểu", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Target Specific Eggs"] = "Nhắm Trứng Cụ Thể", ["Only steal these eggs (empty = all)"] = "Chỉ cướp những trứng này (Trống = Tất cả)",
    ["Prioritize Rift Recipe Eggs"] = "Ưu Tiên Trứng Rift", ["Steal eggs the Rift recipe needs first"] = "Cướp trứng cần cho Rift trước",
    ["Steal Priority"] = "Ưu Tiên Cướp", ["Highest Value"] = "Giá Trị Cao Nhất",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)", ["Anti Guard V1"] = "Chống Vệ Sĩ V1",
    ["Not recommended to use with Auto Steal"] = "Không khuyên dùng cùng Tự Động Cướp",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng", ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Priority"] = "Ưu Tiên Đặt Trứng", ["Biggest Size"] = "Kích Thước Lớn Nhất",
    ["Always"] = "Luôn Luôn", ["Auto Treadmill"] = "Tự Chạy Máy Tập",
    ["Stay On Treadmill"] = "Giữ Trên Máy Tập", ["Re-mount the belt whenever the ride drops"] = "Tự trèo lên lại nếu bị rớt",
    ["Auto Hatch & Equip"] = "Tự Ấp & Thay Thú", ["Auto Hatch"] = "Tự Động Ấp",
    ["Auto Equip Best"] = "Tự Mặc Đồ Xịn Nhất", ["Equip Best when a better pet appears"] = "Tự đổi thú xịn hơn khi có",
    ["Auto Sell"] = "Tự Động Bán", ["Auto Sell Pet"] = "Tự Động Bán Thú",
    ["Sell Pets Now"] = "Bán Thú Ngay", ["Sell Pet Rule"] = "Quy Tắc Bán Thú",
    ["Which checks must pass to sell"] = "Điều kiện cần thỏa mãn để bán", ["Rarity Only"] = "Chỉ Xét Độ Hiếm",
    ["Pet Max Rarity"] = "Độ Hiếm Thú Tối Đa", ["Sell pets at or below this rarity"] = "Bán thú từ độ hiếm này trở xuống",
    ["Pet Value Threshold"] = "Ngưỡng Giá Trị Thú", ["Sell pets worth less than this (0 = off)"] = "Bán thú rẻ hơn mức này (0 = Tắt)",
    ["Keep Mutated Pets"] = "Giữ Thú Đột Biến", ["Never sell mutated pets"] = "Tuyệt đối không bán thú đột biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen (Không Bán)", ["These pets are never sold"] = "Những thú này sẽ không bao giờ bị bán",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng", ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi theo luật dưới đây",
    ["Sell Eggs Now"] = "Bán Trứng Ngay", ["Sell matching eggs once"] = "Bán trứng đúng điều kiện một lần",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng", ["Egg Max Rarity"] = "Độ Hiếm Trứng Tối Đa",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống", ["Egg Value Threshold"] = "Ngưỡng Giá Trị Trứng",
    ["Sell eggs worth less than this (0 = off)"] = "Bán trứng rẻ hơn mức này (0 = Tắt)", ["Keep Mutated Eggs"] = "Giữ Trứng Đột Biến",
    ["Never sell mutated eggs"] = "Tuyệt đối không bán trứng đột biến", ["Blacklist Sell Eggs"] = "Danh Sách Đen Trứng",
    ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Auto Fuse Machine"] = "Tự Động Máy Ghép", ["Fuse 3 same pets into an egg, nonstop"] = "Liên tục ghép 3 thú giống nhau",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Ghép", ["Lowest Rarity First"] = "Độ Hiếm Thấp Trộn Trước",
    ["Pets To Use"] = "Thú Cưng Sử Dụng", ["Lowest To Highest"] = "Từ Thấp Đến Cao",
    ["Max Rarity to Fuse"] = "Độ Hiếm Ghép Tối Đa", ["Specific Species to Fuse"] = "Chỉ Ghép Loài Thú Này",
    ["Only fuse these species (empty = all)"] = "Chỉ ghép những loài này (Trống = Tất cả)", ["Skip Mutated Pets"] = "Bỏ Qua Thú Đột Biến",
    ["Eject Incomplete Slots"] = "Đẩy Ra Ô Chưa Đủ", ["Take out pets that can't make a set"] = "Lấy ra thú không đủ bộ 3 con",
    ["Auto Favorite"] = "Tự Động Khóa Thú", ["Auto Favorite Pet"] = "Tự Động Khóa Thú",
    ["Favorite pets matching the rules below"] = "Khóa thú thỏa mãn luật bên dưới", ["Favorite Pets Now"] = "Khóa Thú Ngay",
    ["Favorite matching pets once"] = "Khóa thú đúng điều kiện 1 lần", ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Pass any check or all checks"] = "Thỏa 1 điều kiện hoặc tất cả", ["Match All"] = "Khớp Tất Cả",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min", ["Favorite pets of the chosen rarity and every rarity above it"] = "Khóa thú từ độ hiếm này trở lên",
    ["Favorite Mutations"] = "Khóa Thú Đột Biến", ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (Trống = Bỏ qua)",
    ["Favorite Min Value"] = "Giá Trị Khóa Min", ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = Bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Loài Này", ["Always favorite these species"] = "Luôn khóa những loài thú này",
    ["Auto Favorite Equipped"] = "Tự Khóa Thú Đang Dùng", ["Keep equipped pets favorited"] = "Giữ thú đang trang bị ở trạng thái khóa",
    ["Auto Unfavorite Equipped"] = "Tự Mở Khóa Thú Đang Dùng", ["Unfavorite equipped pets not in the rules"] = "Mở khóa nếu không đúng luật",
    ["Favorite Equipped Now"] = "Khóa Thú Đang Dùng Ngay", ["Favorite all equipped pets once"] = "Khóa tất cả thú đang dùng",
    ["Unfavorite Equipped Now"] = "Mở Khóa Thú Đang Dùng Ngay", ["Unfavorite all equipped pets once"] = "Mở khóa tất cả thú đang dùng",
    ["Auto Rift & Boss"] = "Tự Động Rift & Boss", ["Auto Rift Sacrifice"] = "Tự Động Hiến Tế Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Tự nạp 3 thú yêu cầu vào máy Rift", ["Auto Reroll Rift Recipe"] = "Tự Động Đổi Công Thức Rift",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Đổi công thức nếu thiếu thú và còn lượt free", ["Auto Claim Boss Mastery"] = "Tự Nhận Thưởng Boss",
    ["Claim milestone rewards as soon as the kill count allows"] = "Nhận mốc thưởng ngay khi đủ điểm hạ gục", ["Auto Fight Boss"] = "Tự Động Đánh Boss",
    ["Auto Progression"] = "Tự Động Thăng Tiến", ["Auto Buy Trail"] = "Tự Động Mua Vệt Sáng",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng khi đủ tiền", ["Auto Upgrade Base"] = "Tự Động Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi có tiền", ["Auto Upgrade Treadmill"] = "Tự Động Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi có tiền", ["Auto Claim"] = "Tự Động Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền offline & thưởng danh mục",
    ["ESP"] = "Xuyên Tường (ESP)", ["ESP Eggs"] = "Hiển Thị Trứng",
    ["ESP Fixed Size"] = "Cố Định Kích Cỡ ESP", ["ESP Own Base Eggs"] = "Hiển Thị Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiện cả trứng đã đặt trong căn cứ của bạn", ["ESP Min Rarity"] = "Độ Hiếm Tối Thiểu ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm này trở lên", ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["ESP Min Value"] = "Giá Trị ESP Tối Thiểu", ["ESP Egg Size"] = "Kích Cỡ Trứng ESP",
    ["ESP Guards"] = "Hiển Thị Vệ Sĩ", ["ESP Guard Size"] = "Kích Cỡ Vệ Sĩ ESP",
    ["ESP Players"] = "Hiển Thị Người Chơi", ["ESP Player Info"] = "Thông Tin Người Chơi ESP",
    ["ESP Player Size"] = "Kích Cỡ Người Chơi ESP", ["Movement"] = "Di Chuyển",
    ["Speed Boost"] = "Tăng Tốc Di Chuyển", ["Boost Speed"] = "Tốc Độ Tăng Cường",
    ["Infinite Jump"] = "Nhảy Vô Hạn", ["Character"] = "Nhân Vật",
    ["Anti Ragdoll"] = "Chống Ngã (Ragdoll)", ["Anti Trap"] = "Chống Bẫy",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không bắt được bạn", ["Instant Steal"] = "Cướp Tức Thì",
    ["IDLE"] = "ĐANG CHỜ LỆNH", ["Turn on Egg Finder to start hunting"] = "Bật Máy Dò Trứng để bắt đầu săn",
    ["Keep hopping servers until a matching egg is found"] = "Đổi server liên tục tới khi thấy trứng đúng luật", ["Link To Auto Steal Filters"] = "Dùng Chung Bộ Lọc Tự Động Cướp",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Đồng bộ hóa bộ lọc với tab Tự Động Cướp", ["Min Value To Find"] = "Giá Trị Trứng Tối Thiểu",
    ["Hop Only When Rarity Appears"] = "Chỉ Đổi Server Khi Thấy Độ Hiếm Này", ["Wait for the chosen rarity to appear, then hop until night"] = "Chờ độ hiếm xuất hiện, sau đó đổi server liên tục",
    ["Rarity That Must Appear"] = "Độ Hiếm Bắt Buộc Xuất Hiện", ["Hop starts when this rarity or higher appears"] = "Đổi server khi độ hiếm này xuất hiện",
    ["Hop Delay"] = "Độ Trễ Đổi Server", ["Egg Predictor"] = "Soi Trứng (Predictor)",
    ["Sort By"] = "Sắp Xếp Theo", ["Value"] = "Giá Trị",
    ["Preview Card"] = "Xem Thẻ Trước", ["Search eggs..."] = "Tìm kiếm trứng...",
    ["Tap an egg below to preview it"] = "Chạm vào trứng bên dưới để xem chi tiết", ["In inventory"] = "Trong túi",
    ["Hold egg"] = "Đang giữ", ["Fuse Predictor"] = "Soi Tỷ Lệ Ghép (Fuse)",
    ["Machine is empty"] = "Máy đang trống", ["Load 3 pets of the same species to see the result odds"] = "Cho 3 thú cùng loài vào để xem tỷ lệ kết quả",
    ["Search"] = "Tìm Kiếm", ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server", ["Least Players"] = "Ít Người Chơi Nhất",
    ["Server Hop"] = "Đổi Server Ngay", ["Job ID"] = "ID Máy Chủ (Job ID)",
    ["Paste a server Job ID..."] = "Dán ID máy chủ vào đây...", ["Join Job ID"] = "Vào Bằng ID",
    ["Copy Current Job ID"] = "Chép ID Máy Chủ Hiện Tại", ["Rejoin Server"] = "Vào Lại Máy Chủ Này",
    ["Join"] = "Vào", ["Copy"] = "Chép", ["Rejoin"] = "Vào Lại", ["Hop"] = "Chuyển",
    ["Performance"] = "Hiệu Năng", ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa Tối Đa", ["Strip shadows, textures and effects for the highest FPS"] = "Tắt bóng, kết cấu và hiệu ứng để đạt FPS cao nhất",
    ["FPS and Ping"] = "Hiện FPS & Ping", ["FPS and Ping Size"] = "Cỡ Chữ FPS & Ping",
    ["Utility"] = "Tiện Ích", ["Anti AFK"] = "Chống Treo Máy (AFK)",
    ["Creator Event"] = "Sự Kiện Của Tác Giả", ["INVITE LINK"] = "LIÊN KẾT MỜI",
    ["Copy Link"] = "Sao Chép Link", ["WHAT YOU GET"] = "BẠN NHẬN ĐƯỢC GÌ",
    ["New Scripts & Updates"] = "Script & Cập Nhật Mới", ["Patch notes and new game scripts are posted there first."] = "Chi tiết cập nhật và script game mới được đăng ở đây đầu tiên.",
    ["Giveaways"] = "Tặng Quà (Giveaways)", ["Member giveaways and events are announced in the server."] = "Sự kiện và phát quà cho thành viên được thông báo trong server.",
    ["Support"] = "Hỗ Trợ", ["Ask for help, report bugs and get answers from the team."] = "Hỏi đáp, báo lỗi và nhận hỗ trợ từ nhóm phát triển.",
    ["Suggestions"] = "Đóng Góp Ý Kiến", ["Request features and vote on what gets added next."] = "Yêu cầu tính năng và bình chọn cập nhật tiếp theo.",
    ["Paste the copied link into your browser or the Discord app to join."] = "Dán link vừa chép vào trình duyệt hoặc app Discord để tham gia.",
    ["Copy Discord Link"] = "Chép Link Discord", ["Click"] = "Bấm",
    ["Quick Access"] = "Truy Cập Nhanh", ["Show Quick Bars"] = "Hiện Thanh Phím Tắt",
    ["Floating quick bars; drag a header to move one"] = "Thanh phím tắt nổi; kéo tiêu đề để di chuyển", ["Visible Quick Bars"] = "Các Thanh Đang Hiện",
    ["Quick Bar Size"] = "Kích Cỡ Thanh Phím Tắt", ["Quick Bar & Keybinds"] = "Thanh Phím Tắt & Gán Nút",
    ["Reset Quick Access"] = "Đặt Lại Truy Cập Nhanh", ["Restore default items, bars and positions"] = "Khôi phục lại vị trí thanh mặc định",
    ["Reset Keybinds"] = "Đặt Lại Nút Gán", ["Restore the defaults set in code"] = "Khôi phục lại nút gán mặc định",
    ["Reset"] = "Đặt Lại", ["Interface"] = "Giao Diện", ["UI Size"] = "Kích Cỡ Giao Diện",
    ["Scales the main window; the corner grip does the same by hand"] = "Đổi cỡ cửa sổ; kéo góc dưới cùng bên phải để đổi thủ công",
    ["Notifications"] = "Bật Thông Báo", ["Show notification cards; turning this off hides every notify"] = "Hiện thẻ thông báo; tắt mục này sẽ ẩn toàn bộ",
    ["Open On Launch"] = "Mở Khi Khởi Chạy", ["Open the UI automatically when the script starts"] = "Tự động hiện bảng menu khi script bắt đầu",
    ["Defaults"] = "Mặc Định", ["Reset to Defaults"] = "Đặt Lại Về Mặc Định",
    ["Reset every feature to its built-in default"] = "Khôi phục mọi tính năng về mặc định gốc", ["Turn Off All Toggles"] = "Tắt Tất Cả Công Tắc",
    ["Switch off every enabled toggle in the feature tabs"] = "Tắt mọi công tắc đang bật trong các tab", ["Turn Off"] = "Tắt Ngay",
    ["Auto Save Config"] = "Tự Động Lưu Cấu Hình", ["Auto Load Config"] = "Tự Động Nạp Cấu Hình",
    ["New Config Name"] = "Tên Cấu Hình Mới", ["Create New Config"] = "Tạo Cấu Hình Mới",
    ["Save Config"] = "Lưu Cấu Hình Hiện Tại", ["Import Config Text"] = "Nhập Mã Văn Bản Cấu Hình",
    ["Destination"] = "Nơi Nhận Thông Báo", ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Notify Egg Finder Match"] = "Báo Khi Máy Dò Khớp Trứng", ["Post the egg Egg Finder stops hopping for"] = "Gửi cảnh báo quả trứng mà Máy Dò vừa tìm được",
    ["Notify Stolen Eggs"] = "Báo Khi Cướp Được Trứng", ["Post every egg you bring home"] = "Gửi thông báo mỗi khi bạn cướp thành công mang về nhà",
    ["None"] = "Không Chọn", ["Off"] = "Tắt", ["Filter features..."] = "Lọc tính năng...",
    ["Favorite"] = "Khóa Lại", ["Unfavorite"] = "Mở Khóa", ["Sell"] = "Bán",
    ["Mythic"] = "Thần Thoại (Mythic)", ["Secret"] = "Bí Ẩn (Secret)", ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)", ["Cosmic"] = "Vũ Trụ (Cosmic)", ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Window Minimized - Click bubble to restore"] = "Cửa sổ đã thu nhỏ - Bấm bong bóng để mở lại",
    ["Let's Chat!"] = "Trò Chuyện Nào!", ["Connecting to Global Script Chat..."] = "Đang kết nối chat thế giới...",
    ["Send"] = "Gửi", ["Live"] = "Trực Tiếp", ["Spoof anti cheat success!"] = "Đã vượt qua Anti-Cheat thành công!",
    ["Fetching..."] = "Đang Tải Dữ Liệu...", ["Loaded"] = "Đã Nạp Xong",
    ["Teleport Mode [Gold/Premium]"] = "Dịch Chuyển [Gold/VIP]", ["Force Speed To (0 = Auto / Q"] = "Ép Tốc Độ (0 = Tự Động / Q)",
    ["Force Speed To"] = "Ép Tốc Độ", ["Manual Steal (Instant Carry)"] = "Cướp Thủ Công (Nhặt Tức Thì)",
    ["Instant Carry (Manual Steal)"] = "Nhặt Tức Thì (Thủ Công)", ["Instant Carry Rarities"] = "Độ Hiếm Nhặt Tức Thì",
    ["Pet Names (Auto Place)"] = "Tên Thú Cưng (Tự Đặt)", ["All (none)"] = "Tất Cả (Không Chọn)",
    ["Rarities"] = "Độ Hiếm", ["Areas"] = "Khu Vực", ["Priority"] = "Ưu Tiên", ["Rarity"] = "Độ Hiếm",
    ["Min Egg KG (0 = off)"] = "KG Trứng Tối Thiểu (0 = Tắt)", ["Automation & Egg Management"] = "Tự Động & Quản Lý Trứng",
    ["Auto Hatch Ready"] = "Tự Ấp Trứng Sẵn Sàng", ["Auto Place All Egg"] = "Tự Đặt Mọi Quả Trứng",
    ["Auto Place Selected (By Pet Names Filter)"] = "Tự Đặt Trứng Chọn Theo Tên Thú",
    ["Auto Steal from other players [Gold/Premium]"] = "Tự Cướp Từ Người Khác [Gold/VIP]",
    ["Automatically target players carrying eggs"] = "Tự Nhắm Người Đang Cầm Trứng",
    ["Filter Rarity for Steal"] = "Lọc Độ Hiếm Để Cướp",
    ["Steal from special for player (Teleport Strike)"] = "Cướp Đặc Biệt (Đòn Dịch Chuyển)",
    ["Steal History"] = "Lịch Sử Cướp", ["History of Stolen Eggs from Players"] = "Lịch Sử Cướp Trứng Phiên Này",
    ["Clear"] = "Xóa", ["No player steals recorded yet this session."] = "Chưa có lượt cướp nào trong phiên.",
    ["In Safe Zone"] = "Trong Vùng An Toàn", ["No Egg Carried"] = "Không Cầm Trứng", ["Locked"] = "Đã Khóa",
    ["STOLEN EGGS"] = "TRỨNG ĐÃ CƯỚP", ["HUNTED TARGETS"] = "MỤC TIÊU ĐÃ SĂN",
    ["Reset Session Counter"] = "Đặt Lại Bộ Đếm Phiên", ["Live Engine"] = "Đang Hoạt Động",
    ["Bag Inventory & Live Value"] = "Túi Đồ & Giá Trị Thực", ["TOTAL VALUE IN BAG"] = "TỔNG GIÁ TRỊ TÚI",
    ["TOTAL ITEMS IN BAG"] = "TỔNG SỐ LƯỢNG TÚI", ["Sell Egg Settings"] = "Cài Đặt Bán Trứng",
    ["Sell Below Value (cth 100M, ..."] = "Bán Dưới Mức Giá (VD: 100M,...)", ["Sell Below KG (0=off)"] = "Bán Dưới KG (0 = Tắt)",
    ["Pet Names (per area)"] = "Tên Thú (Theo Khu Vực)", ["Select Pet to Fuse"] = "Chọn Thú Cưng Để Ghép",
    ["Refresh Inventory Pets"] = "Làm Mới Túi Thú Cưng", ["List Player Need Partner"] = "Danh Sách Người Cần Ghép",
    ["Find Partner (Register) [Gold/Premium]"] = "Tìm Bạn Ghép (Đăng Ký) [Gold/VIP]",
    ["Refresh Partner List"] = "Làm Mới Danh Sách Bạn Ghép", ["Broadcast Need Partner [Gold/Premium]"] = "Phát Thông Báo Cần Ghép [Gold/VIP]",
    ["Broadcast a global Notice banner to script users (1-hour cooldown)."] = "Phát thông báo toàn cầu đến người dùng script (Hồi chiêu 1 giờ).",
    ["Filter by Pet Owned (e.g. Pegasus)..."] = "Lọc theo thú đang có (VD: Pegasus)...",
    ["No other players are currently looking for a partner."] = "Hiện không có người chơi nào tìm bạn ghép.",
    ["Rift Live Status & Rotation"] = "Trạng Thái Trực Tiếp & Lượt Đổi Rift", ["Banner: [Verdant] Riftborn"] = "Banner: [Lục Bảo] Riftborn",
    ["Refresh"] = "Làm Mới", ["Recipe egg is still unmatched! Must hatch into pets before Trade-In."] = "Chưa đúng công thức! Cần ấp thành thú trước khi Hiến Tế.",
    ["Open Boss Shop"] = "Mở Cửa Hàng Boss", ["Auto Buy Boss Shop"] = "Tự Mua Shop Boss",
    ["Automation"] = "Tự Động Hóa", ["Target Banners (none = all)"] = "Banner Mục Tiêu (Trống = Tất Cả)",
    ["Boss Rift (Abyss Overlord)"] = "Boss Rift (Chúa Tể Vực Thẳm)", ["Abyss Overlord (Portal Closed)"] = "Chúa Tể Vực Thẳm (Cổng Đang Đóng)",
    ["Boss HP: Waiting for spawn..."] = "Máu Boss: Đang chờ xuất hiện...", ["Boss Glide Speed (studs/s)"] = "Tốc Độ Bay Đánh Boss (studs/s)",
    ["Leave Boss Arena (To Safe Zone)"] = "Rời Đấu Trường (Về Vùng An Toàn)", ["Manual Attack (Equip Bat & Swing)"] = "Tấn Công Thủ Công (Cầm Gậy & Vung)",
    ["Quick Actions"] = "Thao Tác Nhanh", ["Place Rift Eggs to Pen"] = "Đặt Trứng Rift Vào Chuồng",
    ["Instant Trade-In Once"] = "Hiến Tế Nhanh 1 Lần", ["Use Free Reroll Now"] = "Dùng Lượt Quay Miễn Phí Ngay",
    ["Buy 1x Mutation Consumable"] = "Mua 1x Thuốc Đột Biến", ["Claim All Available Milestones"] = "Nhận Tất Cả Mốc Thưởng",
    ["Teleport to Rift Machine"] = "Dịch Chuyển Đến Máy Rift", ["Refresh Status"] = "Làm Mới Trạng Thái",
    ["Session Stats"] = "Thống Kê Phiên", ["Rift Sacrifices"] = "Lượt Hiến Tế Rift", ["RIFT SACRIFICES"] = "LƯỢT HIẾN TẾ RIFT",
    ["Guard"] = "Thú Cưỡi", ["Light Dark"] = "Quang Ám Long", ["Hunt & Stash Settings"] = "Cài Đặt Săn & Giấu Đồ",
    ["Drop Egg Before Safe Zone"] = "Thả Trứng Trước Vùng An Toàn", ["Do Not Deliver to Safe Zone"] = "Không Nộp Vào Vùng An Toàn",
    ["Never Drop the Egg"] = "Tuyệt Đối Không Làm Rơi Trứng", ["Staging Controls"] = "Điều Khiển Điểm Trung Chuyển",
    ["Set Staging Spot (Here)"] = "Đặt Điểm Trung Chuyển (Tại Đây)", ["Deliver Stash Now"] = "Nộp Toàn Bộ Trứng Đang Giấu",
    ["Uncap FPS, Lighting Compatibility, SmoothPlastic, & Native Low Settings"] = "Mở khóa FPS, Tối ưu ánh sáng, Bật Nhựa Mịn & Giảm đồ họa",
    ["Re-apply Boost Now"] = "Kích Hoạt Lại Tăng Tốc Ngay", ["Visual & Clean Up"] = "Hình Ảnh & Dọn Dẹp Bản Đồ",
    ["Delete other player pet and egg"] = "Ẩn Thú Cưng & Trứng Người Khác",
    ["Hapus visual pet & telur dari player lain (Aman: telur area tetap ada)"] = "Xóa hình ảnh thú & trứng người khác (An toàn: trứng khu vực vẫn giữ)",
    ["Auto Execute"] = "Tự Khởi Chạy", ["Hop Now (Emptiest Server)"] = "Đổi Server Ngay (Phòng Trống Nhất)",
    ["Solo Server"] = "Phòng Đơn", ["Prev"] = "Trước", ["Next"] = "Sau",
    ["Display & Window"] = "Màn Hình & Giao Diện", ["Display Full Size (PC)"] = "Hiển Thị Toàn Màn Hình (PC)",
    ["PC Full Size sets 100% scale for desktop displays. Turn OFF for"] = "Chế độ toàn màn hình 100% cho PC. Hãy TẮT nếu dùng điện thoại",
    ["Anti-AFK Protection"] = "Bảo Vệ Chống Treo Máy (Anti-AFK)",
    ["Prevent idle triggers, 20-min Roblox kick & game soft-teleports with"] = "Ngăn chặn bị văng game sau 20 phút và tránh dịch chuyển mềm",
    ["View Disconnect Log"] = "Xem Nhật Ký Ngắt Kết Nối", ["Clear Disconnect Log"] = "Xóa Nhật Ký Ngắt Kết Nối",
    ["Configuration"] = "Cấu Hình", ["Alert Types"] = "Các Loại Thông Báo",
    ["Periodic Progress"] = "Báo Tiến Trình Định Kỳ", ["Egg Spawn Alert"] = "Báo Trứng Xuất Hiện",
    ["Collect / Claim"] = "Báo Nhặt / Nhận Thưởng", ["Egg Hatched"] = "Báo Trứng Nở",
    ["Pet Obtained"] = "Báo Nhận Thú Cưng", ["Pets Sold"] = "Báo Đã Bán Thú",
    ["Trails Bought"] = "Báo Mua Vệt Sáng", ["Auto Gift Alert"] = "Báo Quà Tự Động",
    ["Rebirth Alert"] = "Báo Chuyển Sinh (Rebirth)", ["Disconnect Alert"] = "Báo Khi Mất Kết Nối",
    ["Alert Filters"] = "Bộ Lọc Cảnh Báo", ["Min Rarity for Alerts"] = "Độ Hiếm Tối Thiểu Để Báo",
    ["Any"] = "Bất Kỳ", ["Manual Actions"] = "Thao Tác Thủ Công",
    ["Send Summary Now"] = "Gửi Báo Cáo Tổng Hợp Ngay", ["Test Webhook"] = "Kiểm Tra Gửi Webhook",
    ["Send Inventory Report"] = "Gửi Báo Cáo Túi Đồ", ["Send Equipped Report"] = "Gửi Báo Cáo Trang Bị"
}

-- ==================== 2. TỪ ĐIỂN FILIPINO (TAGLISH GAMER) ====================
local MAP_PH = {
    ["Farm"] = "Farm", ["Player"] = "Manlalaro", ["Egg Finder"] = "Tagahanap ng Itlog",
    ["Predictor"] = "Tagahula", ["Progress"] = "Pag-unlad", ["Server"] = "Server",
    ["Misc"] = "Iba pa", ["Creator"] = "Lumikha", ["Discord"] = "Discord",
    ["Quick & Keys"] = "Mabilisang Susi", ["Settings"] = "Mga Setting", ["Config"] = "Config",
    ["Farm Tab > Auto Steal"] = "Farm Tab > Auto Nakaw",
    ["Farm Tab > Auto Place Egg"] = "Farm Tab > Auto Lagay ng Itlog",
    ["Farm Tab > Auto Treadmill"] = "Farm Tab > Auto Treadmill",
    ["Farm Tab > Auto Hatch & Equip"] = "Farm Tab > Auto Pusa at Suot",
    ["Farm Tab > Auto Sell"] = "Farm Tab > Auto Benta",
    ["Farm Tab > Auto Fuse Machine"] = "Farm Tab > Auto Fuse Machine",
    ["Farm Tab > Auto Favorite"] = "Farm Tab > Auto Paborito",
    ["Farm Tab > Auto Rift & Boss"] = "Farm Tab > Auto Rift & Boss",
    ["Player Tab > ESP"] = "Player Tab > ESP (X-Ray)",
    ["Player Tab > Movement"] = "Player Tab > Paggalaw",
    ["Player Tab > Character"] = "Player Tab > Karakter",
    ["Egg Finder Tab > Egg Finder"] = "Egg Finder Tab > Tagahanap ng Itlog",
    ["Predictor Tab > Discord Webhook"] = "Predictor Tab > Discord Webhook",
    ["Predictor Tab > Egg Predictor"] = "Predictor Tab > Tagahula ng Itlog",
    ["Predictor Tab > Fuse Predictor"] = "Predictor Tab > Tagahula ng Pag-fuse",
    ["Progress Tab > Auto Progression"] = "Progress Tab > Awtomatikong Pag-unlad",
    ["Server Tab > Server"] = "Server Tab > Server",
    ["Misc Tab > Performance"] = "Misc Tab > Pagganap",
    ["Misc Tab > Utility"] = "Misc Tab > Kagamitan",
    ["Discord Tab > Creator Event"] = "Discord Tab > Kaganapan ng Lumikha",
    ["Discord Tab > Community"] = "Discord Tab > Komunidad",
    ["Quick & Keys Tab > Quick Access"] = "Keys Tab > Mabilisang Access",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Keys Tab > Quick Bar at Keybinds",
    ["Settings Tab > Interface"] = "Settings Tab > Interface",
    ["Settings Tab > Defaults"] = "Settings Tab > Mga Default",
    ["Config Tab > Config"] = "Config Tab > Config",
    ["Config Tab > Profiles"] = "Config Tab > Mga Profile",
    ["Config Tab > Import/Export"] = "Config Tab > Import/Export",
    ["Auto Steal"] = "Auto Nakaw", ["Target Areas"] = "Mga Target na Lugar",
    ["Min Rarity"] = "Pinakamababang Rarity", ["Steal eggs of the chosen rarity and every rarity above it"] = "Nakawin ang itlog ng napiling rarity pataas",
    ["Min Value To Steal"] = "Min na Halaga para Nakawin", ["Skip eggs worth less than this (0 = off)"] = "Laktawan kung mas mababa ang halaga (0 = off)",
    ["Target Specific Eggs"] = "I-target ang Tukoy na Itlog", ["Only steal these eggs (empty = all)"] = "Nakawin lang ang mga itlog na ito (walang laman = lahat)",
    ["Prioritize Rift Recipe Eggs"] = "Unahin ang Itlog para sa Rift", ["Steal eggs the Rift recipe needs first"] = "Unahing nakawin ang kailangan sa Rift",
    ["Steal Priority"] = "Prayoridad sa Pagnanakaw", ["Highest Value"] = "Pinakamataas na Halaga",
    ["Tween Speed"] = "Bilis ng Tween", ["Anti Guard V1"] = "Laban sa Guwardiya V1",
    ["Not recommended to use with Auto Steal"] = "Hindi inirerekomenda kasama ang Auto Nakaw",
    ["Auto Place Egg"] = "Auto Lagay ng Itlog", ["Place Egg Rule"] = "Panuntunan sa Paglagay",
    ["Place Egg Priority"] = "Prayoridad sa Paglagay", ["Biggest Size"] = "Pinakamalaki",
    ["Always"] = "Palagi", ["Auto Treadmill"] = "Auto Treadmill",
    ["Stay On Treadmill"] = "Manatili sa Treadmill", ["Re-mount the belt whenever the ride drops"] = "Sumakay muli kapag nahulog",
    ["Auto Hatch & Equip"] = "Auto Pusa & Suot", ["Auto Hatch"] = "Auto Pusa",
    ["Auto Equip Best"] = "Auto Isuot ang Pinakamaganda", ["Equip Best when a better pet appears"] = "Isuot ang pinakamaganda pag may bagong pet",
    ["Auto Sell"] = "Auto Benta", ["Auto Sell Pet"] = "Auto Benta ng Pet",
    ["Sell Pets Now"] = "Ibenta na ang Pets", ["Sell Pet Rule"] = "Panuntunan sa Pagbenta ng Pet",
    ["Which checks must pass to sell"] = "Mga kondisyon para makapagbenta", ["Rarity Only"] = "Rarity Lang",
    ["Pet Max Rarity"] = "Max Rarity ng Pet", ["Sell pets at or below this rarity"] = "Ibenta ang pets sa rarity na ito pababa",
    ["Pet Value Threshold"] = "Limitasyon ng Halaga ng Pet", ["Sell pets worth less than this (0 = off)"] = "Ibenta ang pets na mas mababa dito (0 = off)",
    ["Keep Mutated Pets"] = "Itago ang Mutated Pets", ["Never sell mutated pets"] = "Huwag ibenta ang mutated pets",
    ["Blacklist Sell Pets"] = "Blacklist sa Pagbenta ng Pet", ["These pets are never sold"] = "Hindi ibebenta ang mga pet na ito",
    ["Auto Sell Egg"] = "Auto Benta ng Itlog", ["Sell bag eggs matching the rules below"] = "Ibenta ang mga itlog sa bag ayon sa rules",
    ["Sell Eggs Now"] = "Ibenta na ang mga Itlog", ["Sell matching eggs once"] = "Ibenta ng isang beses ang tumutugmang itlog",
    ["Sell Egg Rule"] = "Panuntunan sa Pagbenta ng Itlog", ["Egg Max Rarity"] = "Max Rarity ng Itlog",
    ["Sell eggs at or below this rarity"] = "Ibenta ang itlog sa rarity na ito pababa", ["Egg Value Threshold"] = "Limitasyon ng Halaga ng Itlog",
    ["Sell eggs worth less than this (0 = off)"] = "Ibenta ang itlog na mas mababa dito (0 = off)", ["Keep Mutated Eggs"] = "Itago ang Mutated na Itlog",
    ["Never sell mutated eggs"] = "Huwag ibenta ang mutated na itlog", ["Blacklist Sell Eggs"] = "Blacklist sa Pagbenta ng Itlog",
    ["These eggs are never sold"] = "Hindi ibebenta ang mga itlog na ito",
    ["Auto Fuse Machine"] = "Auto Fuse Machine", ["Fuse 3 same pets into an egg, nonstop"] = "Pagsamahin ang 3 parehong pets, tuloy-tuloy",
    ["Fuse Priority Mode"] = "Prayoridad sa Pag-fuse", ["Lowest Rarity First"] = "Pinakamababang Rarity Muna",
    ["Pets To Use"] = "Gagamiting Pets", ["Lowest To Highest"] = "Mababa Hanggang Mataas",
    ["Max Rarity to Fuse"] = "Max Rarity na I-fuse", ["Specific Species to Fuse"] = "Tukoy na Uri na I-fuse",
    ["Only fuse these species (empty = all)"] = "I-fuse lang ang mga uri na ito (walang laman = lahat)", ["Skip Mutated Pets"] = "Laktawan ang Mutated Pets",
    ["Eject Incomplete Slots"] = "I-eject ang Hindi Kumpleto", ["Take out pets that can't make a set"] = "Kunin ang mga pets na hindi makabuo ng set",
    ["Auto Favorite"] = "Auto Paborito", ["Auto Favorite Pet"] = "Auto Paborito ng Pet",
    ["Favorite pets matching the rules below"] = "Paborito ang mga pet ayon sa rules sa ibaba", ["Favorite Pets Now"] = "Paborito na ang Pets",
    ["Favorite matching pets once"] = "Paborito ang tumutugmang pets minsan", ["Favorite Rule"] = "Panuntunan sa Paborito",
    ["Pass any check or all checks"] = "Pumasa sa isa o lahat ng kondisyon", ["Match All"] = "Itugma Lahat",
    ["Favorite Min Rarity"] = "Min Rarity ng Paborito", ["Favorite pets of the chosen rarity and every rarity above it"] = "Paboritong pets mula sa rarity na ito pataas",
    ["Favorite Mutations"] = "Paboritong Mutations", ["Mutation check (empty = skip)"] = "Pagsusuri sa mutation (walang laman = laktawan)",
    ["Favorite Min Value"] = "Min Value ng Paborito", ["Value check (0 = skip)"] = "Pagsusuri sa halaga (0 = laktawan)",
    ["Always Favorite Species"] = "Palaging Paboritong Uri", ["Always favorite these species"] = "Palaging paborito ang mga uring ito",
    ["Auto Favorite Equipped"] = "Auto Paborito ang Nakasuot", ["Keep equipped pets favorited"] = "Panatilihing paborito ang mga nakasuot na pets",
    ["Auto Unfavorite Equipped"] = "Auto Alisin Paborito sa Nakasuot", ["Unfavorite equipped pets not in the rules"] = "Alisin sa paborito kung wala sa rules",
    ["Favorite Equipped Now"] = "Paborito ang Nakasuot Ngayon", ["Favorite all equipped pets once"] = "Paborito ang lahat ng nakasuot minsan",
    ["Unfavorite Equipped Now"] = "Alisin Paborito sa Nakasuot Ngayon", ["Unfavorite all equipped pets once"] = "Alisin sa paborito ang lahat ng nakasuot minsan",
    ["Auto Rift & Boss"] = "Auto Rift at Boss", ["Auto Rift Sacrifice"] = "Auto Sakripisyo sa Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Ipasok ang 3 kinakailangang pets sa Rift", ["Auto Reroll Rift Recipe"] = "Auto Reroll sa Rift Recipe",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Mag-reroll kapag may kulang na pet at may free rerolls pa", ["Auto Claim Boss Mastery"] = "Auto Kunin ang Boss Mastery",
    ["Claim milestone rewards as soon as the kill count allows"] = "Kunin agad ang rewards pag sapat na ang kills", ["Auto Fight Boss"] = "Auto Labanan ang Boss",
    ["Auto Progression"] = "Awtomatikong Pag-unlad", ["Auto Buy Trail"] = "Awtomatikong Bumili ng Trail",
    ["Automatically buy available trails when affordable"] = "Awtomatikong bilhin ang trails kapag kaya na", ["Auto Upgrade Base"] = "Auto I-upgrade ang Base",
    ["Automatically upgrade base when money is available"] = "Awtomatikong i-upgrade ang base pag may pera", ["Auto Upgrade Treadmill"] = "Auto I-upgrade ang Treadmill",
    ["Automatically upgrade treadmill when money is available"] = "Awtomatikong i-upgrade ang treadmill pag may pera", ["Auto Claim"] = "Awtomatikong Kunin",
    ["Claim offline money & index rewards"] = "Kunin ang offline money at index rewards",
    ["ESP"] = "ESP (Tingnan sa Pader)", ["ESP Eggs"] = "ESP Itlog",
    ["ESP Fixed Size"] = "Nakapirming Laki ng ESP", ["ESP Own Base Eggs"] = "ESP Sariling Base na Itlog",
    ["Also show the eggs placed in your own base"] = "Ipakita rin ang mga itlog sa sariling base", ["ESP Min Rarity"] = "Min Rarity ng ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Ipakita ang itlog ng napiling rarity pataas", ["ESP Show Info"] = "Ipakita ang Info ng ESP",
    ["ESP Min Value"] = "Min na Halaga ng ESP", ["ESP Egg Size"] = "Laki ng ESP Itlog",
    ["ESP Guards"] = "ESP Guwardiya", ["ESP Guard Size"] = "Laki ng ESP Guwardiya",
    ["ESP Players"] = "ESP Manlalaro", ["ESP Player Info"] = "Info ng ESP Manlalaro",
    ["ESP Player Size"] = "Laki ng ESP Manlalaro", ["Movement"] = "Paggalaw",
    ["Speed Boost"] = "Pagpalakas ng Bilis", ["Boost Speed"] = "Bilis ng Boost",
    ["Infinite Jump"] = "Walang Hanggang Talon", ["Character"] = "Karakter",
    ["Anti Ragdoll"] = "Anti Ragdoll (Walang Tumba)", ["Anti Trap"] = "Anti Trap (Laban sa Bitag)",
    ["Traps from other players cannot catch you"] = "Hindi ka mahuhuli sa bitag ng ibang manlalaro", ["Instant Steal"] = "Mabilisang Nakaw (Instant Steal)",
    ["IDLE"] = "BAKANTE", ["Turn on Egg Finder to start hunting"] = "I-on ang Tagahanap ng Itlog para mag-hunt",
    ["Keep hopping servers until a matching egg is found"] = "Patuloy na lumipat ng server hanggang makahanap", ["Link To Auto Steal Filters"] = "I-link sa Auto Steal Filters",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Ibahagi ang isang set ng filter sa Auto Steal", ["Min Value To Find"] = "Min na Halaga na Hahanapin",
    ["Hop Only When Rarity Appears"] = "Lumipat Lang Kapag Lumabas ang Rarity", ["Wait for the chosen rarity to appear, then hop until night"] = "Hintaying lumabas ang rarity, bago lumipat",
    ["Rarity That Must Appear"] = "Rarity na Dapat Lumabas", ["Hop starts when this rarity or higher appears"] = "Magsisimula ang paglipat kapag lumabas ang rarity na ito",
    ["Hop Delay"] = "Pagkaantala sa Paglipat", ["Egg Predictor"] = "Tagahula ng Itlog",
    ["Sort By"] = "Ayusin Ayon Sa", ["Value"] = "Halaga",
    ["Preview Card"] = "Silipin ang Card", ["Search eggs..."] = "Maghanap ng itlog...",
    ["Tap an egg below to preview it"] = "I-tap ang itlog sa ibaba para silipin", ["In inventory"] = "Nasa inventory",
    ["Hold egg"] = "Hawak na itlog", ["Fuse Predictor"] = "Tagahula ng Fuse",
    ["Machine is empty"] = "Walang laman ang makina", ["Load 3 pets of the same species to see the result odds"] = "Maglagay ng 3 parehong pets para makita ang tsansa",
    ["Search"] = "Maghanap", ["Auto Load Script"] = "Auto I-load ang Script",
    ["Server Hop Mode"] = "Mode ng Paglipat ng Server", ["Least Players"] = "Pinakakaunting Manlalaro",
    ["Server Hop"] = "Lumipat ng Server", ["Job ID"] = "Job ID",
    ["Paste a server Job ID..."] = "I-paste ang Job ID ng server...", ["Join Job ID"] = "Sumali sa Job ID",
    ["Copy Current Job ID"] = "Kopyahin ang Job ID", ["Rejoin Server"] = "Muling Sumali sa Server",
    ["Join"] = "Sumali", ["Copy"] = "Kopyahin", ["Rejoin"] = "Muling Sumali", ["Hop"] = "Lumipat",
    ["Performance"] = "Pagganap", ["FPS Cap"] = "Limitasyon ng FPS",
    ["Optimizer"] = "Optimizer", ["Strip shadows, textures and effects for the highest FPS"] = "Tanggalin ang anino, textures, at effects",
    ["FPS and Ping"] = "FPS at Ping", ["FPS and Ping Size"] = "Laki ng FPS at Ping",
    ["Utility"] = "Kagamitan", ["Anti AFK"] = "Laban sa AFK",
    ["Creator Event"] = "Kaganapan ng Lumikha", ["INVITE LINK"] = "LINK NG IMBITASYON",
    ["Copy Link"] = "Kopyahin ang Link", ["WHAT YOU GET"] = "ANO ANG MAKUHA MO",
    ["New Scripts & Updates"] = "Mga Bagong Script at Updates", ["Patch notes and new game scripts are posted there first."] = "Mga patch notes at bagong script ay naka-post doon una.",
    ["Giveaways"] = "Mga Giveaway", ["Member giveaways and events are announced in the server."] = "Mga giveaway para sa miyembro ay ina-announce sa server.",
    ["Support"] = "Suporta", ["Ask for help, report bugs and get answers from the team."] = "Humingi ng tulong, mag-report ng bugs at kumuha ng sagot.",
    ["Suggestions"] = "Mga Mungkahi", ["Request features and vote on what gets added next."] = "Humiling ng features at bumoto sa susunod na idadagdag.",
    ["Paste the copied link into your browser or the Discord app to join."] = "I-paste ang link sa browser o Discord app para sumali.",
    ["Copy Discord Link"] = "Kopyahin ang Discord Link", ["Click"] = "I-click",
    ["Quick Access"] = "Mabilisang Pag-access", ["Show Quick Bars"] = "Ipakita ang Mabilisang Bars",
    ["Floating quick bars; drag a header to move one"] = "Lumulutang na quick bars; i-drag ang header para ilipat", ["Visible Quick Bars"] = "Mga Nakikitang Quick Bars",
    ["Quick Bar Size"] = "Laki ng Quick Bar", ["Quick Bar & Keybinds"] = "Mabilisang Bar at Keybinds",
    ["Reset Quick Access"] = "I-reset ang Mabilisang Pag-access", ["Restore default items, bars and positions"] = "Ibalik sa default ang mga items, bars, at posisyon",
    ["Reset Keybinds"] = "I-reset ang Keybinds", ["Restore the defaults set in code"] = "Ibalik sa default ang naka-set sa code",
    ["Reset"] = "I-reset", ["Interface"] = "Interface", ["UI Size"] = "Laki ng UI",
    ["Scales the main window; the corner grip does the same by hand"] = "Papalakihin ang main window; pwedeng gawin gamit ang grip",
    ["Notifications"] = "Mga Notipikasyon", ["Show notification cards; turning this off hides every notify"] = "Ipakita ang notipikasyon; itatago ang lahat kapag naka-off",
    ["Open On Launch"] = "Buksan Kapag Nagsimula", ["Open the UI automatically when the script starts"] = "Awtomatikong buksan ang UI pag-start ng script",
    ["Defaults"] = "Mga Default", ["Reset to Defaults"] = "I-reset sa Mga Default",
    ["Reset every feature to its built-in default"] = "I-reset ang lahat ng feature sa orihinal na default nito", ["Turn Off All Toggles"] = "I-off Lahat ng Toggles",
    ["Switch off every enabled toggle in the feature tabs"] = "I-off lahat ng nakabukas na toggle sa mga tab", ["Turn Off"] = "I-off Ngayon",
    ["Auto Save Config"] = "Auto I-save ang Config", ["Auto Load Config"] = "Auto I-load ang Config",
    ["New Config Name"] = "Pangalan ng Bagong Config", ["Create New Config"] = "Gumawa ng Bagong Config",
    ["Save Config"] = "I-save ang Config", ["Import Config Text"] = "I-import ang Teksto ng Config",
    ["Destination"] = "Destinasyon", ["Webhook URL"] = "Webhook URL",
    ["Notify Egg Finder Match"] = "I-notify ang Tugma ng Tagahanap ng Itlog", ["Post the egg Egg Finder stops hopping for"] = "I-post ang itlog na dahilan ng paghinto sa paglipat",
    ["Notify Stolen Eggs"] = "I-notify ang Nakaw na Itlog", ["Post every egg you bring home"] = "I-post ang bawat itlog na naiuwi mo",
    ["None"] = "Wala", ["Off"] = "Naka-off", ["Filter features..."] = "I-filter ang mga features...",
    ["Favorite"] = "Paborito", ["Unfavorite"] = "Alisin sa Paborito", ["Sell"] = "Ibenta",
    ["Mythic"] = "Mythic", ["Secret"] = "Secret", ["Divine"] = "Divine",
    ["Eternal"] = "Eternal", ["Cosmic"] = "Cosmic", ["Legendary"] = "Legendary",
    ["Match All"] = "Itugma Lahat", ["Rarity Only"] = "Rarity Lang",
    ["Window Minimized - Click bubble to restore"] = "Na-minimize ang window - I-click ang bubble para ibalik",
    ["Let's Chat!"] = "Mag-chat na tayo!", ["Connecting to Global Script Chat..."] = "Kumokonekta sa Global Script Chat...",
    ["Send"] = "Ipadala", ["Live"] = "Live", ["Spoof anti cheat success!"] = "Matagumpay na na-spoof ang anti cheat!",
    ["Fetching..."] = "Kinukuha ang data...", ["Loaded"] = "Na-load Na",
    ["Teleport Mode [Gold/Premium]"] = "Mode ng Teleport [Gold/Premium]", ["Force Speed To (0 = Auto / Q"] = "Piliting I-set ang Bilis sa (0 = Auto / Q)",
    ["Force Speed To"] = "I-set ang Bilis Sa", ["Manual Steal (Instant Carry)"] = "Manu-manong Nakaw (Instant Carry)",
    ["Instant Carry (Manual Steal)"] = "Instant Carry (Manu-mano)", ["Instant Carry Rarities"] = "Rarity ng Instant Carry",
    ["Pet Names (Auto Place)"] = "Pangalan ng Pet (Auto Lagay)", ["All (none)"] = "Lahat (Wala)",
    ["Rarities"] = "Rarities", ["Areas"] = "Mga Lugar", ["Priority"] = "Prayoridad", ["Rarity"] = "Rarity",
    ["Min Egg KG (0 = off)"] = "Min na KG ng Itlog (0 = Off)", ["Automation & Egg Management"] = "Automation at Pamamahala ng Itlog",
    ["Auto Hatch Ready"] = "Auto Pusa pag Handa Na", ["Auto Place All Egg"] = "Auto Lagay Lahat ng Itlog",
    ["Auto Place Selected (By Pet Names Filter)"] = "Auto Lagay ang Napili (Ayon sa Pangalan ng Pet)",
    ["Auto Steal from other players [Gold/Premium]"] = "Auto Nakaw sa ibang manlalaro [Gold/VIP]",
    ["Automatically target players carrying eggs"] = "Awtomatikong i-target ang manlalaro na may itlog",
    ["Filter Rarity for Steal"] = "I-filter ang Rarity para Nakawin",
    ["Steal from special for player (Teleport Strike)"] = "Magnakaw ng espesyal (Teleport Strike)",
    ["Steal History"] = "Kasaysayan ng Pagnanakaw", ["History of Stolen Eggs from Players"] = "Kasaysayan ng mga Nakaw na Itlog sa Sesyon",
    ["Clear"] = "I-clear", ["No player steals recorded yet this session."] = "Wala pang naitalang nakaw sa sesyon na ito.",
    ["In Safe Zone"] = "Nasa Safe Zone", ["No Egg Carried"] = "Walang Dala na Itlog", ["Locked"] = "Naka-lock",
    ["STOLEN EGGS"] = "NAKAW NA ITLOG", ["HUNTED TARGETS"] = "HINANAP NA TARGETS",
    ["Reset Session Counter"] = "I-reset ang Bilang ng Sesyon", ["Live Engine"] = "Buhay na Engine",
    ["Bag Inventory & Live Value"] = "Bag Inventory & Kasalukuyang Halaga", ["TOTAL VALUE IN BAG"] = "KABUUANG HALAGA SA BAG",
    ["TOTAL ITEMS IN BAG"] = "KABUUANG ITEMS SA BAG", ["Sell Egg Settings"] = "Mga Setting sa Pagbenta ng Itlog",
    ["Sell Below Value (cth 100M, ..."] = "Ibenta Kung Mababa sa Halaga (hal. 100M)", ["Sell Below KG (0=off)"] = "Ibenta Kung Mababa sa KG (0 = Off)",
    ["Pet Names (per area)"] = "Pangalan ng Pet (Kada Lugar)", ["Select Pet to Fuse"] = "Pumili ng Pet na I-fuse",
    ["Refresh Inventory Pets"] = "I-refresh ang Pets sa Inventory", ["List Player Need Partner"] = "Listahan ng Kailangan ng Partner",
    ["Find Partner (Register) [Gold/Premium]"] = "Maghanap ng Partner (Rehistro) [Gold/VIP]",
    ["Refresh Partner List"] = "I-refresh ang Listahan ng Partner", ["Broadcast Need Partner [Gold/Premium]"] = "I-broadcast ang Kailangan ng Partner [Gold/VIP]",
    ["Broadcast a global Notice banner to script users (1-hour cooldown)."] = "I-broadcast ang paunawa sa mga users (1-oras na cooldown).",
    ["Filter by Pet Owned (e.g. Pegasus)..."] = "I-filter ayon sa Pet na Meron ka (hal. Pegasus)...",
    ["No other players are currently looking for a partner."] = "Wala pang manlalaro na naghahanap ng partner ngayon.",
    ["Rift Live Status & Rotation"] = "Live Status at Pag-ikot ng Rift", ["Banner: [Verdant] Riftborn"] = "Banner: [Verdant] Riftborn",
    ["Refresh"] = "I-refresh", ["Recipe egg is still unmatched! Must hatch into pets before Trade-In."] = "Hindi pa tugma ang recipe! Kailangang mapusa muna.",
    ["Open Boss Shop"] = "Buksan ang Boss Shop", ["Auto Buy Boss Shop"] = "Auto Bili sa Boss Shop",
    ["Automation"] = "Automation", ["Target Banners (none = all)"] = "Mga Target na Banner (Wala = Lahat)",
    ["Boss Rift (Abyss Overlord)"] = "Boss Rift (Abyss Overlord)", ["Abyss Overlord (Portal Closed)"] = "Abyss Overlord (Sarado ang Portal)",
    ["Boss HP: Waiting for spawn..."] = "HP ng Boss: Naghihintay lumabas...", ["Boss Glide Speed (studs/s)"] = "Bilis ng Paglipad sa Boss (studs/s)",
    ["Leave Boss Arena (To Safe Zone)"] = "Umalis sa Boss Arena (Pa-Safe Zone)", ["Manual Attack (Equip Bat & Swing)"] = "Mano-manong Pag-atake (Gamitin ang Bat)",
    ["Quick Actions"] = "Mabilisang Aksyon", ["Place Rift Eggs to Pen"] = "Ilagay ang Rift Eggs sa Pen",
    ["Instant Trade-In Once"] = "Mabilisang Trade-In Minsan", ["Use Free Reroll Now"] = "Gamitin ang Libreng Reroll Ngayon",
    ["Buy 1x Mutation Consumable"] = "Bumili ng 1x Mutation Consumable", ["Claim All Available Milestones"] = "Kunin Lahat ng Available na Milestones",
    ["Teleport to Rift Machine"] = "Mag-teleport sa Makina ng Rift", ["Refresh Status"] = "I-refresh ang Status",
    ["Session Stats"] = "Stats ng Sesyon", ["Rift Sacrifices"] = "Mga Sakripisyo sa Rift", ["RIFT SACRIFICES"] = "MGA SAKRIPISYO SA RIFT",
    ["Guard"] = "Guwardiya", ["Light Dark"] = "Light Dark", ["Hunt & Stash Settings"] = "Mga Setting sa Pag-hunt at Pag-imbak",
    ["Drop Egg Before Safe Zone"] = "Ihulog ang Itlog Bago Mag-Safe Zone", ["Do Not Deliver to Safe Zone"] = "Huwag Ihatid sa Safe Zone",
    ["Never Drop the Egg"] = "Huwag Kailanman Ihulog ang Itlog", ["Staging Controls"] = "Mga Kontrol sa Staging",
    ["Set Staging Spot (Here)"] = "I-set ang Staging Spot (Dito)", ["Deliver Stash Now"] = "Ihatid na ang Inimbak",
    ["Uncap FPS, Lighting Compatibility, SmoothPlastic, & Native Low Settings"] = "Alisin ang FPS cap, Lighting, SmoothPlastic, & Low Settings",
    ["Re-apply Boost Now"] = "I-apply Muli ang Boost Ngayon", ["Visual & Clean Up"] = "Visual at Paglilinis",
    ["Delete other player pet and egg"] = "Burahin ang pet at itlog ng ibang manlalaro",
    ["Hapus visual pet & telur dari player lain (Aman: telur area tetap ada)"] = "Burahin ang visual ng pet at itlog ng iba (Ligtas)",
    ["Auto Execute"] = "Auto Execute", ["Hop Now (Emptiest Server)"] = "Lumipat Ngayon (Pinakabakanteng Server)",
    ["Solo Server"] = "Solo Server", ["Prev"] = "Nakaraan", ["Next"] = "Susunod",
    ["Display & Window"] = "Display at Window", ["Display Full Size (PC)"] = "I-display ng Full Size (PC)",
    ["PC Full Size sets 100% scale for desktop displays. Turn OFF for"] = "Ang PC Full Size ay 100% scale. I-OFF kung sa cellphone",
    ["Anti-AFK Protection"] = "Proteksyon sa Anti-AFK",
    ["Prevent idle triggers, 20-min Roblox kick & game soft-teleports with"] = "Pinipigilan ang 20-min kick sa Roblox at soft-teleports",
    ["View Disconnect Log"] = "Tingnan ang Disconnect Log", ["Clear Disconnect Log"] = "I-clear ang Disconnect Log",
    ["Configuration"] = "Configuration", ["Alert Types"] = "Mga Uri ng Alert",
    ["Periodic Progress"] = "Pana-panahong Pag-unlad", ["Egg Spawn Alert"] = "Alert Kapag May Lumabas na Itlog",
    ["Collect / Claim"] = "Kolektahin / Kunin", ["Egg Hatched"] = "Napusa na Itlog",
    ["Pet Obtained"] = "Nakuha ang Pet", ["Pets Sold"] = "Naibentang Pets",
    ["Trails Bought"] = "Nabili ang Trails", ["Auto Gift Alert"] = "Auto Alert sa Regalo",
    ["Rebirth Alert"] = "Alert sa Rebirth", ["Disconnect Alert"] = "Alert Kapag Na-disconnect",
    ["Alert Filters"] = "Mga Filter ng Alert", ["Min Rarity for Alerts"] = "Min Rarity para sa Alerts",
    ["Any"] = "Kahit Ano", ["Manual Actions"] = "Mano-manong Aksyon",
    ["Send Summary Now"] = "Ipadala ang Buod Ngayon", ["Test Webhook"] = "I-test ang Webhook",
    ["Send Inventory Report"] = "Ipadala ang Report ng Inventory", ["Send Equipped Report"] = "Ipadala ang Report ng Nakasuot"
}

-- Mẫu Regex xử lý chuỗi động đa ngôn ngữ
local DYNAMIC_PATTERNS = {
    {
        pattern = "^(%d+) selected$",
        format  = function(lang, count) return (lang == "VI") and ("Đã chọn " .. count) or ("Napili " .. count) end
    },
    {
        pattern = "^IN INVENTORY %((%d+)%)$",
        format  = function(lang, count) return (lang == "VI") and ("TRONG TÚI ĐỒ (" .. count .. ")") or ("NASA INVENTORY (" .. count .. ")") end
    },
    {
        pattern = "^Eggs placed (%d+)%/(%d+) %- (%d+)%/(%d+) pets equipped, (%d+) in bag$",
        format  = function(lang, e1, e2, p1, p2, b1) return (lang == "VI") and ("Đã đặt " .. e1 .. "/" .. e2 .. " trứng - " .. p1 .. "/" .. p2 .. " thú trang bị, " .. b1 .. " trong túi") or ("Nailagay na itlog " .. e1 .. "/" .. e2 .. " - " .. p1 .. "/" .. p2 .. " pets ang gamit, " .. b1 .. " sa bag") end
    },
    {
        pattern = "^Pet matches %- (%d+) pets for %$(.-)$",
        format  = function(lang, count, val) return (lang == "VI") and ("Thú khớp lệnh - " .. count .. " thú, tổng giá $" .. val) or ("Tumugma ang pet - " .. count .. " pets sa halagang $" .. val) end
    },
    {
        pattern = "^Egg matches %- (%d+) eggs for %$(.-)$",
        format  = function(lang, count, val) return (lang == "VI") and ("Trứng khớp lệnh - " .. count .. " trứng, tổng giá $" .. val) or ("Tumugma ang itlog - " .. count .. " itlog sa halagang $" .. val) end
    },
    {
        pattern = "^Next fuse %- (%d+) (.-) for %$(.-)$",
        format  = function(lang, count, name, val) return (lang == "VI") and ("Ghép tiếp theo - " .. count .. " " .. name .. " tốn $" .. val) or ("Susunod na fuse - " .. count .. " " .. name .. " halaga $" .. val) end
    },
    {
        pattern = "^Favorite matches %- (%d+) pets, (%d+) to mark %| (%d+) favorited$",
        format  = function(lang, mCount, mark, fav) return (lang == "VI") and ("Khớp khóa thú - " .. mCount .. " con, " .. mark .. " cần khóa | " .. fav .. " đã khóa") or ("Tumugma ang paborito - " .. mCount .. " pets, " .. mark .. " i-mark | " .. fav .. " paborito na") end
    },
    {
        pattern = "^Riftborn %- needs (.-) %- pity (%d+)%/(%d+) %- free rerolls (%d+) %- rotates in (.-) %- boss portal (.-)$",
        format  = function(lang, needs, pity1, pity2, reroll, timeStr, status) return (lang == "VI") and ("Riftborn - Cần: " .. needs .. " - Bảo hiểm: " .. pity1 .. "/" .. pity2 .. " - Quay free: " .. reroll .. " - Đổi sau " .. timeStr .. " - Cổng Boss: " .. (status == "closed" and "Đóng" or "Mở")) or ("Riftborn - Kailangan: " .. needs .. " - Awa: " .. pity1 .. "/" .. pity2 .. " - Libreng reroll: " .. reroll .. " - Iikot sa " .. timeStr .. " - Portal ng boss: " .. (status == "closed" and "Sarado" or "Bukas")) end
    },
    {
        pattern = "^(%d+) eggs %- (%d+) ready %- (%d+) growing %- (%d+) in bag %- Total (.-)$",
        format  = function(lang, e1, r1, g1, b1, t1) return (lang == "VI") and (e1 .. " trứng - " .. r1 .. " xong - " .. g1 .. " đang lớn - " .. b1 .. " trong túi - Tổng " .. t1) or (e1 .. " itlog - " .. r1 .. " handa - " .. g1 .. " lumalaki - " .. b1 .. " sa bag - Kabuuan " .. t1) end
    },
    {
        pattern = "^Players (%d+)%/(%d+)$",
        format  = function(lang, p1, p2) return (lang == "VI") and ("Người chơi: " .. p1 .. "/" .. p2) or ("Mga Manlalaro: " .. p1 .. "/" .. p2) end
    }
}

-- Sắp xếp tự điển dài -> ngắn (Plain-Text Rules)
local SortedVI, SortedPH = {}, {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
for en, ph in pairs(MAP_PH) do table.insert(SortedPH, {en = en, out = ph, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)
table.sort(SortedPH, function(a, b) return a.len > b.len end)

-- ==================== 2. ENGINE DỊCH CHUỖI SIÊU TỐC ĐA NGÔN NGỮ ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    local trimmed = raw:gsub("^%s*(.-)%s*$", "%1")
    local exactMatch = (currentLanguage == "VI") and MAP_VI[trimmed] or MAP_PH[trimmed]

    -- 1. O(1) Exact HashMap Lookup
    if exactMatch then
        local res = safeReplace(raw, trimmed, exactMatch)
        FastCache[cacheKey] = res
        return res
    end

    -- 2. Khớp chuỗi động Regex
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            local res = item.format(currentLanguage, unpack(matches))
            FastCache[cacheKey] = res
            return res
        end
    end

    -- 3. Khớp cụm từ dài nhất bằng Plain-Text
    local result = raw
    local matched = false
    local sortedMap = (currentLanguage == "VI") and SortedVI or SortedPH
    for _, item in ipairs(sortedMap) do
        if result:find(item.en, 1, true) then
            result = safeReplace(result, item.en, item.out)
            matched = true
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_LangToggle_Slate") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    if currentLanguage == "EN" then
        if inst.Text ~= original then
            translationLock = true
            inst.Text = original
            translationLock = false
        end
    else
        local mappedText = translateText(original)
        if inst.Text ~= mappedText then
            translationLock = true
            inst.Text = mappedText
            translationLock = false
        end
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(TrackedElements, inst)
    applyTranslation(inst)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if not translationLock then
            local current = inst.Text
            local isKnown = false
            
            if currentLanguage ~= "EN" then
                local sortedMap = (currentLanguage == "VI") and SortedVI or SortedPH
                for _, item in ipairs(sortedMap) do
                    if current:find(item.out, 1, true) then
                        isKnown = true
                        break
                    end
                end
            else
                isKnown = (current == inst:GetAttribute("OriginalRawText"))
            end

            if not isKnown then
                inst:SetAttribute("OriginalRawText", current)
            end
            applyTranslation(inst)
        end
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

-- ==================== 3. NÚT ĐỔI NGÔN NGỮ 3 CHẾ ĐỘ ====================
local function createLangToggleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_LangToggle_Slate")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_LangToggle_Slate"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Container = Instance.new("Frame", ScreenGui)
    Container.Size = UDim2.new(0, 126, 0, 28)
    Container.Position = UDim2.new(1, -140, 0, 14)
    Container.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    Container.BackgroundTransparency = 0.2
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke", Container)
    Stroke.Color = Color3.fromRGB(160, 45, 45) 
    Stroke.Thickness = 1.0

    local Icon = Instance.new("TextLabel", Container)
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌶️"
    Icon.TextSize = 12

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -36, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Tiếng Việt"
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(240, 130, 130)
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
            currentLanguage = "PH"
            Label.Text = "Filipino"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(245, 205, 110)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 135, 60)}):Play()
        elseif currentLanguage == "PH" then
            currentLanguage = "EN"
            Label.Text = "English"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(215, 180, 180)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 45, 45)}):Play()
        else
            currentLanguage = "VI"
            Label.Text = "Tiếng Việt"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 130, 130)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 45, 45)}):Play()
        end
        updateAllActive()
    end)
end

-- ==================== 4. BỘ QUÉT ZERO-LAG ====================
task.spawn(function()
    createLangToggleUI()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    for _, root in ipairs(searchRoots) do
        if root then
            root.DescendantAdded:Connect(function(desc)
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                end
            end)
        end
    end

    task.spawn(function()
        for _, root in ipairs(searchRoots) do
            if root then
                local allItems = root:GetDescendants()
                local count = 0
                for _, desc in ipairs(allItems) do
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        hookElement(desc)
                        count = count + 1
                        if count % 40 == 0 then
                            task.wait() 
                        end
                    end
                end
            end
        end
    end)

    while true do
        task.wait(2.5)
        for _, root in ipairs(searchRoots) do
            if root then
                for _, desc in ipairs(root:GetDescendants()) do
                    if (desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox")) and not desc:GetAttribute("HasTranslateHook") then
                        hookElement(desc)
                    end
                end
            end
        end
    end
end)

-- ==================== 5. NẠP CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg"))()
    end)
end)
