-- ==============================================================================
--  RONNEI HUB - PERFORMANCE TRANSLATION ENGINE V3.5 (SLATE FROSTED / ZERO-LAG)
--  Tối ưu hóa:
--    1. Bộ nhớ đệm O(1) Memoization (không chạy lại RegEx trên chuỗi đã dịch).
--    2. Triệt tiêu vòng quét nặng máy (Loại bỏ while scan 0.1s -> Chuyển sang Event-Driven).
--    3. Giữ nguyên toàn vẹn từ điển 14 Tab tiếng Việt chuẩn xác.
--    4. Nút bấm Slate Frosted Glass êm mắt, kéo thả mượt mà, không giật lag.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local currentLanguage = "VI"
local translationLock = false
local TranslationCache = {} -- Bộ đệm cache chuỗi O(1) chống ngốn CPU

-- ==================== 1. TỪ ĐIỂN DỊCH THUẬT ====================
local EXACT_MAP = {
    -- Danh mục Tab chính bên trái
    ["Steal"]                             = "Cướp Trứng",
    ["Auto Grab & Claim"]                 = "Tự Nhặt & Nhận",
    ["Steal Tools"]                       = "Công Cụ Cướp",
    ["Filter Tools"]                      = "Bộ Lọc Trứng",
    ["Steal from players"]                = "Cướp Người Chơi",
    ["Session Counter"]                   = "Bộ Đếm Phiên",
    ["Sell"]                              = "Bán Đồ",
    ["Fuse Partner"]                      = "Ghép Thú Cưng",
    ["The Rift Event"]                    = "Sự Kiện Rift",
    ["Trade & Boss Overload"]             = "Giao Dịch & Đánh Boss",
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
    ["Discord Live Alerts"]               = "Thông Báo Discord Trực Tiếp",

    -- Tab 1 & 2: Steal & Steal Tools
    ["Teleport Mode [Gold/Premium]"]       = "Dịch Chuyển [Gold/VIP]",
    ["Auto Steal Eggs"]                   = "Tự Động Cướp Trứng",
    ["Fly Mode"]                          = "Chế Độ Bay",
    ["Real Godmode"]                      = "Bất Tử Thực Thể",
    ["Auto Place to Pen"]                 = "Tự Đặt Vào Chuồng",
    ["Auto Treadmill"]                    = "Tự Chạy Máy Tập",
    ["Auto Steal Speed (Recommended 80% - 90%)"] = "Tốc Độ Cướp (Khuyên Dùng 80% - 90%)",
    ["Force Speed To (0 = Auto / Q"]       = "Ép Tốc Độ Di Chuyển (0 = Tự Động)",
    ["Manual Steal (Instant Carry)"]      = "Cướp Thủ Công (Nhặt Tức Thì)",
    ["Instant Carry (Manual Steal)"]      = "Nhặt Tức Thì (Thủ Công)",
    ["Instant Carry Rarities"]            = "Độ Hiếm Nhặt Tức Thì",

    -- Tab 3: Filter Tools & Automation
    ["Pet Names (Auto Place)"]            = "Tên Thú Cưng (Tự Đặt)",
    ["All (none)"]                        = "Tất Cả (Không Chọn)",
    ["Rarities"]                          = "Độ Hiếm",
    ["Areas"]                             = "Khu Vực",
    ["Priority"]                          = "Ưu Tiên",
    ["Rarity"]                            = "Độ Hiếm",
    ["Min Egg KG (0 = off)"]              = "KG Tối Thiểu (0 = Tắt)",
    ["Automation & Egg Management"]       = "Tự Động & Quản Lý Trứng",
    ["Auto Hatch Ready"]                  = "Tự Ấp Trứng Đã Sẵn Sàng",
    ["Auto Place All Egg"]                = "Tự Đặt Mọi Quả Trứng",
    ["Auto Place Selected (By Pet Names Filter)"] = "Tự Đặt Trứng Đã Lọc Theo Tên",

    -- Tab 4: Steal from players
    ["Auto Steal from other players [Gold/Premium]"] = "Tự Cướp Từ Người Khác [Gold/VIP]",
    ["Automatically target players carrying eggs"]    = "Tự Nhắm Người Đang Cầm Trứng",
    ["Filter Rarity for Steal"]           = "Lọc Độ Hiếm Để Cướp",
    ["Steal from special for player (Teleport Strike)"] = "Cướp Đòn Dịch Chuyển Đặc Biệt",
    ["Steal History"]                     = "Lịch Sử Cướp",
    ["History of Stolen Eggs from Players"]= "Lịch Sử Cướp Trứng Phiên Này",
    ["Clear"]                             = "Xóa",
    ["No player steals recorded yet this session."] = "Chưa ghi nhận lượt cướp nào trong phiên.",
    ["In Safe Zone"]                      = "Trong Vùng An Toàn",
    ["No Egg Carried"]                    = "Không Cầm Trứng",
    ["Locked"]                            = "Đã Khóa",

    -- Tab 5: Session Counter
    ["STOLEN EGGS"]                       = "TRỨNG ĐÃ CƯỚP",
    ["HUNTED TARGETS"]                    = "MỤC TIÊU ĐÃ SĂN",
    ["Reset Session Counter"]             = "Đặt Lại Bộ Đếm Phiên",
    ["Live Engine"]                       = "Hệ Thống Bật",
    ["Idle"]                              = "Đang Chờ",

    -- Tab 6: Sell
    ["Bag Inventory & Live Value"]        = "Túi Đồ & Giá Trị Thực",
    ["TOTAL VALUE IN BAG"]                = "TỔNG GIÁ TRỊ TÚI",
    ["TOTAL ITEMS IN BAG"]                = "TỔNG SỐ LƯỢNG",
    ["Sell Egg Settings"]                 = "Cài Đặt Bán Trứng",
    ["Sell Below Value (cth 100M, ..."]   = "Bán Dưới Mức Giá (VD: 100M)",
    ["Sell Below KG (0=off)"]             = "Bán Dưới Trọng Lượng (KG)",
    ["Auto Sell Egg"]                     = "Tự Động Bán Trứng",
    ["Sell Eggs Now"]                     = "Bán Trứng Ngay",
    ["Sell Pet Filter"]                   = "Bộ Lọc Bán Thú Cưng",
    ["Pet Names (per area)"]              = "Tên Thú (Theo Khu Vực)",
    ["Auto Sell Pet"]                     = "Tự Động Bán Thú Cưng",
    ["Sell Pets Now"]                     = "Bán Thú Cưng Ngay",

    -- Tab 7: Fuse Partner
    ["Select Pet to Fuse"]                = "Chọn Thú Cưng Ghép",
    ["Refresh Inventory Pets"]            = "Làm Mới Danh Sách Thú",
    ["List Player Need Partner"]          = "Danh Sách Người Cần Ghép",
    ["Find Partner (Register) [Gold/Premium]"] = "Tìm Bạn Ghép (Đăng Ký)",
    ["Refresh Partner List"]              = "Làm Mới Danh Sách Ghép",
    ["Broadcast Need Partner [Gold/Premium]"]  = "Thông Báo Cần Tìm Bạn Ghép",
    ["Filter by Pet Owned (e.g. Pegasus)..."]  = "Lọc theo thú đang có (VD: Pegasus)...",
    ["No other players are currently looking for a partner."] = "Hiện không có người chơi nào tìm bạn ghép.",

    -- Tab 8: The Rift Event
    ["Rift Live Status & Rotation"]       = "Trạng Thái Trực Tiếp Sự Kiện Rift",
    ["Banner: [Verdant] Riftborn"]        = "Banner: [Lục Bảo] Riftborn",
    ["Refresh"]                           = "Làm Mới",
    ["Recipe egg is still unmatched! Must hatch into pets before Trade-In."] = "Chưa ghép đúng công thức! Cần ấp thành thú trước khi Hiến Tế.",
    ["Open Boss Shop"]                    = "Mở Cửa Hàng Boss",
    ["Auto Buy Boss Shop"]                = "Tự Mua Shop Boss",
    ["Automation"]                        = "Tự Động Hóa",
    ["Auto Trade-In (Sacrifice)"]         = "Tự Động Hiến Tế (Trade-In)",
    ["Auto Free Reroll if Missing Pets"]  = "Tự Quay Miễn Phí Khi Thiếu Thú",
    ["Prioritize Rift Pets in Auto Steal"] = "Ưu Tiên Cướp Thú Rift",
    ["Target Banners (none = all)"]       = "Banner Mục Tiêu (Trống = Tất Cả)",
    ["Boss Rift (Abyss Overlord)"]        = "Boss Rift (Chúa Tể Vực Thẳm)",
    ["Abyss Overlord (Portal Closed)"]    = "Chúa Tể Vực Thẳm (Cổng Đang Đóng)",
    ["Boss HP: Waiting for spawn..."]     = "Máu Boss: Đang chờ xuất hiện...",
    ["Auto Boss Rift (Enter & Fight)"]    = "Tự Vào & Đánh Boss Rift",
    ["Auto Destroy Crystals & Hit Boss"]  = "Tự Phá Tinh Thể & Đánh Boss",
    ["Auto Return to Safe Zone After Boss"]= "Tự Về Khu An Toàn Sau Boss",
    ["Boss Glide Speed (studs/s)"]        = "Tốc Độ Bay Đánh Boss",
    ["Enter Boss Arena Now"]              = "Vào Đấu Trường Boss Ngay",
    ["Leave Boss Arena (To Safe Zone)"]   = "Rời Khỏi Đấu Trường (Về Vùng An Toàn)",
    ["Manual Attack (Equip Bat & Swing)"] = "Tự Cầm Gậy Đập Boss",
    ["Quick Actions"]                     = "Thao Tác Nhanh",
    ["Place Rift Eggs to Pen"]            = "Đặt Trứng Rift Vào Chuồng",
    ["Instant Trade-In Once"]             = "Hiến Tế Nhanh 1 Lần",
    ["Use Free Reroll Now"]               = "Dùng Lượt Quay Miễn Phí",
    ["Buy 1x Mutation Consumable"]        = "Mua 1x Thuốc Đột Biến",
    ["Claim All Available Milestones"]    = "Nhận Tất Cả Mốc Thưởng",
    ["Teleport to Rift Machine"]          = "Dịch Chuyển Đến Máy Rift",
    ["Refresh Status"]                    = "Làm Mới Trạng Thái",
    ["Session Stats"]                     = "Thống Kê Phiên",
    ["RIFT SACRIFICES"]                   = "LƯỢT HIẾN TẾ RIFT",

    -- Tab 9: Ride Guard
    ["Guard"]                             = "Vệ Sĩ",
    ["Light Dark"]                        = "Quang Ám Long",

    -- Tab 10: Help Player
    ["Hunt & Stash Settings"]             = "Cài Đặt Săn & Giấu Trứng",
    ["Drop Egg Before Safe Zone"]         = "Thả Trứng Trước Khu An Toàn",
    ["Do Not Deliver to Safe Zone"]       = "Không Nộp Vào Khu An Toàn",
    ["Never Drop the Egg"]                = "Tuyệt Đối Không Làm Rơi Trứng",
    ["Staging Controls"]                  = "Điều Khiển Điểm Trung Chuyển",
    ["Set Staging Spot (Here)"]           = "Đặt Điểm Giấu Trứng (Tại Đây)",
    ["Deliver Stash Now"]                 = "Nộp Toàn Bộ Trứng Đang Giấu",

    -- Tab 11: FPS Boost
    ["Engine Performance"]                = "Tối Ưu Hiệu Năng",
    ["Uncap FPS, Lighting Compatibility, SmoothPlastic, & Native Low Settings"] = "Mở khóa FPS, Tối ưu ánh sáng, Bật Nhựa Mịn & Đồ họa thấp",
    ["Re-apply Boost Now"]                = "Kích Hoạt Lại Tăng Tốc Ngay",
    ["Visual & Clean Up"]                 = "Hình Ảnh & Dọn Dẹp Bản Đồ",
    ["Delete other player pet and egg"]   = "Ẩn Thú Cưng & Trứng Người Khác",
    ["Hapus visual pet & telur dari player lain (Aman: telur area tetap ada)"] = "Xóa hình ảnh thú & trứng người khác (An toàn: trứng khu vực vẫn giữ)",

    -- Tab 12: Server Hop
    ["Auto Execute"]                      = "Tự Khởi Chạy",
    ["Hop Server"]                        = "Chuyển Server",
    ["Hop Now (Emptiest Server)"]         = "Đổi Server Ngay (Phòng Trống Nhất)",
    ["Hop"]                               = "Chuyển",
    ["Prev"]                              = "Trước",
    ["Next"]                              = "Sau",

    -- Tab 13: Settings
    ["Display & Window"]                  = "Màn Hình & Giao Diện",
    ["Display Full Size (PC)"]            = "Hiển Thị Toàn Màn Hình (PC)",
    ["PC Full Size sets 100% scale for desktop displays. Turn OFF for"] = "Chế độ toàn màn hình 100% cho máy tính. Hãy TẮT nếu dùng điện thoại",
    ["Anti-AFK Protection"]               = "Bảo Vệ Chống Treo Máy (Anti-AFK)",
    ["Anti AFK"]                          = "Chống AFK",
    ["Prevent idle triggers, 20-min Roblox kick & game soft-teleports with"] = "Ngăn chặn bị văng game sau 20 phút và tránh bị dịch chuyển bất ngờ",
    ["View Disconnect Log"]               = "Xem Nhật Ký Mất Kết Nối",
    ["Clear Disconnect Log"]              = "Xóa Nhật Ký Mất Kết Nối",
    ["Configuration"]                     = "Cấu Hình",
    ["Save Settings Config"]              = "Lưu Cấu Hình Cài Đặt",

    -- Tab 14: Webhook
    ["Destination"]                       = "Địa Chỉ Gửi",
    ["Webhook URL"]                       = "Đường Dẫn Webhook URL",
    ["Alert Types"]                       = "Các Loại Thông Báo",
    ["Periodic Progress"]                 = "Tiến Trình Định Kỳ",
    ["Egg Spawn Alert"]                   = "Báo Trứng Xuất Hiện",
    ["Collect / Claim"]                   = "Báo Nhặt / Nhận Quà",
    ["Egg Hatched"]                       = "Báo Trứng Nở",
    ["Pet Obtained"]                      = "Báo Nhận Thú Cưng",
    ["Pets Sold"]                         = "Báo Đã Bán Thú",
    ["Trails Bought"]                     = "Báo Đã Mua Vệt Sáng",
    ["Auto Gift Alert"]                   = "Báo Quà Tự Động",
    ["Rebirth Alert"]                     = "Báo Chuyển Sinh (Rebirth)",
    ["Disconnect Alert"]                  = "Báo Khi Bị Mất Kết Nối",
    ["Alert Filters"]                     = "Bộ Lọc Cảnh Báo",
    ["Min Rarity for Alerts"]             = "Độ Hiếm Tối Thiểu Để Báo",
    ["Any"]                               = "Bất Kỳ",
    ["Manual Actions"]                    = "Thao Tác Thủ Công",
    ["Send Summary Now"]                  = "Gửi Báo Cáo Tổng Hợp Ngay",
    ["Test Webhook"]                      = "Kiểm Tra Gửi Webhook",
    ["Send Inventory Report"]             = "Gửi Báo Cáo Túi Đồ",
    ["Send Equipped Report"]              = "Gửi Báo Cáo Trang Bị",

    -- Thanh thông báo & Chat dưới màn hình
    ["Window Minimized - Click bubble to restore"] = "Menu đã thu nhỏ - Bấm bong bóng để mở lại",
    ["Let's Chat!"]                       = "Trò Chuyện!",
    ["Global Chat"]                       = "Chat Thế Giới",
    ["All Users"]                         = "Tất Cả Người Dùng",
    ["Connecting to Global Script Chat..."] = "Đang kết nối vào kênh chat của Script...",
    ["Send"]                              = "Gửi",
    ["Live"]                              = "Trực Tiếp",
    ["Scroll Down"]                       = "Cuộn Xuống",
    ["Scroll Up"]                         = "Cuộn Lên",
    ["Spoof anti cheat success!"]         = "Đã vượt qua Anti-Cheat thành công!",
    ["Steal an Egg loaded."]              = "Đã nạp xong game Steal an Egg.",
    ["Fetching..."]                       = "Đang Tải Dữ Liệu...",
    ["Loaded"]                            = "Đã Nạp Xong"
}

