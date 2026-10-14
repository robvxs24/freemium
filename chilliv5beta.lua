-- ==============================================================================
--  CHILLI HUB V5 - DYNAMIC ISLAND LANGUAGE SWITCHER & FULL VIETNAMESE ENGINE
--  Bảo toàn 100%:
--    1. LOGO TRÒN 1:1 (60x60) & HEADER LOGO: Giữ nguyên vẹn bản chuẩn 6568.jpg.
--    2. DYNAMIC ISLAND THÔNG MINH: Thu gọn hiện "● Idle ✨ rainbow", bấm vào ẩn
--       nút Idle và mở bảng chọn ngôn ngữ (Tiếng Việt / English).
--    3. DỊCH FULL GIAO DIỆN: Dịch 100% nội dung các tab trong 10 ảnh sang Tiếng Việt.
--    4. ZERO-LAG ENGINE: Chạy 1 luồng duy nhất, khóa chống đệ quy tuyệt đối.
-- ==============================================================================

local NEW_TITLE = "Chilli Hub V5"
local CHILLI_LOGO_ID = "rbxassetid://92622270383869"
local LOGO_BG_COLOR = Color3.fromRGB(5, 7, 15)

-- 1. KHỞI CHẠY BASE SCRIPT LUARMOR
if not getgenv().__VenyxV5Loaded then
    getgenv().__VenyxV5Loaded = true
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/a40becae9d58ed4c969ab2f9d26f2f1b.lua"))()
        end)
    end)
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local roots = {
    gethui and gethui(),
    CoreGui,
    LocalPlayer:WaitForChild("PlayerGui")
}

-- Danh sách chứa các Gradient để xoay chung trong 1 luồng duy nhất (0% CPU)
local ActiveGradients = {}

local COLOR_SEQ_RAINBOW = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 55, 55)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 175, 40)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 235, 50)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(50, 255, 130)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(60, 185, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 55, 55))
})

-- VÒNG LẶP XOAY CẦU VỒNG DUY NHẤT TOÀN HỆ THỐNG (NHẸ TUYỆT ĐỐI)
task.spawn(function()
    local rot = 0
    while true do
        rot = (rot + 4) % 360
        for i = #ActiveGradients, 1, -1 do
            local g = ActiveGradients[i]
            if g and g.Parent then
                g.Rotation = rot
            else
                table.remove(ActiveGradients, i)
            end
        end
        task.wait(0.03)
    end
end)

-- ==================== 2. HỆ THỐNG TỪ ĐIỂN DỊCH THUẬT (CHUẨN 10 ẢNH) ====================
local currentLanguage = "VI"
local FastCache = {}
local TrackedTexts = {}

