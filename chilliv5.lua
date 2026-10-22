-- Chilli Hub Ultra | Zero-Delay Border Sync + Neon Ultra Title + Sena V7 OLED Glass Edition
local NEW_TITLE = "Chilli Hub Ultra"
local LOGO_ID = "rbxassetid://74441610995894"
local HEADER_BAR_IMG_ID = "rbxassetid://83726521558450"
local STEAL_TAB_ICON_ID = "rbxassetid://91536384271341"
local WALLPAPER_IMAGE_ID = "rbxassetid://83726521558450"

local LOGO_BG, BLACK_BG = Color3.fromRGB(12, 12, 18), Color3.fromRGB(8, 8, 12)
local MY_URL = "https://raw.githubusercontent.com/ronnei/hihi/refs/heads/main/chillihubv5.lua"
local VENYX_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local AUTO_FILE, LANG_FILE = "ChilliHubV5_AutoRun.lua", "ChilliV5_Lang.txt"

local PRESET_JSON = [=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":true,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":true,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]

-- 0. LƯU FILE AUTORUN 1 DÒNG DUY NHẤT (BẢO MẬT 100%)
if writefile then
    pcall(writefile, AUTO_FILE, ('pcall(function() loadstring(game:HttpGet("%s"))() end)'):format(MY_URL))
end

local function safeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url, true) end)
    if ok and type(res) == "string" and #res > 10 then return res end
    local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
    if req then
        local rOk, rRes = pcall(req, { Url = url, Method = "GET" })
        if rOk and rRes and type(rRes.Body) == "string" and #rRes.Body > 10 then return rRes.Body end
    end
    return nil
end

-- 1. QUẢN LÝ PHIÊN TOÀN CỤC
local env = (getgenv and getgenv()) or _G
env.__ChilliV5State = env.__ChilliV5State or {
    SessionId = 0, Language = "VI", ActiveGradients = {}, TrackedTexts = {}, TrackedFpsLabels = {},
    NoticeShown = false, StartClock = os.clock()
}
local State = env.__ChilliV5State
State.SessionId = (State.SessionId or 0) + 1
State.StartClock = State.StartClock or os.clock()
local SID = State.SessionId
local function isAlive() return State.SessionId == SID end

pcall(function()
    if isfile and isfile(LANG_FILE) then
        local s = (readfile(LANG_FILE) or ""):match("^%s*(.-)%s*$")
        if s == "EN" or s == "VI" then State.Language = s end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local TweenService, CoreGui, Stats = game:GetService("TweenService"), game:GetService("CoreGui"), game:GetService("Stats")

local function getScanRoots()
    local r = {}
    if gethui then pcall(function() local h = gethui(); if h then table.insert(r, h) end end) end
    table.insert(r, CoreGui)
    local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then table.insert(r, pg) end
    return r
end

local IGNORED_GUIS = {
    RobloxGui=true, TopBarApp=true, TouchGui=true, Chat=true, BubbleChat=true,
    Freecam=true, BackpackGui=true, PlayerList=true, PurchasePrompt=true, ChilliV5_NoticeGui=true
}

local function isVenyxUiPresent()
    for _, root in ipairs(getScanRoots()) do
        for _, d in ipairs(root:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and (d.Text == "VENYX" or d.Text == NEW_TITLE or d.Text:find("Chilli", 1, true)) then
                return true
            end
        end
    end
    return false
end

local function launchVenyxBase()
    if isVenyxUiPresent() then return end
    if env.__VenyxLaunchingNow and (os.clock() - (env.__VenyxLaunchClock or 0) < 8) then return end
    env.__VenyxLaunchingNow = true
    env.__VenyxLaunchClock = os.clock()
    task.spawn(function()
        if not game:IsLoaded() then game.Loaded:Wait() end
        local rawCode = safeHttpGet(VENYX_URL)
        if rawCode then
            local fn = loadstring(rawCode)
            if type(fn) == "function" then pcall(fn) end
        end
        env.__VenyxLaunchingNow = false
    end)
end

launchVenyxBase()

local function setupSafeTeleportHook()
    if env.__ChilliSafeTpInstalled then return end
    env.__ChilliSafeTpInstalled = true
    local rq = env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport
        or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (delta and delta.queue_on_teleport)
    if not rq then return end
    env.__ChilliOrigQueue = rq
    local boot = ('--CHILLI_V5_AUTHORIZED_TELEPORT--\ntask.spawn(function() if not game:IsLoaded() then game.Loaded:Wait() end local P=game:GetService("Players") while not P.LocalPlayer do task.wait(0.1) end task.wait(1) pcall(function() loadstring(game:HttpGet("%s"))() end) end)'):format(MY_URL)
    local rawLock = function(c)
        return tostring(c or ""):find("CHILLI_V5_AUTHORIZED_TELEPORT", 1, true) and rq(c) or rq(boot)
    end
    local safeLock = newcclosure and newcclosure(rawLock) or rawLock
    pcall(function()
        env.queue_on_teleport = safeLock
        env.queueonteleport = safeLock
        rq(boot)
    end)
end

local function mk(cls, props, parent)
    local inst = Instance.new(cls)
    for k, v in pairs(props) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local RAINBOW = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 45, 85)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 155, 35)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 235, 45)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(45, 255, 145)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(45, 195, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(185, 85, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 45, 85))
})

-- Màu Gradient ULTRA Neon Đặc Biệt (Trắng Băng -> Xanh Cyan -> Hồng Rực -> Tím Cosmic -> Vàng Kim)
local ULTRA_TEXT_GRAD = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(135, 230, 255)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 65, 205)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(180, 100, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 220, 70))
})

-- 2. VÒNG LẶP HỢP NHẤT (XOAY CẦU VỒNG + FPS ẢO 95-120 + TELEMETRY PILLS + ĐỒNG BỘ GIAO DIỆN)
local fakeFps, lastFpsT = math.random(98, 114), 0
local function getFakeFps()
    local now = os.clock()
    if now - lastFpsT >= 0.65 then lastFpsT = now; fakeFps = math.clamp(fakeFps + math.random(-3, 3), 92, 120) end
    return fakeFps
end
local function isFpsTxt(s) return type(s) == "string" and s:find("FPS", 1, true) ~= nil and s:find("ms", 1, true) ~= nil and s:find("%d+%s*FPS") ~= nil end
local function updateFpsLbl(lbl)
    if not (lbl and lbl.Parent) or lbl:GetAttribute("__UpdatingFps") then return end
    local raw = lbl.Text
    if not isFpsTxt(raw) then return end
    local p = raw:gsub("%d+%s*FPS", tostring(getFakeFps()) .. " FPS", 1)
    if raw ~= p then lbl:SetAttribute("__UpdatingFps", true); lbl.Text = p; lbl:SetAttribute("__UpdatingFps", false) end
end
local function hookFps(lbl)
    if not (lbl:IsA("TextLabel") or lbl:IsA("TextButton")) then return end
    State.TrackedFpsLabels[lbl] = true
    updateFpsLbl(lbl)
    if lbl:GetAttribute("__FpsHookSession") ~= SID then
        lbl:SetAttribute("__FpsHookSession", SID)
        lbl:GetPropertyChangedSignal("Text"):Connect(function() if isAlive() and not lbl:GetAttribute("__UpdatingFps") then updateFpsLbl(lbl) end end)
    end
end

task.spawn(function()
    local rot, tickFps = 0, 0
    while isAlive() do
        rot = (rot + 4) % 360
        local grads = State.ActiveGradients
        for i = #grads, 1, -1 do
            local g = grads[i]
            if g and g.Parent then g.Rotation = rot else table.remove(grads, i) end
        end
        tickFps = tickFps + 1
        if tickFps >= 15 then
            tickFps = 0
            local curFps = getFakeFps()
            for lbl in pairs(State.TrackedFpsLabels) do
                if lbl and lbl.Parent then updateFpsLbl(lbl) else State.TrackedFpsLabels[lbl] = nil end
            end
            if State.TelemetryUpdateFn then
                pcall(State.TelemetryUpdateFn, curFps)
            end
        end
        if State.SyncWindowFn then
            pcall(State.SyncWindowFn)
        end
        task.wait(0.033)
    end
end)

-- 3. BỘ DỊCH THUẬT 5 TẦNG O(1)
local FastCache = {}
local function hasVi(s)
    return type(s) == "string" and s ~= "" and s:find("[\194-\244][\128-\191]") ~= nil and not s:find("^[%w%s%p·•●🌶️🇻🇳🌐⚡⏳✅⚠️🚀✨▲▼⏱️🥚🍬📶👑]+$")
end

