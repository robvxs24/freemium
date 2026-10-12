-- ==============================================================================
--  CHILLI HUB V3.8 - CLEAN DIRECT ENGINE (ZERO BLACK BLOB & AUTO STARTUP)
-- ==============================================================================

-- ==================== 0. DỌN DẸP SẠCH TÀN DƯ GUI CŨ ====================
local cleanupList = {
    "Chilli_Dynamic_Island",
    "Chilli_AutoConfig_Btn",
    "Chilli_AutoFarm_Widget",
    "Chilli_Liquid_Capsule",
    "Sparkling_New_Badge",
    "Chilli_Update_Toast"
}

for _, root in ipairs({gethui and gethui(), game:GetService("CoreGui"), game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")}) do
    if root then
        for _, name in ipairs(cleanupList) do
            local f = root:FindFirstChild(name, true)
            while f do
                pcall(function() f:Destroy() end)
                f = root:FindFirstChild(name, true)
            end
        end
    end
end

-- ==================== 1. CHẶN SCRIPT GỐC KHI REJOIN / HOP SERVER ====================
local rawQueue = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
if rawQueue then
    local function autoHookQueue(code)
        if type(code) == "string" and (code:find("tienkhanh1") or code:find("Chilli.lua") or code:find("spicy")) then
            return rawQueue([[
                task.wait(2.5)
                if isfile and isfile("Chilli_V38.lua") then
                    loadstring(readfile("Chilli_V38.lua"))()
                elseif isfile and isfile("autoexec/Chilli_V38.lua") then
                    loadstring(readfile("autoexec/Chilli_V38.lua"))()
                end
            ]])
        end
        return rawQueue(code)
    end

    pcall(function() getgenv().queue_on_teleport = autoHookQueue end)
    pcall(function() if syn then syn.queue_on_teleport = autoHookQueue end end)
    pcall(function() if fluxus then fluxus.queue_on_teleport = autoHookQueue end end)
end

-- ==================== 2. KHỞI ĐỘNG AN TOÀN TUYỆT ĐỐI (KHÔNG TREO) ====================
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait(0.1)
    LocalPlayer = Players.LocalPlayer
end

task.wait(1.5)

-- ==================== 3. TẢI SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ==================== DỮ LIỆU CẤU HÌNH JSON (PROFILE: MAIN) ====================
local RAW_CONFIG_JSON = [===[{"Config":{"Profile":"main","Version":2,"States":{"Farm HUD Stealing Position":{"Value":[]},"Quick Panel Collapsed":{"Value":{"1":true}},"Quick Keybinds":{"Value":{"Player > Movement > Speed Boost":"Q"}},"Farm HUD World Position":{"Value":[]},"Farm HUD Stolen Eggs":{"Value":{"History":[{"At":1791707562,"Name":"Parrotfish Egg","Category":"Parrotfish","Scale":0.9196704573013789,"Rarity":"Rare","Value":659.493259982963}],"Count":1,"Best":{"Category":"Parrotfish","Name":"Parrotfish Egg","Rarity":"Rare","Rank":3}}},"Farm HUD Top Eggs Position":{"Value":[]},"Anti Guard Enabled":{"Value":false},"Farm HUD Steal History Position":{"Value":[]},"Quick Pinned Features":{"Value":["Player > Movement > Speed Boost","Player > Movement > Boost Speed"]},"Open On Launch":{"Value":true},"Quick Panel Position":{"Value":{"1":{"Y":0.32634490728378298,"X":0.8134856224060059}}},"Notifications":{"Value":true},"Farm HUD Top Pets Position":{"Value":[]},"Quick Open Key":{"Value":"LeftControl"},"FPS and Ping Position":{"Value":{"XOffset":16,"XScale":0,"YScale":0,"YOffset":47}},"Farm HUD Status Position":{"Value":[]},"Farm HUD Events Position":{"Value":[]},"Steal Panel Open":{"Value":false},"Quick LeftCenter Hidden":{"Value":true},"Farm HUD Economy Position":{"Value":[]},"Quick Pin Groups":{"Value":[]},"Farm HUD Collection Position":{"Value":[]}},"Values":{"Admin Abuse":{"Minigame Eggs":{"Auto Steal Minigame Egg":{"Value":true,"Type":"toggle"}},"Instant Steal V3":{"Instant Steal V3 Note":{"Value":"Cần Máy Tập Admin","Type":"text"},"Instant Steal V3":{"Value":false,"Type":"toggle"}},"Admin Treadmill":{"Auto Use Admin Treadmill":{"Value":true,"Type":"toggle"}},"Capture The Egg":{"Hold Height":{"Value":45,"Type":"slider","Unit":"studs"},"Auto Capture Event Egg":{"Value":false,"Type":"toggle"},"Keep Away Distance":{"Value":45,"Type":"slider","Unit":"studs"},"Take It From The Holder":{"Value":true,"Type":"toggle"}}},"Predictor":{"Egg Predictor":{"Sort By":{"Value":"Value","Type":"dropdown"},"Preview Card":{"Value":true,"Type":"toggle"}},"Discord Webhook":{"Webhook URL":{"Value":"","Type":"input"},"Notify Fused Eggs":{"Value":false,"Type":"toggle"},"Notify Stolen Eggs":{"Value":false,"Type":"toggle"},"Webhook Min Rarity":{"Value":"Any","Type":"dropdown"},"Webhook Eggs":{"Value":[],"Type":"multidropdown"},"Webhook Min Value":{"Value":0,"Type":"slider"},"Ping @everyone":{"Value":false,"Type":"toggle"}}},"Progress":{"Auto Progression":{"Auto Buy Trail":{"Value":true,"Type":"toggle"},"Auto Claim Index":{"Value":true,"Type":"toggle"},"Auto Upgrade Treadmill":{"Value":true,"Type":"toggle"},"Auto Claim":{"Value":true,"Type":"toggle"},"Auto Upgrade Base":{"Value":true,"Type":"toggle"}}},"Quick":{"Pin Pad":{"Pad Size":{"Value":150,"Type":"slider","Unit":"%"},"Enable Keybinds":{"Value":true,"Type":"toggle"},"Show Pin Pads":{"Value":true,"Type":"toggle"},"Visible Quick Bars":{"Value":["Quick Bar 1","Quick Bar 2","Quick Bar 3","Quick Bar 4","Quick Bar 5"],"Type":"multidropdown"}}},"Auto Hop":{"Egg Finder":{"Hop Mode":{"Value":"Steal Then Hop","Type":"dropdown"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Rarity To Wait For":{"Value":"Cosmic","Type":"dropdown"},"First Hop Delay":{"Value":5,"Type":"slider","Unit":"s"},"Sync With Auto Steal Filters":{"Value":true,"Type":"toggle"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Min Value To Find":{"Value":700.11,"Type":"slider"},"Auto Hop":{"Value":false,"Type":"toggle"},"Target Areas":{"Value":["Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"}}},"Player":{"ESP":{"ESP Eggs":{"Value":true,"Type":"toggle"},"ESP Show Info":{"Value":["Icon","Name","Value"],"Type":"multidropdown"},"ESP Guard Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Player Info":{"Value":["Name","Tool"],"Type":"multidropdown"},"ESP Other Base Eggs":{"Value":false,"Type":"toggle"},"ESP Min Rarity":{"Value":"7 - Cosmic","Type":"dropdown"},"ESP Guards":{"Value":true,"Type":"toggle"},"Min ESP Value":{"Value":0,"Type":"slider"},"ESP Player Size":{"Value":75,"Type":"slider","Unit":"%"},"ESP Players":{"Value":true,"Type":"toggle"},"ESP Own Base Eggs":{"Value":true,"Type":"toggle"},"ESP Fixed Size":{"Value":false,"Type":"toggle"},"ESP Egg Size":{"Value":75,"Type":"slider","Unit":"%"}},"Character":{"Instant Prompts":{"Value":true,"Type":"toggle"},"Anti Ragdoll":{"Value":true,"Type":"toggle"},"Anti Trap":{"Value":true,"Type":"toggle"},"Invisibility":{"Value":false,"Type":"toggle"}},"Movement":{"Speed Boost":{"Value":false,"Type":"toggle"},"Boost Speed":{"Value":1000,"Type":"slider","Unit":"studs/s"},"Infinite Jump":{"Value":false,"Type":"toggle"}},"Combat":{"Auto Hit Egg Holders":{"Value":false,"Type":"toggle"},"Hit Max Speed":{"Value":750,"Type":"slider","Unit":"studs/s"},"Auto Hit Nearest Player":{"Value":false,"Type":"toggle"},"Hit Player":{"Value":"67sixseven16690","Type":"dropdown"},"Hit Lead":{"Value":-275,"Type":"slider"},"Hit Tween Speed":{"Value":400,"Type":"slider","Unit":"studs/s"},"Hit Sweep":{"Value":60,"Type":"slider","Unit":"%"},"Chase Settings":{"Value":"Cài Đặt Đuổi Đánh","Type":"label"},"Auto Hit Specific Player":{"Value":false,"Type":"toggle"},"Hit Aura":{"Value":true,"Type":"toggle"},"Hit Status":{"Value":"Aura ready, nobody in reach","Type":"text"}}},"Settings":{"Interface":{"UI Size":{"Value":100,"Type":"slider","Unit":"%"}}},"Farm":{"Auto Steal":{"Drop Eggs At Safe Zone":{"Value":false,"Type":"toggle"},"Target Specific Eggs":{"Value":[],"Type":"multidropdown"},"Biohazard Lab Eggs":{"Value":["Red Panda Egg (43%)","Snowy Owl Egg (40%)","Salamander Egg (38%)"],"Type":"multidropdown"},"Anti Guard Panel":{"Value":true,"Type":"toggle"},"Steal Missing Lab Eggs":{"Value":false,"Type":"toggle"},"Instant Steal Steps":{"Value":2,"Type":"slider"},"Instant Steal Zones":{"Value":["Titan Temple","Light Dark","Enchanted Forest"],"Type":"multidropdown"},"Target Areas":{"Value":["Cherry Blossom","Light Dark","Titan Temple","Enchanted Forest"],"Type":"multidropdown"},"Unstable DNA Lab Eggs":{"Value":["Toro Egg (24%)","Winged Lamb Egg (23%)","Bladehide Egg (23%)","Imp Egg (22%)","Crustacia Egg (22%)"],"Type":"multidropdown"},"Stock Per Egg":{"Value":3,"Type":"slider","Unit":""},"Auto Steal":{"Value":true,"Type":"toggle"},"Min Rarity":{"Value":"Secret","Type":"dropdown"},"Teleport To Egg":{"Value":true,"Type":"toggle"},"Carry Speed":{"Value":120,"Type":"slider","Unit":"%"},"Experimental Lab Eggs":{"Value":["Bladehide Egg (34%)","Red Panda Egg (34%)","Crustacia Egg (33%)","Salamander Egg (33%)","Snowy Owl Egg (32%)"],"Type":"multidropdown"},"Fast Delivery":{"Value":true,"Type":"toggle"},"Skip Owned Lab Eggs":{"Value":true,"Type":"toggle"},"Steal Priority":{"Value":"Highest Value","Type":"dropdown"},"Instant Steal V2":{"Value":true,"Type":"toggle"},"Instant Steal":{"Value":false,"Type":"toggle"},"Steal Missing Index Eggs":{"Value":false,"Type":"toggle"},"Min Steal Value":{"Value":700.11,"Type":"slider"},"Tween Speed":{"Value":120,"Type":"slider","Unit":"%"},"Stock Lab Eggs For":{"Value":[],"Type":"multidropdown"}},"Auto Sell":{"Egg Sell Value":{"Value":0,"Type":"slider"},"Sell Egg Rule":{"Value":"Rarity Only","Type":"dropdown"},"Auto Sell Egg":{"Value":false,"Type":"toggle"},"Blacklist Sell Eggs":{"Value":[],"Type":"multidropdown"},"Keep Mutated Eggs":{"Value":true,"Type":"toggle"},"Egg Max Rarity":{"Value":"3 - Rare","Type":"dropdown"},"Blacklist Sell Pets":{"Value":[],"Type":"multidropdown"},"Egg Sell Preview":{"Value":"Egg matches  -  0 eggs for $0","Type":"text"},"Auto Sell Pet":{"Value":false,"Type":"toggle"},"Pet Sell Value":{"Value":777.78,"Type":"slider"},"Pet Sell Preview":{"Value":"Pet matches  -  0 pets for $0","Type":"text"},"Keep Mutated Pets":{"Value":false,"Type":"toggle"},"Sell Pet Rule":{"Value":"Rarity Only","Type":"dropdown"},"Pet Max Rarity":{"Value":"8 - Secret","Type":"dropdown"}},"Auto Fuse Machine":{"Max Rarity to Fuse":{"Value":"6 - Mythic","Type":"dropdown"},"Skip Mutated Pets":{"Value":true,"Type":"toggle"},"Auto Fuse Machine":{"Value":true,"Type":"toggle"},"Specific Species to Fuse":{"Value":[],"Type":"multidropdown"},"Eject Incomplete Slots":{"Value":true,"Type":"toggle"},"Pets To Use":{"Value":"Lowest To Highest","Type":"dropdown"},"Fuse Priority Mode":{"Value":"Lowest Rarity First","Type":"dropdown"},"Fuse Preview":{"Value":"Không đủ 3 pet trùng khớp","Type":"text"}},"Auto Favorite":{"Favorite Mutations":{"Value":[],"Type":"multidropdown"},"Favorite Preview":{"Value":"Favorite matches  -  5 pets, 0 to mark  |  23 favorited","Type":"text"},"Favorite Min Rarity":{"Value":"10 - Divine","Type":"dropdown"},"Auto Favorite Equipped":{"Value":true,"Type":"toggle"},"Auto Favorite Pet":{"Value":true,"Type":"toggle"},"Always Favorite Species":{"Value":[],"Type":"multidropdown"},"Min Favorite Value":{"Value":797.34,"Type":"slider"},"Auto Unfavorite Equipped":{"Value":true,"Type":"toggle"},"Favorite Rule":{"Value":"Match All","Type":"dropdown"}},"Auto Treadmill":{"Stay On Treadmill":{"Value":true,"Type":"toggle"},"Auto Treadmill":{"Value":true,"Type":"toggle"}},"Auto Place Egg":{"Place Egg Rule":{"Value":"Always","Type":"dropdown"},"Place Rarities":{"Value":[],"Type":"multidropdown"},"Pen Status":{"Value":"Eggs placed 5/30  -  19/19 pets equipped, 0 in bag","Type":"text"},"Auto Place Egg":{"Value":true,"Type":"toggle"},"Place Egg Order":{"Value":"Highest Value","Type":"dropdown"},"Min Place Value":{"Value":0,"Type":"slider"},"Place Specific Eggs":{"Value":[],"Type":"multidropdown"}},"Wisp Companion":{"Auto Banjo Cricket":{"Value":true,"Type":"toggle"},"Auto Wisp":{"Value":true,"Type":"toggle"},"Wisp Status":{"Value":"Banjo Cricket: Done, Cricket's Banjo is yours","Type":"text"}},"Butterfly Bloom":{"Auto Butterfly Bloom":{"Value":true,"Type":"toggle"},"Trade Up Tiers":{"Value":["Emerald To Sapphire","Sapphire To Amethyst","Amethyst To Radiant"],"Type":"multidropdown"},"Auto Craft Essence":{"Value":true,"Type":"toggle"},"Auto Trade Up":{"Value":true,"Type":"toggle"},"Catch Priority":{"Value":"Rarest","Type":"dropdown"},"Tween Speed  ":{"Value":600,"Type":"slider","Unit":"studs/s"},"Catch Mode":{"Value":"Chase","Type":"dropdown"},"Catch Butterflies":{"Value":["Radiant Butterfly","Amethyst Butterfly","Sapphire Butterfly","Emerald Butterfly"],"Type":"multidropdown"},"Smart Trade For Essence":{"Value":true,"Type":"toggle"}},"Racing Event":{"Race Speed":{"Value":400,"Type":"slider"},"Auto Race":{"Value":true,"Type":"toggle"},"Race Shop Items":{"Value":["Nitro Mutation"],"Type":"multidropdown"},"Auto Equip Racer":{"Value":true,"Type":"toggle"},"Auto Buy Race Shop":{"Value":true,"Type":"toggle"},"Auto Claim Race Rewards":{"Value":true,"Type":"toggle"},"Auto Use Power-Ups":{"Value":true,"Type":"toggle"},"Racer":{"Value":"Best Owned","Type":"dropdown"}},"Auto Mutation":{"Mutate Priority":{"Value":"Highest Value","Type":"dropdown"},"Mutations To Use":{"Value":["Fractured","Scrambled","Enchanted","Nitro"],"Type":"multidropdown"},"Mutate Target Eggs":{"Value":[],"Type":"multidropdown"},"Mutate Min Value":{"Value":797.34,"Type":"slider"},"Auto Mutate":{"Value":true,"Type":"toggle"},"Mutate Status":{"Value":"Waiting  |  No egg to mutate","Type":"text"},"Auto Buy Nitro":{"Value":true,"Type":"toggle"},"Mutate Min Rarity":{"Value":"Secret","Type":"dropdown"}},"Auto Sell Lab Egg":{"Lab Egg Sell Value":{"Value":700.11,"Type":"slider"},"Sell Lab Egg Rule":{"Value":"Rarity And Value","Type":"dropdown"},"Lab Egg Max Rarity":{"Value":"Off","Type":"dropdown"},"Auto Sell Lab Egg":{"Value":true,"Type":"toggle"},"Lab Egg Sell Preview":{"Value":"Lab egg matches  -  0 eggs for $0","Type":"text"},"Keep Lab Pets":{"Value":[],"Type":"multidropdown"},"Keep Mutated Lab Eggs":{"Value":true,"Type":"toggle"}},"Auto Hatch & Equip":{"Hatch Specific Eggs":{"Value":[],"Type":"multidropdown"},"Auto Hatch":{"Value":false,"Type":"toggle"},"Hatch Min Rarity":{"Value":"Any","Type":"dropdown"},"Min Hatch Value":{"Value":0,"Type":"slider"},"Auto Equip Best":{"Value":true,"Type":"toggle"}},"Dr Scramble Lab":{"Lab Banners":{"Value":[],"Type":"multidropdown"},"Lab Status":{"Value":"Unstable DNA  -  needs Flame Sprite, Salamander, Bladehide  -  pity 0/100  -  free rerolls 0  -  rotates in 19:58  -  Need a Flame Sprite egg","Type":"text"},"Auto Place Lab Reward Eggs":{"Value":true,"Type":"toggle"},"Auto Reroll Lab Recipe":{"Value":true,"Type":"toggle"},"Auto Lab Trade-In":{"Value":true,"Type":"toggle"}},"Shooting Star":{"Auto Catch Shooting Star":{"Value":true,"Type":"toggle"},"Shooting Star Status":{"Value":"Đang chờ sao băng rơi","Type":"text"}}},"Misc":{"Performance":{"Optimizer":{"Value":true,"Type":"toggle"},"Farm HUD":{"Value":false,"Type":"toggle"},"Background Color":{"Value":"White","Type":"dropdown"},"Egg Card Image":{"Value":"Egg Image","Type":"dropdown"},"Disable 3D Render":{"Value":false,"Type":"toggle"},"FPS and Ping":{"Value":true,"Type":"toggle"},"FPS Cap":{"Value":240,"Type":"slider","Unit":" FPS"},"HUD Size":{"Value":70,"Type":"slider","Unit":"%"},"Showcase Cards":{"Value":4,"Type":"slider"},"Hide Game UI":{"Value":true,"Type":"toggle"},"HUD Items":{"Value":["Money","Income","Speed","Treadmill","Eggs Stolen","Best Steal","Night Timer","Session Time","Activity","Racing Event","Race Wins","Shooting Star","Pets","Eggs","Top Pets","Top Eggs","Steal History"],"Type":"multidropdown"},"FPS and Ping Size":{"Value":100,"Type":"slider","Unit":"%"}},"Utility":{"Anti AFK":{"Value":true,"Type":"toggle"}}},"Server":{"Server":{"Server Hop Mode":{"Value":"Least Players","Type":"dropdown"},"Auto Load Script":{"Value":true,"Type":"toggle"},"Auto Rejoin When Disconnect":{"Value":true,"Type":"toggle"}}}},"SavedAt":1791729602},"Format":"ChilliLibraryConfig","ExportVersion":1,"Name":"main"}]===]

-- ==================== 4. TỪ ĐIỂN DỊCH THUẬT V3.8 ====================
local currentLanguage = "VI"
local FastCache = {}
local switchGlobalLanguage = nil
local updateIslandContentLanguage = nil
local updateToastLanguage = nil

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

local EXACT_MATCH_VI = {
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
    ["Highest To Lowest"] = "Từ cao đến thấp",
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
    ["TOTAL / S"] = "TỔNG / GIÂY",
    ["WAITING"] = "ĐANG CHỜ",
    ["INACTIVE"] = "KHÔNG HOẠT ĐỘNG"
}

local MAP_VI = {
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
    ["Anti Guard"] = "Chống Vệ Sĩ",

    ["Auto Progression"] = "Tự Động Tiến Trình",
    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Chỉ Mục",
    ["Claim index rewards as soon as they unlock"] = "Nhận thưởng chỉ mục ngay khi mở khóa",
    ["Auto Claim"] = "Tự Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền offline & thưởng chỉ mục",

    ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Server Hop"] = "Đổi Server",
    ["Job ID"] = "Mã Phòng (Job ID)",
    ["Paste a server Job ID..."] = "Dán mã Job ID máy chủ...",
    ["Join Job ID"] = "Vào Bằng Job ID",
    ["Copy Current Job ID"] = "Sao Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Máy Chủ",
    ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",

    ["Performance"] = "Hiệu Năng",
    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để tối đa FPS",
    ["FPS and Ping Size"] = "Cỡ FPS & Ping",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D",
    ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Utility"] = "Tiện Ích",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",

    ["Egg Finder"] = "Dò Tìm Trứng",
    ["Joins new servers to find eggs that match the filters below"] = "Tự vào server mới để tìm trứng khớp bộ lọc dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Máy Chủ để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server",
    ["When to move on to the next server"] = "Thời điểm chuyển sang máy chủ tiếp theo",
    ["Rarity To Wait For"] = "Độ Hiếm Cần Đợi",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ sau khi xuất hiện trứng từ độ hiếm này trở lên",
    ["For After A Rare Spawns: this rarity or higher"] = "Chờ sau khi xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với Tự Động Cướp",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu",
    ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",
    ["Min Value To Find"] = "Giá Trị Min Cần Tìm",
    ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Target Specific Eggs"] = "Mục Tiêu Trứng Chỉ Định",
    ["Only look for these eggs (empty = all)"] = "Chỉ tìm các trứng này (trống = tất cả)",
    ["Target Areas"] = "Khu Vực Mục Tiêu",

    ["Discord Webhook"] = "Webhook Discord",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng",
    ["Post eggs you bring home that match the filter"] = "Gửi thông báo các trứng mang về khớp bộ lọc",
    ["Notify Fused Eggs"] = "Báo Cáo Trứng Dung Hợp",
    ["Post eggs from the Fuse Machine that match the filter"] = "Gửi thông báo các trứng từ Máy Dung Hợp khớp bộ lọc",
    ["Webhook Độ Hiếm Min"] = "Độ Hiếm Webhook Min",
    ["Webhook Min Rarity"] = "Độ Hiếm Webhook Min",
    ["Only post eggs of this rarity and above"] = "Chỉ gửi trứng từ độ hiếm này trở lên",
    ["Webhook Min Value"] = "Giá Trị Webhook Min",
    ["Only post eggs worth at least this. Drag or type 350k, 50m, 10b"] = "Chỉ gửi trứng đạt giá trị tối thiểu mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["Egg Dự Đoán"] = "Dự Đoán Trứng",
    ["Egg Predictor"] = "Dự Đoán Trứng",
    ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp",
    ["Sort By"] = "Sắp Xếp Theo",
    ["Preview Card"] = "Thẻ Xem Trước",
    ["Search eggs..."] = "Tìm kiếm trứng...",
    ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",

    ["Capture The Egg"] = "Cướp Trứng Sự Kiện",
    ["Turn on Capture The Egg below to join the event"] = "Bật Cướp Trứng Sự Kiện bên dưới để tham gia",
    ["Auto Capture Event Egg"] = "Tự Cướp Trứng Sự Kiện",
    ["Take It From The Holder"] = "Giật Trứng Từ Người Bê",
    ["Hold Height"] = "Độ Cao Bê Trứng",
    ["Keep Away Distance"] = "Khoảng Cách Giữ An Toàn",
    ["Admin Treadmill"] = "Máy Tập Admin",
    ["Waiting for the Admin Treadmill"] = "Đang chờ Máy Tập Admin",
    ["Auto Use Admin Treadmill"] = "Tự Dùng Máy Tập Admin",
    ["Instant Steal V3 Note"] = "Ghi Chú Cướp Siêu Tốc V3",
    ["Instant Steal V3"] = "Cướp Siêu Tốc V3",
    ["Instant Steal V2"] = "Cướp Siêu Tốc V2",
    ["Instant Steal"] = "Cướp Siêu Tốc",
    ["Needs Admin Treadmill"] = "Cần Máy Tập Admin",
    ["Toggle is off"] = "Đang tắt",

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
    ["Mutate Priority"] = "Ưu Tiên Đột Biến",
    ["Mutations To Use"] = "Loại Đột Biến Dùng",
    ["Mutate Target Eggs"] = "Mục Tiêu Trứng Đột Biến",
    ["Mutate Min Value"] = "Giá Trị Đột Biến Min",
    ["Auto Mutate"] = "Tự Động Đột Biến",
    ["Mutate Status"] = "Trạng Thái Đột Biến",
    ["Auto Buy Nitro"] = "Tự Mua Nitro",
    ["Mutate Min Rarity"] = "Độ Hiếm Đột Biến Min",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Steal Value"] = "Giá Trị Cướp Min",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu",
    ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp trứng thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Carry Speed"] = "Tốc Độ Bê Trứng",
    ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ",
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
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab",
    ["Lab Egg Max Rarity"] = "Độ Hiếm Bán Trứng Lab Max",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab",
    ["No three matching pets"] = "Không đủ 3 pet trùng khớp",
    ["Fuse 3 same pets into an egg, nonstop"] = "Dung hợp 3 pet cùng loại thành 1 trứng liên tục",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Dung Hợp",
    ["Pets To Use"] = "Loại Pet Sử Dụng",
    ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Dung Hợp",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến",
    ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ",
    ["Auto Favorite Pet"] = "Tự Động Khóa Pet",
    ["Favorite Pets Now"] = "Khóa Pet Ngay",
    ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min",
    ["Favorite Mutations"] = "Đột Biến Cần Khóa",
    ["Min Favorite Value"] = "Giá Trị Khóa Min",
    ["Always Favorite Species"] = "Luôn Khóa Các Loài Này",
    ["Auto Favorite Equipped"] = "Tự Khóa Pet Đang Dùng",
    ["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Pet Đang Dùng",
    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm",
    ["Catch Mode"] = "Chế Độ Bắt",
    ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Catch Butterflies"] = "Chọn Bướm Muốn Bắt",
    ["Radiant Butterfly"] = "Bướm Rực Rỡ",
    ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím",
    ["Sapphire Butterfly"] = "Bướm Lam Ngọc (Sapphire)",
    ["Emerald Butterfly"] = "Bướm Lục Bảo (Emerald)",
    ["Auto Trade Up"] = "Tự Nâng Cấp Bướm",
    ["Trade Up Tiers"] = "Bậc Nâng Cấp",
    ["Smart Trade For Essence"] = "Đổi Bướm Lấy Tinh Chất Thông Minh",
    ["Going to the middle of the bloom"] = "Đang đi tới trung tâm khu bướm nở",
    ["Auto Craft Essence"] = "Tự Chế Tạo Tinh Chất",
    ["Auto Use Enchanted Essence"] = "Tự Dùng Tinh Chất Phù Phép",
    ["Auto Wisp"] = "Tự Động Nhặt Wisp",
    ["Auto Banjo Cricket"] = "Tự Động Bắt Dế Banjo",
    ["Chase Settings"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh",
    ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Mục Tiêu (Hit Lead)",
    ["Hit Sweep"] = "Quét Đòn Đánh (Hit Sweep)",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất",
    ["Auto Hit Egg Holders"] = "Tự Đánh Người Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định",
    ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
    ["Speed Boost"] = "Tăng Tốc Chạy",
    ["Boost Speed"] = "Tốc Độ Tăng Tốc",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)",
    ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Instant Prompts"] = "Tương Tác Nhanh (Instant E)",
    ["ESP Eggs"] = "ESP Trứng",
    ["ESP Guards"] = "ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi",
    ["ESP Players"] = "ESP Người Chơi",
    ["Set Startup Config"] = "Cài Đặt Khởi Động",
    ["Startup Config"] = "Cấu Hình Khởi Động",
    ["Set Startup"] = "Cài Khởi Động",
    ["Load Config"] = "Tải Cấu Hình",
    ["Save Config"] = "Lưu Cấu Hình",
    ["Import / Export"] = "Nhập / Xuất Cấu Hình",
    ["Export Config"] = "Xuất Cấu Hình",
    ["Import Config Text"] = "Nhập Văn Bản Cấu Hình",
    ["Import Config"] = "Nhập Cấu Hình",
    ["Creates a config only; use Load Config or Set Startup after"] = "Chỉ tạo cấu hình; hãy dùng Tải Cấu Hình hoặc Cài Khởi Động sau",
    ["Pick a config, then press Load to apply it now"] = "Chọn một cấu hình, sau đó bấm Tải để áp dụng ngay",
    ["selected"] = "đã chọn"
}

local DYNAMIC_PATTERNS = {
    { pattern = "ALL (%d+)", format = function(l, c) return l == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end },
    { pattern = "READY (%d+)", format = function(l, c) return l == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end },
    { pattern = "GROWING (%d+)", format = function(l, c) return l == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end },
    { pattern = "IN BAG (%d+)", format = function(l, c) return l == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end },
    { pattern = "Ends in (%d+h %d+m %d+s)", format = function(l, t) return l == "VI" and ("Kết thúc sau " .. t) or ("Ends in " .. t) end },
    { pattern = "Players (%d+)/(%d+)", format = function(l, p1, p2) return l == "VI" and string.format("Người chơi %s/%s", p1, p2) or string.format("Players %s/%s", p1, p2) end },
    { pattern = "#(%d+) of (%d+) eggs by value", format = function(l, r, t) return l == "VI" and string.format("#%s / %s trứng theo giá trị", r, t) or string.format("#%s of %s eggs by value", r, t) end },
    { pattern = "Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag", format = function(l, p1, p2, p3, p4, p5)
        return l == "VI" and string.format("Trứng đã đặt %s/%s - %s/%s pet trang bị, %s trong túi", p1, p2, p3, p4, p5) or string.format("Eggs placed %s/%s - %s/%s pets equipped, %s in bag", p1, p2, p3, p4, p5)
    end },
    { pattern = "Pet matches %- (%d+) pets? for %$(.+)", format = function(l, c, v)
        return l == "VI" and string.format("Khớp pet - %s pet giá $%s", c, v) or string.format("Pet matches - %s pets for $%s", c, v)
    end },
    { pattern = "Egg matches %- (%d+) eggs? for %$(.+)", format = function(l, c, v)
        return l == "VI" and string.format("Khớp trứng - %s trứng giá $%s", c, v) or string.format("Egg matches - %s eggs for $%s", c, v)
    end }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if raw:find("Chilli Hub") then
        local fixedBrand = raw:gsub("Chilli Hub%s*V?[%d%.]*", "Chilli Hub V3.8")
        if raw:match("^%s*Chilli Hub") then
            FastCache[cacheKey] = fixedBrand
            return fixedBrand
        end
        raw = fixedBrand
    end

    if currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
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
            result = result:gsub(item.pattern, function(...)
                return item.format(currentLanguage, ...)
            end)
            matched = true
        end
    end

    for _, item in ipairs(SortedVI) do
        if result:find(item.en, 1, true) then
            result = replaceAll(result, item.en, item.out)
            matched = true
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") or inst:FindFirstAncestor("Chilli_Update_Toast") then return end
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
        task.defer(function()
            inst:SetAttribute("__IsTranslating", false)
        end)
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

-- ==================== 5. ĐỔI MÀU SOFT BLUE & GẮN CHỮ NEW (KHÔNG DÙNG FRAME) ====================
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

    -- XÓA SẠCH MỌI FRAME/BADGE GÂY CỤC ĐEN TRÊN HEADER
    for _, child in ipairs(headerFrame:GetChildren()) do
        if child.Name == "Sparkling_New_Badge" or child.Name:find("Badge") then
            pcall(function() child:Destroy() end)
        end
    end

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

    -- CHỮ NEW VÀNG SÁNG THUẦN TÚY TRÊN TEXT - 100% KHÔNG THỂ BỊ CỤC ĐEN
    if titleObj and (titleObj:IsA("TextLabel") or titleObj:IsA("TextButton")) then
        titleObj.RichText = true
        titleObj.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleObj.Text = 'Chilli Hub V3.8  <font color="#FFE650">✨ NEW</font>'
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
    if inst:FindFirstAncestor("Chilli_Dynamic_Island") or inst:FindFirstAncestor("Chilli_Update_Toast") then return end

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

-- ==================== 6. CLICK AN TOÀN (STEALTH CLICK) ====================
local function stealthClick(inst)
    if not inst then return end
    local targets = {inst}
    if inst.Parent and inst.Parent:IsA("GuiObject") then table.insert(targets, inst.Parent) end
    local btnAncestor = inst:FindFirstAncestorWhichIsA("GuiButton")
    if btnAncestor then table.insert(targets, btnAncestor) end

    for _, obj in ipairs(targets) do
        pcall(function()
            if firesignal then
                firesignal(obj.MouseButton1Click)
                firesignal(obj.Activated)
            end
        end)
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(obj.MouseButton1Click)) do c:Fire() end
                for _, c in ipairs(getconnections(obj.Activated)) do c:Fire() end
            end
        end)
    end
end

-- ==================== 7. ĐỘNG CƠ TỰ ĐỘNG CÀI KHỞI ĐỘNG (CHUẨN VIDEO) ====================
local isConfigInjecting = false

local function executeAutoConfig(statusCallback)
    if isConfigInjecting then return end
    isConfigInjecting = true

    task.spawn(function()
        statusCallback("⏳ Đang nạp...", Color3.fromRGB(255, 210, 90))

        if switchGlobalLanguage then
            switchGlobalLanguage("EN")
            task.wait(0.3)
        end

        local roots = {gethui and gethui(), CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        local chilliGui = nil

        for _, root in ipairs(roots) do
            if root then
                for _, g in ipairs(root:GetChildren()) do
                    if g:IsA("ScreenGui") and g.Name ~= "Chilli_Dynamic_Island" and g.Name ~= "Chilli_Update_Toast" then
                        for _, d in ipairs(g:GetDescendants()) do
                            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text:lower():find("chilli hub") then
                                chilliGui = g; break
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
            if updateIslandContentLanguage then updateIslandContentLanguage(currentLanguage) end
            isConfigInjecting = false; return
        end

        -- 1. Bấm Tab Config
        local configTabElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:lower():match("^%s*(.-)%s*$") or ""
                if t == "config" or t == "cấu hình" then
                    configTabElement = d; break
                end
            end
        end

        if configTabElement then
            stealthClick(configTabElement)
            task.wait(0.35)
        end

        -- 2. Tìm ô TextBox Import
        local importTextBox = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if d:IsA("TextBox") then
                local ph = (d.PlaceholderText or ""):lower()
                if ph:find("exported config") then
                    importTextBox = d; break
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
            if updateIslandContentLanguage then updateIslandContentLanguage(currentLanguage) end
            isConfigInjecting = false; return
        end

        -- 3. Bơm dữ liệu JSON
        importTextBox.Text = RAW_CONFIG_JSON
        task.wait(0.1)

        if getconnections then
            pcall(function()
                for _, conn in ipairs(getconnections(importTextBox.FocusLost)) do conn:Fire(true) end
            end)
        end
        task.wait(0.25)

        -- 4. Bấm nút đỏ "Import"
        local importBtnElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                if t == "Import" or t == "Nhập" then
                    importBtnElement = d; break
                end
            end
        end

        if not importBtnElement then
            statusCallback("❌ Ko thấy nút Import", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            if updateIslandContentLanguage then updateIslandContentLanguage(currentLanguage) end
            isConfigInjecting = false; return
        end

        stealthClick(importBtnElement)
        task.wait(0.9)

        -- 5. Mở Dropdown "Load Config"
        local loadDropdownElement = nil
        for _, lbl in ipairs(chilliGui:GetDescendants()) do
            if lbl:IsA("TextLabel") and (lbl.Text:find("Load Config") or lbl.Text:find("Tải Cấu Hình")) then
                local row = lbl.Parent
                if row then
                    loadDropdownElement = row:FindFirstChildWhichIsA("GuiButton", true)
                    if not loadDropdownElement then
                        for _, c in ipairs(row:GetDescendants()) do
                            if (c:IsA("TextLabel") or c:IsA("TextButton")) and c.Text:find("Default") then
                                loadDropdownElement = c; break
                            end
                        end
                    end
                end
                break
            end
        end

        if loadDropdownElement then
            stealthClick(loadDropdownElement)
            task.wait(0.35)
        end

        -- 6. Chọn profile "main"
        local mainProfileElement = nil
        local t0 = tick()
        while tick() - t0 < 4 do
            for _, d in ipairs(chilliGui:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                    local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                    if t:lower() == "main" then
                        mainProfileElement = d; break
                    end
                end
            end
            if mainProfileElement then break end
            task.wait(0.12)
        end

        if not mainProfileElement then
            statusCallback("❌ Ko có profile main", Color3.fromRGB(255, 90, 90))
            task.wait(2)
            if updateIslandContentLanguage then updateIslandContentLanguage(currentLanguage) end
            isConfigInjecting = false; return
        end

        stealthClick(mainProfileElement)
        task.wait(0.35)

        -- 7. Bấm nút đỏ "Load"
        local loadBtnElement = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                if t == "Load" or t == "Tải" then
                    loadBtnElement = d; break
                end
            end
        end

        if loadBtnElement then
            stealthClick(loadBtnElement)
            task.wait(0.4)
        end

        -- 8. BƯỚC CÀI KHỞI ĐỘNG (CHUẨN VIDEO)
        statusCallback("⏳ Cài khởi động...", Color3.fromRGB(255, 210, 90))
        task.wait(0.35)

        local startupDropdown = nil
        for _, lbl in ipairs(chilliGui:GetDescendants()) do
            if lbl:IsA("TextLabel") and (lbl.Text:find("Startup Config") or lbl.Text:find("Set Startup") or lbl.Text:find("Cấu Hình Khởi Động")) then
                local row = lbl.Parent
                if row then
                    startupDropdown = row:FindFirstChildWhichIsA("GuiButton", true)
                    if not startupDropdown then
                        for _, c in ipairs(row:GetDescendants()) do
                            if (c:IsA("TextLabel") or c:IsA("TextButton")) and (c.Text:find("Default") or c.Text:find("main")) then
                                startupDropdown = c; break
                            end
                        end
                    end
                end
                if startupDropdown then break end
            end
        end

        if startupDropdown then
            stealthClick(startupDropdown)
            task.wait(0.35)
        end

        local startupItem = nil
        local tStart = tick()
        while tick() - tStart < 3.5 do
            for _, d in ipairs(chilliGui:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                    local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                    if t:lower() == "main" then
                        startupItem = d; break
                    end
                end
            end
            if startupItem then break end
            task.wait(0.1)
        end

        if startupItem then
            stealthClick(startupItem)
            task.wait(0.35)
        end

        local setStartupBtn = nil
        for _, d in ipairs(chilliGui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
                local t = d.Text:gsub("%s+", " "):match("^%s*(.-)%s*$") or ""
                if t == "Set Startup" or t == "Set" or t == "Cài Khởi Động" then
                    setStartupBtn = d; break
                end
            end
        end

        if setStartupBtn then
            stealthClick(setStartupBtn)
            task.wait(0.4)
        end

        -- 9. CHUYỂN TOÀN BỘ VỀ TIẾNG VIỆT
        if switchGlobalLanguage then
            switchGlobalLanguage("VI")
        end

        statusCallback("✔ HOÀN TẤT A-Z!", Color3.fromRGB(110, 245, 140))
        task.wait(2.2)
        if updateIslandContentLanguage then updateIslandContentLanguage(currentLanguage) end
        isConfigInjecting = false
    end)
end

-- ==================== 8. THÔNG BÁO V3.8 TOAST (10S TỰ BIẾN MẤT - KHÔNG NÚT X) ====================
local function createUpdateToast()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local oldToast = parentTarget:FindFirstChild("Chilli_Update_Toast")
    if oldToast then oldToast:Destroy() end

    local ToastGui = Instance.new("ScreenGui")
    ToastGui.Name = "Chilli_Update_Toast"
    ToastGui.ResetOnSpawn = false
    ToastGui.IgnoreGuiInset = true
    ToastGui.DisplayOrder = 2147483646
    ToastGui.Parent = parentTarget

    local ToastFrame = Instance.new("Frame")
    ToastFrame.Name = "ToastFrame"
    ToastFrame.Size = UDim2.new(0, 325, 0, 48)
    ToastFrame.AnchorPoint = Vector2.new(0.5, 0)
    ToastFrame.Position = UDim2.new(0.5, 0, 0, -70)
    ToastFrame.BackgroundColor3 = Color3.fromRGB(12, 18, 28)
    ToastFrame.BackgroundTransparency = 0.12
    ToastFrame.BorderSizePixel = 0
    ToastFrame.ClipsDescendants = true
    ToastFrame.Parent = ToastGui

    local ToastCorner = Instance.new("UICorner")
    ToastCorner.CornerRadius = UDim.new(0, 10)
    ToastCorner.Parent = ToastFrame

    local ToastStroke = Instance.new("UIStroke")
    ToastStroke.Thickness = 1.2
    ToastStroke.Color = Color3.fromRGB(0, 215, 255)
    ToastStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ToastStroke.Parent = ToastFrame

    local ToastGrad = Instance.new("UIGradient")
    ToastGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 230, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 95, 140)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 230, 255))
    })
    ToastGrad.Rotation = 45
    ToastGrad.Parent = ToastStroke

    local TagBadge = Instance.new("Frame")
    TagBadge.Size = UDim2.new(0, 48, 0, 20)
    TagBadge.Position = UDim2.new(0, 9, 0.5, -10)
    TagBadge.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    TagBadge.BorderSizePixel = 0
    TagBadge.Parent = ToastFrame

    local TagCorner = Instance.new("UICorner")
    TagCorner.CornerRadius = UDim.new(0, 5)
    TagCorner.Parent = TagBadge

    local TagLabel = Instance.new("TextLabel")
    TagLabel.Size = UDim2.new(1, 0, 1, 0)
    TagLabel.BackgroundTransparency = 1
    TagLabel.Text = "🚀 V3.8"
    TagLabel.Font = Enum.Font.GothamBlack
    TagLabel.TextSize = 8.5
    TagLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TagLabel.Parent = TagBadge

    local ToastText = Instance.new("TextLabel")
    ToastText.Size = UDim2.new(1, -68, 1, -8)
    ToastText.Position = UDim2.new(0, 63, 0, 4)
    ToastText.BackgroundTransparency = 1
    ToastText.Font = Enum.Font.GothamMedium
    ToastText.TextSize = 8.8
    ToastText.TextColor3 = Color3.fromRGB(235, 245, 255)
    ToastText.TextXAlignment = Enum.TextXAlignment.Left
    ToastText.TextWrapped = true
    ToastText.Text = "+ Bản cập nhật mới đã sửa lỗi sự kiện đua xe tự động.\n+ và sửa các lỗi lặt vặt khác"
    ToastText.Parent = ToastFrame

    TweenService:Create(ToastFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0, 52)
    }):Play()

    -- ĐÚNG 10 GIÂY TỰ BIẾN MẤT (KHÔNG NÚT X)
    task.delay(10, function()
        if ToastFrame and ToastFrame.Parent then
            TweenService:Create(ToastFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, 0, -70)
            }):Play()
            task.delay(0.5, function() pcall(function() ToastGui:Destroy() end) end)
        end
    end)

    updateToastLanguage = function(lang)
        if ToastText and ToastText.Parent then
            if lang == "VI" then
                ToastText.Text = "+ Bản cập nhật mới đã sửa lỗi sự kiện đua xe tự động.\n+ và sửa các lỗi lặt vặt khác"
            else
                ToastText.Text = "+ new update fixed the auto-racing event.\n+ and fix other minor bugs"
            end
        end
    end
