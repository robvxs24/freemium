-- Codium Hub | 5-Tier Hybrid Auto-Translator (100% Unseen Text Coverage + Zero-Lag Event Architecture)
local CODIUM_URL = "https://getcodium.xyz/loader.luau"

local env = (getgenv and getgenv()) or _G
env.__CodiumViSession = (env.__CodiumViSession or 0) + 1
local SID = env.__CodiumViSession
local function isAlive()
    return env.__CodiumViSession == SID
end

-- 1. KHỞI CHẠY CODIUM HUB GỐC (CHỐNG CHẠY TRÙNG KHI EXEC LẠI BỘ DỊCH)
if not env.__CodiumLoadedOnce then
    env.__CodiumLoadedOnce = true
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet(CODIUM_URL))()
        end)
    end)
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

local FastCache = {}

-- Kiểm tra chuỗi đã có dấu tiếng Việt chưa
local function hasVietnameseChars(s)
    return type(s) == "string" and s:find("[\195\196\197\225]") ~= nil
end

-- ============================================================================
-- TẦNG 2: TỪ ĐIỂN KHỚP CHÍNH XÁC (BAO PHỦ CẢ CÁC TAB CHƯA CHỤP)
-- ============================================================================
local EXACT_VI = {
    -- Sidebar & Cửa sổ chung
    ["Media"] = "Mạng Xã Hội",
    ["Chat"] = "Trò Chuyện",
    ["Home"] = "Trang Chủ",
    ["Features"] = "Tính Năng",
    ["Egg"] = "Trứng (Egg)",
    ["Pet"] = "Thú Cưng (Pet)",
    ["Event"] = "Sự Kiện",
    ["Activities"] = "Hoạt Động",
    ["Barn"] = "Chuồng Trại",
    ["Others"] = "Khác",
    ["Config"] = "Cấu Hình",
    ["Search..."] = "Tìm kiếm...",
    ["Search"] = "Tìm kiếm",
    ["Keyless"] = "Không cần Key",
    ["Default"] = "Mặc định",
    ["Anime"] = "Chế độ Anime",
    ["None"] = "Không có",
    ["All"] = "Tất cả",

    -- Tab Trang Chủ (Home / Inventory / Map)
    ["Player Stats"] = "Thống Kê Người Chơi",
    ["Inventory"] = "Túi Đồ",
    ["Map"] = "Bản Đồ",
    ["Placed"] = "Đã Đặt",
    ["Rarity"] = "Độ Hiếm",
    ["World"] = "Thế Giới",
    ["Steal"] = "Cướp Ngay",
    ["Hatch"] = "Ấp Ngay",
    ["Sell"] = "Bán",
    ["Equip"] = "Trang Bị",
    ["Unequip"] = "Tháo Ra",
    ["Lock"] = "Khóa",
    ["Unlock"] = "Mở Khóa",

    -- Tab Trứng (Egg: Steal, Place, Hatch, Sell, Webhook)
    ["Steal Egg"] = "Cướp Trứng",
    ["Filtering"] = "Bộ Lọc",
    ["Strict Filter"] = "Lọc Nghiêm Ngặt",
    ["Only target eggs that match every filter you set."] = "Chỉ nhắm mục tiêu trứng khớp với tất cả bộ lọc bạn đã chọn.",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Select Area"] = "Chọn Khu Vực",
    ["Select Rarity"] = "Chọn Độ Hiếm",
    ["Select Pet"] = "Chọn Thú Cưng",
    ["Select Mutation"] = "Chọn Đột Biến",
    ["Min Value"] = "Giá Trị Tối Thiểu",
    ["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."] = "Chỉ nhắm tới trứng kiếm ít nhất mức này mỗi giây, tính cả đột biến (VD: 500k, 1.5m). Nhập 0 hoặc để trống để tắt.",
    ["Indexing"] = "Chỉ Mục (Index)",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Chỉ Mục",
    ["Redeems unlocked index rewards."] = "Tự động nhận phần thưởng chỉ mục đã mở khóa.",
    ["Auto Indexing"] = "Tự Cướp Trứng Chưa Mở Chỉ Mục",
    ["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."] = "Tự động cướp chỉ nhắm vào trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",
    ["Steal Settings"] = "Cài Đặt Cướp",
    ["Steal Mode"] = "Chế Độ Cướp",
    ["Normal flies to the egg, Instant Steal works in every area."] = "Chế độ Thường sẽ bay tới trứng, Cướp Tức Thì hoạt động ở mọi khu vực.",
    ["Instant Steal"] = "Cướp Tức Thì",
    ["Normal"] = "Bình Thường",
    ["Delivery Mode"] = "Chế Độ Mang Về",
    ["Recommended Delivery Mode: Speed Match or Steady"] = "Chế độ mang về khuyên dùng: Khớp Tốc Độ hoặc Ổn Định",
    ["Speed Match"] = "Khớp Tốc Độ",
    ["Steady"] = "Ổn Định",
    ["Steal From Player"] = "Cướp Từ Người Chơi Khác",
    ["Steals eggs from other players."] = "Giật trứng từ tay người chơi khác.",
    ["Server Hop (No Target)"] = "Đổi Server (Khi Hết Trứng)",
    ["Hops server when no target is found."] = "Tự động đổi máy chủ khi không tìm thấy trứng mục tiêu.",
    ["Drop for Friend"] = "Thả Trứng Cho Bạn Bè",
    ["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."] = "Thả trứng tại điểm tập kết để bạn bè nhặt, sau đó tiếp tục đi tìm trứng khác.",
    ["Auto Steal"] = "Tự Động Cướp",
    ["Flies to field eggs, grabs them and brings them home."] = "Bay tới trứng ngoài bãi, nhặt và mang về chuồng.",
    ["Steal Other Script"] = "Cướp Trứng Từ Script Khác",
    ["Grabs eggs other players drop near safezone."] = "Nhặt trứng mà người chơi khác thả gần vùng an toàn.",
    ["Steal Status"] = "Bảng Trạng Thái Cướp",
    ["Shows the Auto Steal status panel."] = "Hiển thị bảng theo dõi trạng thái tự động cướp.",
    ["Open Steal Panel"] = "Mở Bảng Cướp Thủ Công",
    ["Find and steal World and Halloween eggs by hand."] = "Tìm và chọn cướp trứng Thế Giới hoặc Halloween thủ công.",
    ["Open Steal History"] = "Mở Lịch Sử Cướp",
    ["Open the last 10 steal results in a separate window."] = "Xem 10 kết quả cướp trứng gần nhất trong cửa sổ riêng.",
    ["Egg Utilities"] = "Tiện Ích Trứng",
    ["Open Egg Predictor"] = "Mở Bảng Dự Đoán Trứng",
    ["Open standalone egg cycle predictor window."] = "Mở cửa sổ riêng dự đoán chu kỳ xuất hiện trứng.",
    ["Egg Inventory Value"] = "Hiện Giá Trị Trứng Trong Túi",
    ["Show generation rate (/s) and sell price on backpack egg slots."] = "Hiển thị tốc độ kiếm tiền (/s) và giá bán trên từng ô trứng trong túi.",
    ["Place Egg"] = "Đặt Trứng Vào Chuồng",
    ["Hatch Egg"] = "Ấp Trứng",
    ["Sell Egg"] = "Bán Trứng",
    ["Stop At Rarity"] = "Dừng Lại Ở Độ Hiếm",
    ["Eggs of this rarity or higher won't be placed."] = "Trứng có độ hiếm này hoặc cao hơn sẽ không bị đặt vào chuồng.",
    ["Eggs of this rarity or higher won't be hatched."] = "Trứng có độ hiếm này hoặc cao hơn sẽ không bị ấp.",
    ["Whitelist"] = "Danh Sách Ưu Tiên (Whitelist)",
    ["Blacklist"] = "Danh Sách Chặn (Blacklist)",
    ["Whitelist Rarity"] = "Độ Hiếm Ưu Tiên",
    ["Whitelist Pet"] = "Thú Cưng Ưu Tiên",
    ["Whitelist Mutation"] = "Đột Biến Ưu Tiên",
    ["Blacklist Rarity"] = "Chặn Độ Hiếm",
    ["Blacklist Pet"] = "Chặn Thú Cưng",
    ["Blacklist Mutation"] = "Chặn Đột Biến",
    ["Place eggs that will match the selected pets."] = "Chỉ đặt trứng khớp với thú cưng đã chọn.",
    ["Place eggs that will match the selected rarities."] = "Chỉ đặt trứng khớp với độ hiếm đã chọn.",
    ["Place eggs that will match the selected mutations."] = "Chỉ đặt trứng khớp với đột biến đã chọn.",
    ["Never place eggs matching the selected pets."] = "Không bao giờ đặt trứng khớp với thú cưng đã chọn.",
    ["Never place eggs matching the selected rarities."] = "Không bao giờ đặt trứng khớp với độ hiếm đã chọn.",
    ["Never place eggs matching the selected mutations."] = "Không bao giờ đặt trứng khớp với đột biến đã chọn.",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Places matching eggs from your bag into the pen. Whitelist picks which eggs; blacklist always blocks."] = "Tự đặt trứng khớp lọc từ túi vào chuồng. Whitelist chọn trứng, Blacklist luôn chặn.",
    ["Auto Place Indexing"] = "Tự Đặt Trứng Chưa Có Chỉ Mục",
    ["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."] = "Chỉ đặt những quả trứng bạn chưa mở chỉ mục. Bỏ qua Whitelist và Blacklist.",
    ["Hatch eggs that will match the selected pets."] = "Chỉ ấp trứng khớp với thú cưng đã chọn.",
    ["Hatch eggs that will match the selected rarities."] = "Chỉ ấp trứng khớp với độ hiếm đã chọn.",
    ["Hatch eggs that will match the selected mutations."] = "Chỉ ấp trứng khớp với đột biến đã chọn.",
    ["Never hatch eggs matching the selected pets."] = "Không bao giờ ấp trứng khớp với thú cưng đã chọn.",
    ["Never hatch eggs matching the selected rarities."] = "Không bao giờ ấp trứng khớp với độ hiếm đã chọn.",
    ["Never hatch eggs matching the selected mutations."] = "Không bao giờ ấp trứng khớp với đột biến đã chọn.",
    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Automatically hatch ready eggs matching the selected filters."] = "Tự động ấp các trứng đã chín khớp với bộ lọc đã chọn.",
    ["Auto Hatch Indexing"] = "Tự Ấp Trứng Chưa Có Chỉ Mục",
    ["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."] = "Chỉ ấp những trứng bạn chưa mở chỉ mục. Bỏ qua Whitelist, vẫn áp dụng Blacklist.",
    ["Sell eggs matching selected rarities."] = "Bán trứng khớp với độ hiếm đã chọn.",
    ["Sell eggs that will match selected pets."] = "Bán trứng khớp với thú cưng đã chọn.",
    ["Sell eggs matching selected mutations."] = "Bán trứng khớp với đột biến đã chọn.",
    ["Prevent selling eggs with selected rarities."] = "Ngăn không bán trứng thuộc độ hiếm đã chọn.",
    ["Prevent selling eggs that will match selected pets."] = "Ngăn không bán trứng khớp với thú cưng đã chọn.",
    ["Prevent selling eggs with selected mutations."] = "Ngăn không bán trứng có đột biến đã chọn.",
    ["Keep Above"] = "Giữ Lại Trên Mức (/s)",
    ["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."] = "Không bao giờ bán trứng kiếm từ mức này trở lên mỗi giây (VD: 100m). Nhập 0 để tắt.",
    ["Auto Sell Eggs"] = "Tự Động Bán Trứng",
    ["Sells eggs that pass your filters. Placed eggs are never sold."] = "Tự bán trứng khớp bộ lọc. Trứng đã đặt trong chuồng không bao giờ bị bán.",
    ["Sell On Inventory Full"] = "Chỉ Bán Khi Đầy Túi",
    ["Only sell when your egg backpack is full."] = "Chỉ tự động bán khi túi đựng trứng của bạn đã đầy.",

    -- Webhook
    ["Webhook"] = "Báo Cáo Discord (Webhook)",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Discord webhook URL for sending notifications."] = "Đường dẫn Webhook Discord dùng để nhận thông báo.",
    ["Ping @everyone"] = "Gắn Thẻ @everyone",
    ["Mention @everyone in Discord when a new egg is claimed."] = "Tag @everyone trên Discord khi cướp/nhận được trứng mới.",
    ["Egg Webhook"] = "Thông Báo Trứng",
    ["Select Egg Rarity"] = "Chọn Độ Hiếm Trứng",
    ["Enable New Egg Claimed"] = "Bật Báo Trứng Mới",
    ["Send webhook notification when stealing/claiming a new egg."] = "Gửi thông báo về Discord khi cướp hoặc nhận được trứng mới.",
    ["Player Webhook"] = "Thông Báo Người Chơi",
    ["Stats Interval (Min)"] = "Chu Kỳ Gửi Thống Kê (Phút)",
    ["Enable Player Stats"] = "Bật Báo Cáo Thống Kê",
    ["Periodically send player stats to Discord."] = "Định kỳ gửi bảng thống kê tài khoản về Discord.",
    ["Test Webhook"] = "Kiểm Tra Webhook",
    ["Send Stats Now"] = "Gửi Thống Kê Ngay",
    ["Immediately send stats to Discord."] = "Gửi ngay lập tức bảng thống kê về Discord.",
    ["Test Egg Webhook"] = "Thử Báo Cáo Trứng",
    ["Simulate claiming an egg."] = "Giả lập tin nhắn nhặt được trứng để thử Webhook.",

    -- Tab Sự Kiện (Event)
    ["Admin Abuse Boost (BETA)"] = "Lạm Dụng Buff Admin (BETA)",
    ["Phantom Express"] = "Chuyến Tàu Bóng Ma",
    ["Halloween Dimension"] = "Không Gian Halloween",
    ["Ghost Dog Quest"] = "Nhiệm Vụ Chó Ma",
    ["Abandoned Manor"] = "Dinh Thự Bỏ Hoang",
    ["Pumpkin King"] = "Vua Bí Ngô",
    ["The Hollow"] = "Vực Thẳm The Hollow",
    ["Cursed Island Wars"] = "Đại Chiến Đảo Nguyền Rủa",
    ["Pumpkin Moon"] = "Sự Kiện Trăng Bí Ngô",

    -- Các Tab Chưa Chụp: Pet, Features, Activities, Barn, Others, Config
    ["Auto Equip Best"] = "Tự Trang Bị Pet Mạnh Nhất",
    ["Equip Best Pets"] = "Trang Bị Pet Mạnh Nhất",
    ["Auto Sell Pets"] = "Tự Động Bán Thú Cưng",
    ["Sell Pets"] = "Bán Thú Cưng",
    ["Fuse Pets"] = "Dung Hợp Thú Cưng",
    ["Auto Fuse"] = "Tự Động Dung Hợp",
    ["Mutate Egg"] = "Đột Biến Trứng",
    ["Auto Mutate"] = "Tự Động Đột Biến",
    ["Auto Lock"] = "Tự Động Khóa Bảo Vệ",
    ["Auto Favorite"] = "Tự Động Yêu Thích",
    ["Pet Inventory Value"] = "Hiện Giá Trị Pet Trong Túi",
    ["Walk Speed"] = "Tốc Độ Chạy Bộ",
    ["Jump Power"] = "Lực Nhảy Cao",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["No Clip"] = "Đi Xuyên Tường (NoClip)",
    ["Noclip"] = "Đi Xuyên Tường (NoClip)",
    ["Anti AFK"] = "Chống Treo Máy (Anti-AFK)",
    ["Anti Ragdoll"] = "Chống Văng Ngã",
    ["Ignore Traps"] = "Vô Hiệu Hóa Bẫy",
    ["God Mode"] = "Bất Tử (God Mode)",
    ["Invisible"] = "Tàng Hình",
    ["Instant Prompts"] = "Nhấn Giữ Tức Thì",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
    ["Auto Hit"] = "Tự Động Đánh Người",
    ["Skip Friends"] = "Bỏ Qua Bạn Bè",
    ["Auto Fishing"] = "Tự Động Câu Cá",
    ["Auto Treadmill"] = "Tự Chạy Máy Tập",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ",
    ["Auto Upgrade Barn"] = "Tự Nâng Cấp Chuồng Trại",
    ["Auto Claim Offline Cash"] = "Tự Nhận Tiền Offline",
    ["Auto Buy Trails"] = "Tự Mua Vệt Sáng",
    ["Auto Catch Star"] = "Tự Bắt Sao Băng",
    ["Auto Catch Butterfly"] = "Tự Bắt Bướm",
    ["Auto Race"] = "Tự Động Đua Xe",
    ["Low Graphics"] = "Đồ Họa Thấp (Tăng FPS)",
    ["FPS Boost"] = "Tối Ưu Tăng FPS",
    ["Disable 3D Render"] = "Tắt Dựng Hình 3D (Treo Máy)",
    ["Hide Pets"] = "Ẩn Thú Cưng",
    ["Hide Eggs"] = "Ẩn Trứng",
    ["Server Hop"] = "Đổi Máy Chủ",
    ["Rejoin"] = "Vào Lại Phòng",
    ["Rejoin Server"] = "Vào Lại Máy Chủ",
    ["Copy JobId"] = "Chép Mã Phòng (JobId)",
    ["Save Config"] = "Lưu Cấu Hình",
    ["Load Config"] = "Nạp Cấu Hình",
    ["Delete Config"] = "Xóa Cấu Hình",
    ["Create Config"] = "Tạo Cấu Hình",
    ["Auto Load Config"] = "Tự Nạp Cấu Hình",

    -- Độ hiếm & Đột biến & Khu vực
    ["Common"] = "Phổ Thông",
    ["Uncommon"] = "Thường",
    ["Rare"] = "Hiếm",
    ["Epic"] = "Sử Thi",
    ["Legendary"] = "Huyền Thoại",
    ["Mythic"] = "Thần Thoại",
    ["Cosmic"] = "Vũ Trụ",
    ["Secret"] = "Bí Ẩn",
    ["Eternal"] = "Vĩnh Cửu",
    ["Divine"] = "Thánh Thần",
    ["Silver"] = "Bạc",
    ["Golden"] = "Vàng",
    ["Rainbow"] = "Cầu Vồng",
    ["Spectral"] = "Quang Phổ",
    ["Nitro"] = "Nitro",
    ["Enchanted"] = "Phù Phép",
    ["Fractured"] = "Rạn Nứt",
    ["Scrambled"] = "Hỗn Loạn",
    ["Abyss Ocean"] = "Đáy Đại Dương",
    ["Prehistoric"] = "Tiền Sử",
    ["Cherry Blossom"] = "Hoa Anh Đào",
    ["Light Dark"] = "Sáng Tối",
    ["Titan Temple"] = "Đền Titan",
    ["Enchanted Forest"] = "Rừng Phù Phép"
}

