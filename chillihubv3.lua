-- ==============================================================================
--  CHILLI HUB V2 - PREMIUM EDITION (STABLE AUTO FARM & RAINBOW ISLAND)
--  Cập nhật:
--    1. ỔN ĐỊNH 100%: Lập trình lại thuật toán bấm nút, chờ animation menu hoàn tất trước khi chọn.
--    2. KHUNG CẦU VỒNG CHẠY: Viền Dynamic Island có dải màu cầu vồng chạy qua lại liên tục.
--    3. DỊCH THUẬT TOÀN DIỆN: Ép dịch 100% tiếng Việt không độ trễ.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    task.wait(0.5)
    LocalPlayer = Players.LocalPlayer
end

-- ==================== 1. TÌM VÙNG CHỨA GUI AN TOÀN ====================
local function getSafeContainer()
    local container = nil
    pcall(function() if gethui then container = gethui() end end)
    if not container then pcall(function() if CoreGui and pcall(function() return CoreGui:GetChildren() end) then container = CoreGui end end) end
    if not container and LocalPlayer then container = LocalPlayer:FindFirstChild("PlayerGui") end
    return container
end

-- ==================== 2. NẠP SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))() end)
end)

-- ==================== 3. TỪ ĐIỂN DỊCH THUẬT VÀ REGEX ====================
local currentLanguage = "VI"
local FastCache = {}

local EXACT_MATCH_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Hop"] = "Đổi Server", ["Join"] = "Vào Phòng", ["Copy"] = "Sao Chép", ["Rejoin"] = "Vào Lại",
    ["Add"] = "Thêm", ["Sell"] = "Bán", ["Favorite"] = "Khóa", ["Unfavorite"] = "Mở Khóa", ["RESET"] = "ĐẶT LẠI",
    ["All"] = "Tất cả", ["ALL"] = "TẤT CẢ", ["Any"] = "Tất cả", ["None"] = "Không có", ["Off"] = "Tắt", ["OFF"] = "TẮT",
    ["On"] = "Bật", ["ON"] = "BẬT", ["Idle"] = "Đang chờ", ["IDLE"] = "ĐANG CHỜ", ["Stand"] = "Đứng yên", ["Chase"] = "Đuổi theo",
    ["Circle"] = "Xoay vòng", ["Patrol"] = "Tuần tra", ["Rarest"] = "Hiếm nhất", ["Nearest"] = "Gần nhất", ["Always"] = "Luôn luôn",
    ["Never"] = "Không bao giờ", ["Value"] = "Giá trị", ["Cosmic"] = "Vũ Trụ", ["Divine"] = "Thánh Thần", ["Eternal"] = "Vĩnh Cửu",
    ["Mythic"] = "Thần Thoại", ["Legendary"] = "Huyền Thoại", ["Epic"] = "Sử Thi", ["Rare"] = "Hiếm", ["Uncommon"] = "Thường",
    ["Common"] = "Phổ Thông", ["Secret"] = "Bí Ẩn", ["Least Players"] = "Ít người chơi nhất", ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm", ["Rarity And Value"] = "Độ hiếm & Giá trị", ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước", ["Lowest To Highest"] = "Từ thấp đến cao", ["Highest To Lowest"] = "Từ cao đến thấp",
    ["Match All"] = "Khớp tất cả", ["Match Any"] = "Khớp bất kỳ", ["Highest Value"] = "Giá trị cao nhất", ["Lowest Value"] = "Giá trị thấp nhất"
}