local DYNAMIC_PATTERNS = {
    {
        pattern = "^Rotation in: (.+)$",
        format  = function(timeStr) return "Đổi mới sau: " .. timeStr end
    },
    {
        pattern = "^Next Boss in: (.+)$",
        format  = function(timeStr) return "Boss tiếp theo sau: " .. timeStr end
    },
    {
        pattern = "^Scanned (%d+) pets %- none are (.+)$",
        format  = function(count, desc) return "Đã quét " .. count .. " thú - chưa có " .. desc end
    },
    {
        pattern = "^(%d+) Eggs %((.-)%) • (%d+) Pets$",
        format  = function(eCount, val, pCount) return eCount .. " Trứng (" .. val .. ") • " .. pCount .. " Thú" end
    },
    {
        pattern = "^Page (%d+) %/ (%d+) %((%d+) Solo%)$",
        format  = function(cur, max, count) return "Trang " .. cur .. "/" .. max .. " (" .. count .. " Phòng Đơn)" end
    },
    {
        pattern = "^Hop Now %((.-)%)$",
        format  = function(state) return "Đổi Server Ngay (" .. (state == "Emptiest Server" and "Server Trống Nhất" or state) .. ")" end
    },
    {
        pattern = "^Kirim pesan ke user script %((.-)%)%.%.%.$",
        format  = function(lang) return "Gửi tin nhắn đến người dùng (" .. lang .. ")..." end
    }
}