local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
    LOWER_VI[k:lower()] = v
end

-- ============================================================================
-- TẦNG 3 & 4: MẪU NGỮ PHÁP ĐỘNG (DỊCH CÁC CÂU CHƯA TỪNG THẤY THEO NGỮ PHÁP)
-- ============================================================================
local GRAMMAR_RULES = {
    -- Các mẫu câu mô tả và tiêu đề động
    { pat = "^e%.g%.%s*(.+)$", rep = "VD: %1" },
    { pat = "^v(%d+%.%d+.*)$", rep = "Phiên bản %1" },
    { pat = "^World%s+(%d+)$", rep = "Thế Giới %1" },
    { pat = "^Halloween%s+(%d+)$", rep = "Halloween %1" },
    { pat = "^Pet%s+(%d+)$", rep = "Thú Cưng %1" },
    { pat = "^Egg%s+(%d+)$", rep = "Trứng %1" },
    { pat = "^Placed%s+(%d+)$", rep = "Đã Đặt %1" },
    { pat = "^[Ss]elect%s+(.+)$", rep = "Chọn %1" },
    { pat = "^[Aa]uto%s+(.+)$", rep = "Tự động %1" },
    { pat = "^[Oo]pen%s+(.+)$", rep = "Mở %1" },
    { pat = "^[Ee]nable%s+(.+)$", rep = "Bật %1" },
    { pat = "^[Dd]isable%s+(.+)$", rep = "Tắt %1" },
    { pat = "^[Ss]how%s+(.+)$", rep = "Hiển thị %1" },
    { pat = "^[Hh]ide%s+(.+)$", rep = "Ẩn %1" },
    { pat = "^[Cc]laim%s+(.+)$", rep = "Nhận %1" },
    { pat = "^[Uu]pgrade%s+(.+)$", rep = "Nâng cấp %1" },
    { pat = "^[Bb]uy%s+(.+)$", rep = "Mua %1" },
    { pat = "^[Cc]raft%s+(.+)$", rep = "Chế tạo %1" },
    { pat = "^[Tt]eleport%s+to%s+(.+)$", rep = "Dịch chuyển tới %1" },
    { pat = "^[Ww]aiting%s+for%s+(.+)$", rep = "Đang chờ %1" },
    { pat = "^[Nn]ever%s+(.+)$", rep = "Không bao giờ %1" },
    { pat = "^[Oo]nly%s+(.+)$", rep = "Chỉ %1" },
    { pat = "^[Pp]revent%s+(.+)$", rep = "Ngăn không %1" }
}