local EXACT_MATCH_VI = {
    -- Dashboard (Ảnh 1)
    ["Dashboard"] = "Bảng Điều Khiển",
    ["Welcome back"] = "Chào mừng trở lại",
    ["Beta version"] = "Phiên bản Beta",
    ["This is a test build. Features may change and bugs can happen."] = "Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",
    ["Rejoin"] = "Vào lại",
    ["Server hop"] = "Đổi server",
    ["Copy Job ID"] = "Chép Job ID",
    ["Unload hub"] = "Tắt Hub",
    ["Save config"] = "Lưu cấu hình",
    ["Hide UI"] = "Ẩn Menu",
    ["SESSION"] = "PHIÊN CHƠI",
    ["STOLEN"] = "ĐÃ CƯỚP",
    ["LAST EGG"] = "TRỨNG CUỐI",
    ["PLACED"] = "ĐÃ ĐẶT",
    ["HATCHED"] = "ĐÃ ẤP",
    ["NIGHT IN"] = "ĐÊM SAU",
    ["SESSION TIME"] = "THỜI GIAN",
    ["BEST STEAL"] = "CƯỚP TỐT NHẤT",
    ["EGG BAG"] = "TÚI TRỨNG",
    ["PET BAG"] = "TÚI PET",
    ["WHAT'S NEW"] = "CÓ GÌ MỚI",
    ["NEW"] = "MỚI",
    ["Event"] = "Sự kiện",
    ["Racing Event: ragdoll jump to the portal, races, leaves and claims"] = "Sự Kiện Đua Xe: tự nhảy vào cổng, đua, rời đi và nhận thưởng",
    ["Shooting Star catcher with ragdoll jump and run fallback"] = "Bắt Sao Băng kết hợp nhảy ragdoll và chạy dự phòng",
    ["Steal panel joins the game buttons and lists every egg"] = "Bảng Cướp tích hợp nút game và liệt kê mọi quả trứng",
    ["Search"] = "Tìm kiếm",
    ["Filter"] = "Lọc tìm",

    -- Steal & Egg Predictor (Ảnh 2, 3, 4)
    ["Steal"] = "Cướp Trứng",
    ["Auto Steal"] = "Tự Động Cướp",
    ["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP",
    ["Auto steal"] = "Tự động cướp",
    ["Egg Predictor"] = "Dự Đoán Trứng",
    ["EGG PREDICTOR"] = "DỰ ĐOÁN TRỨNG",
    ["Go to egg"] = "Di chuyển tới trứng",
    ["Teleport to egg"] = "Dịch chuyển tới trứng",
    ["Tween"] = "Bay (Tween)",
    ["Delivery method"] = "Cách mang về",
    ["Fast tween speed"] = "Tốc độ bay nhanh",
    ["Tween speed"] = "Tốc độ bay",
    ["Steal missing index eggs"] = "Cướp trứng thiếu trong Chỉ mục",
    ["Steal back from players"] = "Cướp lại từ người chơi",
    ["Anti guard"] = "Chống vệ sĩ",
    ["Drop eggs at safe zone"] = "Thả trứng ở vùng an toàn",
    ["FILTER"] = "BỘ LỌC",
    ["Zones"] = "Khu vực",
    ["None"] = "Không có",
    ["Steal first"] = "Ưu tiên cướp",
    ["Best value"] = "Giá trị cao nhất",
    ["Mutations"] = "Đột biến",
    ["Rarities"] = "Độ hiếm",
    ["Only these eggs"] = "Chỉ những trứng này",
    ["Min value /s"] = "Giá trị tối thiểu /s",
    ["Off"] = "Tắt",
    ["Sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
    ["Keep lab eggs"] = "Giữ lại trứng Lab",
    ["AUTO HOP SERVER"] = "TỰ ĐỔI MÁY CHỦ",
    ["Only sell eggs below /s"] = "Chỉ bán trứng dưới mức /s",
    ["EGG SHOWCASE"] = "TRƯNG BÀY TRỨNG",
    ["Sort eggs"] = "Sắp xếp trứng",
    ["Preview card"] = "Thẻ xem trước",
    ["Pick one"] = "Chọn một mục",
    ["Value"] = "Giá trị",
    ["Rarity"] = "Độ hiếm",
    ["Time left"] = "Thời gian còn lại",

    -- Farm: Pen, Treadmill, Mutate (Ảnh 5, 6, 7)
    ["Farm"] = "Cày Cuốc",
    ["Pen"] = "Chuồng Ấp",
    ["PEN"] = "CHUỒNG ẤP",
    ["Treadmill"] = "Máy Tập",
    ["TREADMILL"] = "MÁY TẬP CHẠY",
    ["Mutate"] = "Đột Biến",
    ["MUTATE"] = "ĐỘT BIẾN",
    ["Sell"] = "Bán",
    ["SELL"] = "BÁN TỰ ĐỘNG",
    ["Fuse"] = "Dung Hợp",
    ["FUSE"] = "DUNG HỢP",
    ["Priority"] = "Ưu Tiên",
    ["AUTO PLACE"] = "TỰ ĐỘNG ĐẶT TRỨNG",
    ["Auto place"] = "Tự động đặt trứng",
    ["Place when"] = "Đặt khi",
    ["Always"] = "Luôn luôn",
    ["Place first"] = "Ưu tiên đặt",
    ["AUTO HATCH"] = "TỰ ĐỘNG ẤP TRỨNG",
    ["Auto hatch"] = "Tự động ấp trứng",
    ["Equip best pets"] = "Trang bị pet mạnh nhất",
    ["READY NOW"] = "SẴN SÀNG ẤP",
    ["Auto treadmill"] = "Tự chạy máy tập",
    ["Auto upgrade treadmill"] = "Tự nâng cấp máy tập",
    ["PROGRESS"] = "TIẾN TRÌNH",
    ["Auto upgrade base"] = "Tự nâng cấp căn cứ",
    ["Auto buy trails"] = "Tự mua vệt sáng",
    ["Auto claim offline cash"] = "Tự nhận tiền ngoại tuyến",
    ["Auto claim index rewards"] = "Tự nhận thưởng Chỉ mục",
    ["AUTO MUTATE"] = "TỰ ĐỘNG ĐỘT BIẾN",
    ["Auto mutate"] = "Tự động đột biến",
    ["MUTATE FILTER"] = "BỘ LỌC ĐỘT BIẾN",
    ["Use items"] = "Dùng vật phẩm",
    ["Mutate first"] = "Ưu tiên đột biến",
    ["Auto buy Nitro"] = "Tự mua Nitro",
    ["PETS"] = "THÚ CƯNG (PETS)",
    ["EGGS"] = "TRỨNG (EGGS)",

    -- Farm: Sell, Lab Eggs, Favorite, Fuse (Ảnh 8, 9, 10)
    ["Auto sell pets"] = "Tự động bán pet",
    ["Auto sell eggs"] = "Tự động bán trứng",
    ["Sell rarities"] = "Độ hiếm bán",
    ["Never sell"] = "Không bao giờ bán",
    ["Only mutations"] = "Chỉ bán đột biến",
    ["Only below /s"] = "Chỉ bán dưới mức /s",
    ["Keep mutated"] = "Giữ lại đồ đột biến",
    ["Sell matching pets now"] = "Bán các pet khớp ngay",
    ["Sell matching eggs now"] = "Bán các trứng khớp ngay",
    ["LAB EGGS"] = "TRỨNG PHÒNG LAB",
    ["FAVORITE"] = "YÊU THÍCH (KHÓA)",
    ["Auto favorite"] = "Tự động khóa bảo vệ",
    ["Auto sell lab eggs"] = "Tự động bán trứng Lab",
    ["Sell matching lab eggs now"] = "Bán trứng Lab khớp ngay",
    ["Match"] = "Điều kiện khớp",
    ["All picked rules"] = "Khớp tất cả quy tắc",
    ["Any picked rule"] = "Khớp bất kỳ quy tắc",
    ["Always favorite"] = "Luôn khóa loài này",
    ["Favorite equipped"] = "Khóa pet đang trang bị",
    ["FUSE MACHINE"] = "MÁY DUNG HỢP",
    ["No 3 matching pets"] = "Chưa đủ 3 pet cùng loại",
    ["Auto fuse"] = "Tự động dung hợp",
    ["Fuse first"] = "Ưu tiên dung hợp",
    ["Lowest rarity"] = "Độ hiếm thấp nhất",
    ["Highest rarity"] = "Độ hiếm cao nhất",
    ["Use pets"] = "Sử dụng pet",
    ["Lowest value first"] = "Giá trị thấp nhất trước",
    ["Highest value first"] = "Giá trị cao nhất trước",
    ["Skip mutated"] = "Bỏ qua pet đột biến",
    ["Eject odd pets"] = "Đẩy pet lẻ ra ngoài",
    ["FUSE FILTER"] = "BỘ LỌC DUNG HỢP",
    ["Only these pets"] = "Chỉ những pet này",
    ["Never fuse"] = "Không bao giờ dung hợp",
    ["FUSE PREDICTOR"] = "DỰ ĐOÁN DUNG HỢP",
    ["SLOTS"] = "Ô CHỨA",
    ["STATUS"] = "TRẠNG THÁI",
    ["Waiting for pets"] = "Đang chờ pet",
    ["LIKELY SIZE"] = "KÍCH CỠ DỰ KIẾN",
    ["CHANCE"] = "TỶ LỆ",

    -- Độ hiếm
    ["Common"] = "Phổ Thông (Common)",
    ["Uncommon"] = "Thường (Uncommon)",
    ["Rare"] = "Hiếm (Rare)",
    ["Epic"] = "Sử Thi (Epic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)"
}

local DYNAMIC_PATTERNS_VI = {
    { pat = "^ALL (%d+)$", rep = "TẤT CẢ %1" },
    { pat = "^READY (%d+)$", rep = "SẴN SÀNG %1" },
    { pat = "^GROWING (%d+)$", rep = "ĐANG LỚN %1" },
    { pat = "^IN BAG (%d+)$", rep = "TRONG TÚI %1" },
    { pat = "Pen (%d+/%d+) · (%d+) egg%(s%) ready to place", rep = "Chuồng %1 · %2 trứng sẵn sàng đặt" },
    { pat = "(%d+) egg%(s%) can be mutated", rep = "%1 trứng có thể đột biến" },
    { pat = "(%d+) pet%(s%) match", rep = "%1 pet khớp bộ lọc" },
    { pat = "(%d+) egg%(s%) match", rep = "%1 trứng khớp bộ lọc" },
    { pat = "(%d+) lab egg%(s%) match", rep = "%1 trứng Lab khớp bộ lọc" },
    { pat = "^(%d+) pets$", rep = "%1 thú cưng" }
}

local function translateVenyxText(raw)
    if not raw or raw == "" then return raw end
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if raw:find("Venyx SAE") then
        raw = raw:gsub("Venyx SAE", "Chilli SAE")
    elseif raw == "VENYX" then
        raw = NEW_TITLE
    end

    if currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
    end

    local trimmed = raw:match("^%s*(.-)%s*$") or raw
    if EXACT_MATCH_VI[trimmed] then
        local out = raw:gsub(trimmed:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"), EXACT_MATCH_VI[trimmed], 1)
        FastCache[cacheKey] = out
        return out
    end

    local result = raw
    for _, item in ipairs(DYNAMIC_PATTERNS_VI) do
        if result:find(item.pat) then
            result = result:gsub(item.pat, item.rep)
            FastCache[cacheKey] = result
            return result
        end
    end

    FastCache[cacheKey] = result
    return result
end

local function applyElementTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    if inst:IsA("TextBox") then
        local origPh = inst:GetAttribute("OrigPlaceholder")
        if not origPh and inst.PlaceholderText ~= "" then
            origPh = inst.PlaceholderText
            inst:SetAttribute("OrigPlaceholder", origPh)
        end
        if origPh then
            inst.PlaceholderText = translateVenyxText(origPh)
        end
        return
    end

    local rawText = inst.Text
    if rawText:find("✨ rainbow") then return end

    local original = inst:GetAttribute("OrigRawText")
    if not original then
        original = rawText
        inst:SetAttribute("OrigRawText", original)
    end

    local mapped = translateVenyxText(original)
    if inst.Text ~= mapped then
        inst:SetAttribute("__IsTranslating", true)
        inst:SetAttribute("__LastTranslated", mapped)
        pcall(function() inst.Text = mapped end)
        task.defer(function()
            inst:SetAttribute("__IsTranslating", false)
        end)
    end
end

local function hookTextForTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__TransHooked") then return end
    if inst:GetAttribute("__IslandDone") or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") then return end
    inst:SetAttribute("__TransHooked", true)

    table.insert(TrackedTexts, inst)
    applyElementTranslation(inst)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        if inst.Text:find("✨ rainbow") then return end
        if inst.Text ~= inst:GetAttribute("__LastTranslated") then
            inst:SetAttribute("OrigRawText", inst.Text)
            applyElementTranslation(inst)
        end
    end)
end

local function refreshAllTranslations()
    for i = #TrackedTexts, 1, -1 do
        local el = TrackedTexts[i]
        if el and el.Parent then
            applyElementTranslation(el)
        else
            table.remove(TrackedTexts, i)
        end
    end
end

-- ==================== 3. DYNAMIC ISLAND & NÚT TRẠNG THÁI IDLE ✨ RAINBOW ====================
-- Thu gọn: Hiện nút trạng thái "● Idle ✨ rainbow"
-- Phóng to (Bấm vào): Ẩn nút trạng thái Idle, hiện bảng chọn Tiếng Việt / English
local function setupDynamicIslandFromStatus(statusLbl, venyxGui)
    if statusLbl:GetAttribute("__IslandDone") then return end
    statusLbl:SetAttribute("__IslandDone", true)

    local pill = statusLbl.Parent
    if not (pill and pill:IsA("GuiObject")) then return end

    local function updateStatusText()
        if statusLbl:GetAttribute("__Updating") then return end
        statusLbl:SetAttribute("__Updating", true)

        local raw = statusLbl.Text
        local clean = raw:gsub("●", ""):gsub("•", ""):gsub("✨%s*rainbow", ""):match("^%s*(.-)%s*$") or "Idle"
        if clean == "" then clean = "Idle" end

        statusLbl.Text = clean .. " ✨ rainbow"
        statusLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLbl.AutomaticSize = Enum.AutomaticSize.X

        task.defer(function()
            statusLbl:SetAttribute("__Updating", false)
        end)
    end

    updateStatusText()

    local txtGrad = pill:FindFirstChild("TextRainbow", true) or Instance.new("UIGradient")
    txtGrad.Name = "TextRainbow"
    txtGrad.Color = COLOR_SEQ_RAINBOW
    txtGrad.Parent = statusLbl
    table.insert(ActiveGradients, txtGrad)

    -- Đưa nút trạng thái gốc lên đỉnh màn hình (Chế độ thu gọn)
    local currentHeight = math.clamp(pill.AbsoluteSize.Y, 26, 32)
    pill.Parent = venyxGui
    pill.AnchorPoint = Vector2.new(0.5, 0)
    pill.Position = UDim2.new(0.5, 0, 0, 10)
    pill.Size = UDim2.new(0, 0, 0, currentHeight)
    pill.AutomaticSize = Enum.AutomaticSize.X
    pill.BackgroundColor3 = Color3.fromRGB(22, 24, 36)
    pill.BackgroundTransparency = 0.08
    pill.ZIndex = 9999
    pill.Active = true

    local pillCorner = pill:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(1, 0)
    pillCorner.Parent = pill

    local pillStroke = pill:FindFirstChild("IslandStroke") or Instance.new("UIStroke")
    pillStroke.Name = "IslandStroke"
    pillStroke.Thickness = 1.4
    pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    pillStroke.Color = Color3.fromRGB(255, 255, 255)
    pillStroke.Parent = pill

    local strokeGrad = pillStroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
    strokeGrad.Color = COLOR_SEQ_RAINBOW
    strokeGrad.Parent = pillStroke
    table.insert(ActiveGradients, strokeGrad)

    -- TẠO BẢNG DYNAMIC ISLAND PHÓNG TO (ẨN MẶC ĐỊNH, HIỆN KHI ẤN VÀO NÚT IDLE)
    local oldExp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
    if oldExp then oldExp:Destroy() end

    local ExpandedIsland = Instance.new("Frame")
    ExpandedIsland.Name = "ChilliV5_ExpandedIsland"
    ExpandedIsland.AnchorPoint = Vector2.new(0.5, 0)
    ExpandedIsland.Position = pill.Position
    ExpandedIsland.Size = UDim2.new(0, 260, 0, 78)
    ExpandedIsland.BackgroundColor3 = Color3.fromRGB(16, 18, 28)
    ExpandedIsland.BackgroundTransparency = 0.05
    ExpandedIsland.BorderSizePixel = 0
    ExpandedIsland.Visible = false
    ExpandedIsland.Active = true
    ExpandedIsland.ZIndex = 10000
    ExpandedIsland.Parent = venyxGui

    local ExpCorner = Instance.new("UICorner")
    ExpCorner.CornerRadius = UDim.new(0, 16)
    ExpCorner.Parent = ExpandedIsland

    local ExpStroke = Instance.new("UIStroke")
    ExpStroke.Thickness = 1.6
    ExpStroke.Color = Color3.fromRGB(255, 255, 255)
    ExpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ExpStroke.Parent = ExpandedIsland

    local ExpStrokeGrad = Instance.new("UIGradient")
    ExpStrokeGrad.Color = COLOR_SEQ_RAINBOW
    ExpStrokeGrad.Parent = ExpStroke
    table.insert(ActiveGradients, ExpStrokeGrad)

    -- Tiêu đề trong Dynamic Island khi mở rộng
    local ExpTitle = Instance.new("TextLabel")
    ExpTitle.Size = UDim2.new(1, -44, 0, 28)
    ExpTitle.Position = UDim2.new(0, 14, 0, 4)
    ExpTitle.BackgroundTransparency = 1
    ExpTitle.Text = "🌶️ Chilli Hub V5"
    ExpTitle.Font = Enum.Font.GothamBold
    ExpTitle.TextSize = 11.5
    ExpTitle.TextColor3 = Color3.fromRGB(245, 248, 255)
    ExpTitle.TextXAlignment = Enum.TextXAlignment.Left
    ExpTitle.ZIndex = 10001
    ExpTitle.Parent = ExpandedIsland

    -- Nút thu gọn lại về trạng thái Idle ✨ rainbow
    local CollapseBtn = Instance.new("TextButton")
    CollapseBtn.Size = UDim2.new(0, 24, 0, 22)
    CollapseBtn.Position = UDim2.new(1, -32, 0, 7)
    CollapseBtn.BackgroundColor3 = Color3.fromRGB(32, 36, 54)
    CollapseBtn.BorderSizePixel = 0
    CollapseBtn.Text = "▲"
    CollapseBtn.Font = Enum.Font.GothamBold
    CollapseBtn.TextSize = 10
    CollapseBtn.TextColor3 = Color3.fromRGB(160, 205, 255)
    CollapseBtn.ZIndex = 10002
    CollapseBtn.Parent = ExpandedIsland

    local CollapseCorner = Instance.new("UICorner")
    CollapseCorner.CornerRadius = UDim.new(1, 0)
    CollapseCorner.Parent = CollapseBtn

    -- Thanh gạt đổi ngôn ngữ (Tiếng Việt / English)
    local LangCapsule = Instance.new("Frame")
    LangCapsule.Size = UDim2.new(1, -20, 0, 34)
    LangCapsule.Position = UDim2.new(0, 10, 0, 36)
    LangCapsule.BackgroundColor3 = Color3.fromRGB(24, 28, 42)
    LangCapsule.BorderSizePixel = 0
    LangCapsule.ZIndex = 10001
    LangCapsule.Parent = ExpandedIsland

    local LangCorner = Instance.new("UICorner")
    LangCorner.CornerRadius = UDim.new(1, 0)
    LangCorner.Parent = LangCapsule

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -4, 1, -4)
    LangSlider.Position = UDim2.new(0, 2, 0, 2)
    LangSlider.BackgroundColor3 = Color3.fromRGB(95, 110, 235)
    LangSlider.BorderSizePixel = 0
    LangSlider.ZIndex = 10002
    LangSlider.Parent = LangCapsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = LangSlider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.Position = UDim2.new(0, 0, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 TIẾNG VIỆT"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10.5
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 10003
    BtnVI.Parent = LangCapsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10.5
    BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
    BtnEN.ZIndex = 10003
    BtnEN.Parent = LangCapsule

    local function setLanguage(lang)
        if currentLanguage == lang then return end
        currentLanguage = lang

        if lang == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
            BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 2, 0, 2)
            }):Play()
            BtnEN.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnVI.TextColor3 = Color3.fromRGB(150, 165, 190)
        end

        refreshAllTranslations()
    end

    BtnVI.MouseButton1Click:Connect(function() setLanguage("VI") end)
    BtnEN.MouseButton1Click:Connect(function() setLanguage("EN") end)

    -- HÀM ĐÓNG / MỞ DYNAMIC ISLAND (ẨN NÚT IDLE KHI MỞ RỘNG, HIỆN LẠI KHI THU GỌN)
    local function toggleIsland(expand)
        if expand then
            ExpandedIsland.Position = pill.Position
            pill.Visible = false -- Ẩn hoàn toàn nút trạng thái Idle khi phóng to
            ExpandedIsland.Size = UDim2.new(0, 150, 0, 32)
            ExpandedIsland.Visible = true
            TweenService:Create(ExpandedIsland, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 260, 0, 78)
            }):Play()
        else
            pill.Position = ExpandedIsland.Position
            ExpandedIsland.Visible = false
            pill.Visible = true -- Hiện lại nút trạng thái Idle ✨ rainbow khi thu gọn
        end
    end

    CollapseBtn.MouseButton1Click:Connect(function()
        toggleIsland(false)
    end)

    -- Hỗ trợ vừa Kéo Thả vừa Bấm Mở trên cả Nút Idle và Bảng Mở Rộng
    local function attachDragAndClick(frameObj, onTapCallback)
        local dragging, dragStart, startPos, moved = false, nil, nil, false

        frameObj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                moved = false
                dragStart = input.Position
                startPos = frameObj.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        if dragging and not moved and onTapCallback then
                            onTapCallback()
                        end
                        dragging = false
                    end
                end)
            end
        end)

        frameObj.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
                local delta = input.Position - dragStart
                if delta.Magnitude > 6 then
                    moved = true
                end
                local cam = workspace.CurrentCamera
                local maxX = cam and cam.ViewportSize.X - 140 or 800
                local maxY = cam and cam.ViewportSize.Y - 50 or 600
                local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 4, maxY)
                local newPos = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                frameObj.Position = newPos
                if frameObj == pill then
                    ExpandedIsland.Position = newPos
                else
                    pill.Position = newPos
                end
            end
        end)
    end

    attachDragAndClick(pill, function()
        toggleIsland(true)
    end)
    attachDragAndClick(ExpandedIsland, nil)

    statusLbl:GetPropertyChangedSignal("Text"):Connect(function()
        if not statusLbl:GetAttribute("__Updating") and not statusLbl.Text:find("✨ rainbow") then
            updateStatusText()
        end
    end)
