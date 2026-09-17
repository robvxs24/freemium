-- ==============================================================================
--  RONNEI HUB - ZERO-LAG PERFORMANCE TRANSLATION ENGINE V4.3 (FULL SETTINGS)
--  Tối ưu hóa:
--    1. Nạp đúng luồng script gốc Chilli Hub (StealAnEgg).
--    2. Bổ sung 100% mục Settings (Interface, Notifications, Defaults).
--    3. Batch Scanner: Quét phân bổ từng đợt, triệt tiêu lag khởi động.
--    4. Tra cứu O(1) Fast-Path: Dịch tức thì, không lặp Regex khi không cần thiết.
--    5. Nút bấm Frosted Slate thanh lịch, kéo thả mượt mà.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local currentLanguage = "VI"
local translationLock = false
local FastCache = {}

-- ==================== 1. TỪ ĐIỂN TỔNG HỢP TOÀN BỘ CÁC TAB ====================
local EXACT_MAP = {
    -- Thanh Tab chính bên trái
    ["Steal"]                             = "Cướp Trứng",
    ["Auto Grab & Claim"]                 = "Tự Nhặt & Nhận",
    ["Steal Tools"]                       = "Công Cụ Cướp",
    ["Filter Tools"]                      = "Bộ Lọc Trứng",
    ["Steal from players"]                = "Cướp Người Chơi",
    ["Session Counter"]                   = "Bộ Đếm Phiên",
    ["Sell"]                              = "Bán Đồ",
    ["Fuse Partner"]                      = "Ghép Thú Cưng",
    ["The Rift Event"]                    = "Sự Kiện Rift",
    ["Trade & Boss Overload"]             = "Giao Dịch & Boss",
    ["Ride Guard"]                        = "Thú Cưỡi Bảo Vệ",
    ["Guard Mount & Mech Ride"]           = "Thú Cưỡi & Giáp Mech",
    ["Help Player"]                       = "Hỗ Trợ Bạn Bè",
    ["Stash & Avoid Friends"]             = "Giấu Trứng & Tránh Bạn",
    ["FPS Boost"]                         = "Tăng Tốc FPS",
    ["Boost Performance"]                 = "Tối Ưu Hiệu Năng",
    ["Server Hop"]                        = "Đổi Server",
    ["Settings"]                          = "Cài Đặt",
    ["Display & UI Scaling"]              = "Hiển Thị & Tỉ Lệ UI",
    ["Webhook"]                           = "Báo Webhook",
    ["Discord Live Alerts"]               = "Thông Báo Discord",

    -- Breadcrumbs (Menu con trong Phím Tắt)
    ["Farm Tab > Auto Steal"]             = "Tab Cày Cuốc > Tự Động Cướp",
    ["Farm Tab > Auto Place Egg"]         = "Tab Cày Cuốc > Tự Đặt Trứng",
    ["Farm Tab > Auto Treadmill"]         = "Tab Cày Cuốc > Tự Chạy Máy Tập",
    ["Farm Tab > Auto Hatch & Equip"]     = "Tab Cày Cuốc > Tự Ấp & Trang Bị",
    ["Farm Tab > Auto Sell"]              = "Tab Cày Cuốc > Tự Động Bán",
    ["Farm Tab > Auto Fuse Machine"]      = "Tab Cày Cuốc > Tự Động Ghép",
    ["Farm Tab > Auto Favorite"]          = "Tab Cày Cuốc > Tự Yêu Thích",
    ["Farm Tab > Auto Rift & Boss"]       = "Tab Cày Cuốc > Tự Động Rift & Boss",
    ["Player Tab > ESP"]                  = "Tab Người Chơi > Xuyên Tường (ESP)",
    ["Player Tab > Movement"]             = "Tab Người Chơi > Di Chuyển",
    ["Player Tab > Character"]            = "Tab Người Chơi > Nhân Vật",
    ["Egg Finder Tab > Egg Finder"]       = "Tab Tìm Trứng > Tìm Trứng",
    ["Predictor Tab > Discord Webhook"]   = "Tab Dự Đoán > Webhook Discord",
    ["Predictor Tab > Egg Predictor"]     = "Tab Dự Đoán > Dự Đoán Trứng",
    ["Progress Tab > Auto Progression"]   = "Tab Tiến Độ > Tự Động Thăng Tiến",
    ["Server Tab > Server"]               = "Tab Máy Chủ > Máy Chủ",
    ["Misc Tab > Performance"]            = "Tab Linh Tinh > Hiệu Năng",
    ["Misc Tab > Utility"]                = "Tab Linh Tinh > Tiện Ích",
    ["Discord Tab > Community"]           = "Tab Discord > Cộng Đồng",
    ["Settings Tab > Defaults"]           = "Tab Cài Đặt > Mặc Định",
    ["Config Tab > Config"]               = "Tab Cấu Hình > Cấu Hình",
    ["Config Tab > Profiles"]             = "Tab Cấu Hình > Hồ Sơ",
    ["Config Tab > Import/Export"]        = "Tab Cấu Hình > Nhập/Xuất",

    -- Tính năng bên trong (Settings, Config & Cài đặt)
    ["Interface"]                         = "Giao Diện",
    ["UI Size"]                           = "Kích Cỡ UI",
    ["Scales the main window; the corner grip does the same by hand"] = "Đổi cỡ cửa sổ chính; có thể kéo góc để đổi thủ công",
    ["Notifications"]                     = "Thông Báo",
    ["Show notification cards; turning this off hides every notify"] = "Hiện thẻ thông báo; tắt mục này sẽ ẩn mọi thông báo",
    ["Open On Launch"]                    = "Mở Khi Khởi Chạy",
    ["Open the UI automatically when the script starts"] = "Tự động mở giao diện khi script vừa bật",
    ["Defaults"]                          = "Mặc Định",
    ["Reset to Defaults"]                 = "Đặt Lại Mặc Định",
    ["Reset every feature to its built-in default"] = "Khôi phục mọi tính năng về mặc định ban đầu",
    ["Turn Off All Toggles"]              = "Tắt Tất Cả Công Tắc",
    ["Switch off every enabled toggle in the feature tabs"] = "Tắt mọi công tắc đang bật trong các tab tính năng",
    ["Turn Off"]                          = "Tắt Ngay",
    ["Auto Save Config"]                  = "Tự Động Lưu Cấu Hình",
    ["Auto Load Config"]                  = "Tự Động Nạp Cấu Hình",
    ["New Config Name"]                   = "Tên Cấu Hình Mới",
    ["Create New Config"]                 = "Tạo Cấu Hình Mới",
    ["Save Config"]                       = "Lưu Cấu Hình",
    ["Import Config Text"]                = "Nhập Mã Văn Bản Cấu Hình",

    -- Tiện ích & Hiệu năng
    ["FPS Cap"]                           = "Giới Hạn FPS",
    ["Optimizer"]                         = "Tối Ưu Hóa Tối Đa",
    ["FPS and Ping"]                      = "Hiển Thị FPS & Ping",
    ["FPS and Ping Size"]                 = "Kích Cỡ Chữ FPS & Ping",
    ["Anti AFK"]                          = "Chống Treo Máy (AFK)",
    ["Copy Discord Link"]                 = "Chép Link Discord",

    -- Auto Steal
    ["Auto Steal Eggs"]                   = "Tự Động Cướp Trứng",
    ["Teleport Mode [Gold/Premium]"]       = "Chế Độ Dịch Chuyển [Gold/VIP]",
    ["Fly Mode"]                          = "Chế Độ Bay",
    ["Real Godmode"]                      = "Bất Tử Thực Thể",
    ["Auto Steal Speed (Recommended 80% - 90%)"] = "Tốc Độ Cướp (Khuyên Dùng 80% - 90%)",
    ["Force Speed To (0 = Auto / Q"]       = "Ép Tốc Độ (0 = Tự Động / Q)",
    ["Force Speed To"]                    = "Ép Tốc Độ",
    ["Manual Steal (Instant Carry)"]      = "Cướp Thủ Công (Nhặt Tức Thì)",
    ["Instant Carry Rarities"]            = "Độ Hiếm Nhặt Tức Thì",

    -- Auto Filter
    ["Pet Names (Auto Place)"]            = "Tên Thú Cưng (Tự Đặt)",
    ["All (none)"]                        = "Tất Cả (Không Chọn)",
    ["Rarities"]                          = "Độ Hiếm",
    ["Areas"]                             = "Khu Vực",
    ["Priority"]                          = "Ưu Tiên",
    ["Rarity"]                            = "Độ Hiếm",
    ["Min Egg KG (0 = off)"]              = "KG Trứng Tối Thiểu (0 = Tắt)",
    ["Automation & Egg Management"]       = "Tự Động & Quản Lý Trứng",
    ["Auto Hatch Ready"]                  = "Tự Ấp Trứng Sẵn Sàng",
    ["Auto Place All Egg"]                = "Tự Đặt Mọi Quả Trứng",

    -- Tab Steal from players
    ["Auto Steal from other players [Gold/Premium]"] = "Tự Cướp Từ Người Khác [Gold/VIP]",
    ["Automatically target players carrying eggs"]    = "Tự Nhắm Người Đang Cầm Trứng",
    ["Filter Rarity for Steal"]           = "Lọc Độ Hiếm Để Cướp",
    ["Steal from special for player (Teleport Strike)"] = "Cướp Đặc Biệt (Đòn Dịch Chuyển)",
    ["Steal History"]                     = "Lịch Sử Cướp",
    ["History of Stolen Eggs from Players"]= "Lịch Sử Cướp Trứng Phiên Này",
    ["Clear"]                             = "Xóa",
    ["No player steals recorded yet this session."] = "Chưa có lượt cướp nào trong phiên.",
    ["In Safe Zone"]                      = "Trong Vùng An Toàn",
    ["No Egg Carried"]                    = "Không Cầm Trứng",
    ["Locked"]                            = "Đã Khóa",

    -- Tab Session Counter
    ["STOLEN EGGS"]                       = "TRỨNG ĐÃ CƯỚP",
    ["HUNTED TARGETS"]                    = "MỤC TIÊU ĐÃ SĂN",
    ["Reset Session Counter"]             = "Đặt Lại Bộ Đếm Phiên",
    ["Live Engine"]                       = "Đang Hoạt Động",
    ["Idle"]                              = "Đang Chờ",

    -- Tab Sell
    ["Bag Inventory & Live Value"]        = "Túi Đồ & Giá Trị Thực",
    ["TOTAL VALUE IN BAG"]                = "TỔNG GIÁ TRỊ TÚI",
    ["TOTAL ITEMS IN BAG"]                = "TỔNG SỐ LƯỢNG TÚI",
    ["Sell Below Value (cth 100M, ..."]   = "Bán Dưới Mức Giá (VD: 100M,...)",
    ["Sell Below KG (0=off)"]             = "Bán Dưới KG (0 = Tắt)",
    ["Auto Sell Egg"]                     = "Tự Động Bán Trứng",
    ["Sell Eggs Now"]                     = "Bán Trứng Ngay",
    ["Pet Names (per area)"]              = "Tên Thú (Theo Khu Vực)",
    ["Auto Sell Pet"]                     = "Tự Động Bán Thú Cưng",
    ["Sell Pets Now"]                     = "Bán Thú Cưng Ngay",

    -- Tab Fuse Partner
    ["Select Pet to Fuse"]                = "Chọn Thú Cưng Để Ghép",
    ["Refresh Inventory Pets"]            = "Làm Mới Túi Thú Cưng",
    ["Find Partner (Register) [Gold/Premium]"] = "Tìm Bạn Ghép (Đăng Ký) [Gold/VIP]",
    ["Broadcast Need Partner [Gold/Premium]"]  = "Phát Thông Báo Cần Ghép [Gold/VIP]",

    -- Tab The Rift Event
    ["Rift Live Status & Rotation"]       = "Trạng Thái Trực Tiếp & Lượt Đổi Rift",
    ["Banner: [Verdant] Riftborn"]        = "Banner: [Lục Bảo] Riftborn",
    ["Refresh"]                           = "Làm Mới",
    ["Open Boss Shop"]                    = "Mở Cửa Hàng Boss",
    ["Auto Buy Boss Shop"]                = "Tự Mua Shop Boss",
    ["Auto Trade-In (Sacrifice)"]         = "Tự Động Hiến Tế (Trade-In)",
    ["Auto Free Reroll if Missing Pets"]  = "Tự Quay Miễn Phí Nếu Thiếu Thú",
    ["Prioritize Rift Pets in Auto Steal"] = "Ưu Tiên Thú Rift Khi Cướp",
    ["Target Banners (none = all)"]       = "Banner Mục Tiêu (Trống = Tất Cả)",
    ["Boss Rift (Abyss Overlord)"]        = "Boss Rift (Chúa Tể Vực Thẳm)",
    ["Auto Boss Rift (Enter & Fight)"]    = "Tự Vào & Đánh Boss Rift",
    ["Auto Destroy Crystals & Hit Boss"]  = "Tự Phá Tinh Thể & Đánh Boss",
    ["Auto Return to Safe Zone After Boss"]= "Tự Về Vùng An Toàn Sau Khi Xong",
    ["Enter Boss Arena Now"]              = "Vào Đấu Trường Boss Ngay",
    ["Leave Boss Arena (To Safe Zone)"]   = "Rời Đấu Trường (Về Vùng An Toàn)",
    ["Place Rift Eggs to Pen"]            = "Đặt Trứng Rift Vào Chuồng",
    ["Instant Trade-In Once"]             = "Hiến Tế Nhanh 1 Lần",
    ["Use Free Reroll Now"]               = "Dùng Lượt Quay Miễn Phí Ngay",
    ["Buy 1x Mutation Consumable"]        = "Mua 1x Thuốc Đột Biến",
    ["Claim All Available Milestones"]    = "Nhận Tất Cả Mốc Thưởng",
    ["Teleport to Rift Machine"]          = "Dịch Chuyển Đến Máy Rift",
    ["Session Stats"]                     = "Thống Kê Phiên",
    ["Rift Sacrifices"]                   = "Lượt Hiến Tế Rift",
    ["RIFT SACRIFICES"]                   = "LƯỢT HIẾN TẾ RIFT",

    -- Tab Ride Guard & Help Player
    ["Guard"]                             = "Thú Cưỡi",
    ["Light Dark"]                        = "Quang Ám Long",
    ["Hunt & Stash Settings"]             = "Cài Đặt Săn & Giấu Đồ",
    ["Drop Egg Before Safe Zone"]         = "Thả Trứng Trước Vùng An Toàn",
    ["Do Not Deliver to Safe Zone"]       = "Không Nộp Vào Vùng An Toàn",
    ["Never Drop the Egg"]                = "Tuyệt Đối Không Làm Rơi Trứng",
    ["Set Staging Spot (Here)"]           = "Đặt Điểm Trung Chuyển (Tại Đây)",
    ["Deliver Stash Now"]                 = "Nộp Toàn Bộ Trứng Đang Giấu",

    -- Tab Server Hop
    ["Auto Execute"]                      = "Tự Khởi Chạy",
    ["Hop Server"]                        = "Đổi Server",
    ["Hop Now (Emptiest Server)"]         = "Đổi Server Ngay (Phòng Trống Nhất)",
    ["Solo Server"]                       = "Phòng Đơn",
    ["Hop"]                               = "Chuyển",
    ["Prev"]                              = "Trước",
    ["Next"]                              = "Sau",

    -- ESP & Character
    ["ESP Eggs"]                          = "Hiển Thị Trứng",
    ["ESP Fixed Size"]                    = "Cố Định Kích Cỡ ESP",
    ["ESP Own Base Eggs"]                 = "Hiển Thị Trứng Base Mình",
    ["ESP Min Value"]                     = "Giá Trị ESP Tối Thiểu",
    ["ESP Egg Size"]                      = "Kích Cỡ Trứng ESP",
    ["ESP Guards"]                        = "Hiển Thị Vệ Sĩ",
    ["ESP Guard Size"]                    = "Kích Cỡ Vệ Sĩ ESP",
    ["ESP Players"]                       = "Hiển Thị Người Chơi",
    ["ESP Player Size"]                   = "Kích Cỡ Người Chơi ESP",
    ["Speed Boost"]                       = "Tăng Tốc Di Chuyển",
    ["Boost Speed"]                       = "Tốc Độ Tăng Cường",
    ["Infinite Jump"]                     = "Nhảy Vô Hạn",
    ["Anti Ragdoll"]                      = "Chống Ngã (Ragdoll)",
    ["Anti Trap"]                         = "Chống Bẫy",
    ["Instant Steal"]                     = "Cướp Tức Thì",

    -- Webhook
    ["Destination"]                       = "Địa Chỉ Gửi",
    ["Webhook URL"]                       = "Đường Dẫn Webhook",
    ["Alert Types"]                       = "Các Loại Thông Báo",
    ["Periodic Progress"]                 = "Báo Tiến Trình Định Kỳ",
    ["Egg Spawn Alert"]                   = "Báo Trứng Xuất Hiện",
    ["Collect / Claim"]                   = "Báo Nhặt / Nhận Thưởng",
    ["Egg Hatched"]                       = "Báo Trứng Nở",
    ["Pet Obtained"]                      = "Báo Nhận Thú Cưng",
    ["Pets Sold"]                         = "Báo Đã Bán Thú",
    ["Trails Bought"]                     = "Báo Mua Vệt Sáng",
    ["Auto Gift Alert"]                   = "Báo Quà Tự Động",
    ["Rebirth Alert"]                     = "Báo Chuyển Sinh (Rebirth)",
    ["Disconnect Alert"]                  = "Báo Khi Mất Kết Nối",
    ["Alert Filters"]                     = "Bộ Lọc Cảnh Báo",
    ["Min Rarity for Alerts"]             = "Độ Hiếm Tối Thiểu Để Báo",
    ["Any"]                               = "Bất Kỳ",
    ["Manual Actions"]                    = "Thao Tác Thủ Công",
    ["Send Summary Now"]                  = "Gửi Báo Cáo Tổng Hợp Ngay",
    ["Test Webhook"]                      = "Kiểm Tra Gửi Webhook",

    -- Điều hướng
    ["Window Minimized - Click bubble to restore"] = "Cửa sổ đã thu nhỏ - Bấm bong bóng để mở lại",
    ["Let's Chat!"]                       = "Trò Chuyện Nào!",
    ["Connecting to Global Script Chat..."] = "Đang kết nối chat thế giới...",
    ["Send"]                              = "Gửi",
    ["Live"]                              = "Trực Tiếp",
    ["Spoof anti cheat success!"]         = "Đã vượt qua Anti-Cheat thành công!",
    ["Fetching..."]                       = "Đang Tải Dữ Liệu...",
    ["Loaded"]                            = "Đã Nạp Xong"
}