-- ============================================================================
-- TẦNG 5: CỤM TỪ & TỪ VỰNG FALLBACK (QUÉT DỊCH TỰ ĐỘNG 100% CÁC TAB CHƯA CHỤP)
-- ============================================================================
local PHRASES_VI = {
    {"admin abuse boost", "Buff Quyền Admin"},
    {"phantom express", "Tàu Bóng Ma"},
    {"halloween dimension", "Không Gian Halloween"},
    {"ghost dog quest", "Nhiệm Vụ Chó Ma"},
    {"abandoned manor", "Dinh Thự Bỏ Hoang"},
    {"pumpkin king", "Vua Bí Ngô"},
    {"the hollow", "Vực The Hollow"},
    {"cursed island wars", "Đại Chiến Đảo Nguyền Rủa"},
    {"shooting star", "Sao Băng"},
    {"selected rarities", "độ hiếm đã chọn"},
    {"selected pets", "thú cưng đã chọn"},
    {"selected mutations", "đột biến đã chọn"},
    {"selected filters", "bộ lọc đã chọn"},
    {"other players", "người chơi khác"},
    {"other filters", "các bộ lọc khác"},
    {"are ignored", "sẽ bị bỏ qua"},
    {"is ignored", "sẽ bị bỏ qua"},
    {"still applies", "vẫn được áp dụng"},
    {"per second", "mỗi giây"},
    {"at least", "ít nhất"},
    {"or higher", "hoặc cao hơn"},
    {"or empty", "hoặc để trống"},
    {"to disable", "để tắt"},
    {"separate window", "cửa sổ riêng"},
    {"backpack is full", "túi đồ đã đầy"},
    {"inventory full", "đầy túi đồ"},
    {"generation rate", "tốc độ sinh tiền"},
    {"sell price", "giá bán"},
    {"index rewards", "thưởng chỉ mục"},
    {"haven't indexed", "chưa mở chỉ mục"},
    {"ready eggs", "trứng đã chín"},
    {"field eggs", "trứng ngoài bãi"},
    {"drop point", "điểm thả"},
    {"player stats", "thống kê người chơi"},
    {"offline cash", "tiền ngoại tuyến"},
    {"walk speed", "tốc độ chạy"},
    {"jump power", "lực nhảy"},
    {"infinite jump", "nhảy vô hạn"},
    {"hit aura", "vòng đánh tự động"},
    {"server hop", "đổi máy chủ"},
    {"safe zone", "vùng an toàn"},
    {"safezone", "vùng an toàn"},
    {"by hand", "thủ công"}
}