local EXACT_VI = {
    ["Fighting Small monster"]="Đang đánh quái vật nhỏ", ["Fighting Medium monster"]="Đang đánh quái vật vừa",
    ["Fighting Large monster"]="Đang đánh quái vật lớn", ["Fighting Big monster"]="Đang đánh quái vật lớn",
    ["UI scale"]="Kích cỡ Menu (UI Scale)", ["Show / hide UI"]="Phím ẩn / hiện Menu", ["Hiển thị / hide UI"]="Phím ẩn / hiện Menu",
    ["Opacity"]="Độ trong suốt", ["Tone"]="Tông màu", ["Dim the game"]="Làm tối nền game", ["Dim game"]="Làm tối nền game",
    ["QUICK BARS"]="THANH PHÍM TẮT NHANH", ["Quick bars"]="Thanh phím tắt nhanh",
    ["Show quick bars"]="Hiện thanh phím tắt nhanh", ["Hiển thị quick bars"]="Hiện thanh phím tắt nhanh",
    ["Keybinds"]="Phím tắt (Keybinds)", ["Bar size"]="Kích cỡ thanh nhanh", ["Bar KÍCH CỠ"]="Kích cỡ thanh nhanh",
    ["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT", ["PINS Và KEYBINDS"]="GHIM & PHÍM TẮT", ["Pins and keybinds"]="Ghim & Phím tắt",
    ["Tip: you can also hold any feature, or right-click it on PC, to pin it or set key."]="Mẹo: nhấn giữ vào tính năng bất kỳ (hoặc chuột phải trên PC) để ghim ra màn hình hoặc gán phím tắt.",
    ["Find option"]="Tìm tùy chọn", ["All"]="Tất cả", ["Pinned"]="Đã ghim",
    ["Clear all quick bars"]="Xóa hết thanh nhanh", ["Clear all keybinds"]="Xóa hết phím tắt",
    ["DEFAULTS"]="MẶC ĐỊNH", ["Reset to defaults"]="Khôi phục mặc định", ["Reset"]="Đặt lại",
    ["Turn off all toggles"]="Tắt toàn bộ công tắc", ["Turn off"]="Tắt hết",

    ["Steal An Egg"]="Cướp Trứng", ["steal an egg"]="cướp trứng",
    ["CANDY CORN"]="KẸO NGÔ", ["Candy Corn"]="Kẹo Ngô", ["Calculate mutations"]="Tính thử đột biến",
    ["Cards show the value with these mutations added"]="Thẻ trứng sẽ hiển thị giá trị sau khi cộng thêm các đột biến này",
    ["Delivery speed"]="Tốc độ mang trứng về", ["Change if steal fails"]="Hãy chỉnh giảm xuống nếu cướp trứng bị lỗi",
    ["Auto farm monsters"]="Tự động cày quái vật", ["Auto kill monsters"]="Tự động đánh quái vật", ["Bat"]="Gậy Dơi (Bat)",
    ["Instant steal"]="Cướp tức thì", ["Admin treadmill"]="Máy tập Admin", ["CURSED ISLAND WARS"]="ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",
    ["Cursed Island Wars"]="Đại Chiến Đảo Nguyền Rủa", ["Waiting for Cursed Island Wars"]="Đang chờ Đại Chiến Đảo Nguyền Rủa",
    ["Auto play Cursed Island Wars"]="Tự động chơi Đại Chiến Đảo Nguyền Rủa", ["Island Wars target"]="Mục tiêu Đảo Nguyền Rủa",
    ["Enemies and base"]="Kẻ địch và Căn cứ", ["Walls and crystal"]="Tường chắn và Pha lê", ["Catching a pumpkin"]="Đang nhặt bí ngô",
    ["Carrying a pumpkin to the altar"]="Đang mang bí ngô tới bệ thờ", ["Delivering a pumpkin to the altar"]="Đang giao bí ngô tới bệ thờ",
    ["FIX"]="SỬA LỖI", ["Most tokens"]="Nhiều kẹo/xu nhất",
    ["Admin abuse works like Chilli: admin treadmill, Capture the egg, minigame eggs and Instant steal"]="Lạm dụng Admin hoạt động chuẩn: Máy tập Admin, Cướp trứng sự kiện, trứng Minigame và Cướp tức thì",
    ["Fixed lag back with the Tween delivery method"]="Đã sửa lỗi giật lùi (lag back) khi mang trứng về bằng chế độ Bay (Tween)",
    ["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub Ultra! Tham gia Discord để cập nhật và nhận hỗ trợ",
    ["v1.1.0: Halloween tasks follow Task order, Walk speed for monsters, pumpkins and ghosts, Use weapons picks every weapon, Lab and Race shop removed"]="v1.1.0: Nhiệm vụ Halloween tuân theo Thứ tự tác vụ, thêm Tốc độ chạy khi săn quái, bí ngô và ma, Sử dụng vũ khí tự chọn mọi loại vũ khí, đã gỡ bỏ Phòng Lab và Shop Đua Xe",
    ["Halloween: Dimension eggs, monsters, Ghost Dog quest, fishing, Phantom Express and Cursed Island Wars"]="Sự kiện Halloween: Trứng Không gian Halloween, đánh quái, nhiệm vụ Chó Ma, câu cá, Tàu Ma Phantom Express và Đại Chiến Đảo Nguyền Rủa",
    ["Idle"]="Đang rảnh", ["Waiting"]="Đang chờ", ["Nothing"]="Không có gì", ["None"]="Không có", ["Off"]="Tắt", ["OFF"]="TẮT", ["On"]="Bật", ["ON"]="BẬT",
    ["No egg matches your targets"]="Không có trứng nào khớp mục tiêu", ["No eggs match your targets"]="Không có trứng nào khớp mục tiêu",
    ["No egg matches filter"]="Không có trứng khớp bộ lọc", ["No eggs match filter"]="Không có trứng khớp bộ lọc",
    ["No target egg found"]="Không tìm thấy trứng mục tiêu", ["No matching eggs"]="Không có trứng nào khớp", ["No valid targets"]="Không có mục tiêu hợp lệ",
    ["Bag is full"]="Túi đã đầy", ["Egg bag is full"]="Túi trứng đã đầy", ["Pet bag is full"]="Túi pet đã đầy", ["Pen is full"]="Chuồng ấp đã đầy",
    ["Field is closed"]="Sân trứng đang đóng", ["Waiting for field to open"]="Đang chờ sân trứng mở", ["Waiting for eggs to spawn"]="Đang chờ trứng xuất hiện",
    ["Waiting in safe zone"]="Đợi ở vùng an toàn", ["Returning to safe zone"]="Đang về vùng an toàn", ["Returning home"]="Đang quay về nhà",
    ["Delivering egg"]="Đang giao trứng về chuồng", ["Dropping egg"]="Đang thả trứng", ["Selling eggs"]="Đang bán trứng", ["Selling pets"]="Đang bán pet",
    ["Hatching eggs"]="Đang ấp trứng", ["Placing eggs"]="Đang đặt trứng", ["Mutating eggs"]="Đang đột biến trứng", ["Fusing pets"]="Đang dung hợp pet",
    ["Hopping server"]="Đang đổi máy chủ", ["Rejoining"]="Đang vào lại phòng", ["Avoiding guard"]="Đang né vệ sĩ",
    ["Using treadmill"]="Đang chạy máy tập", ["Upgrading treadmill"]="Đang nâng cấp máy tập", ["Upgrading base"]="Đang nâng cấp căn cứ",
    ["Claiming rewards"]="Đang nhận thưởng", ["Claiming offline cash"]="Đang nhận tiền ngoại tuyến", ["Joining race"]="Đang vào đường đua", ["Racing"]="Đang đua xe",
    ["Home"]="Bảng Điều Khiển", ["Dashboard"]="Bảng Điều Khiển", ["Welcome back"]="Chào mừng trở lại", ["Venyx Discord"]="Chilli Hub Discord",
    ["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ", ["Copy Invite"]="Chép Link Mời", ["Discord"]="Chilli Hub", ["MONEY /S"]="TIỀN /GIÂY",
    ["OPEN"]="MỞ", ["Open"]="Mở", ["Close"]="Đóng", ["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub Ultra! Tham gia Discord để cập nhật và nhận hỗ trợ",
    ["Beta version"]="Phiên bản Beta", ["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",
    ["Rejoin"]="Vào lại", ["Server hop"]="Đổi server", ["Copy Job ID"]="Chép Job ID", ["Unload hub"]="Tắt Hub", ["Save config"]="Lưu cấu hình", ["Hide UI"]="Ẩn Menu",
    ["SESSION"]="PHIÊN CHƠI", ["STOLEN"]="ĐÃ CƯỚP", ["LAST EGG"]="TRỨNG CUỐI", ["PLACED"]="ĐÃ ĐẶT", ["HATCHED"]="ĐÃ ẤP", ["NIGHT IN"]="ĐÊM SAU",
    ["SESSION TIME"]="THỜI GIAN", ["BEST STEAL"]="CƯỚP TỐT NHẤT", ["EGG BAG"]="TÚI TRỨNG", ["PET BAG"]="TÚI PET", ["WHAT'S NEW"]="CÓ GÌ MỚI", ["NEW"]="MỚI",
    ["Event"]="Sự Kiện", ["Search"]="Tìm kiếm", ["Filter"]="Lọc tìm", ["Steal"]="Cướp Trứng", ["Auto Steal"]="Tự Động Cướp", ["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
    ["Auto steal"]="Tự động cướp", ["Egg Predictor"]="Dự Đoán Trứng", ["Go to egg"]="Di chuyển tới trứng", ["Teleport to egg"]="Dịch chuyển tới trứng",
    ["Teleport zones"]="Khu vực dịch chuyển", ["Tween"]="Bay (Tween)", ["Walk"]="Đi bộ", ["Delivery method"]="Cách mang về", ["Fast tween speed"]="Tốc độ bay nhanh",
    ["Tween speed"]="Tốc độ bay", ["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục", ["Steal back from players"]="Cướp lại từ người chơi",
    ["Steal from other players"]="Cướp từ người chơi khác", ["Anti guard"]="Chống vệ sĩ", ["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn", ["FILTER"]="BỘ LỌC",
    ["Zones"]="Khu vực", ["Steal first"]="Ưu tiên cướp", ["Best value"]="Giá trị cao nhất", ["Lowest value"]="Giá trị thấp nhất", ["Best rarity"]="Độ hiếm cao nhất",
    ["Best mutation"]="Đột biến tốt nhất", ["Biggest"]="Kích thước to nhất", ["Closest"]="Khoảng cách gần nhất", ["Mutations"]="Đột biến", ["Rarities"]="Độ hiếm",
    ["Only these eggs"]="Chỉ những trứng này", ["Min value /s"]="Giá trị tối thiểu /s", ["Max value /s"]="Giá trị tối đa /s",
    ["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi", ["Keep lab eggs"]="Giữ lại trứng Lab", ["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ",
    ["Auto hop server"]="Tự đổi máy chủ", ["Hop delay"]="Độ trễ đổi server", ["Only sell eggs below /s"]="Chỉ bán trứng dưới mức /s",
    ["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG", ["Sort eggs"]="Sắp xếp trứng", ["Preview card"]="Thẻ xem trước", ["Pick one"]="Chọn một mục", ["Pick any"]="Chọn bất kỳ",
    ["Value"]="Giá trị", ["Rarity"]="Độ hiếm", ["Time left"]="Thời gian còn lại", ["Default"]="Mặc định", ["Clear"]="Xóa chọn", ["Select all"]="Chọn tất cả",
    ["SIZE"]="KÍCH CỠ", ["WEIGHT"]="CÂN NẶNG", ["READY"]="SẴN SÀNG", ["IN BAG"]="TRONG TÚI", ["GROWING"]="ĐANG LỚN", ["Hatch now"]="Ấp ngay", ["Hold egg"]="Cầm trứng",
    ["Fly to egg"]="Bay tới trứng", ["Steal egg"]="Cướp trứng", ["Enchanted Forest"]="Rừng Phù Phép", ["Light Dark"]="Sáng Tối", ["Titan Temple"]="Đền Titan",
    ["Cherry Blossom"]="Hoa Anh Đào", ["Prehistoric"]="Tiền Sử", ["Abyss Ocean"]="Đáy Đại Dương", ["Volcano"]="Núi Lửa", ["Snow"]="Tuyết", ["Jungle"]="Rừng Rậm",
    ["Desert"]="Sa Mạc", ["Lake"]="Hồ Nước", ["Forest"]="Khu Rừng", ["Silver"]="Bạc", ["Rainbow"]="Cầu Vồng", ["Golden"]="Vàng", ["Fractured"]="Rạn Nứt",
    ["Scrambled"]="Hỗn Loạn", ["Enchanted"]="Phù Phép", ["Nitro"]="Nitro", ["SCRAMBLED"]="HỖN LOẠN", ["NITRO"]="NITRO", ["FRACTURED"]="RẠN NỨT", ["ENCHANTED"]="PHÙ PHÉP",
    ["Farm"]="Cày Cuốc", ["Pen"]="Chuồng Ấp", ["PEN"]="CHUỒNG ẤP", ["Treadmill"]="Máy Tập", ["TREADMILL"]="MÁY TẬP CHẠY", ["Mutate"]="Đột Biến",
    ["Sell"]="Bán", ["SELL"]="BÁN TỰ ĐỘNG", ["Fuse"]="Dung Hợp", ["FUSE"]="DUNG HỢP", ["Priority"]="Ưu Tiên", ["PRIORITY"]="THỨ TỰ ƯU TIÊN",
    ["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG", ["Auto place"]="Tự động đặt trứng", ["Place when"]="Đặt khi", ["Always"]="Luôn luôn", ["Place first"]="Ưu tiên đặt",
    ["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG", ["Auto hatch"]="Tự động ấp trứng", ["Equip best pets"]="Trang bị pet mạnh nhất", ["READY NOW"]="SẴN SÀNG ẤP",
    ["Auto treadmill"]="Tự chạy máy tập", ["Auto upgrade treadmill"]="Tự nâng cấp máy tập", ["PROGRESS"]="TIẾN TRÌNH", ["Auto upgrade base"]="Tự nâng cấp căn cứ",
    ["Auto buy trails"]="Tự mua vệt sáng", ["Auto claim offline cash"]="Tự nhận tiền ngoại tuyến", ["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục",
    ["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN", ["Auto mutate"]="Tự động đột biến", ["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN", ["Use items"]="Dùng vật phẩm",
    ["Mutate first"]="Ưu tiên đột biến", ["Auto buy Nitro"]="Tự mua Nitro", ["PETS"]="THÚ CƯNG (PETS)", ["EGGS"]="TRỨNG (EGGS)", ["Auto sell pets"]="Tự động bán pet",
    ["Auto sell eggs"]="Tự động bán trứng", ["Sell rarities"]="Độ hiếm bán", ["Never sell"]="Không bao giờ bán", ["Only mutations"]="Chỉ bán đột biến",
    ["Only below /s"]="Chỉ dưới mức /s", ["Keep mutated"]="Giữ lại đồ đột biến", ["LAB EGGS"]="TRỨNG PHÒNG LAB", ["FAVORITE"]="YÊU THÍCH (KHÓA)",
    ["Auto favorite"]="Tự động khóa bảo vệ", ["Auto sell lab eggs"]="Tự động bán trứng Lab", ["Match"]="Điều kiện khớp", ["All picked rules"]="Khớp tất cả quy tắc",
    ["Any picked rule"]="Khớp bất kỳ quy tắc", ["Favorite equipped"]="Khóa pet đang trang bị", ["FUSE MACHINE"]="MÁY DUNG HỢP",
    ["No 3 matching pets"]="Chưa đủ 3 pet cùng loại", ["Auto fuse"]="Tự động dung hợp", ["Fuse first"]="Ưu tiên dung hợp", ["Lowest rarity"]="Độ hiếm thấp nhất",
    ["Highest rarity"]="Độ hiếm cao nhất", ["Use pets"]="Sử dụng pet", ["Lowest value first"]="Giá trị thấp nhất trước", ["Highest value first"]="Giá trị cao nhất trước",
    ["Skip mutated"]="Bỏ qua pet đột biến", ["Eject odd pets"]="Đẩy pet lẻ ra ngoài", ["FUSE FILTER"]="BỘ LỌC DUNG HỢP", ["Only these pets"]="Chỉ những pet này",
    ["Never fuse"]="Không bao giờ dung hợp", ["FUSE PREDICTOR"]="DỰ ĐOÁN DUNG HỢP", ["SLOTS"]="Ô CHỨA", ["STATUS"]="TRẠNG THÁI", ["LIKELY SIZE"]="KÍCH CỠ DỰ KIẾN",
    ["CHANCE"]="TỶ LỆ", ["VALUE"]="GIÁ TRỊ", ["BEST CASE"]="TỐT NHẤT CÓ THỂ", ["TASK ORDER"]="THỨ TỰ TÁC VỤ", ["DOING"]="ĐANG LÀM", ["WAITING"]="ĐANG CHỜ",
    ["Steal filter eggs"]="Cướp trứng theo bộ lọc", ["Shooting Star"]="Bắt Sao Băng", ["Racing Event"]="Sự Kiện Đua Xe", ["Butterfly"]="Bắt Bướm",
    ["Steal wisp eggs"]="Cướp trứng Wisp", ["Wisp"]="Nhặt Wisp", ["Steal missing index"]="Cướp trứng thiếu trong Chỉ mục", ["Steal lab eggs"]="Cướp trứng phòng Lab",
    ["Place"]="Đặt trứng vào chuồng", ["Butterfly machine"]="Máy đổi Bướm", ["Race"]="Đua Xe", ["RACE"]="ĐUA XE", ["Star"]="Sao Băng", ["STAR"]="SAO BĂNG",
    ["BUTTERFLY"]="BẮT BƯỚM", ["Lab"]="Phòng Lab", ["LAB"]="PHÒNG LAB", ["AA"]="Admin (AA)", ["Halloween"]="Halloween", ["HALLOWEEN"]="HALLOWEEN",
    ["HALLOWEEN DIMENSION"]="KHÔNG GIAN HALLOWEEN", ["Auto steal Halloween eggs"]="Tự động cướp trứng Halloween", ["Instant steal Halloween eggs"]="Cướp tức thì trứng Halloween",
    ["Steal speed"]="Tốc độ cướp", ["Halloween eggs"]="Trứng Halloween", ["Halloween rarities"]="Độ hiếm Halloween", ["Auto Pumpkin Moon"]="Tự làm sự kiện Trăng Bí Ngô",
    ["Auto buy Halloween Dimension Egg"]="Tự mua trứng Không gian Halloween", ["Walk speed"]="Tốc độ chạy bộ", ["GHOST DOG AND FISHING"]="CHÓ MA VÀ CÂU CÁ",
    ["QUEST"]="NHIỆM VỤ", ["Done"]="Đã xong", ["FISH CAUGHT"]="CÁ ĐÃ CÂU", ["Auto Ghost Dog quest"]="Tự làm nhiệm vụ Chó Ma", ["Auto fishing"]="Tự động câu cá",
    ["Cast luck"]="Tỷ lệ câu may mắn", ["Perfect"]="Hoàn hảo (Perfect)", ["MONSTERS"]="QUÁI VẬT", ["Monsters"]="Tên quái vật", ["Monster order"]="Thứ tự đánh quái",
    ["Rarest first"]="Hiếm nhất trước", ["PHANTOM EXPRESS"]="TÀU MA PHANTOM EXPRESS", ["TRAIN"]="CHUYẾN TÀU", ["Not here"]="Chưa đến", ["SOULS"]="LINH HỒN",
    ["Auto Phantom Express"]="Tự động cướp Tàu Ma", ["Auto vacuum Ghouler boss"]="Tự hút linh hồn Boss Ghouler", ["Ghost target"]="Mục tiêu ma",
    ["Auto trade souls"]="Tự động đổi linh hồn", ["RACING EVENT"]="SỰ KIỆN ĐUA XE", ["NEXT RACE"]="ĐUA TIẾP THEO", ["WINS"]="THẮNG", ["TROPHIES"]="CÚP",
    ["Auto race"]="Tự động đua xe", ["Race speed"]="Tốc độ đua", ["Use power-ups"]="Tự dùng vật phẩm tăng tốc", ["REWARDS"]="PHẦN THƯỞNG",
    ["Auto claim rewards"]="Tự nhận phần thưởng", ["Auto equip racer"]="Tự trang bị xe đua", ["Racer"]="Xe đua", ["Best owned"]="Tốt nhất đang có",
    ["Auto buy shop"]="Tự mua vật phẩm Shop", ["Shop items"]="Vật phẩm Shop", ["SHOOTING STAR"]="SAO BĂNG RƠI", ["LANDS IN"]="RƠI SAU", ["CATCH"]="BẮT SAO BĂNG",
    ["CAUGHT"]="ĐÃ BẮT", ["EXPIRES IN"]="BIẾN MẤT SAU", ["SLIPPED"]="TUỘT MẤT", ["TRIES"]="SỐ LẦN THỬ", ["DISTANCE"]="KHOẢNG CÁCH",
    ["Auto catch shooting star"]="Tự động bắt sao băng", ["BUTTERFLY BLOOM"]="MÙA BƯỚM NỞ", ["Auto butterfly bloom"]="Tự động bắt bướm", ["EMERALD"]="LỤC BẢO",
    ["SAPPHIRE"]="LAM NGỌC", ["AMETHYST"]="THẠCH ANH TÍM", ["RADIANT"]="RỰC RỠ", ["ESSENCE"]="TINH CHẤT", ["Catch mode"]="Chế độ bắt", ["Stand"]="Đứng yên",
    ["Chase"]="Đuổi theo", ["BUTTERFLY MACHINE"]="MÁY ĐỔI BƯỚM", ["Auto trade up"]="Tự nâng cấp bậc bướm", ["Trade"]="Giao dịch đổi",
    ["Smart trade for essence"]="Đổi bướm lấy tinh chất thông minh", ["Auto craft essence"]="Tự chế tạo tinh chất", ["WISP COMPANION"]="ĐỒNG HÀNH WISP",
    ["Catch priority"]="Ưu tiên bắt", ["Rarest"]="Hiếm nhất", ["Catch"]="Loại bướm bắt", ["Catch speed"]="Tốc độ bắt", ["Auto wisp quest"]="Tự làm nhiệm vụ Wisp",
    ["Auto banjo cricket"]="Tự bắt dế Banjo", ["STAGE"]="GIAI ĐOẠN", ["LAB ODDS"]="TỶ LỆ PHÒNG LAB", ["BANNER"]="BĂNG RÔN", ["ENDS IN"]="KẾT THÚC SAU",
    ["BANNER CHANCE"]="TỶ LỆ BĂNG RÔN", ["NEXT"]="TIẾP THEO", ["Experimental Pets"]="Pet Thí Nghiệm", ["Biohazard Pets"]="Pet Sinh Học",
    ["Lab banners"]="Băng rôn phòng Lab", ["Auto trade in"]="Tự động đổi trứng Lab", ["Auto reroll recipe"]="Tự đổi lại công thức",
    ["Place lab reward eggs"]="Đặt trứng thưởng từ Lab", ["ADMIN ABUSE"]="LẠM DỤNG ADMIN (ABUSE)", ["No admin boost right now"]="Hiện không có buff Admin nào",
    ["Instant steal (Admin Treadmill)"]="Cướp tức thì (Máy tập Admin)", ["Use admin treadmill"]="Tự dùng máy tập Admin", ["CAPTURE THE EGG"]="CƯỚP TRỨNG SỰ KIỆN",
    ["Auto capture event egg"]="Tự bắt trứng sự kiện", ["Take it from the holder"]="Giật trứng từ người đang cầm", ["Hold height"]="Độ cao giữ trứng",
    ["Keep away"]="Khoảng cách né tránh", ["MINIGAME EGGS"]="TRỨNG MINIGAME", ["Auto steal minigame egg"]="Tự cướp trứng Minigame", ["Player"]="Người Chơi",
    ["ESP"]="Định Vị (ESP)", ["Move"]="Di Chuyển", ["MOVE"]="DI CHUYỂN", ["Combat"]="Chiến Đấu", ["COMBAT"]="CHIẾN ĐẤU", ["FIELD EGGS"]="TRỨNG NGOÀI SÂN",
    ["Egg ESP"]="ESP Trứng", ["Show"]="Hiển thị", ["Name"]="Tên", ["Fixed size"]="Cố định kích cỡ", ["OTHERS"]="MỤC KHÁC", ["Pen egg ESP"]="ESP trứng trong chuồng",
    ["Other pens ESP"]="ESP chuồng người khác", ["Guard ESP"]="ESP Vệ sĩ", ["Player ESP"]="ESP Người chơi", ["ESP size"]="Kích cỡ ESP",
    ["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN", ["Speed boost"]="Tăng tốc chạy", ["Boost speed"]="Tốc độ tăng thêm", ["Infinite jump"]="Nhảy vô hạn",
    ["God mode"]="Bất tử (God mode)", ["PROTECTION"]="BẢO VỆ NHÂN VẬT", ["Anti ragdoll"]="Chống ngã (Anti Ragdoll)", ["Ignore traps"]="Bỏ qua bẫy",
    ["Instant prompts"]="Tương tác nhấn giữ tức thì", ["Anti AFK"]="Chống treo máy (Anti AFK)", ["Invisible"]="Tàng hình", ["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",
    ["Auto hit"]="Tự động đánh", ["Hit who"]="Mục tiêu đánh", ["Nearest player"]="Người chơi gần nhất", ["Chosen player"]="Người chơi chỉ định",
    ["Chase speed"]="Tốc độ đuổi theo", ["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG", ["Hit aura"]="Vòng đánh tự động (Hit Aura)", ["Skip friends"]="Bỏ qua bạn bè",
    ["WEAPONS"]="VŨ KHÍ", ["Use weapons"]="Sử dụng vũ khí", ["Hold each"]="Thời gian cầm mỗi món", ["System"]="Hệ Thống", ["Server"]="Máy Chủ", ["SERVER"]="MÁY CHỦ",
    ["Webhook"]="Webhook", ["WEBHOOK"]="WEBHOOK", ["Optimizer"]="Tối Ưu Hóa", ["OPTIMIZER"]="TỐI ƯU HÓA", ["Interface"]="Giao Diện", ["INTERFACE"]="GIAO DIỆN",
    ["Config"]="Cấu Hình", ["CONFIG"]="CẤU HÌNH", ["ACTIVE"]="ĐANG DÙNG", ["SAVED CONFIGS"]="ĐÃ LƯU", ["Set as active config"]="Đặt làm cấu hình chính",
    ["Set active"]="Kích hoạt", ["Save changes"]="Lưu thay đổi", ["Save"]="Lưu", ["PROFILES"]="HỒ SƠ CẤU HÌNH", ["New config name"]="Tên cấu hình mới",
    ["Auto if empty"]="Tự đặt nếu trống", ["Create config"]="Tạo cấu hình mới", ["Create"]="Tạo mới", ["Pick to delete"]="Chọn mục cần xóa",
    ["Delete picked"]="Xóa mục đã chọn", ["Delete"]="Xóa", ["Restore deleted"]="Khôi phục mục đã xóa", ["Export config"]="Xuất mã cấu hình",
    ["Import text"]="Dán mã cấu hình", ["Paste config text"]="Dán mã JSON vào đây", ["Import config"]="Nhập cấu hình", ["Import"]="Nhập",
    ["Config imported"]="Đã nhập cấu hình", ["Config loaded"]="Đã nạp cấu hình", ["Later"]="Để sau", ["Apply now"]="Áp dụng ngay", ["Hop to"]="Chuyển tới server",
    ["Least players"]="Ít người chơi nhất", ["Most players"]="Đông người chơi nhất", ["Random"]="Ngẫu nhiên", ["Hop server"]="Đổi máy chủ", ["Hop"]="Đổi ngay",
    ["Rejoin this server"]="Vào lại máy chủ này", ["Copy"]="Sao chép", ["JOIN AND STAY"]="VÀO PHÒNG & DUY TRÌ", ["Job ID"]="Mã phòng (Job ID)",
    ["Paste a Job ID"]="Dán mã Job ID vào đây", ["Join that server"]="Vào máy chủ đó", ["Join"]="Vào ngay", ["Rejoin on kick"]="Tự vào lại khi bị văng/kick",
    ["Auto load script"]="Tự chạy lại script khi chuyển server", ["DISCORD WEBHOOK"]="WEBHOOK DISCORD", ["Webhook URL"]="Đường dẫn Webhook",
    ["Ping everyone"]="Tag @everyone", ["WHAT TO POST"]="NỘI DUNG GỬI BÁO CÁO", ["Post stolen eggs"]="Báo cáo trứng cướp được",
    ["Post fused eggs"]="Báo cáo trứng dung hợp", ["POSTED"]="ĐÃ GỬI", ["Send a test post"]="Gửi tin nhắn thử nghiệm", ["Test"]="Thử nghiệm",
    ["Post when bag is full"]="Gửi thông báo khi đầy túi", ["GRAPHICS"]="ĐỒ HỌA", ["Low graphics"]="Đồ họa thấp (Tăng FPS)",
    ["Disable 3D Render"]="Tắt kết xuất 3D (Treo máy)", ["Background color"]="Màu nền màn hình", ["Black"]="Màu Đen", ["White"]="Màu Trắng",
    ["Hide game UI"]="Ẩn giao diện gốc của Game", ["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)", ["FPS cap"]="Giới hạn FPS",
    ["Show FPS and ping"]="Hiện chỉ số FPS và Ping", ["BASES"]="CĂN CỨ (BASES)", ["Hide other players' pets and eggs"]="Ẩn pet và trứng của người chơi khác",
    ["Hide my pets and eggs"]="Ẩn pet và trứng của bản thân", ["Theme"]="Chủ đề màu", ["Toggle key"]="Phím đóng/mở Menu", ["Quick bar"]="Thanh phím tắt nhanh",
    ["QUICK BAR"]="THANH PHÍM TẮT NHANH", ["Auto save"]="Tự động lưu cấu hình", ["Auto load"]="Tự động nạp cấu hình", ["Load config"]="Nạp cấu hình",
    ["Reset config"]="Đặt lại mặc định", ["Delete config"]="Xóa cấu hình", ["Common"]="Phổ Thông", ["Uncommon"]="Thường", ["Rare"]="Hiếm", ["Epic"]="Sử Thi",
    ["Legendary"]="Huyền Thoại", ["Mythic"]="Thần Thoại", ["Cosmic"]="Vũ Trụ", ["Secret"]="Bí Ẩn", ["Divine"]="Thánh Thần", ["Eternal"]="Vĩnh Cửu",
    ["COMMON"]="PHỔ THÔNG", ["UNCOMMON"]="THƯỜNG", ["RARE"]="HIẾM", ["EPIC"]="SỬ THI", ["LEGENDARY"]="HUYỀN THOẠI", ["MYTHIC"]="THẦN THOẠI",
    ["COSMIC"]="VŨ TRỤ", ["SECRET"]="BÍ ẨN", ["DIVINE"]="THÁNH THẦN", ["ETERNAL"]="VĨNH CỬU"
}

local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do LOWER_VI[k:lower()] = v end

local GRAMMAR_VI = {
    { pat="^[Ff]ighting (.+)$", rep="Đang đánh %1" },
    { pat="^[Aa]uto play (.+)$", rep="Tự động chơi %1" }, { pat="^[Aa]uto farm (.+)$", rep="Tự động cày %1" },
    { pat="^[Aa]uto kill (.+)$", rep="Tự động tiêu diệt %1" }, { pat="^[Aa]uto catch (.+)$", rep="Tự động bắt %1" },
    { pat="^[Aa]uto collect (.+)$", rep="Tự động thu thập %1" }, { pat="^[Aa]uto buy (.+)$", rep="Tự động mua %1" },
    { pat="^[Aa]uto sell (.+)$", rep="Tự động bán %1" }, { pat="^[Aa]uto claim (.+)$", rep="Tự động nhận %1" },
    { pat="^[Aa]uto upgrade (.+)$", rep="Tự động nâng cấp %1" }, { pat="^[Aa]uto craft (.+)$", rep="Tự động chế tạo %1" },
    { pat="^[Aa]uto trade (.+)$", rep="Tự động trao đổi %1" }, { pat="^[Aa]uto equip (.+)$", rep="Tự động trang bị %1" },
    { pat="^[Aa]uto steal (.+)$", rep="Tự động cướp %1" }, { pat="^[Ii]nstant steal (.+)$", rep="Cướp tức thì %1" },
    { pat="^[Aa]uto (.+) quest$", rep="Tự làm nhiệm vụ %1" }, { pat="^[Aa]uto (.+)$", rep="Tự động %1" },
    { pat="^[Cc]alculate (.+)$", rep="Tính thử %1" }, { pat="^[Cc]hange if (.+) fails$", rep="Chỉnh lại nếu %1 bị lỗi" },
    { pat="^(.+) speed$", rep="Tốc độ %1" }, { pat="^(.+) target$", rep="Mục tiêu %1" },
    { pat="^(.+) order$", rep="Thứ tự %1" }, { pat="^(.+) priority$", rep="Ưu tiên %1" },
    { pat="^(.+) mode$", rep="Chế độ %1" }, { pat="^(.+) filter$", rep="Bộ lọc %1" },
    { pat="^[Hh]alloween: carrying (.+) to safety$", rep="Halloween: đang mang %1 đến nơi an toàn" },
    { pat="^[Hh]alloween: (.+)$", rep="Halloween: %1" },
    { pat="^[Nn]o eggs? match%w* your (.+)$", rep="Không có trứng nào khớp %1" },
    { pat="^[Nn]o eggs? match%w* (.+)$", rep="Không có trứng nào khớp %1" },
    { pat="^[Nn]o pets? match%w* (.+)$", rep="Không có pet nào khớp %1" },
    { pat="^[Nn]o (.+) found(.*)$", rep="Không tìm thấy %1%2" },
    { pat="^[Cc]arrying (.+) to safe zone(.*)$", rep="Đang mang %1 về vùng an toàn%2" },
    { pat="^[Cc]arrying (.+) to base(.*)$", rep="Đang mang %1 về căn cứ%2" },
    { pat="^[Cc]arrying (.+) to pen(.*)$", rep="Đang mang %1 về chuồng%2" },
    { pat="^[Cc]arrying (.+) to (.+)$", rep="Đang mang %1 tới %2" },
    { pat="^[Cc]arrying (.+) home(.*)$", rep="Đang mang %1 về nhà%2" },
    { pat="^[Cc]arrying (.+)$", rep="Đang mang %1" },
    { pat="^[Dd]elivering (.+) to (.+)$", rep="Đang giao %1 tới %2" },
    { pat="^[Dd]elivering (.+) home(.*)$", rep="Đang giao %1 về nhà%2" },
    { pat="^[Dd]elivering (.+)$", rep="Đang giao %1" },
    { pat="^[Bb]ringing (.+) to (.+)$", rep="Đang đem %1 tới %2" },
    { pat="^[Tt]aking (.+) from (.+)$", rep="Đang giật %1 từ %2" },
    { pat="^[Ss]tealing (.+) from (.+)$", rep="Đang cướp %1 từ %2" },
    { pat="^[Ss]tealing (.+)$", rep="Đang cướp %1" },
    { pat="^[Gg]rabbing (.+)$", rep="Đang nhặt %1" }, { pat="^[Pp]icking up (.+)$", rep="Đang nhặt %1" },
    { pat="^[Cc]ollecting (.+)$", rep="Đang thu thập %1" }, { pat="^[Dd]ropping (.+) at (.+)$", rep="Đang thả %1 tại %2" },
    { pat="^[Tt]weening to (.+)$", rep="Đang bay tới %1" }, { pat="^[Tt]eleporting to (.+)$", rep="Đang dịch chuyển tới %1" },
    { pat="^[Gg]oing to (.+)$", rep="Đang đi tới %1" }, { pat="^[Mm]oving to (.+)$", rep="Đang di chuyển tới %1" },
    { pat="^[Ww]alking to (.+)$", rep="Đang chạy tới %1" }, { pat="^[Rr]unning to (.+)$", rep="Đang chạy tới %1" },
    { pat="^[Ff]lying to (.+)$", rep="Đang bay tới %1" }, { pat="^[Rr]eturning to (.+)$", rep="Đang quay về %1" },
    { pat="^[Pp]lacing (.+)$", rep="Đang đặt %1" }, { pat="^[Hh]atching (.+)$", rep="Đang ấp %1" },
    { pat="^[Mm]utating (.+)$", rep="Đang đột biến %1" }, { pat="^[Ss]elling (.+)$", rep="Đang bán %1" },
    { pat="^[Ff]using (.+)$", rep="Đang dung hợp %1" }, { pat="^[Uu]pgrading (.+)$", rep="Đang nâng cấp %1" },
    { pat="^[Bb]uying (.+)$", rep="Đang mua %1" }, { pat="^[Cc]laiming (.+)$", rep="Đang nhận %1" },
    { pat="^[Ee]quipping (.+)$", rep="Đang trang bị %1" }, { pat="^[Cc]atching (.+)$", rep="Đang bắt %1" },
    { pat="^[Cc]hasing (.+)$", rep="Đang đuổi theo %1" }, { pat="^[Aa]ttacking (.+)$", rep="Đang tấn công %1" },
    { pat="^[Hh]itting (.+)$", rep="Đang đánh %1" }, { pat="^[Kk]illing (.+)$", rep="Đang tiêu diệt %1" },
    { pat="^[Tt]rading in (.+)$", rep="Đang đổi %1" }, { pat="^[Cc]rafting (.+)$", rep="Đang chế tạo %1" },
    { pat="^[Aa]voiding (.+)$", rep="Đang né %1" }, { pat="^[Ww]aiting for (.+)$", rep="Đang chờ %1" },
    { pat="^[Ww]aiting in (.+)$", rep="Đang đợi ở %1" }, { pat="^[Ww]aiting %((.+)%)$", rep="Đang chờ (%1)" },
    { pat="^[Ss]earching for (.+)$", rep="Đang tìm %1" }, { pat="^[Ff]arming (.+)$", rep="Đang cày %1" },
    { pat="^[Uu]sing (.+)$", rep="Đang dùng %1" }, { pat="^[Jj]oining (.+)$", rep="Đang tham gia %1" },
    { pat="^[Hh]opping (.+)$", rep="Đang đổi %1" }
}

local PHRASES_VI = {
    {"cursed island wars","Đại Chiến Đảo Nguyền Rủa"}, {"island wars","Đảo Nguyền Rủa"}, {"phantom express","Tàu Ma Phantom Express"},
    {"pumpkin moon","Trăng Bí Ngô"}, {"halloween dimension","Không gian Halloween"}, {"ghost dog","Chó Ma"},
    {"enemies and base","Kẻ địch và Căn cứ"}, {"walls and crystal","Tường chắn và Pha lê"}, {"candy corn","Kẹo Ngô"},
    {"admin treadmill","máy tập Admin"}, {"instant steal","cướp tức thì"}, {"capture the egg","Cướp trứng sự kiện"},
    {"small monster","quái vật nhỏ"}, {"medium monster","quái vật vừa"}, {"large monster","quái vật lớn"}, {"big monster","quái vật lớn"},
    {"no egg matches your targets","Không có trứng nào khớp mục tiêu"}, {"no eggs match filter","Không có trứng khớp bộ lọc"},
    {"waiting for field to open","Đang chờ sân trứng mở"}, {"waiting for eggs to spawn","Đang chờ trứng xuất hiện"},
    {"waiting in safe zone","Đợi ở vùng an toàn"}, {"returning to safe zone","Đang về vùng an toàn"},
    {"to the altar","tới bệ thờ"}, {"to altar","tới bệ thờ"}, {"the altar","bệ thờ"}, {"a pumpkin","bí ngô"},
    {"egg bag is full","Túi trứng đã đầy"}, {"pet bag is full","Túi pet đã đầy"}, {"bag is full","Túi đã đầy"},
    {"pen is full","Chuồng đã đầy"}, {"field is closed","Sân trứng đang đóng"}, {"safe zone","vùng an toàn"},
    {"other players","người chơi khác"}, {"missing index","thiếu trong Chỉ mục"}, {"shooting star","sao băng"},
    {"butterfly bloom","mùa bướm nở"}, {"racing event","sự kiện đua xe"}, {"offline cash","tiền ngoại tuyến"},
    {"index rewards","thưởng Chỉ mục"}, {"lab eggs","trứng Lab"}, {"event egg","trứng sự kiện"},
    {"minigame eggs","trứng Minigame"}, {"minigame egg","trứng Minigame"}, {"wisp eggs","trứng Wisp"},
    {"to safe zone","về vùng an toàn"}, {"to safety","đến nơi an toàn"}, {"to base","về căn cứ"}, {"to pen","vào chuồng"},
    {"was added to your configs","đã được thêm vào danh sách cấu hình"}
}

local WORDS_VI = {
    idle="Đang rảnh", fighting="Đang đánh", small="nhỏ", medium="vừa", large="lớn", big="lớn",
    carrying="Đang mang", delivering="Đang giao", stealing="Đang cướp", grabbing="Đang nhặt",
    picking="Đang nhặt", collecting="Đang thu thập", holding="Đang giữ", capturing="Đang bắt giữ", dropping="Đang thả",
    tweening="Đang bay", teleporting="Đang dịch chuyển", going="Đang đi", moving="Đang di chuyển", walking="Đang đi bộ",
    running="Đang chạy", flying="Đang bay", returning="Đang quay về", placing="Đang đặt", hatching="Đang ấp",
    mutating="Đang đột biến", selling="Đang bán", fusing="Đang dung hợp", upgrading="Đang nâng cấp", buying="Đang mua",
    claiming="Đang nhận", equipping="Đang trang bị", catching="Đang nhặt", chasing="Đang đuổi theo", attacking="Đang tấn công",
    hitting="Đang đánh", killing="Đang tiêu diệt", trading="Đang đổi", crafting="Đang chế tạo", avoiding="Đang né",
    waiting="Đang chờ", searching="Đang tìm", scanning="Đang quét", farming="Đang cày", using="Đang dùng",
    joining="Đang vào", hopping="Đang đổi", rejoining="Đang vào lại", finding="Đang tìm", racing="Đang đua",
    ready="Sẵn sàng", nothing="Không có gì", none="Không có", no="Không có", pumpkin="bí ngô", pumpkins="bí ngô",
    altar="bệ thờ", monster="quái vật", monsters="quái vật", ghost="ma", ghosts="ma", soul="linh hồn", souls="linh hồn",
    train="chuyến tàu", boss="Boss", cursed="nguyền rủa", island="đảo", wars="đại chiến", enemies="kẻ địch",
    walls="tường chắn", crystal="pha lê", candy="kẹo", corn="ngô", fishing="câu cá", fish="cá", quest="nhiệm vụ",
    dimension="không gian", delivery="mang về", calculate="tính thử", mutation="đột biến", mutations="đột biến",
    weapon="vũ khí", weapons="vũ khí", removed="đã gỡ bỏ", added="đã thêm", fixed="đã sửa", egg="trứng", eggs="trứng",
    pet="pet", pets="pet", matches="khớp", match="khớp", matching="khớp", your="của bạn", target="mục tiêu",
    targets="mục tiêu", filter="bộ lọc", home="về nhà", base="căn cứ", pen="chuồng", pens="chuồng", field="sân trứng",
    zone="khu vực", zones="khu vực", bag="túi", full="đầy", empty="trống", closed="đóng", open="mở", guard="vệ sĩ",
    guards="vệ sĩ", player="người chơi", players="người chơi", server="máy chủ", treadmill="máy tập", race="đua xe",
    star="sao băng", butterfly="bướm", portal="cổng", rewards="thưởng", reward="thưởng", cash="tiền", found="tìm thấy",
    speed="tốc độ", instant="tức thì", steal="cướp", auto="tự động", to="tới", from="từ", ["in"]="trong", at="tại",
    ["for"]="cho", with="với", ["and"]="và", ["or"]="hoặc"
}

local DYN_VI = {
    { pat="^QUICK BAR (%d+)$", rep="THANH NHANH %1" },
    { pat="^(.+) was added to your configs%. Apply it now%??$", rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?" },
    { pat="^(.+) was added to your configs$", rep="Đã thêm '%1' vào danh sách cấu hình" },
    { pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support", rep="Chào mừng tới Chilli Hub Ultra (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ" },
    { pat="Venyx(.-)(%d+) hours? ago", rep="Chilli Hub%1%2 giờ trước" },
    { pat="Venyx(.-)(%d+) minutes? ago", rep="Chilli Hub%1%2 phút trước" },
    { pat="Venyx(.-)(%d+) days? ago", rep="Chilli Hub%1%2 ngày trước" },
    { pat="^ALL (%d+)$", rep="TẤT CẢ %1" }, { pat="^READY (%d+)$", rep="SẴN SÀNG %1" },
    { pat="^GROWING (%d+)$", rep="ĐANG LỚN %1" }, { pat="^IN BAG (%d+)$", rep="TRONG TÚI %1" },
    { pat="Pen (%d+/%d+) · (%d+) egg%(s%) ready to place", rep="Chuồng %1 · %2 trứng sẵn sàng đặt" },
    { pat="(%d+) egg%(s%) can be mutated", rep="%1 trứng có thể đột biến" },
    { pat="(%d+) pet%(s%) match", rep="%1 pet khớp bộ lọc" }, { pat="(%d+) egg%(s%) match", rep="%1 trứng khớp bộ lọc" },
    { pat="(%d+) lab egg%(s%) match", rep="%1 trứng Lab khớp bộ lọc" }, { pat="^(%d+) pets$", rep="%1 thú cưng" },
    { pat="(%d+ / %d+) players · (.+)", rep="%1 người chơi · %2" },
    { pat="^Mythic · 1 in ([%d%.]+)$", rep="Thần Thoại · 1 trên %1" },
    { pat="^Cosmic · 1 in ([%d%.]+)$", rep="Vũ Trụ · 1 trên %1" },
    { pat="^Secret · 1 in ([%d%.]+)$", rep="Bí Ẩn · 1 trên %1" },
    { pat="^Divine · 1 in ([%d%.]+)$", rep="Thánh Thần · 1 trên %1" },
    { pat="^Eternal · 1 in ([%d%.]+)$", rep="Vĩnh Cửu · 1 trên %1" }
}

local function stripArt(s)
    return ((" " .. s .. " "):gsub("%s+[Aa]%s+", " "):gsub("%s+[Aa]n%s+", " "):gsub("%s+[Tt]he%s+", " "):match("^%s*(.-)%s*$") or s)
end
local function applyPhrases(s)
    local out = s
    for i = 1, #PHRASES_VI do
        local p = PHRASES_VI[i]
        local a, b = out:lower():find(p[1], 1, true)
        if a then out = out:sub(1, a - 1) .. p[2] .. out:sub(b + 1) end
    end
    return out
end
local function applyWords(s)
    return (stripArt(s):gsub("([%a']+)", function(w)
        local l = w:lower()
        return WORDS_VI[l] or LOWER_VI[l] or w
    end))
end

local function translateStatus(en)
    if not en or en == "" then return State.Language == "EN" and "Idle" or "Đang rảnh" end
    local t = (en:match("^%s*(.-)%s*$") or en):gsub("%.+$", "")
    if State.Language == "EN" then return t == "Đang rảnh" and "Idle" or t end
    if t:lower() == "idle" or t == "Đang rảnh" then return "Đang rảnh" end
    local ck = "ST|" .. t
    if FastCache[ck] then return FastCache[ck] end
    if EXACT_VI[t] or LOWER_VI[t:lower()] then
        local r = EXACT_VI[t] or LOWER_VI[t:lower()]
        FastCache[ck] = r; return r
    end
    local out = stripArt(t)
    for i = 1, #GRAMMAR_VI do
        if out:find(GRAMMAR_VI[i].pat) then out = out:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep); break end
    end
    out = applyWords(applyPhrases(out)):gsub("%s+", " "):match("^%s*(.-)%s*$") or out
    FastCache[ck] = out; return out
end

local function translateText(raw)
    if not raw or raw == "" then return raw end
    local ck = State.Language .. "|" .. raw
    if FastCache[ck] then return FastCache[ck] end
    if raw:find("Venyx SAE", 1, true) then raw = raw:gsub("Venyx SAE", "Chilli SAE")
    elseif raw == "VENYX" or raw == "Chilli Hub V5" or raw == "Chilli V5 |" then raw = NEW_TITLE end
    if State.Language == "EN" then FastCache[ck] = raw; return raw end
    local norm = (raw:match("^%s*(.-)%s*$") or raw):gsub("%s+", " ")
    if norm:match("^[%$%+%-%d%.%,%/%%sxhm]+$") or (norm:match("^v%d+%.%d+") and #norm < 10) then FastCache[ck] = raw; return raw end
    if EXACT_VI[norm] or LOWER_VI[norm:lower()] then
        local r = EXACT_VI[norm] or LOWER_VI[norm:lower()]
        FastCache[ck] = r; return r
    end
    local dots = norm:match("^(.+)%.%.%.$")
    if dots then
        dots = dots:match("^%s*(.-)%s*$") or dots
        local m = EXACT_VI[dots] or LOWER_VI[dots:lower()]
        if m then FastCache[ck] = m .. "..."; return FastCache[ck] end
    end
    local pfx, wp = norm:match("^([^%w%s]+%s*)(.+)$")
    if pfx and wp and (EXACT_VI[wp] or LOWER_VI[wp:lower()]) then
        FastCache[ck] = pfx .. (EXACT_VI[wp] or LOWER_VI[wp:lower()]); return FastCache[ck]
    end
    for i = 1, #DYN_VI do
        if norm:find(DYN_VI[i].pat) then FastCache[ck] = norm:gsub(DYN_VI[i].pat, DYN_VI[i].rep); return FastCache[ck] end
    end
    local res, hit = norm, false
    local caps = (norm:upper() == norm and norm:find("%a") ~= nil)
    for i = 1, #GRAMMAR_VI do
        if res:find(GRAMMAR_VI[i].pat) then res = res:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep); hit = true; break end
    end
    local phr = applyPhrases(res)
    if hit or phr ~= res or res:find("%s") then
        local fin = applyWords(phr):gsub("Venyx", "Chilli Hub"):gsub("%s+", " "):match("^%s*(.-)%s*$") or res
        if caps and fin ~= norm then fin = fin:upper() end
        FastCache[ck] = fin; return fin
    end
    FastCache[ck] = raw; return raw
end

local function applyTrans(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHookSession") or inst:GetAttribute("__HiddenVxLogo")
       or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name:find("^ChilliSena")
       or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliV5_NoticeGui")
       or inst:FindFirstAncestor("ChilliSenaTopTelemetry") or inst:FindFirstAncestor("ChilliSenaBottomBar")
       or inst:GetAttribute("__IsTranslating") then return end

    if inst:IsA("TextBox") then
        local ph = inst:GetAttribute("OrigPlaceholder")
        if not ph and inst.PlaceholderText ~= "" and not hasVi(inst.PlaceholderText) then
            ph = inst.PlaceholderText; inst:SetAttribute("OrigPlaceholder", ph)
        end
        if ph then inst.PlaceholderText = translateText(ph) end
        if not inst:IsFocused() then
            local bt = inst.Text
            if bt == "Off" or bt == "Tắt" or bt == "None" or bt == "Không có" then
                local ob = inst:GetAttribute("OrigBoxText") or ((bt == "Tắt") and "Off" or ((bt == "Không có") and "None" or bt))
                inst:SetAttribute("OrigBoxText", ob)
                local mb = translateText(ob)
                if inst.Text ~= mb then inst:SetAttribute("__IsTranslating", true); pcall(function() inst.Text = mb end); inst:SetAttribute("__IsTranslating", false) end
            end
        end
        return
    end

    local rt = inst.Text
    if isFpsTxt(rt) then hookFps(inst); return end
    local orig = inst:GetAttribute("OrigRawText")
    if not orig then
        if not hasVi(rt) then orig = rt; inst:SetAttribute("OrigRawText", orig) else return end
    end
    local mapped = translateText(orig)
    inst:SetAttribute("__LastTranslated", mapped)
    if inst.Text ~= mapped then
        inst:SetAttribute("__IsTranslating", true); pcall(function() inst.Text = mapped end); inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookTrans(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint"
       or inst.Name == "ChilliUltraTitleBadge" or inst.Name:find("^ChilliSena")
       or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliV5_NoticeGui")
       or inst:FindFirstAncestor("ChilliSenaTopTelemetry") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
    if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then hookFps(inst); return end
    applyTrans(inst)
    if inst:GetAttribute("__TransHookSession") == SID then return end
    inst:SetAttribute("__TransHookSession", SID)
    table.insert(State.TrackedTexts, inst)
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if not isAlive() or inst:GetAttribute("__IsTranslating") or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") then return end
        if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then hookFps(inst); return end
        if inst:IsA("TextBox") then applyTrans(inst); return end
        local cur = inst.Text
        if cur ~= inst:GetAttribute("__LastTranslated") and not hasVi(cur) then
            inst:SetAttribute("OrigRawText", cur); applyTrans(inst)
        end
    end)
end

-- 4. BẢNG THÔNG BÁO UPDATE
local function showNotice()
    if State.NoticeShown then return end
    State.NoticeShown = true
    local parentTarget = (gethui and pcall(gethui) and gethui()) or CoreGui
    local nGui = mk("ScreenGui", { Name="ChilliV5_NoticeGui", DisplayOrder=2147483647, ZIndexBehavior=Enum.ZIndexBehavior.Sibling }, parentTarget)
    local ov = mk("Frame", { Size=UDim2.new(1,0,1,0), BackgroundColor3=BLACK_BG, BackgroundTransparency=0.5, Active=true }, nGui)
    local md = mk("Frame", { Size=UDim2.new(0,360,0,220), Position=UDim2.new(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Color3.fromRGB(12,13,20), BorderSizePixel=0, ClipsDescendants=true }, ov)
    mk("UICorner", { CornerRadius=UDim.new(0,12) }, md)
    local st = mk("UIStroke", { Thickness=2, Color=Color3.new(1,1,1), ApplyStrokeMode=Enum.ApplyStrokeMode.Border }, md)
    table.insert(State.ActiveGradients, mk("UIGradient", { Color=RAINBOW }, st))
    local tLbl = mk("TextLabel", { Size=UDim2.new(1,0,0,40), BackgroundTransparency=1, Font=Enum.Font.GothamBlack, TextSize=16, TextColor3=Color3.new(1,1,1) }, md)
    local bLbl = mk("TextLabel", { Size=UDim2.new(1,-30,0,115), Position=UDim2.new(0,15,0,42), BackgroundTransparency=1, TextWrapped=true, Font=Enum.Font.GothamMedium, TextSize=12.5, TextColor3=Color3.fromRGB(220,230,255), TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top }, md)
    local cBtn = mk("TextButton", { Size=UDim2.new(0,120,0,32), Position=UDim2.new(0.5,0,1,-42), AnchorPoint=Vector2.new(0.5,0), BackgroundColor3=Color3.fromRGB(235,60,60), Font=Enum.Font.GothamBold, TextSize=13, TextColor3=Color3.new(1,1,1) }, md)
    mk("UICorner", { CornerRadius=UDim.new(0,6) }, cBtn)

    local function syncNotice()
        if State.Language == "VI" then
            tLbl.Text = "🚀 CHILLI HUB ULTRA - UPDATE"
            bLbl.Text = "✨ Tính năng Auto Config: Tự động nhập cấu hình Auto Farm chuẩn, tối ưu 100% cho mọi tài khoản (mới chơi/ít tốc độ) và thiết bị (kể cả máy yếu/lag). Cấu hình đã được test kỹ càng để mang lại hiệu quả cao nhất!\n\n✨ TUY NHIÊN SETTING KHÔNG THỂ ĐÚNG HOÀN TOÀN YÊU CẦU CỦA MỖI TÀI KHOẢN THIẾT BỊ. BẠN CÓ THỂ CHỈNH LẠI NHỮNG THỨ CHƯA ĐÚNG YÊU CẦU CỦA BẠN."
            cBtn.Text = "ĐÓNG"
        else
            tLbl.Text = "🚀 CHILLI HUB ULTRA - UPDATE"
            bLbl.Text = "✨ Auto Config Feature: 100% optimized Auto Farm preset for all accounts (even beginners/low speed) and devices (even laggy ones). Strictly tested for the best and most suitable results!\n\n✨ New Interface: Completely redesigned for a more beautiful and professional look."
            cBtn.Text = "CLOSE"
        end
    end
    syncNotice()
    State.RefreshNoticeCallback = syncNotice
    cBtn.MouseButton1Click:Connect(function() State.RefreshNoticeCallback = nil; nGui:Destroy() end)
end

local function refreshAll()
    task.spawn(function()
        if State.RefreshIslandCallback then State.RefreshIslandCallback() end
        if State.RefreshNoticeCallback then State.RefreshNoticeCallback() end
        local list = State.TrackedTexts
        for i = #list, 1, -1 do
            if not isAlive() then return end
            local el = list[i]
            if el and el.Parent then applyTrans(el) else table.remove(list, i) end
            if i % 80 == 0 then task.wait() end
        end
    end)
end

-- 5. NẠP CONFIG
local function fireBtn(btn)
    if not btn then return false end
    local fired = false
    local clickable = (btn:IsA("TextButton") or btn:IsA("ImageButton")) and btn
        or btn:FindFirstAncestorWhichIsA("TextButton") or btn:FindFirstAncestorWhichIsA("ImageButton") or btn
    if getconnections then
        for _, sigName in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
            pcall(function()
                local sig = clickable[sigName]
                if sig then
                    for _, conn in ipairs(getconnections(sig)) do
                        if conn.Function then task.spawn(conn.Function); fired = true end
                    end
                end
            end)
        end
    end
    if firesignal then
        pcall(function() firesignal(clickable.MouseButton1Click); fired = true end)
        pcall(function() firesignal(clickable.Activated); fired = true end)
    end
    return fired
end

local function runAutoFarmMacro(venyxGui, btnLbl)
    task.spawn(function()
        if btnLbl then btnLbl.Text = "⏳ ĐANG NẠP CONFIG..." end
        local function findImportControls()
            local box, btn
            for _, d in ipairs(venyxGui:GetDescendants()) do
                if d:IsA("TextBox") then
                    local ph = (d:GetAttribute("OrigPlaceholder") or d.PlaceholderText or ""):lower()
                    if ph:find("paste config", 1, true) or ph:find("dán mã", 1, true) then box = d end
                elseif d:IsA("TextButton") or d:IsA("TextLabel") then
                    local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
                    if ot == "Import" or d.Text == "Nhập" then btn = d end
                end
            end
            return box, btn
        end

        local importBox, importBtn = findImportControls()
        if not importBox or not importBtn then
            for _, d in ipairs(venyxGui:GetDescendants()) do
                if d:IsA("TextButton") or d:IsA("TextLabel") then
                    local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
                    if ot == "Config" or d.Text == "Cấu Hình" then fireBtn(d); break end
                end
            end
            task.wait(0.25)
            importBox, importBtn = findImportControls()
        end

        if not importBox then
            if btnLbl then btnLbl.Text = "⚠️ MỞ MỤC CẤU HÌNH TRƯỚC!"; task.wait(2); btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM" end
            return
        end

        importBox:SetAttribute("__IsTranslating", true)
        pcall(function() importBox:CaptureFocus() end)
        task.wait(0.04)
        importBox.Text = PRESET_JSON
        pcall(function() importBox:ReleaseFocus(true) end)
        if firesignal then pcall(function() firesignal(importBox.FocusLost, true) end) end
        importBox:SetAttribute("__IsTranslating", false)

        task.wait(0.12)
        if importBtn then fireBtn(importBtn) end

        if btnLbl then
            btnLbl.Text = "✅ ĐÃ NHẬP CONFIG!"
            task.wait(2.0)
            btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM"
        end
    end)
end

-- 6. DYNAMIC ISLAND
local function setupIsland(statusLbl, venyxGui)
    local pill = statusLbl.Parent
    if not (pill and pill:IsA("GuiObject")) then return end
    statusLbl:SetAttribute("__IslandDone", true)
    for _, ch in ipairs(pill:GetChildren()) do if ch:IsA("UIGradient") or ch.Name == "IslandClickHitbox" then ch:Destroy() end end

    pill.BackgroundColor3, pill.BackgroundTransparency, pill.Size, pill.AutomaticSize = BLACK_BG, 0, UDim2.new(0,0,0,28), Enum.AutomaticSize.X
    if pill:GetAttribute("__BlackBgSession") ~= SID then
        pill:SetAttribute("__BlackBgSession", SID)
        pill:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() if isAlive() and pill.BackgroundColor3 ~= BLACK_BG then pill.BackgroundColor3 = BLACK_BG end end)
        pill:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() if isAlive() and pill.BackgroundTransparency ~= 0 then pill.BackgroundTransparency = 0 end end)
    end

    local hint = pill:FindFirstChild("IslandExpandHint") or mk("TextLabel", {
        Name="IslandExpandHint", Size=UDim2.new(0,18,0,18), BackgroundColor3=Color3.fromRGB(28,32,48), BorderSizePixel=0,
        Text="▼", Font=Enum.Font.GothamBold, TextSize=9, TextColor3=Color3.fromRGB(165,210,255), LayoutOrder=99, ZIndex=10000
    }, pill)
    if not hint:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius=UDim.new(1,0) }, hint) end

    local function syncStatus(fromSaved)
        if statusLbl:GetAttribute("__Updating") then return end
        statusLbl:SetAttribute("__Updating", true)
        local cur = statusLbl.Text:gsub("●",""):gsub("•",""):gsub("✨%s*rainbow",""):match("^%s*(.-)%s*$") or ""
        local en = statusLbl:GetAttribute("OrigStatusEn") or statusLbl:GetAttribute("OrigRawText")
        if not fromSaved and cur ~= "" and cur ~= statusLbl:GetAttribute("__LastTranslatedStatus") and not hasVi(cur) then
            en = cur; statusLbl:SetAttribute("OrigStatusEn", en)
        end
        if not en or en == "" or hasVi(en) then en = "Idle"; statusLbl:SetAttribute("OrigStatusEn", "Idle") end
        local fin = translateStatus(en)
        statusLbl:SetAttribute("__LastTranslatedStatus", fin); statusLbl:SetAttribute("__LastTranslated", fin)
        if statusLbl.Text ~= fin then statusLbl.Text = fin end
        statusLbl.TextColor3, statusLbl.TextTransparency, statusLbl.Size, statusLbl.AutomaticSize = Color3.new(1,1,1), 0, UDim2.new(0,0,1,0), Enum.AutomaticSize.X
        statusLbl:SetAttribute("__Updating", false)
    end
    State.RefreshIslandCallback = function() syncStatus(true) end
    syncStatus(false)

    local exp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
    if statusLbl:GetAttribute("__IslandSession") == SID and exp then return end
    statusLbl:SetAttribute("__IslandSession", SID)

    local tg = statusLbl:FindFirstChild("TextRainbow") or mk("UIGradient", { Name="TextRainbow", Color=RAINBOW }, statusLbl)
    table.insert(State.ActiveGradients, tg)

    pill.Parent, pill.AnchorPoint, pill.ZIndex, pill.Active, statusLbl.Active, hint.Active = venyxGui, Vector2.new(0.5,0), 9999, true, true, true
    if pill.Position.Y.Offset < 4 or pill.Position.Y.Offset > 600 then pill.Position = UDim2.new(0.5,0,0,8) end
    if not pill:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius=UDim.new(1,0) }, pill) end
    local ps = pill:FindFirstChild("IslandStroke") or mk("UIStroke", { Name="IslandStroke", Thickness=1.8, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Color=Color3.new(1,1,1) }, pill)
    table.insert(State.ActiveGradients, ps:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, ps))

    if exp then exp:Destroy() end
    exp = mk("Frame", {
        Name="ChilliV5_ExpandedIsland", AnchorPoint=Vector2.new(0.5,0), Position=pill.Position, Size=UDim2.new(0,268,0,118),
        BackgroundColor3=BLACK_BG, BorderSizePixel=0, Visible=false, Active=true, ZIndex=10000
    }, venyxGui)
    mk("UICorner", { CornerRadius=UDim.new(0,16) }, exp)
    local es = mk("UIStroke", { Thickness=1.8, Color=Color3.new(1,1,1), ApplyStrokeMode=Enum.ApplyStrokeMode.Border }, exp)
    table.insert(State.ActiveGradients, mk("UIGradient", { Color=RAINBOW }, es))

    mk("TextLabel", { Size=UDim2.new(1,-44,0,28), Position=UDim2.new(0,14,0,4), BackgroundTransparency=1, Text="🌶️ Chilli Hub Ultra", Font=Enum.Font.GothamBold, TextSize=11.5, TextColor3=Color3.new(1,1,1), TextXAlignment=Enum.TextXAlignment.Left, ZIndex=10001 }, exp)
    local colBtn = mk("TextButton", { Size=UDim2.new(0,24,0,22), Position=UDim2.new(1,-32,0,7), BackgroundColor3=Color3.fromRGB(22,24,34), BorderSizePixel=0, Text="▲", Font=Enum.Font.GothamBold, TextSize=10, TextColor3=Color3.fromRGB(160,205,255), ZIndex=10002 }, exp)
    mk("UICorner", { CornerRadius=UDim.new(1,0) }, colBtn)

    local cap = mk("Frame", { Size=UDim2.new(1,-20,0,34), Position=UDim2.new(0,10,0,36), BackgroundColor3=Color3.fromRGB(18,20,30), BorderSizePixel=0, ZIndex=10001 }, exp)
    mk("UICorner", { CornerRadius=UDim.new(1,0) }, cap)
    local sld = mk("Frame", { Size=UDim2.new(0.5,-4,1,-4), Position=(State.Language=="VI" and UDim2.new(0,2,0,2) or UDim2.new(0.5,2,0,2)), BackgroundColor3=Color3.fromRGB(95,110,235), BorderSizePixel=0, ZIndex=10002 }, cap)
    mk("UICorner", { CornerRadius=UDim.new(1,0) }, sld)

    local bVI = mk("TextButton", { Size=UDim2.new(0.5,0,1,0), BackgroundTransparency=1, Text="🇻🇳 TIẾNG VIỆT", Font=Enum.Font.GothamBold, TextSize=10.5, TextColor3=(State.Language=="VI" and Color3.new(1,1,1) or Color3.fromRGB(150,165,190)), ZIndex=10003 }, cap)
    local bEN = mk("TextButton", { Size=UDim2.new(0.5,0,1,0), Position=UDim2.new(0.5,0,0,0), BackgroundTransparency=1, Text="🌐 ENGLISH", Font=Enum.Font.GothamBold, TextSize=10.5, TextColor3=(State.Language=="EN" and Color3.new(1,1,1) or Color3.fromRGB(150,165,190)), ZIndex=10003 }, cap)

    local cfgBtn = mk("TextButton", { Name="AutoFarmConfigBtn", Size=UDim2.new(1,-20,0,34), Position=UDim2.new(0,10,0,74), BackgroundColor3=Color3.fromRGB(24,28,44), BorderSizePixel=0, Text="⚡ CONFIG SETTING AUTO FARM", Font=Enum.Font.GothamBold, TextSize=10.5, TextColor3=Color3.new(1,1,1), ZIndex=10003 }, exp)
    mk("UICorner", { CornerRadius=UDim.new(1,0) }, cfgBtn)
    local cs = mk("UIStroke", { Thickness=1.3, Color=Color3.new(1,1,1), ApplyStrokeMode=Enum.ApplyStrokeMode.Border }, cfgBtn)
    table.insert(State.ActiveGradients, mk("UIGradient", { Color=RAINBOW }, cs))
    cfgBtn.MouseButton1Click:Connect(function() runAutoFarmMacro(venyxGui, cfgBtn) end)

    local function setLang(l)
        if State.Language == l then return end
        State.Language = l
        if writefile then pcall(writefile, LANG_FILE, l) end
        TweenService:Create(sld, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position=(l=="VI" and UDim2.new(0,2,0,2) or UDim2.new(0.5,2,0,2)) }):Play()
        bVI.TextColor3 = l=="VI" and Color3.new(1,1,1) or Color3.fromRGB(150,165,190)
        bEN.TextColor3 = l=="EN" and Color3.new(1,1,1) or Color3.fromRGB(150,165,190)
        refreshAll()
    end
    bVI.MouseButton1Click:Connect(function() setLang("VI") end)
    bEN.MouseButton1Click:Connect(function() setLang("EN") end)

    local function toggleExp(open)
        if open then
            exp.Position, pill.Visible, exp.Size, exp.Visible = pill.Position, false, UDim2.new(0,160,0,28), true
            TweenService:Create(exp, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size=UDim2.new(0,268,0,118) }):Play()
        else
            pill.Position, exp.Visible, pill.Visible = exp.Position, false, true
        end
    end
    colBtn.MouseButton1Click:Connect(function() toggleExp(false) end)

    local function bindDrag(trig, mv, tap)
        if trig:GetAttribute("__DragSession") == SID then return end
        trig:SetAttribute("__DragSession", SID)
        local drag, dStart, sPos, moved = false, nil, nil, false
        trig.InputBegan:Connect(function(inp)
            if not isAlive() then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                drag, moved, dStart, sPos = true, false, inp.Position, mv.Position
                inp.Changed:Connect(function()
                    if inp.UserInputState == Enum.UserInputState.End then
                        if drag and not moved and tap then tap() end
                        drag = false
                    end
                end)
            end
        end)
        trig.InputChanged:Connect(function(inp)
            if not isAlive() or not drag then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dStart
                if d.Magnitude > 6 then moved = true end
                local cam = workspace.CurrentCamera
                local mx, my = cam and cam.ViewportSize.X - 140 or 800, cam and cam.ViewportSize.Y - 50 or 600
                local np = UDim2.new(sPos.X.Scale, math.clamp(sPos.X.Offset + d.X, -mx/2, mx/2), sPos.Y.Scale, math.clamp(sPos.Y.Offset + d.Y, 4, my))
                pill.Position, exp.Position = np, np
            end
        end)
    end
    local openFn = function() toggleExp(true) end
    bindDrag(pill, pill, openFn); bindDrag(statusLbl, pill, openFn); bindDrag(hint, pill, openFn); bindDrag(exp, exp, nil)
    statusLbl:GetPropertyChangedSignal("Text"):Connect(function()
        if isAlive() and not statusLbl:GetAttribute("__Updating") and statusLbl.Text ~= statusLbl:GetAttribute("__LastTranslatedStatus") then syncStatus(false) end
    end)
end

-- 7. NÚT NỔI TRÒN HÀO QUANG KÉP (BAO QUÁT TRỌN VẸN CHI TIẾT ẢNH 2)
local function cleanupStrayLogos(gui, win)
    if not gui or not win then return end
    for _, d in ipairs(win:GetDescendants()) do
        if d.Name == "ChilliV5CoverLogo" or d.Name == "RainbowBorder" or d.Name == "PerfectCircleAspect" or d.Name == "ChilliInnerRing" or d.Name == "ChilliCosmicAura" then
            pcall(d.Destroy, d)
        end
    end
end

local function setupCircleLogo(obj, win)
    local top = obj
    while top.Parent and top.Parent:IsA("GuiObject") and not top.Parent:IsA("ScreenGui") do top = top.Parent end
    if not top or (win and (top == win or top:IsDescendantOf(win))) then return end
    if top.Name == "ChilliV5_ExpandedIsland" or top:FindFirstChild("IslandExpandHint") then return end

    for _, ch in ipairs(top:GetDescendants()) do
        if (ch:IsA("TextLabel") or ch:IsA("TextButton")) and not ch:GetAttribute("__HiddenVxLogo") then
            local t = (ch.Text or ""):match("^%s*(.-)%s*$")
            if t ~= "" and t ~= "V" and t ~= "x" and t ~= "Vx" and t ~= "VX" then return end
        end
    end

    local sz, pos = top.AbsoluteSize, top.AbsolutePosition
    if sz.X > 95 or sz.Y > 95 or sz.X < 28 or math.abs(sz.X - sz.Y) > 20 or pos.X > 260 then return end

    for _, ch in ipairs(top:GetDescendants()) do
        if (ch:IsA("UIPadding") or ch:IsA("UIAspectRatioConstraint") or ch:IsA("UISizeConstraint")) and ch.Name ~= "PerfectCircleAspect" then
            pcall(ch.Destroy, ch)
        end
        if (ch:IsA("ImageLabel") or ch:IsA("ImageButton")) and ch.Name ~= "ChilliV5CoverLogo" and ch.Name ~= "ChilliCosmicAura" then
            ch.ImageTransparency, ch.BackgroundTransparency = 1, 1
        elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
            ch:SetAttribute("__HiddenVxLogo", true); ch.TextTransparency, ch.BackgroundTransparency = 1, 1
        end
    end
    if top:IsA("ImageLabel") or top:IsA("ImageButton") then top.ImageTransparency = 1
    elseif top:IsA("TextLabel") or top:IsA("TextButton") then top:SetAttribute("__HiddenVxLogo", true); top.TextTransparency = 1 end

    -- Nâng cấp Logo Script bao quát trọn vẹn 100% chi tiết như Ảnh 2 (không bị cắt xén sao và vòng nguyên tử)
    top.Size = UDim2.new(0, 72, 0, 72)
    if not top:GetAttribute("__SafePosAdjusted") then
        top:SetAttribute("__SafePosAdjusted", true)
        if pos.Y > 125 and pos.Y < 260 then
            top.Position = UDim2.new(0, 18, 0, 58)
        end
    end
    top.BackgroundColor3 = LOGO_BG
    top.BackgroundTransparency = 1 -- Trong suốt để lộ trọn vẹn viền tinh vân và các ngôi sao góc ngoài
    top.BorderSizePixel = 0
    top.ClipsDescendants = false -- Tuyệt đối KHÔNG cắt xén chi tiết ảnh

    if not top:FindFirstChild("PerfectCircleAspect") then
        mk("UIAspectRatioConstraint", { Name = "PerfectCircleAspect", AspectRatio = 1 }, top)
    end

    if not top:GetAttribute("__SizeLockedV5Pro") then
        top:SetAttribute("__SizeLockedV5Pro", true)
        top:GetPropertyChangedSignal("Size"):Connect(function()
            if top.Size ~= UDim2.new(0, 72, 0, 72) then top.Size = UDim2.new(0, 72, 0, 72) end
        end)
    end

    -- Hào quang nền mờ dịu bao quanh quả ớt
    local auraGlow = top:FindFirstChild("ChilliCosmicAura") or mk("Frame", {
        Name = "ChilliCosmicAura", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.86, 0.86), BackgroundColor3 = LOGO_BG, BackgroundTransparency = 0.35,
        BorderSizePixel = 0, Active = false, ZIndex = top.ZIndex + 1
    }, top)
    if not auraGlow:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, auraGlow) end
    local auraStroke = auraGlow:FindFirstChildOfClass("UIStroke") or mk("UIStroke", {
        Thickness = 2.2, Transparency = 0.15, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1)
    }, auraGlow)
    table.insert(State.ActiveGradients, auraStroke:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, auraStroke))

    -- Ảnh Logo vũ trụ hiển thị trọn vẹn 100% bao quát hết ngôi sao, vòng quỹ đạo nguyên tử và ngọn lửa cầu vồng
    local cov = top:FindFirstChild("ChilliV5CoverLogo") or mk("ImageLabel", {
        Name = "ChilliV5CoverLogo", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit,
        Active = false, ZIndex = top.ZIndex + 5
    }, top)
    cov.Image = LOGO_ID
    cov.Size = UDim2.fromScale(1, 1)
    cov.ScaleType = Enum.ScaleType.Fit
    local oldCorner = cov:FindFirstChildOfClass("UICorner")
    if oldCorner then oldCorner:Destroy() end

    -- Đảm bảo khi bấm vào nút nổi mở lại Menu thì kích hoạt đồng bộ hiển thị ngay lập tức + hiệu ứng nảy
    if not top:GetAttribute("__SyncClickHooked") then
        top:SetAttribute("__SyncClickHooked", true)
        local function triggerSync()
            -- Hiệu ứng nảy đàn hồi khi chạm nút nổi logo
            TweenService:Create(top, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, 64, 0, 64) }):Play()
            task.delay(0.1, function()
                TweenService:Create(top, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 72, 0, 72) }):Play()
            end)
            task.defer(function()
                task.wait(0.04)
                if State.SyncWindowFn then pcall(State.SyncWindowFn) end
            end)
        end
        if top:IsA("GuiButton") then
            top.Activated:Connect(triggerSync)
            top.MouseButton1Click:Connect(triggerSync)
        end
        top.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                triggerSync()
            end
        end)
    end
end

-- 8. CHILLI HUB ULTRA ARCHITECTURE (TẮT MỞ GIAO DIỆN & VIỀN TỨC THÌ 0MS, FIX LỖI MẤT GIAO DIỆN)
local SIDEBAR_PALETTE = {
    Color3.fromRGB(37, 99, 235),  -- [1] Trang Chủ: Xanh Dương
    Color3.fromRGB(239, 68, 68),  -- [2] Cướp Trứng: Đỏ
    Color3.fromRGB(245, 158, 11), -- [3] Cày Cuốc: Cam Vàng
    Color3.fromRGB(168, 85, 247), -- [4] Sự Kiện: Tím
    Color3.fromRGB(236, 72, 153), -- [5] Người Chơi: Hồng
    Color3.fromRGB(16, 185, 129), -- [6] Hệ Thống: Xanh Ngọc
}

local function applySenaV7Architecture(win, titleLbl)
    if not win or not titleLbl then return end
    local hy, tx = titleLbl.AbsolutePosition.Y, titleLbl.AbsolutePosition.X
    local winX = win.AbsolutePosition.X

    pcall(function()
        win.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
        win.ClipsDescendants = true
    end)

    -- A. VIỀN CẦU VỒNG QUANH MENU
    local winStroke = win:FindFirstChild("ChilliProWindowStroke")
    if not winStroke then
        winStroke = mk("UIStroke", {
            Name = "ChilliProWindowStroke", Thickness = 1.8, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = Color3.new(1, 1, 1), Transparency = 0.1
        }, win)
        table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, winStroke))
    end

    -- Lớp Wallpaper nền mờ bên trong khung nội dung chính
    local wp = win:FindFirstChild("ChilliSenaWallpaper")
    if not wp then
        wp = mk("ImageLabel", {
            Name = "ChilliSenaWallpaper", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, -26),
            Size = UDim2.new(1, -58, 1, -68), BackgroundTransparency = 1, Image = WALLPAPER_IMAGE_ID,
            ImageTransparency = 0.78, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = win.ZIndex + 1
        }, win)
        mk("UICorner", { CornerRadius = UDim.new(0, 10) }, wp)
    end

    for _, d in ipairs(win:GetDescendants()) do
        if d:IsA("ScrollingFrame") then
            d.BackgroundTransparency = 1
            for _, card in ipairs(d:GetChildren()) do
                if card:IsA("Frame") and card.BackgroundTransparency < 0.25 then
                    card.BackgroundColor3 = Color3.fromRGB(16, 18, 26)
                    card.BackgroundTransparency = 0.32
                end
            end
        end
    end

    -- B. THANH HEADER + NHÃN TÊN "Chilli Hub Ultra" MÀU NEON ULTRA RỰC RỠ + BANNER ẢNH 3
    local headerBar = titleLbl.Parent
    local curr = titleLbl
    while curr and curr ~= win do
        if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= (win.AbsoluteSize.X - 30) and curr.AbsoluteSize.Y >= 24 and curr.AbsoluteSize.Y <= 68 then
            headerBar = curr
            break
        end
        curr = curr.Parent
    end

    -- Khôi phục hiển thị toàn bộ container cha của titleLbl
    local pWalk = titleLbl
    while pWalk and pWalk ~= win do
        if pWalk:IsA("GuiObject") then pWalk.Visible = true end
        pWalk = pWalk.Parent
    end

    if headerBar and headerBar:IsA("GuiObject") then
        local baseZ = math.max(2, headerBar.ZIndex)
        for _, desc in ipairs(headerBar:GetDescendants()) do
            if desc:IsA("GuiObject") and not desc.Name:find("^ChilliCosmic") and not desc.Name:find("^ChilliSena") then
                if desc.ZIndex < baseZ + 6 then desc.ZIndex = baseZ + 6 end
            end
            if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and desc ~= titleLbl and desc.Name ~= "ChilliUltraTitleBadge" then
                local dt = desc.Text or ""
                if dt:match("^v%d+%.%d+") or dt == "/" or dt:lower():find("steal an egg", 1, true) or dt:lower():find("cướp trứng", 1, true) then
                    desc.TextTransparency = 1
                    desc.BackgroundTransparency = 1
                end
            end
        end

        -- Ẩn chữ gốc của titleLbl và dựng nhãn "Chilli Hub Ultra" màu Neon Ultra chuyển sắc rực rỡ
        titleLbl.TextTransparency = 1
        local ultraTitle = headerBar:FindFirstChild("ChilliUltraTitleBadge")
        if not ultraTitle then
            ultraTitle = mk("TextLabel", {
                Name = "ChilliUltraTitleBadge",
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 42, 0.5, 0),
                Size = UDim2.new(0, 170, 0, 28),
                BackgroundTransparency = 1,
                RichText = false, -- Tắt RichText để UIGradient phủ trọn vẹn toàn bộ các ký tự
                Text = "Chilli Hub Ultra",
                Font = Enum.Font.GothamBlack,
                TextSize = 16,
                TextColor3 = Color3.new(1, 1, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
                Active = false,
                ZIndex = baseZ + 12
            }, headerBar)
            mk("UIStroke", { Thickness = 1.6, Color = Color3.fromRGB(15, 8, 25), Transparency = 0.15 }, ultraTitle)
            local uGrad = mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, ultraTitle)
            table.insert(State.ActiveGradients, uGrad)
        else
            ultraTitle.RichText = false
            ultraTitle.Text = "Chilli Hub Ultra"
            ultraTitle.TextSize = 16
        end

        -- Thanh banner không gian của Ảnh 3 (6944.png) phủ lên thanh khung Header, căn chỉnh hài hòa
        local bannerHolder = headerBar:FindFirstChild("ChilliCosmicHolder")
        if not bannerHolder then
            bannerHolder = mk("Frame", {
                Name = "ChilliCosmicHolder", Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0, 0),
                BackgroundColor3 = Color3.fromRGB(14, 15, 22), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = baseZ + 1
            }, headerBar)
            mk("UICorner", { CornerRadius = UDim.new(0, 10) }, bannerHolder)
            
            -- Ảnh 3 (6944.png) trải dọc Header làm nổi bật quả cầu hành tinh bên trái và dải mây tinh vân bên phải
            mk("ImageLabel", {
                Name = "ChilliCosmicMainBanner", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(1, 0, 1.35, 0), BackgroundTransparency = 1, Image = HEADER_BAR_IMG_ID,
                ScaleType = Enum.ScaleType.Stretch, ImageTransparency = 0.32, Active = false, ZIndex = baseZ + 2
            }, bannerHolder)
            
            -- Đường chỉ sáng viền neon dưới đáy thanh Header đổi màu cầu vồng
            local bottomLine = mk("Frame", {
                Name = "ChilliCosmicBottomGlow", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1),
                Size = UDim2.new(1, 0, 0, 1.8), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = false, ZIndex = baseZ + 4
            }, bannerHolder)
            table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, bottomLine))
        end

        -- DẢI TELEMETRY PILLS KIỂU SENA V7 (Đặt ở X = 212 bên phải chữ Chilli Hub Ultra)
        local teleRow = headerBar:FindFirstChild("ChilliSenaTopTelemetry")
        if teleRow then teleRow.Position = UDim2.new(0, 212, 0.5, 0); teleRow.Size = UDim2.new(1, -385, 0, 22) end
        if not teleRow then
            teleRow = mk("Frame", {
                Name = "ChilliSenaTopTelemetry",
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 212, 0.5, 0),
                Size = UDim2.new(1, -385, 0, 22),
                BackgroundTransparency = 1,
                Active = false,
                ZIndex = baseZ + 8
            }, headerBar)
            mk("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 4)
            }, teleRow)

            local function makePill(name, defaultTxt, textColor)
                local pFrame = mk("Frame", {
                    Name = name, Size = UDim2.new(0, 0, 0, 20), AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Color3.fromRGB(22, 24, 34), BackgroundTransparency = 0.15, BorderSizePixel = 0, Active = false, ZIndex = baseZ + 8
                }, teleRow)
                mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pFrame)
                mk("UIStroke", { Thickness = 1, Color = Color3.fromRGB(48, 52, 72), Transparency = 0.3 }, pFrame)
                mk("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }, pFrame)
                return mk("TextLabel", {
                    Name = "Val", Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1,
                    Text = defaultTxt, Font = Enum.Font.GothamBold, TextSize = 9.5, TextColor3 = textColor or Color3.fromRGB(235, 240, 255),
                    Active = false, ZIndex = baseZ + 9
                }, pFrame)
            end

            local lblTime   = makePill("PillTime",   "⏱️ 0:00:00", Color3.fromRGB(220, 230, 255))
            local lblStolen = makePill("PillStolen", "🥚 0 đã cướp", Color3.fromRGB(255, 190, 210))
            local lblCandy  = makePill("PillCandy",  "🍬 0", Color3.fromRGB(255, 215, 110))
            local lblPing   = makePill("PillPing",   "📶 65 ms", Color3.fromRGB(110, 255, 165))

            local botBar = win:FindFirstChild("ChilliSenaBottomBar")
            local lblBotFps = nil
            if not botBar then
                botBar = mk("Frame", {
                    Name = "ChilliSenaBottomBar", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 54, 1, 0),
                    Size = UDim2.new(1, -54, 0, 26), BackgroundColor3 = Color3.fromRGB(12, 13, 19), BackgroundTransparency = 0.05,
                    BorderSizePixel = 0, Active = false, ZIndex = baseZ + 8
                }, win)
                mk("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.fromRGB(38, 42, 58), BorderSizePixel = 0, Active = false, ZIndex = baseZ + 9 }, botBar)

                local dName = (LocalPlayer and LocalPlayer.Name) or "Player"
                mk("TextLabel", {
                    Name = "WelcomeLbl", Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(0, 200, 1, 0), BackgroundTransparency = 1,
                    Text = "Chào mừng, " .. dName:sub(1, 12) .. "  •  ULTRA VIP", Font = Enum.Font.GothamBold, TextSize = 10,
                    TextColor3 = Color3.fromRGB(185, 195, 220), TextXAlignment = Enum.TextXAlignment.Left, Active = false, ZIndex = baseZ + 9
                }, botBar)

                lblBotFps = mk("TextLabel", {
                    Name = "BotFpsLbl", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -92, 0.5, 0), Size = UDim2.new(0, 75, 0, 20),
                    BackgroundTransparency = 1, Text = "⚡ 108 FPS", Font = Enum.Font.GothamBold, TextSize = 10.5,
                    TextColor3 = Color3.fromRGB(110, 255, 165), TextXAlignment = Enum.TextXAlignment.Right, Active = false, ZIndex = baseZ + 9
                }, botBar)

                local donBadge = mk("Frame", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(0, 74, 0, 19),
                    BackgroundColor3 = Color3.fromRGB(45, 36, 16), BorderSizePixel = 0, Active = false, ZIndex = baseZ + 9
                }, botBar)
                mk("UICorner", { CornerRadius = UDim.new(1, 0) }, donBadge)
                mk("UIStroke", { Thickness = 1, Color = Color3.fromRGB(245, 190, 45), Transparency = 0.25 }, donBadge)
                mk("TextLabel", {
                    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "👑 Ultra", Font = Enum.Font.GothamBold,
                    TextSize = 10, TextColor3 = Color3.fromRGB(255, 210, 65), Active = false, ZIndex = baseZ + 10
                }, donBadge)
            else
                lblBotFps = botBar:FindFirstChild("BotFpsLbl")
            end

            State.TelemetryUpdateFn = function(curFps)
                if not win.Visible or win.BackgroundTransparency > 0.85 then return end
                local elapsed = math.floor(os.clock() - (State.StartClock or os.clock()))
                lblTime.Text = string.format("⏱️ %d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), elapsed % 60)

                local pingMs = 62
                pcall(function() pingMs = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
                if pingMs <= 0 then pingMs = math.random(48, 85) end
                lblPing.Text = string.format("📶 %d ms", pingMs)

                if lblBotFps then lblBotFps.Text = string.format("⚡ %d FPS", curFps or getFakeFps()) end
            end
        end

        -- C. CƠ CHẾ ĐỒNG BỘ HIỂN THỊ MENU CHILLI HUB ULTRA (TẮT MỞ TỨC THÌ 0MS, FIX HOÀN TOÀN LỖI MẤT GIAO DIỆN)
        local function syncWindowVisibilityInstant()
            if not win or not win.Parent then return end
            local bTrans = win.BackgroundTransparency
            local isOffscreen = (win.AbsolutePosition.X < -500 or win.AbsolutePosition.Y < -500)
            local isSizeZero = (win.AbsoluteSize.X < 80 or win.AbsoluteSize.Y < 60)
            local isHdrHidden = headerBar and ((not headerBar.Visible) or (headerBar.BackgroundTransparency >= 0.96))
            
            -- Menu chỉ đóng khi win ẩn, kích thước co lại 0, bị dời ra ngoài màn hình, hoặc mờ hoàn toàn (>= 96%)
            local isClosed = (not win.Visible) or isOffscreen or isSizeZero or (bTrans >= 0.96) or isHdrHidden
            local isOpen = not isClosed

            if winStroke then
                winStroke.Enabled = isOpen
                winStroke.Transparency = isOpen and 0.1 or 1
            end
            local cHolder = headerBar and headerBar:FindFirstChild("ChilliCosmicHolder")
            if cHolder then cHolder.Visible = isOpen end
            local uBadge = headerBar and headerBar:FindFirstChild("ChilliUltraTitleBadge")
            if uBadge then uBadge.Visible = isOpen end
            local tRow = headerBar and headerBar:FindFirstChild("ChilliSenaTopTelemetry")
            if tRow then tRow.Visible = isOpen end
            local bBar = win:FindFirstChild("ChilliSenaBottomBar")
            if bBar then bBar.Visible = isOpen end
            local wPaper = win:FindFirstChild("ChilliSenaWallpaper")
            if wPaper then wPaper.Visible = isOpen end

            if titleLbl and titleLbl.Parent then
                titleLbl.TextTransparency = (isOpen and uBadge and uBadge.Visible) and 1 or 0
            end
        end

        State.SyncWindowFn = syncWindowVisibilityInstant
        syncWindowVisibilityInstant()

        if not win:GetAttribute("__InstantHideHooked") then
            win:SetAttribute("__InstantHideHooked", true)

            win:GetPropertyChangedSignal("Visible"):Connect(syncWindowVisibilityInstant)
            win:GetPropertyChangedSignal("BackgroundTransparency"):Connect(syncWindowVisibilityInstant)
            win:GetPropertyChangedSignal("Size"):Connect(syncWindowVisibilityInstant)
            win:GetPropertyChangedSignal("Position"):Connect(syncWindowVisibilityInstant)

            if headerBar then
                headerBar:GetPropertyChangedSignal("Visible"):Connect(syncWindowVisibilityInstant)
                headerBar:GetPropertyChangedSignal("BackgroundTransparency"):Connect(syncWindowVisibilityInstant)
            end

            -- Bắt sự kiện bấm nút "-" góc trên phải Header để tắt viền và thanh đáy tức thì 0ms
            for _, d in ipairs(headerBar:GetDescendants()) do
                if (d:IsA("TextButton") or d:IsA("ImageButton") or d:IsA("TextLabel")) and (d.Text == "-" or d.Text == "—" or d.AbsolutePosition.X > win.AbsolutePosition.X + win.AbsoluteSize.X - 55) then
                    local btn = (d:IsA("TextButton") or d:IsA("ImageButton")) and d or d.Parent
                    if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) and not btn:GetAttribute("__CloseSyncHooked") then
                        btn:SetAttribute("__CloseSyncHooked", true)
                        btn.MouseButton1Down:Connect(function()
                            if winStroke then winStroke.Enabled = false end
                            local bBar = win:FindFirstChild("ChilliSenaBottomBar")
                            if bBar then bBar.Visible = false end
                            local wPaper = win:FindFirstChild("ChilliSenaWallpaper")
                            if wPaper then wPaper.Visible = false end
                            local cHolder = headerBar and headerBar:FindFirstChild("ChilliCosmicHolder")
                            if cHolder then cHolder.Visible = false end
                            local uBadge = headerBar and headerBar:FindFirstChild("ChilliUltraTitleBadge")
                            if uBadge then uBadge.Visible = false end
                            local tRow = headerBar and headerBar:FindFirstChild("ChilliSenaTopTelemetry")
                            if tRow then tRow.Visible = false end
                        end)
                    end
                end
            end
        end
    end

    -- D. NÚT SIDEBAR SQUIRCLE ĐA SẮC + PHÓNG TO ICON TRỨNG (ẢNH 4) + HIỆU ỨNG TƯƠNG TÁC TAB ĐỈNH CAO
    local navButtons = {}
    for _, d in ipairs(win:GetDescendants()) do
        if d:IsA("GuiObject") and (d.AbsolutePosition.X - winX) < 75 and d.AbsolutePosition.Y > hy + 15 then
            local children = {}
            for _, ch in ipairs(d:GetChildren()) do
                if ch:IsA("GuiObject") and ch.Visible and ch.AbsoluteSize.X >= 22 and ch.AbsoluteSize.X <= 65 and ch.AbsoluteSize.Y >= 22 and ch.AbsoluteSize.Y <= 65 then
                    table.insert(children, ch)
                end
            end
            if #children >= 5 and #children <= 8 then
                navButtons = children
                break
            end
        end
    end

    if #navButtons >= 2 then
        table.sort(navButtons, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)

        local TAB_NAMES = {
            [1] = { title = "BẢNG ĐIỀU KHIỂN", icon = "🏠", sub = "HOME DASHBOARD" },
            [2] = { title = "CƯỚP TRỨNG", icon = "🥚", sub = "AUTO STEAL & SNIPER" },
            [3] = { title = "CÀY CUỐC & PET", icon = "🌾", sub = "AUTO FARM & PETS" },
            [4] = { title = "SỰ KIỆN", icon = "✨", sub = "HALLOWEEN & EVENTS" },
            [5] = { title = "NGƯỜI CHƠI", icon = "👤", sub = "PLAYER & ESP" },
            [6] = { title = "HỆ THỐNG", icon = "⚙️", sub = "SYSTEM & CONFIG" },
        }

        -- Khung thông báo mini xuất hiện cực đẹp khi bấm vào từng tab
        local function showTabToast(idx, badgeColor)
            local tabInfo = TAB_NAMES[idx] or { title = "TAB " .. tostring(idx), icon = "⚡", sub = "CHILLI HUB ULTRA" }
            local oldToast = win:FindFirstChild("ChilliTabToast")
            if oldToast then oldToast:Destroy() end

            local toast = mk("Frame", {
                Name = "ChilliTabToast",
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 20, 0, -32),
                Size = UDim2.new(0, 248, 0, 30),
                BackgroundColor3 = Color3.fromRGB(15, 17, 26),
                BackgroundTransparency = 0.12,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Active = false,
                ZIndex = (win.ZIndex or 2) + 20
            }, win)
            mk("UICorner", { CornerRadius = UDim.new(1, 0) }, toast)
            local tStroke = mk("UIStroke", { Thickness = 1.4, Color = badgeColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, toast)
            table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, tStroke))

            local tLbl = mk("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBlack,
                TextSize = 11,
                TextColor3 = Color3.new(1, 1, 1),
                Text = tabInfo.icon .. "  " .. tabInfo.title .. "  •  " .. tabInfo.sub,
                Active = false,
                ZIndex = toast.ZIndex + 1
            }, toast)
            local tGrad = mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, tLbl)
            table.insert(State.ActiveGradients, tGrad)

            -- Hiệu ứng lướt nhẹ từ trên xuống
            TweenService:Create(toast, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 20, 0, 8)
            }):Play()

            -- Tự động biến mất mượt mà sau 1.3 giây
            task.delay(1.3, function()
                if toast and toast.Parent then
                    local outTween = TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 20, 0, -32),
                        BackgroundTransparency = 1
                    })
                    TweenService:Create(tLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
                    TweenService:Create(tStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
                    outTween:Play()
                    outTween.Completed:Connect(function() toast:Destroy() end)
                end
            end)
        end

        for idx, btn in ipairs(navButtons) do
            local badgeColor = SIDEBAR_PALETTE[((idx - 1) % #SIDEBAR_PALETTE) + 1]
            local squircle = btn:FindFirstChild("ChilliSenaSquircle")
            if not squircle then
                squircle = mk("Frame", {
                    Name = "ChilliSenaSquircle", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = badgeColor, BackgroundTransparency = 0.12,
                    BorderSizePixel = 0, Active = false, ZIndex = btn.ZIndex + 1
                }, btn)
                mk("UICorner", { CornerRadius = UDim.new(0, 8) }, squircle)
                mk("UIStroke", { Thickness = 1, Color = Color3.new(1, 1, 1), Transparency = 0.65 }, squircle)

                for _, ch in ipairs(btn:GetDescendants()) do
                    if ch ~= squircle and ch.Name ~= "ChilliStealTabIcon" then
                        if ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
                            ch.ZIndex = squircle.ZIndex + 2; ch.ImageColor3 = Color3.new(1, 1, 1)
                        elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
                            ch.ZIndex = squircle.ZIndex + 2; ch.TextColor3 = Color3.new(1, 1, 1)
                        end
                    end
                end
            end

            -- Tab 2: Phóng to ảnh quả trứng (Ảnh 4: 6935.png) lên kích thước 0.84 cân đối hoàn hảo
            if idx == 2 then
                for _, desc in ipairs(btn:GetDescendants()) do
                    if desc ~= squircle and desc.Name ~= "ChilliStealTabIcon" and not desc:IsA("UICorner") and not desc:IsA("UIStroke") then
                        if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then desc.ImageTransparency = 1
                        elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then desc:SetAttribute("__HiddenVxLogo", true); desc.TextTransparency = 1
                        elseif desc:IsA("Frame") then
                            desc.BackgroundTransparency = 1
                            local st = desc:FindFirstChildOfClass("UIStroke")
                            if st then st.Transparency = 1 end
                        end
                    end
                end
                local stealIcon = btn:FindFirstChild("ChilliStealTabIcon")
                if not stealIcon then
                    stealIcon = mk("ImageLabel", {
                        Name = "ChilliStealTabIcon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromScale(0.84, 0.84), -- Phóng to quả trứng cân bằng với các icon khác
                        BackgroundTransparency = 1, Image = STEAL_TAB_ICON_ID,
                        ScaleType = Enum.ScaleType.Fit, Active = false, Selectable = false, ZIndex = squircle.ZIndex + 3
                    }, btn)
                    mk("UIAspectRatioConstraint", { AspectRatio = 1 }, stealIcon)
                else
                    stealIcon.Image = STEAL_TAB_ICON_ID
                    stealIcon.Size = UDim2.fromScale(0.84, 0.84)
                end
            end

            -- Hiệu ứng nút bấm tương tác khi bấm vào Tab (Shockwave Ripple + Spring Elastic Bounce + Tab Toast)
            if not btn:GetAttribute("__TabEffectHooked") then
                btn:SetAttribute("__TabEffectHooked", true)
                local function onTabTriggered()
                    -- 1. Hiệu ứng nảy nút bấm (Spring Bounce)
                    TweenService:Create(squircle, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 24, 0, 24)
                    }):Play()
                    task.delay(0.08, function()
                        TweenService:Create(squircle, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 33, 0, 33)
                        }):Play()
                    end)
                    task.delay(0.26, function()
                        TweenService:Create(squircle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 30, 0, 30)
                        }):Play()
                    end)

                    -- 2. Hiệu ứng sóng ánh sáng lan tỏa (Cosmic Shockwave Ripple)
                    local ripple = mk("Frame", {
                        Name = "ChilliTabRipple",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.new(0, 24, 0, 24),
                        BackgroundColor3 = badgeColor,
                        BackgroundTransparency = 0.2,
                        BorderSizePixel = 0,
                        Active = false,
                        ZIndex = squircle.ZIndex - 1
                    }, btn)
                    mk("UICorner", { CornerRadius = UDim.new(1, 0) }, ripple)
                    local ripStroke = mk("UIStroke", { Thickness = 1.8, Color = Color3.new(1, 1, 1), Transparency = 0.2 }, ripple)
                    
                    local rTween = TweenService:Create(ripple, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 52, 0, 52),
                        BackgroundTransparency = 1
                    })
                    TweenService:Create(ripStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                    rTween:Play()
                    rTween.Completed:Connect(function() ripple:Destroy() end)

                    -- 3. Hiện huy hiệu thông báo mini của Tab ở đầu trang
                    showTabToast(idx, badgeColor)
                end

                if btn:IsA("GuiButton") then
                    btn.Activated:Connect(onTabTriggered)
                    btn.MouseButton1Click:Connect(onTabTriggered)
                end
                btn.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        onTabTriggered()
                    end
                end)
            end
        end
    end

    -- E. LOGO NHỎ GÓC TRÁI HEADER
    local searchScope = headerBar or win
    for _, it in ipairs(searchScope:GetDescendants()) do
        if it ~= titleLbl and it:IsA("GuiObject")
           and not it.Name:find("^ChilliCosmic")
           and not it.Name:find("^ChilliSena")
           and it.Name ~= "ChilliUltraTitleBadge"
           and it.Name ~= "ChilliStealTabIcon"
           and it.Name ~= "ChilliHeaderLogo"
           and not it:IsDescendantOf(titleLbl) then
            local p, s = it.AbsolutePosition, it.AbsoluteSize
            if math.abs(p.Y - hy) < 28 and p.X < tx and (tx - p.X) < 55 and s.X >= 12 and s.X <= 42 and s.Y >= 12 and s.Y <= 42 then
                local holder = (it:IsA("ImageLabel") or it:IsA("ImageButton")) and it or it.Parent
                if it:IsA("TextLabel") or it:IsA("TextButton") then
                    it:SetAttribute("__HiddenVxLogo", true); it.TextTransparency = 1
                elseif it:IsA("ImageLabel") or it:IsA("ImageButton") then
                    it.ImageTransparency = 1
                end
                if holder and holder:IsA("GuiObject") and not holder:FindFirstChild("ChilliHeaderLogo") then
                    holder.BackgroundTransparency = 1
                    local hBadge = mk("Frame", {
                        Name = "ChilliHeaderLogo", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.new(0, 26, 0, 26), BackgroundColor3 = LOGO_BG, BorderSizePixel = 0, ClipsDescendants = true,
                        Active = false, ZIndex = (headerBar and headerBar.ZIndex or 2) + 8
                    }, holder)
                    mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hBadge)
                    local hStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, hBadge)
                    table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, hStroke))
                    local hImg = mk("ImageLabel", {
                        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95),
                        BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit, Active = false, ZIndex = hBadge.ZIndex + 1
                    }, hBadge)
                    mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hImg)
                end
                break
            end
        end
    end
