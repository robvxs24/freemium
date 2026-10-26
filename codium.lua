-- Codium Hub (Steal an Egg) | Universal Vietnamese Translation Daemon
local CODIUM_LOADER = 'loadstring(game:HttpGet("https://getcodium.xyz/loader.luau"))()'
local IS_TRANSLATING = true

-- Khởi chạy Codium Hub gốc trong luồng riêng
task.spawn(function()
    pcall(function() loadstring(game:HttpGet("https://getcodium.xyz/loader.luau"))() end)
end)

local FastCache = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

-- TỪ ĐIỂN DỊCH THUẬT (Bao phủ toàn bộ UI của Codium & Steal An Egg)
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
    
    -- Events
    ["Halloween"] = "Halloween",
    ["Pumpkin"] = "Bí Ngô",
    ["Ghost"] = "Bóng Ma",
    ["Monster"] = "Quái vật",
    ["Phantom Express"] = "Tàu Bóng Ma",
    ["Cursed Island"] = "Đảo Nguyền Rủa",
    ["Shooting Star"] = "Sao Băng",
    ["Butterfly"] = "Bắt Bướm",
    ["Race"] = "Đua Xe",
    
    -- ESP & Visuals
    ["ESP"] = "Định vị (ESP)",
    ["Player ESP"] = "ESP Người chơi",
    ["Egg ESP"] = "ESP Trứng",
    ["Guard ESP"] = "ESP Vệ sĩ",
    
    -- Save/Load
    ["Save"] = "Lưu",
    ["Load"] = "Nạp",
    ["Create"] = "Tạo mới",
    ["Delete"] = "Xóa",
    ["Refresh"] = "Làm mới"
}

-- Chuẩn bị từ điển tra cứu nhanh (Case-insensitive)
local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
    LOWER_VI[k:lower()] = v
end

-- Xử lý cụm từ động (Ví dụ: "Version v4.1", "FPS: 60")
local DYNAMIC_PATTERNS = {
    { pat = "^v(%d+%.%d+)$", rep = "Phiên bản %1" },
    { pat = "^([%d%.]+)k$", rep = "%1k" },
    { pat = "^([%d%.]+)m$", rep = "%1m" }
}

local function translateText(raw)
    if not raw or raw == "" then return raw end
    local cacheKey = raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    -- Bỏ qua số thuần túy hoặc URL
    if raw:match("^[%d%.%,%-%+]+$") or raw:find("discord.gg") then
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
        if norm:find(dp.pat) then
            local res = norm:gsub(dp.pat, dp.rep)
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
            -- Nếu có ký tự Tiếng Việt rồi thì bỏ qua (đã dịch)
            if rawText:find("[\194-\244][\128-\191]") then return end
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
            -- Nếu text bị cập nhật bởi Hub (vd: trạng thái thay đổi), cập nhật lại OrigText
            local newText = inst.Text
            if newText and not newText:find("[\194-\244][\128-\191]") then
                inst:SetAttribute("OrigText", newText)
                applyTranslation(inst)
            end
        end
    end)
end

-- Quét định kỳ để bắt toàn bộ UI của Codium sinh ra (Kể cả trong gethui(), CoreGui, PlayerGui)
local function getScanRoots()
    local roots = {}
    if gethui then pcall(function() table.insert(roots, gethui()) end) end
    table.insert(roots, game:GetService("CoreGui"))
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then table.insert(roots, pg) end
    return roots
end

-- Luồng quét liên tục (Codium thường ẩn UI khá kỹ hoặc sinh ra từ từ)
task.spawn(function()
    while task.wait(0.5) do
        for _, root in ipairs(getScanRoots()) do
            -- Tìm kiếm các ScreenGui không phải mặc định của Roblox
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "RobloxGui" and gui.Name ~= "TopBarApp" and gui.Name ~= "CoreScriptsRootProvider" then
                    for _, desc in ipairs(gui:GetDescendants()) do
                        hookUIElement(desc)
                    end
                end
            end
        end
    end
end)

-- Lắng nghe sự kiện thêm mới để dịch tức thời ngay khi nút vừa xuất hiện
for _, root in ipairs(getScanRoots()) do
    root.DescendantAdded:Connect(function(desc)
        task.defer(function()
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookUIElement(desc)
            end
        end)
    end)
end