local WORDS_VI = {
    auto = "tự động", steal = "cướp", steals = "cướp", stealing = "cướp", stolen = "đã cướp",
    place = "đặt", places = "đặt", placed = "đã đặt", placing = "đặt",
    hatch = "ấp", hatches = "ấp", hatched = "đã ấp", hatching = "ấp",
    sell = "bán", sells = "bán", sold = "đã bán", selling = "bán",
    equip = "trang bị", equipped = "đang đeo", unequip = "tháo",
    fuse = "dung hợp", fusing = "dung hợp", mutate = "đột biến", mutating = "đột biến",
    mutation = "đột biến", mutations = "đột biến", rarity = "độ hiếm", rarities = "độ hiếm",
    pet = "thú cưng", pets = "thú cưng", egg = "trứng", eggs = "trứng",
    bag = "túi", backpack = "ba lô", inventory = "túi đồ", pen = "chuồng", barn = "chuồng trại",
    base = "căn cứ", area = "khu vực", zone = "khu vực", world = "thế giới", map = "bản đồ",
    target = "mục tiêu", targets = "nhắm tới", priority = "ưu tiên", filter = "bộ lọc", filters = "bộ lọc",
    strict = "nghiêm ngặt", match = "khớp", matches = "khớp", matching = "khớp với",
    whitelist = "danh sách ưu tiên", blacklist = "danh sách chặn",
    keep = "giữ", above = "trên mức", below = "dưới mức", min = "tối thiểu", max = "tối đa",
    value = "giá trị", values = "giá trị", money = "tiền", cash = "tiền", gems = "đá quý", gain = "thu nhập",
    speed = "tốc độ", mode = "chế độ", delivery = "mang về", instant = "tức thì", normal = "bình thường",
    steady = "ổn định", player = "người chơi", players = "người chơi", friend = "bạn bè", friends = "bạn bè",
    server = "máy chủ", hop = "đổi", hops = "đổi", rejoin = "vào lại",
    drop = "thả", drops = "thả", grab = "nhặt", grabs = "nhặt", bring = "mang", brings = "mang",
    home = "về nhà", panel = "bảng", status = "trạng thái", history = "lịch sử", window = "cửa sổ",
    predictor = "dự đoán", utilities = "tiện ích", settings = "cài đặt", config = "cấu hình",
    save = "lưu", load = "nạp", delete = "xóa", create = "tạo", refresh = "làm mới", reset = "đặt lại",
    enable = "bật", enabled = "đã bật", disable = "tắt", disabled = "đã tắt",
    open = "mở", close = "đóng", show = "hiện", shows = "hiển thị", hide = "ẩn",
    claim = "nhận", claimed = "đã nhận", claiming = "nhận", redeem = "nhận", redeems = "nhận",
    reward = "phần thưởng", rewards = "phần thưởng", quest = "nhiệm vụ", quests = "nhiệm vụ",
    event = "sự kiện", events = "sự kiện", activities = "hoạt động", features = "tính năng",
    others = "khác", media = "mạng xã hội", chat = "trò chuyện",
    fishing = "câu cá", fish = "cá", treadmill = "máy tập", trail = "vệt sáng", trails = "vệt sáng",
    monster = "quái vật", monsters = "quái vật", boss = "trùm", ghost = "bóng ma", pumpkin = "bí ngô",
    butterfly = "bướm", star = "sao băng", race = "đua", racing = "đua",
    send = "gửi", notification = "thông báo", notifications = "thông báo",
    interval = "chu kỳ", test = "thử", simulate = "giả lập", immediately = "ngay lập tức",
    periodically = "định kỳ", automatically = "tự động",
    only = "chỉ", never = "không bao giờ", always = "luôn", when = "khi",
    every = "mọi", all = "tất cả", none = "không có", empty = "trống", full = "đầy",
    selected = "đã chọn", unlocked = "đã mở khóa", owned = "đã sở hữu",
    common = "Phổ Thông", uncommon = "Thường", rare = "Hiếm", epic = "Sử Thi",
    legendary = "Huyền Thoại", mythic = "Thần Thoại", cosmic = "Vũ Trụ",
    secret = "Bí Ẩn", eternal = "Vĩnh Cửu", divine = "Thánh Thần",
    silver = "Bạc", golden = "Vàng", rainbow = "Cầu Vồng", spectral = "Quang Phổ"
}

