-- ==============================================================================
--  CHILLI HUB V2 - DYNAMIC ISLAND V_FINAL (SAFE VISUAL MACRO)
--  Tối ưu hóa:
--    1. CLICK AN TOÀN: Thêm cơ chế chờ và thử lại, đảm bảo 100% click trúng nút.
--    2. KHÔNG CAN THIỆP SÂU: Chỉ đơn giản là giả lập thao tác tay, cực kỳ an toàn.
--    3. 100% OBFUSCATE PROOF: Code tĩnh hoàn toàn, không lỗi khi mã hóa.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat task.wait() until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
end

local function getSafeGuiContainer()
    local container = nil
    pcall(function() if gethui then container = gethui() end end)
    if container then return container end
    pcall(function() if CoreGui and pcall(function() return CoreGui:GetChildren() end) then container = CoreGui end end)
    if container then return container end
    pcall(function() container = LocalPlayer:WaitForChild("PlayerGui", 5) end)
    return container
end

-- ==================== CHUỖI JSON CONFIG CỦA NGƯỜI DÙNG ====================
local AUTO_FARM_JSON = [=[
{"Profile":"auto farm","Version":2,"Values":{"Misc":{"Performance":{"FPS Cap":{"Value":240,"Type":"slider","Unit":" FPS"},"Farm HUD":{"Value":false,"Type":"toggle"},"Background Color":{"Value":"White","Type":"dropdown"},"Egg Card Image":{"Value":"Egg Image","Type":"dropdown"},"Disable 3D Render":{"Value":false,"Type":"toggle"},"FPS and Ping":{"Value":true,"Type":"toggle"},"Optimizer":{"Value":false,"Type":"toggle"},"HUD Size":{"Value":70,"Type":"slider","Unit":"%"},"Showcase Cards":{"Value":4,"Type":"slider"},"Hide Game UI":{"Value":true,"Type":"toggle"},"HUD Items":{"Value":["Money","Income","Speed","Treadmill","Eggs Stolen","Best Steal","Night Timer","Session Time","Activity","Mech Portal","Boss Mastery","Samples","Mech Fights","Lab","Pets","Eggs","Top Pets","Top Eggs","Steal History"],"Type":"multidropdown"},"FPS and Ping Size":{"Value":100,"Type":"slider","Unit":"%"}},"Utility":{"Anti AFK":{"Value":true,"Type":"toggle"}}},"Predictor":{"Egg Predictor":{"Sort By":{"Value":"Value","Type":"dropdown"},"Preview Card":{"Value":true,"Type":"toggle"}},"Discord Webhook":{"Webhook URL":{"Value":"","Type":"input"},"Notify Fused Eggs":{"Value":false,"Type":"toggle"},"Notify Stolen Eggs":{"Value":false,"Type":"toggle"},"Webhook Eggs":{"Value":[],"Type":"multidropdown"},"Webhook Min Rarity":{"Value":"Any","Type":"dropdown"},"Webhook Min Value":{"Value":0,"Type":"slider"},"Ping @everyone":{"Value":false,"Type":"toggle"}}},"Progress":{"Auto Progression":{"Auto Buy Trail":{"Value":false,"Type":"toggle"},"Auto Claim Index":{"Value":false,"Type":"toggle"},"Auto Upgrade Treadmill":{"Value":false,"Type":"toggle"},"Auto Claim":{"Value":false,"Type":"toggle"},"Auto Upgrade Base":{"Value":false,"Type":"toggle"}}},"Quick":{"Pin Pad":{"Pad Size":{"Value":150,"Type":"slider","Unit":"%"},"Enable Keybinds":{"Value":true,"Type":"toggle"},"Show Pin Pads":{"Value":true,"Type":"toggle"},"Visible Quick Bars":{"Value":["Quick Bar 1","Quick Bar 2","Quick Bar 3","Quick Bar 4","Quick Bar 5"],"Type":"multidropdown"}}},"Auto Hop":{"Egg Finder":{"Hop Mode":{"Value":"Steal Then Hop","Type":"dropdown"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Rarity To Wait For":{"Value":"Cosmic","Type":"dropdown"},"First Hop Delay":{"Value":5,"Type":"slider","Unit":"s"},"Auto Hop":{"Value":false,"Type":"toggle"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Sync With Auto Steal Filters":{"Value":true,"Type":"toggle"},"Min Value To Find":{"Value":0,"Type":"slider"},"Target Areas":{"Value":["Forest","Desert","Snow","Lake","Jungle","Volcano","Prehistoric","Cosmic","Abyss Ocean","Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"}}},"Player":{"ESP":{"ESP Eggs":{"Value":false,"Type":"toggle"},"ESP Player Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Show Info":{"Value":["Icon","Name","Value"],"Type":"multidropdown"},"ESP Guard Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Player Info":{"Value":["Name","Tool"],"Type":"multidropdown"},"ESP Other Base Eggs":{"Value":false,"Type":"toggle"},"ESP Min Rarity":{"Value":"Any","Type":"dropdown"},"ESP Guards":{"Value":false,"Type":"toggle"},"Min ESP Value":{"Value":0,"Type":"slider"},"ESP Lost Parts":{"Value":false,"Type":"toggle"},"ESP Players":{"Value":false,"Type":"toggle"},"ESP Own Base Eggs":{"Value":true,"Type":"toggle"},"ESP Fixed Size":{"Value":false,"Type":"toggle"},"ESP Egg Size":{"Value":75,"Type":"slider","Unit":"%"}},"Character":{"Instant Prompts":{"Value":true,"Type":"toggle"},"Anti Ragdoll":{"Value":true,"Type":"toggle"},"Anti Trap":{"Value":true,"Type":"toggle"},"Invisibility":{"Value":false,"Type":"toggle"}},"Movement":{"Speed Boost":{"Value":false,"Type":"toggle"},"Boost Speed":{"Value":1000,"Type":"slider","Unit":"studs/s"},"Infinite Jump":{"Value":true,"Type":"toggle"}},"Combat":{"Auto Hit Egg Holders":{"Value":false,"Type":"toggle"},"Hit Max Speed":{"Value":750,"Type":"slider","Unit":"studs/s"},"Auto Hit Nearest Player":{"Value":false,"Type":"toggle"},"Hit Sweep":{"Value":250,"Type":"slider","Unit":"%"},"Hit Player":{"Value":"ayainayyaa","Type":"dropdown"},"Hit Tween Speed":{"Value":400,"Type":"slider","Unit":"studs/s"},"Hit Lead":{"Value":100,"Type":"slider"},"Chase Settings":{"Value":"Chase Settings","Type":"label"},"Auto Hit Specific Player":{"Value":false,"Type":"toggle"},"Hit Aura":{"Value":false,"Type":"toggle"},"Hit Status":{"Value":"Idle","Type":"text"}}},"Settings":{"Interface":{"UI Size":{"Value":100,"Type":"slider","Unit":"%"}}},"Farm":{"Auto Steal":{"Drop Eggs At Safe Zone":{"Value":false,"Type":"toggle"},"Anti Guard Panel":{"Value":true,"Type":"toggle"},"Carry Speed":{"Value":120,"Type":"slider","Unit":"%"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Steal Missing Lab Eggs":{"Value":false,"Type":"toggle"},"Instant Steal Steps":{"Value":1,"Type":"slider"},"Stock Lab Eggs For":{"Value":[],"Type":"multidropdown"},"Target Areas":{"Value":["Forest","Desert","Snow","Lake","Jungle","Volcano","Prehistoric","Cosmic","Abyss Ocean","Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"},"Unstable DNA Lab Eggs":{"Value":["Toro Egg (24%)","Winged Lamb Egg (23%)","Bladehide Egg (23%)","Imp Egg (22%)","Crustacia Egg (22%)"],"Type":"multidropdown"},"Steal Priority":{"Value":"Highest Value","Type":"dropdown"},"Auto Steal":{"Value":true,"Type":"toggle"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Teleport To Egg":{"Value":true,"Type":"toggle"},"Stock Per Egg":{"Value":3,"Type":"slider","Unit":""},"Experimental Lab Eggs":{"Value":[],"Type":"multidropdown"},"Fast Delivery":{"Value":false,"Type":"toggle"},"Skip Owned Lab Eggs":{"Value":true,"Type":"toggle"},"Biohazard Lab Eggs":{"Value":[],"Type":"multidropdown"},"Instant Steal V2":{"Value":true,"Type":"toggle"},"Instant Steal":{"Value":false,"Type":"toggle"},"Steal Missing Index Eggs":{"Value":false,"Type":"toggle"},"Instant Steal Zones":{"Value":["Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"},"Tween Speed":{"Value":120,"Type":"slider","Unit":"%"},"Min Steal Value":{"Value":0,"Type":"slider"}},"Auto Treadmill":{"Stay On Treadmill":{"Value":true,"Type":"toggle"},"Auto Treadmill":{"Value":true,"Type":"toggle"}},"Dr Scramble Lab & Mech":{"Swap Two Weapons":{"Value":true,"Type":"toggle"},"Auto Lab Trade-In":{"Value":false,"Type":"toggle"},"Keep Hopping For":{"Value":3,"Type":"slider","Unit":"min"},"Boss Server Hop":{"Value":false,"Type":"toggle"},"Auto Claim Mastery":{"Value":false,"Type":"toggle"},"Auto Buy Scramble Shop":{"Value":false,"Type":"toggle"},"Scrambler Hold":{"Value":0.4,"Type":"slider","Unit":"s"},"Scramble Shop Items":{"Value":[],"Type":"multidropdown"},"Auto Mech Boss":{"Value":false,"Type":"toggle"},"Auto Reroll Lab Recipe":{"Value":false,"Type":"toggle"},"Lab Banners":{"Value":[],"Type":"multidropdown"},"Auto Place Lab Reward Eggs":{"Value":false,"Type":"toggle"},"Mech Tween Speed":{"Value":250,"Type":"slider","Unit":"studs/s"},"Lab Status":{"Value":"Experimental Pets  -  needs Cosmic Gecko, Bladehide, Snowy Owl  -  pity 0/100  -  free rerolls 2  -  rotates in 2:56","Type":"text"},"Main Weapon Hold":{"Value":0.3,"Type":"slider","Unit":"s"},"Mech Status":{"Value":"Off  |  Next Mech portal in 2:57","Type":"text"},"Keep Samples":{"Value":0,"Type":"slider","Unit":""}},"Auto Sell":{"Egg Sell Value":{"Value":0,"Type":"slider"},"Egg Sell Preview":{"Value":"Egg matches  -  0 eggs for $0","Type":"text"},"Auto Sell Egg":{"Value":false,"Type":"toggle"},"Blacklist Sell Eggs":{"Value":[],"Type":"multidropdown"},"Keep Mutated Eggs":{"Value":true,"Type":"toggle"},"Egg Max Rarity":{"Value":"3 - Rare","Type":"dropdown"},"Blacklist Sell Pets":{"Value":[],"Type":"multidropdown"},"Sell Egg Rule":{"Value":"Rarity Only","Type":"dropdown"},"Auto Sell Pet":{"Value":false,"Type":"toggle"},"Pet Sell Value":{"Value":0,"Type":"slider"},"Pet Sell Preview":{"Value":"Pet matches  -  0 pets for $0","Type":"text"},"Keep Mutated Pets":{"Value":true,"Type":"toggle"},"Sell Pet Rule":{"Value":"Rarity Only","Type":"dropdown"},"Pet Max Rarity":{"Value":"3 - Rare","Type":"dropdown"}},"Wisp Companion":{"Auto Banjo Cricket":{"Value":false,"Type":"toggle"},"Auto Wisp":{"Value":false,"Type":"toggle"},"Wisp Status":{"Value":"Off","Type":"text"}},"Auto Place Egg":{"Place Egg Rule":{"Value":"Always","Type":"dropdown"},"Auto Place Egg":{"Value":false,"Type":"toggle"},"Pen Status":{"Value":"Eggs placed 6/30  -  19/19 pets equipped, 87 in bag","Type":"text"},"Place Rarities":{"Value":[],"Type":"multidropdown"},"Place Egg Order":{"Value":"Highest Value","Type":"dropdown"},"Min Place Value":{"Value":0,"Type":"slider"},"Place Specific Eggs":{"Value":[],"Type":"multidropdown"}},"Auto Fuse Machine":{"Max Rarity to Fuse":{"Value":"6 - Mythic","Type":"dropdown"},"Skip Mutated Pets":{"Value":true,"Type":"toggle"},"Auto Fuse Machine":{"Value":false,"Type":"toggle"},"Eject Incomplete Slots":{"Value":true,"Type":"toggle"},"Specific Species to Fuse":{"Value":[],"Type":"multidropdown"},"Pets To Use":{"Value":"Lowest To Highest","Type":"dropdown"},"Fuse Priority Mode":{"Value":"Lowest Rarity First","Type":"dropdown"},"Fuse Preview":{"Value":"No three matching pets","Type":"text"}},"Auto Mutation":{"Mutate Target Eggs":{"Value":["Amethyst Runebear [Secret]"],"Type":"multidropdown"},"Mutations To Use":{"Value":["Fractured","Scrambled","Enchanted"],"Type":"multidropdown"},"Mutate Priority":{"Value":"Highest Value","Type":"dropdown"},"Auto Buy Scrambled":{"Value":false,"Type":"toggle"},"Auto Mutate":{"Value":false,"Type":"toggle"},"Mutate Status":{"Value":"Off","Type":"text"},"Mutate Min Value":{"Value":0,"Type":"slider"},"Mutate Min Rarity":{"Value":"Any","Type":"dropdown"}},"Auto Sell Lab Egg":{"Lab Egg Sell Value":{"Value":0,"Type":"slider"},"Sell Lab Egg Rule":{"Value":"Rarity And Value","Type":"dropdown"},"Lab Egg Max Rarity":{"Value":"Off","Type":"dropdown"},"Auto Sell Lab Egg":{"Value":false,"Type":"toggle"},"Lab Egg Sell Preview":{"Value":"Lab egg matches  -  0 eggs for $0","Type":"text"},"Keep Lab Pets":{"Value":[],"Type":"multidropdown"},"Keep Mutated Lab Eggs":{"Value":true,"Type":"toggle"}},"Auto Hatch & Equip":{"Hatch Specific Eggs":{"Value":[],"Type":"multidropdown"},"Auto Hatch":{"Value":false,"Type":"toggle"},"Hatch Min Rarity":{"Value":"Any","Type":"dropdown"},"Min Hatch Value":{"Value":0,"Type":"slider"},"Auto Equip Best":{"Value":false,"Type":"toggle"}},"Auto Favorite":{"Favorite Mutations":{"Value":[],"Type":"multidropdown"},"Favorite Preview":{"Value":"Favorite matches  -  0 pets, 0 to mark  |  1 favorited","Type":"text"},"Favorite Min Rarity":{"Value":"Off","Type":"dropdown"},"Auto Favorite Equipped":{"Value":false,"Type":"toggle"},"Auto Favorite Pet":{"Value":false,"Type":"toggle"},"Always Favorite Species":{"Value":[],"Type":"multidropdown"},"Auto Unfavorite Equipped":{"Value":false,"Type":"toggle"},"Min Favorite Value":{"Value":0,"Type":"slider"},"Favorite Rule":{"Value":"Match All","Type":"dropdown"}},"Butterfly Bloom":{"Auto Butterfly Bloom":{"Value":true,"Type":"toggle"},"Smart Trade For Essence":{"Value":false,"Type":"toggle"},"Auto Craft Essence":{"Value":false,"Type":"toggle"},"Auto Trade Up":{"Value":false,"Type":"toggle"},"Catch Butterflies":{"Value":["Radiant Butterfly","Amethyst Butterfly","Sapphire Butterfly","Emerald Butterfly"],"Type":"multidropdown"},"Tween Speed  ":{"Value":600,"Type":"slider","Unit":"studs/s"},"Catch Mode":{"Value":"Chase","Type":"dropdown"},"Catch Priority":{"Value":"Rarest","Type":"dropdown"},"Trade Up Tiers":{"Value":["Amethyst To Radiant"],"Type":"multidropdown"}}},"Server":{"Server":{"Server Hop Mode":{"Value":"Least Players","Type":"dropdown"},"Auto Load Script":{"Value":true,"Type":"toggle"},"Auto Rejoin When Disconnect":{"Value":true,"Type":"toggle"}}}},"States":{"Farm HUD Stealing Position":{"Value":[]},"Quick Panel Collapsed":{"Value":{"1":false}},"Quick Keybinds":{"Value":{"Player > Movement > Speed Boost":"Q"}},"Farm HUD World Position":{"Value":[]},"Farm HUD Stolen Eggs":{"Value":{"History":[{"At":1791608191,"Name":"Gargoyle Egg","Category":"Dark Gargoyle","Scale":1.0089377638111945,"Rarity":"Secret","Value":274481363.75902286}],"Count":1,"Best":{"Category":"Dark Gargoyle","Name":"Gargoyle Egg","Rarity":"Secret","Rank":8}}},"Farm HUD Top Eggs Position":{"Value":[]},"Anti Guard Enabled":{"Value":false},"Farm HUD Steal History Position":{"Value":[]},"Open On Launch":{"Value":true},"Notifications":{"Value":true},"Quick Panel Position":{"Value":{"1":{"Y":0.046925779432058337,"X":0.8835160732269287}}},"Quick Open Key":{"Value":"LeftControl"},"Farm HUD Top Pets Position":{"Value":[]},"Quick Pin Groups":{"Value":[]},"FPS and Ping Position":{"Value":{"XOffset":-107,"XScale":0,"YScale":0,"YOffset":337}},"Farm HUD Dr Scramble Position":{"Value":[]},"Farm HUD Status Position":{"Value":[]},"Steal Panel Open":{"Value":false},"Quick LeftCenter Hidden":{"Value":true},"Farm HUD Economy Position":{"Value":[]},"Quick Pinned Features":{"Value":["Player > Movement > Speed Boost","Player > Movement > Boost Speed"]},"Farm HUD Collection Position":{"Value":[]}},"SavedAt":1791608223}
]=]

-- Hàm click an toàn
local function fireClick(target)
    if not target then return end
    pcall(function()
        if firesignal then
            firesignal(target.MouseButton1Click)
        elseif getconnections then
            for _, conn in ipairs(getconnections(target.MouseButton1Click)) do conn:Fire() end
            for _, conn in ipairs(getconnections(target.Activated)) do conn:Fire() end
        end
    end)
end

-- Hàm tìm kiếm an toàn (có retry)
local function findElementSafe(container, text, className, retries, delayTime)
    retries = retries or 5
    delayTime = delayTime or 0.2
    
    for i = 1, retries do
        for _, d in ipairs(container:GetDescendants()) do
            if d:IsA(className) and d.Text:lower() == text:lower() and not d:FindFirstAncestor("Chilli_Dynamic_Island") then
                return d
            end
        end
        -- Nếu tìm TextButton nhưng thực ra nó là TextLabel bên trong 1 nút
        if className == "TextButton" then
            for _, d in ipairs(container:GetDescendants()) do
                if d:IsA("TextLabel") and d.Text:lower() == text:lower() and not d:FindFirstAncestor("Chilli_Dynamic_Island") then
                    local btn = d:FindFirstAncestorOfClass("TextButton") or d.Parent
                    if btn then return btn end
                end
            end
        end
        task.wait(delayTime)
    end
    return nil
end

-- ==================== MACRO TỰ ĐỘNG (Y HỆT THAO TÁC TAY) ====================
local function executeSafeVisualMacro()
    local cont = getSafeGuiContainer()
    if not cont then return end

    -- 1. Tìm và bấm tab Cấu Hình
    local cfgTab = findElementSafe(cont, "Cấu Hình", "TextButton") or findElementSafe(cont, "Config", "TextButton")
    if cfgTab then fireClick(cfgTab) end
    task.wait(0.3)

    -- 2. Tìm TextBox Import và dán JSON
    local importBox
    for i = 1, 5 do
        for _, d in ipairs(cont:GetDescendants()) do
            if d:IsA("TextBox") and not d:FindFirstAncestor("Chilli_Dynamic_Island") then
                local ph = (d.PlaceholderText or ""):lower()
                if ph:find("paste") or ph:find("import") then 
                    importBox = d
                    break 
                end
            end
        end
        if importBox then break end
        task.wait(0.2)
    end
    
    if importBox then
        pcall(function() importBox.Text = AUTO_FARM_JSON end)
    end
    task.wait(0.3)

    -- 3. Bấm Import
    local importBtn = findElementSafe(cont, "Import", "TextButton")
    if importBtn then fireClick(importBtn) end
    task.wait(0.3)

    -- 4. Bấm chữ auto farm (để chọn)
    local autoFarmOpt = findElementSafe(cont, "auto farm", "TextButton")
    if autoFarmOpt then fireClick(autoFarmOpt) end
    task.wait(0.3)

    -- 5. Bấm Load
    local loadBtn = findElementSafe(cont, "Load", "TextButton") or findElementSafe(cont, "Tải", "TextButton")
    if loadBtn then fireClick(loadBtn) end
    task.wait(0.3)

    -- 6. Quay lại tab Cày Cuốc
    local farmTab = findElementSafe(cont, "Cày Cuốc", "TextButton") or findElementSafe(cont, "Farm", "TextButton")
    if farmTab then fireClick(farmTab) end
end

-- ==================== NẠP SCRIPT GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== TỪ ĐIỂN DỊCH THUẬT (CODE TĨNH 100%) ====================
local currentLanguage = "VI"
local FastCache = {}

local EXACT_MATCH_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Hop"] = "Đổi Server", ["Join"] = "Vào Phòng", ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại", ["Add"] = "Thêm", ["Sell"] = "Bán", ["Favorite"] = "Khóa", ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI", ["All"] = "Tất cả", ["ALL"] = "TẤT CẢ", ["Any"] = "Tất cả", ["None"] = "Không có",
    ["Off"] = "Tắt", ["OFF"] = "TẮT", ["On"] = "Bật", ["ON"] = "BẬT", ["Idle"] = "Đang chờ", ["IDLE"] = "ĐANG CHỜ",
    ["Stand"] = "Đứng yên", ["Chase"] = "Đuổi theo", ["Circle"] = "Xoay vòng", ["Patrol"] = "Tuần tra",
    ["Rarest"] = "Hiếm nhất", ["Nearest"] = "Gần nhất", ["Always"] = "Luôn luôn", ["Never"] = "Không bao giờ",
    ["Value"] = "Giá trị", ["Cosmic"] = "Vũ Trụ (Cosmic)", ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)", ["Mythic"] = "Thần Thoại (Mythic)", ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)", ["Rare"] = "Hiếm (Rare)", ["Uncommon"] = "Thường (Uncommon)", ["Common"] = "Phổ Thông (Common)",
    ["Secret"] = "Bí Ẩn (Secret)", ["Least Players"] = "Ít người chơi nhất", ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm", ["Rarity And Value"] = "Độ hiếm & Giá trị", ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước", ["Lowest To Highest"] = "Từ thấp đến cao", ["Highest To Lowest"] = "Từ cao đến thấp",
    ["Match All"] = "Khớp tất cả", ["Match Any"] = "Khớp bất kỳ", ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất", ["3 - Rare"] = "3 - Hiếm (Rare)", ["6 - Mythic"] = "6 - Thần Thoại (Mythic)",
    ["EGGS"] = "TRỨNG", ["READY"] = "SẴN SÀNG", ["GROWING"] = "ĐANG LỚN", ["IN BAG"] = "TRONG TÚI",
    ["TOTAL / S"] = "TỔNG / GIÂY", ["SCRAMBLED"] = "ĐÃ BIẾN ĐỔI", ["GOLDEN"] = "VÀNG", ["SILVER"] = "BẠC", ["RAINBOW"] = "CẦU VỒNG"
}

local MAP_VI = {
    ["Chilli Hub"] = "Chilli Hub V2", ["Farm"] = "Cày Cuốc", ["Player"] = "Người Chơi", ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình", ["Server"] = "Máy Chủ", ["Misc"] = "Khác", ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord", ["Quick & Keys"] = "Phím Tắt & Key", ["Settings"] = "Cài Đặt", ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...", ["Search"] = "Tìm kiếm",
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble", ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp", ["Auto Steal"] = "Tự Động Cướp Trứng", ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Auto Treadmill"] = "Tự Động Máy Tập", ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị", ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Pet", ["Auto Sell Egg"] = "Tự Động Bán Trứng", ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet", ["Auto Favorite"] = "Tự Động Khóa Pet", ["Priority"] = "Ưu Tiên Nhiệm Vụ",
    ["ESP"] = "Định Vị (ESP)", ["Movement"] = "Di Chuyển", ["Character"] = "Nhân Vật", ["Combat"] = "Chiến Đấu",
    ["Discord Webhook"] = "Cài Đặt Webhook Discord", ["Egg Predictor"] = "Dự Đoán Trứng", ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp", ["Auto Progression"] = "Tự Động Tiến Trình", ["Performance"] = "Hiệu Năng",
    ["Utility"] = "Tiện Ích", ["Egg Finder"] = "Dò Tìm Trứng", ["Quick Bar 1"] = "Thanh Phím Nhanh 1", ["Quick Bar 2"] = "Thanh Phím Nhanh 2",
    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm", ["Catch Mode"] = "Chế Độ Bắt", ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Only for Chase mode"] = "Chỉ dùng cho chế độ Đuổi theo", ["Catch Butterflies"] = "Chọn Bướm Cần Bắt",
    ["Radiant Butterfly"] = "Bướm Rực Rỡ", ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím", ["Sapphire Butterfly"] = "Bướm Lam Ngọc (Sapphire)",
    ["Emerald Butterfly"] = "Bướm Lục Bảo (Emerald)", ["Tween Speed"] = "Tốc Độ Bay (Tween)", ["Auto Trade Up"] = "Tự Nâng Cấp Bướm",
    ["Trade Up Tiers"] = "Bậc Nâng Cấp", ["Smart Trade For Essence"] = "Đổi Bướm Lấy Tinh Chất Thông Minh",
    ["Going to the middle of the bloom"] = "Đang đi tới trung tâm khu bướm nở", ["Auto Craft Essence"] = "Tự Chế Tạo Tinh Chất",
    ["Auto Use Enchanted Essence"] = "Tự Dùng Tinh Chất Phù Phép", ["Essence Min Rarity"] = "Độ Hiếm Nhận Tinh Chất Min",
    ["Only eggs of this rarity and above get the essence"] = "Chỉ trứng đạt độ hiếm này trở lên mới nhận tinh chất",
    ["Essence Min Value"] = "Giá Trị Nhận Tinh Chất Min", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị nhỏ hơn mức này (0 = tắt)",
    ["Essence Target Eggs"] = "Mục Tiêu Trứng Nhận Tinh Chất", ["Only use the essence on these eggs (empty = all)"] = "Chỉ dùng tinh chất lên trứng này (trống = tất cả)",
    ["Essence Priority"] = "Ưu Tiên Dùng Tinh Chất", ["Which egg gets the essence first"] = "Trứng nào được ưu tiên nhận tinh chất trước",
    ["Essence Skip Enchanted Eggs"] = "Bỏ Qua Trứng Đã Phù Phép", ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "Bỏ qua trứng đã phù phép, đột biến khác vẫn nhận tinh chất",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)", ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc", ["Higher is safer but takes longer"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",
    ["Target Areas"] = "Khu Vực Mục Tiêu", ["Min Steal Value"] = "Giá Trị Cướp Min", ["Target Specific Eggs"] = "Chọn Đích Danh Trứng Cần Cướp",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu", ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp cả trứng còn thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp", ["Carry Speed"] = "Tốc Độ Bê Trứng", ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ", ["Place Egg Rule"] = "Quy Tắc Đặt Trứng", ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng", ["Only place eggs of the picked rarities (empty = all)"] = "Chỉ đặt trứng thuộc các độ hiếm đã chọn (trống = tất cả)",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Cần Đặt", ["Only place these eggs (empty = all)"] = "Chỉ đặt các trứng này (trống = tất cả)",
    ["Min Place Value"] = "Giá Trị Đặt Min", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị thấp hơn mức này (0 = tắt)",
    ["Stay On Treadmill"] = "Cố Định Trên Máy Tập", ["Auto Hatch"] = "Tự Động Ấp Trứng", ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "Ấp trứng từ độ hiếm đã chọn trở lên", ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Cần Ấp", ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Equip Best when a better pet appears"] = "Tự trang bị khi có pet mạnh hơn xuất hiện", ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell matching pets once"] = "Bán các pet khớp điều kiện một lần", ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Which checks must pass to sell"] = "Các điều kiện bắt buộc để bán", ["Pet Max Rarity"] = "Độ Hiếm Pet Max Cần Bán",
    ["Sell pets at or below this rarity"] = "Bán pet từ độ hiếm này trở xuống", ["Pet Sell Value"] = "Giá Trị Bán Pet Min",
    ["Sell pets worth less than this (0 = off)"] = "Bán pet có giá trị nhỏ hơn mức này (0 = tắt)", ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Never sell mutated pets"] = "Không bao giờ bán pet có đột biến", ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["These pets are never sold"] = "Những pet này sẽ không bao giờ bị bán", ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi khớp quy tắc dưới",
    ["Sell Eggs Now"] = "Bán Trứng Ngay", ["Sell matching eggs once"] = "Bán một lần các trứng khớp điều kiện", ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Trứng Max Cần Bán", ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng Min", ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến", ["Never sell mutated eggs"] = "Không bao giờ bán trứng có đột biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng", ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "Bán trứng đổi từ Dr Scramble khớp bộ lọc dưới",
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay", ["Sell matching Lab eggs once"] = "Bán một lần các trứng Lab khớp điều kiện",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab", ["Lab Egg Max Rarity"] = "Độ Hiếm Trứng Lab Max Cần Bán",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "Bán trứng Lab từ độ hiếm này trở xuống (Off = tắt)",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab Min", ["Sell Lab eggs worth less than this (0 = off)"] = "Bán trứng Lab giá trị thấp hơn mức này (0 = tắt)",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến", ["Never sell mutated Lab eggs"] = "Không bao giờ bán trứng Lab có đột biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab", ["Lab eggs of these pets are never sold"] = "Trứng Lab của những pet này sẽ không bao giờ bị bán",
    ["No three matching pets"] = "Không đủ 3 pet trùng khớp", ["Fuse 3 same pets into an egg, nonstop"] = "Ghép 3 pet cùng loại thành 1 trứng liên tục",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Dung Hợp", ["Pets To Use"] = "Loại Pet Sử Dụng", ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Cần Dung Hợp", ["Only fuse these species (empty = all)"] = "Chỉ ghép loài này (trống = tất cả)",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến", ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ", ["Take out pets that can't make a set"] = "Đẩy ra các pet không thể ghép đủ bộ 3",
    ["Auto Favorite Pet"] = "Tự Động Khóa Pet", ["Favorite pets matching the rules below"] = "Khóa các pet khớp quy tắc bên dưới",
    ["Favorite Pets Now"] = "Khóa Pet Ngay", ["Favorite matching pets once"] = "Khóa các pet khớp điều kiện một lần",
    ["Favorite Rule"] = "Quy Tắc Khóa", ["Pass any check or all checks"] = "Thỏa mãn một hoặc tất cả điều kiện",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min", ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "Khóa pet từ độ hiếm đã chọn trở lên (Off = bỏ qua)",
    ["Favorite Mutations"] = "Đột Biến Cần Khóa", ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (trống = bỏ qua)",
    ["Min Favorite Value"] = "Giá Trị Khóa Min", ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Các Loài Này", ["Always favorite these species"] = "Luôn luôn khóa những loài này",
    ["Auto Favorite Equipped"] = "Tự Khóa Pet Đang Dùng", ["Keep equipped pets favorited"] = "Luôn giữ pet đang trang bị được khóa",
    ["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Pet Đang Dùng", ["Unfavorite equipped pets not in the rules"] = "Mở khóa pet đang trang bị nếu không đúng quy tắc",
    ["Favorite Equipped Now"] = "Khóa Pet Đang Dùng Ngay", ["Favorite all equipped pets once"] = "Khóa tất cả pet đang trang bị một lần",
    ["Unfavorite Equipped Now"] = "Bỏ Khóa Pet Đang Dùng Ngay", ["Unfavorite all equipped pets once"] = "Mở khóa tất cả pet đang trang bị một lần",
    ["Auto Mech Boss"] = "Tự Động Đánh Boss Robot", ["Mech Tween Speed"] = "Tốc Độ Bay Đánh Boss",
    ["Main Weapon Hold"] = "Thời Gian Giữ Vũ Khí Chính", ["Scrambler Hold"] = "Thời Gian Giữ Súng Biến Đổi",
    ["Swap Two Weapons"] = "Tự Đổi Qua Lại 2 Vũ Khí", ["Boss Server Hop"] = "Tự Đổi Server Săn Boss",
    ["After each boss, hops to a less crowded server to fight again"] = "Sau mỗi boss, đổi sang server vắng hơn để đánh tiếp",
    ["Keep Hopping For"] = "Thời Gian Đổi Server Liên Tục", ["Keeps fighting every boss it finds and hopping for this long"] = "Liên tục săn boss tìm được và đổi server trong thời gian này",
    ["Auto Claim Mastery"] = "Tự Nhận Thưởng Tinh Thông Boss", ["Claims Boss Mastery rewards as soon as they unlock"] = "Tự nhận thưởng Tinh Thông Boss ngay khi mở khóa",
    ["Lab Banners"] = "Biểu Ngữ Phòng Lab", ["Only trade and steal for these banners (empty = all)"] = "Chỉ đổi và cướp các biểu ngữ này (trống = tất cả)",
    ["Auto Lab Trade-In"] = "Tự Đổi Đồ Phòng Thí Nghiệm", ["Auto Reroll Lab Recipe"] = "Tự Đổi Công Thức Phòng Lab",
    ["Auto Place Lab Reward Eggs"] = "Tự Đặt Trứng Thưởng Lab", ["Places the reward eggs from Lab trades"] = "Tự động đặt trứng thưởng nhận từ đổi đồ phòng lab",
    ["Auto Buy Scramble Shop"] = "Tự Mua Shop Dr. Scramble", ["Buy the picked items with Samples"] = "Dùng Mẫu Vật (Samples) mua các vật phẩm đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble", ["Keep Samples"] = "Giữ Lại Mẫu Vật Tối Thiểu",
    ["Never spend below this many Samples"] = "Không bao giờ tiêu hao dưới mức mẫu vật này",
    ["Auto Use Scrambled"] = "Tự Dùng Thuốc Biến Đổi Scrambled", ["Turn it on to start applying Scrambled"] = "Bật lên để bắt đầu áp dụng thuốc Scrambled",
    ["Auto Buy Scrambled"] = "Tự Mua Thêm Scrambled Khi Hết", ["Buy another Scrambled from the event shop when you run out"] = "Tự mua thêm Scrambled từ shop sự kiện khi dùng hết",
    ["Mutation Min Rarity"] = "Độ Hiếm Đột Biến Min", ["Only eggs of this rarity and above are used"] = "Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Value"] = "Giá Trị Đột Biến Min", ["Mutation Priority"] = "Ưu Tiên Đột Biến",
    ["Which egg gets the consumable first"] = "Trứng nào được ưu tiên dùng thuốc trước",
    ["Mutation Target Eggs"] = "Mục Tiêu Trứng Đột Biến", ["Only use the consumable on these eggs (empty = all)"] = "Chỉ dùng thuốc lên các trứng này (trống = tất cả)",
    ["Auto Wisp"] = "Tự Động Nhặt Wisp", ["Auto Banjo Cricket"] = "Tự Động Bắt Dế Banjo",
    ["Chase Settings"] = "Cài Đặt Đuổi Đánh", ["Chase Cài Đặt"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh", ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Đòn Đánh (Hit Lead)", ["Stand further ahead of the target (i.e. or closer to them)"] = "Đứng đón đầu mục tiêu xa hơn (hoặc áp sát gần hơn)",
    ["Hit Sweep"] = "Góc Quét Đòn Đánh (Hit Sweep)", ["How far you swipe back and forth in front of the target"] = "Khoảng cách vung vũ khí quét qua lại trước mục tiêu",
    ["Add/Remove Hits On Quick Bar 2"] = "Thêm/Bỏ Nút Đánh Vào Quick Bar 2", ["Pin or unpin the hit toggles on Quick Bar 2"] = "Ghim hoặc bỏ ghim các nút đánh trên Quick Bar 2",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất", ["Auto Hit Egg Holders"] = "Tự Đánh Người Đang Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định", ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)", ["Instant Prompts"] = "Tương Tác Phím Nhanh (Instant E)",
    ["Speed Boost"] = "Tăng Tốc Chạy", ["Boost Speed"] = "Tốc Độ Tăng Tốc", ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)", ["Makes you invisible to other players"] = "Làm bạn vô hình trước người chơi khác",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)", ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không thể bắt được bạn",
    ["ESP Eggs"] = "ESP Trứng", ["ESP Fixed Size"] = "Cỡ ESP Cố Định", ["ESP Own Base Eggs"] = "Hiện Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiển thị cả trứng đã đặt tại căn cứ của bạn",
    ["ESP Min Rarity"] = "Độ Hiếm ESP Min", ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm đã chọn trở lên",
    ["ESP Show Info"] = "Hiện Thông Tin ESP", ["Min ESP Value"] = "Giá Trị ESP Min",
    ["ESP Egg Size"] = "Cỡ ESP Trứng", ["ESP Guards"] = "ESP Vệ Sĩ", ["ESP Guard Size"] = "Cỡ ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi", ["ESP Players"] = "ESP Người Chơi",
    ["ESP Player Info"] = "Thông Tin ESP Người Chơi", ["ESP Player Size"] = "Cỡ ESP Người Chơi",
    ["Search eggs..."] = "Tìm kiếm trứng...", ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",
    ["Biohazard Pets"] = "Pet Phóng Xạ (Biohazard)", ["CURRENT RECIPE"] = "CÔNG THỨC HIỆN TẠI",
    ["REWARD ODDS - BIOHAZARD PETS"] = "TỈ LỆ THƯỞNG - PET PHÓNG XẠ", ["Chase pet"] = "Đuổi bắt pet",
    ["Machine is empty"] = "Máy đang trống", ["Load 3 pets of the same species to see the result odds"] = "Đặt 3 pet cùng loài vào máy để xem tỉ lệ kết quả",
    ["Sort By"] = "Sắp Xếp Theo", ["Preview Card"] = "Thẻ Xem Trước",
    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng (Trail)", ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng có sẵn khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ", ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập", ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim"] = "Tự Nhận Thưởng", ["Claim offline money & index rewards"] = "Nhận tiền tích lũy offline & thưởng sách pet",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Sách Pet", ["Claim index rewards as soon as they unlock"] = "Tự động nhận thưởng sách ngay khi mở khóa",
    ["Auto Load Script"] = "Tự Động Nạp Script", ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Server Hop"] = "Đổi Server", ["Job ID"] = "Mã Phòng (Job ID)", ["Paste a server Job ID..."] = "Dán mã Job ID của server...",
    ["Join Job ID"] = "Vào Bằng Job ID", ["Copy Current Job ID"] = "Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Server", ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",
    ["FPS Cap"] = "Giới Hạn FPS", ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping", ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D", ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",
    ["Joins new servers to find eggs that match the filters below"] = "Tự đổi server để tìm trứng khớp bộ lọc bên dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Server để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server", ["Rarity To Wait For"] = "Độ Hiếm Cần Giữ Chân",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ nếu xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp", ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với mục Tự Động Cướp",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Value To Find"] = "Giá Trị Trứng Min Cần Tìm", ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu", ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",
    ["Webhook URL"] = "Đường Dẫn Webhook", ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng", ["Post every egg you bring home"] = "Gửi thông báo mỗi quả trứng mang về thành công",
    ["selected"] = "đã chọn"
}

