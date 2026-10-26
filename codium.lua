-- ==========================================
-- Codium Hub - Bộ Dịch Tiếng Việt (Translation Daemon)
-- ==========================================

-- 1. Khởi chạy Codium Hub gốc
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://getcodium.xyz/loader.luau"))()
    end)
end)

-- 2. Bộ từ điển dịch thuật (Dựa trên UI của Codium Hub)
local DICTIONARY = {
    -- Menu chính / Sidebar[cite: 30, 32, 40]
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
    ["Keyless"] = "Không cần Key",
    ["Default"] = "Mặc định",
    ["Anime"] = "Chế độ Anime",
    ["Search..."] = "Tìm kiếm...",
    ["Search"] = "Tìm kiếm",

    -- Tab Egg: Lọc & Cướp[cite: 30, 31]
    ["Steal Egg"] = "Cướp Trứng",
    ["Filtering"] = "Bộ Lọc",
    ["Strict Filter"] = "Lọc Nghiêm Ngặt",
    ["Only target eggs that match every filter you set."] = "Chỉ cướp trứng khớp với mọi bộ lọc bạn đã cài.",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Select Area"] = "Chọn Khu Vực",
    ["Select Rarity"] = "Chọn Độ Hiếm",
    ["Select Pet"] = "Chọn Thú Cưng",
    ["Select Mutation"] = "Chọn Đột Biến",
    ["Min Value"] = "Giá Trị Tối Thiểu",
    ["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."] = "Chỉ cướp trứng kiếm được ít nhất mức này mỗi giây (VD: 500k, 1.5m). Nhập 0 để tắt.",
    
    ["Indexing"] = "Chỉ Mục (Index)",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Chỉ Mục",
    ["Redeems unlocked index rewards."] = "Tự động nhận phần thưởng từ danh mục đã mở khóa.",
    ["Auto Indexing"] = "Tự Động Thu Thập Chỉ Mục",
    ["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."] = "Chỉ cướp các trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",
    
    ["Steal Settings"] = "Cài Đặt Cướp",
    ["Steal Mode"] = "Chế Độ Cướp",
    ["Normal flies to the egg, Instant Steal works in every area."] = "Bình thường sẽ bay tới trứng. Cướp Tức Thì hoạt động ở mọi khu vực.",
    ["Instant Steal"] = "Cướp Tức Thì",
    ["Normal"] = "Bình Thường",
    ["Delivery Mode"] = "Chế Độ Giao Trứng",
    ["Recommended Delivery Mode: Speed Match or Steady"] = "Khuyên dùng: Tốc độ khớp hoặc Ổn định",
    ["Steady"] = "Ổn định",
    ["Steal From Player"] = "Cướp Từ Người Chơi",
    ["Steals eggs from other players."] = "Cướp trứng từ tay người chơi khác.",
    ["Server Hop (No Target)"] = "Đổi Server (Khi Hết Mục Tiêu)",
    ["Hops server when no target is found."] = "Tự động đổi máy chủ khi không tìm thấy trứng mục tiêu.",
    ["Drop for Friend"] = "Nhặt Hộ Bạn Bè",
    ["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."] = "Mang trứng đến điểm hẹn, thả xuống cho bạn bè nhặt và đi tìm trứng khác.",
    
    ["Tự động cướp"] = "Tự Động Cướp", -- Từ bản mod cũ có thể còn sót lại
    ["Flies to field eggs, grabs them and brings them home."] = "Bay tới bãi, nhặt trứng và mang về nhà.",
    ["Steal Other Script"] = "Cướp Của Script Khác",
    ["Grabs eggs other players drop near safezone."] = "Nhặt trứng mà các người chơi dùng script khác làm rớt gần vùng an toàn.",
    
    ["Steal Status"] = "Trạng Thái Cướp",
    ["Shows the Auto Steal status panel."] = "Hiển thị bảng trạng thái tự động cướp.",
    ["Open Steal Panel"] = "Mở Bảng Cướp Trứng",
    ["Find and steal World and Halloween eggs by hand."] = "Tìm và cướp trứng Thế Giới / Halloween bằng tay.",
    ["Open Steal History"] = "Mở Lịch Sử Cướp",
    ["Open the last 10 steal results in a separate window."] = "Mở 10 kết quả cướp gần nhất ở cửa sổ riêng.",

    -- Tab Egg: Tiện ích & Đặt trứng[cite: 32, 33, 34]
    ["Egg Utilities"] = "Tiện Ích Trứng",
    ["Open Egg Predictor"] = "Mở Dự Đoán Trứng",
    ["Open standalone egg cycle predictor window."] = "Mở cửa sổ dự đoán chu kỳ trứng riêng biệt.",
    ["Egg Inventory Value"] = "Giá Trị Trứng Trong Túi",
    ["Show generation rate (/s) and sell price on backpack egg slots."] = "Hiển thị tốc độ sinh tiền (/s) và giá bán trên từng ô trứng trong ba lô.",
    ["Place Egg"] = "Đặt Trứng Vào Chuồng",
    ["Hatch Egg"] = "Ấp Trứng",
    ["Stop At Rarity"] = "Dừng Lại Ở Độ Hiếm",
    ["Eggs of this rarity or higher won't be placed."] = "Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi đặt.",
    ["Eggs of this rarity or higher won't be hatched."] = "Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi ấp.",
    
    ["Whitelist"] = "Danh Sách Trắng (Ưu Tiên)",
    ["Blacklist"] = "Danh Sách Đen (Bỏ Qua)",
    ["Whitelist Rarity"] = "Ưu Tiên Độ Hiếm",
    ["Whitelist Pet"] = "Ưu Tiên Thú Cưng",
    ["Whitelist Mutation"] = "Ưu Tiên Đột Biến",
    ["Blacklist Rarity"] = "Bỏ Qua Độ Hiếm",
    ["Blacklist Pet"] = "Bỏ Qua Thú Cưng",
    ["Blacklist Mutation"] = "Bỏ Qua Đột Biến",
    
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Places matching eggs from your bag into the pen. Whitelist picks which eggs, blacklist always blocks."] = "Đặt trứng phù hợp từ túi vào chuồng. Ưu tiên các mục trong Whitelist, luôn chặn mục trong Blacklist.",
    ["Auto Place Indexing"] = "Tự Động Đặt Lấy Chỉ Mục",
    ["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."] = "Chỉ tự động đặt các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist và Blacklist.",
    ["Auto Hatch"] = "Tự Động Ấp",
    ["Automatically hatch ready eggs matching the selected filters."] = "Tự động ấp các trứng đã sẵn sàng và khớp với bộ lọc.",
    ["Auto Hatch Indexing"] = "Tự Động Ấp Lấy Chỉ Mục",
    ["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."] = "Chỉ ấp các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist, vẫn áp dụng Blacklist.",

    -- Tab Egg: Bán[cite: 37]
    ["Sell Egg"] = "Bán Trứng",
    ["Keep Above"] = "Giữ Lại Trên Mức",
    ["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."] = "Không bao giờ bán trứng kiếm được trên mức này mỗi giây (VD: 100m). Nhập 0 để tắt.",
    ["Auto Sell Eggs"] = "Tự Động Bán Trứng",
    ["Sells eggs that pass your filters. Placed eggs are never sold."] = "Bán trứng lọt qua bộ lọc. Trứng đã đặt trong chuồng sẽ không bao giờ bị bán.",
    ["Sell On Inventory Full"] = "Chỉ Bán Khi Đầy Túi",
    ["Only sell when your egg backpack is full."] = "Chỉ kích hoạt bán khi ba lô chứa trứng đã đầy.",

    -- Thống kê & Bản đồ (Tab Trang Chủ)[cite: 35]
    ["Player Stats"] = "Thống Kê Người Chơi",
    ["Money"] = "Tiền",
    ["Gems"] = "Đá Quý",
    ["Pets"] = "Thú Cưng",
    ["Equipped"] = "Đang Tranh Bị",
    ["Eggs"] = "Trứng",
    ["Placed"] = "Đã Đặt",
    ["Value"] = "Giá Trị",
    ["Gain"] = "Tăng Tốc Độ",
    ["Inventory"] = "Túi Đồ",
    ["Map"] = "Bản Đồ",
    ["Rarity"] = "Độ Hiếm",
    ["World"] = "Thế Giới",

    -- Webhook[cite: 36]
    ["Webhook URL"] = "Link Webhook",
    ["Discord webhook URL for sending notifications."] = "Đường dẫn Webhook Discord để gửi thông báo.",
    ["Ping @everyone"] = "Tag @everyone",
    ["Mention @everyone in Discord when a new egg is claimed."] = "Gắn thẻ @everyone trên Discord khi nhận được trứng mới.",
    ["Egg Webhook"] = "Webhook Trứng",
    ["Select Egg Rarity"] = "Chọn Độ Hiếm Của Trứng",
    ["Enable New Egg Claimed"] = "Bật Thông Báo Trứng Mới",
    ["Send webhook notification when stealing/claiming a new egg."] = "Gửi thông báo Webhook khi cướp/nhận được trứng mới.",
    ["Player Webhook"] = "Webhook Người Chơi",
    ["Stats Interval (Min)"] = "Khoảng Thời Gian Báo Thống Kê (Phút)",
    ["Enable Player Stats"] = "Bật Thông Báo Thống Kê",
    ["Periodically send player stats to Discord."] = "Định kỳ gửi thông số người chơi qua Discord.",
    ["Test Webhook"] = "Thử Nghiệm Webhook",
    ["Send Stats Now"] = "Gửi Thống Kê Ngay Lúc Này",
    ["Immediately send stats to Discord."] = "Gửi ngay thông số người chơi vào Discord.",
    ["Test Egg Webhook"] = "Gửi Thử Webhook Trứng",
    ["Simulate claiming an egg."] = "Mô phỏng thao tác nhận trứng để kiểm tra.",

    -- Sự kiện[cite: 40]
    ["Admin Abuse Boost (BETA)"] = "Nhận Buff Quyền Admin (BETA)",
    ["Halloween Dimension"] = "Không Gian Halloween",
    ["Ghost Dog Quest"] = "Nhiệm Vụ Chó Ma",
    ["Abandoned Manor"] = "Dinh Thự Bỏ Hoang",
    ["Pumpkin King"] = "Vua Bí Ngô",
    ["The Hollow"] = "Vực Hollow",

    -- Tên cấp độ/độ hiếm
    ["None"] = "Không có",
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
}

