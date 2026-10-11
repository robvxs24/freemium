-- ==============================================================================
--  CHILLI HUB V2 - PURE CLEAN & SAFE EDITION (ANTI-BAC ISOLATION)
--  Mục tiêu kiểm chứng:
--    1. GỠ BỎ 100% VIRTUALINPUTMANAGER & FIRESIGNAL: Triệt tiêu mã lỗi BAC-55110.
--    2. SAFE-BOOT GUARD: Đợi game load và nhân vật spawn hoàn tất né BAC-8512.
--    3. SOFT SKY BLUE RESKIN: Đúng 3 phần (Header, 7 tab trái, 5 tab phải gồm Admin Abuse).
--    4. DỊCH THUẬT 100%: Toàn diện Farm, Racing, Mech, Lab, Predictor, ESP, Combat.
--    5. LIQUID CYBER CAPSULE: Giữ nguyên thanh chuyển ngữ Tiếng Việt / English mượt mà.
-- ==============================================================================

-- ==================== 1. BẢO VỆ KHỞI ĐỘNG (SAFE-BOOT GUARD) ====================
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    LocalPlayer.CharacterAdded:Wait()
    repeat task.wait(0.2) until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

-- Nghỉ đệm 3 giây để game gửi gói Handshake xác thực hoàn tất lên Server
task.wait(3)

-- ==================== 2. TẢI SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ==================== 3. TỪ ĐIỂN DỊCH THUẬT TOÀN DIỆN 100% ====================
local currentLanguage = "VI"
local FastCache = {}

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

local EXACT_MATCH_VI = {
    ["Chilli Hub"] = "Chilli Hub V2",
    ["Hop"] = "Đổi Server",
    ["Join"] = "Vào Phòng",
    ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại",
    ["Add"] = "Thêm",
    ["Sell"] = "Bán",
    ["Favorite"] = "Khóa",
    ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI",
    ["All"] = "Tất cả",
    ["ALL"] = "TẤT CẢ",
    ["Any"] = "Tất cả",
    ["None"] = "Không có",
    ["Off"] = "Tắt",
    ["OFF"] = "TẮT",
    ["On"] = "Bật",
    ["ON"] = "BẬT",
    ["Idle"] = "Đang chờ",
    ["IDLE"] = "ĐANG CHỜ",
    ["Stand"] = "Đứng yên",
    ["Chase"] = "Đuổi theo",
    ["Circle"] = "Xoay vòng",
    ["Patrol"] = "Tuần tra",
    ["Rarest"] = "Hiếm nhất",
    ["Nearest"] = "Gần nhất",
    ["Always"] = "Luôn luôn",
    ["Value"] = "Giá trị",
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)",
    ["Rare"] = "Hiếm (Rare)",
    ["Uncommon"] = "Thường (Uncommon)",
    ["Common"] = "Phổ Thông (Common)",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Least Players"] = "Ít người chơi nhất",
    ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm",
    ["Rarity And Value"] = "Độ hiếm & Giá trị",
    ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước",
    ["Lowest To Highest"] = "Từ thấp đến cao",
    ["Match All"] = "Khớp tất cả",
    ["Match Any"] = "Khớp bất kỳ",
    ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất",
    ["3 - Rare"] = "3 - Hiếm (Rare)",
    ["6 - Mythic"] = "6 - Thần Thoại (Mythic)",
    ["8 - Secret"] = "8 - Bí Ẩn (Secret)",
    ["10 - Divine"] = "10 - Thánh Thần (Divine)",
    ["EGGS"] = "TRỨNG",
    ["READY"] = "SẴN SÀNG",
    ["GROWING"] = "ĐANG LỚN",
    ["IN BAG"] = "TRONG TÚI",
    ["TOTAL / S"] = "TỔNG / GIÂY"
}