end

-- ==================== 4. NÚT TRÒN NỔI 1:1 (GIỮ NGUYÊN BẢN 6568.JPG) ====================
local function setupUnclippedCircularLogo(img)
    if img:GetAttribute("__FloatingLogoV5Perfect") then return end
    img:SetAttribute("__FloatingLogoV5Perfect", true)

    local container = img
    while container.Parent and container.Parent:IsA("GuiObject") and not container.Parent:IsA("ScreenGui") do
        if container.Parent.AbsoluteSize.X <= 130 and container.Parent.AbsoluteSize.Y <= 130 then
            container = container.Parent
        else
            break
        end
    end

    for _, child in ipairs(container:GetDescendants()) do
        if child:IsA("UIPadding") or child:IsA("UIAspectRatioConstraint") or child:IsA("UISizeConstraint") then
            if child.Name ~= "PerfectCircleAspect" then
                pcall(function() child:Destroy() end)
            end
        end
        if child.Name == "InnerChilliLogo" or child.Name == "ChilliFullInnerLogo" then
            pcall(function() child:Destroy() end)
        end
    end

    container.Size = UDim2.new(0, 60, 0, 60)
    container.BackgroundColor3 = LOGO_BG_COLOR
    container.BackgroundTransparency = 0
    container.BorderSizePixel = 0
    container.ClipsDescendants = true

    local aspect = container:FindFirstChild("PerfectCircleAspect") or Instance.new("UIAspectRatioConstraint")
    aspect.Name = "PerfectCircleAspect"
    aspect.AspectRatio = 1
    aspect.Parent = container

    local cCorner = container:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = container

    if not container:GetAttribute("__SizeLocked") then
        container:SetAttribute("__SizeLocked", true)
        container:GetPropertyChangedSignal("Size"):Connect(function()
            if container.Size ~= UDim2.new(0, 60, 0, 60) then
                container.Size = UDim2.new(0, 60, 0, 60)
            end
        end)
    end

    local stroke = container:FindFirstChild("RainbowBorder") or Instance.new("UIStroke")
    stroke.Name = "RainbowBorder"
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Parent = container

    local strokeGrad = stroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
    strokeGrad.Color = COLOR_SEQ_RAINBOW
    strokeGrad.Parent = stroke
    table.insert(ActiveGradients, strokeGrad)

    for _, desc in ipairs(container:GetDescendants()) do
        if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) and desc.Name ~= "ChilliV5CoverLogo" then
            desc.ImageTransparency = 1
            desc.BackgroundTransparency = 1
        end
    end
    if container:IsA("ImageLabel") or container:IsA("ImageButton") then
        container.ImageTransparency = 1
    end

    local coverLogo = container:FindFirstChild("ChilliV5CoverLogo") or Instance.new("ImageLabel")
    coverLogo.Name = "ChilliV5CoverLogo"
    coverLogo.Size = UDim2.new(1, 0, 1, 0)
    coverLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    coverLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    coverLogo.BackgroundTransparency = 1
    coverLogo.Image = CHILLI_LOGO_ID
    coverLogo.ImageTransparency = 0
    coverLogo.ScaleType = Enum.ScaleType.Fit
    coverLogo.Active = false
    coverLogo.ZIndex = container.ZIndex + 5
    coverLogo.Parent = container

    local logoCorner = coverLogo:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = coverLogo