local function getStaticTranslation(raw)
    local p1, p2, p3, p4, p5
    p1, p2, p3 = raw:match("Catching a (.+) butterfly, (%d+) studs | (%d+) flying")
    if p1 then return currentLanguage == "VI" and ("Đang bắt bướm " .. p1 .. ", " .. p2 .. " studs | " .. p3 .. " đang bay") or raw end
    p1 = raw:match("ALL (%d+)")
    if p1 then return currentLanguage == "VI" and ("TẤT CẢ " .. p1) or raw end
    p1 = raw:match("READY (%d+)")
    if p1 then return currentLanguage == "VI" and ("SẴN SÀNG " .. p1) or raw end
    p1 = raw:match("GROWING (%d+)")
    if p1 then return currentLanguage == "VI" and ("ĐANG LỚN " .. p1) or raw end
    p1 = raw:match("IN BAG (%d+)")
    if p1 then return currentLanguage == "VI" and ("TRONG TÚI " .. p1) or raw end
    p1, p2 = raw:match("#(%d+) of (%d+) eggs by value")
    if p1 then return currentLanguage == "VI" and ("Hạng #" .. p1 .. "/" .. p2 .. " trứng theo giá trị") or raw end
    p1 = raw:match("1 in ([%d%.]+)")
    if p1 then return currentLanguage == "VI" and ("Tỉ lệ 1/" .. p1) or raw end
    p1 = raw:match("Ends in (%d+h %d+m %d+s)")
    if p1 then return currentLanguage == "VI" and ("Kết thúc sau " .. p1) or raw end
    p1 = raw:match("in (%d+h %d+m)")
    if p1 then return currentLanguage == "VI" and ("sau " .. p1) or raw end
    p1 = raw:match("Banner chance (%d+%.?%d*%%)")
    if p1 then return currentLanguage == "VI" and ("Tỉ lệ Banner " .. p1) or raw end
    p1, p2 = raw:match("Pity (%d+)/(%d+)")
    if p1 then return currentLanguage == "VI" and ("Bảo hiểm " .. p1 .. "/" .. p2) or raw end
    p1 = raw:match("Free rerolls (%d+)")
    if p1 then return currentLanguage == "VI" and ("Đổi miễn phí " .. p1) or raw end
    p1 = raw:match("rotates in (%d+:%d+)")
    if p1 then return currentLanguage == "VI" and ("xoay vòng sau " .. p1) or raw end
    p1, p2, p3, p4, p5 = raw:match("Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag")
    if p1 then return currentLanguage == "VI" and ("Trứng đã đặt " .. p1 .. "/" .. p2 .. " - " .. p3 .. "/" .. p4 .. " pet trang bị, " .. p5 .. " trong túi") or raw end
    p1, p2 = raw:match("Pet matches %- (%d+) pets? for %$(.+)")
    if p1 then return currentLanguage == "VI" and ("Khớp pet - " .. p1 .. " pet giá $" .. p2) or raw end
    p1, p2 = raw:match("Egg matches %- (%d+) eggs? for %$(.+)")
    if p1 then return currentLanguage == "VI" and ("Khớp trứng - " .. p1 .. " trứng giá $" .. p2) or raw end
    p1, p2 = raw:match("Lab egg matches %- (%d+) eggs? for %$(.+)")
    if p1 then return currentLanguage == "VI" and ("Khớp trứng Lab - " .. p1 .. " trứng giá $" .. p2) or raw end
    p1, p2, p3 = raw:match("Favorite matches %- (%d+) pets?, (%d+) to mark %| (%d+) favorited")
    if p1 then return currentLanguage == "VI" and ("Khớp yêu thích - " .. p1 .. " pet, " .. p2 .. " cần lưu | " .. p3 .. " đã khóa") or raw end
    p1, p2, p3, p4, p5 = raw:match("Charges (%d+) Eggs (%d+)/(%d+) Tries (%d+) Applied (%d+)")
    if p1 then return currentLanguage == "VI" and ("Số lần sạc " .. p1 .. " Trứng " .. p2 .. "/" .. p3 .. " Thử " .. p4 .. " Đã dùng " .. p5) or raw end
    p1, p2 = raw:match("Players (%d+)/(%d+)")
    if p1 then return currentLanguage == "VI" and ("Người chơi " .. p1 .. "/" .. p2) or raw end
    p1 = raw:match("Next Mech portal in (%d+:%d+)")
    if p1 then return currentLanguage == "VI" and ("Cổng Robot mở sau " .. p1) or raw end
    p1 = raw:match("Next Butterfly Bloom in (%d+:%d+)")
    if p1 then return currentLanguage == "VI" and ("Sự kiện Bướm nở sau " .. p1) or raw end
    p1 = raw:match("Butterfly Bloom live, (%d+:%d+) left")
    if p1 then return currentLanguage == "VI" and ("Sự kiện Bướm đang diễn ra, còn " .. p1) or raw end
    p1, p2 = raw:match("Caught (.+)! %((%d+) owned%)")
    if p1 then return currentLanguage == "VI" and ("Đã bắt " .. p1 .. "! (Đang có " .. p2 .. " con)") or raw end
    return nil
