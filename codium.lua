-- Codium Hub | Arceus X NEO Fix (Zero-Connection Polling) + Ghost Translator
local DISCORD_MASK_TEXT = "★ CODIUM VIỆT HÓA VIP ★"

-- 1. NATIVE BOOTLOADER (Bọc Coroutine cực an toàn cho Arceus X NEO)
coroutine.wrap(function()
    local ok, res = pcall(function() return game:HttpGet("https://getcodium.xyz/loader.luau") end)
    if ok and type(res) == "string" and #res > 10 then
        local fn = loadstring(res)
        if type(fn) == "function" then fn() end
    end
end)()

-- 2. GHOST TRANSLATION DAEMON (Chạy ngầm tách biệt hoàn toàn khỏi luồng của Codium)
coroutine.wrap(function()
    -- Đợi 3 giây cho Codium dựng xong Menu, tránh đụng độ Anti-Tamper lúc khởi tạo
    task.wait(3)

    local env = (getgenv and getgenv()) or _G
    env.__CodiumViSession = (env.__CodiumViSession or 0) + 1
    local SID = env.__CodiumViSession
    local function isAlive() return env.__CodiumViSession == SID end

    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

    local FastCache = {}

    -- ============================================================================
    -- TỪ ĐIỂN DỊCH THUẬT TOÀN DIỆN (ĐÃ CHE LINK DISCORD & FIX LỖI CÂU NỬA ANH NỬA VIỆT)
    -- ============================================================================
    local EXACT_VI = {
        ["Steal an Egg"] = "Steal an Egg (Cướp Trứng)",
        ["cướp an trứng"] = "Steal an Egg (Cướp Trứng)",
        ["Slow Mode"] = "Chế độ chậm",
        ["Slow chế độ"] = "Chế độ chậm",
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
        ["Select Ghost"] = "Chọn Bóng Ma",
        ["Select Ghosts"] = "Chọn Bóng Ma",
        ["Chọn bóng ma"] = "Chọn Bóng Ma",
        ["Ghosts to vacuum. None selected = all, most Souls first."] = "Chọn loại ma cần hút. Không chọn = hút tất cả (ưu tiên nhiều Linh Hồn nhất trước).",
        ["Ghosts to vacuum. Không có đã chọn = tất cả, most Souls first."] = "Chọn loại ma cần hút. Không chọn = hút tất cả (ưu tiên nhiều Linh Hồn nhất trước).",
        ["Auto Vacuum Ghost"] = "Tự Động Hút Bóng Ma",
        ["Auto Vacuum Ghosts"] = "Tự Động Hút Bóng Ma",
        ["Tự động Vacuum bóng ma"] = "Tự Động Hút Bóng Ma",
        ["Boards the Phantom Express when it comes and vacuums ghosts in the Forgotten Town."] = "Tự động lên Tàu Bóng Ma khi tàu đến và hút ma tại Thị Trấn Lãng Quên.",
        ["Boards the Tàu Bóng Ma khi it comes and vacuums ghosts in the Forgotten Town."] = "Tự động lên Tàu Bóng Ma khi tàu đến và hút ma tại Thị Trấn Lãng Quên.",
        ["Prioritize Ghouler"] = "Ưu Tiên Hút Trùm Ghouler",
        ["Ghouler first when he shows up."] = "Ưu tiên hút trùm Ghouler ngay khi hắn xuất hiện.",
        ["Vacuums Ghouler first when he shows up."] = "Ưu tiên hút trùm Ghouler ngay khi hắn xuất hiện.",
        ["Ghouler first khi he hiển thị up."] = "Ưu tiên hút trùm Ghouler ngay khi hắn xuất hiện.",
        ["Trade"] = "Đổi Linh Hồn",
        ["Souls"] = "Linh Hồn (Souls)",
        ["Auto Trade Souls"] = "Tự Động Đổi Linh Hồn",
        ["Tự động Trade Souls"] = "Tự Động Đổi Linh Hồn",
        ["Trades Souls for a Spectral mutation at the Soul Keeper whenever you have enough."] = "Tự động đổi Linh Hồn lấy Đột Biến Quang Phổ tại NPC Giữ Hồn mỗi khi đủ số lượng.",
        ["Trades Souls for a Quang Phổ đột biến at the Soul Keeper whenever you have enough."] = "Tự động đổi Linh Hồn lấy Đột Biến Quang Phổ tại NPC Giữ Hồn mỗi khi đủ số lượng.",
        ["Admin Abuse Boost (BETA)"] = "Lạm Dụng Buff Admin (BETA)",
        ["Phantom Express"] = "Chuyến Tàu Bóng Ma",
        ["Tàu Bóng Ma"] = "Chuyến Tàu Bóng Ma",
        ["Halloween Dimension"] = "Không Gian Halloween",
        ["Ghost Dog Quest"] = "Nhiệm Vụ Chó Ma",
        ["Abandoned Manor"] = "Dinh Thự Bỏ Hoang",
        ["Pumpkin King"] = "Vua Bí Ngô",
        ["The Hollow"] = "Vực Thẳm The Hollow",
        ["Cursed Island Wars"] = "Đại Chiến Đảo Nguyền Rủa",
        ["Pumpkin Moon"] = "Sự Kiện Trăng Bí Ngô",
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
        ["Scrambled"] = "Hỗn Loạn"
    }

    local LOWER_VI = {}
    for k, v in pairs(EXACT_VI) do LOWER_VI[k:lower()] = v end

    local NATURAL_SENTENCE_PATTERNS = {
        { pat = "^[Gg]hosts to vacuum%..*$", rep = "Chọn loại ma cần hút. Không chọn = hút tất cả (ưu tiên nhiều Linh Hồn nhất trước)." },
        { pat = "^[Bb]oards the .- when it comes and vacuums ghosts.*$", rep = "Tự động lên Tàu Bóng Ma khi tàu đến và hút ma tại Thị Trấn Lãng Quên." },
        { pat = "^.*Ghouler first when he shows up.*$", rep = "Ưu tiên hút trùm Ghouler ngay khi hắn xuất hiện." },
        { pat = "^[Tt]rades Souls for a .- at the Soul Keeper whenever you have enough.*$", rep = "Tự động đổi Linh Hồn lấy Đột Biến Quang Phổ tại NPC Giữ Hồn mỗi khi đủ số lượng." },
        { pat = "^[Ss]ession:%s*(%d+)%s*|%s*[Tt]otal:%s*(%d+)$", rep = "Phiên này: %1 | Tổng cộng: %2" },
        { pat = "^[Ss]ouls:%s*(%d+)%s*|%s*[Pp]rice:%s*(%d+)%s*|%s*[Ss]uccess:%s*([%d%%]+)$", rep = "Linh Hồn: %1 | Giá đổi: %2 | Tỷ lệ: %3" },
        { pat = "^[Ss]pectral%s+[Mm]utation:%s*(%d+)$", rep = "Đột biến Quang Phổ: %1" },
        { pat = "^e%.g%.%s*(.+)$", rep = "VD: %1" },
        { pat = "^v(%d+%.%d+.*)$", rep = "Phiên bản %1" },
        { pat = "^World%s+(%d+)$", rep = "Thế Giới %1" },
        { pat = "^Halloween%s+(%d+)$", rep = "Halloween %1" },
        { pat = "^Pet%s+(%d+)$", rep = "Thú Cưng %1" },
        { pat = "^Egg%s+(%d+)$", rep = "Trứng %1" },
        { pat = "^Placed%s+(%d+)$", rep = "Đã Đặt %1" },
        { pat = "^[Pp]rioritize%s+(.+)$", rep = "Ưu Tiên %1" },
        { pat = "^[Ss]elect%s+(.+)$", rep = "Chọn %1" },
        { pat = "^[Aa]uto%s+(.+)$", rep = "Tự Động %1" },
        { pat = "^[Oo]pen%s+(.+)$", rep = "Mở %1" },
        { pat = "^[Ee]nable%s+(.+)$", rep = "Bật %1" },
        { pat = "^[Dd]isable%s+(.+)$", rep = "Tắt %1" }
    }

    local PHRASES_VI = {
        {"steal an egg", "Steal an Egg (Cướp Trứng)"},
        {"cướp an trứng", "Steal an Egg (Cướp Trứng)"},
        {"slow mode", "Chế độ chậm"},
        {"slow chế độ", "Chế độ chậm"},
        {"none selected", "Không chọn"},
        {"không có đã chọn", "Không chọn"},
        {"most souls first", "ưu tiên nhiều Linh Hồn nhất trước"},
        {"forgotten town", "Thị Trấn Lãng Quên"},
        {"soul keeper", "NPC Giữ Hồn"},
        {"when it comes", "khi tàu đến"},
        {"when he shows up", "khi hắn xuất hiện"},
        {"shows up", "xuất hiện"},
        {"whenever you have enough", "mỗi khi bạn có đủ"},
        {"have enough", "đủ số lượng"},
        {"spectral mutation", "Đột Biến Quang Phổ"},
        {"quang phổ đột biến", "Đột Biến Quang Phổ"},
        {"vacuum ghosts", "hút bóng ma"},
        {"vacuums ghosts", "hút bóng ma"},
        {"ghosts to vacuum", "bóng ma cần hút"},
        {"trade souls", "Đổi Linh Hồn"},
        {"trades souls", "Đổi Linh Hồn"},
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
        vacuum = "hút", vacuums = "hút", vacuuming = "đang hút",
        board = "lên", boards = "lên", boarding = "đang lên",
        prioritize = "ưu tiên", prioritizes = "ưu tiên",
        trade = "đổi", trades = "đổi", trading = "đang đổi",
        soul = "Linh Hồn", souls = "Linh Hồn",
        price = "giá", success = "tỷ lệ", session = "phiên này", total = "tổng cộng",
        first = "trước", enough = "đủ", whenever = "mỗi khi",
        when = "khi", while = "trong lúc", where = "nơi",
        it = "nó", he = "hắn", they = "chúng", you = "bạn", your = "của bạn",
        comes = "đến", come = "đến", goes = "đi", go = "đi",
        up = "lên", down = "xuống", into = "vào", out = "ra",
        with = "với", without = "không có",
        most = "nhiều nhất", least = "ít nhất", more = "thêm", less = "ít hơn",
        slow = "chậm", fast = "nhanh",
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
        monster = "quái vật", monsters = "quái vật", boss = "trùm", ghost = "bóng ma", ghosts = "bóng ma",
        pumpkin = "bí ngô", butterfly = "bướm", star = "sao băng", race = "đua", racing = "đua",
        send = "gửi", notification = "thông báo", notifications = "thông báo",
        interval = "chu kỳ", test = "thử", simulate = "giả lập", immediately = "ngay lập tức",
        periodically = "định kỳ", automatically = "tự động",
        only = "chỉ", never = "không bao giờ", always = "luôn",
        every = "mọi", all = "tất cả", none = "không có", empty = "trống", full = "đầy",
        selected = "đã chọn", unlocked = "đã mở khóa", owned = "đã sở hữu",
        common = "Phổ Thông", uncommon = "Thường", rare = "Hiếm", epic = "Sử Thi",
        legendary = "Huyền Thoại", mythic = "Thần Thoại", cosmic = "Vũ Trụ",
        secret = "Bí Ẩn", eternal = "Vĩnh Cửu", divine = "Thánh Thần",
        silver = "Bạc", golden = "Vàng", rainbow = "Cầu Vồng", spectral = "Quang Phổ"
    }

    local STOP_WORDS_REMOVE = { ["the"] = true, ["a"] = true, ["an"] = true }

    local function applyPhrasesAndWords(str)
        local out = str
        local lowerOut = out:lower()
        local changed = false
        for i = 1, #PHRASES_VI do
            local p = PHRASES_VI[i]
            local sIdx, eIdx = lowerOut:find(p[1], 1, true)
            if sIdx then
                out = out:sub(1, sIdx - 1) .. p[2] .. out:sub(eIdx + 1)
                lowerOut = out:lower()
                changed = true
            end
        end
        local wordReplaced = out:gsub("([%a]+)", function(w)
            local lw = w:lower()
            if STOP_WORDS_REMOVE[lw] then changed = true; return "" end
            if lw == "and" then changed = true; return "và" end
            if lw == "or" then changed = true; return "hoặc" end
            if lw == "for" then changed = true; return "đổi lấy" end
            if lw == "to" then changed = true; return "để" end
            if lw == "in" or lw == "at" then changed = true; return "tại" end
            local rep = WORDS_VI[lw] or LOWER_VI[lw]
            if rep then changed = true; return rep end
            return w
        end)
        wordReplaced = (wordReplaced:gsub("%s+", " "):match("^%s*(.-)%s*$") or wordReplaced)
        return wordReplaced, changed
    end

    local function translateSingleLine(line)
        if not line or line == "" then return line end
        local lowerLine = line:lower()
        
        if lowerLine:find("discord%.gg") or lowerLine:find("discord%.com/invite") then
            return DISCORD_MASK_TEXT
        end

        if line:find("Money:", 1, true) or line:find("Pets:", 1, true) or line:find("Eggs:", 1, true) or line:find("Value:", 1, true) then
            return (line:gsub("Money:", "Tiền:"):gsub("Gems:", "Đá Quý:"):gsub("Pets:", "Thú Cưng:"):gsub("Equipped:", "Đang Đeo:"):gsub("Eggs:", "Trứng:"):gsub("Placed:", "Đã Đặt:"):gsub("Value:", "Giá Trị:"):gsub("Gain:", "Thu Nhập:"))
        end

        if line:find("Souls:", 1, true) or line:find("Price:", 1, true) or line:find("Session:", 1, true) or line:find("Spectral Mutation:", 1, true) then
            return (line:gsub("Session:", "Phiên này:"):gsub("Total:", "Tổng cộng:"):gsub("Souls:", "Linh Hồn:"):gsub("Price:", "Giá đổi:"):gsub("Success:", "Tỷ lệ:"):gsub("Spectral Mutation:", "Đột biến Quang Phổ:"))
        end

        local clean = (line:match("^%s*(.-)%s*$") or line):gsub("%s+", " ")
        if clean == "" then return line end

        if clean:match("^[%$%+%-%d%.%,%/%%skmbtqKMBTQsxhg%s]+$") or clean:find("https://", 1, true) or clean:find("CODIUM |", 1, true) then
            return line
        end

        if EXACT_VI[clean] then return EXACT_VI[clean] end
        local lowerClean = clean:lower()
        if LOWER_VI[lowerClean] then
            local r = LOWER_VI[lowerClean]
            if clean:upper() == clean and clean:find("%a") then return r:upper() end
            return r
        end

        if clean:find(",", 1, true) and not clean:find("%.") and #clean < 40 then
            local parts = {}
            local allMatched = true
            for part in clean:gmatch("([^,]+)") do
                local pTrim = part:match("^%s*(.-)%s*$")
                local pVi = EXACT_VI[pTrim] or LOWER_VI[pTrim:lower()]
                if pVi then table.insert(parts, pVi) else allMatched = false; break end
            end
            if allMatched and #parts > 1 then return table.concat(parts, ", ") end
        end

        local working = clean
        local grammarHit = false
        for i = 1, #NATURAL_SENTENCE_PATTERNS do
            local rule = NATURAL_SENTENCE_PATTERNS[i]
            if working:find(rule.pat) then
                working = working:gsub(rule.pat, rule.rep)
                grammarHit = true
                break
            end
        end

        local finalStr, wordHit = applyPhrasesAndWords(working)
        if grammarHit or wordHit then return finalStr end
        return line
    end

    local function translateFullText(raw)
        if type(raw) ~= "string" or raw == "" then return raw end
        if FastCache[raw] then return FastCache[raw] end
        if raw:find("\n", 1, true) then
            local lines = {}
            for line in (raw .. "\n"):gmatch("(.-)\n") do table.insert(lines, translateSingleLine(line)) end
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
    -- 3. ZERO-CONNECTION EVENT POLLER (KHÔNG GÂY LỖI STACK OVERFLOW TRÊN ARCEUS)
    -- ============================================================================
    local activeLabels = {}
    
    local function stillHasUntranslatedEnglish(s)
        local ls = s:lower()
        if ls:find("discord%.gg") or ls:find("cướp an trứng") or ls:find("slow chế độ") then return true end
        if ls:find("ghosts") or ls:find("vacuum") or ls:find("souls") or ls:find("boards") or ls:find("whenever") or ls:find("session:") or ls:find("price:") then return true end
        return false
    end

    local function trackInstance(inst)
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            if not inst:GetAttribute("__ViTrk") then
                inst:SetAttribute("__ViTrk", true)
                table.insert(activeLabels, inst)
            end
        end
    end

    local IGNORED_GUIS = { RobloxGui = true, TopBarApp = true, TouchGui = true, Chat = true, BubbleChat = true, CoreScriptsRootProvider = true }
    local function scanRootsForGuis()
        local roots = { CoreGui }
        if gethui then pcall(function() table.insert(roots, gethui()) end) end
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if pg then table.insert(roots, pg) end

        for _, root in ipairs(roots) do
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and not IGNORED_GUIS[gui.Name] then
                    if not gui:GetAttribute("__ViHk") then
                        gui:SetAttribute("__ViHk", true)
                        for _, d in ipairs(gui:GetDescendants()) do trackInstance(d) end
                        gui.DescendantAdded:Connect(trackInstance)
                    end
                end
            end
        end
    end

    task.spawn(function()
        while task.wait(1.5) do
            if not isAlive() then break end
            pcall(scanRootsForGuis)
        end
    end)

    -- Heartbeat Micro-stepped Poller: Scan flat array without creating Connections (Fixes Arceus crash)
    local idx = 1
    RunService.Heartbeat:Connect(function()
        if not isAlive() or #activeLabels == 0 then return end
        local count = 0
        local limit = 600 -- Xử lý tối đa 600 UI elements mỗi frame để không tụt FPS
        
        while idx <= #activeLabels and count < limit do
            local inst = activeLabels[idx]
            if not inst.Parent then
                table.remove(activeLabels, idx)
            else
                if inst:IsA("TextBox") then
                    local ph = inst.PlaceholderText
                    if ph and ph ~= "" and ph ~= inst:GetAttribute("__LastPh") then
                        local tr = translateFullText(ph)
                        if tr and tr ~= ph then
                            pcall(function() inst.PlaceholderText = tr end)
                        end
                        inst:SetAttribute("__LastPh", tr)
                    end
                else
                    local txt = inst.Text
                    if txt and txt ~= "" and txt ~= inst:GetAttribute("__LastTxt") then
                        -- Bỏ qua nếu chữ có dấu tiếng việt và không còn tàn dư tiếng anh
                        if txt:find("[\194-\244][\128-\191]") and not stillHasUntranslatedEnglish(txt) then
                            inst:SetAttribute("__LastTxt", txt)
                        else
                            local tr = translateFullText(txt)
                            if tr and tr ~= txt then
                                pcall(function() inst.Text = tr end)
                            end
                            inst:SetAttribute("__LastTxt", tr)
                        end
                    end
                end
                idx = idx + 1
            end
            count = count + 1
        end
        if idx > #activeLabels then idx = 1 end
    end)

end)()