local MAP_VI = {
    ["Chilli Hub"] = "Chilli Hub V2",
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Khác",
    ["Auto Hop"] = "Tự Đổi Máy Chủ",
    ["Admin Abuse"] = "Menu Admin (Abuse)",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt & Key",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...",
    ["Search"] = "Tìm kiếm",

    ["Racing Event"] = "Sự Kiện Đua Xe",
    ["Shooting Star"] = "Sao Băng Rơi",
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble",
    ["Dr Scramble Lab"] = "Phòng Lab Dr. Scramble",
    ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp",
    ["Auto Steal"] = "Tự Động Cướp Trứng",
    ["Auto Mutation"] = "Tự Động Đột Biến",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Auto Treadmill"] = "Tự Động Máy Tập",
    ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị",
    ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Auto Sell Pet"] = "Tự Động Bán Pet",
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet",
    ["Auto Favorite"] = "Tự Động Khóa Pet",

    ["Race Speed"] = "Tốc Độ Đua",
    ["Auto Race"] = "Tự Động Đua Xe",
    ["Race Shop Items"] = "Vật Phẩm Shop Đua",
    ["Nitro Mutation"] = "Đột Biến Nitro",
    ["Auto Equip Racer"] = "Tự Trang Bị Xe Tốt Nhất",
    ["Auto Buy Race Shop"] = "Tự Mua Shop Đua Xe",
    ["Auto Claim Race Rewards"] = "Tự Nhận Thưởng Đua Xe",
    ["Auto Use Power-Ups"] = "Tự Dùng Đạo Cụ Tăng Tốc",
    ["Racer"] = "Tay Đua",
    ["Best Owned"] = "Tốt Nhất Đang Có",
    ["Auto Catch Shooting Star"] = "Tự Động Bắt Sao Băng",
    ["Shooting Star Status"] = "Trạng Thái Sao Băng",
    ["Waiting for a shooting star"] = "Đang chờ sao băng rơi",

    ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Rarity"] = "Độ Hiếm Min",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Steal Value"] = "Giá Trị Cướp Min",
    ["Target Specific Eggs"] = "Mục Tiêu Trứng Chỉ Định",
    ["Only steal these eggs (empty = all)"] = "Chỉ cướp các trứng này (trống = tất cả)",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu",
    ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp trứng thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Carry Speed"] = "Tốc Độ Bê Trứng",
    ["Anti Guard Panel"] = "Bảng Điều Khiển Anti Vệ Sĩ",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Vận chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc",
    ["Higher is safer but takes longer"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",

    ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng",
    ["Only place eggs of the picked rarities (empty = all)"] = "Chỉ đặt trứng thuộc độ hiếm đã chọn (trống = tất cả)",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Đặt",
    ["Only place these eggs (empty = all)"] = "Chỉ đặt các loại trứng này (trống = tất cả)",
    ["Min Place Value"] = "Giá Trị Đặt Min",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá nhỏ hơn mức này (0 = tắt)",
    ["Stay On Treadmill"] = "Luôn Ở Trên Máy Tập",

    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "Ấp trứng từ độ hiếm đã chọn trở lên",
    ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Ấp",
    ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Equip Best when a better pet appears"] = "Tự trang bị khi xuất hiện pet mạnh hơn",

    ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell matching pets once"] = "Bán một lần các pet khớp điều kiện",
    ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Pet Max Rarity"] = "Độ Hiếm Bán Pet Max",
    ["Sell pets at or below this rarity"] = "Bán pet từ độ hiếm này trở xuống",
    ["Pet Sell Value"] = "Giá Trị Bán Pet",
    ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi khớp quy tắc dưới",
    ["Sell Eggs Now"] = "Bán Trứng Ngay",
    ["Sell matching eggs once"] = "Bán một lần các trứng khớp điều kiện",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Bán Trứng Max",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng",
    ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng",

    ["Set Startup Config"] = "Cấu Hình Khởi Động",
    ["Load Config"] = "Tải Cấu Hình",
    ["Save Config"] = "Lưu Cấu Hình",
    ["Import / Export"] = "Nhập / Xuất Cấu Hình",
    ["Export Config"] = "Xuất Cấu Hình",
    ["Import Config Text"] = "Nhập Văn Bản Cấu Hình",
    ["Import Config"] = "Nhập Cấu Hình",
    ["Pick a config, then press Load to apply it now"] = "Chọn một cấu hình, sau đó bấm Tải để áp dụng ngay",

    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D",
    ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",
    ["selected"] = "đã chọn"
}