-- Chuỗi động Regex (Tự động bù số liệu, khu vực, trạng thái, thời gian)
local DYNAMIC_PATTERNS = {
    {
        pattern = "^(%d+) selected$",
        format  = function(count) return "Đã chọn " .. count end
    },
    {
        pattern = "^Eggs placed (%d+)%/(%d+) %- (%d+)%/(%d+) pets equipped, (%d+) in bag$",
        format  = function(e1, e2, p1, p2, b1) return "Đã đặt " .. e1 .. "/" .. e2 .. " trứng - " .. p1 .. "/" .. p2 .. " thú trang bị, " .. b1 .. " trong túi" end
    },
    {
        pattern = "^Pet matches %- (%d+) pets for %$(.-)$",
        format  = function(count, val) return "Thú khớp - " .. count .. " thú giá $" .. val end
    },
    {
        pattern = "^Egg matches %- (%d+) eggs for %$(.-)$",
        format  = function(count, val) return "Trứng khớp - " .. count .. " trứng giá $" .. val end
    },
    {
        pattern = "^Next fuse %- (%d+) (.-) for %$(.-)$",
        format  = function(count, name, val) return "Ghép tiếp - " .. count .. " " .. name .. " tốn $" .. val end
    },
    {
        pattern = "^Favorite matches %- (%d+) pets, (%d+) to mark %| (%d+) favorited$",
        format  = function(mCount, mark, fav) return "Khớp yêu thích - " .. mCount .. " thú, " .. mark .. " cần đánh dấu | " .. fav .. " đã thích" end
    },
    {
        pattern = "^Riftborn %- needs (.-), (.-), (.-) %- pity (%d+)%/(%d+) %- free rerolls (%d+) %-$",
        format  = function(p1, p2, p3, pity1, pity2, reroll) return "Riftborn - Cần: " .. p1 .. ", " .. p2 .. ", " .. p3 .. " - Bảo hiểm: " .. pity1 .. "/" .. pity2 .. " - Lượt quay free: " .. reroll .. " -" end
    },
    {
        pattern = "^rotates in (.-) %- boss portal (.-)$",
        format  = function(timeStr, status) return "Đổi mới sau " .. timeStr .. " - Cổng Boss: " .. (status == "closed" and "Đã Đóng" or "Mở") end
    },
    {
        pattern = "^(%d+) eggs %- (%d+) ready %- (%d+) growing %- (%d+) in bag %- Total (.-)$",
        format  = function(e1, r1, g1, b1, t1) return e1 .. " trứng - " .. r1 .. " sẵn sàng - " .. g1 .. " đang lớn - " .. b1 .. " trong túi - Tổng " .. t1 end
    },
    {
        pattern = "^Players (%d+)%/(%d+)$",
        format  = function(p1, p2) return "Người chơi: " .. p1 .. "/" .. p2 end
    }
}