end

-- ==================== 9. DYNAMIC ISLAND MORPHING ====================
local function createDynamicIslandUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local oldIsland = parentTarget:FindFirstChild("Chilli_Dynamic_Island")
    if oldIsland then oldIsland:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_Dynamic_Island"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local isExpanded = false

    local Island = Instance.new("Frame")
    Island.Name = "Island"
    Island.Size = UDim2.new(0, 172, 0, 36)
    Island.AnchorPoint = Vector2.new(0.5, 0)
    Island.Position = UDim2.new(0.5, 0, 0, 10)
    Island.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
    Island.BackgroundTransparency = 0.08
    Island.BorderSizePixel = 0
    Island.ClipsDescendants = true
    Island.Parent = ScreenGui

    local IslandCorner = Instance.new("UICorner")
    IslandCorner.CornerRadius = UDim.new(1, 0)
    IslandCorner.Parent = Island

    local IslandStroke = Instance.new("UIStroke")
    IslandStroke.Thickness = 1.4
    IslandStroke.Color = COLOR_FACE_TOP
    IslandStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    IslandStroke.Parent = Island

    -- VIEW THU GỌN
    local CollapsedView = Instance.new("TextButton")
    CollapsedView.Name = "CollapsedView"
    CollapsedView.Size = UDim2.new(1, 0, 0, 36)
    CollapsedView.BackgroundTransparency = 1
    CollapsedView.Text = ""
    CollapsedView.Parent = Island

    local DotStatus = Instance.new("Frame")
    DotStatus.Size = UDim2.new(0, 7, 0, 7)
    DotStatus.Position = UDim2.new(0, 14, 0.5, -3)
    DotStatus.BackgroundColor3 = Color3.fromRGB(90, 240, 140)
    DotStatus.BorderSizePixel = 0
    DotStatus.Parent = CollapsedView

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = DotStatus

    local IslandTitle = Instance.new("TextLabel")
    IslandTitle.Size = UDim2.new(1, -55, 1, 0)
    IslandTitle.Position = UDim2.new(0, 28, 0, 0)
    IslandTitle.BackgroundTransparency = 1
    IslandTitle.Text = "🌶️ Chilli Hub V3.8"
    IslandTitle.Font = Enum.Font.GothamBold
    IslandTitle.TextSize = 11
    IslandTitle.TextColor3 = Color3.fromRGB(245, 250, 255)
    IslandTitle.TextXAlignment = Enum.TextXAlignment.Left
    IslandTitle.Parent = CollapsedView

    local ChevronIcon = Instance.new("TextLabel")
    ChevronIcon.Size = UDim2.new(0, 20, 1, 0)
    ChevronIcon.Position = UDim2.new(1, -26, 0, 0)
    ChevronIcon.BackgroundTransparency = 1
    ChevronIcon.Text = "▼"
    ChevronIcon.Font = Enum.Font.GothamBold
    ChevronIcon.TextSize = 10
    ChevronIcon.TextColor3 = Color3.fromRGB(150, 195, 245)
    ChevronIcon.Parent = CollapsedView

    -- VIEW MỞ RỘNG
    local ExpandedView = Instance.new("Frame")
    ExpandedView.Name = "ExpandedView"
    ExpandedView.Size = UDim2.new(1, 0, 1, 0)
    ExpandedView.BackgroundTransparency = 1
    ExpandedView.Visible = false
    ExpandedView.Parent = Island

    local ExpHeader = Instance.new("Frame")
    ExpHeader.Size = UDim2.new(1, 0, 0, 32)
    ExpHeader.BackgroundTransparency = 1
    ExpHeader.Parent = ExpandedView

    local ExpTitle = Instance.new("TextLabel")
    ExpTitle.Size = UDim2.new(1, -50, 1, 0)
    ExpTitle.Position = UDim2.new(0, 14, 0, 0)
    ExpTitle.BackgroundTransparency = 1
    ExpTitle.Text = "🌶️ Chilli Hub V3.8 Control"
    ExpTitle.Font = Enum.Font.GothamBold
    ExpTitle.TextSize = 11
    ExpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExpTitle.TextXAlignment = Enum.TextXAlignment.Left
    ExpTitle.Parent = ExpHeader

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -34, 0, 3)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 32, 48)
    CloseBtn.Text = "▲"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 11
    CloseBtn.TextColor3 = Color3.fromRGB(150, 200, 255)
    CloseBtn.Parent = ExpHeader

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseBtn

    -- Hàng 1: Nút dịch Liquid Capsule bên trong Island
    local LangCapsule = Instance.new("Frame")
    LangCapsule.Size = UDim2.new(1, -24, 0, 32)
    LangCapsule.Position = UDim2.new(0, 12, 0, 34)
    LangCapsule.BackgroundColor3 = Color3.fromRGB(16, 22, 34)
    LangCapsule.BorderSizePixel = 0
    LangCapsule.Parent = ExpandedView

    local LangCorner = Instance.new("UICorner")
    LangCorner.CornerRadius = UDim.new(1, 0)
    LangCorner.Parent = LangCapsule

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -2, 1, -4)
    LangSlider.Position = UDim2.new(0, 2, 0, 2)
    LangSlider.BackgroundColor3 = COLOR_FACE_BOTTOM
    LangSlider.BorderSizePixel = 0
    LangSlider.Parent = LangCapsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = LangSlider

    local SliderGrad = Instance.new("UIGradient")
    SliderGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    SliderGrad.Rotation = 90
    SliderGrad.Parent = LangSlider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.Position = UDim2.new(0, 0, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 TIẾNG VIỆT"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.ZIndex = 5
    BtnVI.Parent = LangCapsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(145, 160, 185)
    BtnEN.ZIndex = 5
    BtnEN.Parent = LangCapsule

    -- Hàng 2: Thẻ Thông Báo Update V3.8
    local UpdateNoticeCard = Instance.new("Frame")
    UpdateNoticeCard.Name = "UpdateNoticeCard"
    UpdateNoticeCard.Size = UDim2.new(1, -24, 0, 36)
    UpdateNoticeCard.Position = UDim2.new(0, 12, 0, 72)
    UpdateNoticeCard.BackgroundColor3 = Color3.fromRGB(15, 22, 36)
    UpdateNoticeCard.BorderSizePixel = 0
    UpdateNoticeCard.Parent = ExpandedView

    local UpdateCorner = Instance.new("UICorner")
    UpdateCorner.CornerRadius = UDim.new(0, 7)
    UpdateCorner.Parent = UpdateNoticeCard

    local UpdateStroke = Instance.new("UIStroke")
    UpdateStroke.Thickness = 1
    UpdateStroke.Color = Color3.fromRGB(0, 180, 255)
    UpdateStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UpdateStroke.Parent = UpdateNoticeCard

    local NoticeTag = Instance.new("TextLabel")
    NoticeTag.Size = UDim2.new(0, 48, 1, 0)
    NoticeTag.Position = UDim2.new(0, 6, 0, 0)
    NoticeTag.BackgroundTransparency = 1
    NoticeTag.Text = "📢 V3.8:"
    NoticeTag.Font = Enum.Font.GothamBlack
    NoticeTag.TextSize = 9.5
    NoticeTag.TextColor3 = Color3.fromRGB(0, 230, 255)
    NoticeTag.TextXAlignment = Enum.TextXAlignment.Left
    NoticeTag.Parent = UpdateNoticeCard

    local NoticeContent = Instance.new("TextLabel")
    NoticeContent.Name = "NoticeContent"
    NoticeContent.Size = UDim2.new(1, -56, 1, -4)
    NoticeContent.Position = UDim2.new(0, 52, 0, 2)
    NoticeContent.BackgroundTransparency = 1
    NoticeContent.Font = Enum.Font.GothamMedium
    NoticeContent.TextSize = 8.5
    NoticeContent.TextColor3 = Color3.fromRGB(240, 245, 255)
    NoticeContent.TextXAlignment = Enum.TextXAlignment.Left
    NoticeContent.TextWrapped = true
    NoticeContent.Text = "• Sửa lỗi sự kiện đua xe tự động\n• Sửa các lỗi lặt vặt khác"
    NoticeContent.Parent = UpdateNoticeCard

    -- Hàng 3: Thẻ Setting Auto Farm
    local AutoFarmCard = Instance.new("Frame")
    AutoFarmCard.Size = UDim2.new(1, -24, 0, 96)
    AutoFarmCard.Position = UDim2.new(0, 12, 0, 114)
    AutoFarmCard.BackgroundColor3 = Color3.fromRGB(14, 20, 30)
    AutoFarmCard.BorderSizePixel = 0
    AutoFarmCard.Parent = ExpandedView

    local AutoFarmCorner = Instance.new("UICorner")
    AutoFarmCorner.CornerRadius = UDim.new(0, 10)
    AutoFarmCorner.Parent = AutoFarmCard

    local AutoFarmStroke = Instance.new("UIStroke")
    AutoFarmStroke.Thickness = 1
    AutoFarmStroke.Color = Color3.fromRGB(45, 80, 140)
    AutoFarmStroke.Parent = AutoFarmCard

    local AutoFarmBtn = Instance.new("TextButton")
    AutoFarmBtn.Size = UDim2.new(1, -12, 0, 28)
    AutoFarmBtn.Position = UDim2.new(0, 6, 0, 6)
    AutoFarmBtn.BackgroundColor3 = COLOR_FACE_BOTTOM
    AutoFarmBtn.BorderSizePixel = 0
    AutoFarmBtn.Text = "⚙️ SETTING AUTO FARM"
    AutoFarmBtn.Font = Enum.Font.GothamBold
    AutoFarmBtn.TextSize = 11
    AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoFarmBtn.Parent = AutoFarmCard

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = AutoFarmBtn

    local BtnGrad = Instance.new("UIGradient")
    BtnGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })
    BtnGrad.Rotation = 90
    BtnGrad.Parent = AutoFarmBtn

    local SubLabel = Instance.new("TextLabel")
    SubLabel.Size = UDim2.new(1, -16, 0, 54)
    SubLabel.Position = UDim2.new(0, 8, 0, 37)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Font = Enum.Font.GothamMedium
    SubLabel.TextSize = 8.8
    SubLabel.TextColor3 = Color3.fromRGB(180, 210, 245)
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.TextYAlignment = Enum.TextYAlignment.Top
    SubLabel.TextWrapped = true
    SubLabel.Text = "• Tự động làm từ A-Z\n• Nhặt trứng trên Secret 2B+\n• Tự động chạy máy tập khi rảnh rỗi\n• Tự động làm các nhiệm vụ còn thiếu và sự kiện..."
    SubLabel.Parent = AutoFarmCard

    -- Hàng 4: NÚT TIKTOK CYBER GLASS (LOGO ID 105105387426191)
    local TIKTOK_URL = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-9AU6v4rybwu"

    local TikTokBtn = Instance.new("TextButton")
    TikTokBtn.Name = "TikTokBtn"
    TikTokBtn.Size = UDim2.new(1, -24, 0, 36)
    TikTokBtn.Position = UDim2.new(0, 12, 0, 216)
    TikTokBtn.BackgroundColor3 = Color3.fromRGB(15, 18, 26)
    TikTokBtn.BorderSizePixel = 0
    TikTokBtn.Text = ""
    TikTokBtn.AutoButtonColor = false
    TikTokBtn.Parent = ExpandedView

    local TikTokCorner = Instance.new("UICorner")
    TikTokCorner.CornerRadius = UDim.new(0, 9)
    TikTokCorner.Parent = TikTokBtn

    local TikTokStroke = Instance.new("UIStroke")
    TikTokStroke.Thickness = 1.2
    TikTokStroke.Color = Color3.fromRGB(0, 230, 255)
    TikTokStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    TikTokStroke.Parent = TikTokBtn

    local TikTokStrokeGrad = Instance.new("UIGradient")
    TikTokStrokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 242, 254)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(254, 9, 121)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 242, 254))
    })
    TikTokStrokeGrad.Rotation = 45
    TikTokStrokeGrad.Parent = TikTokStroke

    local AvatarCircle = Instance.new("Frame")
    AvatarCircle.Size = UDim2.new(0, 24, 0, 24)
    AvatarCircle.Position = UDim2.new(0, 8, 0.5, -12)
    AvatarCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    AvatarCircle.BorderSizePixel = 0
    AvatarCircle.Parent = TikTokBtn

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = AvatarCircle

    local AvatarStroke = Instance.new("UIStroke")
    AvatarStroke.Thickness = 1.1
    AvatarStroke.Color = Color3.fromRGB(254, 9, 121)
    AvatarStroke.Parent = AvatarCircle

    local AvatarImg = Instance.new("ImageLabel")
    AvatarImg.Size = UDim2.new(1, -4, 1, -4)
    AvatarImg.Position = UDim2.new(0, 2, 0, 2)
    AvatarImg.BackgroundTransparency = 1
    AvatarImg.Image = "rbxassetid://105105387426191"
    AvatarImg.ScaleType = Enum.ScaleType.Fit
    AvatarImg.Parent = AvatarCircle

    local ImgCorner = Instance.new("UICorner")
    ImgCorner.CornerRadius = UDim.new(1, 0)
    ImgCorner.Parent = AvatarImg

    local TikTokLabel = Instance.new("TextLabel")
    TikTokLabel.Name = "TikTokLabel"
    TikTokLabel.Size = UDim2.new(1, -112, 1, 0)
    TikTokLabel.Position = UDim2.new(0, 38, 0, 0)
    TikTokLabel.BackgroundTransparency = 1
    TikTokLabel.Text = "tiktok:@ronnei7.htk"
    TikTokLabel.Font = Enum.Font.GothamBold
    TikTokLabel.TextSize = 10.5
    TikTokLabel.TextColor3 = Color3.fromRGB(240, 248, 255)
    TikTokLabel.TextXAlignment = Enum.TextXAlignment.Left
    TikTokLabel.Parent = TikTokBtn

    local CopyTag = Instance.new("Frame")
    CopyTag.Name = "CopyTag"
    CopyTag.Size = UDim2.new(0, 68, 0, 22)
    CopyTag.Position = UDim2.new(1, -74, 0.5, -11)
    CopyTag.BackgroundColor3 = Color3.fromRGB(25, 34, 52)
    CopyTag.BorderSizePixel = 0
    CopyTag.Parent = TikTokBtn

    local CopyTagCorner = Instance.new("UICorner")
    CopyTagCorner.CornerRadius = UDim.new(0, 6)
    CopyTagCorner.Parent = CopyTag

    local CopyTagLabel = Instance.new("TextLabel")
    CopyTagLabel.Name = "CopyTagLabel"
    CopyTagLabel.Size = UDim2.new(1, 0, 1, 0)
    CopyTagLabel.BackgroundTransparency = 1
    CopyTagLabel.Text = "📋 SAO CHÉP"
    CopyTagLabel.Font = Enum.Font.GothamBold
    CopyTagLabel.TextSize = 8.5
    CopyTagLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
    CopyTagLabel.Parent = CopyTag

    local isCopiedAnimating = false

    local function triggerCopyLink()
        pcall(function()
            if setclipboard then
                setclipboard(TIKTOK_URL)
            elseif toclipboard then
                toclipboard(TIKTOK_URL)
            end
        end)

        if isCopiedAnimating then return end
        isCopiedAnimating = true

        TweenService:Create(TikTokBtn, TweenInfo.new(0.08), {Size = UDim2.new(1, -28, 0, 34)}):Play()
        task.delay(0.08, function()
            TweenService:Create(TikTokBtn, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, -24, 0, 36)}):Play()
        end)

        local successMsg = (currentLanguage == "VI") and "✔ ĐÃ SAO CHÉP LINK!" or "✔ LINK COPIED!"
        TikTokLabel.Text = successMsg
        TikTokLabel.TextColor3 = Color3.fromRGB(90, 245, 140)
        CopyTagLabel.Text = "✔ XONG"
        CopyTagLabel.TextColor3 = Color3.fromRGB(90, 245, 140)

        task.delay(2, function()
            TikTokLabel.Text = "tiktok:@ronnei7.htk"
            TikTokLabel.TextColor3 = Color3.fromRGB(240, 248, 255)
            CopyTagLabel.Text = (currentLanguage == "VI") and "📋 SAO CHÉP" or "📋 COPY"
            CopyTagLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
            isCopiedAnimating = false
        end)
    end

    TikTokBtn.MouseButton1Click:Connect(triggerCopyLink)

    updateIslandContentLanguage = function(lang)
        if lang == "VI" then
            NoticeTag.Text = "📢 V3.8:"
            NoticeContent.Text = "• Sửa lỗi sự kiện đua xe tự động\n• Sửa các lỗi lặt vặt khác"
            AutoFarmBtn.Text = "⚙️ SETTING AUTO FARM"
            SubLabel.Text = "• Tự động làm từ A-Z\n• Nhặt trứng trên Secret 2B+\n• Tự động chạy máy tập khi rảnh rỗi\n• Tự động làm các nhiệm vụ còn thiếu và sự kiện..."
            if not isCopiedAnimating then
                CopyTagLabel.Text = "📋 SAO CHÉP"
            end
        else
            NoticeTag.Text = "📢 V3.8:"
            NoticeContent.Text = "• Fixed auto-racing event\n• Fix other minor bugs"
            AutoFarmBtn.Text = "⚙️ SETTING AUTO FARM"
            SubLabel.Text = "• Automated from A to Z\n• Steal Secret eggs 2B+\n• Auto run treadmill when idle\n• Complete missing quests & live events..."
            if not isCopiedAnimating then
                CopyTagLabel.Text = "📋 COPY"
            end
        end
    end

    local function setExpanded(expand)
        if isExpanded == expand then return end
        isExpanded = expand

        if expand then
            CollapsedView.Visible = false
            ExpandedView.Visible = true
            TweenService:Create(Island, TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 320, 0, 264)
            }):Play()
            TweenService:Create(IslandCorner, TweenInfo.new(0.35), {CornerRadius = UDim.new(0, 16)}):Play()
        else
            ExpandedView.Visible = false
            CollapsedView.Visible = true
            TweenService:Create(Island, TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 172, 0, 36)
            }):Play()
            TweenService:Create(IslandCorner, TweenInfo.new(0.3), {CornerRadius = UDim.new(1, 0)}):Play()
        end
    end

    CollapsedView.MouseButton1Click:Connect(function() setExpanded(true) end)
    CloseBtn.MouseButton1Click:Connect(function() setExpanded(false) end)

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target

        if target == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0, 2)
            }):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnVI, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        end

        updateAllActive()

        if updateIslandContentLanguage then updateIslandContentLanguage(target) end
        if updateToastLanguage then updateToastLanguage(target) end
    end

    switchGlobalLanguage = switchMode
    BtnVI.MouseButton1Click:Connect(function() switchMode("VI") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)

    local function updateStatus(txt, col)
        AutoFarmBtn.Text = txt
        TweenService:Create(AutoFarmBtn, TweenInfo.new(0.18), {TextColor3 = col}):Play()
    end

    AutoFarmBtn.MouseButton1Click:Connect(function()
        if isConfigInjecting then return end
        TweenService:Create(AutoFarmCard, TweenInfo.new(0.08), {Size = UDim2.new(1, -28, 0, 92)}):Play()
        task.delay(0.08, function()
            TweenService:Create(AutoFarmCard, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, -24, 0, 96)}):Play()
        end)
        executeAutoConfig(updateStatus)
    end)

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
            local cam = workspace.CurrentCamera
            local maxX = cam and cam.ViewportSize.X - 180 or 800
            local maxY = cam and cam.ViewportSize.Y - 50 or 600

            local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, maxY)

            Island.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

-- ==================== 10. EVENT-DRIVEN ENGINE SIÊU NHẸ ====================
task.delay(1.0, function()
    createDynamicIslandUI()
    createUpdateToast()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    local function handleNewDescendant(desc)
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            hookElement(desc)
            inspectAndApplySoftBlue(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then
            for _, desc in ipairs(root:GetDescendants()) do
                handleNewDescendant(desc)
            end
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then
            root.DescendantAdded:Connect(function(desc)
                task.defer(function()
                    handleNewDescendant(desc)
                end)
            end)
        end
    end
end)