local MAP_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Farm"] = "Cày Cuốc", ["Player"] = "Người Chơi", ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình", ["Server"] = "Máy Chủ", ["Misc"] = "Khác", ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord", ["Quick & Keys"] = "Phím Tắt & Key", ["Settings"] = "Cài Đặt", ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Tìm kiếm tính năng...", ["Search"] = "Tìm kiếm",
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble", ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Auto Steal"] = "Tự Động Cướp Trứng", ["Auto Place Egg"] = "Tự Động Đặt Trứng", ["Auto Treadmill"] = "Tự Động Máy Tập",
    ["Auto Sell"] = "Tự Động Bán", ["Auto Sell Pet"] = "Tự Động Bán Pet", ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab", ["Auto Fuse Machine"] = "Máy Dung Hợp Pet", ["Auto Favorite"] = "Tự Động Khóa Pet",
    ["Priority"] = "Ưu Tiên Nhiệm Vụ", ["Auto Progression"] = "Tự Động Tiến Trình", ["Performance"] = "Hiệu Năng",
    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm", ["Catch Mode"] = "Chế Độ Bắt", ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Catch Butterflies"] = "Chọn Bướm Cần Bắt", ["Radiant Butterfly"] = "Bướm Rực Rỡ", ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím",
    ["Sapphire Butterfly"] = "Bướm Lam Ngọc", ["Emerald Butterfly"] = "Bướm Lục Bảo", ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)", ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc",
    ["Target Areas"] = "Khu Vực Mục Tiêu", ["Min Steal Value"] = "Giá Trị Cướp Min", ["Target Specific Eggs"] = "Chọn Đích Danh Trứng Cần Cướp",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu", ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Steal Priority"] = "Ưu Tiên Cướp", ["Carry Speed"] = "Tốc Độ Bê Trứng", ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ",
    ["Stay On Treadmill"] = "Cố Định Trên Máy Tập", ["Auto Hatch"] = "Tự Động Ấp Trứng", ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Min Rarity"] = "Độ Hiếm Min", ["Drop Eggs At Safe Zone"] = "Thả Trứng Tại Vùng An Toàn", ["Teleport To Egg"] = "Dịch Chuyển Đến Trứng"
}

local DYNAMIC_PATTERNS = {
    { pattern = "ALL (%d+)", format = function(lang, c) return lang == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end },
    { pattern = "READY (%d+)", format = function(lang, c) return lang == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end },
    { pattern = "GROWING (%d+)", format = function(lang, c) return lang == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end },
    { pattern = "IN BAG (%d+)", format = function(lang, c) return lang == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end },
    { pattern = "1 in ([%d%.]+)", format = function(lang, val) return lang == "VI" and ("Tỉ lệ 1/" .. val) or ("1 in " .. val) end },
    { pattern = "Ends in (%d+h %d+m %d+s)", format = function(lang, tStr) return lang == "VI" and ("Kết thúc sau " .. tStr) or ("Ends in " .. tStr) end }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end
    if currentLanguage == "EN" then
        local res = raw:gsub("Chilli Hub", "Chilli Hub V2")
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
            result = result:gsub(item.en, item.out)
            matched = true
        end
    end
    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}
local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end
    if inst:GetAttribute("__IsTranslating") then return end
    
    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end
    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        inst:SetAttribute("__IsTranslating", true)
        inst:SetAttribute("__LastTranslatedText", mappedText)
        pcall(function() inst.Text = mappedText end)
        inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    pcall(function() inst:SetAttribute("HasTranslateHook", true) end)
    table.insert(TrackedElements, inst)
    task.defer(function() applyTranslation(inst) end)
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        local current = inst.Text
        if current == inst:GetAttribute("__LastTranslatedText") then return end
        inst:SetAttribute("OriginalRawText", current)
        applyTranslation(inst)
    end)
end

-- ==================== 4. LÕI CÔ LẬP ĐỔI MÀU GIAO DIỆN (PASTEL BLUE) ====================
local COLOR_FACE_TOP     = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM  = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW = Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["cày cuốc"] = true, ["farm"] = true, ["người chơi"] = true, ["player"] = true, ["dự đoán"] = true, ["predictor"] = true,
    ["tiến trình"] = true, ["progress"] = true, ["máy chủ"] = true, ["server"] = true, ["khác"] = true, ["misc"] = true,
    ["tự đổi máy chủ"] = true, ["auto hop"] = true, ["discord"] = true, ["phím tắt & key"] = true, ["quick & keys"] = true,
    ["cài đặt"] = true, ["settings"] = true, ["cấu hình"] = true, ["config"] = true
}