local SortedPhrases = {}
for en, vi in pairs(EXACT_MAP) do
    table.insert(SortedPhrases, {en = en, vi = vi, len = #en})
end
table.sort(SortedPhrases, function(a, b) return a.len > b.len end)

-- ==================== 2. ENGINE DỊCH FAST-PATH SIÊU TỐC ====================
local function translateText(raw)
    if FastCache[raw] then return FastCache[raw] end

    local trimmed = raw:gsub("^%s*(.-)%s*$", "%1")

    if EXACT_MAP[trimmed] then
        local res = raw:gsub(trimmed, EXACT_MAP[trimmed], 1)
        FastCache[raw] = res
        return res
    end

    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            local res = item.format(unpack(matches))
            FastCache[raw] = res
            return res
        end
    end

    local result = raw
    local matched = false
    for _, item in ipairs(SortedPhrases) do
        if result:find(item.en, 1, true) then
            result = result:gsub(item.en, item.vi)
            matched = true
        end
    end

    FastCache[raw] = matched and result or raw
    return FastCache[raw]
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

    if currentLanguage == "VI" then
        local viText = translateText(original)
        if inst.Text ~= viText then
            translationLock = true
            inst.Text = viText
            translationLock = false
        end
    else
        if inst.Text ~= original then
            translationLock = true
            inst.Text = original
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
            local isKnownVi = false
            for _, item in ipairs(SortedPhrases) do
                if current == item.vi then
                    isKnownVi = true
                    break
                end
            end

            if not isKnownVi then
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

-- ==================== 3. NÚT ĐỔI NGÔN NGỮ (FROSTED SLATE MINIMAL) ====================
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
    Icon.TextColor3 = Color3.fromRGB(200, 160, 160)

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

-- ==================== 4. QUÉT PHÂN BỔ CHỐNG LAG KHỞI ĐỘNG ====================
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

-- ==================== 5. NẠP SCRIPT GỐC CHILLI HUB ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg"))()
    end)
end)