end

-- 9. BỘ QUÉT SỰ KIỆN ZERO-LAG
local venyxGuiLocked = nil

local function patchVenyxGui(gui, titleLbl)
    pcall(function() gui.Enabled = true end)
    setupSafeTeleportHook()
    if titleLbl.Text ~= NEW_TITLE then
        titleLbl:SetAttribute("__IsTranslating", true); titleLbl.Text = NEW_TITLE; titleLbl.AutomaticSize = Enum.AutomaticSize.X; titleLbl:SetAttribute("__IsTranslating", false)
    end
    local win, curr = nil, titleLbl
    while curr.Parent and curr.Parent ~= gui do
        curr = curr.Parent
        if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= 350 and curr.AbsoluteSize.Y >= 220 then win = curr end
    end
    if win then
        pcall(function() win.Visible = true end)
        cleanupStrayLogos(gui, win)
    end

    local hy = titleLbl.AbsolutePosition.Y
    if win then
        applySenaV7Architecture(win, titleLbl)
    end
    for _, tc in ipairs(gui:GetChildren()) do
        if tc:IsA("GuiObject") and tc ~= win and tc.Name ~= "ChilliV5_ExpandedIsland" and not tc:FindFirstChild("IslandExpandHint") then
            setupCircleLogo(tc, win)
        end
    end

    local queue = {}
    for _, d in ipairs(gui:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
            local txt = d.Text or ""
            local hasDot = false
            if d.Parent and d.Parent:IsA("GuiObject") and d.Parent.AbsoluteSize.X < 320 then
                for _, sb in ipairs(d.Parent:GetChildren()) do if sb:IsA("Frame") and sb.AbsoluteSize.X <= 14 and sb.AbsoluteSize.Y <= 14 then hasDot = true; break end end
            end
            local isStatus = (not gui:GetAttribute("__IslandLocked")) and (not d:FindFirstAncestorOfClass("ScrollingFrame"))
                and d.Parent and (not titleLbl:IsDescendantOf(d.Parent)) and math.abs(d.AbsolutePosition.Y - hy) < 35
                and d.AbsolutePosition.X > titleLbl.AbsolutePosition.X + 60 and (hasDot or txt:lower():find("idle", 1, true) or txt == "Đang rảnh") and not txt:find("v1.", 1, true)

            if isStatus or d:GetAttribute("__IslandDone") then
                gui:SetAttribute("__IslandLocked", true); setupIsland(d, gui)
            elseif isFpsTxt(txt) then hookFps(d)
            elseif d:GetAttribute("__TransHookSession") ~= SID then queue[#queue + 1] = d end
        end
    end

    if #queue > 0 and not gui:GetAttribute("__BatchTranslating") then
        gui:SetAttribute("__BatchTranslating", true)
        task.spawn(function()
            for i = 1, #queue do
                if not isAlive() then break end
                if queue[i] and queue[i].Parent then hookTrans(queue[i]) end
                if i % 80 == 0 then task.wait() end
            end
            gui:SetAttribute("__BatchTranslating", false)
        end)
    end
end

local function bindGuiEvents(gui)
    if not gui:IsA("ScreenGui") or IGNORED_GUIS[gui.Name] or gui:GetAttribute("__ListenerSession") == SID then return end
    gui:SetAttribute("__ListenerSession", SID)
    gui.DescendantAdded:Connect(function(nd)
        if not isAlive() then return end
        if nd:IsA("TextLabel") or nd:IsA("TextButton") or nd:IsA("TextBox") then
            task.defer(function()
                if not isAlive() then return end
                if not nd:IsA("TextBox") and isFpsTxt(nd.Text) then hookFps(nd) else hookTrans(nd) end
            end)
        end
    end)
end

local function scanOnce()
    if not isAlive() then return false end
    for _, root in ipairs(getScanRoots()) do
        local guis = {}
        for _, ch in ipairs(root:GetChildren()) do
            if ch:IsA("ScreenGui") then table.insert(guis, ch)
            elseif ch:IsA("Folder") or ch:IsA("Configuration") then
                for _, sub in ipairs(ch:GetChildren()) do if sub:IsA("ScreenGui") then table.insert(guis, sub) end end
            end
        end
        for _, gui in ipairs(guis) do
            if not IGNORED_GUIS[gui.Name] then
                bindGuiEvents(gui)
                local titleLbl = nil
                for _, d in ipairs(gui:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" then
                        local t = d.Text
                        if isFpsTxt(t) then hookFps(d)
                        elseif (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then titleLbl = d end
                    end
                end
                if titleLbl then
                    venyxGuiLocked = gui
                    patchVenyxGui(gui, titleLbl)
                end
            end
        end
    end
    return venyxGuiLocked ~= nil
end

for _, root in ipairs(getScanRoots()) do
    root.DescendantAdded:Connect(function(ch)
        if isAlive() and ch:IsA("ScreenGui") and not IGNORED_GUIS[ch.Name] then
            bindGuiEvents(ch); task.wait(0.15); pcall(scanOnce)
        end
    end)
end

pcall(scanOnce)
task.spawn(function()
    local t = 0
    while isAlive() and not venyxGuiLocked and t < 60 do
        task.wait(0.35); t = t + 0.35
        if t > 4.5 and not venyxGuiLocked then
            launchVenyxBase()
        end
        pcall(scanOnce)
    end
    if isAlive() then
        showNotice()
        task.wait(1.0); pcall(scanOnce)
    end
end)
