-- Codium Hub (Steal an Egg) | Universal Vietnamese Translation Daemon (Optimized)
local CODIUM_LOADER = 'loadstring(game:HttpGet("https://getcodium.xyz/loader.luau"))()'
local IS_TRANSLATING = true

-- Khởi chạy Codium Hub gốc trong luồng riêng
task.spawn(function()
    pcall(function() loadstring(game:HttpGet("https://getcodium.xyz/loader.luau"))() end)
end)

local FastCache = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

-- TỪ ĐIỂN DỊCH THUẬT MỞ RỘNG (Dựa trên hình ảnh cung cấp và các cụm từ phổ biến trong Steal an Egg)
local EXACT_VI = {
    -- Codium Sidebar & Header
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
    ["Keyless"] = "Không cần Key",
    ["Default"] = "Mặc định",
    ["Anime"] = "Chế độ Anime",
    
    -- Home Tab (Stats & Inventory)
    ["Player Stats"] = "Thống Kê Người Chơi",
    ["Money"] = "Tiền",
    ["Gems"] = "Đá Quý",
    ["Pets"] = "Thú Cưng",
    ["Equipped"] = "Đã Trang Bị",
    ["Eggs"] = "Trứng",
    ["Placed"] = "Đã Đặt",
    ["Value"] = "Giá Trị",
    ["Gain"] = "Thu Nhập",
    ["Inventory"] = "Túi Đồ",
    ["Map"] = "Bản Đồ",
    ["Rarity"] = "Độ Hiếm",
    ["World"] = "Thế Giới",
    
    -- Egg Tab (Cướp Trứng & Bộ Lọc)
    ["Steal Egg"] = "Cướp Trứng",
    ["Filtering"] = "Bộ Lọc (Filtering)",
    ["Strict Filter"] = "Lọc Nghiêm Ngặt",
    ["Only target eggs that match every filter you set."] = "Chỉ nhắm mục tiêu trứng khớp với mọi bộ lọc bạn đã cài.",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Select Area"] = "Chọn Khu Vực",
    ["Select Rarity"] = "Chọn Độ Hiếm",
    ["Select Pet"] = "Chọn Thú Cưng",
    ["Select Mutation"] = "Chọn Đột Biến",
    ["Min Value"] = "Giá Trị Tối Thiểu",
    ["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."] = "Nhắm mục tiêu trứng kiếm được ít nhất mức này mỗi giây (bao gồm cả đột biến). Nhập 0 hoặc để trống để tắt.",
    ["e.g. 500k, 1.5m"] = "VD: 500k, 1.5m",
    ["None"] = "Không có",
    
    -- Indexing & Steal Settings
    ["Indexing"] = "Chỉ Mục (Index)",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Chỉ Mục",
    ["Redeems unlocked index rewards."] = "Nhận các phần thưởng chỉ mục đã mở khóa.",
    ["Auto Indexing"] = "Tự Động Điền Chỉ Mục",
    ["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."] = "Tự Động Cướp chỉ nhắm vào trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",
    ["Steal Settings"] = "Cài Đặt Cướp",
    ["Steal Mode"] = "Chế Độ Cướp",
    ["Normal flies to the egg. Instant Steal works in every area."] = "Bình thường sẽ bay tới trứng. Cướp Tức Thì hoạt động ở mọi khu vực.",
    ["Delivery Mode"] = "Chế Độ Mang Trứng Về",
    ["Recommended Delivery Mode: Speed Match or Steady"] = "Chế độ khuyên dùng: Tốc Độ Khớp (Speed Match) hoặc Ổn Định (Steady)",
    ["Steal From Player"] = "Cướp Từ Người Chơi",
    ["Steals eggs from other players."] = "Cướp trứng từ người chơi khác.",
    ["Server Hop (No Target)"] = "Đổi Server (Không Có Mục Tiêu)",
    ["Hops server when no target is found."] = "Tự động đổi máy chủ khi không tìm thấy mục tiêu.",
    ["Drop for Friend"] = "Thả Trứng Cho Bạn Bè",
    ["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."] = "Thả trứng tại điểm tập kết cho bạn bè nhặt, sau đó đi tìm trứng khác.",
    ["Tự động cướp"] = "Tự Động Cướp",
    ["Flies to field eggs, grabs them and brings them home."] = "Bay tới trứng ngoài bãi, nhặt và mang về nhà.",
    ["Steal Other Script"] = "Cướp Từ Script Khác",
    ["Grabs eggs other players drop near safezone."] = "Nhặt trứng mà người chơi khác (dùng script) làm rớt gần vùng an toàn.",
    
    -- Extra Steal Features
    ["Steal Status"] = "Trạng Thái Cướp",
    ["Shows the Auto Steal status panel."] = "Hiển thị bảng trạng thái Tự Động Cướp.",
    ["Open Steal Panel"] = "Mở Bảng Cướp",
    ["Find and steal World and Halloween eggs by hand."] = "Tìm và cướp trứng Thế Giới / Halloween bằng tay.",
    ["Open Steal History"] = "Mở Lịch Sử Cướp",
    ["Open the last 10 steal results in a separate window."] = "Mở lịch sử 10 lần cướp gần nhất ở một cửa sổ riêng.",
    ["Egg Utilities"] = "Tiện Ích Trứng",
    ["Open Egg Predictor"] = "Mở Dự Đoán Trứng",
    ["Open standalone egg cycle predictor window."] = "Mở cửa sổ dự đoán chu kỳ ấp trứng độc lập.",
    ["Egg Inventory Value"] = "Giá Trị Trứng Trong Túi",
    ["Show generation rate (/s) and sell price on backpack egg slots."] = "Hiển thị tốc độ tạo tiền (/s) và giá bán trên các ô trứng trong ba lô.",
    ["Place Egg"] = "Đặt Trứng",
    ["Hatch Egg"] = "Ấp Trứng",
    
    -- Sell Egg Tab
    ["Sell Egg"] = "Bán Trứng",
    ["Whitelist"] = "Danh Sách Trắng (Giữ Lại)",
    ["Whitelist Rarity"] = "Giữ Lại Theo Độ Hiếm",
    ["Sell eggs matching selected rarities."] = "Bán các trứng KHÔNG khớp với độ hiếm này (chỉ giữ lại độ hiếm đã chọn).",
    ["Whitelist Pet"] = "Giữ Lại Theo Thú Cưng",
    ["Sell eggs that will match selected pets."] = "Bán các trứng KHÔNG nở ra thú cưng này (chỉ giữ lại thú cưng đã chọn).",
    ["Whitelist Mutation"] = "Giữ Lại Theo Đột Biến",
    ["Sell eggs matching selected mutations."] = "Bán các trứng KHÔNG có đột biến này (chỉ giữ lại đột biến đã chọn).",
    ["Blacklist"] = "Danh Sách Đen (Bán Hết)",
    ["Blacklist Rarity"] = "Bán Theo Độ Hiếm",
    ["Prevent selling eggs with selected rarities."] = "Ngăn không cho bán các trứng có độ hiếm này.",
    ["Blacklist Pet"] = "Bán Theo Thú Cưng",
    ["Prevent selling eggs that will match selected pets."] = "Ngăn không cho bán các trứng sẽ nở ra thú cưng này.",
    ["Blacklist Mutation"] = "Bán Theo Đột Biến",
    ["Prevent selling eggs with selected mutations."] = "Ngăn không cho bán các trứng có đột biến này.",
    ["Keep Above"] = "Giữ Lại Trên Mức",
    ["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."] = "Không bao giờ bán trứng kiếm được trên mức này mỗi giây (VD: 100m). Nhập 0 hoặc để trống để tắt.",
    ["e.g. 100m"] = "VD: 100m",
    ["Auto Sell Eggs"] = "Tự Động Bán Trứng",
    ["Sells eggs that pass your filters. Placed eggs are never sold."] = "Tự động bán trứng lọt qua bộ lọc. Trứng đã đặt trong chuồng không bao giờ bị bán.",
    ["Sell On Inventory Full"] = "Chỉ Bán Khi Đầy Túi",
    ["Only sell when your egg backpack is full."] = "Chỉ thực hiện bán khi ba lô đựng trứng của bạn đã đầy.",
    
    -- Place/Hatch Egg Details
    ["Stop At Rarity"] = "Dừng Lại Ở Độ Hiếm",
    ["Eggs of this rarity or higher won't be placed."] = "Trứng có độ hiếm này hoặc cao hơn sẽ KHÔNG được đặt vào chuồng.",
    ["Eggs of this rarity or higher won't be hatched."] = "Trứng có độ hiếm này hoặc cao hơn sẽ KHÔNG được ấp.",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Places matching eggs from your bag into the pen. Whitelist picks which eggs, blacklist always blocks."] = "Đặt trứng phù hợp từ túi vào chuồng. Danh sách trắng ưu tiên chọn, danh sách đen luôn luôn chặn.",
    ["Auto Place Indexing"] = "Tự Động Đặt Theo Chỉ Mục",
    ["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."] = "Chỉ tự động đặt những trứng bạn chưa có trong chỉ mục. Bỏ qua Danh sách trắng/đen.",
    ["Tự động ấp"] = "Tự Động Ấp",
    ["Automatically hatch ready eggs matching the selected filters."] = "Tự động ấp các trứng đã sẵn sàng khớp với bộ lọc.",
    ["Auto Hatch Indexing"] = "Tự Động Ấp Theo Chỉ Mục",
    ["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."] = "Chỉ tự động ấp những trứng bạn chưa có trong chỉ mục. Bỏ qua Danh sách trắng, Danh sách đen vẫn áp dụng.",
    
    -- Webhook Tab
    ["Webhook"] = "Webhook (Thông Báo Discord)",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Discord webhook URL for sending notifications."] = "Đường dẫn Webhook của Discord để gửi thông báo.",
    ["Ping @everyone"] = "Thông báo @everyone",
    ["Mention @everyone in Discord when a new egg is claimed."] = "Tag @everyone trên Discord khi nhặt được trứng mới.",
    ["Egg Webhook"] = "Thông Báo Trứng",
    ["Select Egg Rarity"] = "Chọn Độ Hiếm Trứng",
    ["Enable New Egg Claimed"] = "Bật Thông Báo Trứng Mới",
    ["Send webhook notification when stealing/claiming a new egg."] = "Gửi thông báo qua Webhook khi cướp/nhận được trứng mới.",
    ["Player Webhook"] = "Thông Báo Người Chơi",
    ["Stats Interval (Min)"] = "Chu Kỳ Cập Nhật (Phút)",
    ["Enable Player Stats"] = "Bật Thống Kê Người Chơi",
    ["Periodically send player stats to Discord."] = "Định kỳ gửi thống kê tài khoản của bạn qua Discord.",
    ["Test Webhook"] = "Thử Nghiệm Webhook",
    ["Send Stats Now"] = "Gửi Thống Kê Ngay",
    ["Immediately send stats to Discord."] = "Gửi ngay lập tức thống kê hiện tại qua Discord.",
    ["Test Egg Webhook"] = "Thử Thông Báo Trứng",
    ["Simulate claiming an egg."] = "Mô phỏng việc nhặt được một quả trứng để kiểm tra.",
    
    -- Event Tab
    ["Admin Abuse Boost (BETA)"] = "Buff Lạm Dụng Admin (BETA)",
    ["Ghost Dog Quest"] = "Nhiệm Vụ Chó Ma",
    ["Abandoned Manor"] = "Dinh Thự Bị Bỏ Hoang",
    ["Pumpkin King"] = "Vua Bí Ngô",
    ["The Hollow"] = "Khu Rừng Trống Rỗng (The Hollow)",
    
    -- Priority & Filters
    ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất",
    ["Closest"] = "Gần nhất",
    ["Nearest"] = "Gần nhất",
    ["Rarest"] = "Hiếm nhất",
    ["Largest"] = "To nhất",
    ["Smallest"] = "Nhỏ nhất",
    ["All"] = "Tất cả",
    
    -- Actions & General
    ["Enable"] = "Bật",
    ["Disable"] = "Tắt",
    ["Auto Steal"] = "Tự động cướp",
    ["Auto Farm"] = "Tự động cày",
    ["Auto Hatch"] = "Tự động ấp",
    ["Auto Place"] = "Tự động đặt",
    ["Auto Mutate"] = "Tự động đột biến",
    ["Auto Fuse"] = "Tự động dung hợp",
    ["Auto Sell"] = "Tự động bán",
    ["Auto Equip"] = "Tự động trang bị",
    ["Auto Treadmill"] = "Tự chạy máy tập",
    ["Teleport"] = "Dịch chuyển",
    ["Walk"] = "Đi bộ",
    ["Tween"] = "Bay (Tween)",
    ["Hit Aura"] = "Vòng đánh tự động",
    ["Anti AFK"] = "Chống văng game",
    ["God Mode"] = "Bất tử",
    ["Infinite Jump"] = "Nhảy vô hạn",
    ["Walk Speed"] = "Tốc độ chạy",
    
    -- Rarities
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
    ["Spectral"] = "Tâm Linh (Spectral)",
    ["Golden"] = "Vàng (Golden)",
    
    -- Locations
    ["Abyss Ocean"] = "Đại Dương Sâu Thẳm",
    ["Prehistoric"] = "Thời Tiền Sử",
    ["Cherry Blossom"] = "Rừng Hoa Anh Đào",
    ["Light Dark"] = "Sáng Tối",
}