local function applyPhrasesAndWords(str)
    local out = str
    local lowerOut = out:lower()
    local changed = false

    -- 1. Thay thế cụm từ dài trước
    for i = 1, #PHRASES_VI do
        local p = PHRASES_VI[i]
        local sIdx, eIdx = lowerOut:find(p[1], 1, true)
        if sIdx then
            out = out:sub(1, sIdx - 1) .. p[2] .. out:sub(eIdx + 1)
            lowerOut = out:lower()
            changed = true
        end
    end

    -- 2. Thay thế từng từ đơn lẻ
    local wordReplaced = out:gsub("([%a']+)", function(w)
        local lw = w:lower()
        local rep = WORDS_VI[lw] or LOWER_VI[lw]
        if rep then
            changed = true
            return rep
        end
        return w
    end)

    return wordReplaced, changed
end

-- Hàm dịch 1 dòng đơn lẻ (Bảo toàn RichText nếu có)
local function translateSingleLine(line)
    if not line or line == "" then return line end

    -- Xử lý riêng dòng thống kê "Player Stats" (Money: $3.9Qa Gems: 0 ...)
    if line:find("Money:", 1, true) or line:find("Pets:", 1, true) or line:find("Eggs:", 1, true) or line:find("Value:", 1, true) then
        return (line
            :gsub("Money:", "Tiền:")
            :gsub("Gems:", "Đá Quý:")
            :gsub("Pets:", "Thú Cưng:")
            :gsub("Equipped:", "Đang Đeo:")
            :gsub("Eggs:", "Trứng:")
            :gsub("Placed:", "Đã Đặt:")
            :gsub("Value:", "Giá Trị:")
            :gsub("Gain:", "Thu Nhập:"))
    end

    local clean = (line:match("^%s*(.-)%s*$") or line):gsub("%s+", " ")
    if clean == "" then return line end

    -- Bỏ qua chuỗi thuần số/đơn vị tiền tệ/cân nặng ("1,001 kg", "$2.5B/s", "discord.gg/...")
    if clean:match("^[%$%+%-%d%.%,%/%%skmbtqKMBTQsxhg%s]+$") or clean:find("discord.gg", 1, true) or clean:find("https://", 1, true) then
        return line
    end

    -- Bỏ qua dòng FPS của Codium góc trái trên ("CODIUM | 28 fps | 99 ms | 22:49")
    if clean:find("CODIUM |", 1, true) then
        return line
    end

    -- Khớp chính xác Tầng 2
    if EXACT_VI[clean] then return EXACT_VI[clean] end
    local lowerClean = clean:lower()
    if LOWER_VI[lowerClean] then
        local r = LOWER_VI[lowerClean]
        if clean:upper() == clean and clean:find("%a") then
            return r:upper()
        end
        return r
    end

    -- Xử lý danh sách đột biến cách nhau bởi dấu phẩy (VD: "Silver, Spectral")
    if clean:find(",", 1, true) and not clean:find("%.") and #clean < 40 then
        local parts = {}
        local allMatched = true
        for part in clean:gmatch("([^,]+)") do
            local pTrim = part:match("^%s*(.-)%s*$")
            local pVi = EXACT_VI[pTrim] or LOWER_VI[pTrim:lower()]
            if pVi then
                table.insert(parts, pVi)
            else
                allMatched = false
                break
            end
        end
        if allMatched and #parts > 1 then
            return table.concat(parts, ", ")
        end
    end

    -- Khớp mẫu ngữ pháp Tầng 3 & 4
    local working = clean
    local grammarHit = false
    for i = 1, #GRAMMAR_RULES do
        local rule = GRAMMAR_RULES[i]
        if working:find(rule.pat) then
            working = working:gsub(rule.pat, rule.rep)
            grammarHit = true
            break
        end
    end

    -- Quét cụm từ và từ vựng Tầng 5
    local finalStr, wordHit = applyPhrasesAndWords(working)
    if grammarHit or wordHit then
        return finalStr
    end

    return line