local DYNAMIC_PATTERNS = {
    { pattern = "ALL (%d+)", format = function(l, c) return l == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end },
    { pattern = "READY (%d+)", format = function(l, c) return l == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end },
    { pattern = "GROWING (%d+)", format = function(l, c) return l == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end },
    { pattern = "IN BAG (%d+)", format = function(l, c) return l == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end },
    { pattern = "Ends in (%d+h %d+m %d+s)", format = function(l, t) return l == "VI" and ("Kết thúc sau " .. t) or ("Ends in " .. t) end },
    { pattern = "Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag", format = function(l, p1, p2, p3, p4, p5)
        return l == "VI" and string.format("Trứng đã đặt %s/%s - %s/%s pet trang bị, %s trong túi", p1, p2, p3, p4, p5) or string.format("Eggs placed %s/%s - %s/%s pets equipped, %s in bag", p1, p2, p3, p4, p5)
    end },
    { pattern = "Pet matches %- (%d+) pets? for %$(.+)", format = function(l, c, v)
        return l == "VI" and string.format("Khớp pet - %s pet giá $%s", c, v) or string.format("Pet matches - %s pets for $%s", c, v)
    end },
    { pattern = "Egg matches %- (%d+) eggs? for %$(.+)", format = function(l, c, v)
        return l == "VI" and string.format("Khớp trứng - %s trứng giá $%s", c, v) or string.format("Egg matches - %s eggs for $%s", c, v)
    end },
    { pattern = "Lab egg matches %- (%d+) eggs? for %$(.+)", format = function(l, c, v)
        return l == "VI" and string.format("Khớp trứng Lab - %s trứng giá $%s", c, v) or string.format("Lab egg matches - %s eggs for $%s", c, v)
    end }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        local res = replaceAll(raw, "Chilli Hub", "Chilli Hub V2")
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
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        if result:find(item.pattern) then
            result = result:gsub(item.pattern, function(...)
                return item.format(currentLanguage, ...)
            end)
        end
    end

    for _, item in ipairs(SortedVI) do
        if result:find(item.en, 1, true) then
            result = replaceAll(result, item.en, item.out)
        end
    end

    FastCache[cacheKey] = result
    return result
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Liquid_Capsule") then return end
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
    inst:SetAttribute("HasTranslateHook", true)

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

-- ==================== 4. LÕI CÔ LẬP ĐỔI MÀU 3 PHẦN SOFT SKY BLUE ====================
local COLOR_FACE_TOP     = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM  = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW = Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["cày cuốc"] = true, ["farm"] = true,
    ["người chơi"] = true, ["player"] = true,
    ["dự đoán"] = true, ["predictor"] = true,
    ["tiến trình"] = true, ["progress"] = true,
    ["máy chủ"] = true, ["server"] = true,
    ["khác"] = true, ["misc"] = true,
    ["tự đổi máy chủ"] = true, ["tự đổi server"] = true, ["auto hop"] = true,
    ["admin abuse"] = true, ["menu admin (abuse)"] = true,
    ["discord"] = true,
    ["phím tắt & key"] = true, ["quick & keys"] = true,
    ["cài đặt"] = true, ["settings"] = true,
    ["cấu hình"] = true, ["config"] = true
}

local function recolorSingleButton(btnContainer, labelObj)
    if not btnContainer then return end
    
    local grad = btnContainer:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = btnContainer
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
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

local function recolorHeaderBar(headerFrame, titleObj)
    if not headerFrame then return end
    local grad = headerFrame:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = headerFrame
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    headerFrame.BackgroundColor3 = COLOR_FACE_BOTTOM

    if headerFrame.Parent and headerFrame.Parent:IsA("Frame") then
        local p = headerFrame.Parent
        if p.BackgroundColor3.R > 0.4 and p.BackgroundColor3.G < 0.35 then
            p.BackgroundColor3 = COLOR_BEVEL_SHADOW
        end
    end

    if titleObj and (titleObj:IsA("TextLabel") or titleObj:IsA("TextButton")) then
        titleObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    for _, item in ipairs(headerFrame:GetDescendants()) do
        if item:IsA("TextButton") or item:IsA("ImageButton") then
            item.BackgroundColor3 = COLOR_FACE_BOTTOM
            local xGrad = item:FindFirstChildOfClass("UIGradient")
            if xGrad then
                xGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
                    ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
                })
            end
            if item:IsA("TextButton") then
                item.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end