-- Chuẩn bị từ điển tra cứu nhanh (Case-insensitive)
local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
    LOWER_VI[k:lower()] = v
end

-- Xử lý cụm từ động (Ví dụ: "Version v4.1", "FPS: 60", Giá trị tiền)
local DYNAMIC_PATTERNS = {
    { pat = "^[Vv](%d+%.%d+)$", rep = "Phiên bản %1" },
    { pat = "^Phiên bản (%d+%.%d+)$", rep = "Phiên bản %1" }, -- Tránh dịch lặp
    { pat = "^([%d%.]+)k$", rep = "%1k" },
    { pat = "^([%d%.]+)m$", rep = "%1m" },
    { pat = "^([%d%.]+)b$", rep = "%1B" },
    { pat = "^([%d%.]+)t$", rep = "%1T" },
    { pat = "^([%d%.]+)qa$", rep = "%1Qa" }
}

local function translateText(raw)
    if not raw or raw == "" then return raw end
    local cacheKey = raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    -- Bỏ qua số thuần túy hoặc URL, giữ nguyên các thông số Stats ($3.9Qa, v.v.)
    if raw:match("^[%d%.%,%-%+]+$") or raw:find("discord.gg") or raw:find("https://") then
        FastCache[cacheKey] = raw
        return raw
    end

    local norm = (raw:match("^%s*(.-)%s*$") or raw):gsub("%s+", " ")
    
    -- Khớp chính xác (Có phân biệt hoa thường)
    if EXACT_VI[norm] then
        FastCache[cacheKey] = EXACT_VI[norm]
        return EXACT_VI[norm]
    end
    
    -- Khớp không phân biệt hoa thường
    local normLower = norm:lower()
    if LOWER_VI[normLower] then
        -- Giữ nguyên định dạng in hoa nếu từ gốc viết hoa toàn bộ
        if norm:upper() == norm and norm:match("%a") then
            FastCache[cacheKey] = LOWER_VI[normLower]:upper()
            return FastCache[cacheKey]
        end
        FastCache[cacheKey] = LOWER_VI[normLower]
        return LOWER_VI[normLower]
    end

    -- Khớp mẫu động
    for _, dp in ipairs(DYNAMIC_PATTERNS) do
        if normLower:find(dp.pat) then
            local res = normLower:gsub(dp.pat, dp.rep)
            -- Phục hồi case nếu cần
            if norm:upper() == norm and norm:match("%a") then res = res:upper() end
            FastCache[cacheKey] = res
            return res
        end
    end

    -- Nếu không dịch được, lưu vào cache để tránh quét lại
    FastCache[cacheKey] = raw
    return raw