end

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

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
    local matched = false

    local dyn = getStaticTranslation(result)
    if dyn then
        result = dyn
        matched = true
    else
        for _, item in ipairs(SortedVI) do
            if result:find(item.en, 1, true) then
                result = replaceAll(result, item.en, item.out)
                matched = true
            end
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local function applyTranslation(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        pcall(function() inst:SetAttribute("OriginalRawText", original) end)
    end

    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        pcall(function()
            inst:SetAttribute("__IsTranslating", true)
            inst:SetAttribute("__LastTranslatedText", mappedText)
            inst.Text = mappedText
            inst:SetAttribute("__IsTranslating", false)
        end)
    end
end

local function hookElement(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    pcall(function() inst:SetAttribute("HasTranslateHook", true) end)

    task.defer(function() if inst and inst.Parent then applyTranslation(inst) end end)
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        local current = inst.Text
        if current == inst:GetAttribute("__LastTranslatedText") then return end
        pcall(function() inst:SetAttribute("OriginalRawText", current) end)
        applyTranslation(inst)
    end)
end

-- ==================== LÕI ĐỔI MÀU SOFT PASTEL BLUE ====================
local COLOR_FACE_TOP     = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM  = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW = Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["cày cuốc"] = true, ["farm"] = true, ["người chơi"] = true, ["player"] = true,
    ["dự đoán"] = true, ["predictor"] = true, ["tiến trình"] = true, ["progress"] = true,
    ["máy chủ"] = true, ["server"] = true, ["khác"] = true, ["misc"] = true,
    ["tự đổi máy chủ"] = true, ["tự đổi server"] = true, ["auto hop"] = true,
    ["discord"] = true, ["phím tắt & key"] = true, ["quick & keys"] = true,
    ["cài đặt"] = true, ["settings"] = true, ["cấu hình"] = true, ["config"] = true
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
        local pCol = p.BackgroundColor3
        if pCol and (pCol.R > 0.4 and pCol.G < 0.35) then p.BackgroundColor3 = COLOR_BEVEL_SHADOW end
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
        if p.BackgroundColor3.R > 0.4 and p.BackgroundColor3.G < 0.35 then p.BackgroundColor3 = COLOR_BEVEL_SHADOW end
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
            if item:IsA("TextButton") then item.TextColor3 = Color3.fromRGB(255, 255, 255) end
        end
    end
end

local function inspectAndApplySoftBlue(inst)
    if not inst or not inst.Parent then return end
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") then return end
    local success, textRaw = pcall(function() return inst.Text:lower():match("^%s*(.-)%s*$") or "" end)
    if not success then return end

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

-- ==================== RAINBOW DYNAMIC ISLAND UI ====================
local function createDynamicIslandUI()
    pcall(function()
        if CoreGui:FindFirstChild("Chilli_Dynamic_Island") then CoreGui.Chilli_Dynamic_Island:Destroy() end
        if LocalPlayer.PlayerGui:FindFirstChild("Chilli_Dynamic_Island") then LocalPlayer.PlayerGui.Chilli_Dynamic_Island:Destroy() end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Dynamic_Island"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    
    local container = getSafeGuiContainer()
    if container then ScreenGui.Parent = container end

    local Island = Instance.new("Frame")
    Island.Name = "Island"
    Island.Size = UDim2.new(0, 150, 0, 32)
    Island.AnchorPoint = Vector2.new(0.5, 0)
    Island.Position = UDim2.new(0.5, 0, 0, 12)
    Island.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    Island.BackgroundTransparency = 0.05
    Island.BorderSizePixel = 0
    Island.ClipsDescendants = true
    Island.Parent = ScreenGui

    Instance.new("UICorner", Island).CornerRadius = UDim.new(0, 16)

    local IslandStroke = Instance.new("UIStroke")
    IslandStroke.Thickness = 2
    IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    IslandStroke.Parent = Island

    local RainbowGradient = Instance.new("UIGradient")
    RainbowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 60, 60)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 160, 40)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 230, 50)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 240, 120)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(45, 180, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(180, 70, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 60, 60))
    })
    RainbowGradient.Parent = IslandStroke

    RunService.RenderStepped:Connect(function()
        RainbowGradient.Rotation = (RainbowGradient.Rotation + 2) % 360
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 32)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Island

    local IconBadge = Instance.new("Frame")
    IconBadge.Size = UDim2.new(0, 22, 0, 22)
    IconBadge.Position = UDim2.new(0, 6, 0.5, -11)
    IconBadge.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    IconBadge.BorderSizePixel = 0
    IconBadge.Parent = TopBar
    Instance.new("UICorner", IconBadge).CornerRadius = UDim.new(1, 0)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌶️"
    Icon.TextSize = 13
    Icon.Parent = IconBadge

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -65, 1, 0)
    Title.Position = UDim2.new(0, 32, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Chilli V2"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 11
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local ArrowBadge = Instance.new("TextLabel")
    ArrowBadge.Size = UDim2.new(0, 20, 1, 0)
    ArrowBadge.Position = UDim2.new(1, -26, 0, 0)
    ArrowBadge.BackgroundTransparency = 1
    ArrowBadge.Text = "▼"
    ArrowBadge.Font = Enum.Font.GothamBold
    ArrowBadge.TextSize = 10
    ArrowBadge.TextColor3 = Color3.fromRGB(180, 195, 220)
    ArrowBadge.Parent = TopBar

    local TriggerBtn = Instance.new("TextButton")
    TriggerBtn.Size = UDim2.new(1, 0, 1, 0)
    TriggerBtn.BackgroundTransparency = 1
    TriggerBtn.Text = ""
    TriggerBtn.ZIndex = 15
    TriggerBtn.Parent = TopBar

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -16, 0, 96)
    ContentFrame.Position = UDim2.new(0, 8, 0, 36)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Island

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)
    Layout.Parent = ContentFrame

    local LangSegment = Instance.new("Frame")
    LangSegment.Size = UDim2.new(1, 0, 0, 28)
    LangSegment.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
    LangSegment.BorderSizePixel = 0
    LangSegment.LayoutOrder = 1
    LangSegment.Parent = ContentFrame
    Instance.new("UICorner", LangSegment).CornerRadius = UDim.new(1, 0)

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -3, 1, -4)
    LangSlider.Position = UDim2.new(0, 2, 0.5, -12)
    LangSlider.BackgroundColor3 = COLOR_FACE_BOTTOM
    LangSlider.BorderSizePixel = 0
    LangSlider.Parent = LangSegment
    Instance.new("UICorner", LangSlider).CornerRadius = UDim.new(1, 0)

    local SliderGrad = Instance.new("UIGradient")
    SliderGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLOR_FACE_TOP), ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)})
    SliderGrad.Rotation = 90
    SliderGrad.Parent = LangSlider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 VIE"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = LangSegment

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENG"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
    BtnEN.ZIndex = 5
    BtnEN.Parent = LangSegment

    local function setLanguage(lang)
        if currentLanguage == lang then return end
        currentLanguage = lang
        if lang == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -12), BackgroundColor3 = COLOR_FACE_BOTTOM}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 1, 0.5, -12), BackgroundColor3 = Color3.fromRGB(50, 65, 90)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 165, 190)}):Play()
        end
        local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
        for _, root in ipairs(searchRoots) do
            if root then
                for _, desc in ipairs(root:GetDescendants()) do
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        task.defer(function() applyTranslation(desc) end)
                    end
                end
            end
        end
    end

    BtnVI.Activated:Connect(function() setLanguage("VI") end)
    BtnEN.Activated:Connect(function() setLanguage("EN") end)

    local PresetBtn = Instance.new("TextButton")
    PresetBtn.Size = UDim2.new(1, 0, 0, 36)
    PresetBtn.BackgroundColor3 = Color3.fromRGB(38, 44, 58)
    PresetBtn.Text = "⚡ THIẾT LẬP AUTO FARM"
    PresetBtn.Font = Enum.Font.GothamBold
    PresetBtn.TextSize = 11
    PresetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PresetBtn.LayoutOrder = 2
    PresetBtn.Parent = ContentFrame
    Instance.new("UICorner", PresetBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", PresetBtn).Color = Color3.fromRGB(45, 60, 85)

    PresetBtn.Activated:Connect(function()
        PresetBtn.Text = "Đang thiết lập siêu tốc..."
        PresetBtn.BackgroundColor3 = Color3.fromRGB(45, 205, 110)
        
        task.spawn(function()
            executeSafeVisualMacro()
            task.wait(0.5)
            PresetBtn.Text = "✅ ĐÃ THIẾT LẬP XONG!"
            task.wait(2)
            PresetBtn.Text = "⚡ THIẾT LẬP AUTO FARM"
            PresetBtn.BackgroundColor3 = Color3.fromRGB(38, 44, 58)
        end)
    end)

    local isExpanded = false
    local isTweening = false

    local function toggleIsland()
        if isTweening then return end
        isTweening = true
        isExpanded = not isExpanded
        TweenService:Create(Island, TweenInfo.new(0.08), {Size = UDim2.new(0, isExpanded and 140 or 255, 0, isExpanded and 30 or 120)}):Play()
        task.wait(0.08)
        if isExpanded then
            TweenService:Create(ArrowBadge, TweenInfo.new(0.3), {Rotation = 180}):Play()
            local tweenExp = TweenService:Create(Island, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 245, 0, 115)})
            tweenExp:Play()
            tweenExp.Completed:Connect(function() isTweening = false end)
        else
            TweenService:Create(ArrowBadge, TweenInfo.new(0.3), {Rotation = 0}):Play()
            local tweenCol = TweenService:Create(Island, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 150, 0, 32)})
            tweenCol:Play()
            tweenCol.Completed:Connect(function() isTweening = false end)
        end
    end

    TriggerBtn.Activated:Connect(toggleIsland)

    local dragging, dragStart, startPos = false, nil, nil
    Island.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Island.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    Island.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            if delta.Magnitude > 8 then
                local cam = workspace.CurrentCamera
                local maxX = cam and cam.ViewportSize.X - 245 or 800
                local maxY = cam and cam.ViewportSize.Y - 115 or 600
                local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)
                Island.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
            end
        end
    end)
end

-- ==================== KHỞI ĐỘNG VÀ QUÉT ĐA TẦNG ====================
task.spawn(function()
    createDynamicIslandUI()
    local function processRootChunked(root)
        if not root then return end
        local function inspectTree(parent)
            local children = parent:GetChildren()
            for i, desc in ipairs(children) do
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                    inspectAndApplySoftBlue(desc)
                end
                if i % 30 == 0 then RunService.RenderStepped:Wait() end
                inspectTree(desc)
            end
        end
        pcall(function() inspectTree(root) end)
        root.DescendantAdded:Connect(function(desc)
            task.defer(function()
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    hookElement(desc)
                    inspectAndApplySoftBlue(desc)
                end
            end)
        end)
    end
    local searchRoots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
    pcall(function() if gethui then table.insert(searchRoots, gethui()) end end)
    for _, r in ipairs(searchRoots) do processRootChunked(r) end
end)
