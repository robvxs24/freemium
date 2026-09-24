-- ==============================================================================
--  LENNON HUB KAITUN - PURE O(1) TRANSLATION ENGINE V1.2 (LUARMOR SAFE)
--  Tối ưu hóa:
--    1. Nạp đúng luồng script gốc Lennon Hub (Luarmor Loader).
--    2. Cấu trúc Pure O(1) Hash Map: Loại bỏ vòng lặp chuỗi, tốc độ xử lý tức thời.
--    3. Bảo vệ Tên Pet: Chỉ dịch chính xác 100% các từ khóa Rarity (Secret, Cosmic...), không dịch nhầm vào tên Pet.
--    4. Luarmor Bypass: Thêm bộ đệm (Debounce) chống Crash do vòng lặp Text động.
--    5. Nút bấm Frosted Slate Top-Center (Y=15).
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP LUARMOR SCRIPT GỐC (ƯU TIÊN SỐ 1) ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/4595fe31a5f7a8b4f4dd7071f3119ef7.lua"))()
    end)
end)

-- ==================== 2. PURE O(1) DICTIONARIES ====================
local currentLanguage = "VI"
local translationLock = false
local FastCache = {}

local MAP_VI = {
    -- Các Tab & Nút cơ bản
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "CÀY CUỐC (KAITUN)",
    ["DR. SCRAMBLE"] = "SỰ KIỆN DR. SCRAMBLE",
    ["WEBHOOK"] = "CÀI ĐẶT WEBHOOK",
    ["BEST EGG"] = "TRỨNG TỐT NHẤT",
    ["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP",
    ["ONE SHOT"] = "MỘT LẦN",
    ["LOOP"] = "LẶP LẠI",
    ["IDLE"] = "ĐANG CHỜ LỆNH",
    ["Auto steal running automations on hold"] = "Đang tự động cướp, các tính năng khác tạm dừng",
    ["START"] = "BẮT ĐẦU",
    ["STOP"] = "DỪNG LẠI",
    
    -- Chức năng Kaitun
    ["Auto Treadmill"] = "Tự Động Chạy Máy Tập",
    ["Auto Hatch Eggs"] = "Tự Động Ấp Trứng",
    ["Anti-AFK"] = "Chống Treo Máy (AFK)",
    ["Auto Place Eggs"] = "Tự Đặt Trứng Vào Chuồng",
    ["Offline Earnings"] = "Nhận Tiền Offline",
    ["Anti-Trap"] = "Chống Dính Bẫy",
    
    -- Chức năng Dr Scramble
    ["Auto Hunt Drones"] = "Tự Động Săn Drone",
    ["Auto Open Vault"] = "Tự Động Mở Hầm",
    ["Secret Cave"] = "Hang Động Bí Ẩn",
    ["Auto Lost Parts"] = "Tự Nhặt Phụ Tùng",
    ["Auto Buy Shop"] = "Tự Động Mua Cửa Hàng",
    
    -- Chức năng Webhook
    ["DISCORD WEBHOOK URL"] = "ĐƯỜNG DẪN WEBHOOK DISCORD",
    ["Send Steals"] = "Báo Cáo Cướp Trứng",
    ["Test Webhook"] = "Kiểm Tra Webhook",
    ["No steals logged yet"] = "Chưa có lượt cướp nào được ghi lại",
    
    -- Lọc Độ Hiếm (Chỉ khớp 100%)
    ["RARITY FILTER"] = "BỘ LỌC ĐỘ HIẾM",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Cosmic"] = "Vũ Trụ (Cosmic)"
}

local MAP_PH = {
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "KAITUN (AUTO-FARM)",
    ["DR. SCRAMBLE"] = "EVENT NI DR. SCRAMBLE",
    ["WEBHOOK"] = "WEBHOOK SETTINGS",
    ["BEST EGG"] = "PINAKAMAGANDANG ITLOG",
    ["AUTO STEAL"] = "AUTO NAKAW",
    ["ONE SHOT"] = "ISANG BESES",
    ["LOOP"] = "PAULIT-ULIT",
    ["IDLE"] = "BAKANTE",
    ["Auto steal running automations on hold"] = "Umaandar ang auto nakaw, naka-pause ang iba",
    ["START"] = "SIMULAN",
    ["STOP"] = "IHINTO",
    ["Auto Treadmill"] = "Auto Treadmill",
    ["Auto Hatch Eggs"] = "Auto Pusa ng Itlog",
    ["Anti-AFK"] = "Laban sa AFK",
    ["Auto Place Eggs"] = "Auto Lagay ng Itlog",
    ["Offline Earnings"] = "Kita Offline",
    ["Anti-Trap"] = "Laban sa Bitag",
    ["Auto Hunt Drones"] = "Auto Hunt Drones",
    ["Auto Open Vault"] = "Auto Bukas ng Vault",
    ["Secret Cave"] = "Sikretong Kuweba",
    ["Auto Lost Parts"] = "Auto Kolekta ng Nawawalang Parts",
    ["Auto Buy Shop"] = "Auto Bili sa Shop",
    ["DISCORD WEBHOOK URL"] = "DISCORD WEBHOOK URL",
    ["Send Steals"] = "Ipadala ang mga Nakaw",
    ["Test Webhook"] = "I-test ang Webhook",
    ["No steals logged yet"] = "Wala pang nakaw na naitala",
    ["RARITY FILTER"] = "FILTER NG RARITY",
    ["Secret"] = "Secret",
    ["Eternal"] = "Eternal",
    ["Divine"] = "Divine",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic"
}

local MAP_ID = {
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "FARMING OTOMATIS",
    ["DR. SCRAMBLE"] = "EVENT DR. SCRAMBLE",
    ["WEBHOOK"] = "PENGATURAN WEBHOOK",
    ["BEST EGG"] = "TELUR TERBAIK",
    ["AUTO STEAL"] = "AUTO CURI",
    ["ONE SHOT"] = "SEKALI SAJA",
    ["LOOP"] = "TERUS MENERUS",
    ["IDLE"] = "DIAM",
    ["Auto steal running automations on hold"] = "Auto curi jalan, otomatisasi lain ditahan",
    ["START"] = "MULAI",
    ["STOP"] = "BERHENTI",
    ["Auto Treadmill"] = "Auto Treadmill",
    ["Auto Hatch Eggs"] = "Auto Tetas Telur",
    ["Anti-AFK"] = "Anti AFK",
    ["Auto Place Eggs"] = "Auto Taruh Telur",
    ["Offline Earnings"] = "Penghasilan Offline",
    ["Anti-Trap"] = "Anti Perangkap",
    ["Auto Hunt Drones"] = "Auto Hunt Drone",
    ["Auto Open Vault"] = "Auto Buka Brankas",
    ["Secret Cave"] = "Gua Rahasia",
    ["Auto Lost Parts"] = "Auto Ambil Suku Cadang",
    ["Auto Buy Shop"] = "Auto Beli di Toko",
    ["DISCORD WEBHOOK URL"] = "URL WEBHOOK DISCORD",
    ["Send Steals"] = "Kirim Info Curi",
    ["Test Webhook"] = "Tes Webhook",
    ["No steals logged yet"] = "Belum ada curian tercatat",
    ["RARITY FILTER"] = "FILTER RARITY",
    ["Secret"] = "Secret",
    ["Eternal"] = "Eternal",
    ["Divine"] = "Divine",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic"
}

-- Mẫu Regex cho các bộ đếm thời gian động
local DYNAMIC_PATTERNS = {
    {
        pattern = "^IDLE / (%d+:%d+)$",
        format  = function(lang, timeStr) 
            if lang == "VI" then return "ĐANG CHỜ LỆNH / " .. timeStr 
            elseif lang == "PH" then return "BAKANTE / " .. timeStr 
            elseif lang == "ID" then return "DIAM / " .. timeStr 
            end return "IDLE / " .. timeStr 
        end
    }
}

-- ==================== 3. CỖ MÁY DỊCH PURE O(1) ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    -- Xóa khoảng trắng thừa ở 2 đầu
    local trimmed = raw:gsub("^%s*(.-)%s*$", "%1")
    
    -- Chọn bảng từ điển
    local map = MAP_VI
    if currentLanguage == "PH" then map = MAP_PH
    elseif currentLanguage == "ID" then map = MAP_ID
    elseif currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
    end

    -- 1. ƯU TIÊN 1: Khớp chính xác 100% (O(1) Hash Map Lookup)
    -- Không dùng vòng lặp, nếu có từ khóa trong Map thì thay ngay lập tức
    if map[trimmed] then
        -- Giữ nguyên khoảng trắng gốc của UI (nếu có) bằng cách dùng chuỗi thay thế
        local startIdx, endIdx = raw:find(trimmed, 1, true)
        if startIdx then
            local res = raw:sub(1, startIdx - 1) .. map[trimmed] .. raw:sub(endIdx + 1)
            FastCache[cacheKey] = res
            return res
        end
    end

    -- 2. ƯU TIÊN 2: Khớp Regex cho đồng hồ đếm ngược (Chạy cực nhẹ vì mảng rất nhỏ)
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            local res = item.format(currentLanguage, unpack(matches))
            FastCache[cacheKey] = res
            return res
        end
    end

    -- Nếu không có trong từ điển thì lưu nguyên gốc để lần sau không phải check lại
    FastCache[cacheKey] = raw
    return raw
end

local TrackedElements = {}
local DebounceTracker = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_LangToggle_Slate") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        translationLock = true
        inst.Text = mappedText
        translationLock = false
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(TrackedElements, inst)
    
    task.defer(function() applyTranslation(inst) end)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if not translationLock then
            -- Chống Crash do Luarmor re-render vòng lặp
            if DebounceTracker[inst] and tick() - DebounceTracker[inst] < 0.1 then return end
            DebounceTracker[inst] = tick()

            local current = inst.Text
            local isKnown = false
            
            -- Kiểm tra xem Text hiện tại có phải là bản dịch không
            local map = MAP_VI
            if currentLanguage == "PH" then map = MAP_PH
            elseif currentLanguage == "ID" then map = MAP_ID end
            
            if currentLanguage ~= "EN" then
                -- Kiểm tra O(1) ngược (Reverse lookup) bằng cách quét value, chỉ quét 1 lần khi có text mới
                for _, translated in pairs(map) do
                    if current:find(translated, 1, true) then
                        isKnown = true
                        break
                    end
                end
                
                -- Check regex
                if not isKnown then
                    for _, item in ipairs(DYNAMIC_PATTERNS) do
                        local trimmed = current:gsub("^%s*(.-)%s*$", "%1")
                        local matches = {trimmed:match(item.pattern)}
                        if #matches > 0 then
                            -- Nếu cấu trúc giống định dạng sau khi dịch, coi như known
                            isKnown = true 
                            break
                        end
                    end
                end
            else
                isKnown = (current == inst:GetAttribute("OriginalRawText"))
            end

            -- Nếu Text mới hoàn toàn từ game (VD: Tên Pet mới, thời gian mới) -> Cập nhật Original
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

-- ==================== 4. NÚT ĐỔI NGÔN NGỮ ====================
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
    Container.Size = UDim2.new(0, 136, 0, 28)
    Container.AnchorPoint = Vector2.new(0.5, 0)
    Container.Position = UDim2.new(0.5, 0, 0, 15)
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
    Icon.Text = "🌐"
    Icon.TextSize = 14

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
            currentLanguage = "ID"
            Label.Text = "Indonesia"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 220, 240)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 140, 160)}):Play()
        elseif currentLanguage == "ID" then
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

-- ==================== 5. BỘ QUÉT DEFER (CHỐNG PHÁT HIỆN BỞI LUARMOR) ====================
task.delay(4.5, function()
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