end

-- Hàm áp dụng dịch lên một thành phần UI
local function applyTranslation(inst)
    if not IS_TRANSLATING then return end
    if not inst or not inst.Parent then return end
    
    -- Bỏ qua nếu đang trong quá trình dịch để tránh lặp vô hạn
    if inst:GetAttribute("__Translating") then return end

    if inst:IsA("TextLabel") or inst:IsA("TextButton") then
        local rawText = inst.Text
        if not rawText or rawText == "" then return end
        
        local orig = inst:GetAttribute("OrigText")
        if not orig then
            -- Bỏ qua nếu text đã có ký tự Tiếng Việt (chứng tỏ đã dịch hoặc có sẵn)
            if rawText:find("[\194-\244][\128-\191]") and not rawText:find("Phiên bản") then return end
            orig = rawText
            inst:SetAttribute("OrigText", orig)
        end
        
        local translated = translateText(orig)
        if translated and inst.Text ~= translated then
            inst:SetAttribute("__Translating", true)
            pcall(function() inst.Text = translated end)
            inst:SetAttribute("__Translating", false)
        end

    elseif inst:IsA("TextBox") then
        local rawPh = inst.PlaceholderText
        if rawPh and rawPh ~= "" then
            local origPh = inst:GetAttribute("OrigPhText")
            if not origPh then
                if rawPh:find("[\194-\244][\128-\191]") then return end
                origPh = rawPh
                inst:SetAttribute("OrigPhText", origPh)
            end
            
            local translatedPh = translateText(origPh)
            if translatedPh and inst.PlaceholderText ~= translatedPh then
                inst:SetAttribute("__Translating", true)
                pcall(function() inst.PlaceholderText = translatedPh end)
                inst:SetAttribute("__Translating", false)
            end
        end
    end