-- Chuẩn bị từ điển dạng chữ thường để so sánh cho chính xác
local CACHE = {}
local LOWER_DICT = {}
for k, v in pairs(DICTIONARY) do
    LOWER_DICT[k:lower()] = v
end

-- Xử lý cụm từ động chứa số (Ví dụ tiền tệ, chỉ số)
local DYNAMIC_PATTERNS = {
    { pat = "^e%.g%. (.+)$", rep = "VD: %1" },
    { pat = "^([%d%.]+)k$", rep = "%1k" },
    { pat = "^([%d%.]+)m$", rep = "%1m" }
}

-- Hàm dịch thuật cốt lõi
local function translateStr(rawStr)
    if not rawStr or rawStr == "" or type(rawStr) ~= "string" then return rawStr end
    
    if CACHE[rawStr] then return CACHE[rawStr] end
    
    -- Bỏ qua các chuỗi chỉ có số hoặc ký tự đặc biệt
    if rawStr:match("^[%d%.%,%-%+%s]+$") or rawStr:find("discord.gg") then
        CACHE[rawStr] = rawStr
        return rawStr
    end
    
    local cleanStr = (rawStr:match("^%s*(.-)%s*$") or rawStr):gsub("%s+", " ")
    local lowerStr = cleanStr:lower()
    
    if LOWER_DICT[lowerStr] then
        local result = LOWER_DICT[lowerStr]
        -- Giữ nguyên định dạng IN HOA toàn bộ nếu bản gốc như vậy
        if cleanStr:upper() == cleanStr and cleanStr:match("%a") then
            result = result:upper()
        end
        CACHE[rawStr] = result
        return result
    end
    
    for _, dp in ipairs(DYNAMIC_PATTERNS) do
        if lowerStr:find(dp.pat) then
            local result = lowerStr:gsub(dp.pat, dp.rep)
            CACHE[rawStr] = result
            return result
        end
    end
    
    CACHE[rawStr] = rawStr
    return rawStr
