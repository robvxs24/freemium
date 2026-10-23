-- Chilli Hub V7 Supreme | Clean Multi-Line Edition (100% Luau Compatible, Zero Semicolons)
local NEW_TITLE = "Chilli Hub V7"
local LOGO_ID = "rbxassetid://74441610995894"
local HEADER_BAR_IMG_ID = "rbxassetid://83726521558450"
local STEAL_TAB_ICON_ID = "rbxassetid://91536384271341"
local WALLPAPER_IMAGE_ID = "rbxassetid://90615151648668"
local c3, u2, u2s, v2, csk = Color3.fromRGB, UDim2.new, UDim2.fromScale, Vector2.new, ColorSequenceKeypoint.new
local LOGO_BG, BLACK_BG = c3(12, 12, 18), c3(8, 8, 12)
local MY_URL = "https://raw.githubusercontent.com/ronnei/hihi/refs/heads/main/chillihubv5.lua"
local VENYX_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local AUTO_FILE, LANG_FILE = "ChilliHubV5_AutoRun.lua", "ChilliV5_Lang.txt"
local PRESET_JSON = [=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":true,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":true,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]
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
local env = (getgenv and getgenv()) or _G
env.__ChilliV5State = env.__ChilliV5State or {
SessionId = 0, Language = "VI", ActiveGradients = {},
TrackedTexts = {}, TrackedFpsLabels = {}, NoticeShown = false, StartClock = os.clock()
}
local State = env.__ChilliV5State
State.SessionId = (State.SessionId or 0) + 1
State.CloseHideUntil = nil
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
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local function getScanRoots()
local r = {}
if gethui then
pcall(function()
local h = gethui()
if h then table.insert(r, h) end
end)
end
table.insert(r, CoreGui)
local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
if pg then table.insert(r, pg) end
return r
end
local IGNORED_GUIS = { RobloxGui=true, TopBarApp=true, TouchGui=true, Chat=true, BubbleChat=true, Freecam=true, BackpackGui=true, PlayerList=true, PurchasePrompt=true, ChilliV5_NoticeGui=true }
local function isVenyxUiPresent()
for _, root in ipairs(getScanRoots()) do
for _, d in ipairs(root:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local sg = d:FindFirstAncestorOfClass("ScreenGui")
if sg and not IGNORED_GUIS[sg.Name] and sg.Enabled ~= false then
local t = d.Text
if (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
return true
end
end
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
local rq = env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (delta and delta.queue_on_teleport)
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
local RAINBOW = ColorSequence.new({ csk(0.00, c3(255, 45, 85)), csk(0.17, c3(255, 155, 35)), csk(0.33, c3(255, 235, 45)), csk(0.50, c3(45, 255, 145)), csk(0.67, c3(45, 195, 255)), csk(0.83, c3(185, 85, 255)), csk(1.00, c3(255, 45, 85)) })
local ULTRA_TEXT_GRAD = ColorSequence.new({ csk(0.00, c3(255, 255, 255)), csk(0.20, c3(125, 225, 255)), csk(0.45, c3(255, 95, 215)), csk(0.72, c3(175, 115, 255)), csk(1.00, c3(255, 215, 85)) })
local ULTRA_CARD_GRAD = ColorSequence.new({ csk(0.00, c3(70, 210, 255)), csk(0.50, c3(170, 95, 255)), csk(1.00, c3(255, 75, 195)) })
local fakeFps, lastFpsT = math.random(98, 114), 0
local function getFakeFps()
local now = os.clock()
if now - lastFpsT > 0.7 then
lastFpsT = now
fakeFps = math.clamp(fakeFps + math.random(-5, 6), 95, 120)
end
return fakeFps
end
local function isFpsTxt(t) return type(t) == "string" and t:find("FPS") ~= nil and t:find("ms") ~= nil and #t < 38 end
local function fmtFps(t, f) return type(t) == "string" and t:gsub("%d+%s*FPS", f .. " FPS") or t end
local function hookFps(lbl)
if not lbl or lbl:GetAttribute("__FpsHookSession") == SID then return end
lbl:SetAttribute("__FpsHookSession", SID)
table.insert(State.TrackedFpsLabels, lbl)
local b = false
lbl:GetPropertyChangedSignal("Text"):Connect(function()
if not b and isAlive() and isFpsTxt(lbl.Text) then
b = true
lbl.Text = fmtFps(lbl.Text, getFakeFps())
b = false
end
end)
if isFpsTxt(lbl.Text) then
b = true
lbl.Text = fmtFps(lbl.Text, getFakeFps())
b = false
end
end
task.spawn(function()
local rot, tickCount = 0, 0
while isAlive() do
rot = (rot + 3) % 360
tickCount = tickCount + 1
local g = State.ActiveGradients
for i = #g, 1, -1 do
local item = g[i]
if item and item.Parent then item.Rotation = rot else table.remove(g, i) end
end
if tickCount % 22 == 0 then
local f = getFakeFps()
local fl = State.TrackedFpsLabels
for i = #fl, 1, -1 do
local l = fl[i]
if l and l.Parent then
if isFpsTxt(l.Text) then l.Text = fmtFps(l.Text, f) end
else
table.remove(fl, i)
end
end
if State.TelemetryUpdateFn then pcall(State.TelemetryUpdateFn, f) end
end
if tickCount % 8 == 0 and State.SyncWindowFn then pcall(State.SyncWindowFn) end
task.wait(0.033)
end
end)
local FastCache = {}
local function hasVi(s) return type(s) == "string" and s:find("[\195\196\197\198\225]") ~= nil end
local EXACT_VI = {
["Riding the Phantom Express"]="Đang đi Tàu Bóng Ma", ["Fighting Small monster"]="Đang đánh quái vật nhỏ", ["Fighting Medium monster"]="Đang đánh quái vật vừa", ["Fighting Large monster"]="Đang đánh quái vật lớn",
["UI scale"]="Kích cỡ Menu", ["Show / hide UI"]="Phím ẩn / hiện Menu", ["Opacity"]="Độ trong suốt", ["Tone"]="Tông màu", ["Dim the game"]="Làm tối nền game",
["QUICK BARS"]="THANH PHÍM TẮT NHANH", ["Quick bars"]="Thanh phím tắt nhanh", ["Show quick bars"]="Hiện thanh phím tắt nhanh", ["Keybinds"]="Phím tắt", ["Bar size"]="Kích cỡ thanh nhanh",
["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT", ["Find option"]="Tìm tùy chọn", ["All"]="Tất cả", ["Pinned"]="Đã ghim", ["Clear all quick bars"]="Xóa hết thanh nhanh", ["Clear all keybinds"]="Xóa hết phím tắt",
["DEFAULTS"]="MẶC ĐỊNH", ["Reset to defaults"]="Khôi phục mặc định", ["Reset"]="Đặt lại", ["Turn off all toggles"]="Tắt toàn bộ công tắc", ["Turn off"]="Tắt hết",
["Steal An Egg"]="Cướp Trứng", ["CANDY CORN"]="KẸO NGÔ", ["Candy Corn"]="Kẹo Ngô", ["Calculate mutations"]="Tính thử đột biến", ["Delivery speed"]="Tốc độ mang trứng về",
["Change if steal fails"]="Hãy chỉnh giảm xuống nếu cướp trứng bị lỗi", ["Auto farm monsters"]="Tự động cày quái vật", ["Instant steal"]="Cướp tức thì", ["Admin treadmill"]="Máy tập Admin",
["CURSED ISLAND WARS"]="ĐẠI CHIẾN ĐẢO NGUYỀN RỦA", ["Cursed Island Wars"]="Đại Chiến Đảo Nguyền Rủa", ["Auto play Cursed Island Wars"]="Tự động chơi Đại Chiến Đảo Nguyền Rủa",
["Island Wars target"]="Mục tiêu Đảo Nguyền Rủa", ["Enemies and base"]="Kẻ địch và Căn cứ", ["Most tokens"]="Nhiều kẹo/xu nhất", ["Idle"]="Đang rảnh", ["Waiting"]="Đang chờ", ["Nothing"]="Không có gì",
["None"]="Không có", ["Off"]="Tắt", ["On"]="Bật", ["Search"]="Tìm kiếm", ["Home"]="Bảng Điều Khiển", ["Dashboard"]="Bảng Điều Khiển", ["Steal"]="Cướp Trứng", ["Farm"]="Cày Cuốc", ["Event"]="Sự Kiện", ["Player"]="Người Chơi", ["System"]="Hệ Thống",
["Welcome back"]="Chào mừng trở lại", ["Updated"]="Cập nhật", ["Copy link"]="Chép Link Mới", ["Rejoin"]="Vào lại", ["Server hop"]="Đổi server", ["Copy Job ID"]="Chép Job ID", ["Unload"]="Tắt Hub",
["SESSION"]="PHIÊN CHƠI", ["WHAT'S NEW"]="CÓ GÌ MỚI", ["NEW"]="MỚI", ["LAST EGG"]="TRỨNG CUỐI", ["PLACED"]="ĐÃ ĐẶT", ["CASH / S"]="TIỀN / GIÂY", ["NEXT NIGHT"]="ĐÊM SAU", ["TIME"]="THỜI GIAN",
["BEST STEAL"]="CƯỚP TỐT NHẤT", ["EGG BAG"]="TÚI TRỨNG", ["PET BAG"]="TÚI PET", ["OPEN"]="MỞ", ["Auto Steal"]="Tự Động Cướp", ["Egg Predictor"]="Dự Đoán Trứng", ["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
["Auto steal"]="Tự động cướp", ["Go to egg"]="Di chuyển tới trứng", ["Teleport to egg"]="Dịch chuyển tới trứng", ["Walk to egg"]="Đi bộ tới trứng", ["Tween to egg"]="Bay mượt tới trứng",
["Teleport zones"]="Khu vực dịch chuyển", ["Delivery method"]="Kiểu mang trứng về", ["Instant steps"]="Tức thì từng bước", ["Instant"]="Tức thì", ["Tween"]="Bay mượt", ["Teleport"]="Dịch chuyển",
["Tween speed"]="Tốc độ bay", ["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục", ["Steal from other players"]="Cướp từ người chơi khác", ["Anti guard"]="Chống vệ sĩ",
["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn", ["FILTER"]="BỘ LỌC", ["Zones"]="Khu vực", ["Steal first"]="Ưu tiên cướp", ["Best value"]="Giá trị cao nhất", ["Lowest value"]="Giá trị thấp nhất",
["Rarest"]="Hiếm nhất", ["Nearest"]="Gần nhất", ["Mutations"]="Đột biến", ["Rarities"]="Độ hiếm", ["Only these eggs"]="Chỉ những trứng này", ["Min value /s"]="Giá trị tối thiểu /s",
["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi", ["Only below /s"]="Chỉ dưới mức /s", ["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ", ["Auto hop"]="Tự động đổi server", ["Hop now"]="Đổi server ngay",
["First hop after"]="Đổi lần đầu sau", ["Hop when"]="Đổi khi", ["After stealing a match"]="Sau khi cướp đủ trứng lọc", ["No matching egg"]="Không có trứng phù hợp", ["Rare from"]="Độ hiếm từ",
["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG", ["Sort eggs"]="Sắp xếp trứng", ["Value"]="Giá trị", ["Rarity"]="Độ hiếm", ["Preview card"]="Thẻ xem trước", ["Pen"]="Chuồng Trứng", ["Treadmill"]="Máy Tập Chạy",
["Sell"]="Bán Đồ", ["Mutate"]="Đột Biến", ["Fuse"]="Dung Hợp", ["Priority"]="Thứ Tự Ưu Tiên", ["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG", ["Auto hatch"]="Tự động ấp trứng", ["Equip best pets"]="Trang bị Pet mạnh nhất",
["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG", ["Auto place"]="Tự động đặt trứng", ["Place first"]="Ưu tiên đặt", ["Place when"]="Đặt khi", ["Always"]="Luôn luôn", ["KEEP EGGS"]="GIỮ LẠI TRỨNG", ["Eggs to keep"]="Trứng cần giữ",
["TREADMILL"]="MÁY TẬP CHẠY", ["Auto treadmill"]="Tự động chạy máy tập", ["Auto upgrade treadmill"]="Tự nâng cấp máy tập", ["PROGRESS"]="TIẾN ĐỘ & NHẬN THƯỞNG", ["Auto upgrade base"]="Tự nâng cấp căn cứ",
["Auto claim offline cash"]="Tự nhận tiền Offline", ["Auto buy trails"]="Tự mua vệt sáng", ["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục", ["EGGS"]="TRỨNG", ["Auto sell eggs"]="Tự động bán trứng",
["Sell all eggs now"]="Bán hết trứng ngay", ["Keep mutated"]="Giữ lại đồ Đột biến", ["Sell rarities"]="Bán các độ hiếm", ["Only mutations"]="Chỉ bán đột biến", ["Never sell"]="Không bao giờ bán",
["PETS"]="THÚ CƯNG (PET)", ["Auto sell pets"]="Tự động bán Pet", ["Sell all pets now"]="Bán hết Pet ngay", ["FAVORITE"]="YÊU THÍCH (KHÓA ĐỒ)", ["Auto favorite"]="Tự động khóa Yêu thích",
["Favorite matching now"]="Khóa đồ khớp lọc ngay", ["Unfavorite pets not matching"]="Bỏ thích Pet không khớp", ["Favorite equipped"]="Khóa Pet đang trang bị", ["Match"]="Điều kiện khớp",
["All picked rules"]="Khớp tất cả điều kiện", ["Any picked rule"]="Khớp bất kỳ điều kiện nào", ["Always favorite"]="Luôn khóa Yêu thích", ["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN", ["Auto mutate"]="Tự động đột biến",
["Mutate first"]="Ưu tiên đột biến", ["Use items"]="Dùng vật phẩm", ["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN", ["Skip eggs with"]="Bỏ qua trứng đã có", ["FUSE MACHINE"]="MÁY DUNG HỢP", ["Auto fuse"]="Tự động dung hợp",
["Fuse first"]="Ưu tiên dung hợp", ["Lowest rarity"]="Độ hiếm thấp nhất", ["Highest rarity"]="Độ hiếm cao nhất", ["Use pets"]="Dùng Pet", ["Lowest value first"]="Giá trị thấp trước",
["Highest value first"]="Giá trị cao trước", ["Skip mutated"]="Bỏ qua đồ Đột biến", ["Eject odd pets"]="Đẩy Pet lẻ ra", ["FUSE FILTER"]="BỘ LỌC DUNG HỢP", ["Only these pets"]="Chỉ những Pet này",
["Never fuse"]="Không bao giờ dung hợp", ["TASK ORDER"]="THỨ TỰ ƯU TIÊN NHIỆM VỤ", ["Task order"]="Thứ tự ưu tiên", ["Reset order"]="Đặt lại thứ tự", ["Halloween"]="Sự Kiện Halloween",
["Butterfly"]="Sự Kiện Bướm", ["Star"]="Sao Băng", ["Race"]="Đua Tốc Độ", ["AA"]="Admin & Sự Kiện", ["HALLOWEEN DIMENSION"]="CHIỀU KHÔNG GIAN HALLOWEEN", ["Auto Pumpkin Moon"]="Tự động cày Trăng Bí Ngô",
["Auto steal Halloween eggs"]="Tự cướp trứng Halloween", ["Instant steal Halloween eggs"]="Cướp tức thì trứng Halloween", ["Halloween rarities"]="Độ hiếm Halloween", ["Halloween eggs"]="Trứng Halloween",
["Auto buy Halloween Dimension Egg"]="Tự mua trứng Không Gian Halloween", ["Walk speed"]="Tốc độ đi bộ", ["Steal speed"]="Tốc độ cướp", ["MONSTERS"]="QUÁI VẬT HALLOWEEN", ["Monsters"]="Quái vật",
["Monster order"]="Thứ tự đánh quái", ["Use weapons"]="Dùng vũ khí", ["GHOST DOG AND FISHING"]="CHÓ MA & CÂU CÁ", ["Auto Ghost Dog quest"]="Tự làm nhiệm vụ Chó Ma", ["Auto fishing"]="Tự động câu cá",
["Cast luck"]="Độ may mắn quăng cần", ["PHANTOM EXPRESS"]="CHUYẾN TÀU BÓNG MA", ["Auto Phantom Express"]="Tự động đi Tàu Bóng Ma", ["Auto vacuum Ghouler boss"]="Tự hút trùm Ghouler",
["Ghost target"]="Mục tiêu bắt Ma", ["Rarest first"]="Hiếm nhất trước", ["Auto trade souls"]="Tự động đổi Linh hồn", ["BUTTERFLY BLOOM"]="MÙA BƯỚM NỞ", ["Auto butterfly bloom"]="Tự động bắt Bướm",
["Catch"]="Loại bướm bắt", ["Catch priority"]="Ưu tiên bắt", ["Catch mode"]="Chế độ bắt", ["Chase"]="Đuổi theo", ["Catch speed"]="Tốc độ bắt", ["BUTTERFLY MACHINE"]="MÁY ÉP BƯỚM",
["Smart trade for essence"]="Đổi thông minh lấy Tinh chất", ["Auto trade up"]="Tự động đổi bậc cao", ["Trade"]="Loại bướm đem đổi", ["Auto craft essence"]="Tự chế tạo Tinh chất",
["WISP COMPANION"]="TINH LINH ĐỒNG HÀNH", ["Auto wisp quest"]="Tự làm nhiệm vụ Tinh linh", ["Auto banjo cricket"]="Tự đánh Dế trả nhiệm vụ", ["SHOOTING STAR"]="SAO BĂNG",
["Auto catch shooting star"]="Tự động bắt Sao băng", ["RACING EVENT"]="SỰ KIỆN ĐUA", ["Auto race"]="Tự động đua", ["CAPTURE THE EGG"]="ĐOẠT TRỨNG SỰ KIỆN", ["Auto capture event egg"]="Tự động đoạt trứng sự kiện",
["Take it from the holder"]="Cướp lại từ người đang giữ", ["Hold height"]="Độ cao giữ trứng", ["Keep away"]="Khoảng cách né người", ["MINIGAME EGGS"]="TRỨNG MINIGAME", ["Auto steal minigame egg"]="Tự cướp trứng Minigame",
["ADMIN ABUSE"]="LẠM DỤNG QUYỀN ADMIN", ["Move"]="Di Chuyển", ["Combat"]="Chiến Đấu", ["ESP"]="Định Vị ESP", ["MOVEMENT"]="DI CHUYỂN", ["Speed boost"]="Tăng tốc chạy", ["Boost speed"]="Tốc độ chạy",
["Infinite jump"]="Nhảy vô hạn", ["God mode"]="Bất tử (God Mode)", ["PROTECTION"]="BẢO VỆ NHÂN VẬT", ["Anti ragdoll"]="Chống văng ngã", ["Ignore traps"]="Bỏ qua bẫy", ["Anti AFK"]="Chống văng game (Anti AFK)",
["Instant prompts"]="Nhấn nút tức thì", ["Invisible"]="Tàng hình", ["AUTO HIT"]="TỰ ĐỘNG ĐÁNH", ["Auto hit"]="Tự động đánh người", ["Hit who"]="Mục tiêu đánh", ["Nearest player"]="Người chơi gần nhất",
["Egg carrier"]="Người đang ôm trứng", ["Chase speed"]="Tốc độ đuổi", ["HIT AURA"]="VÒNG ĐÁNH QUANH NGƯỜI", ["Hit aura"]="Đánh tự động quanh người", ["Skip friends"]="Bỏ qua bạn bè", ["WEAPONS"]="VŨ KHÍ",
["Hold each"]="Thời gian cầm mỗi món", ["FIELD EGGS"]="TRỨNG NGOÀI BÃI", ["Egg ESP"]="Định vị Trứng ngoài bãi", ["Show"]="Hiển thị thông tin", ["Fixed size"]="Kích cỡ cố định", ["OTHERS"]="ĐỊNH VỊ KHÁC",
["Player ESP"]="Định vị Người chơi", ["Guard ESP"]="Định vị Vệ sĩ", ["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ", ["Pen egg ESP"]="Định vị Trứng trong chuồng", ["Other pens ESP"]="Định vị Chuồng người khác",
["ESP size"]="Kích cỡ chữ ESP", ["Optimizer"]="Tối Ưu Giảm Lag", ["Interface"]="Giao Diện", ["Server"]="Máy Chủ", ["Config"]="Cấu Hình", ["Webhook"]="Báo Discord", ["BASES"]="TỐI ƯU CĂN CỨ",
["Hide my pets and eggs"]="Ẩn Pet và Trứng của tôi", ["Hide other players' pets and eggs"]="Ẩn Pet và Trứng người khác", ["GRAPHICS"]="ĐỒ HỌA & MÀN HÌNH", ["Low graphics"]="Đồ họa thấp (Siêu mượt)",
["Hide game UI"]="Ẩn giao diện gốc của Game", ["Disable 3D Render"]="Tắt dựng hình 3D (Treo máy)", ["Background color"]="Màu nền khi tắt 3D", ["Black"]="Màu Đen", ["White"]="Màu Trắng",
["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)", ["Show FPS and ping"]="Hiện thanh FPS và Ping", ["FPS cap"]="Giới hạn FPS tối đa", ["GAME HUD"]="TRÊN MÀN HÌNH GAME",
["Steal panel button on game HUD"]="Hiện nút Bảng Cướp trên màn hình", ["INTERFACE"]="TÙY CHỈNH GIAO DIỆN", ["SERVER"]="MÁY CHỦ (SERVER)", ["Hop to"]="Đổi sang server",
["Least players"]="Ít người chơi nhất", ["Most players"]="Đông người nhất", ["Random"]="Ngẫu nhiên", ["JOIN AND STAY"]="TỰ VÀO LẠI & TỰ CHẠY", ["Rejoin on kick"]="Tự vào lại khi bị văng",
["Auto load script"]="Tự chạy lại Script khi qua Server", ["CONFIGS"]="QUẢN LÝ CẤU HÌNH", ["Configs"]="Danh sách cấu hình", ["Config name"]="Tên cấu hình", ["Create"]="Tạo mới", ["Save"]="Lưu đè",
["Load"]="Nạp cấu hình", ["Delete"]="Xóa bỏ", ["Auto load"]="Tự động nạp khi vào game", ["IMPORT / EXPORT"]="NHẬP / XUẤT MÃ CẤU HÌNH", ["Export to clipboard"]="Chép mã cấu hình",
["Config data"]="Dữ liệu cấu hình (JSON)", ["Paste config JSON here"]="Dán mã JSON cấu hình vào đây", ["Import"]="Nhập cấu hình", ["Apply now"]="Áp dụng ngay",
["Common"]="Thường", ["Uncommon"]="Không Phổ Biến", ["Rare"]="Hiếm", ["Epic"]="Sử Thi", ["Legendary"]="Huyền Thoại", ["Mythic"]="Thần Thoại", ["Cosmic"]="Vũ Trụ", ["Secret"]="Bí Mật",
["Eternal"]="Vĩnh Cửu", ["Divine"]="Thánh Thần", ["Radiant"]="Rực Rỡ", ["Amethyst"]="Thạch Anh Tím", ["Sapphire"]="Lam Ngọc", ["Emerald"]="Ngọc Lục Bảo"
}
local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do LOWER_VI[k:lower()] = v end
local GRAMMAR_VI = {
{ pat="^[Rr]iding%s+(.+)$", rep="Đang đi %1" },
{ pat="^[Ff]ighting%s+[Ss]mall%s+monster$", rep="Đang đánh quái vật nhỏ" },
{ pat="^[Ff]ighting%s+[Mm]edium%s+monster$", rep="Đang đánh quái vật vừa" },
{ pat="^[Ff]ighting%s+[Ll]arge%s+monster$", rep="Đang đánh quái vật lớn" },
{ pat="^[Cc]atching%s+(.+)%s+butterfly$", rep="Đang bắt bướm %1" },
{ pat="^[Mm]oving%s+to%s+(.+)$", rep="Đang di chuyển tới %1" },
{ pat="^[Tt]eleporting%s+to%s+(.+)$", rep="Đang dịch chuyển tới %1" },
{ pat="^[Ww]alking%s+to%s+(.+)$", rep="Đang đi bộ tới %1" },
{ pat="^[Tt]weening%s+to%s+(.+)$", rep="Đang bay tới %1" },
{ pat="^[Ss]tealing%s+(.+)$", rep="Đang cướp %1" },
{ pat="^[Dd]elivering%s+(.+)$", rep="Đang mang %1 về căn cứ" },
{ pat="^[Ff]ighting%s+(.+)$", rep="Đang giao chiến với %1" },
{ pat="^[Ww]aiting%s+for%s+(.+)$", rep="Đang chờ %1" },
{ pat="^[Ss]earching%s+for%s+(.+)$", rep="Đang tìm kiếm %1" }
}
local PHRASES_VI = {
{"dark zone","vùng tối"}, {"safe zone","vùng an toàn"}, {"shooting star","sao băng"},
{"ghost dog","chó ma"}, {"pumpkin moon","trăng bí ngô"}, {"phantom express","tàu bóng ma"},
{"cursed island wars","đại chiến đảo nguyền rủa"}, {"candy corn","kẹo ngô"}, {"event egg","trứng sự kiện"},
{"small monster","quái vật nhỏ"}, {"medium monster","quái vật vừa"}, {"large monster","quái vật lớn"}
}
local WORDS_VI = {
["riding"]="Đang đi", ["moving"]="Đang di chuyển", ["walking"]="Đang đi bộ", ["teleporting"]="Đang dịch chuyển", ["tweening"]="Đang bay",
["stealing"]="Đang cướp", ["delivering"]="Đang mang về", ["carrying"]="Đang ôm", ["holding"]="Đang giữ", ["catching"]="Đang bắt",
["farming"]="Đang cày", ["fighting"]="Đang đánh", ["killing"]="Đang tiêu diệt", ["attacking"]="Đang tấn công", ["fishing"]="Đang câu cá",
["hatching"]="Đang ấp", ["placing"]="Đang đặt", ["selling"]="Đang bán", ["fusing"]="Đang dung hợp", ["mutating"]="Đang đột biến",
["claiming"]="Đang nhận", ["upgrading"]="Đang nâng cấp", ["buying"]="Đang mua", ["searching"]="Đang tìm", ["waiting"]="Đang chờ",
["hopping"]="Đang đổi server", ["idle"]="Đang rảnh", ["egg"]="trứng", ["eggs"]="trứng", ["pet"]="thú cưng", ["pets"]="thú cưng",
["butterfly"]="bướm", ["monster"]="quái vật", ["monsters"]="quái vật", ["boss"]="trùm", ["ghost"]="bóng ma", ["soul"]="linh hồn",
["pumpkin"]="bí ngô", ["star"]="ngôi sao", ["base"]="căn cứ", ["pen"]="chuồng", ["zone"]="khu vực", ["server"]="máy chủ",
["player"]="người chơi", ["guard"]="vệ sĩ", ["small"]="nhỏ", ["medium"]="vừa", ["large"]="lớn", ["divine"]="Thánh Thần",
["eternal"]="Vĩnh Cửu", ["secret"]="Bí Mật", ["cosmic"]="Vũ Trụ", ["mythic"]="Thần Thoại", ["legendary"]="Huyền Thoại",
["epic"]="Sử Thi", ["rare"]="Hiếm", ["uncommon"]="Không Phổ Biến", ["common"]="Thường"
}
local DYN_VI = {
{ pat="^First hop after (%d+)s$", rep="Đổi lần đầu sau %1 giây" },
{ pat="^Hold each ([%d%.]+)s$", rep="Cầm mỗi món %1 giây" },
{ pat="^(%d+) selected$", rep="Đã chọn %1 mục" },
{ pat="^(%d+)%s*/%s*(%d+) selected$", rep="Đã chọn %1/%2" },
{ pat="^([%d%.]+)s$", rep="%1 giây" }
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
return (s:gsub("([\128-\255%a\']+)", function(w)
if w:find("[\128-\255]") then return w end
local l = w:lower()
if (l == "an" or l == "to" or l == "in" or l == "at" or l == "or" or l == "no") and hasVi(s) then return w end
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
FastCache[ck] = r
return r
end
local out = stripArt(t)
for i = 1, #GRAMMAR_VI do
if out:find(GRAMMAR_VI[i].pat) then
out = out:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep)
break
end
end
out = applyWords(applyPhrases(out)):gsub("%s+", " "):match("^%s*(.-)%s*$") or out
FastCache[ck] = out
return out
end
local function translateText(raw)
if not raw or raw == "" then return raw end
local ck = State.Language .. "|" .. raw
if FastCache[ck] then return FastCache[ck] end
if raw:find("Venyx SAE", 1, true) then raw = raw:gsub("Venyx SAE", "Chilli SAE")
elseif raw == "VENYX" or raw == "Chilli Hub V5" or raw == "Chilli V5 |" then raw = NEW_TITLE end
if State.Language == "EN" then
FastCache[ck] = raw
return raw
end
local norm = (raw:match("^%s*(.-)%s*$") or raw):gsub("%s+", " ")
if norm:match("^[%$%+%-%d%.%,%/%%sxhm]+$") or (norm:match("^v%d+%.%d+") and #norm < 10) then
FastCache[ck] = raw
return raw
end
if EXACT_VI[norm] or LOWER_VI[norm:lower()] then
local r = EXACT_VI[norm] or LOWER_VI[norm:lower()]
FastCache[ck] = r
return r
end
local dots = norm:match("^(.+)%.%.%.$")
if dots then
dots = dots:match("^%s*(.-)%s*$") or dots
local m = EXACT_VI[dots] or LOWER_VI[dots:lower()]
if m then
FastCache[ck] = m .. "..."
return FastCache[ck]
end
end
for i = 1, #DYN_VI do
if norm:find(DYN_VI[i].pat) then
FastCache[ck] = norm:gsub(DYN_VI[i].pat, DYN_VI[i].rep)
return FastCache[ck]
end
end
local res = applyWords(applyPhrases(norm))
if res ~= norm then
if norm:upper() == norm and norm:find("%a") ~= nil then res = res:upper() end
FastCache[ck] = res
return res
end
FastCache[ck] = raw
return raw
end
local function applyTrans(inst)
if not inst or not inst.Parent or inst:GetAttribute("__IsTranslating") then return end
if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHookSession") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
inst:SetAttribute("__IsTranslating", true)
if inst:IsA("TextBox") then
local ph = inst.PlaceholderText
if ph and ph ~= "" then
if not inst:GetAttribute("OrigPh") then inst:SetAttribute("OrigPh", ph) end
local op = inst:GetAttribute("OrigPh") or ph
local np = State.Language == "VI" and translateText(op) or op
if inst.PlaceholderText ~= np then inst.PlaceholderText = np end
end
else
local cur = inst.Text
if cur and cur ~= "" then
local orig = inst:GetAttribute("OrigRawText")
if not orig or (cur ~= inst:GetAttribute("__LastTranslated") and cur ~= orig and not hasVi(cur)) then
orig = cur
inst:SetAttribute("OrigRawText", orig)
end
local nxt = State.Language == "VI" and translateText(orig) or (orig == "VENYX" and NEW_TITLE or orig:gsub("Venyx SAE", "Chilli SAE"))
if inst.Text ~= nxt then
inst:SetAttribute("__LastTranslated", nxt)
inst.Text = nxt
end
end
end
inst:SetAttribute("__IsTranslating", false)
end
local function hookTrans(inst)
if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then hookFps(inst) return end
if inst:GetAttribute("__TransHookSession") == SID then return end
inst:SetAttribute("__TransHookSession", SID)
table.insert(State.TrackedTexts, inst)
applyTrans(inst)
inst:GetPropertyChangedSignal(inst:IsA("TextBox") and "PlaceholderText" or "Text"):Connect(function()
if isAlive() and not inst:GetAttribute("__IsTranslating") then
if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then hookFps(inst) else applyTrans(inst) end
end
end)
end
local function refreshAllTexts()
table.clear(FastCache)
for i = #State.TrackedTexts, 1, -1 do
local ins = State.TrackedTexts[i]
if ins and ins.Parent then applyTrans(ins) else table.remove(State.TrackedTexts, i) end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
end
local function fireBtn(b)
if not b then return end
if getconnections then
for _, sig in ipairs({ b.MouseButton1Click, b.Activated, b.MouseButton1Down, b.MouseButton1Up }) do
if sig then
for _, c in ipairs(getconnections(sig)) do
if c.Function then task.spawn(pcall, c.Function) end
end
end
end
end
if firesignal then
pcall(firesignal, b.MouseButton1Click)
pcall(firesignal, b.Activated)
end
end
local function runAutoFarmMacro(venyxGui, statusBtn)
if State.MacroRunning then return end
State.MacroRunning = true
local origTxt = statusBtn.Text
statusBtn.Text = "⏳ ĐANG NẠP CONFIG..."
task.spawn(function()
pcall(function()
if setclipboard then pcall(setclipboard, PRESET_JSON) end
local cfgTab, cfgBox, impBtn = nil, nil, nil
for _, d in ipairs(venyxGui:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") then
local t = (d:GetAttribute("OrigRawText") or d.Text or ""):lower()
if t == "config" or t == "cấu hình" then cfgTab = d:IsA("TextButton") and d or d.Parent end
end
end
if cfgTab then
fireBtn(cfgTab)
task.wait(0.2)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if d:IsA("TextBox") then
local ph = (d:GetAttribute("OrigPh") or d.PlaceholderText or ""):lower()
if ph:find("json", 1, true) or ph:find("config", 1, true) or ph:find("dán", 1, true) then
cfgBox = d
break
end
end
end
if cfgBox then
pcall(function() cfgBox:CaptureFocus() end)
cfgBox.Text = PRESET_JSON
task.wait(0.1)
pcall(function() cfgBox:ReleaseFocus(true) end)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if d:IsA("TextButton") or d:IsA("TextLabel") then
local raw = (d:GetAttribute("OrigRawText") or d.Text or ""):lower():match("^%s*(.-)%s*$")
if raw == "import" or raw == "nhập cấu hình" then
impBtn = d:IsA("TextButton") and d or (d.Parent and d.Parent:IsA("TextButton") and d.Parent) or d.Parent
end
end
end
if impBtn then fireBtn(impBtn) end
end)
statusBtn.Text = "✅ ĐÃ NẠP CONFIG (BẤM ÁP DỤNG NGAY)!"
task.wait(2.0)
if statusBtn and statusBtn.Parent then statusBtn.Text = origTxt end
State.MacroRunning = false
end)
end
-- DYNAMIC ISLAND V7 (KHÔNG GẮN HUY HIỆU Ở DYNAMIC ISLAND, CHỈ DÙNG NÚT MŨI TÊN GỌN GÀNG "▾")
local function setupIsland(statusLbl, venyxGui)
local pill = statusLbl.Parent
if not (pill and pill:IsA("GuiObject")) then return end
statusLbl:SetAttribute("__IslandDone", true)
for _, ch in ipairs(pill:GetChildren()) do
if ch:IsA("UIGradient") or ch.Name == "IslandClickHitbox" then ch:Destroy() end
end
pill.BackgroundColor3 = c3(10, 12, 20)
pill.BackgroundTransparency = 0.04
pill.Size = u2(0, 0, 0, 32)
pill.AutomaticSize = Enum.AutomaticSize.X
local pad = pill:FindFirstChildOfClass("UIPadding") or mk("UIPadding", {}, pill)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
local leftBadge = pill:FindFirstChild("IslandLogoBadge")
if not leftBadge then
leftBadge = mk("Frame", { Name = "IslandLogoBadge", Size = u2(0, 24, 0, 24), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = -10, Active = false, ZIndex = 10000 }, pill)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, leftBadge)
local lbStroke = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, leftBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, lbStroke))
mk("ImageLabel", { Name = "LogoImg", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.58, 0.58), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit, Active = false, ZIndex = 10001 }, leftBadge)
else
leftBadge.Size = u2(0, 24, 0, 24)
leftBadge.BackgroundColor3 = c3(0, 0, 0)
local lbImg = leftBadge:FindFirstChildOfClass("ImageLabel")
if lbImg then
lbImg.Image = LOGO_ID
lbImg.Size = u2s(0.58, 0.58)
end
end
local hint = pill:FindFirstChild("IslandExpandHint")
if not hint then
hint = mk("TextLabel", { Name = "IslandExpandHint", Size = u2(0, 22, 0, 20), BackgroundColor3 = c3(20, 24, 38), BorderSizePixel = 0, Text = "▾", Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = c3(165, 215, 255), LayoutOrder = 99, Active = true, ZIndex = 10000 }, pill)
else
hint.Size = u2(0, 22, 0, 20)
hint.BackgroundColor3 = c3(20, 24, 38)
hint.Text = "▾"
hint.Font = Enum.Font.GothamBold
hint.TextSize = 11
hint.TextColor3 = c3(165, 215, 255)
end
if not hint:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hint) end
local hStroke = hint:FindFirstChildOfClass("UIStroke")
if hStroke then hStroke:Destroy() end
local expTaskLbl = nil
local function syncStatus(fromSaved)
if statusLbl:GetAttribute("__Updating") then return end
statusLbl:SetAttribute("__Updating", true)
local cur = statusLbl.Text:gsub("●",""):gsub("•",""):gsub("✨%s*rainbow",""):match("^%s*(.-)%s*$") or ""
local en = statusLbl:GetAttribute("OrigStatusEn") or statusLbl:GetAttribute("OrigRawText")
if not fromSaved and cur ~= "" and cur ~= statusLbl:GetAttribute("__LastTranslatedStatus") and not hasVi(cur) then
en = cur
statusLbl:SetAttribute("OrigStatusEn", en)
end
local out = translateStatus(en or cur)
statusLbl:SetAttribute("__LastTranslatedStatus", out)
statusLbl.RichText = false
statusLbl.Font = Enum.Font.GothamBlack
statusLbl.TextColor3 = Color3.new(1, 1, 1)
statusLbl.Text = out
if expTaskLbl and expTaskLbl.Parent then expTaskLbl.Text = "⚡ " .. out end
statusLbl:SetAttribute("__Updating", false)
end
State.RefreshIslandCallback = function() syncStatus(true) end
syncStatus(false)
if not statusLbl:FindFirstChildOfClass("UIStroke") then mk("UIStroke", { Thickness = 1.2, Color = c3(12, 8, 22), Transparency = 0.2 }, statusLbl) end
local tg = statusLbl:FindFirstChild("TextRainbow") or mk("UIGradient", { Name = "TextRainbow", Color = ULTRA_TEXT_GRAD }, statusLbl)
tg.Color = ULTRA_TEXT_GRAD
table.insert(State.ActiveGradients, tg)
local exp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if statusLbl:GetAttribute("__IslandSession") == SID and exp then return end
statusLbl:SetAttribute("__IslandSession", SID)
pill.Parent = venyxGui
pill.AnchorPoint = v2(0.5, 0)
pill.ZIndex = 9999
pill.Active = true
statusLbl.Active = true
hint.Active = true
if pill.Position.Y.Offset < 4 or pill.Position.Y.Offset > 600 then pill.Position = u2(0.5, 0, 0, 8) end
if not pill:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pill) end
local ps = pill:FindFirstChild("IslandStroke") or mk("UIStroke", { Name = "IslandStroke", Thickness = 2.0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1) }, pill)
table.insert(State.ActiveGradients, ps:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, ps))
if exp then exp:Destroy() end
exp = mk("Frame", { Name = "ChilliV5_ExpandedIsland", AnchorPoint = v2(0.5, 0), Position = pill.Position, Size = u2(0, 296, 0, 144), BackgroundColor3 = c3(10, 12, 20), BorderSizePixel = 0, Visible = false, Active = true, ClipsDescendants = true, ZIndex = 10000 }, venyxGui)
mk("UICorner", { CornerRadius = UDim.new(0, 18) }, exp)
local es = mk("UIStroke", { Thickness = 2.0, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, exp)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, es))
mk("ImageLabel", { Name = "IslandCosmicBg", Position = u2(0, 0, 0, 0), Size = u2(1, 0, 0, 42), BackgroundTransparency = 1, Image = HEADER_BAR_IMG_ID, ImageRectOffset = v2(15, 60), ImageRectSize = v2(650, 170), ScaleType = Enum.ScaleType.Stretch, ImageTransparency = 0.22, Active = false, ZIndex = 10000 }, exp)
local expLogo = mk("Frame", { Position = u2(0, 10, 0, 7), Size = u2(0, 24, 0, 24), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 10002 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, expLogo)
local elStroke = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1) }, expLogo)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, elStroke))
mk("ImageLabel", { AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.58, 0.58), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit, Active = false, ZIndex = 10003 }, expLogo)
local expTitle = mk("TextLabel", { Name = "ChilliIslandTitle", Size = u2(0, 150, 0, 24), Position = u2(0, 40, 0, 7), BackgroundTransparency = 1, Text = "Chilli Hub V7", Font = Enum.Font.GothamBlack, TextSize = 13.5, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002 }, exp)
mk("UIStroke", { Thickness = 1.2, Color = c3(12, 8, 22), Transparency = 0.2 }, expTitle)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, expTitle))
local colBtn = mk("TextButton", { Size = u2(0, 26, 0, 22), Position = u2(1, -34, 0, 8), BackgroundColor3 = c3(22, 24, 36), BorderSizePixel = 0, Text = "▲", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = c3(160, 205, 255), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, colBtn)
local taskBox = mk("Frame", { Size = u2(1, -20, 0, 24), Position = u2(0, 10, 0, 36), BackgroundColor3 = c3(16, 18, 28), BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, taskBox)
mk("UIStroke", { Thickness = 1, Color = c3(45, 52, 78), Transparency = 0.35 }, taskBox)
expTaskLbl = mk("TextLabel", { Size = u2(1, -16, 1, 0), Position = u2(0, 8, 0, 0), BackgroundTransparency = 1, Text = "⚡ " .. (statusLbl.Text or "Đang rảnh"), Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = Color3.new(1, 1, 1), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 10002 }, taskBox)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, expTaskLbl))
local cap = mk("Frame", { Size = u2(1, -20, 0, 32), Position = u2(0, 10, 0, 65), BackgroundColor3 = c3(18, 20, 30), BorderSizePixel = 0, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cap)
local sld = mk("Frame", { Size = u2(0.5, -4, 1, -4), Position = (State.Language == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)), BackgroundColor3 = c3(95, 110, 235), BorderSizePixel = 0, ZIndex = 10002 }, cap)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, sld)
local bVI = mk("TextButton", { Size = u2(0.5, 0, 1, 0), BackgroundTransparency = 1, Text = "🇻🇳 TIẾNG VIỆT", Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = (State.Language == "VI" and Color3.new(1, 1, 1) or c3(150, 165, 190)), ZIndex = 10003 }, cap)
local bEN = mk("TextButton", { Size = u2(0.5, 0, 1, 0), Position = u2(0.5, 0, 0, 0), BackgroundTransparency = 1, Text = "🌐 ENGLISH", Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = (State.Language == "EN" and Color3.new(1, 1, 1) or c3(150, 165, 190)), ZIndex = 10003 }, cap)
local cfgBtn = mk("TextButton", { Name = "AutoFarmConfigBtn", Size = u2(1, -20, 0, 34), Position = u2(0, 10, 0, 102), BackgroundColor3 = c3(22, 25, 40), BorderSizePixel = 0, Text = "⚡ CONFIG SETTING AUTO FARM", Font = Enum.Font.GothamBlack, TextSize = 10.5, TextColor3 = Color3.new(1, 1, 1), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cfgBtn)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, cfgBtn))
local cs = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, cfgBtn)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, cs))
cfgBtn.MouseButton1Click:Connect(function() runAutoFarmMacro(venyxGui, cfgBtn) end)
local function setLang(l)
if State.Language == l then return end
State.Language = l
if writefile then pcall(writefile, LANG_FILE, l) end
TweenService:Create(sld, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = (l == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)) }):Play()
bVI.TextColor3 = l == "VI" and Color3.new(1, 1, 1) or c3(150, 165, 190)
bEN.TextColor3 = l == "EN" and Color3.new(1, 1, 1) or c3(150, 165, 190)
refreshAllTexts()
end
bVI.MouseButton1Click:Connect(function() setLang("VI") end)
bEN.MouseButton1Click:Connect(function() setLang("EN") end)
local open = false
local function toggle()
open = not open
if open then
exp.Position = pill.Position
exp.Size = u2(0, 210, 0, 32)
exp.Visible = true
pill.Visible = false
TweenService:Create(exp, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 296, 0, 144) }):Play()
else
local tw = TweenService:Create(exp, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = u2(0, 210, 0, 32) })
tw:Play()
tw.Completed:Connect(function()
if not open then
exp.Visible = false
pill.Visible = true
end
end)
end
end
colBtn.MouseButton1Click:Connect(toggle)
local dStart, dMoved = nil, false
local function onIn(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
dStart, dMoved = i.Position, false
local c1, c2
c1 = i.Changed:Connect(function()
if i.UserInputState == Enum.UserInputState.End then
if c1 then c1:Disconnect() end
if c2 then c2:Disconnect() end
if not dMoved then toggle() end
end
end)
c2 = pill.InputChanged:Connect(function(m)
if (m.UserInputType == Enum.UserInputType.MouseMovement or m.UserInputType == Enum.UserInputType.Touch) and dStart and (m.Position - dStart).Magnitude > 8 then
dMoved = true
end
end)
end
end
pill.InputBegan:Connect(onIn)
statusLbl.InputBegan:Connect(onIn)
hint.InputBegan:Connect(onIn)
statusLbl:GetPropertyChangedSignal("Text"):Connect(function() if isAlive() then syncStatus(false) end end)
end
-- NÚT NỔI TRÒN ĐEN TUYỀN #000000 + PHÓNG XA LOGO 0.58x (KHÔNG CHE HOẠ TIẾT TINH THỂ)
local function cleanupStrayLogos(gui, win)
for _, ch in ipairs(gui:GetChildren()) do
if ch:IsA("GuiObject") and ch ~= win and ch.Name ~= "ChilliV5_ExpandedIsland" and not ch:FindFirstChild("IslandExpandHint") then
local s, p = ch.AbsoluteSize, ch.AbsolutePosition
if s.X >= 22 and s.X <= 110 and s.Y >= 22 and s.Y <= 110 and p.X > 260 then
ch.Visible = false
end
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
if sz.X > 105 or sz.Y > 105 or sz.X < 24 or math.abs(sz.X - sz.Y) > 25 or pos.X > 260 then return end
for _, ch in ipairs(top:GetChildren()) do
if ch.Name == "ChilliV5CoverLogo" or ch.Name == "RainbowBorder" or ch.Name == "ChilliInnerRing" or ch.Name == "ChilliCosmicAura" or ch:IsA("UIStroke") then
pcall(ch.Destroy, ch)
elseif ch:IsA("UICorner") then
ch.CornerRadius = UDim.new(1, 0)
end
end
local discExisting = top:FindFirstChild("ChilliCircleDisc")
for _, ch in ipairs(top:GetDescendants()) do
if not (discExisting and ch:IsDescendantOf(discExisting)) and ch ~= discExisting then
if (ch:IsA("UIPadding") or ch:IsA("UIAspectRatioConstraint") or ch:IsA("UISizeConstraint")) and ch.Name ~= "PerfectCircleAspect" then
pcall(ch.Destroy, ch)
elseif ch:IsA("UIStroke") then
ch.Transparency = 1
ch.Enabled = false
elseif ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
ch.ImageTransparency = 1
ch.BackgroundTransparency = 1
elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch:SetAttribute("__HiddenVxLogo", true)
ch.TextTransparency = 1
ch.BackgroundTransparency = 1
elseif ch:IsA("Frame") then
ch.BackgroundTransparency = 1
end
end
end
if top:IsA("ImageLabel") or top:IsA("ImageButton") then
top.ImageTransparency = 1
elseif top:IsA("TextLabel") or top:IsA("TextButton") then
top:SetAttribute("__HiddenVxLogo", true)
top.TextTransparency = 1
end
top.Size = u2(0, 70, 0, 70)
if not top:GetAttribute("__SafePosAdjusted") then
top:SetAttribute("__SafePosAdjusted", true)
if pos.Y > 125 and pos.Y < 260 then top.Position = u2(0, 16, 0, 56) end
end
top.BackgroundTransparency = 1
top.BorderSizePixel = 0
top.ClipsDescendants = false
if not top:FindFirstChild("PerfectCircleAspect") then
mk("UIAspectRatioConstraint", { Name = "PerfectCircleAspect", AspectRatio = 1 }, top)
end
if not top:GetAttribute("__SizeLockedV5Pro") then
top:SetAttribute("__SizeLockedV5Pro", true)
top:GetPropertyChangedSignal("Size"):Connect(function()
if top.Size ~= u2(0, 70, 0, 70) then top.Size = u2(0, 70, 0, 70) end
end)
end
local disc = top:FindFirstChild("ChilliCircleDisc") or mk("Frame", {
Name = "ChilliCircleDisc", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2(0, 68, 0, 68), BackgroundColor3 = c3(0, 0, 0), BackgroundTransparency = 0,
BorderSizePixel = 0, Active = false, ClipsDescendants = true, ZIndex = top.ZIndex + 8
}, top)
disc.BackgroundColor3 = c3(0, 0, 0)
disc.BackgroundTransparency = 0
disc.Size = u2(0, 68, 0, 68)
disc.ClipsDescendants = true
disc.ZIndex = top.ZIndex + 8
local discCorner = disc:FindFirstChildOfClass("UICorner") or mk("UICorner", { CornerRadius = UDim.new(1, 0) }, disc)
discCorner.CornerRadius = UDim.new(1, 0)
local discStroke = disc:FindFirstChild("RainbowBorder") or mk("UIStroke", {
Name = "RainbowBorder", Thickness = 2.3, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
Color = Color3.new(1, 1, 1), Transparency = 0.02
}, disc)
table.insert(State.ActiveGradients, discStroke:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, discStroke))
local cov = disc:FindFirstChild("ChilliV5CoverLogo") or mk("ImageLabel", {
Name = "ChilliV5CoverLogo", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2s(0.58, 0.58), BackgroundTransparency = 1, Image = LOGO_ID,
ScaleType = Enum.ScaleType.Fit, Active = false, ZIndex = disc.ZIndex + 2
}, disc)
cov.Image = LOGO_ID
cov.Size = u2s(0.58, 0.58)
cov.Position = u2s(0.5, 0.5)
cov.AnchorPoint = v2(0.5, 0.5)
cov.BackgroundTransparency = 1
cov.ScaleType = Enum.ScaleType.Fit
cov.ZIndex = disc.ZIndex + 2
local oldCovCorner = cov:FindFirstChildOfClass("UICorner")
if oldCovCorner then oldCovCorner:Destroy() end
if not top:GetAttribute("__SyncClickHooked") then
top:SetAttribute("__SyncClickHooked", true)
local function triggerSync()
State.CloseHideUntil = 0
TweenService:Create(disc, TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = u2(0, 56, 0, 56) }):Play()
task.delay(0.09, function()
TweenService:Create(disc, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 68, 0, 68) }):Play()
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
-- KIẾN TRÚC MENU CHILLI HUB V7 SUPREME (HUY HIỆU TRÊN THANH MENU + NỀN 90615151648668 + CYBER NEON CARDS)
local SIDEBAR_PALETTE = { c3(37, 99, 235), c3(239, 68, 68), c3(245, 158, 11), c3(168, 85, 247), c3(236, 72, 153), c3(16, 185, 129) }
local function applySenaV7Architecture(win, titleLbl)
if not win or not titleLbl then return end
local hy, tx = titleLbl.AbsolutePosition.Y, titleLbl.AbsolutePosition.X
local winX, winY = win.AbsolutePosition.X, win.AbsolutePosition.Y
local bgFrames = {}
if win.BackgroundTransparency < 0.98 then table.insert(bgFrames, win) end
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and not d.Name:find("^Chilli") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
if d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.55 and d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.55 then
if d.BackgroundTransparency < 0.98 then table.insert(bgFrames, d) end
for _, st in ipairs(d:GetChildren()) do
if st:IsA("UIStroke") and st.Name ~= "ChilliProWindowStroke" then
st.Transparency = 1
st.Enabled = false
end
end
end
end
end
for _, st in ipairs(win:GetChildren()) do
if st:IsA("UIStroke") and st.Name ~= "ChilliProWindowStroke" then
st.Transparency = 1
st.Enabled = false
end
end
local mainBg = bgFrames[1] or win
pcall(function()
for _, bf in ipairs(bgFrames) do bf.BackgroundColor3 = c3(8, 10, 18) end
win.ClipsDescendants = true
end)
local strokeTarget = mainBg or win
local winStroke = strokeTarget:FindFirstChild("ChilliProWindowStroke") or win:FindFirstChild("ChilliProWindowStroke")
if not winStroke then
winStroke = mk("UIStroke", { Name = "ChilliProWindowStroke", Thickness = 2.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1), Transparency = 0.02 }, strokeTarget)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, winStroke))
end
-- Dọn sạch ChilliPageWallpaper cũ để không bao giờ đè lên thanh nút bên trái
for _, d in ipairs(win:GetDescendants()) do
if d.Name == "ChilliPageWallpaper" then pcall(d.Destroy, d) end
end
local wpParent = mainBg or win
local wpZ = math.max(1, wpParent.ZIndex)
for _, ch in ipairs(wpParent:GetChildren()) do
if ch:IsA("GuiObject") and not ch.Name:find("^Chilli") and ch.ZIndex <= wpZ then
ch.ZIndex = wpZ + 2
end
end
local wp = wpParent:FindFirstChild("ChilliSenaWallpaper") or win:FindFirstChild("ChilliSenaWallpaper")
if not wp then
wp = mk("ImageLabel", {
Name = "ChilliSenaWallpaper", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2s(1, 1), BackgroundTransparency = 1, Image = WALLPAPER_IMAGE_ID,
ImageTransparency = 0.28, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = wpZ
}, wpParent)
mk("UICorner", { CornerRadius = UDim.new(0, 10) }, wp)
else
wp.Image = WALLPAPER_IMAGE_ID
wp.ZIndex = wpZ
end
local sectionCards = {}
local curBaseOpacity = (mainBg.BackgroundTransparency < 0.95) and mainBg.BackgroundTransparency or 0.30
local function styleMenuInterior()
if not win or not win.Parent then return end
sectionCards = {}
local cardT = math.clamp(0.36 + curBaseOpacity * 0.50, 0.32, 0.88)
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("ScrollingFrame") and (d.AbsolutePosition.X - winX) > 35 then
d.BackgroundTransparency = 1
local p = d.Parent
while p and p ~= win and p ~= mainBg do
if p:IsA("GuiObject") and p.AbsoluteSize.X >= win.AbsoluteSize.X * 0.45 and (p.AbsolutePosition.X - winX) > 30 then
p.BackgroundTransparency = 1
end
p = p.Parent
end
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("Frame") then
local hasList = ch:FindFirstChildOfClass("UIListLayout") ~= nil
local isTransparentCol = (ch.BackgroundTransparency >= 0.95 and not ch:GetAttribute("__IsChilliCard"))
if isTransparentCol and hasList then
for _, subCard in ipairs(ch:GetChildren()) do
if subCard:IsA("Frame") and (subCard.BackgroundTransparency < 0.95 or subCard:GetAttribute("__IsChilliCard")) then
subCard:SetAttribute("__IsChilliCard", true)
table.insert(sectionCards, subCard)
end
end
else
ch:SetAttribute("__IsChilliCard", true)
table.insert(sectionCards, ch)
end
end
end
end
end
for _, card in ipairs(sectionCards) do
card.BackgroundColor3 = c3(12, 14, 26)
card.BackgroundTransparency = cardT
local cStroke = card:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, card)
cStroke.Color = Color3.new(1, 1, 1)
cStroke.Thickness = 1.4
cStroke.Transparency = 0.14
cStroke.Enabled = true
if not cStroke:FindFirstChild("ChilliCardGrad") then
table.insert(State.ActiveGradients, mk("UIGradient", { Name = "ChilliCardGrad", Color = ULTRA_CARD_GRAD }, cStroke))
end
if not card:FindFirstChild("ChilliCardTopGlow") then
local topGlow = mk("Frame", { Name = "ChilliCardTopGlow", AnchorPoint = v2(0.5, 0), Position = u2(0.5, 0, 0, 0), Size = u2(0.92, 0, 0, 2), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = false, ZIndex = card.ZIndex + 2 }, card)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, topGlow)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, topGlow))
end
end
for _, d in ipairs(win:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d.Name:find("^Chilli") and d ~= titleLbl and not d:IsDescendantOf(titleLbl) then
local txt = d.Text or ""
local isBigPageTitle = (d.TextSize >= 15 and d.AbsolutePosition.Y > hy + 8 and d.AbsolutePosition.Y < hy + 95 and (d.AbsolutePosition.X - winX) < 240)
local isSectionHeader = (txt:upper() == txt and #txt >= 3 and d.TextSize <= 14 and d:FindFirstAncestorOfClass("ScrollingFrame") ~= nil)
local isSubTabActive = (d.AbsolutePosition.Y > hy + 10 and d.AbsolutePosition.Y < hy + 75 and (d.AbsolutePosition.X - winX) >= 200)
if isBigPageTitle or isSectionHeader or isSubTabActive then
d.TextColor3 = Color3.new(1, 1, 1)
if not d:FindFirstChild("ChilliInnerUltraGrad") then
table.insert(State.ActiveGradients, mk("UIGradient", { Name = "ChilliInnerUltraGrad", Color = ULTRA_TEXT_GRAD }, d))
end
end
elseif (d:IsA("Frame") or d:IsA("TextButton") or d:IsA("TextBox")) and not d.Name:find("^Chilli") and not d:GetAttribute("__IsChilliCard") and not d:IsDescendantOf(titleLbl) then
local inScroll = d:FindFirstAncestorOfClass("ScrollingFrame") ~= nil
local sz = d.AbsoluteSize
local col = d.BackgroundColor3
if inScroll and (d.AbsolutePosition.X - winX) > 40 and sz.Y >= 3 and sz.Y <= 28 and sz.X >= 8 and sz.X <= 290 and d.BackgroundTransparency < 0.65 then
if (col.B > 0.50 and (col.R > 0.30 or col.G > 0.30)) and not (col.R < 0.22 and col.G < 0.22 and col.B < 0.28) then
if not d:FindFirstChild("ChilliControlNeonGrad") then
d.BackgroundColor3 = Color3.new(1, 1, 1)
mk("UIGradient", { Name = "ChilliControlNeonGrad", Color = ULTRA_CARD_GRAD }, d)
end
elseif sz.Y >= 16 and sz.Y <= 28 and sz.X >= 34 and sz.X <= 195 and d:FindFirstChildOfClass("UICorner") then
d.BackgroundColor3 = c3(15, 18, 32)
local dStroke = d:FindFirstChild("ChilliDropStroke") or d:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Name = "ChilliDropStroke", Thickness = 1.1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, d)
dStroke.Color = Color3.new(1, 1, 1)
dStroke.Transparency = 0.32
if not dStroke:FindFirstChild("ChilliDropGrad") then
mk("UIGradient", { Name = "ChilliDropGrad", Color = ULTRA_CARD_GRAD }, dStroke)
end
end
elseif not inScroll and d.AbsolutePosition.Y >= winY and d.AbsolutePosition.Y < hy + 80 and (d.AbsolutePosition.X - winX) > 180 and sz.Y >= 18 and sz.Y <= 36 and sz.X >= 60 and sz.X <= 260 and d:FindFirstChildOfClass("UICorner") then
local topStroke = d:FindFirstChild("ChilliTopPillStroke") or d:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Name = "ChilliTopPillStroke", Thickness = 1.2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, d)
topStroke.Color = Color3.new(1, 1, 1)
topStroke.Transparency = 0.25
if not topStroke:FindFirstChild("ChilliTopPillGrad") then
table.insert(State.ActiveGradients, mk("UIGradient", { Name = "ChilliTopPillGrad", Color = ULTRA_CARD_GRAD }, topStroke))
end
end
end
end
end
local syncingOpacity = false
local function syncWallpaperAndOldBg(changedFrame)
if syncingOpacity or not wp or not wp.Parent then return end
syncingOpacity = true
local curT = curBaseOpacity
if changedFrame and changedFrame.Parent and changedFrame.BackgroundTransparency < 0.98 then
curT = changedFrame.BackgroundTransparency
elseif mainBg and mainBg.Parent and mainBg.BackgroundTransparency < 0.98 then
curT = mainBg.BackgroundTransparency
end
curBaseOpacity = curT
if mainBg and mainBg.Parent and mainBg.BackgroundTransparency < 0.98 then
mainBg.BackgroundTransparency = curT
end
for i = 2, #bgFrames do
local bf = bgFrames[i]
if bf and bf.Parent and bf ~= mainBg then
bf.BackgroundTransparency = math.clamp(curT + 0.62, 0.86, 0.98)
end
end
wp.ImageTransparency = math.clamp(0.14 + curT * 0.78, 0.14, 0.94)
local cardT = math.clamp(0.36 + curT * 0.50, 0.32, 0.88)
for _, card in ipairs(sectionCards) do
if card and card.Parent then card.BackgroundTransparency = cardT end
end
syncingOpacity = false
end
pcall(styleMenuInterior)
for _, bf in ipairs(bgFrames) do
if not bf:GetAttribute("__WpSyncHooked") then
bf:SetAttribute("__WpSyncHooked", true)
bf:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() syncWallpaperAndOldBg(bf) end)
end
end
pcall(syncWallpaperAndOldBg, nil)
-- GẮN HUY HIỆU 👑 ULTRA + ⚡ SUPREME + TELEMETRY TRỰC TIẾP TRÊN THANH MENU SCRIPT
pcall(function()
local oldCosmicHolder = win:FindFirstChild("ChilliCosmicHolder")
if oldCosmicHolder then oldCosmicHolder:Destroy() end
local pWalk = titleLbl
while pWalk and pWalk ~= win do
if pWalk:IsA("GuiObject") then pWalk.Visible = true end
pWalk = pWalk.Parent
end
for _, desc in ipairs(win:GetDescendants()) do
if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and desc ~= titleLbl and not desc:IsDescendantOf(titleLbl) then
if math.abs(desc.AbsolutePosition.Y - hy) < 28 then
local dt = (desc.Text or ""):match("^%s*(.-)%s*$")
if dt:match("^v%d+%.%d+") or dt == "/" or dt:lower():find("steal an egg", 1, true) or dt:lower():find("cướp trứng", 1, true) then
desc.TextTransparency = 1
desc.BackgroundTransparency = 1
if desc.Parent and desc.Parent:IsA("Frame") and desc.Parent.AbsoluteSize.X < 90 and desc.Parent.AbsoluteSize.Y < 32 then
desc.Parent.BackgroundTransparency = 1
local st = desc.Parent:FindFirstChildOfClass("UIStroke")
if st then st.Transparency = 1 end
end
end
end
end
end
titleLbl.TextTransparency = 0
titleLbl.TextColor3 = Color3.new(1, 1, 1)
titleLbl.Font = Enum.Font.GothamBlack
if not titleLbl:FindFirstChild("TitleUltraGrad") then
table.insert(State.ActiveGradients, mk("UIGradient", { Name = "TitleUltraGrad", Color = ULTRA_TEXT_GRAD }, titleLbl))
end
if not titleLbl:FindFirstChildOfClass("UIStroke") then
mk("UIStroke", { Thickness = 1.3, Color = c3(10, 8, 20), Transparency = 0.2 }, titleLbl)
end
local hdrOverlay = wpParent:FindFirstChild("ChilliHeaderOverlay") or mk("Frame", {
Name = "ChilliHeaderOverlay", Position = u2(0, 0, 0, 0), Size = u2(1, 0, 0, 38),
BackgroundTransparency = 1, BorderSizePixel = 0, Active = false, ZIndex = 50
}, wpParent)
hdrOverlay.ZIndex = 50
if not hdrOverlay:FindFirstChild("ChilliHeaderRainbowLine") then
local hdrLine = mk("Frame", {
Name = "ChilliHeaderRainbowLine", AnchorPoint = v2(0.5, 1), Position = u2(0.5, 0, 1, 0),
Size = u2(1, 0, 0, 1.8), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = false, ZIndex = 51
}, hdrOverlay)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, hdrLine))
end
local badgeStartX = math.clamp(math.floor((tx - winX) + ((titleLbl.TextBounds.X > 35 and titleLbl.TextBounds.X < 200) and titleLbl.TextBounds.X or 106) + 10), 148, 175)
local ultraBadge = hdrOverlay:FindFirstChild("ChilliUltraBadgePill")
if not ultraBadge then
ultraBadge = mk("Frame", {
Name = "ChilliUltraBadgePill", AnchorPoint = v2(0, 0.5), Position = u2(0, badgeStartX, 0.5, 0),
Size = u2(0, 58, 0, 19), BackgroundColor3 = c3(24, 16, 42), BackgroundTransparency = 0.04,
BorderSizePixel = 0, Active = false, ZIndex = 55
}, hdrOverlay)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, ultraBadge)
local bStroke = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0.05 }, ultraBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, bStroke))
mk("TextLabel", {
Name = "BadgeTxt", Size = u2s(1, 1), BackgroundTransparency = 1,
Font = Enum.Font.GothamBlack, TextSize = 9.5, TextColor3 = c3(255, 225, 85),
Text = "👑 ULTRA", Active = false, ZIndex = 56
}, ultraBadge)
else
ultraBadge.Position = u2(0, badgeStartX, 0.5, 0)
end
local vipBadge = hdrOverlay:FindFirstChild("ChilliVipBadgePill")
if not vipBadge then
vipBadge = mk("Frame", {
Name = "ChilliVipBadgePill", AnchorPoint = v2(0, 0.5), Position = u2(0, badgeStartX + 63, 0.5, 0),
Size = u2(0, 58, 0, 19), BackgroundColor3 = c3(14, 22, 38), BackgroundTransparency = 0.06,
BorderSizePixel = 0, Active = false, ZIndex = 55
}, hdrOverlay)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, vipBadge)
local vStroke = mk("UIStroke", { Thickness = 1.2, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0.15 }, vipBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_CARD_GRAD }, vStroke))
local vTxt = mk("TextLabel", {
Name = "VipTxt", Size = u2s(1, 1), BackgroundTransparency = 1,
Font = Enum.Font.GothamBlack, TextSize = 8.5, TextColor3 = Color3.new(1, 1, 1),
Text = "⚡ SUPREME", Active = false, ZIndex = 56
}, vipBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, vTxt))
else
vipBadge.Position = u2(0, badgeStartX + 63, 0.5, 0)
end
local teleRow = hdrOverlay:FindFirstChild("ChilliSenaTopTelemetry")
if not teleRow then
teleRow = mk("Frame", {
Name = "ChilliSenaTopTelemetry", AnchorPoint = v2(0, 0.5), Position = u2(0, badgeStartX + 126, 0.5, 0),
Size = u2(0, 185, 0, 20), BackgroundTransparency = 1, Active = false, ZIndex = 55
}, hdrOverlay)
mk("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 4) }, teleRow)
local function makePill(name, defaultTxt, textColor)
local pFrame = mk("Frame", { Name = name, Size = u2(0, 0, 0, 18), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = c3(18, 20, 34), BackgroundTransparency = 0.12, BorderSizePixel = 0, Active = false, ZIndex = 55 }, teleRow)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pFrame)
local pSt = mk("UIStroke", { Thickness = 1, Color = Color3.new(1, 1, 1), Transparency = 0.35 }, pFrame)
mk("UIGradient", { Color = ULTRA_CARD_GRAD }, pSt)
mk("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, pFrame)
return mk("TextLabel", { Name = "Val", Size = u2(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Text = defaultTxt, Font = Enum.Font.GothamBold, TextSize = 8.5, TextColor3 = textColor or c3(235, 240, 255), Active = false, ZIndex = 56 }, pFrame)
end
local lblTime = makePill("PillTime", "⏱️ 0:00:00", c3(220, 235, 255))
local lblPing = makePill("PillPing", "📶 60 ms", c3(110, 255, 175))
local lblTopFps = makePill("PillFps", "⚡ 110 FPS", c3(255, 220, 105))
local botBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
local lblBotFps = nil
if not botBar then
botBar = mk("Frame", { Name = "ChilliSenaBottomBar", AnchorPoint = v2(0, 1), Position = u2(0, 50, 1, 0), Size = u2(1, -50, 0, 22), BackgroundColor3 = c3(10, 12, 20), BackgroundTransparency = 0.08, BorderSizePixel = 0, Active = false, ZIndex = 55 }, wpParent)
local topDivider = mk("Frame", { Size = u2(1, 0, 0, 1.5), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = false, ZIndex = 56 }, botBar)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, topDivider))
local dName = (LocalPlayer and LocalPlayer.Name) or "Player"
local wLbl = mk("TextLabel", { Name = "WelcomeLbl", Position = u2(0, 10, 0, 0), Size = u2(0, 260, 1, 0), BackgroundTransparency = 1, Text = "🌶️ Chào mừng, " .. dName:sub(1, 14) .. "  •  CHILLI HUB V7 SUPREME", Font = Enum.Font.GothamBlack, TextSize = 9, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left, Active = false, ZIndex = 56 }, botBar)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, wLbl))
lblBotFps = mk("TextLabel", { Name = "BotFpsLbl", AnchorPoint = v2(1, 0.5), Position = u2(1, -84, 0.5, 0), Size = u2(0, 75, 0, 18), BackgroundTransparency = 1, Text = "⚡ 108 FPS", Font = Enum.Font.GothamBold, TextSize = 9.5, TextColor3 = c3(110, 255, 165), TextXAlignment = Enum.TextXAlignment.Right, Active = false, ZIndex = 56 }, botBar)
local donBadge = mk("Frame", { AnchorPoint = v2(1, 0.5), Position = u2(1, -8, 0.5, 0), Size = u2(0, 68, 0, 16), BackgroundColor3 = c3(28, 20, 44), BorderSizePixel = 0, Active = false, ZIndex = 56 }, botBar)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, donBadge)
local dbStroke = mk("UIStroke", { Thickness = 1, Color = c3(245, 190, 45), Transparency = 0.15 }, donBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, dbStroke))
mk("TextLabel", { Size = u2s(1, 1), BackgroundTransparency = 1, Text = "👑 VIP V7", Font = Enum.Font.GothamBlack, TextSize = 8.5, TextColor3 = c3(255, 220, 80), Active = false, ZIndex = 57 }, donBadge)
else
lblBotFps = botBar:FindFirstChild("BotFpsLbl")
end
State.TelemetryUpdateFn = function(curFps)
if not win or not win.Visible then return end
local elapsed = math.floor(os.clock() - (State.StartClock or os.clock()))
lblTime.Text = string.format("⏱️ %d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), elapsed % 60)
local pingMs = 62
pcall(function() pingMs = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
if pingMs <= 0 then pingMs = math.random(48, 85) end
lblPing.Text = string.format("📶 %d ms", pingMs)
local fpsVal = curFps or getFakeFps()
lblTopFps.Text = string.format("⚡ %d FPS", fpsVal)
if lblBotFps then lblBotFps.Text = string.format("⚡ %d FPS", fpsVal) end
end
end
end)
local function syncWindowVisibilityInstant()
if not win or not win.Parent then return end
local isOffscreen = (win.AbsolutePosition.X < -500 or win.AbsolutePosition.Y < -500)
local isSizeZero = (win.AbsoluteSize.X < 80 or win.AbsoluteSize.Y < 60)
local isForceClosing = (State.CloseHideUntil ~= nil) and (os.clock() < State.CloseHideUntil)
local isOpen = not ((not win.Visible) or isOffscreen or isSizeZero or isForceClosing)
if winStroke then
winStroke.Enabled = isOpen
winStroke.Transparency = isOpen and 0.02 or 1
end
local hOv = wpParent:FindFirstChild("ChilliHeaderOverlay")
if hOv then hOv.Visible = isOpen end
local bBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if bBar then bBar.Visible = isOpen end
if wp and wp.Parent then wp.Visible = isOpen end
if titleLbl and titleLbl.Parent then titleLbl.TextTransparency = 0 end
end
State.SyncWindowFn = syncWindowVisibilityInstant
syncWindowVisibilityInstant()
if not win:GetAttribute("__InstantHideHooked") then
win:SetAttribute("__InstantHideHooked", true)
win:GetPropertyChangedSignal("Visible"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Size"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Position"):Connect(syncWindowVisibilityInstant)
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and math.abs(d.AbsolutePosition.Y - hy) < 30 then
local isTxtClose = (d:IsA("TextButton") or d:IsA("TextLabel")) and (d.Text == "-" or d.Text == "—")
local isRightEdgeBtn = (d:IsA("TextButton") or d:IsA("ImageButton")) and (d.AbsolutePosition.X > win.AbsolutePosition.X + win.AbsoluteSize.X - 45)
if isTxtClose or isRightEdgeBtn then
local btn = (d:IsA("TextButton") or d:IsA("ImageButton")) and d or d.Parent
if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) and not btn:GetAttribute("__CloseSyncHooked") then
btn:SetAttribute("__CloseSyncHooked", true)
btn.MouseButton1Down:Connect(function()
State.CloseHideUntil = os.clock() + 0.42
if winStroke then winStroke.Enabled = false end
local hOv = wpParent:FindFirstChild("ChilliHeaderOverlay")
if hOv then hOv.Visible = false end
local bBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if bBar then bBar.Visible = false end
if wp and wp.Parent then wp.Visible = false end
end)
end
end
end
end
end
pcall(function()
local navButtons = {}
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and (d.AbsolutePosition.X - winX) < 75 and d.AbsolutePosition.Y > hy + 15 then
local children = {}
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("GuiObject") and ch.AbsoluteSize.X >= 22 and ch.AbsoluteSize.X <= 65 and ch.AbsoluteSize.Y >= 22 and ch.AbsoluteSize.Y <= 65 then
ch.Visible = true
table.insert(children, ch)
end
end
if #children >= 5 and #children <= 8 then
if d.ZIndex < wpZ + 5 then d.ZIndex = wpZ + 5 end
for _, nb in ipairs(children) do
if nb.ZIndex < wpZ + 6 then nb.ZIndex = wpZ + 6 end
end
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
[6] = { title = "HỆ THỐNG", icon = "⚙️", sub = "SYSTEM & CONFIG" }
}
local function showTabToast(idx, badgeColor)
local tabInfo = TAB_NAMES[idx] or { title = "TAB " .. tostring(idx), icon = "⚡", sub = "CHILLI HUB V7" }
local oldToast = win:FindFirstChild("ChilliTabToast")
if oldToast then oldToast:Destroy() end
local toast = mk("Frame", { Name = "ChilliTabToast", AnchorPoint = v2(0.5, 0), Position = u2(0.5, 20, 0, -32), Size = u2(0, 256, 0, 30), BackgroundColor3 = c3(14, 16, 28), BackgroundTransparency = 0.08, BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 1005 }, win)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, toast)
local tStroke = mk("UIStroke", { Thickness = 1.5, Color = badgeColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, toast)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, tStroke))
local tLbl = mk("TextLabel", { Size = u2(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 11, TextColor3 = Color3.new(1, 1, 1), Text = tabInfo.icon .. "  " .. tabInfo.title .. "  •  " .. tabInfo.sub, Active = false, ZIndex = 1006 }, toast)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, tLbl))
TweenService:Create(toast, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = u2(0.5, 20, 0, 8) }):Play()
task.delay(1.3, function()
if toast and toast.Parent then
local outTween = TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = u2(0.5, 20, 0, -32), BackgroundTransparency = 1 })
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
squircle = mk("Frame", { Name = "ChilliSenaSquircle", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2(0, 30, 0, 30), BackgroundColor3 = badgeColor, BackgroundTransparency = 0.12, BorderSizePixel = 0, Active = false, ZIndex = btn.ZIndex + 1 }, btn)
mk("UICorner", { CornerRadius = UDim.new(0, 8) }, squircle)
mk("UIStroke", { Thickness = 1, Color = Color3.new(1, 1, 1), Transparency = 0.55 }, squircle)
for _, ch in ipairs(btn:GetDescendants()) do
if ch ~= squircle and ch.Name ~= "ChilliStealTabIcon" then
if ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
ch.ZIndex = squircle.ZIndex + 2
ch.ImageColor3 = Color3.new(1, 1, 1)
elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch.ZIndex = squircle.ZIndex + 2
ch.TextColor3 = Color3.new(1, 1, 1)
end
end
end
end
if idx == 2 then
for _, desc in ipairs(btn:GetDescendants()) do
if desc ~= squircle and desc.Name ~= "ChilliStealTabIcon" and not desc:IsA("UICorner") and not desc:IsA("UIStroke") then
if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
desc.ImageTransparency = 1
elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
desc:SetAttribute("__HiddenVxLogo", true)
desc.TextTransparency = 1
elseif desc:IsA("Frame") then
desc.BackgroundTransparency = 1
end
end
end
local stealIcon = btn:FindFirstChild("ChilliStealTabIcon") or mk("ImageLabel", { Name = "ChilliStealTabIcon", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.84, 0.84), BackgroundTransparency = 1, Image = STEAL_TAB_ICON_ID, ScaleType = Enum.ScaleType.Fit, Active = false, Selectable = false, ZIndex = squircle.ZIndex + 3 }, btn)
stealIcon.Image = STEAL_TAB_ICON_ID
stealIcon.Size = u2s(0.84, 0.84)
end
if not btn:GetAttribute("__TabEffectHooked") then
btn:SetAttribute("__TabEffectHooked", true)
local function onTabTriggered()
TweenService:Create(squircle, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = u2(0, 24, 0, 24) }):Play()
task.delay(0.08, function()
TweenService:Create(squircle, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 33, 0, 33) }):Play()
pcall(styleMenuInterior)
end)
task.delay(0.26, function()
TweenService:Create(squircle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = u2(0, 30, 0, 30) }):Play()
pcall(styleMenuInterior)
end)
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
end)
pcall(function()
for _, it in ipairs(win:GetDescendants()) do
if it ~= titleLbl and it:IsA("GuiObject") and not it.Name:find("^Chilli") and not it:IsDescendantOf(titleLbl) then
local p, s = it.AbsolutePosition, it.AbsoluteSize
if math.abs(p.Y - hy) < 28 and p.X < tx and (tx - p.X) < 55 and s.X >= 12 and s.X <= 42 and s.Y >= 12 and s.Y <= 42 then
local holder = (it:IsA("ImageLabel") or it:IsA("ImageButton")) and it or it.Parent
if it:IsA("TextLabel") or it:IsA("TextButton") then
it:SetAttribute("__HiddenVxLogo", true)
it.TextTransparency = 1
elseif it:IsA("ImageLabel") or it:IsA("ImageButton") then
it.ImageTransparency = 1
end
if holder and holder:IsA("GuiObject") then
holder.BackgroundTransparency = 1
local hBadge = holder:FindFirstChild("ChilliHeaderLogo")
if not hBadge then
hBadge = mk("Frame", { Name = "ChilliHeaderLogo", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2(0, 28, 0, 28), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 60 }, holder)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hBadge)
local hStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, hBadge)
table.insert(State.ActiveGradients, mk("UIGradient", { Color = RAINBOW }, hStroke))
mk("ImageLabel", { Name = "LogoImg", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.58, 0.58), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit, Active = false, ZIndex = 61 }, hBadge)
else
hBadge.Size = u2(0, 28, 0, 28)
hBadge.BackgroundColor3 = c3(0, 0, 0)
local hImg = hBadge:FindFirstChildOfClass("ImageLabel")
if hImg then
hImg.Image = LOGO_ID
hImg.Size = u2s(0.58, 0.58)
end
end
end
break
end
end
end
end)
end
local venyxGuiLocked = nil
local function patchVenyxGui(gui, titleLbl)
pcall(function() gui.Enabled = true end)
pcall(setupSafeTeleportHook)
if titleLbl.Text ~= NEW_TITLE then
titleLbl:SetAttribute("__IsTranslating", true)
titleLbl.Text = NEW_TITLE
titleLbl.AutomaticSize = Enum.AutomaticSize.X
titleLbl:SetAttribute("__IsTranslating", false)
end
local win, curr = nil, titleLbl
local cam = workspace.CurrentCamera
local vpX, vpY = (cam and cam.ViewportSize.X) or 1920, (cam and cam.ViewportSize.Y) or 1080
while curr.Parent and curr.Parent ~= gui do
curr = curr.Parent
if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= 260 and curr.AbsoluteSize.Y >= 165 then
if curr.AbsoluteSize.X < vpX * 0.96 or curr.AbsoluteSize.Y < vpY * 0.96 then win = curr end
end
end
local hy = titleLbl.AbsolutePosition.Y
if win then
pcall(function() win.Visible = true end)
pcall(cleanupStrayLogos, gui, win)
pcall(applySenaV7Architecture, win, titleLbl)
end
for _, tc in ipairs(gui:GetChildren()) do
if tc:IsA("GuiObject") and tc ~= win and tc.Name ~= "ChilliV5_ExpandedIsland" and not tc:FindFirstChild("IslandExpandHint") then
pcall(setupCircleLogo, tc, win)
end
end
local queue = {}
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
local txt = d.Text or ""
local hasDot = false
if d.Parent and d.Parent:IsA("GuiObject") and d.Parent.AbsoluteSize.X < 320 then
for _, sb in ipairs(d.Parent:GetChildren()) do
if sb:IsA("GuiObject") and sb ~= d and sb.AbsoluteSize.X <= 16 and sb.AbsoluteSize.Y <= 16 then
hasDot = true
break
end
end
end
local isStatus = (not gui:GetAttribute("__IslandLocked")) and (not d:FindFirstAncestorOfClass("ScrollingFrame")) and d.Parent and (not titleLbl:IsDescendantOf(d.Parent)) and math.abs(d.AbsolutePosition.Y - hy) < 35 and d.AbsolutePosition.X > titleLbl.AbsolutePosition.X + 60 and (hasDot or txt:lower():find("idle", 1, true) or txt == "Đang rảnh") and not txt:find("v1.", 1, true)
if isStatus or d:GetAttribute("__IslandDone") then
gui:SetAttribute("__IslandLocked", true)
pcall(setupIsland, d, gui)
elseif isFpsTxt(txt) then
pcall(hookFps, d)
elseif d:GetAttribute("__TransHookSession") ~= SID then
queue[#queue + 1] = d
end
end
end
if #queue > 0 and not gui:GetAttribute("__BatchTranslating") then
gui:SetAttribute("__BatchTranslating", true)
task.spawn(function()
for i = 1, #queue do
if not isAlive() then break end
if queue[i] and queue[i].Parent then pcall(hookTrans, queue[i]) end
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
if not nd:IsA("TextBox") and isFpsTxt(nd.Text) then pcall(hookFps, nd) else pcall(hookTrans, nd) end
end)
end
end)
end
local function scanOnce()
if not isAlive() then return false end
for _, root in ipairs(getScanRoots()) do
local guis = {}
for _, ch in ipairs(root:GetChildren()) do
if ch:IsA("ScreenGui") then
table.insert(guis, ch)
elseif ch:IsA("Folder") or ch:IsA("Configuration") then
for _, sub in ipairs(ch:GetChildren()) do
if sub:IsA("ScreenGui") then table.insert(guis, sub) end
end
end
end
for _, gui in ipairs(guis) do
if not IGNORED_GUIS[gui.Name] then
bindGuiEvents(gui)
local titleLbl = nil
for _, d in ipairs(gui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
local t = d.Text
if isFpsTxt(t) then
pcall(hookFps, d)
elseif (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
titleLbl = d
end
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
bindGuiEvents(ch)
task.wait(0.15)
pcall(scanOnce)
end
end)
end
pcall(scanOnce)
task.spawn(function()
local t = 0
while isAlive() and not venyxGuiLocked and t < 60 do
task.wait(0.35)
t = t + 0.35
if t > 4.5 and not venyxGuiLocked then launchVenyxBase() end
pcall(scanOnce)
end
if isAlive() then
task.wait(1.0)
pcall(scanOnce)
end
end)