end

-- Hàm dịch tổng hợp (Hỗ trợ cả chuỗi nhiều dòng `\n` và Cache O(1))
local function translateFullText(raw)
    if type(raw) ~= "string" or raw == "" then return raw end
    if FastCache[raw] then return FastCache[raw] end

    if raw:find("\n", 1, true) then
        local lines = {}
        for line in (raw .. "\n"):gmatch("(.-)\n") do
            table.insert(lines, translateSingleLine(line))
        end
        local joined = table.concat(lines, "\n")
        FastCache[raw] = joined
        return joined
    else
        local res = translateSingleLine(raw)
        FastCache[raw] = res
        return res
    end
end

-- ============================================================================
-- CƠ CHẾ GẮN HOOK SỰ KIỆN ZERO-LAG (KHÔNG DÙNG VÒNG LẶP QUÉT ĐỊNH KỲ)
-- ============================================================================
local function applyTranslationToInstance(inst)
    if not isAlive() or not inst or not inst.Parent then return end
    if inst:GetAttribute("__ViBusy") then return end

    if inst:IsA("TextLabel") or inst:IsA("TextButton") then
        local cur = inst.Text
        if not cur or cur == "" then return end

        -- Nếu là bảng Player Stats nhiều dòng thì luôn dịch từng dòng kể cả khi đã có chữ Việt
        local isMultiLineStats = cur:find("Money:", 1, true) or cur:find("Equipped:", 1, true) or cur:find("Gain:", 1, true)
        if not isMultiLineStats and hasVietnameseChars(cur) then return end

        local translated = translateFullText(cur)
        if translated and translated ~= cur then
            inst:SetAttribute("__ViBusy", true)
            pcall(function() inst.Text = translated end)
            inst:SetAttribute("__ViBusy", false)
        end
    elseif inst:IsA("TextBox") then
        local ph = inst.PlaceholderText
        if ph and ph ~= "" and not hasVietnameseChars(ph) then
            local translatedPh = translateFullText(ph)
            if translatedPh and translatedPh ~= ph then
                inst:SetAttribute("__ViBusy", true)
                pcall(function() inst.PlaceholderText = translatedPh end)
                inst:SetAttribute("__ViBusy", false)
            end
        end
    end