end

-- Hàm áp dụng dịch vào đối tượng UI
local function applyTranslation(inst)
    if not inst or not inst.Parent or inst:GetAttribute("IsTranslating") then return end
    
    if inst:IsA("TextLabel") or inst:IsA("TextButton") then
        local currentText = inst.Text
        if not currentText or currentText == "" then return end
        
        -- Kiểm tra nếu chuỗi đã có ký tự có dấu (đã dịch) thì bỏ qua
        if currentText:find("[\194-\244][\128-\191]") then return end
        
        local translated = translateStr(currentText)
        if translated and translated ~= currentText then
            inst:SetAttribute("IsTranslating", true)
            pcall(function() inst.Text = translated end)
            inst:SetAttribute("IsTranslating", false)
        end
        
    elseif inst:IsA("TextBox") then
        local currentPh = inst.PlaceholderText
        if currentPh and currentPh ~= "" and not currentPh:find("[\194-\244][\128-\191]") then
            local translatedPh = translateStr(currentPh)
            if translatedPh and translatedPh ~= currentPh then
                inst:SetAttribute("IsTranslating", true)
                pcall(function() inst.PlaceholderText = translatedPh end)
                inst:SetAttribute("IsTranslating", false)
            end
        end
    end
end

-- Hàm bắt sự kiện UI thay đổi
local function hookInstance(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HookedForTranslation") then return end
    
    inst:SetAttribute("HookedForTranslation", true)
    applyTranslation(inst)
    
    -- Bắt sự kiện khi Codium cập nhật nội dung Text
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        applyTranslation(inst)
    end)