local SortedPhrases = {}
for en, vi in pairs(EXACT_MAP) do
    table.insert(SortedPhrases, {en = en, vi = vi, len = #en})
end
table.sort(SortedPhrases, function(a, b) return a.len > b.len end)

-- ==================== 2. ENGINE DỊCH THUẬT SIÊU NHẸ (CACHE MEMOIZATION) ====================
local function translateText(raw)
    if TranslationCache[raw] then
        return TranslationCache[raw]
    end

    local trimmed = raw:gsub("^%s*(.-)%s*$", "%1")

    -- 1. Tra Hash Map O(1)
    if EXACT_MAP[trimmed] then
        local res = raw:gsub(trimmed, EXACT_MAP[trimmed], 1)
        TranslationCache[raw] = res
        return res
    end

    -- 2. Khớp chuỗi động RegEx
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local m1, m2, m3 = trimmed:match(item.pattern)
        if m1 then
            local res = item.format(m1, m2, m3)
            TranslationCache[raw] = res
            return res
        end
    end

    -- 3. Khớp cụm từ dài nhất
    local result = raw
    local matched = false
    for _, item in ipairs(SortedPhrases) do
        if result:find(item.en, 1, true) then
            result = result:gsub(item.en, item.vi)
            matched = true
        end
    end

    TranslationCache[raw] = matched and result or raw
    return TranslationCache[raw]
end

local ActiveElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("Ronnei_LangToggle_Slate") then return end

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
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(ActiveElements, inst)
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
    for i = #ActiveElements, 1, -1 do
        local inst = ActiveElements[i]
        if inst and inst.Parent then
            applyTranslation(inst)
        else
            table.remove(ActiveElements, i)
        end
    end
end

-- ==================== 3. NÚT ĐỔI NGÔN NGỮ (FROSTED SLATE MINIMAL) ====================
local function createLangToggleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Ronnei_LangToggle_Slate")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Ronnei_LangToggle_Slate"
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
    Stroke.Color = Color3.fromRGB(45, 55, 75)
    Stroke.Thickness = 1.0

    local Icon = Instance.new("TextLabel", Container)
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌐"
    Icon.TextSize = 12
    Icon.TextColor3 = Color3.fromRGB(140, 160, 190)

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -36, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Tiếng Việt"
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(130, 200, 160)
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
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(170, 185, 205)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 55, 75)}):Play()
        else
            currentLanguage = "VI"
            Label.Text = "Tiếng Việt"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 200, 160)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 85, 70)}):Play()
        end
        updateAllActive()
    end)
end

-- ==================== 4. KHỞI CHẠY KHÔNG LAG (EVENT-DRIVEN) ====================
task.spawn(function()
    createLangToggleUI()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    -- 1. Bắt sự kiện xuất hiện tức thì (0% CPU khi đứng yên)
    for _, root in ipairs(searchRoots) do
        if root then
            for _, desc in ipairs(root:GetDescendants()) do
                if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                    hookElement(desc)
                end
            end
            root.DescendantAdded:Connect(function(desc)
                if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                    hookElement(desc)
                end
            end)
        end
    end

    -- 2. Quét bù nhẹ nhàng mỗi 2 giây (Chỉ xử lý khi có tab ẩn vừa hiển thị)
    while true do
        task.wait(2.0)
        for _, root in ipairs(searchRoots) do
            if root then
                for _, desc in ipairs(root:GetDescendants()) do
                    if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and not desc:GetAttribute("HasTranslateHook") then
                        hookElement(desc)
                    end
                end
            end
        end
    end
end)

-- ==================== 5. NẠP SCRIPT GỐC NASI ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/robvxs24/freemium/refs/heads/main/nasi.lua"))()
    end)
end)