end

-- Hàng đợi xử lý chia nhỏ (Micro-Batch Queue) chống giật lag khi mở tab có nhiều Pet/Egg
local pendingQueue = {}
local queueRunning = false

local function processQueue()
    if queueRunning then return end
    queueRunning = true
    task.spawn(function()
        while isAlive() and #pendingQueue > 0 do
            local batchCount = 0
            while #pendingQueue > 0 and batchCount < 55 do
                local inst = table.remove(pendingQueue)
                if inst and inst.Parent then
                    applyTranslationToInstance(inst)
                end
                batchCount = batchCount + 1
            end
            if #pendingQueue > 0 then
                task.wait()
            end
        end
        queueRunning = false
    end)
end

local function hookTextElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__CodiumViHooked") == SID then return end
    inst:SetAttribute("__CodiumViHooked", SID)

    table.insert(pendingQueue, inst)
    processQueue()

    if inst:IsA("TextBox") then
        inst:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
            if isAlive() and not inst:GetAttribute("__ViBusy") then
                applyTranslationToInstance(inst)
            end
        end)
    else
        inst:GetPropertyChangedSignal("Text"):Connect(function()
            if isAlive() and not inst:GetAttribute("__ViBusy") then
                applyTranslationToInstance(inst)
            end
        end)
    end