local function applySoftBlue(btnContainer, labelObj)
    if not btnContainer then return end
    local grad = btnContainer:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = btnContainer
    end
    grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLOR_FACE_TOP), ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)})
    btnContainer.BackgroundColor3 = COLOR_FACE_BOTTOM

    if btnContainer.Parent and btnContainer.Parent:IsA("Frame") and btnContainer.Parent ~= btnContainer then
        local p = btnContainer.Parent
        if p.BackgroundColor3.R > 0.4 and p.BackgroundColor3.G < 0.35 then
            p.BackgroundColor3 = COLOR_BEVEL_SHADOW
        end
    end
    if labelObj and (labelObj:IsA("TextLabel") or labelObj:IsA("TextButton")) then
        labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function inspectAndReskin(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end

    local textRaw = inst.Text:lower():match("^%s*(.-)%s*$") or ""
    if textRaw:find("chilli hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then applySoftBlue(headerFrame, inst) end
        return
    end
    if TARGET_BUTTON_KEYWORDS[textRaw] then
        local btnTarget = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton") or inst:FindFirstAncestorOfClass("Frame")
        if btnTarget then applySoftBlue(btnTarget, inst) end
        return
    end
end

-- ==================== 5. THUẬT TOÁN ĐIỀU KHIỂN AUTO FARM ỔN ĐỊNH 100% ====================
local function forceClick(target)
    if not target then return end
    pcall(function()
        if getconnections then
            for _, evt in ipairs({"MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "Activated", "TouchTap"}) do
                for _, conn in ipairs(getconnections(target[evt])) do conn:Fire() end
            end
        end
    end)
end

local function isToggleOn(btn)
    if not btn then return false end
    local function isGreen(c) return c and (c.G > 0.45 and c.G > c.R * 1.2 and c.G > c.B * 1.2) end
    if isGreen(btn.BackgroundColor3) then return true end
    for _, child in ipairs(btn:GetDescendants()) do
        if (child:IsA("Frame") or child:IsA("TextButton")) and isGreen(child.BackgroundColor3) then return true end
    end
    return false
end

local function findElementByText(patterns, isDropdown)
    local container = getSafeContainer()
    if not container then return nil end
    for _, desc in ipairs(container:GetDescendants()) do
        if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and not desc:FindFirstAncestor("Chilli_Dynamic_Island") then
            if isDropdown and not desc.Visible then continue end
            local t = desc.Text:lower()
            for _, p in ipairs(patterns) do
                if t == p:lower() or t:find(p:lower(), 1, true) then
                    return desc
                end
            end
        end
    end
    return nil
end

local function executeDropdownSelection(rowLabelPatterns, targetPatterns)
    local headerLabel = findElementByText(rowLabelPatterns, false)
    if not headerLabel then return end
    local headerBtn = headerLabel.Parent
    
    -- 1. Bấm mở Dropdown
    forceClick(headerBtn)
    task.wait(0.2) -- Chờ animation mở menu
    
    -- 2. Quét tìm nút tùy chọn bên trong và bấm
    for _, pat in ipairs(targetPatterns) do
        local optLabel = findElementByText({pat}, true)
        if optLabel then
            forceClick(optLabel.Parent)
            task.wait(0.05)
        end
    end
    
    -- 3. Bấm đóng Dropdown
    task.wait(0.1)
    forceClick(headerBtn)
    task.wait(0.15)
end

local PRESET_TOGGLES = {
    -- Auto Place Egg / Treadmill[cite: 49]
    { name = "DropSafeZone", target = false, patterns = {"thả trứng tại vùng an toàn", "drop eggs at safe zone"} },
    { name = "AntiGuard", target = true, patterns = {"bảng chống vệ sĩ", "anti guard panel"} },
    { name = "AutoTreadmill", target = true, patterns = {"tự động máy tập", "auto treadmill"} },
    { name = "StayTreadmill", target = true, patterns = {"cố định trên máy tập", "stay on treadmill"} },
    -- Auto Steal[cite: 50]
    { name = "AutoSteal", target = true, patterns = {"tự động cướp trứng", "auto steal"} },
    { name = "InstantStealV1", target = false, patterns = {"cướp siêu tốc (instant steal)", "instant steal"} },
    { name = "InstantStealV2", target = true, patterns = {"cướp siêu tốc (instant steal) v2", "instant steal v2"} },
    { name = "TeleportToEgg", target = true, patterns = {"dịch chuyển đến trứng", "teleport to egg"} },
    -- Auto Butterfly Bloom[cite: 51]
    { name = "AutoButterfly", target = true, patterns = {"tự động bắt bướm", "auto butterfly bloom"} }
}

local function applyAutoFarmSettings(isEnable)
    -- Xử lý Toggles
    for _, cfg in ipairs(PRESET_TOGGLES) do
        local label = findElementByText(cfg.patterns, false)
        if label then
            local btn = label.Parent
            local currentState = isToggleOn(btn)
            if isEnable then
                if currentState ~= cfg.target then forceClick(btn); task.wait(0.1) end
            else
                if currentState then forceClick(btn); task.wait(0.1) end -- Khi tắt thì tắt hết cho sạch
            end
        end
    end

    -- Xử lý Dropdowns (Chỉ áp dụng khi bật)
    if isEnable then
        -- Catch Mode -> Chase[cite: 51]
        executeDropdownSelection({"chế độ bắt", "catch mode"}, {"đuổi theo", "chase"})
        -- Catch Priority -> Rarest[cite: 51]
        executeDropdownSelection({"ưu tiên bắt", "catch priority"}, {"hiếm nhất", "rarest"})
        -- Min Rarity -> Secret[cite: 50]
        executeDropdownSelection({"độ hiếm min", "min rarity"}, {"bí ẩn", "secret"})
        -- Catch Butterflies -> Select all[cite: 51]
        executeDropdownSelection({"chọn bướm cần bắt", "catch butterflies"}, {"rực rỡ", "thạch anh tím", "lam ngọc", "lục bảo", "radiant", "amethyst", "sapphire", "emerald"})
    end
end

-- ==================== 6. RAINBOW DYNAMIC ISLAND (KHUNG CẦU VỒNG CHẠY) ====================
local function createDynamicIslandUI()
    local parentTarget = getSafeContainer()
    if not parentTarget then return end
    pcall(function() local old = parentTarget:FindFirstChild("Chilli_Dynamic_Island"); if old then old:Destroy() end end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Dynamic_Island"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Island = Instance.new("Frame")
    Island.Name = "Island"
    Island.Size = UDim2.new(0, 160, 0, 36)
    Island.AnchorPoint = Vector2.new(0.5, 0)
    Island.Position = UDim2.new(0.5, 0, 0, 12)
    Island.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    Island.BackgroundTransparency = 0.05
    Island.BorderSizePixel = 0
    Island.ClipsDescendants = true
    Island.Parent = ScreenGui
    Instance.new("UICorner", Island).CornerRadius = UDim.new(0, 18)

    -- Viền Cầu Vồng chạy qua lại (Moving Rainbow Border)
    local IslandStroke = Instance.new("UIStroke")
    IslandStroke.Thickness = 2.5
    IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    IslandStroke.Parent = Island

    local RainbowGradient = Instance.new("UIGradient")
    RainbowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    })
    RainbowGradient.Parent = IslandStroke

    -- Chuyển động Gradient tịnh tiến qua lại mượt mà
    local timeElapsed = 0
    RunService.RenderStepped:Connect(function(dt)
        timeElapsed = timeElapsed + dt
        RainbowGradient.Offset = Vector2.new(math.sin(timeElapsed * 2), 0)
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 36)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Island

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 26, 0, 26)
    Icon.Position = UDim2.new(0, 8, 0.5, -13)
    Icon.BackgroundColor3 = Color3.fromRGB(24, 30, 45)
    Icon.Text = "🌶️"
    Icon.TextSize = 14
    Icon.Parent = TopBar
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(1, 0)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -75, 1, 0)
    Title.Position = UDim2.new(0, 42, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Chilli V2"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 12
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local ArrowBadge = Instance.new("TextLabel")
    ArrowBadge.Size = UDim2.new(0, 24, 1, 0)
    ArrowBadge.Position = UDim2.new(1, -30, 0, 0)
    ArrowBadge.BackgroundTransparency = 1
    ArrowBadge.Text = "▼"
    ArrowBadge.Font = Enum.Font.GothamBold
    ArrowBadge.TextSize = 12
    ArrowBadge.TextColor3 = Color3.fromRGB(180, 195, 220)
    ArrowBadge.Parent = TopBar

    local HeaderButton = Instance.new("TextButton")
    HeaderButton.Size = UDim2.new(1, 0, 1, 0)
    HeaderButton.BackgroundTransparency = 1
    HeaderButton.Text = ""
    HeaderButton.ZIndex = 20
    HeaderButton.Parent = TopBar

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -16, 0, 78)
    ContentFrame.Position = UDim2.new(0, 8, 0, 42)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Island

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = ContentFrame

    -- KHOANG 1: NÚT ĐỔI NGÔN NGỮ
    local LangSegment = Instance.new("Frame")
    LangSegment.Size = UDim2.new(1, 0, 0, 30)
    LangSegment.BackgroundColor3 = Color3.fromRGB(20, 24, 36)
    LangSegment.LayoutOrder = 1
    LangSegment.Parent = ContentFrame
    Instance.new("UICorner", LangSegment).CornerRadius = UDim.new(1, 0)

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -4, 1, -4)
    LangSlider.Position = UDim2.new(0, 2, 0.5, -13)
    LangSlider.BackgroundColor3 = COLOR_FACE_BOTTOM
    LangSlider.Parent = LangSegment
    Instance.new("UICorner", LangSlider).CornerRadius = UDim.new(1, 0)

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 VIE"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 11
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = LangSegment

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENG"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 11
    BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
    BtnEN.ZIndex = 5
    BtnEN.Parent = LangSegment

    local function setLanguage(lang)
        if currentLanguage == lang then return end
        currentLanguage = lang
        if lang == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -13)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 2, 0.5, -13)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        end
        updateAllActive()
    end
    BtnVI.MouseButton1Click:Connect(function() setLanguage("VI") end)
    BtnEN.MouseButton1Click:Connect(function() setLanguage("EN") end)

    -- KHOANG 2: CÀI ĐẶT AUTO FARM
    local AutoFarmCard = Instance.new("Frame")
    AutoFarmCard.Size = UDim2.new(1, 0, 0, 48)
    AutoFarmCard.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
    AutoFarmCard.LayoutOrder = 2
    AutoFarmCard.Parent = ContentFrame
    Instance.new("UICorner", AutoFarmCard).CornerRadius = UDim.new(0, 10)
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Color3.fromRGB(45, 60, 85)
    CardStroke.Parent = AutoFarmCard

    local FarmTitle = Instance.new("TextLabel")
    FarmTitle.Size = UDim2.new(1, -60, 0, 20)
    FarmTitle.Position = UDim2.new(0, 10, 0, 5)
    FarmTitle.BackgroundTransparency = 1
    FarmTitle.Text = "Settings Auto Farm"
    FarmTitle.Font = Enum.Font.GothamBold
    FarmTitle.TextSize = 11
    FarmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmTitle.TextXAlignment = Enum.TextXAlignment.Left
    FarmTitle.Parent = AutoFarmCard

    local FarmSub = Instance.new("TextLabel")
    FarmSub.Size = UDim2.new(1, -60, 0, 16)
    FarmSub.Position = UDim2.new(0, 10, 0, 25)
    FarmSub.BackgroundTransparency = 1
    FarmSub.Text = "Áp dụng cấu hình 3 ảnh"
    FarmSub.Font = Enum.Font.GothamMedium
    FarmSub.TextSize = 9
    FarmSub.TextColor3 = Color3.fromRGB(130, 150, 180)
    FarmSub.TextXAlignment = Enum.TextXAlignment.Left
    FarmSub.Parent = AutoFarmCard

    local ToggleTrack = Instance.new("TextButton")
    ToggleTrack.Size = UDim2.new(0, 42, 0, 24)
    ToggleTrack.Position = UDim2.new(1, -52, 0.5, -12)
    ToggleTrack.BackgroundColor3 = Color3.fromRGB(38, 44, 58)
    ToggleTrack.Text = ""
    ToggleTrack.Parent = AutoFarmCard
    Instance.new("UICorner", ToggleTrack).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = Color3.fromRGB(200, 205, 215)
    Knob.Parent = ToggleTrack
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local isAutoFarmActive = false
    ToggleTrack.MouseButton1Click:Connect(function()
        isAutoFarmActive = not isAutoFarmActive
        if isAutoFarmActive then
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -21, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(ToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 205, 110)}):Play()
            FarmSub.Text = "Đang kích hoạt cài đặt..."
            TweenService:Create(FarmSub, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(90, 240, 150)}):Play()
            task.spawn(function()
                applyAutoFarmSettings(true)
                FarmSub.Text = "Đã bật cấu hình chuẩn"
            end)
        else
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Color3.fromRGB(200, 205, 215)}):Play()
            TweenService:Create(ToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(38, 44, 58)}):Play()
            FarmSub.Text = "Đang tắt các cài đặt..."
            TweenService:Create(FarmSub, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 150, 180)}):Play()
            task.spawn(function()
                applyAutoFarmSettings(false)
                FarmSub.Text = "Đã tắt các cài đặt"
            end)
        end
    end)

    -- Logic Mở Rộng / Thu Gọn
    local isExpanded = false
    local isAnimating = false
    local function toggleIsland()
        if isAnimating then return end
        isAnimating = true
        isExpanded = not isExpanded

        local targetSize = isExpanded and UDim2.new(0, 260, 0, 140) or UDim2.new(0, 160, 0, 36)
        local targetRotation = isExpanded and 180 or 0

        TweenService:Create(ArrowBadge, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = targetRotation}):Play()
        local tween = TweenService:Create(Island, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = targetSize})
        tween:Play()
        tween.Completed:Connect(function() isAnimating = false end)
    end

    local dragging, dragStart, startPos = false, nil, nil
    local dragMoved = false

    HeaderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragMoved = false
            dragStart = input.Position
            startPos = Island.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)

    HeaderButton.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            if delta.Magnitude > 10 then
                dragMoved = true
                local cam = workspace.CurrentCamera
                local maxX = cam and cam.ViewportSize.X - 260 or 800
                local maxY = cam and cam.ViewportSize.Y - 140 or 600
                local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)
                Island.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
            end
        end
    end)

    HeaderButton.Activated:Connect(function() if not dragMoved then toggleIsland() end end)
end

-- ==================== 7. KHỞI CHẠY HỆ THỐNG ====================
task.spawn(function()
    createDynamicIslandUI()
    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
                inspectAndReskin(desc)
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end
    local container = getSafeContainer()
    if container then
        pcall(function() scanUIChunked(container) end)
        container.DescendantAdded:Connect(function(desc)
            task.defer(function()
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                    inspectAndReskin(desc)
                end
            end)
        end)
    end
end)