end

-- ==================== 5. BỘ QUÉT ĐỊNH VỊ & DỊCH THUẬT AN TOÀN ====================
local function tryPatchVenyx()
    for _, root in ipairs(roots) do
        if root then
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "RobloxGui" and gui.Name ~= "TopBarApp" then
                    local titleLbl = nil
                    for _, d in ipairs(gui:GetDescendants()) do
                        if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d:FindFirstAncestorOfClass("ScrollingFrame") then
                            local t = d.Text
                            if t == "VENYX" or t == NEW_TITLE then
                                titleLbl = d
                                break
                            end
                        end
                    end

                    if titleLbl then
                        -- 1. Đổi tên tiêu đề
                        if titleLbl.Text ~= NEW_TITLE then
                            titleLbl.Text = NEW_TITLE
                            titleLbl.AutomaticSize = Enum.AutomaticSize.X
                        end

                        -- Tìm khung Main Window (kích thước lớn >= 350x220)
                        local mainWindow = nil
                        local curr = titleLbl
                        while curr.Parent and curr.Parent ~= gui do
                            curr = curr.Parent
                            if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= 350 and curr.AbsoluteSize.Y >= 220 then
                                mainWindow = curr
                            end
                        end

                        local headerY = titleLbl.AbsolutePosition.Y

                        -- Bắt sự kiện cho các phần tử Text khi mở Dropdown / Modal mới (Chỉ bắt Text, không tạo Instance gây đệ quy)
                        if not gui:GetAttribute("__TextListenerAttached") then
                            gui:SetAttribute("__TextListenerAttached", true)
                            gui.DescendantAdded:Connect(function(newDesc)
                                if newDesc:IsA("TextLabel") or newDesc:IsA("TextButton") or newDesc:IsA("TextBox") then
                                    task.defer(function()
                                        hookTextForTranslation(newDesc)
                                    end)
                                end
                            end)
                        end

                        -- Quét có kiểm soát bên trong ScreenGui của Venyx
                        for _, desc in ipairs(gui:GetDescendants()) do
                            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                                local txt = desc.Text or ""

                                -- 2. Định vị đúng nút Idle trên Header để đưa lên Dynamic Island
                                if not desc:GetAttribute("__IslandDone")
                                and not desc:FindFirstAncestorOfClass("ScrollingFrame")
                                and math.abs(desc.AbsolutePosition.Y - headerY) < 35
                                and desc.AbsolutePosition.X > titleLbl.AbsolutePosition.X + 60
                                and txt:lower():find("idle") then
                                    setupDynamicIslandFromStatus(desc, gui)
                                else
                                    -- Dịch thuật sang Tiếng Việt
                                    hookTextForTranslation(desc)
                                end

                            elseif (desc:IsA("ImageLabel") or desc:IsA("ImageButton"))
                            and desc.Name ~= "ChilliV5CoverLogo"
                            and desc.Name ~= "InnerChilliLogo" then
                                if not desc:FindFirstAncestorOfClass("ScrollingFrame") then
                                    -- 3. Đổi Logo nhỏ trên thanh Header (bên trái tiêu đề)
                                    if math.abs(desc.AbsolutePosition.Y - headerY) < 35 and desc.AbsolutePosition.X < titleLbl.AbsolutePosition.X then
                                        if desc.Image ~= CHILLI_LOGO_ID then
                                            desc.Image = CHILLI_LOGO_ID
                                            desc.BackgroundTransparency = 1
                                            desc.ScaleType = Enum.ScaleType.Fit
                                        end

                                    -- 4. Định vị đúng Nút Tròn Nổi bên ngoài Main Window
                                    elseif mainWindow and not desc:IsDescendantOf(mainWindow) then
                                        setupUnclippedCircularLogo(desc)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Chạy kiểm tra nhịp nhàng mỗi 0.5s trong 10 giây đầu (Tuyệt đối không gây lag hay treo máy)
task.spawn(function()
    for _ = 1, 20 do
        pcall(tryPatchVenyx)
        task.wait(0.5)
    end
end)
