-- ==============================================================================
--  CHILLI HUB V2 - AUTO CONFIG & SOFT SKY BLUE (BẢN UNIVERSAL CLICKER 100%)
--  Khắc phục:
--    1. QUÉT ĐA ĐỐI TƯỢNG: Nhận diện chính xác chữ "Import" và "Load" trên cả TextLabel.
--    2. CLICK VẬT LÝ TỌA ĐỘ (VIM): Bấm thẳng vào tâm nút trên màn hình, không trượt.
--    3. TỰ ĐỘNG CHUYỂN ENGLISH: Chuẩn hóa nhãn nút trước khi nạp để tránh lỗi dịch thuật.
--    4. GIỮ NGUYÊN GIAO DIỆN: 3 phần Soft Sky Blue, chữ trắng nổi khối, dịch thuật 100%.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- ==================== DỮ LIỆU CẤU HÌNH JSON (PROFILE: MAIN) ====================
local RAW_CONFIG_JSON = [===[{"Config":{"Profile":"main","Version":2,"States":{"Farm HUD Stealing Position":{"Value":[]},"Quick Panel Collapsed":{"Value":{"1":true}},"Quick Keybinds":{"Value":{"Player > Movement > Speed Boost":"Q"}},"Farm HUD World Position":{"Value":[]},"Farm HUD Stolen Eggs":{"Value":{"History":[{"At":1791691405,"Name":"Salamander Egg","Category":"Salamander","Scale":2.0077867676934826,"Rarity":"Legendary","Value":268694.7970694339},{"At":1791691393,"Name":"Red Panda Egg","Category":"Red Panda","Scale":1.534945088131867,"Rarity":"Mythic","Value":994224.0722744926},{"At":1791691277,"Name":"Crustacia Egg","Category":"Crab","Scale":0.9485398655870736,"Rarity":"Legendary","Value":117895.21822185467},{"At":1791691260,"Name":"Crustacia Egg","Category":"Crab","Scale":0.9492730433116167,"Rarity":"Legendary","Value":118063.85963457519},{"At":1791691246,"Name":"Bladehide Egg","Category":"Blade Head","Scale":0.9936069341113027,"Rarity":"Mythic","Value":741153.7300873696},{"At":1791691231,"Name":"Pterodactyl Egg","Category":"Pterodactyl","Scale":0.9304647986460869,"Rarity":"Legendary","Value":19253.8499877134},{"At":1791691221,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9392414616599657,"Rarity":"Rare","Value":195.91180408490377},{"At":1791691213,"Name":"Pterodactyl Egg","Category":"Pterodactyl","Scale":1.0408297446330186,"Rarity":"Legendary","Value":23690.54852670704},{"At":1791690930,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9503277726641718,"Rarity":"Rare","Value":200.2112653510687},{"At":1791690921,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9709901123134066,"Rarity":"Rare","Value":208.33875983574567},{"At":1791690912,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9877314119821163,"Rarity":"Rare","Value":215.03273659916906},{"At":1791690640,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.8871009623278335,"Rarity":"Rare","Value":176.26773501736077},{"At":1791690631,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.910183959460301,"Rarity":"Rare","Value":184.84668191132057},{"At":1791690624,"Name":"Pterodactyl Egg","Category":"Pterodactyl","Scale":0.9833370835410278,"Rarity":"Legendary","Value":21326.626019822987},{"At":1791690615,"Name":"La Vacca Saturno Saturnita Egg","Category":"La Vacca Saturno Saturnita","Scale":0.9923149280061686,"Rarity":"Cosmic","Value":2168823.9559358234},{"At":1791690381,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9696641788591847,"Rarity":"Rare","Value":249.37529604339495},{"At":1791690369,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":1.4579018948715677,"Rarity":"Rare","Value":441.89596562453337},{"At":1791690362,"Name":"Pterodactyl Egg","Category":"Pterodactyl","Scale":0.990015305361929,"Rarity":"Legendary","Value":21595.348250784464},{"At":1791690321,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":3.8148854983068576,"Rarity":"Rare","Value":2619.1686839768747},{"At":1791690314,"Name":"Pterodactyl Egg","Category":"Pterodactyl","Scale":1.4971519340436624,"Rarity":"Legendary","Value":46415.66220198127}],"Count":188,"Best":{"Category":"King Kong","Name":"Gorilla King Egg","Rarity":"Eternal","Rank":9}}},"Farm HUD Top Eggs Position":{"Value":[]},"Anti Guard Enabled":{"Value":false},"Farm HUD Steal History Position":{"Value":[]},"Quick Pinned Features":{"Value":["Player > Movement > Speed Boost","Player > Movement > Boost Speed"]},"Open On Launch":{"Value":true},"Quick Panel Position":{"Value":{"1":{"Y":0.32634490728378298,"X":0.8134856224060059}}},"Notifications":{"Value":true},"Farm HUD Top Pets Position":{"Value":[]},"Quick Open Key":{"Value":"LeftControl"},"FPS and Ping Position":{"Value":{"XOffset":15,"XScale":0,"YScale":0,"YOffset":19}},"Farm HUD Status Position":{"Value":[]},"Farm HUD Events Position":{"Value":[]},"Steal Panel Open":{"Value":false},"Quick LeftCenter Hidden":{"Value":true},"Farm HUD Economy Position":{"Value":[]},"Quick Pin Groups":{"Value":[]},"Farm HUD Collection Position":{"Value":[]}},"Values":{"Admin Abuse":{"Minigame Eggs":{"Auto Steal Minigame Egg":{"Value":true,"Type":"toggle"}},"Instant Steal V3":{"Instant Steal V3 Note":{"Value":"Needs Admin Treadmill","Type":"text"},"Instant Steal V3":{"Value":false,"Type":"toggle"}},"Admin Treadmill":{"Auto Use Admin Treadmill":{"Value":true,"Type":"toggle"}},"Capture The Egg":{"Hold Height":{"Value":45,"Type":"slider","Unit":"studs"},"Auto Capture Event Egg":{"Value":false,"Type":"toggle"},"Keep Away Distance":{"Value":45,"Type":"slider","Unit":"studs"},"Take It From The Holder":{"Value":true,"Type":"toggle"}}},"Predictor":{"Egg Predictor":{"Sort By":{"Value":"Value","Type":"dropdown"},"Preview Card":{"Value":true,"Type":"toggle"}},"Discord Webhook":{"Webhook URL":{"Value":"","Type":"input"},"Notify Fused Eggs":{"Value":false,"Type":"toggle"},"Notify Stolen Eggs":{"Value":false,"Type":"toggle"},"Webhook Min Rarity":{"Value":"Any","Type":"dropdown"},"Webhook Eggs":{"Value":[],"Type":"multidropdown"},"Webhook Min Value":{"Value":0,"Type":"slider"},"Ping @everyone":{"Value":false,"Type":"toggle"}}},"Progress":{"Auto Progression":{"Auto Buy Trail":{"Value":true,"Type":"toggle"},"Auto Claim Index":{"Value":true,"Type":"toggle"},"Auto Upgrade Treadmill":{"Value":true,"Type":"toggle"},"Auto Claim":{"Value":true,"Type":"toggle"},"Auto Upgrade Base":{"Value":true,"Type":"toggle"}}},"Quick":{"Pin Pad":{"Pad Size":{"Value":150,"Type":"slider","Unit":"%"},"Enable Keybinds":{"Value":true,"Type":"toggle"},"Show Pin Pads":{"Value":true,"Type":"toggle"},"Visible Quick Bars":{"Value":["Quick Bar 1","Quick Bar 2","Quick Bar 3","Quick Bar 4","Quick Bar 5"],"Type":"multidropdown"}}},"Auto Hop":{"Egg Finder":{"Hop Mode":{"Value":"Steal Then Hop","Type":"dropdown"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Rarity To Wait For":{"Value":"Cosmic","Type":"dropdown"},"First Hop Delay":{"Value":5,"Type":"slider","Unit":"s"},"Sync With Auto Steal Filters":{"Value":true,"Type":"toggle"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Min Value To Find":{"Value":700.11,"Type":"slider"},"Auto Hop":{"Value":false,"Type":"toggle"},"Target Areas":{"Value":["Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"}}},"Player":{"ESP":{"ESP Eggs":{"Value":true,"Type":"toggle"},"ESP Show Info":{"Value":["Icon","Name","Value"],"Type":"multidropdown"},"ESP Guard Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Player Info":{"Value":["Name","Tool"],"Type":"multidropdown"},"ESP Other Base Eggs":{"Value":false,"Type":"toggle"},"ESP Min Rarity":{"Value":"7 - Cosmic","Type":"dropdown"},"ESP Guards":{"Value":true,"Type":"toggle"},"Min ESP Value":{"Value":0,"Type":"slider"},"ESP Player Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Players":{"Value":true,"Type":"toggle"},"ESP Own Base Eggs":{"Value":true,"Type":"toggle"},"ESP Fixed Size":{"Value":false,"Type":"toggle"},"ESP Egg Size":{"Value":75,"Type":"slider","Unit":"%"}},"Character":{"Instant Prompts":{"Value":true,"Type":"toggle"},"Anti Ragdoll":{"Value":true,"Type":"toggle"},"Anti Trap":{"Value":true,"Type":"toggle"},"Invisibility":{"Value":false,"Type":"toggle"}},"Movement":{"Speed Boost":{"Value":false,"Type":"toggle"},"Boost Speed":{"Value":1000,"Type":"slider","Unit":"studs/s"},"Infinite Jump":{"Value":false,"Type":"toggle"}},"Combat":{"Auto Hit Egg Holders":{"Value":false,"Type":"toggle"},"Hit Max Speed":{"Value":750,"Type":"slider","Unit":"studs/s"},"Auto Hit Nearest Player":{"Value":false,"Type":"toggle"},"Hit Player":{"Value":"676767kbsoksok","Type":"dropdown"},"Hit Lead":{"Value":-275,"Type":"slider"},"Hit Tween Speed":{"Value":400,"Type":"slider","Unit":"studs/s"},"Hit Sweep":{"Value":60,"Type":"slider","Unit":"%"},"Chase Settings":{"Value":"Chase Settings","Type":"label"},"Auto Hit Specific Player":{"Value":false,"Type":"toggle"},"Hit Aura":{"Value":true,"Type":"toggle"},"Hit Status":{"Value":"Aura ready, nobody in reach","Type":"text"}}},"Settings":{"Interface":{"UI Size":{"Value":100,"Type":"slider","Unit":"%"}}},"Farm":{"Auto Steal":{"Drop Eggs At Safe Zone":{"Value":false,"Type":"toggle"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Biohazard Lab Eggs":{"Value":["Red Panda Egg (43%)","Snowy Owl Egg (40%)","Salamander Egg (38%)"],"Type":"multidropdown"},"Anti Guard Panel":{"Value":false,"Type":"toggle"},"Steal Missing Lab Eggs":{"Value":true,"Type":"toggle"},"Instant Steal Steps":{"Value":2,"Type":"slider"},"Instant Steal Zones":{"Value":["Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"},"Target Areas":{"Value":["Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"},"Unstable DNA Lab Eggs":{"Value":["Toro Egg (24%)","Winged Lamb Egg (23%)","Bladehide Egg (23%)","Imp Egg (22%)","Crustacia Egg (22%)"],"Type":"multidropdown"},"Stock Per Egg":{"Value":3,"Type":"slider","Unit":""},"Auto Steal":{"Value":true,"Type":"toggle"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Teleport To Egg":{"Value":false,"Type":"toggle"},"Carry Speed":{"Value":120,"Type":"slider","Unit":"%"},"Experimental Lab Eggs":{"Value":["Bladehide Egg (34%)","Red Panda Egg (34%)","Crustacia Egg (33%)","Salamander Egg (33%)","Snowy Owl Egg (32%)"],"Type":"multidropdown"},"Fast Delivery":{"Value":true,"Type":"toggle"},"Skip Owned Lab Eggs":{"Value":true,"Type":"toggle"},"Steal Priority":{"Value":"Highest Value","Type":"dropdown"},"Instant Steal V2":{"Value":false,"Type":"toggle"},"Instant Steal":{"Value":true,"Type":"toggle"},"Steal Missing Index Eggs":{"Value":true,"Type":"toggle"},"Min Steal Value":{"Value":700.11,"Type":"slider"},"Tween Speed":{"Value":120,"Type":"slider","Unit":"%"},"Stock Lab Eggs For":{"Value":[],"Type":"multidropdown"}},"Auto Sell":{"Egg Sell Value":{"Value":0,"Type":"slider"},"Sell Egg Rule":{"Value":"Rarity Only","Type":"dropdown"},"Auto Sell Egg":{"Value":false,"Type":"toggle"},"Blacklist Sell Eggs":{"Value":[],"Type":"multidropdown"},"Keep Mutated Eggs":{"Value":true,"Type":"toggle"},"Egg Max Rarity":{"Value":"3 - Rare","Type":"dropdown"},"Blacklist Sell Pets":{"Value":[],"Type":"multidropdown"},"Egg Sell Preview":{"Value":"Egg matches  -  0 eggs for $0","Type":"text"},"Auto Sell Pet":{"Value":true,"Type":"toggle"},"Pet Sell Value":{"Value":777.78,"Type":"slider"},"Pet Sell Preview":{"Value":"Pet matches  -  0 pets for $0","Type":"text"},"Keep Mutated Pets":{"Value":false,"Type":"toggle"},"Sell Pet Rule":{"Value":"Rarity Only","Type":"dropdown"},"Pet Max Rarity":{"Value":"8 - Secret","Type":"dropdown"}},"Auto Fuse Machine":{"Max Rarity to Fuse":{"Value":"6 - Mythic","Type":"dropdown"},"Skip Mutated Pets":{"Value":true,"Type":"toggle"},"Auto Fuse Machine":{"Value":true,"Type":"toggle"},"Specific Species to Fuse":{"Value":[],"Type":"multidropdown"},"Eject Incomplete Slots":{"Value":true,"Type":"toggle"},"Pets To Use":{"Value":"Lowest To Highest","Type":"dropdown"},"Fuse Priority Mode":{"Value":"Lowest Rarity First","Type":"dropdown"},"Fuse Preview":{"Value":"No three matching pets","Type":"text"}},"Auto Favorite":{"Favorite Mutations":{"Value":[],"Type":"multidropdown"},"Favorite Preview":{"Value":"Favorite matches  -  3 pets, 0 to mark  |  23 favorited","Type":"text"},"Favorite Min Rarity":{"Value":"10 - Divine","Type":"dropdown"},"Auto Favorite Equipped":{"Value":true,"Type":"toggle"},"Auto Favorite Pet":{"Value":true,"Type":"toggle"},"Always Favorite Species":{"Value":[],"Type":"multidropdown"},"Min Favorite Value":{"Value":797.34,"Type":"slider"},"Auto Unfavorite Equipped":{"Value":true,"Type":"toggle"},"Favorite Rule":{"Value":"Match All","Type":"dropdown"}},"Auto Treadmill":{"Stay On Treadmill":{"Value":true,"Type":"toggle"},"Auto Treadmill":{"Value":true,"Type":"toggle"}},"Auto Place Egg":{"Place Egg Rule":{"Value":"Always","Type":"dropdown"},"Place Rarities":{"Value":[],"Type":"multidropdown"},"Pen Status":{"Value":"Eggs placed 6/30  -  19/19 pets equipped, 2 in bag","Type":"text"},"Auto Place Egg":{"Value":true,"Type":"toggle"},"Place Egg Order":{"Value":"Highest Value","Type":"dropdown"},"Min Place Value":{"Value":0,"Type":"slider"},"Place Specific Eggs":{"Value":[],"Type":"multidropdown"}},"Wisp Companion":{"Auto Banjo Cricket":{"Value":true,"Type":"toggle"},"Auto Wisp":{"Value":true,"Type":"toggle"},"Wisp Status":{"Value":"Banjo Cricket: Done, Cricket's Banjo is yours","Type":"text"}},"Butterfly Bloom":{"Auto Butterfly Bloom":{"Value":true,"Type":"toggle"},"Trade Up Tiers":{"Value":["Emerald To Sapphire","Sapphire To Amethyst","Amethyst To Radiant"],"Type":"multidropdown"},"Auto Craft Essence":{"Value":true,"Type":"toggle"},"Auto Trade Up":{"Value":true,"Type":"toggle"},"Catch Priority":{"Value":"Rarest","Type":"dropdown"},"Tween Speed  ":{"Value":600,"Type":"slider","Unit":"studs/s"},"Catch Mode":{"Value":"Stand","Type":"dropdown"},"Catch Butterflies":{"Value":["Radiant Butterfly","Amethyst Butterfly","Sapphire Butterfly","Emerald Butterfly"],"Type":"multidropdown"},"Smart Trade For Essence":{"Value":true,"Type":"toggle"}},"Racing Event":{"Race Speed":{"Value":400,"Type":"slider"},"Auto Race":{"Value":true,"Type":"toggle"},"Race Shop Items":{"Value":["Nitro Mutation"],"Type":"multidropdown"},"Auto Equip Racer":{"Value":true,"Type":"toggle"},"Auto Buy Race Shop":{"Value":true,"Type":"toggle"},"Auto Claim Race Rewards":{"Value":true,"Type":"toggle"},"Auto Use Power-Ups":{"Value":true,"Type":"toggle"},"Racer":{"Value":"Best Owned","Type":"dropdown"}},"Auto Mutation":{"Mutate Priority":{"Value":"Highest Value","Type":"dropdown"},"Mutations To Use":{"Value":["Fractured","Scrambled","Enchanted","Nitro"],"Type":"multidropdown"},"Mutate Target Eggs":{"Value":[],"Type":"multidropdown"},"Mutate Min Value":{"Value":797.34,"Type":"slider"},"Auto Mutate":{"Value":true,"Type":"toggle"},"Mutate Status":{"Value":"Waiting  |  No egg to mutate","Type":"text"},"Auto Buy Nitro":{"Value":true,"Type":"toggle"},"Mutate Min Rarity":{"Value":"Secret","Type":"dropdown"}},"Auto Sell Lab Egg":{"Lab Egg Sell Value":{"Value":700.11,"Type":"slider"},"Sell Lab Egg Rule":{"Value":"Rarity And Value","Type":"dropdown"},"Lab Egg Max Rarity":{"Value":"Off","Type":"dropdown"},"Auto Sell Lab Egg":{"Value":true,"Type":"toggle"},"Lab Egg Sell Preview":{"Value":"Lab egg matches  -  0 eggs for $0","Type":"text"},"Keep Lab Pets":{"Value":[],"Type":"multidropdown"},"Keep Mutated Lab Eggs":{"Value":true,"Type":"toggle"}},"Auto Hatch & Equip":{"Hatch Specific Eggs":{"Value":[],"Type":"multidropdown"},"Auto Hatch":{"Value":true,"Type":"toggle"},"Hatch Min Rarity":{"Value":"Any","Type":"dropdown"},"Min Hatch Value":{"Value":0,"Type":"slider"},"Auto Equip Best":{"Value":true,"Type":"toggle"}},"Dr Scramble Lab":{"Lab Banners":{"Value":[],"Type":"multidropdown"},"Lab Status":{"Value":"Experimental Pets  -  needs Salamander, Red Panda, Bladehide  -  pity 67/100  -  free rerolls 0  -  rotates in 55:13  -  Need a Bladehide egg, yours is placed on a nest","Type":"text"},"Auto Place Lab Reward Eggs":{"Value":true,"Type":"toggle"},"Auto Reroll Lab Recipe":{"Value":true,"Type":"toggle"},"Auto Lab Trade-In":{"Value":true,"Type":"toggle"}},"Shooting Star":{"Auto Catch Shooting Star":{"Value":true,"Type":"toggle"},"Shooting Star Status":{"Value":"Waiting for a shooting star","Type":"text"}}},"Misc":{"Performance":{"Optimizer":{"Value":false,"Type":"toggle"},"Farm HUD":{"Value":false,"Type":"toggle"},"Background Color":{"Value":"White","Type":"dropdown"},"Egg Card Image":{"Value":"Egg Image","Type":"dropdown"},"Disable 3D Render":{"Value":false,"Type":"toggle"},"FPS and Ping":{"Value":true,"Type":"toggle"},"FPS Cap":{"Value":240,"Type":"slider","Unit":" FPS"},"HUD Size":{"Value":70,"Type":"slider","Unit":"%"},"Showcase Cards":{"Value":4,"Type":"slider"},"Hide Game UI":{"Value":true,"Type":"toggle"},"HUD Items":{"Value":["Money","Income","Speed","Treadmill","Eggs Stolen","Best Steal","Night Timer","Session Time","Activity","Racing Event","Race Wins","Shooting Star","Pets","Eggs","Top Pets","Top Eggs","Steal History"],"Type":"multidropdown"},"FPS and Ping Size":{"Value":100,"Type":"slider","Unit":"%"}},"Utility":{"Anti AFK":{"Value":true,"Type":"toggle"}}},"Server":{"Server":{"Server Hop Mode":{"Value":"Least Players","Type":"dropdown"},"Auto Load Script":{"Value":true,"Type":"toggle"},"Auto Rejoin When Disconnect":{"Value":true,"Type":"toggle"}}}},"SavedAt":1791691486},"Format":"ChilliLibraryConfig","ExportVersion":1,"Name":"main"}]===]

-- ==================== 1. NẠP SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== 2. HỆ THỐNG DỊCH THUẬT & REBRAND V2 ====================
local currentLanguage = "VI"
local FastCache = {}
local switchGlobalLanguage = nil

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
    ["IDLE"] = "ĐANG CHỜ"
}

local MAP_VI = {
    ["Chilli Hub"] = "Chilli Hub V2",
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Khác",
    ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt & Key",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",
    ["Set Startup Config"] = "Cấu Hình Khởi Động",
    ["Load Config"] = "Tải Cấu Hình",
    ["Save Config"] = "Lưu Cấu Hình",
    ["Import / Export"] = "Nhập / Xuất Cấu Hình",
    ["Export Config"] = "Xuất Cấu Hình",
    ["Import Config Text"] = "Nhập Văn Bản Cấu Hình",
    ["Import Config"] = "Nhập Cấu Hình"
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
    if inst:FindFirstAncestor("Chilli_Liquid_Capsule") or inst:FindFirstAncestor("Chilli_AutoConfig_Btn") then return end
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

-- ==================== 3. LÕI CÔ LẬP ĐỔI MÀU 3 PHẦN SOFT BLUE ====================
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
    if inst:FindFirstAncestor("Chilli_Liquid_Capsule") or inst:FindFirstAncestor("Chilli_AutoConfig_Btn") then return end

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

-- ==================== 4. CƠ CHẾ CLICK TỌA ĐỘ VẬT LÝ VÀ SIGNAL TOÀN DIỆN ====================
local function clickElementDirectly(inst)
    if not inst then return end

    -- 1. Tọa độ tâm trên màn hình (VirtualInputManager tap đúng tâm nút)
    local guiObj = inst:IsA("GuiObject") and inst or inst:FindFirstAncestorWhichIsA("GuiObject")
    if VirtualInputManager and guiObj and guiObj.AbsoluteSize.X > 0 and guiObj.AbsoluteSize.Y > 0 then
        local center = guiObj.AbsolutePosition + guiObj.AbsoluteSize / 2
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 1)
            task.wait(0.04)
            VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 1)
        end)
    end

    -- 2. Kích hoạt firesignal và connections trên cả Label lẫn Container cha
    local targets = {inst}
    if inst.Parent and inst.Parent:IsA("GuiObject") then table.insert(targets, inst.Parent) end
    local btnAncestor = inst:FindFirstAncestorWhichIsA("GuiButton")
    if btnAncestor then table.insert(targets, btnAncestor) end

    for _, obj in ipairs(targets) do
        pcall(function()
            if firesignal then
                firesignal(obj.InputBegan)
                firesignal(obj.MouseButton1Down)
                firesignal(obj.Activated)
                firesignal(obj.MouseButton1Click)
                firesignal(obj.MouseButton1Up)
                firesignal(obj.InputEnded)
            end
        end)
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(obj.InputBegan)) do
                    c:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
                    c:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                end
                task.wait(0.02)
                for _, c in ipairs(getconnections(obj.MouseButton1Click)) do c:Fire() end
                for _, c in ipairs(getconnections(obj.Activated)) do c:Fire() end
                for _, c in ipairs(getconnections(obj.InputEnded)) do
                    c:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.End})
                    c:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.End})
                end
            end
        end)
    end