end

-- Quét toàn bộ UI hiện tại và gắn hook
local function scanAndHookUI()
    local roots = {}
    if gethui then pcall(function() table.insert(roots, gethui()) end) end
    table.insert(roots, game:GetService("CoreGui"))
    local pg = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then table.insert(roots, pg) end
    
    for _, root in ipairs(roots) do
        for _, gui in ipairs(root:GetChildren()) do
            -- Lọc bỏ các UI cơ bản của Roblox
            if gui:IsA("ScreenGui") and gui.Name ~= "RobloxGui" and gui.Name ~= "TopBarApp" and gui.Name ~= "CoreScriptsRootProvider" then
                -- Lắng nghe các phần tử mới được sinh ra
                if not gui:GetAttribute("DescendantHooked") then
                    gui:SetAttribute("DescendantHooked", true)
                    gui.DescendantAdded:Connect(function(desc)
                        task.defer(hookInstance, desc)
                    end)
                end
                
                -- Quét các phần tử đã có sẵn
                for _, desc in ipairs(gui:GetDescendants()) do
                    hookInstance(desc)
                end
            end
        end
    end
end

-- Vòng lặp kiểm tra định kỳ (xử lý trường hợp UI của Hub render chậm)
task.spawn(function()
    while task.wait(1.5) do
        pcall(scanAndHookUI)
    end
end)