end

local IGNORED_GUIS = {
    RobloxGui = true,
    TopBarApp = true,
    TouchGui = true,
    Chat = true,
    BubbleChat = true,
    CoreScriptsRootProvider = true
}

local function hookContainerRoot(root)
    if not root or root:GetAttribute("__RootViHooked") == SID then return end
    root:SetAttribute("__RootViHooked", SID)

    -- Quét 1 lần duy nhất các phần tử đang có sẵn qua hàng đợi chia nhỏ
    for _, gui in ipairs(root:GetChildren()) do
        if not IGNORED_GUIS[gui.Name] then
            for _, desc in ipairs(gui:GetDescendants()) do
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookTextElement(desc)
                end
            end
        end
    end

    -- Bắt sự kiện phần tử mới sinh ra (Zero-Lag, 0% CPU khi đứng yên)
    root.DescendantAdded:Connect(function(desc)
        if not isAlive() then return end
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            local sg = desc:FindFirstAncestorOfClass("ScreenGui")
            if not (sg and IGNORED_GUIS[sg.Name]) then
                task.defer(hookTextElement, desc)
            end
        end
    end)
end

-- Khởi tạo trên toàn bộ không gian chứa UI của Executor (gethui, CoreGui, PlayerGui)
if gethui then
    pcall(function() hookContainerRoot(gethui()) end)
end
pcall(function() hookContainerRoot(CoreGui) end)
pcall(function()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then hookContainerRoot(pg) end
end)