end

-- ==================== 5. ĐỘNG CƠ TỰ ĐỘNG NẠP CONFIG ĐÃ SỬA LỖI ====================
local isConfigInjecting = false

local function executeAutoConfig(statusCallback)
    if isConfigInjecting then return end
    isConfigInjecting = true

    task.spawn(function()
        statusCallback("⏳ Đang nạp...", Color3.fromRGB(255, 210, 90))

        -- BƯỚC 0: TỰ ĐỘNG CHUYỂN SANG ENGLISH ĐỂ ĐỒNG BỘ TÊN NÚT
        if switchGlobalLanguage then
            switchGlobalLanguage("EN")
            task.wait(0.3)
        end

        local roots = {gethui and gethui(), CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        local chilliGui = nil

        for _, root in ipairs(roots) do
            if root then
                for _, g in ipairs(root:GetChildren()) do
                    if g:IsA("ScreenGui") and g.Name ~= "Chilli_Liquid_Capsule" and g.Name ~= "Chilli_AutoConfig_Btn" then
                        for _, d in ipairs(g:GetDescendants()) do
                            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text:lower():find("chilli hub") then
                                chilliGui = g
                                break
                            end
                        end
                    end
                    if chilliGui then break end
                end
            end
            if chilliGui then break end
        end

        if not chilliGui then
            statusCallback("❌ Ko thấy Hub", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
            isConfigInjecting = false
            return
        end

        -- BƯỚC 1: BẤM TAB "CONFIG"
        local configTabElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:lower():match("^%s*(.-)%s*$") or ""
                if t == "config" or t == "cấu hình" then
                    configTabElement = d
                    break
                end
            end
        end

        if configTabElement then
            clickElementDirectly(configTabElement)
            task.wait(0.35)
        end

        -- BƯỚC 2: TÌM Ô TEXTBOX IMPORT
        local importTextBox = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if d:IsA("TextBox") then
                local ph = (d.PlaceholderText or ""):lower()
                if ph:find("exported config") then
                    importTextBox = d
                    break
                end
            end
        end

        if not importTextBox then
            for _, lbl in ipairs(chilliGui:GetDescendants()) do
                if lbl:IsA("TextLabel") and lbl.Text:find("Import Config Text") then
                    local p = lbl.Parent
                    if p then
                        importTextBox = p:FindFirstChildWhichIsA("TextBox", true)
                        if importTextBox then break end
                    end
                end
            end
        end

        if not importTextBox then
            statusCallback("❌ Ko thấy ô Import", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
            isConfigInjecting = false
            return
        end

        -- BƯỚC 3: BƠM DỮ LIỆU JSON
        importTextBox.Text = RAW_CONFIG_JSON
        task.wait(0.1)

        if getconnections then
            pcall(function()
                for _, conn in ipairs(getconnections(importTextBox.FocusLost)) do
                    conn:Fire(true)
                end
            end)
        end
        task.wait(0.25)

        -- BƯỚC 4: TÌM VÀ CLICK NÚT ĐỎ "Import" (QUÉT CẢ TEXTLABEL VÀ TEXTBUTTON)
        local importBtnElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                if t == "Import" or t == "Nhập" then
                    importBtnElement = d
                    break
                end
            end
        end

        if not importBtnElement then
            statusCallback("❌ Ko thấy nút Import", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
            isConfigInjecting = false
            return
        end

        clickElementDirectly(importBtnElement)
        task.wait(0.9) -- Chờ xuất hiện toast "Config Imported"

        -- BƯỚC 5: MỞ DROPDOWN "Load Config"
        local loadDropdownElement = nil
        for _, lbl in ipairs(chilliGui:GetDescendants()) do
            if lbl:IsA("TextLabel") and (lbl.Text:find("Load Config") or lbl.Text:find("Tải Cấu Hình")) then
                local row = lbl.Parent
                if row then
                    loadDropdownElement = row:FindFirstChildWhichIsA("GuiButton", true)
                    if not loadDropdownElement then
                        for _, c in ipairs(row:GetDescendants()) do
                            if (c:IsA("TextLabel") or c:IsA("TextButton")) and c.Text:find("Default") then
                                loadDropdownElement = c
                                break
                            end
                        end
                    end
                end
                break
            end
        end

        if loadDropdownElement then
            clickElementDirectly(loadDropdownElement)
            task.wait(0.35)
        end

        -- BƯỚC 6: CHỌN MỤC "main" (CHỜ TỐI ĐA 4 GIÂY)
        local mainProfileElement = nil
        local t0 = tick()
        while tick() - t0 < 4 do
            for _, d in ipairs(chilliGui:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                    local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                    if t:lower() == "main" then
                        mainProfileElement = d
                        break
                    end
                end
            end
            if mainProfileElement then break end
            task.wait(0.12)
        end

        if not mainProfileElement then
            statusCallback("❌ Ko có profile main", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
            isConfigInjecting = false
            return
        end

        clickElementDirectly(mainProfileElement)
        task.wait(0.35)

        -- BƯỚC 7: CLICK NÚT ĐỎ "Load"
        local loadBtnElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                if t == "Load" or t == "Tải" then
                    loadBtnElement = d
                    break
                end
            end
        end

        if not loadBtnElement then
            statusCallback("❌ Ko thấy nút Load", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
            isConfigInjecting = false
            return
        end

        clickElementDirectly(loadBtnElement)
        task.wait(0.4)

        -- HOÀN TẤT THÀNH CÔNG
        statusCallback("✔ ĐÃ NẠP XONG!", Color3.fromRGB(110, 245, 140))
        task.wait(2.2)
        statusCallback("⚡ NẠP CONFIG", Color3.fromRGB(255, 255, 255))
        isConfigInjecting = false
    end)
end

-- ==================== 6. NÚT NẠP CONFIG CYBER GLASS (TOP-CENTER PHẢI) ====================
local function createAutoConfigButtonUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_AutoConfig_Btn")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_AutoConfig_Btn"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Capsule = Instance.new("Frame")
    Capsule.Name = "Capsule"
    Capsule.Size = UDim2.new(0, 145, 0, 36)
    Capsule.AnchorPoint = Vector2.new(0, 0)
    Capsule.Position = UDim2.new(0.5, 96, 0, 12)
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

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Name = "ActionBtn"
    ActionBtn.Size = UDim2.new(1, -6, 1, -6)
    ActionBtn.Position = UDim2.new(0, 3, 0, 3)
    ActionBtn.BackgroundColor3 = COLOR_FACE_BOTTOM
    ActionBtn.BorderSizePixel = 0
    ActionBtn.Text = "⚡ NẠP CONFIG"
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.TextSize = 11
    ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActionBtn.Parent = Capsule

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = ActionBtn

    local BtnGradient = Instance.new("UIGradient")
    BtnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    BtnGradient.Rotation = 90
    BtnGradient.Parent = ActionBtn

    local function updateStatus(txt, col)
        ActionBtn.Text = txt
        TweenService:Create(ActionBtn, TweenInfo.new(0.18), {TextColor3 = col}):Play()
    end

    ActionBtn.MouseButton1Click:Connect(function()
        if isConfigInjecting then return end
        TweenService:Create(Capsule, TweenInfo.new(0.08), {Size = UDim2.new(0, 140, 0, 34)}):Play()
        task.delay(0.08, function()
            TweenService:Create(Capsule, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 145, 0, 36)}):Play()
        end)
        executeAutoConfig(updateStatus)
    end)

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
            local maxX = cam and cam.ViewportSize.X - 150 or 800
            local maxY = cam and cam.ViewportSize.Y - 45 or 600

            local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)

            Capsule.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

-- ==================== 7. NÚT ĐỔI NGÔN NGỮ LIQUID CYBER (TOP-CENTER TRÁI) ====================
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
    Capsule.AnchorPoint = Vector2.new(1, 0)
    Capsule.Position = UDim2.new(0.5, 86, 0, 12)
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

    switchGlobalLanguage = switchMode

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

-- ==================== 8. KHỞI TẠO TIẾN TRÌNH ====================
task.delay(2.5, function()
    createLiquidCapsuleUI()
    createAutoConfigButtonUI()

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