local function inspectAndApplySoftBlue(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("Chilli_Liquid_Capsule") then return end

    local textRaw = inst.Text:lower():match("^%s*(.-)%s*$") or ""
    if textRaw:find("chilli hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then recolorHeaderBar(headerFrame, inst) end
        return
    end

    if TARGET_BUTTON_KEYWORDS[textRaw] then
        local btnTarget = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton") or inst:FindFirstAncestorOfClass("Frame")
        if btnTarget then recolorSingleButton(btnTarget, inst) end
        return
    end
end

-- ==================== 5. NÚT ĐỔI NGÔN NGỮ LIQUID CYBER (TOP-CENTER) ====================
local function createLiquidCapsuleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_Liquid_Capsule")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Liquid_Capsule"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Capsule = Instance.new("Frame")
    Capsule.Name = "Capsule"
    Capsule.Size = UDim2.new(0, 176, 0, 36)
    Capsule.AnchorPoint = Vector2.new(0.5, 0)
    Capsule.Position = UDim2.new(0.5, 0, 0, 12)
    Capsule.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
    Capsule.BackgroundTransparency = 0.15
    Capsule.BorderSizePixel = 0
    Capsule.Parent = ScreenGui

    local CapsuleCorner = Instance.new("UICorner")
    CapsuleCorner.CornerRadius = UDim.new(1, 0)
    CapsuleCorner.Parent = Capsule

    local CapsuleStroke = Instance.new("UIStroke")
    CapsuleStroke.Thickness = 1.4
    CapsuleStroke.Color = COLOR_FACE_TOP
    CapsuleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    CapsuleStroke.Parent = Capsule

    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Size = UDim2.new(0, 84, 0, 28)
    Slider.Position = UDim2.new(0, 4, 0.5, -14)
    Slider.BackgroundColor3 = COLOR_FACE_BOTTOM
    Slider.BorderSizePixel = 0
    Slider.Parent = Capsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = Slider

    local SliderGradient = Instance.new("UIGradient")
    SliderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    SliderGradient.Rotation = 90
    SliderGradient.Parent = Slider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Name = "BtnVI"
    BtnVI.Size = UDim2.new(0, 84, 1, 0)
    BtnVI.Position = UDim2.new(0, 4, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 TIẾNG VIỆT"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = Capsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Name = "BtnEN"
    BtnEN.Size = UDim2.new(0, 84, 1, 0)
    BtnEN.Position = UDim2.new(1, -88, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(145, 160, 185)
    BtnEN.ZIndex = 5
    BtnEN.Parent = Capsule

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target

        TweenService:Create(Capsule, TweenInfo.new(0.08), {Size = UDim2.new(0, 170, 0, 34)}):Play()
        task.delay(0.08, function()
            TweenService:Create(Capsule, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 176, 0, 36)}):Play()
        end)

        if target == "VI" then
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 4, 0.5, -14),
                BackgroundColor3 = COLOR_FACE_BOTTOM
            }):Play()
            TweenService:Create(CapsuleStroke, TweenInfo.new(0.3), {Color = COLOR_FACE_TOP}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        else
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -88, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(55, 70, 95)
            }):Play()
            TweenService:Create(CapsuleStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(90, 120, 165)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        end

        updateAllActive()
    end

    BtnVI.MouseButton1Click:Connect(function() switchMode("VI") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)

    local dragging, dragStart, startPos = false, nil, nil
    Capsule.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Capsule.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    Capsule.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            local cam = workspace.CurrentCamera
            local maxX = cam and cam.ViewportSize.X - 180 or 800
            local maxY = cam and cam.ViewportSize.Y - 45 or 600

            local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)

            Capsule.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

-- ==================== 6. KHỞI TẠO TIẾN TRÌNH & THEME SCANNER ====================
task.delay(1.5, function()
    createLiquidCapsuleUI()

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
                inspectAndApplySoftBlue(desc)
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
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
                        inspectAndApplySoftBlue(desc)
                    end
                end)
            end)
        end
    end
end)