end

-- Bộ quét và hook sự kiện thay đổi Text
local function hookUIElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__TransHooked") then return end
    
    inst:SetAttribute("__TransHooked", true)
    applyTranslation(inst)
    
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:IsA("TextBox") then return end -- TextBox thường người dùng tự nhập
        if not inst:GetAttribute("__Translating") then
            -- Throttling để tránh lag khi text thay đổi quá nhanh (ví dụ: bộ đếm số lượng)
            local now = os.clock()
            local lastUpdate = inst:GetAttribute("__LastTextUpdate") or 0
            if now - lastUpdate > 0.05 then
                inst:SetAttribute("__LastTextUpdate", now)
                local newText = inst.Text
                if newText and not newText:find("[\194-\244][\128-\191]") then
                    inst:SetAttribute("OrigText", newText)
                    applyTranslation(inst)
                end
            end
        end
    end)
end

-- Tối ưu hoá quá trình quét: Giảm số lần quét toàn bộ DOM, chỉ phụ thuộc vào DescendantAdded
local function getScanRoots()
    local roots = {}
    if gethui then pcall(function() table.insert(roots, gethui()) end) end
    table.insert(roots, game:GetService("CoreGui"))
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then table.insert(roots, pg) end
    return roots
end

-- Quét toàn bộ một lần lúc khởi động
task.spawn(function()
    task.wait(1.5) -- Đợi UI Codium khởi tạo xong cơ bản
    for _, root in ipairs(getScanRoots()) do
        for _, gui in ipairs(root:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "RobloxGui" and gui.Name ~= "TopBarApp" and gui.Name ~= "CoreScriptsRootProvider" then
                -- Tránh đụng chạm vào Background Image để không gây lag
                for _, desc in ipairs(gui:GetDescendants()) do
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        hookUIElement(desc)
                    end
                end
            end
        end
    end
end)

-- Lắng nghe sự kiện thêm mới thay vì dùng while loop quét toàn bộ cây DOM liên tục
for _, root in ipairs(getScanRoots()) do
    root.DescendantAdded:Connect(function(desc)
        -- Sử dụng task.defer để không cản trở quá trình render của game
        task.defer(function()
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookUIElement(desc)
            end
        end)
    end)
end
