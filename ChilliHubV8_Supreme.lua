-- ============================================================================
-- CHILLI HUB V8 SUPREME | ZERO-DELAY BOOT & SLIM SIDEBAR EDITION
-- ============================================================================
local NEW_TITLE = "Chilli Hub V8"
local LOGO_ID = "rbxassetid://74441610995894"
local HEADER_BAR_IMG_ID = "rbxassetid://83726521558450"
local STEAL_TAB_ICON_ID = "rbxassetid://91536384271341"
local WALLPAPER_IMAGE_ID = "rbxassetid://90615151648668"
local c3, u2, u2s, v2, csk = Color3.fromRGB, UDim2.new, UDim2.fromScale, Vector2.new, ColorSequenceKeypoint.new
local LOGO_BG, BLACK_BG = c3(12, 12, 18), c3(8, 8, 12)
local MY_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local VENYX_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local AUTO_FILE, LANG_FILE = "ChilliHubV5_AutoRun.lua", "ChilliV5_Lang.txt"
local PRESET_JSON = [=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":true,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":false,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]
if isfile and delfile then
pcall(function()
if isfile(AUTO_FILE) then delfile(AUTO_FILE) end
end)
end
task.spawn(function()
pcall(function()
if setfpscap then pcall(setfpscap, 120) end
pcall(function() game:GetService("RunService"):Set3dRenderingEnabled(true) end)
local lgt = game:GetService("Lighting")
lgt.GlobalShadows = false
lgt.FogEnd = 9e9
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
pcall(function()
local cp = game:GetService("ContentProvider")
local pre = {}
for _, id in ipairs({ LOGO_ID, HEADER_BAR_IMG_ID, STEAL_TAB_ICON_ID, WALLPAPER_IMAGE_ID }) do
local im = Instance.new("ImageLabel")
im.Image = id
table.insert(pre, im)
end
cp:PreloadAsync(pre)
for _, im in ipairs(pre) do im:Destroy() end
end)
end)
local function safeHttpGet(url)
local ok1, res1 = pcall(function() return game:HttpGet(url) end)
if ok1 and type(res1) == "string" and #res1 > 10 then return res1 end
local ok2, res2 = pcall(function() return game:HttpGet(url, true) end)
if ok2 and type(res2) == "string" and #res2 > 10 then return res2 end
local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
if req then
local rOk, rRes = pcall(req, { Url = url, Method = "GET" })
if rOk and rRes and type(rRes.Body) == "string" and #rRes.Body > 10 then return rRes.Body end
end
return nil
end
local env = (getgenv and getgenv()) or _G
env.__ChilliV5State = env.__ChilliV5State or {
SessionId = 0, Language = "VI", ActiveHub = "CHILLI", ActiveGradients = {},
TrackedTexts = {}, TrackedFpsLabels = {}, 
NoticeShown = false, StartClock = os.clock()
}
local State = env.__ChilliV5State
State.SessionId = (State.SessionId or 0) + 1
State.ActiveHub = "CHILLI"
State.CloseHideUntil = nil
State.StartClock = State.StartClock or os.clock()
State.JoiningLeastServerBusy = false
State.ScanningFinderBusy = false
State.MacroBusy = false
State.TrackedFinderJoinBtns = {}
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
local r, seen = {}, {}
local function addRoot(inst)
if inst and not seen[inst] then
seen[inst] = true
table.insert(r, inst)
end
end
if gethui then
pcall(function() addRoot(gethui()) end)
end
addRoot(CoreGui)
local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
addRoot(pg)
return r
end
local IGNORED_GUIS = {
RobloxGui=true, TopBarApp=true, TouchGui=true, Chat=true, BubbleChat=true,
Freecam=true, BackpackGui=true, PlayerList=true, PurchasePrompt=true,
ChilliV5_NoticeGui=true, ChilliV8_MasterIslandGui=true, CoreScriptsRootProvider=true,
ExperienceChat=true, SettingsClippingShield=true, InGameMenu=true, TeleportGui=true,
RobloxNetworkPauseNotification=true
}
local function isVenyxScreenGui(gui)
if not gui or not gui:IsA("ScreenGui") or IGNORED_GUIS[gui.Name] then return false end
if gui == State.ActiveVenyxGui or gui:GetAttribute("__IsChilliVenyxGui") or gui:GetAttribute("__ChilliV8Patched") or gui:GetAttribute("__ChilliV7Patched") then
return true
end
if gui:GetAttribute("__IsChilliFinderGui") then return false end
local lastChk = gui:GetAttribute("__VenyxCheckClock")
if lastChk and (os.clock() - lastChk < 2.0) then return false end
gui:SetAttribute("__VenyxCheckClock", os.clock())
for _, d in ipairs(gui:GetDescendants()) do
if d.Name == "ChilliHeaderOverlay" or d.Name == "ChilliProWindowStroke" or d.Name == "ChilliCircleDisc" or d.Name == "ChilliUltraBadgePill" then
gui:SetAttribute("__IsChilliVenyxGui", true)
return true
end
if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d:FindFirstAncestorOfClass("ScrollingFrame") then
local t = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
if t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |" then
gui:SetAttribute("__IsChilliVenyxGui", true)
return true
end
end
end
return false
end

local function isVenyxUiPresent()
for _, root in ipairs(getScanRoots()) do
for _, ch in ipairs(root:GetChildren()) do
if ch:IsA("ScreenGui") and not IGNORED_GUIS[ch.Name] and ch.Enabled ~= false then
for _, d in ipairs(ch:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local t = d.Text
if (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
local top = d
while top.Parent and top.Parent ~= ch do top = top.Parent end
if top and (top:GetAttribute("__SizeLockedV5Pro") or top:FindFirstChild("ChilliCircleDisc")) then
pcall(function() ch:Destroy() end)
else
return true
end
end
end
end
end
end
end
return false
end
local function setupSafeTeleportHook()
local rq = env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport or queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (delta and delta.queue_on_teleport)
if not rq then return end
env.__ChilliOrigQueue = rq
local clearQ = env.clearteleportqueue or env.clear_teleport_queue or clearteleportqueue or clear_teleport_queue or (syn and syn.clear_teleport_queue) or (fluxus and fluxus.clear_teleport_queue) or (delta and delta.clear_teleport_queue)
local boot = '--[[CHILLI_V8_AUTHORIZED_TELEPORT]] local E=(getgenv and getgenv()) or _G E.__ChilliAllowVenyxFetch=false task.spawn(function() if not game:IsLoaded() then game.Loaded:Wait() end local P=game:GetService("Players") while not P.LocalPlayer do task.wait(0.05) end pcall(function() loadstring(game:HttpGet("'..MY_URL..'"))() end) end)'
local safeLock = function(c)
pcall(function()
if tostring(c or ""):find("CHILLI_V8_AUTHORIZED_TELEPORT", 1, true) then
rq(c)
else
if clearQ then pcall(clearQ) end
if env.__ChilliBootQueuedSession ~= SID then
env.__ChilliBootQueuedSession = SID
rq(boot)
end
end
end)
end
pcall(function()
if clearQ then pcall(clearQ) end
env.queue_on_teleport = safeLock
env.queueonteleport = safeLock
_G.queue_on_teleport = safeLock
_G.queueonteleport = safeLock
if env.__ChilliBootQueuedSession ~= SID then
env.__ChilliBootQueuedSession = SID
pcall(rq, boot)
end
if not env.__ChilliOnTpHooked and LocalPlayer then
env.__ChilliOnTpHooked = true
LocalPlayer.OnTeleport:Connect(function()
pcall(function()
if clearQ then pcall(clearQ) end
pcall(rq, boot)
end)
end)
end
end)
end
local function launchVenyxBase()
if isVenyxUiPresent() then return end
if env.__VenyxLaunchingNow and (os.clock() - (env.__VenyxLaunchClock or 0) < 6) then return end
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
pcall(setupSafeTeleportHook)
end)
end
for _, root in ipairs(getScanRoots()) do
root.ChildAdded:Connect(function(ch)
if not isAlive() then return end
if ch:IsA("ScreenGui") and not IGNORED_GUIS[ch.Name] then
task.defer(function()
if not isAlive() or not ch or not ch.Parent then return end

end)
end
end)
end
launchVenyxBase()
local function mk(cls, props, parent)
local inst = Instance.new(cls)
for k, v in pairs(props) do inst[k] = v end
if parent then inst.Parent = parent end
return inst
end
local function addGrad(g)
if g then
pcall(function() g.Rotation = 35 end)
end
return g
end
local RAINBOW = ColorSequence.new({
csk(0.00, c3(255, 45, 85)), csk(0.17, c3(255, 155, 35)), csk(0.33, c3(255, 235, 45)),
csk(0.50, c3(45, 255, 145)), csk(0.67, c3(45, 195, 255)), csk(0.83, c3(185, 85, 255)), csk(1.00, c3(255, 45, 85))
})
local ULTRA_TEXT_GRAD = ColorSequence.new({
csk(0.00, c3(255, 255, 255)), csk(0.20, c3(125, 225, 255)), csk(0.45, c3(255, 95, 215)),
csk(0.72, c3(175, 115, 255)), csk(1.00, c3(255, 215, 85))
})
local ULTRA_CARD_GRAD = ColorSequence.new({
csk(0.00, c3(70, 210, 255)), csk(0.50, c3(170, 95, 255)), csk(1.00, c3(255, 75, 195))
})
local LIQUID_TEXT_GRAD = ColorSequence.new({
csk(0.00, c3(250, 253, 255)), csk(0.35, c3(185, 232, 255)),
csk(0.70, c3(225, 215, 255)), csk(1.00, c3(250, 253, 255))
})
local LIQUID_GLASS_COLOR = ColorSequence.new({
csk(0.00, c3(145, 190, 235)), csk(0.20, c3(22, 30, 48)),
csk(0.78, c3(12, 16, 28)), csk(1.00, c3(48, 82, 132))
})
local LIQUID_GLASS_TRANS = NumberSequence.new({
NumberSequenceKeypoint.new(0.00, 0.18),
NumberSequenceKeypoint.new(0.22, 0.28),
NumberSequenceKeypoint.new(0.78, 0.26),
NumberSequenceKeypoint.new(1.00, 0.20)
})
local GREEN_COLOR = Color3.fromRGB(50, 255, 100)
local currentFakeFps = math.random(80, 120)
local currentFakeMs = math.random(15, 80)

local function getFakeFps()
return currentFakeFps
end

local function getLivePing()
return currentFakeMs
end

local function isFpsTxt(t)
if type(t) ~= "string" then return false end
local clean = t:gsub("<[^>]+>", ""):lower()
if #clean > 65 then return false end
return (clean:find("fps", 1, true) ~= nil and (clean:find("ms", 1, true) ~= nil or clean:find("ping", 1, true) ~= nil))
end

local function ensureStandaloneNeonFpsGui()
pcall(function()
for _, root in ipairs(getScanRoots()) do
local oldG = root:FindFirstChild("ChilliV8_NeonFpsPillGui")
if oldG then oldG:Destroy() end
end
end)
return nil
end

local function formatFpsPingText()
return string.format("%d FPS  -  %d ms", currentFakeFps, currentFakeMs)
end

local function hookFps(lbl)
if not lbl or not (lbl:IsA("TextLabel") or lbl:IsA("TextButton")) then return end
State.TrackedFpsLabels[lbl] = true
pcall(function()
local p = lbl.Parent
if p and p:IsA("GuiObject") then
p.Visible = true
for _, ch in ipairs(p:GetChildren()) do
if (ch:IsA("TextLabel") or ch:IsA("TextButton")) and ch ~= lbl then
ch.Visible = false
ch.TextTransparency = 1
end
end
end
lbl:SetAttribute("__UpdatingFps", true)
lbl.RichText = false
lbl.Visible = true
lbl.TextTransparency = 0
lbl.Font = Enum.Font.GothamBold
lbl.TextColor3 = GREEN_COLOR
lbl.Text = formatFpsPingText()
lbl:SetAttribute("__UpdatingFps", false)

if lbl:GetAttribute("__FpsHookSession") ~= SID then
lbl:SetAttribute("__FpsHookSession", SID)
lbl:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive() or lbl:GetAttribute("__UpdatingFps") then return end
lbl:SetAttribute("__UpdatingFps", true)
lbl.TextColor3 = GREEN_COLOR
lbl.Text = formatFpsPingText()
lbl:SetAttribute("__UpdatingFps", false)
end)
lbl:GetPropertyChangedSignal("TextColor3"):Connect(function()
if not isAlive() or lbl:GetAttribute("__UpdatingFps") then return end
if lbl.TextColor3 ~= GREEN_COLOR then
lbl:SetAttribute("__UpdatingFps", true)
lbl.TextColor3 = GREEN_COLOR
lbl:SetAttribute("__UpdatingFps", false)
end
end)
end
end)
end

local function scanForFpsPills()
local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
for _, root in ipairs(getScanRoots()) do
if root ~= pg then
for _, ch in ipairs(root:GetChildren()) do
if ch.Name == "RobloxGui" then
for _, sub in ipairs(ch:GetChildren()) do
if not IGNORED_GUIS[sub.Name] then
for _, d in ipairs(sub:GetDescendants()) do
if d:IsA("TextLabel") and isFpsTxt(d.Text) then
pcall(hookFps, d)
end
end
end
end
elseif not IGNORED_GUIS[ch.Name] then
for _, d in ipairs(ch:GetDescendants()) do
if d:IsA("TextLabel") and isFpsTxt(d.Text) then
pcall(hookFps, d)
end
end
end
end
end
end
end

-- Vòng lặp task.spawn cập nhật ngẫu nhiên mỗi 1 giây (FPS: 80-120, Ping: 15-80ms), toàn bộ chữ màu xanh lá RGB(50, 255, 100)
task.spawn(function()
pcall(ensureStandaloneNeonFpsGui)
pcall(scanForFpsPills)
while isAlive() do
currentFakeFps = math.random(80, 120)
currentFakeMs = math.random(15, 80)
local txtNow = formatFpsPingText()
for lbl in pairs(State.TrackedFpsLabels) do
if lbl and lbl.Parent then
pcall(function()
lbl:SetAttribute("__UpdatingFps", true)
lbl.Visible = true
lbl.TextTransparency = 0
lbl.TextColor3 = GREEN_COLOR
lbl.Text = txtNow
lbl:SetAttribute("__UpdatingFps", false)
end)
else
State.TrackedFpsLabels[lbl] = nil
end
end
task.wait(1)
end
end)
local FastCache = {}
local function hasVi(s)
return type(s) == "string" and s ~= "" and (s:find("\225[\186\187][\128-\191]") ~= nil or s:find("\195[\128-\191]") ~= nil or s:find("\196[\130\131\144\145\168\169]") ~= nil or s:find("\197[\168\169\175\176]") ~= nil)
end
-- ============================================================================
-- [PHẦN 2] BỘ TỪ ĐIỂN & ĐỘNG CƠ DỊCH THUẬT TIẾNG VIỆT THỜI GIAN THỰC
-- ============================================================================
local EXACT_VI = {
-- Nhãn Song Ngữ Cho Các Tab Chính
["Home"] = "Trang Chủ",
["Dashboard"] = "Trang Chủ",
["Steal"] = "Săn Trứng",
["Farm"] = "Tự Cày",
["Event"] = "Sự Kiện",
["Events"] = "Sự Kiện",
["Player"] = "Nhân Vật",
["System"] = "Cài Đặt",
["Settings"] = "Cài Đặt",
-- Các mục trong tab Sự Kiện & Halloween (v1.4.5)
["Halloween & Shooting Star"] = "Halloween & Sao Băng",
["Halloween & sao băng"] = "Halloween & Sao Băng",
["HALLOWEEN & SHOOTING STAR"] = "HALLOWEEN & SAO BĂNG",
["HALLOWEEN & SAO BĂNG"] = "HALLOWEEN & SAO BĂNG",
["The Hollow"] = "Vực Hollow",
["Hollow"] = "Vực Hollow",
["Steal missing Halloween index"] = "Cướp trứng Halloween thiếu trong Chỉ mục",
["Steal missing Halloween index eggs"] = "Cướp trứng Halloween thiếu trong Chỉ mục",
["cướp missing Halloween index"] = "Cướp trứng Halloween thiếu trong Chỉ mục",
["Place eggs in pen and hatch missing in Egg Index"] = "Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",
["Place and hatch eggs missing from your Egg Index"] = "Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",
["Đặt trứng vào chuồng và hatch thiếu trong Chỉ mục trứng"] = "Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",
["PUMPKIN BOSS"] = "BOSS BÍ NGÔ",
["Pumpkin Boss"] = "Boss Bí Ngô",
["Auto Pumpkin Boss"] = "Tự đánh Boss Bí Ngô",
["Auto dodge attacks"] = "Tự động né đòn đánh",
["Dodge attacks"] = "Tự động né đòn đánh",
["Auto claim mastery"] = "Tự động nhận thưởng Thông Thạo",
["Tự động nhận mastery"] = "Tự động nhận thưởng Thông Thạo",
["Claim mastery"] = "Nhận thưởng Thông Thạo",
["Mastery"] = "Thông Thạo",
["MASTERY"] = "THÔNG THẠO",
["Stub pickup speed"] = "Tốc độ nhặt Cuống Bí Ngô",
["Pickup speed"] = "Tốc độ nhặt vật phẩm",
["Tốc độ cuống pickup"] = "Tốc độ nhặt Cuống Bí Ngô",
["Auto manor key"] = "Tự lấy chìa khóa dinh thự",
["Manor key"] = "Chìa khóa dinh thự",
["MANOR KEY"] = "CHÌA KHÓA DINH THỰ",
["KILLS"] = "SỐ LẦN HẠ",
["Kills"] = "Số lần hạ",
["BOSS"] = "TRÙM (BOSS)",
["ALIVE"] = "CÒN SỐNG",
["Alive"] = "Còn sống",
["DEAD"] = "Đã hạ",
["Dead"] = "Đã hạ",
["SPAWNED"] = "ĐÃ XUẤT HIỆN",
["Spawned"] = "Đã xuất hiện",
["NOT SPAWNED"] = "CHƯA XUẤT HIỆN",
["Not spawned"] = "Chưa xuất hiện",
["Cooldown"] = "Đang hồi",
["COOLDOWN"] = "ĐANG HỒI",
["Active"] = "Đang bật",
["ACTIVE"] = "ĐANG BẬT",
["Inactive"] = "Đang tắt",
["INACTIVE"] = "ĐANG TẮT",
-- Đổi tên Chilli Finder Free
["Sign In"] = "Miễn phí",
["Sign in"] = "Miễn phí",
["SIGN IN"] = "MIỄN PHÍ",
["Sign trong"] = "Miễn phí",
["Sign Up"] = "Đăng ký",
["Sign up"] = "Đăng ký",
["No plan"] = "Miễn phí",
["No Plan"] = "Miễn phí",
["FORCE JOIN"] = "TỰ VÀO SAU",
["Force Join"] = "Tự vào sau",
["MIN VALUE"] = "GIÁ TỐI THIỂU",
["RARITY"] = "ĐỘ HIẾM",
["ACCOUNT"] = "TÀI KHOẢN",
["Account"] = "Tài khoản",
["Chilli Finder"] = "Chilli Finder Free",
["Chill Finder Free"] = "Chilli Finder Free",
["Chilli Finder Free"] = "Chilli Finder Free",
["Top 5 recent eggs | Book at chillihub.pro"] = "Top 5 trứng mới nhất | Chilli Finder Free",
["Sign in with your chillihub.pro account to join"] = "Top 5 trứng mới nhất | Chilli Finder Free",
["Sign in with your chillihub.pro account"] = "Top 5 trứng mới nhất | Chilli Finder Free",
["No active booking. Book hours at chillihub.pro"] = "Top 5 trứng mới nhất | Chilli Finder Free",

["Finder"] = "Tìm Trứng",
["FINDER"] = "TÌM TRỨNG",
["finder"] = "tìm trứng",
["Scanning..."] = "Đang quét...",
["Scanning"] = "Đang quét...",
["Searching..."] = "Đang tìm...",
["Searching"] = "Đang tìm...",
["Checking..."] = "Đang kiểm tra...",
["Checking"] = "Đang kiểm tra...",
["Found!"] = "Đã thấy!",
["Found"] = "Đã thấy",
["Egg Found!"] = "Có trứng mới!",
["Egg Found"] = "Có trứng mới",
["Waiting..."] = "Đang chờ...",
["Waiting"] = "Đang chờ...",
["No Eggs"] = "Hết trứng",
["No eggs"] = "Hết trứng",
["None"] = "Không có",
["Auto On"] = "Tự động: BẬT",
["Auto Off"] = "Tự động: TẮT",
["AUTO ON"] = "TỰ ĐỘNG: BẬT",
["AUTO OFF"] = "TỰ ĐỘNG: TẮT",
["Ready"] = "Sẵn sàng",

["Chilli Finder"]="Chill Finder Free",
["Top 5 recent eggs | Book at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",
["Sign in with your chillihub.pro account to join"]="Top 5 recent eggs | Chill Finder Free",
["Sign in with your chillihub.pro account"]="Top 5 recent eggs | Chill Finder Free",
["No active booking. Book hours at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",
["Venyx"]="Chilli Hub", ["VENYX"]="Chilli Hub V8 Supreme",
["Media"]="Mạng Xã Hội", ["Chat"]="Trò Chuyện", ["Features"]="Tính Năng",
["Egg"]="Trứng (Egg)", ["Pet"]="Thú Cưng (Pet)", ["Activities"]="Hoạt Động",
["Barn"]="Chuồng Trại", ["Others"]="Khác", ["Keyless"]="Không cần Key",
["Anime"]="Chế độ Anime", ["Search..."]="Tìm kiếm...",
["Steal Egg"]="Cướp Trứng", ["Filtering"]="Bộ Lọc", ["Strict Filter"]="Lọc Nghiêm Ngặt",
["Only target eggs that match every filter you set."]="Chỉ cướp trứng khớp với mọi bộ lọc bạn đã cài.",
["Steal Priority"]="Ưu Tiên Cướp", ["Select Area"]="Chọn Khu Vực", ["Select Rarity"]="Chọn Độ Hiếm",
["Select Pet"]="Chọn Thú Cưng", ["Select Mutation"]="Chọn Đột Biến", ["Min Value"]="Giá Trị Tối Thiểu",
["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."]="Chỉ cướp trứng kiếm được ít nhất mức này mỗi giây (VD: 500k, 1.5m). Nhập 0 để tắt.",
["Indexing"]="Chỉ Mục (Index)", ["Auto Claim Index"]="Tự Nhận Thưởng Chỉ Mục",
["Redeems unlocked index rewards."]="Tự động nhận phần thưởng từ danh mục đã mở khóa.",
["Auto Indexing"]="Tự Động Thu Thập Chỉ Mục",
["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."]="Chỉ cướp các trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",
["Steal Settings"]="Cài Đặt Cướp", ["Steal Mode"]="Chế Độ Cướp",
["Normal flies to the egg, Instant Steal works in every area."]="Bình thường sẽ bay tới trứng. Cướp Tức Thì hoạt động ở mọi khu vực.",
["Normal"]="Bình Thường", ["Delivery Mode"]="Chế Độ Giao Trứng",
["Recommended Delivery Mode: Speed Match or Steady"]="Khuyên dùng: Tốc độ khớp hoặc Ổn định",
["Speed Match"]="Tốc độ khớp", ["Steady"]="Ổn định", ["Steal From Player"]="Cướp Từ Người Chơi",
["Steals eggs from other players."]="Cướp trứng từ tay người chơi khác.",
["Server Hop (No Target)"]="Đổi Server (Khi Hết Mục Tiêu)",
["Hops server when no target is found."]="Tự động đổi máy chủ khi không tìm thấy trứng mục tiêu.",
["Drop for Friend"]="Nhặt Hộ Bạn Bè",
["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."]="Mang trứng đến điểm hẹn, thả xuống cho bạn bè nhặt và đi tìm trứng khác.",
["Flies to field eggs, grabs them and brings them home."]="Bay tới bãi, nhặt trứng và mang về nhà.",
["Steal Other Script"]="Cướp Của Script Khác",
["Grabs eggs other players drop near safezone."]="Nhặt trứng mà các người chơi dùng script khác làm rớt gần vùng an toàn.",
["Steal Status"]="Trạng Thái Cướp", ["Shows the Auto Steal status panel."]="Hiển thị bảng trạng thái tự động cướp.",
["Open Steal Panel"]="Mở Bảng Cướp Trứng", ["Find and steal World and Halloween eggs by hand."]="Tìm và cướp trứng Thế Giới / Halloween bằng tay.",
["Open Steal History"]="Mở Lịch Sử Cướp", ["Open the last 10 steal results in a separate window."]="Mở 10 kết quả cướp gần nhất ở cửa sổ riêng.",
["Egg Utilities"]="Tiện Ích Trứng", ["Open Egg Predictor"]="Mở Dự Đoán Trứng",
["Open standalone egg cycle predictor window."]="Mở cửa sổ dự đoán chu kỳ trứng riêng biệt.",
["Egg Inventory Value"]="Giá Trị Trứng Trong Túi",
["Show generation rate (/s) and sell price on backpack egg slots."]="Hiển thị tốc độ sinh tiền (/s) và giá bán trên từng ô trứng trong ba lô.",
["Place Egg"]="Đặt Trứng Vào Chuồng", ["Hatch Egg"]="Ấp Trứng", ["Stop At Rarity"]="Dừng Lại Ở Độ Hiếm",
["Eggs of this rarity or higher won't be placed."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi đặt.",
["Eggs of this rarity or higher won't be hatched."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi ấp.",
["Whitelist"]="Danh Sách Trắng (Ưu Tiên)", ["Blacklist"]="Danh Sách Đen (Bỏ Qua)",
["Whitelist Rarity"]="Ưu Tiên Độ Hiếm", ["Whitelist Pet"]="Ưu Tiên Thú Cưng", ["Whitelist Mutation"]="Ưu Tiên Đột Biến",
["Blacklist Rarity"]="Bỏ Qua Độ Hiếm", ["Blacklist Pet"]="Bỏ Qua Thú Cưng", ["Blacklist Mutation"]="Bỏ Qua Đột Biến",
["Auto Place Egg"]="Tự Động Đặt Trứng",
["Places matching eggs from your bag into the pen. Whitelist picks which eggs, blacklist always blocks."]="Đặt trứng phù hợp từ túi vào chuồng. Ưu tiên các mục trong Whitelist, luôn chặn mục trong Blacklist.",
["Auto Place Indexing"]="Tự Động Đặt Lấy Chỉ Mục",
["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."]="Chỉ tự động đặt các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist và Blacklist.",
["Automatically hatch ready eggs matching the selected filters."]="Tự động ấp các trứng đã sẵn sàng và khớp với bộ lọc.",
["Auto Hatch Indexing"]="Tự Động Ấp Lấy Chỉ Mục",
["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."]="Chỉ ấp các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist, vẫn áp dụng Blacklist.",
["Sell Egg"]="Bán Trứng", ["Keep Above"]="Giữ Lại Trên Mức",
["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."]="Không bao giờ bán trứng kiếm được trên mức này mỗi giây (VD: 100m). Nhập 0 để tắt.",
["Sells eggs that pass your filters. Placed eggs are never sold."]="Bán trứng lọt qua bộ lọc. Trứng đã đặt trong chuồng sẽ không bao giờ bị bán.",
["Sell On Inventory Full"]="Chỉ Bán Khi Đầy Túi", ["Only sell when your egg backpack is full."]="Chỉ kích hoạt bán khi ba lô chứa trứng đã đầy.",
["Player Stats"]="Thống Kê Người Chơi", ["Money"]="Tiền", ["Gems"]="Đá Quý", ["Equipped"]="Đang Trang Bị",
["Gain"]="Tăng Tốc Độ", ["Inventory"]="Túi Đồ", ["Map"]="Bản Đồ", ["World"]="Thế Giới",
["Discord webhook URL for sending notifications."]="Đường dẫn Webhook Discord để gửi thông báo.",
["Ping @everyone"]="Tag @everyone", ["Mention @everyone in Discord when a new egg is claimed."]="Gắn thẻ @everyone trên Discord khi nhận được trứng mới.",
["Egg Webhook"]="Webhook Trứng", ["Select Egg Rarity"]="Chọn Độ Hiếm Của Trứng",
["Enable New Egg Claimed"]="Bật Thông Báo Trứng Mới", ["Send webhook notification when stealing/claiming a new egg."]="Gửi thông báo Webhook khi cướp/nhận được trứng mới.",
["Player Webhook"]="Webhook Người Chơi", ["Stats Interval (Min)"]="Khoảng Thời Gian Báo Thống Kê (Phút)",
["Enable Player Stats"]="Bật Thông Báo Thống Kê", ["Periodically send player stats to Discord."]="Định kỳ gửi thông số người chơi qua Discord.",
["Test Webhook"]="Thử Nghiệm Webhook", ["Send Stats Now"]="Gửi Thống Kê Ngay Lúc Này",
["Immediately send stats to Discord."]="Gửi ngay thông số người chơi vào Discord.",
["Test Egg Webhook"]="Gửi Thử Webhook Trứng", ["Simulate claiming an egg."]="Mô phỏng thao tác nhận trứng để kiểm tra.",
["Admin Abuse Boost (BETA)"]="Nhận Buff Quyền Admin (BETA)", ["Halloween Dimension"]="Không Gian Halloween",
["Ghost Dog Quest"]="Nhiệm Vụ Chó Ma", ["Abandoned Manor"]="Dinh Thự Bỏ Hoang",
["Pumpkin King"]="Vua Bí Ngô", ["The Hollow"]="Vực Hollow", ["just now"]="vừa xong", ["Just now"]="Vừa xong",
["Inventory values"]="Giá trị túi đồ", ["Inventory Values"]="Giá trị túi đồ",
["Find option"]="Tìm tùy chọn", ["🔍 Find option"]="🔍 Tìm tùy chọn",
["Tip: you can also hold any feature to pin it or set a key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",
["Tip: you can also hold any feature to pin it or set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",
["Tip: you can also hold any feature to pin it hoặc set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",
["v1.4.2: Fixed some bugs"]="v1.4.2: Đã sửa một số lỗi vặt", ["v1.4.2: fixed some bugs"]="v1.4.2: Đã sửa một số lỗi vặt", ["v1.4.2: đã sửa some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",
["v1.4.1: Movement speed up to 110%, improved Fast Tween"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",
["v1.4.1: Di Chuyển tốc độ up tới 110%, improved Fast Bay (Tween)"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",
["v1.4.0: Auto Pumpkin Boss (dodges attacks, fires cannons, collects Pumpkin Stubs), auto manor key, and Go to Egg Leap (replaces old Go to Egg)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",
["v1.4.0: tự động bí ngô Boss (dodges attacks, fires cannons, collects bí ngô Stubs), tự động manor key, và Di Chuyển tới trứng Leap (replaces old Di Chuyển tới trứng)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",
["v1.3.0: Anti guard fires again, and finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",
["v1.3.0: Anti vệ sĩ fires again, và finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",
["Go to Egg Leap"]="Nhảy Tới Trứng", ["Go to egg leap"]="Nhảy tới trứng", ["Manor key"]="Chìa khóa dinh thự", ["Auto manor key"]="Tự lấy chìa khóa dinh thự",
["Auto Pumpkin Boss"]="Tự đánh Boss Bí Ngô", ["Pumpkin Boss"]="Boss Bí Ngô", ["Pumpkin Stubs"]="Cuống Bí Ngô",
["Going into the Halloween Dimension"]="Đang vào Không gian Halloween", ["Going into Halloween Dimension"]="Đang vào Không gian Halloween",
["Leaving Halloween Dimension"]="Đang rời Không gian Halloween", ["Entering Halloween Dimension"]="Đang vào Không gian Halloween",
["v1.2.9: New optimizer modes: Balanced, Strong (way much higher FPS, ultra-low GPU), no lag spike when you turn it on"]="v1.2.9: Chế độ tối ưu mới: Cân bằng, Mạnh (tăng FPS cực cao, siêu nhẹ GPU), không bị khựng lag khi bật",
["v1.2.8: Inventory values, see how much every pet and every egg in your backpack is worth"]="v1.2.8: Giá trị túi đồ, xem giá trị của từng pet và từng quả trứng trong ba lô",
["v1.2.7: Auto race The Hollow"]="v1.2.7: Tự động đua sự kiện The Hollow",
["v1.2.7: Auto race Hollow"]="v1.2.7: Tự động đua sự kiện Hollow", ["Auto race Hollow"]="Tự động đua sự kiện Hollow",
["Balanced"]="Cân bằng", ["Strong"]="Mạnh",
["v1.2.6: Mutate eggs you choose with multiple mutations, much shorter delay between tasks and instant take back when someone grabs your egg"]="v1.2.6: Đột biến trứng tự chọn với nhiều đột biến, giảm độ trễ giữa các tác vụ và giật lại tức thì khi bị cướp",
["v1.2.5: Teleport to egg"]="v1.2.5: Dịch chuyển tới trứng",
["Riding the Phantom Express"]="Đang đi Tàu Bóng Ma", ["Fighting Small monster"]="Đang đánh quái vật nhỏ", ["Fighting Medium monster"]="Đang đánh quái vật vừa", ["Fighting Large monster"]="Đang đánh quái vật lớn",
["UI scale"]="Kích cỡ Menu", ["Show / hide UI"]="Phím ẩn / hiện Menu", ["Opacity"]="Độ trong suốt", ["Tone"]="Tông màu", ["Dim the game"]="Làm tối nền game",
["QUICK BARS"]="THANH PHÍM TẮT NHANH", ["Quick bars"]="Thanh phím tắt nhanh", ["Show quick bars"]="Hiện thanh phím tắt nhanh", ["Keybinds"]="Phím tắt", ["Bar size"]="Kích cỡ thanh nhanh",
["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT", ["Find option"]="Tìm tùy chọn", ["All"]="Tất cả", ["Pinned"]="Đã ghim", ["Clear all quick bars"]="Xóa hết thanh nhanh", ["Clear all keybinds"]="Xóa hết phím tắt",
["DEFAULTS"]="MẶC ĐỊNH", ["Reset to defaults"]="Khôi phục mặc định", ["Reset"]="Đặt lại", ["Turn off all toggles"]="Tắt toàn bộ công tắc", ["Turn off"]="Tắt hết",
["Steal An Egg"]="Cướp Trứng", ["CANDY CORN"]="KẸO NGÔ", ["Candy Corn"]="Kẹo Ngô", ["Calculate mutations"]="Tính thử đột biến",
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
["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",
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
["Welcome Home"]="Trang Chủ", ["Welcome back"]="Chào mừng trở lại", ["Venyx Discord"]="Chilli Hub Discord",
["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ", ["Copy Invite"]="Chép Link Mời", ["Copy invite"]="Chép Link Mời", ["Copy link"]="Chép Link Mời", ["Discord"]="Chilli Hub", ["MONEY /S"]="TIỀN /GIÂY", ["CASH / S"]="TIỀN / GIÂY",
["OPEN"]="MỞ", ["Open"]="Mở", ["Close"]="Đóng", ["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",
["Beta version"]="Phiên bản Beta", ["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",
["Rejoin"]="Vào lại", ["Server hop"]="Đổi server", ["Copy Job ID"]="Chép Job ID", ["Unload hub"]="Tắt Hub", ["Unload"]="Tắt Hub", ["Save config"]="Lưu cấu hình", ["Hide UI"]="Ẩn Menu",
["SESSION"]="PHIÊN CHƠI", ["STOLEN"]="ĐÃ CƯỚP", ["LAST EGG"]="TRỨNG CUỐI", ["PLACED"]="ĐÃ ĐẶT", ["HATCHED"]="ĐÃ ẤP", ["NIGHT IN"]="ĐÊM SAU", ["NEXT NIGHT"]="ĐÊM SAU",
["SESSION TIME"]="THỜI GIAN", ["TIME"]="THỜI GIAN", ["BEST STEAL"]="CƯỚP TỐT NHẤT", ["EGG BAG"]="TÚI TRỨNG", ["PET BAG"]="TÚI PET", ["WHAT'S NEW"]="CÓ GÌ MỚI", ["NEW"]="MỚI",
["Search"]="Tìm kiếm", ["Filter"]="Lọc tìm", ["Auto Steal"]="Tự Động Cướp", ["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
["Auto steal"]="Tự động cướp", ["Egg Predictor"]="Dự Đoán Trứng", ["Go to egg"]="Di chuyển tới trứng", ["Teleport to egg"]="Dịch chuyển tới trứng",
["Walk to egg"]="Đi bộ tới trứng", ["Tween to egg"]="Bay mượt tới trứng",
["Teleport zones"]="Khu vực dịch chuyển", ["Tween"]="Bay (Tween)", ["Walk"]="Đi bộ", ["Delivery method"]="Cách mang về", ["Instant steps"]="Tức thì từng bước", ["Instant"]="Tức thì", ["Teleport"]="Dịch chuyển",
["Fast tween speed"]="Tốc độ bay nhanh", ["Tween speed"]="Tốc độ bay", ["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục", ["Steal back from players"]="Cướp lại từ người chơi",
["Steal from other players"]="Cướp từ người chơi khác", ["Anti guard"]="Chống vệ sĩ", ["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn", ["FILTER"]="BỘ LỌC",
["Zones"]="Khu vực", ["Steal first"]="Ưu tiên cướp", ["Best value"]="Giá trị cao nhất", ["Lowest value"]="Giá trị thấp nhất", ["Best rarity"]="Độ hiếm cao nhất",
["Best mutation"]="Đột biến tốt nhất", ["Biggest"]="Kích thước to nhất", ["Closest"]="Khoảng cách gần nhất", ["Nearest"]="Gần nhất", ["Mutations"]="Đột biến", ["Rarities"]="Độ hiếm",
["Only these eggs"]="Chỉ những trứng này", ["Min value /s"]="Giá trị tối thiểu /s", ["Max value /s"]="Giá trị tối đa /s",
["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi", ["Keep lab eggs"]="Giữ lại trứng Lab", ["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ",
["Auto hop server"]="Tự đổi máy chủ", ["Auto hop"]="Tự động đổi server", ["Hop now"]="Đổi server ngay", ["First hop after"]="Đổi lần đầu sau", ["Hop when"]="Đổi khi",
["After stealing a match"]="Sau khi cướp đủ trứng lọc", ["No matching egg"]="Không có trứng phù hợp", ["Rare from"]="Độ hiếm từ",
["Hop delay"]="Độ trễ đổi server", ["Only sell eggs below /s"]="Chỉ bán trứng dưới mức /s",
["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG", ["Sort eggs"]="Sắp xếp trứng", ["Preview card"]="Thẻ xem trước", ["Pick one"]="Chọn một mục", ["Pick any"]="Chọn bất kỳ",
["Value"]="Giá trị", ["Rarity"]="Độ hiếm", ["Time left"]="Thời gian còn lại", ["Default"]="Mặc định", ["Clear"]="Xóa chọn", ["Select all"]="Chọn tất cả",
["SIZE"]="KÍCH CỠ", ["WEIGHT"]="CÂN NẶNG", ["READY"]="SẴN SÀNG", ["IN BAG"]="TRONG TÚI", ["GROWING"]="ĐANG LỚN", ["Hatch now"]="Ấp ngay", ["Hold egg"]="Cầm trứng",
["Fly to egg"]="Bay tới trứng", ["Steal egg"]="Cướp trứng", ["Enchanted Forest"]="Rừng Phù Phép", ["Light Dark"]="Sáng Tối", ["Titan Temple"]="Đền Titan",
["Cherry Blossom"]="Hoa Anh Đào", ["Prehistoric"]="Tiền Sử", ["Abyss Ocean"]="Đáy Đại Dương", ["Volcano"]="Núi Lửa", ["Snow"]="Tuyết", ["Jungle"]="Rừng Rậm",
["Desert"]="Sa Mạc", ["Lake"]="Hồ Nước", ["Forest"]="Khu Rừng", ["Silver"]="Bạc", ["Rainbow"]="Cầu Vồng", ["Golden"]="Vàng", ["Fractured"]="Rạn Nứt",
["Scrambled"]="Hỗn Loạn", ["Enchanted"]="Phù Phép", ["Nitro"]="Nitro", ["SCRAMBLED"]="HỖN LOẠN", ["NITRO"]="NITRO", ["FRACTURED"]="RẠN NỨT", ["ENCHANTED"]="PHÙ PHÉP",
["Pen"]="Chuồng Ấp", ["PEN"]="CHUỒNG ẤP", ["Treadmill"]="Máy Tập", ["TREADMILL"]="MÁY TẬP CHẠY", ["Mutate"]="Đột Biến",
["Sell"]="Bán", ["SELL"]="BÁN TỰ ĐỘNG", ["Fuse"]="Dung Hợp", ["FUSE"]="DUNG HỢP", ["Priority"]="Ưu Tiên", ["PRIORITY"]="THỨ TỰ ƯU TIÊN",
["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG", ["Auto place"]="Tự động đặt trứng", ["Place when"]="Đặt khi", ["Always"]="Luôn luôn", ["Place first"]="Ưu tiên đặt",
["KEEP EGGS"]="GIỮ LẠI TRỨNG", ["Eggs to keep"]="Trứng cần giữ",
["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG", ["Auto hatch"]="Tự động ấp trứng", ["Equip best pets"]="Trang bị pet mạnh nhất", ["READY NOW"]="SẴN SÀNG ẤP",
["Auto treadmill"]="Tự chạy máy tập", ["Auto upgrade treadmill"]="Tự nâng cấp máy tập", ["PROGRESS"]="TIẾN TRÌNH", ["Auto upgrade base"]="Tự nâng cấp căn cứ",
["Auto buy trails"]="Tự mua vệt sáng", ["Auto claim offline cash"]="Tự nhận tiền ngoại tuyến", ["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục",
["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN", ["Auto mutate"]="Tự động đột biến", ["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN", ["Use items"]="Dùng vật phẩm",
["Mutate first"]="Ưu tiên đột biến", ["Skip eggs with"]="Bỏ qua trứng đã có", ["Auto buy Nitro"]="Tự mua Nitro", ["PETS"]="THÚ CƯNG (PETS)", ["EGGS"]="TRỨNG (EGGS)", ["Auto sell pets"]="Tự động bán pet",
["Auto sell eggs"]="Tự động bán trứng", ["Sell all eggs now"]="Bán hết trứng ngay", ["Sell all pets now"]="Bán hết Pet ngay",
["Sell rarities"]="Độ hiếm bán", ["Never sell"]="Không bao giờ bán", ["Only mutations"]="Chỉ bán đột biến",
["Only below /s"]="Chỉ dưới mức /s", ["Keep mutated"]="Giữ lại đồ đột biến", ["LAB EGGS"]="TRỨNG PHÒNG LAB", ["FAVORITE"]="YÊU THÍCH (KHÓA)",
["Auto favorite"]="Tự động khóa bảo vệ", ["Favorite matching now"]="Khóa đồ khớp lọc ngay", ["Unfavorite pets not matching"]="Bỏ thích Pet không khớp", ["Always favorite"]="Luôn khóa Yêu thích",
["Auto sell lab eggs"]="Tự động bán trứng Lab", ["Match"]="Điều kiện khớp", ["All picked rules"]="Khớp tất cả quy tắc",
["Any picked rule"]="Khớp bất kỳ quy tắc", ["Favorite equipped"]="Khóa pet đang trang bị", ["FUSE MACHINE"]="MÁY DUNG HỢP",
["No 3 matching pets"]="Chưa đủ 3 pet cùng loại", ["Auto fuse"]="Tự động dung hợp", ["Fuse first"]="Ưu tiên dung hợp", ["Lowest rarity"]="Độ hiếm thấp nhất",
["Highest rarity"]="Độ hiếm cao nhất", ["Use pets"]="Sử dụng pet", ["Lowest value first"]="Giá trị thấp nhất trước", ["Highest value first"]="Giá trị cao nhất trước",
["Skip mutated"]="Bỏ qua pet đột biến", ["Eject odd pets"]="Đẩy pet lẻ ra ngoài", ["FUSE FILTER"]="BỘ LỌC DUNG HỢP", ["Only these pets"]="Chỉ những pet này",
["Never fuse"]="Không bao giờ dung hợp", ["FUSE PREDICTOR"]="DỰ ĐOÁN DUNG HỢP", ["SLOTS"]="Ô CHỨA", ["STATUS"]="TRẠNG THÁI", ["LIKELY SIZE"]="KÍCH CỠ DỰ KIẾN",
["CHANCE"]="TỶ LỆ", ["VALUE"]="GIÁ TRỊ", ["BEST CASE"]="TỐT NHẤT CÓ THỂ", ["TASK ORDER"]="THỨ TỰ TÁC VỤ", ["Task order"]="Thứ tự tác vụ", ["Reset order"]="Đặt lại thứ tự", ["DOING"]="ĐANG LÀM", ["WAITING"]="ĐANG CHỜ",
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
["Keep away"]="Khoảng cách né tránh", ["MINIGAME EGGS"]="TRỨNG MINIGAME", ["Auto steal minigame egg"]="Tự cướp trứng Minigame", 
["ESP"]="Định Vị (ESP)", ["Move"]="Di Chuyển", ["MOVE"]="DI CHUYỂN", ["Combat"]="Chiến Đấu", ["COMBAT"]="CHIẾN ĐẤU", ["FIELD EGGS"]="TRỨNG NGOÀI SÂN",
["Egg ESP"]="ESP Trứng", ["Show"]="Hiển thị", ["Name"]="Tên", ["Fixed size"]="Cố định kích cỡ", ["OTHERS"]="MỤC KHÁC", ["Pen egg ESP"]="ESP trứng trong chuồng",
["Other pens ESP"]="ESP chuồng người khác", ["Guard ESP"]="ESP Vệ sĩ", ["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ", ["Player ESP"]="ESP Người chơi", ["ESP size"]="Kích cỡ ESP",
["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN", ["Speed boost"]="Tăng tốc chạy", ["Boost speed"]="Tốc độ tăng thêm", ["Infinite jump"]="Nhảy vô hạn",
["God mode"]="Bất tử (God mode)", ["PROTECTION"]="BẢO VỆ NHÂN VẬT", ["Anti ragdoll"]="Chống ngã (Anti Ragdoll)", ["Ignore traps"]="Bỏ qua bẫy",
["Instant prompts"]="Tương tác nhấn giữ tức thì", ["Anti AFK"]="Chống treo máy (Anti AFK)", ["Invisible"]="Tàng hình", ["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",
["Auto hit"]="Tự động đánh", ["Hit who"]="Mục tiêu đánh", ["Nearest player"]="Người chơi gần nhất", ["Chosen player"]="Người chơi chỉ định", ["Egg carrier"]="Người đang ôm trứng",
["Chase speed"]="Tốc độ đuổi theo", ["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG", ["Hit aura"]="Vòng đánh tự động (Hit Aura)", ["Skip friends"]="Bỏ qua bạn bè",
["WEAPONS"]="VŨ KHÍ", ["Use weapons"]="Sử dụng vũ khí", ["Hold each"]="Thời gian cầm mỗi món", ["Server"]="Máy Chủ", ["SERVER"]="MÁY CHỦ",
["Webhook"]="Webhook", ["WEBHOOK"]="WEBHOOK", ["Optimizer"]="Tối Ưu Hóa", ["OPTIMIZER"]="TỐI ƯU HÓA", ["Interface"]="Giao Diện", ["INTERFACE"]="GIAO DIỆN",
["GAME HUD"]="TRÊN MÀN HÌNH GAME", ["Steal panel button on game HUD"]="Hiện nút Bảng Cướp trên màn hình",
["Config"]="Cấu Hình", ["CONFIG"]="CẤU HÌNH", ["CONFIGS"]="QUẢN LÝ CẤU HÌNH", ["Configs"]="Danh sách cấu hình", ["ACTIVE"]="ĐANG DÙNG", ["SAVED CONFIGS"]="ĐÃ LƯU",
["Set as active config"]="Đặt làm cấu hình chính", ["Set active"]="Kích hoạt", ["Save changes"]="Lưu thay đổi", ["Save"]="Lưu", ["Overwrite"]="Lưu đè",
["PROFILES"]="HỒ SƠ CẤU HÌNH", ["New config name"]="Tên cấu hình mới", ["Config name"]="Tên cấu hình", ["Auto if empty"]="Tự đặt nếu trống",
["Create config"]="Tạo cấu hình mới", ["Create"]="Tạo mới", ["Pick to delete"]="Chọn mục cần xóa",
["Delete picked"]="Xóa mục đã chọn", ["Delete"]="Xóa", ["Restore deleted"]="Khôi phục mục đã xóa", ["Export config"]="Xuất mã cấu hình", ["Export to clipboard"]="Chép mã cấu hình",
["Import text"]="Dán mã cấu hình", ["Paste config text"]="Dán mã JSON vào đây", ["Paste config JSON here"]="Dán mã JSON vào đây",
["Import config"]="Nhập cấu hình", ["Import"]="Nhập",
["Config imported"]="Đã nhập cấu hình", ["Config loaded"]="Đã nạp cấu hình", ["Later"]="Để sau", ["Apply now"]="Áp dụng ngay", ["Hop to"]="Chuyển tới server",
["Least players"]="Ít người chơi nhất", ["Most players"]="Đông người chơi nhất", ["Random"]="Ngẫu nhiên", ["Hop server"]="Đổi máy chủ", ["Hop"]="Đổi ngay",
["Rejoin this server"]="Vào lại máy chủ này", ["Copy"]="Sao chép", ["JOIN AND STAY"]="VÀO PHÒNG & DUY TRÌ", ["Job ID"]="Mã phòng (Job ID)",
["Paste a Job ID"]="Dán mã Job ID vào đây", ["Join that server"]="Vào máy chủ đó", ["Join"]="Vào ngay", ["Rejoin on kick"]="Tự vào lại khi bị văng/kick",
["Auto load script"]="Tự chạy lại script khi chuyển server", ["DISCORD WEBHOOK"]="WEBHOOK DISCORD", ["Webhook URL"]="Đường dẫn Webhook",
["Ping role ID"]="ID Vai trò (Role ID)", ["Ping user ID"]="ID Người dùng (User ID)",
["Ping everyone"]="Tag @everyone", ["WHAT TO POST"]="NỘI DUNG GỬI BÁO CÁO", ["Post stolen eggs"]="Báo cáo trứng cướp được",
["Post fused eggs"]="Báo cáo trứng dung hợp", ["POSTED"]="ĐÃ GỬI", ["Send a test post"]="Gửi tin nhắn thử nghiệm", ["Test"]="Thử nghiệm",
["Post when bag is full"]="Gửi thông báo khi đầy túi", ["GRAPHICS"]="ĐỒ HỌA", ["Low graphics"]="Đồ họa thấp (Tăng FPS)",
["Disable 3D Render"]="Tắt kết xuất 3D (Treo máy)", ["Background color"]="Màu nền màn hình", ["Black"]="Màu Đen", ["White"]="Màu Trắng",
["Hide game UI"]="Ẩn giao diện gốc của Game", ["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)", ["FPS cap"]="Giới hạn FPS", ["FPS position"]="Vị trí thanh FPS",
["Show FPS and ping"]="Hiện chỉ số FPS và Ping", ["BASES"]="CĂN CỨ (BASES)", ["Hide other players' pets and eggs"]="Ẩn pet và trứng của người chơi khác",
["Hide my pets and eggs"]="Ẩn pet và trứng của bản thân", ["Theme"]="Chủ đề màu", ["Toggle key"]="Phím đóng/mở Menu", ["Quick bar"]="Thanh phím tắt nhanh",
["QUICK BAR"]="THANH PHÍM TẮT NHANH", ["Auto save"]="Tự động lưu cấu hình", ["Auto load"]="Tự động nạp cấu hình", ["Auto load on join"]="Tự động nạp khi vào game",
["Load config"]="Nạp cấu hình", ["Load"]="Nạp cấu hình",
["Reset config"]="Đặt lại mặc định", ["Delete config"]="Xóa cấu hình", ["Common"]="Phổ Thông", ["Uncommon"]="Thường", ["Rare"]="Hiếm", ["Epic"]="Sử Thi",
["Legendary"]="Huyền Thoại", ["Mythic"]="Thần Thoại", ["Cosmic"]="Vũ Trụ", ["Secret"]="Bí Ẩn", ["Divine"]="Thánh Thần", ["Eternal"]="Vĩnh Cửu",
["COMMON"]="PHỔ THÔNG", ["UNCOMMON"]="THƯỜNG", ["RARE"]="HIẾM", ["EPIC"]="SỬ THI", ["LEGENDARY"]="HUYỀN THOẠI", ["MYTHIC"]="THẦN THOẠI",
["COSMIC"]="VŨ TRỤ", ["SECRET"]="BÍ ẨN", ["DIVINE"]="THÁNH THẦN", ["ETERNAL"]="VĨNH CỬU",
["Radiant"]="Rực Rỡ", ["Amethyst"]="Thạch Anh Tím", ["Sapphire"]="Lam Ngọc", ["Emerald"]="Ngọc Lục Bảo"
}
local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
local lk = k:lower()
if not LOWER_VI[lk] or k:upper() ~= k then
LOWER_VI[lk] = v
end
end
local GRAMMAR_VI = {
{ pat="^[Gg]oing%s+into%s+(.+)$", rep="Đang vào %1" },
{ pat="^[Ll]eaving%s+(.+)$", rep="Đang rời %1" },
{ pat="^[Ee]ntering%s+(.+)$", rep="Đang vào %1" },
{ pat="^[Vv]acuuming%s+ghosts%s*(.*)$", rep="Đang hút bóng ma %1" },
{ pat="^[Rr]iding%s+(.+)$", rep="Đang đi %1" },
{ pat="^[Ff]ighting%s+[Ss]mall%s+monster$", rep="Đang đánh quái vật nhỏ" },
{ pat="^[Ff]ighting%s+[Mm]edium%s+monster$", rep="Đang đánh quái vật vừa" },
{ pat="^[Ff]ighting%s+[Ll]arge%s+monster$", rep="Đang đánh quái vật lớn" },
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
{"steal missing halloween index", "Cướp trứng Halloween thiếu trong Chỉ mục"},
{"missing halloween index", "Halloween thiếu trong Chỉ mục"},
{"hatch missing in egg index", "ấp trứng thiếu trong Chỉ mục"},
{"in egg index", "trong Chỉ mục trứng"},
{"egg index", "Chỉ mục trứng"},
{"auto claim mastery", "Tự động nhận thưởng Thông Thạo"},
{"claim mastery", "nhận thưởng Thông Thạo"},
{"stub pickup speed", "Tốc độ nhặt Cuống Bí Ngô"},
{"pickup speed", "Tốc độ nhặt vật phẩm"},
{"cuống pickup", "nhặt Cuống Bí Ngô"},

{"cursed island wars","Đại Chiến Đảo Nguyền Rủa"}, {"island wars","Đảo Nguyền Rủa"}, {"phantom express","Tàu Ma Phantom Express"},
{"pumpkin moon","Trăng Bí Ngô"}, {"halloween dimension","Không gian Halloween"}, {"ghost dog","Chó Ma"},
{"enemies and base","Kẻ địch và Căn cứ"}, {"walls and crystal","Tường chắn và Pha lê"}, {"candy corn","Kẹo Ngô"},
{"admin treadmill","máy tập Admin"}, {"instant steal","cướp tức thì"}, {"capture the egg","Cướp trứng sự kiện"},
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
{"was added to your configs","đã được thêm vào danh sách cấu hình"},
{"fixed some bugs","đã sửa một số lỗi vặt"}, {"some bugs","một số lỗi vặt"},
{"movement speed up to","tốc độ di chuyển lên tới"}, {"di chuyển tốc độ up tới","tốc độ di chuyển lên tới"},
{"improved fast bay (tween)","cải thiện Bay Nhanh (Fast Tween)"}, {"improved fast tween","cải thiện Bay Nhanh (Fast Tween)"}, {"fast tween","Bay Nhanh (Fast Tween)"},
{"auto pumpkin boss","tự đánh Boss Bí Ngô"}, {"tự động bí ngô boss","tự đánh Boss Bí Ngô"},
{"dodges attacks","né đòn tấn công"}, {"fires cannons","bắn đại bác"},
{"collects pumpkin stubs","nhặt Cuống Bí Ngô"}, {"collects bí ngô stubs","nhặt Cuống Bí Ngô"}, {"pumpkin stubs","Cuống Bí Ngô"},
{"auto manor key","tự lấy chìa khóa dinh thự"}, {"tự động manor key","tự lấy chìa khóa dinh thự"}, {"manor key","chìa khóa dinh thự"},
{"go to egg leap","Nhảy Tới Trứng"}, {"di chuyển tới trứng leap","Nhảy Tới Trứng"},
{"replaces old go to egg","thay thế Đi Tới Trứng cũ"}, {"replaces old di chuyển tới trứng","thay thế Đi Tới Trứng cũ"}, {"replaces old","thay thế bản cũ"},
{"anti guard fires again","Chống vệ sĩ hoạt động trở lại"}, {"anti vệ sĩ fires again","Chống vệ sĩ hoạt động trở lại"}, {"fires again","hoạt động trở lại"},
{"finishes about twice as fast","hoàn tất nhanh gấp đôi"}, {"twice as fast","nhanh gấp đôi"},
{"you can also hold any feature to pin it","bạn có thể nhấn giữ tính năng bất kỳ để ghim"},
{"set a key","gán phím tắt"}, {"set key","gán phím tắt"},
{"inventory values","Giá trị túi đồ"}, {"find option","Tìm tùy chọn"}, {"just now","vừa xong"}
}
local VI_TO_EN = {
["trang chủ"] = "Home", ["săn trứng"] = "Steal", ["tự cày"] = "Farm",
["sự kiện"] = "Events", ["nhân vật"] = "Player", ["cài đặt"] = "Settings",
["tự động cướp"] = "Auto steal", ["tự động"] = "Auto", ["dịch chuyển tới trứng"] = "Go to egg",
["di chuyển tới trứng"] = "Go to egg", ["cách mang về"] = "Delivery method",
["khu vực dịch chuyển"] = "Teleport zones", ["cướp trứng thiếu trong chỉ mục"] = "Steal missing index eggs",
["cướp từ người chơi khác"] = "Steal from other players", ["chống vệ sĩ"] = "Anti guard",
["thả trứng ở vùng an toàn"] = "Drop eggs at safe zone", ["chỉ những trứng này"] = "Only these eggs",
["giá tối thiểu /s"] = "Min value /s", ["giá tối thiểu"] = "Min value",
["bán trứng rẻ nhất khi đầy túi"] = "Sell cheapest egg when bag is full",
["chỉ dưới mức /s"] = "Only below /s", ["không có"] = "None", ["không"] = "None",
["giá trị cao nhất"] = "Best value", ["thánh thần"] = "Divine", ["vĩnh cửu"] = "Eternal",
["bí ẩn"] = "Secret", ["vũ trụ"] = "Cosmic", ["thần thoại"] = "Mythic",
["huyền thoại"] = "Legendary", ["sử thi"] = "Epic", ["hiếm"] = "Rare",
["thường"] = "Common", ["tắt"] = "Off", ["bật"] = "On", ["tất cả"] = "All",
["tìm trứng"] = "Finder", ["đang rảnh"] = "Idle", ["vào ngay"] = "Join",
["tự vào sau"] = "Force join", ["độ hiếm"] = "Rarity", ["tài khoản"] = "Account",
["miễn phí"] = "Free", ["ẩn"] = "Hide", ["hiện"] = "Show",
["tự động: tắt"] = "AUTO OFF", ["tự động: bật"] = "AUTO ON",
["đang tìm..."] = "Searching...", ["đang quét..."] = "Scanning...", ["đã thấy!"] = "Found!"
}
for k, v in pairs(EXACT_VI) do
if type(v) == "string" and type(k) == "string" then
local lk = v:lower()
if not VI_TO_EN[lk] then VI_TO_EN[lk] = k end
end
end

local WORDS_VI = {
hatch="ấp", hatches="ấp", hatched="đã ấp",
mastery="Thông Thạo", pickup="nhặt", missing="còn thiếu",
index="Chỉ mục", indexed="đã mở Chỉ mục",
kills="số lần hạ", kill="hạ", alive="còn sống", dead="đã hạ",
spawned="đã xuất hiện", hollow="Vực Hollow", abyss="Vực Thẳm",
wisp="Wisp", banjo="Banjo", cricket="dế",

leaving="Đang rời", entering="Đang vào", vacuuming="Đang hút", riding="Đang đi", choose="chọn", multiple="nhiều", shorter="ngắn hơn", delay="độ trễ", between="giữa", tasks="tác vụ", grabs="cướp",
idle="Đang rảnh", carrying="Đang mang", delivering="Đang giao", stealing="Đang cướp", grabbing="Đang nhặt",
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
["for"]="cho", with="với", ["and"]="và", ["or"]="hoặc",
some="một số", bug="lỗi", bugs="lỗi", improved="cải thiện", fast="nhanh", up="lên",
dodges="né", dodge="né", attacks="đòn đánh", attack="tấn công", fires="bắn", fire="bắn",
cannons="đại bác", cannon="đại bác", collects="nhặt", collect="nhặt", stubs="cuống", stub="cuống",
manor="dinh thự", key="chìa khóa", keys="chìa khóa", leap="nhảy vọt", replaces="thay thế", replace="thay thế",
old="cũ", new="mới", anti="chống", again="lại", finishes="hoàn tất", finish="hoàn tất",
about="khoảng", twice="gấp đôi", as="như", tip="Mẹo", also="cũng", can="có thể",
hold="nhấn giữ", any="bất kỳ", feature="tính năng", features="tính năng", pin="ghim",
it="nó", set="gán", option="tùy chọn", options="tùy chọn", find="tìm",
inventory="túi đồ", values="giá trị", value="giá trị", now="ngay", just="vừa"
}
local DYN_VI = {
{ pat="^(v[%d%.]+):%s*[Ff]ixed some bugs%.?$", rep="%1: Đã sửa một số lỗi vặt" },
{ pat="^(v[%d%.]+):%s*đã sửa some bugs%.?$", rep="%1: Đã sửa một số lỗi vặt" },
{ pat="^(v[%d%.]+):%s*[Mm]ovement speed up to (%d+%%),%s*improved [Ff]ast [Tt]ween.*$", rep="%1: Tăng tốc độ di chuyển lên tới %2, cải thiện Bay Nhanh (Fast Tween)" },
{ pat="^(v[%d%.]+):%s*[Aa]uto [Pp]umpkin [Bb]oss.*$", rep="%1: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng" },
{ pat="^(v[%d%.]+):%s*[Aa]nti guard fires again.*$", rep="%1: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi" },
{ pat="^QUICK BAR (%d+)$", rep="THANH NHANH %1" },
{ pat="^[Ee]%.g%. (.+)$", rep="VD: %1" },
{ pat="^(.+) Egg$", rep="Trứng %1" },
{ pat="^(%d+) seconds? ago$", rep="%1 giây trước" },
{ pat="^(%d+) hours? ago$", rep="%1 giờ trước" },
{ pat="^(%d+) days? ago$", rep="%1 ngày trước" },
{ pat="^(%d+) minutes? ago$", rep="%1 phút trước" },
{ pat="Venyx(.-)just now", rep="Chilli Hub%1vừa xong" },
{ pat="Venyx(.-)(%d+) seconds? ago", rep="Chilli Hub%1%2 giây trước" },
{ pat="^(.+) was added to your configs%. Apply it now%??$", rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?" },
{ pat="^(.+) was added to your configs$", rep="Đã thêm '%1' vào danh sách cấu hình" },
{ pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support", rep="Chào mừng tới Chilli Hub V8 (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ" },
{ pat="Venyx(.-)(%d+) hours? ago", rep="Chilli Hub%1%2 giờ trước" },
{ pat="Venyx(.-)(%d+) minutes? ago", rep="Chilli Hub%1%2 phút trước" },
{ pat="Venyx(.-)(%d+) days? ago", rep="Chilli Hub%1%2 ngày trước" },
{ pat="^ALL (%d+)$", rep="TẤT CẢ %1" }, { pat="^READY (%d+)$", rep="SẴN SÀNG %1" },
{ pat="^GROWING (%d+)$", rep="ĐANG LỚN %1" }, { pat="^IN BAG (%d+)$", rep="TRONG TÚI %1" },
{ pat="Pen (%d+/%d+).-(%d+) egg%(s%) ready to place", rep="Chuồng %1 · %2 trứng sẵn sàng đặt" },
{ pat="(%d+) egg%(s%) can be mutated", rep="%1 trứng có thể đột biến" },
{ pat="(%d+) pet%(s%) match", rep="%1 pet khớp bộ lọc" }, { pat="(%d+) egg%(s%) match", rep="%1 trứng khớp bộ lọc" },
{ pat="(%d+) lab egg%(s%) match", rep="%1 trứng Lab khớp bộ lọc" }, { pat="^(%d+) pets$", rep="%1 thú cưng" },
{ pat="(%d+ / %d+) players · (.+)", rep="%1 người chơi · %2" },
{ pat="Experimental Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="Pet Thí Nghiệm · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="Biohazard Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="Pet Sinh Học · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="Unstable DNA · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="DNA Bất Ổn · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="^Mythic · 1 in ([%d%.]+)$", rep="Thần Thoại · 1 trên %1" },
{ pat="^Cosmic · 1 in ([%d%.]+)$", rep="Vũ Trụ · 1 trên %1" },
{ pat="^Secret · 1 in ([%d%.]+)$", rep="Bí Ẩn · 1 trên %1" },
{ pat="^Divine · 1 in ([%d%.]+)$", rep="Thánh Thần · 1 trên %1" },
{ pat="^Eternal · 1 in ([%d%.]+)$", rep="Vĩnh Cửu · 1 trên %1" },
{ pat="^First hop after (%d+)s$", rep="Đổi lần đầu sau %1 giây" },
{ pat="^Hold each ([%d%.]+)s$", rep="Cầm mỗi món %1 giây" },
{ pat="^(%d+) selected$", rep="Đã chọn %1 mục" },
{ pat="^(%d+)%s*/%s*(%d+) selected$", rep="Đã chọn %1/%2" }
}
local function stripArt(s)
return ((" " .. s .. " "):gsub("%s+[Aa]%s+", " "):gsub("%s+[Aa]n%s+", " "):gsub("%s+[Tt]he%s+", " "):match("^%s*(.-)%s*$") or s)
end
local function applyPhrases(s)
local out = s
for i = 1, #PHRASES_VI do
local p = PHRASES_VI[i]
local guard = 0
while guard < 6 do
local a, b = out:lower():find(p[1], 1, true)
if not a then break end
out = out:sub(1, a - 1) .. p[2] .. out:sub(b + 1)
guard = guard + 1
end
end
return out
end
local function applyWords(s)
return (stripArt(s):gsub("([\128-\255%a']+)", function(w)
if w:find("[\128-\255]") then return w end
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
if raw:find("Venyx SAE", 1, true) then
raw = raw:gsub("Venyx SAE", "Chilli SAE")
elseif raw == "VENYX" or raw == "Chilli Hub V5" or raw == "Chilli V5 |" then
raw = NEW_TITLE
elseif raw == "Venyx" then
raw = "Chilli Hub"
end
if State.Language == "EN" then
local out = raw
local low = raw:lower():match("^%s*(.-)%s*$")
if VI_TO_EN[low] then
out = VI_TO_EN[low]
elseif VI_TO_EN[raw] then
out = VI_TO_EN[raw]
end
FastCache[ck] = out
return out
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
local pfx, wp = norm:match("^([^%w%s]+%s*)(.+)$")
if pfx and wp and (EXACT_VI[wp] or LOWER_VI[wp:lower()]) then
FastCache[ck] = pfx .. (EXACT_VI[wp] or LOWER_VI[wp:lower()])
return FastCache[ck]
end
for i = 1, #DYN_VI do
if norm:find(DYN_VI[i].pat) then
FastCache[ck] = norm:gsub(DYN_VI[i].pat, DYN_VI[i].rep)
return FastCache[ck]
end
end
local res, hit = norm, false
local caps = (norm:upper() == norm and norm:find("%a") ~= nil)
for i = 1, #GRAMMAR_VI do
if res:find(GRAMMAR_VI[i].pat) then
res = res:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep)
hit = true
break
end
end
local phr = applyPhrases(res)
if hit or phr ~= res or res:find("%s") then
local fin = applyWords(phr):gsub("Venyx", "Chilli Hub"):gsub("%s+", " "):match("^%s*(.-)%s*$") or res
if caps and fin ~= norm then fin = fin:upper() end
FastCache[ck] = fin
return fin
end
FastCache[ck] = raw
return raw
end
local function stripRichTags(s)
if type(s) ~= "string" then return "" end
return (s:gsub("<[^>]+>", ""):match("^%s*(.-)%s*$") or "")
end
local hopToLeastPlayersServer = nil
local watchFinderHudButton = nil
local hookChilliFinderJoin = nil
local watchFinderTextObj = nil
local hookLoginFrameTrigger = nil
local translateFinderHudState = nil
local scanChilliFinderButtons = nil

local function applyTrans(inst)
if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHookSession") or inst:GetAttribute("__HiddenVxLogo")
or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt" or inst.Name == "ChilliTabCaption" or inst.Name == "ChilliTabCaptionEn" or inst.Name == "ChilliFakeFpsOverlay" or inst.Name == "NeonFpsText"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar")
or inst:GetAttribute("__IsTranslating") then return end
if inst:IsA("TextBox") then
local phL = (inst.PlaceholderText or ""):lower()
local txL = (inst.Text or ""):lower()
if phL:find("password", 1, true) or phL:find("user", 1, true) or txL == "hihi" then
local curr = inst.Parent
for _ = 1, 4 do
if not curr or curr:IsA("ScreenGui") or curr == State.ActiveFinderWin then break end
if curr:IsA("GuiObject") and curr.AbsoluteSize.Y <= 260 then
curr.Visible = false
curr.Position = UDim2.new(2, 0, 2, 0)
hookLoginFrameTrigger(curr)
break
end
curr = curr.Parent
end
end
local ph = inst:GetAttribute("OrigPlaceholder") or inst:GetAttribute("OrigPh")
if not ph and inst.PlaceholderText ~= "" and not hasVi(inst.PlaceholderText) then
ph = inst.PlaceholderText
inst:SetAttribute("OrigPlaceholder", ph)
inst:SetAttribute("OrigPh", ph)
end
if ph then inst.PlaceholderText = translateText(ph) end
if not inst:IsFocused() then
local bt = inst.Text
if bt == "Off" or bt == "Tắt" or bt == "None" or bt == "Không có" then
local ob = inst:GetAttribute("OrigBoxText") or ((bt == "Tắt") and "Off" or ((bt == "Không có") and "None" or bt))
inst:SetAttribute("OrigBoxText", ob)
local mb = translateText(ob)
if inst.Text ~= mb then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = mb end)
inst:SetAttribute("__IsTranslating", false)
end
end
end
return
end
local rt = inst.Text
if isFpsTxt(rt) then
hookFps(inst)
return
end
local orig = inst:GetAttribute("OrigRawText")
if not orig or (rt ~= "" and rt ~= inst:GetAttribute("__LastTranslated") and not hasVi(rt)) then
orig = rt
inst:SetAttribute("OrigRawText", orig)
end
local rawLow = (orig or ""):lower():match("^%s*(.-)%s*$")
if translateFinderHudState and (rawLow:find("force join", 1, true) or rawLow:find("min value", 1, true) or rawLow:find("rarity", 1, true) or rawLow:find("account", 1, true) or rawLow:find("auto off", 1, true) or rawLow:find("auto on", 1, true)) then
local fMap = translateFinderHudState(orig)
if fMap and fMap ~= orig then
inst:SetAttribute("__LastTranslated", fMap)
if inst.Text ~= fMap then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = fMap end)
inst:SetAttribute("__IsTranslating", false)
end
return
end
end
if State.Language == "EN" then
local enText = orig or VI_TO_EN[rt:lower()] or VI_TO_EN[rt] or rt
inst:SetAttribute("__LastTranslated", enText)
if inst.Text ~= enText then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = enText end)
inst:SetAttribute("__IsTranslating", false)
end
return
end
local mapped = translateText(orig)
inst:SetAttribute("__LastTranslated", mapped)
if inst.Text ~= mapped then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = mapped end)
inst:SetAttribute("__IsTranslating", false)
end
local checkLow = (orig or ""):lower():match("^%s*(.-)%s*$")
if checkLow == "join" or mapped == "Vào ngay" or rt == "Vào ngay" or rt == "Join" then
if hookChilliFinderJoin then pcall(hookChilliFinderJoin, inst) end
elseif watchFinderTextObj and (checkLow == "chilli finder" or checkLow:find("chillihub.pro", 1, true) or checkLow:find("top 5 recent eggs", 1, true) or checkLow == "sign in" or checkLow == "sign up") then
pcall(watchFinderTextObj, inst)
end
end
local function hookTrans(inst)
if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
if inst.Name == "ChilliFakeFpsOverlay" or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint"
or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt" or inst.Name == "ChilliTabCaption" or inst.Name == "ChilliTabCaptionEn" or inst.Name == "ChilliFakeFpsOverlay" or inst.Name == "NeonFpsText"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then
hookFps(inst)
return
end
applyTrans(inst)
if inst:GetAttribute("__TransHookSession") == SID then return end
inst:SetAttribute("__TransHookSession", SID)
table.insert(State.TrackedTexts, inst)
local inScroll = inst:FindFirstAncestorOfClass("ScrollingFrame") ~= nil
if inScroll and inst:IsA("TextLabel") and #inst.Text > 16 and not inst.Text:find("%d") then
return
end
inst:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive() or inst:GetAttribute("__IsTranslating") or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") then return end
local cur = inst.Text
if cur == "" or cur == inst:GetAttribute("__LastTranslated") then return end
if not inst:IsA("TextBox") and isFpsTxt(cur) then
hookFps(inst)
return
end
if cur:match("^[%$%+%-%d%.%,%/%%sxhm%s:]+$") then return end
if inst:IsA("TextBox") then
applyTrans(inst)
return
end
if not hasVi(cur) then
inst:SetAttribute("OrigRawText", cur)
applyTrans(inst)
end
end)
end

local function refreshAllTexts()
if not isAlive() then return end
table.clear(FastCache)
for i = #State.TrackedTexts, 1, -1 do
local el = State.TrackedTexts[i]
if el and el.Parent then
pcall(applyTrans, el)
pcall(watchFinderHudButton, el)
else
table.remove(State.TrackedTexts, i)
end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
if State.RefreshSidebarTabsCallback then pcall(State.RefreshSidebarTabsCallback) end
if State.ActiveFinderWin and State.ActiveFinderWin.Parent then
pcall(scanChilliFinderButtons)
end
end

-- 5. NẠP CONFIG CHUẨN V5 (MỞ THẲNG HỆ THỐNG -> CẤU HÌNH, CUỘN XUỐNG NÚT NHẬP, DÁN JSON & CLICK AN TOÀN)
local function fireBtn(btn)
if not btn or not btn.Parent then return false end
local fired = false
local clickable = (btn:IsA("TextButton") or btn:IsA("ImageButton")) and btn
or btn:FindFirstAncestorWhichIsA("TextButton") or btn:FindFirstAncestorWhichIsA("ImageButton")
or (btn.Parent and (btn.Parent:FindFirstChildWhichIsA("TextButton") or btn.Parent:FindFirstChildWhichIsA("ImageButton")))
or btn
local targets = {}
local seenT = {}
local inScroll = btn:FindFirstAncestorOfClass("ScrollingFrame") ~= nil
local candidateList = inScroll and { clickable, btn, btn.Parent } or { clickable, btn, btn.Parent, btn.Parent and btn.Parent.Parent }
for _, tObj in ipairs(candidateList) do
if tObj and tObj:IsA("GuiObject") and not seenT[tObj] then
if not inScroll or (tObj.AbsoluteSize.X <= 175 and tObj.AbsoluteSize.Y <= 52) then
seenT[tObj] = true
table.insert(targets, tObj)
end
end
end
for _, targetObj in ipairs(targets) do
local cx = math.floor(targetObj.AbsolutePosition.X + targetObj.AbsoluteSize.X * 0.5)
local cy = math.floor(targetObj.AbsolutePosition.Y + targetObj.AbsoluteSize.Y * 0.5)
local pos3 = Vector3.new(cx, cy, 0)
if getconnections then
for _, sigName in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
pcall(function()
local sig = targetObj[sigName]
if sig then
for _, conn in ipairs(getconnections(sig)) do
if conn.Function then
task.spawn(conn.Function)
fired = true
elseif conn.Fire then
pcall(conn.Fire, conn)
fired = true
end
end
end
end)
end
pcall(function()
for _, uType in ipairs({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }) do
local changedCbs = {}
local fakeSig = {
Connect = function(_, fn)
if type(fn) == "function" then table.insert(changedCbs, fn) end
return { Connected = true, Disconnect = function(s) s.Connected = false end }
end,
Once = function(_, fn)
if type(fn) == "function" then table.insert(changedCbs, fn) end
return { Connected = true, Disconnect = function(s) s.Connected = false end }
end,
Wait = function() return "UserInputState" end
}
local fakeInput = {
UserInputType = uType,
UserInputState = Enum.UserInputState.Begin,
Position = pos3,
Delta = Vector3.zero,
KeyCode = Enum.KeyCode.Unknown,
Changed = fakeSig,
GetPropertyChangedSignal = function() return fakeSig end,
IsA = function(_, cls) return cls == "InputObject" end
}
for _, conn in ipairs(getconnections(targetObj.InputBegan)) do
if conn.Function then
pcall(conn.Function, fakeInput, false)
fired = true
elseif conn.Fire then
pcall(conn.Fire, conn, fakeInput, false)
fired = true
end
end
fakeInput.UserInputState = Enum.UserInputState.End
for _, cb in ipairs(changedCbs) do
pcall(cb, "UserInputState")
end
for _, conn in ipairs(getconnections(targetObj.InputEnded)) do
if conn.Function then
pcall(conn.Function, fakeInput, false)
fired = true
elseif conn.Fire then
pcall(conn.Fire, conn, fakeInput, false)
fired = true
end
end
end
end)
end
if firesignal and (targetObj:IsA("TextButton") or targetObj:IsA("ImageButton")) then
pcall(function()
firesignal(targetObj.MouseButton1Click)
fired = true
end)
pcall(function()
firesignal(targetObj.Activated)
fired = true
end)
end
end
return fired
end
local function isControlVisibleOnTab(el, rootGui)
if not (el and el.Parent) then return false end
local curr = el
while curr and curr ~= rootGui and not curr:IsA("ScreenGui") do
if curr:IsA("GuiObject") and not curr.Visible then return false end
curr = curr.Parent
end
return el.AbsoluteSize.X > 8 and el.AbsoluteSize.Y > 6
end
local function findSystemTabBtn(gui)
if State.SystemTabBtn and State.SystemTabBtn.Parent and State.SystemTabBtn:IsDescendantOf(gui) then
return State.SystemTabBtn
end
local candidates = {}
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("GuiObject") and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
local children = {}
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("GuiObject") and ch.AbsoluteSize.X >= 18 and ch.AbsoluteSize.X <= 70 and ch.AbsoluteSize.Y >= 18 and ch.AbsoluteSize.Y <= 70 then
table.insert(children, ch)
end
end
if #children >= 5 and #children <= 8 then
table.sort(children, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)
State.SystemTabBtn = children[6] or children[#children]
return State.SystemTabBtn
end
end
end
return State.SystemTabBtn
end
local function findImportBoxAndButtons(venyxGui, requireVisible)
local box = nil
local btnList = {}
for _, d in ipairs(venyxGui:GetDescendants()) do
if d:IsA("TextBox") and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
local ph = (d:GetAttribute("OrigPlaceholder") or d:GetAttribute("OrigPh") or d.PlaceholderText or ""):lower()
if ph:find("paste", 1, true) or ph:find("dán", 1, true) or ph:find("json", 1, true) then
if not ph:find("job id", 1, true) and not ph:find("webhook", 1, true) and not ph:find("empty", 1, true) and not ph:find("trống", 1, true) then
if not requireVisible or isControlVisibleOnTab(d, venyxGui) then
box = d
end
end
end
end
end
if box then
local bx, by = box.AbsolutePosition.X, box.AbsolutePosition.Y
local seenBtn = {}
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and d ~= box and not d:IsDescendantOf(box) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
if not requireVisible or isControlVisibleOnTab(d, venyxGui) then
local dx = d.AbsolutePosition.X - bx
local dy = d.AbsolutePosition.Y - by
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$"):lower()
local ct = (d.Text or ""):match("^%s*(.-)%s*$"):lower()
local isImportLabel = (ot == "import" or ot == "import config" or ct == "nhập" or ct == "nhập cấu hình")
if isImportLabel and (by <= 10 or (dx >= -25 and dy >= 6 and dy <= 98)) and not seenBtn[d] then
seenBtn[d] = true
table.insert(btnList, d)
end
end
end
end
end
return box, btnList
end
local function highlightTargetButton(btnObj)
if not btnObj then return end
pcall(function()
local pill = (btnObj.Parent and btnObj.Parent:IsA("GuiObject") and btnObj.Parent.AbsoluteSize.X <= 170 and btnObj.Parent.AbsoluteSize.Y <= 48) and btnObj.Parent or btnObj
local oldHl = pill:FindFirstChild("ChilliImportHighlightStroke")
if oldHl then oldHl:Destroy() end
local hl = mk("UIStroke", {
Name = "ChilliImportHighlightStroke",
Thickness = 2.6,
Color = c3(80, 255, 160),
ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
Transparency = 0
}, pill)
addGrad(mk("UIGradient", { Color = RAINBOW }, hl))
task.delay(6, function()
if hl and hl.Parent then hl:Destroy() end
end)
end)
end
local function setChilliChildrenVisible(venyxGui, showChilli)
if not venyxGui or not venyxGui.Parent then return end
pcall(function() venyxGui.Enabled = true end)
local pill = State.ActiveStatusLbl and State.ActiveStatusLbl.Parent
local exp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
for _, ch in ipairs(venyxGui:GetChildren()) do
if ch:IsA("GuiObject") and ch ~= pill and ch ~= exp and not ch:FindFirstChild("IslandLogoBadge") then
if not showChilli then
if ch.Visible then
ch:SetAttribute("__ChilliSavedVis", true)
pcall(function() ch.Visible = false end)
end
else
if ch:GetAttribute("__ChilliSavedVis") or ch == State.ActiveMainWin then
ch:SetAttribute("__ChilliSavedVis", nil)
pcall(function() ch.Visible = true end)
end
end
end
end
end
local function switchHub(targetHub)
State.ActiveHub = "CHILLI"
end
local function runAutoFarmMacro(venyxGui, btnLbl)
if State.MacroBusy then return end
State.MacroBusy = true
task.spawn(function()
local okMacro, _ = pcall(function()
if State.ActiveHub ~= "CHILLI" and State.SwitchHubFn then
pcall(State.SwitchHubFn, "CHILLI")
task.wait(0.10)
end
if State.ActiveVenyxGui and State.ActiveVenyxGui.Parent then
venyxGui = State.ActiveVenyxGui
pcall(function() venyxGui.Enabled = true end)
end
if btnLbl then btnLbl.Text = "⏳ ĐANG MỞ MỤC CẤU HÌNH..." end
local expPanel = venyxGui and venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if expPanel and expPanel.Visible then
expPanel.Visible = false
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent and State.ActiveStatusLbl.Parent:IsA("GuiObject") then
State.ActiveStatusLbl.Parent.Visible = true
end
end
if State.ActiveMainWin and State.ActiveMainWin.Parent and not State.ActiveMainWin.Visible then
State.ActiveMainWin.Visible = true
if State.SyncWindowFn then pcall(State.SyncWindowFn) end
task.wait(0.15)
end
local sysBtn = findSystemTabBtn(venyxGui)
if sysBtn then
fireBtn(sysBtn)
task.wait(0.24)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestorOfClass("ScrollingFrame") and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") and not d:FindFirstAncestor("ChilliTabToast") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local ct = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Config" or ct == "Cấu Hình" then
fireBtn(d)
end
end
end
task.wait(0.30)
local importBox, importBtns = findImportBoxAndButtons(venyxGui, true)
if not importBox then
importBox, importBtns = findImportBoxAndButtons(venyxGui, false)
end
if not importBox then
if btnLbl then
btnLbl.Text = "⚠️ MỞ MỤC CẤU HÌNH TRƯỚC!"
task.wait(2)
btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM"
end
return
end
local sf = importBox:FindFirstAncestorOfClass("ScrollingFrame")
if sf then
pcall(function()
sf.CanvasPosition = v2(0, math.max(360, sf.AbsoluteCanvasSize.Y))
end)
task.wait(0.12)
end
local hasHihi2 = (State.ImportRunCount or 0) > 0
if not hasHihi2 then
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local t = (d.Text or ""):lower()
if t:find("hihi 2", 1, true) then
hasHihi2 = true
break
end
end
end
end
State.ImportRunCount = (State.ImportRunCount or 0) + 1
local payloadJson = PRESET_JSON
if hasHihi2 then
local freshName = "hihi 2 #" .. tostring(math.random(10, 99))
payloadJson = PRESET_JSON:gsub('"name":"hihi 2"', '"name":"' .. freshName .. '"', 1)
end
if setclipboard then
pcall(setclipboard, payloadJson)
end
importBox:SetAttribute("__IsTranslating", true)
pcall(function() importBox.ClearTextOnFocus = false end)
importBox.Text = ""
task.wait(0.05)
importBox.Text = payloadJson
task.wait(0.08)
if getconnections then
pcall(function()
for _, conn in ipairs(getconnections(importBox:GetPropertyChangedSignal("Text"))) do
if conn.Function then pcall(conn.Function) elseif conn.Fire then pcall(conn.Fire, conn) end
end
for _, conn in ipairs(getconnections(importBox.Changed)) do
if conn.Function then pcall(conn.Function, "Text") elseif conn.Fire then pcall(conn.Fire, conn, "Text") end
end
end)
end
if firesignal then
pcall(function() firesignal(importBox.FocusLost, true) end)
end
if getconnections then
pcall(function()
for _, conn in ipairs(getconnections(importBox.FocusLost)) do
if conn.Function then pcall(conn.Function, true) elseif conn.Fire then pcall(conn.Fire, conn, true) end
end
end)
end
importBox:SetAttribute("__IsTranslating", false)
if sf then
pcall(function()
sf.CanvasPosition = v2(0, math.max(360, sf.AbsoluteCanvasSize.Y))
end)
end
task.wait(0.20)
local _, freshBtns = findImportBoxAndButtons(venyxGui, true)
if #freshBtns > 0 then importBtns = freshBtns end
for _, bObj in ipairs(importBtns) do
highlightTargetButton(bObj)
fireBtn(bObj)
end
task.wait(0.35)
for pass = 1, 2 do
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local cur = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Apply now" or cur == "Áp dụng ngay" or ot == "Overwrite" or cur == "Lưu đè" then
if isControlVisibleOnTab(d, venyxGui) then
highlightTargetButton(d)
fireBtn(d)
end
end
end
end
task.wait(0.15)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local cur = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Set active" or cur == "Kích hoạt" then
if isControlVisibleOnTab(d, venyxGui) then
fireBtn(d)
break
end
end
end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
if btnLbl then
btnLbl.Text = "✅ ĐÃ DÁN JSON & MỞ NÚT NHẬP!"
task.wait(1.8)
btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM"
end
end)
State.MacroBusy = false
end)
end
-- ============================================================================
-- [PHẦN 3] DYNAMIC ISLAND V8 SUPREME & HỆ THỐNG ÂM THANH TƯƠNG TÁC (0MS LATENCY)
-- ============================================================================
local SoundService = game:GetService("SoundService")
local ISLAND_SFX_CFG = {
open = { id = "rbxassetid://6895079853", vol = 0.75, spd = 1.06 },
close = { id = "rbxassetid://6895079853", vol = 0.55, spd = 0.86 },
tap = { id = "rbxassetid://6026984224", vol = 0.70, spd = 1.12 },
action = { id = "rbxassetid://4590662766", vol = 0.72, spd = 1.08 }
}
State.CachedIslandSfx = State.CachedIslandSfx or {}
local function getIslandSound(mode)
local key = mode or "tap"
local cfg = ISLAND_SFX_CFG[key] or ISLAND_SFX_CFG.tap
local snd = State.CachedIslandSfx[key]
if not (snd and snd.Parent) then
snd = Instance.new("Sound")
snd.Name = "ChilliV8_Sfx_" .. key
snd.SoundId = cfg.id
snd.Volume = cfg.vol
snd.PlaybackSpeed = cfg.spd
snd.Parent = SoundService
State.CachedIslandSfx[key] = snd
end
return snd
end
task.defer(function()
pcall(function()
for k in pairs(ISLAND_SFX_CFG) do getIslandSound(k) end
end)
end)
local function playIslandSfx(mode)
pcall(function()
local snd = getIslandSound(mode)
snd.TimePosition = 0
if SoundService.PlayLocalSound then
pcall(function() SoundService:PlayLocalSound(snd) end)
end
pcall(function() snd:Play() end)
end)
end
local function setupIsland(statusLbl, venyxGui)
local pill = statusLbl.Parent
if not (pill and pill:IsA("GuiObject")) then return end
if isFpsTxt(statusLbl.Text) then return end
statusLbl:SetAttribute("__IslandDone", true)
State.ActiveStatusLbl = statusLbl
local keptBadge = nil
for _, ch in ipairs(pill:GetChildren()) do
if (ch:IsA("UIGradient") and ch.Name ~= "LiquidGlassSheen") or ch.Name == "IslandClickHitbox" or ch.Name == "ChilliHeaderLogo" or ch.Name == "ChilliCircleDisc" then
pcall(ch.Destroy, ch)
elseif ch.Name == "IslandLogoBadge" then
if not keptBadge then
keptBadge = ch
else
pcall(ch.Destroy, ch)
end
elseif ch:IsA("Frame") or ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
if ch ~= statusLbl and ch.Name ~= "IslandExpandHint" and ch.Name ~= "LiquidGlassTopSpecular" then
ch.Visible = false
end
end
end
pill.BackgroundColor3 = Color3.new(1, 1, 1)
pill.BackgroundTransparency = 0
pill.Size = u2(0, 0, 0, 38)
pill.AutomaticSize = Enum.AutomaticSize.X
local glassGrad = pill:FindFirstChild("LiquidGlassSheen") or mk("UIGradient", {
Name = "LiquidGlassSheen",
Rotation = 90,
Color = LIQUID_GLASS_COLOR,
Transparency = LIQUID_GLASS_TRANS
}, pill)
glassGrad.Rotation = 90
glassGrad.Color = LIQUID_GLASS_COLOR
glassGrad.Transparency = LIQUID_GLASS_TRANS

if pill:GetAttribute("__LockedIslandBg") ~= SID then
pill:SetAttribute("__LockedIslandBg", SID)
pill:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
if isAlive() and pill.BackgroundColor3 ~= Color3.new(1, 1, 1) then
pill.BackgroundColor3 = Color3.new(1, 1, 1)
end
end)
pill:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
if isAlive() and pill.BackgroundTransparency ~= 0 then
pill.BackgroundTransparency = 0
end
end)
pill:GetPropertyChangedSignal("Size"):Connect(function()
if isAlive() and not State.MorphingMiniIsland and pill.Size.Y.Offset < 36 then
pill.Size = u2(0, 0, 0, 38)
end
end)
pill:GetPropertyChangedSignal("Position"):Connect(function()
if isAlive() and not State.DraggingIsland and pill.Position.Y.Offset > 14 then
pill.Position = State.IslandUserPos or u2(0.5, 0, 0, 6)
end
end)
end

local pillLayout = pill:FindFirstChildOfClass("UIListLayout")
if not pillLayout then
pillLayout = mk("UIListLayout", {
Parent = pill,
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 8),
SortOrder = Enum.SortOrder.LayoutOrder
})
else
pillLayout.FillDirection = Enum.FillDirection.Horizontal
pillLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
pillLayout.VerticalAlignment = Enum.VerticalAlignment.Center
pillLayout.Padding = UDim.new(0, 8)
end

local pad = pill:FindFirstChildOfClass("UIPadding") or mk("UIPadding", {}, pill)
pad.PaddingLeft = UDim.new(0, 12)
pad.PaddingRight = UDim.new(0, 12)
pad.PaddingTop = UDim.new(0, 2)
pad.PaddingBottom = UDim.new(0, 2)

local leftBadge = pill:FindFirstChild("IslandLogoBadge")
local lbStroke = nil
if not leftBadge then
leftBadge = mk("Frame", { Name = "IslandLogoBadge", LayoutOrder = 1, Size = u2(0, 28, 0, 28), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = -10, Active = false, ZIndex = 10000 }, pill)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, leftBadge)
local lbImg = mk("ImageLabel", { Name = "LogoImg", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.86, 0.86), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = 10001 }, leftBadge)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, lbImg)
lbStroke = mk("UIStroke", { Thickness = 1.2, Color = c3(65, 195, 255), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, lbImg)
else
leftBadge.Size = u2(0, 28, 0, 28)
leftBadge.BackgroundColor3 = c3(0, 0, 0)
leftBadge.Active = false
local lbImg = leftBadge:FindFirstChildOfClass("ImageLabel")
if lbImg then
lbImg.Image = LOGO_ID
lbImg.Size = u2s(0.86, 0.86)
lbImg.ScaleType = Enum.ScaleType.Crop
if not lbImg:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, lbImg) end
lbStroke = lbImg:FindFirstChildOfClass("UIStroke")
end
end

local hint = pill:FindFirstChild("IslandExpandHint")
if not hint then
hint = mk("TextLabel", { Name = "IslandExpandHint", LayoutOrder = 3, Size = u2(0, 24, 0, 22), BackgroundColor3 = c3(22, 32, 54), BackgroundTransparency = 0.18, BorderSizePixel = 0, Text = "▼", Font = Enum.Font.GothamBlack, TextSize = 10, TextColor3 = c3(205, 238, 255), LayoutOrder = 99, Active = true, ZIndex = 10000 }, pill)
else
hint.Size = u2(0, 24, 0, 22)
hint.BackgroundColor3 = c3(22, 32, 54)
hint.BackgroundTransparency = 0.18
hint.Text = "▼"
hint.Font = Enum.Font.GothamBlack
hint.TextSize = 10
hint.TextColor3 = c3(205, 238, 255)
end
if not hint:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hint) end
local hStroke = hint:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.1, Color = c3(135, 215, 255), Transparency = 0.25 }, hint)
hStroke.Color = c3(135, 215, 255)
hStroke.Transparency = 0.25

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
statusLbl.LayoutOrder = 2
statusLbl.AutomaticSize = Enum.AutomaticSize.XY
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextSize = 13
statusLbl.TextColor3 = Color3.new(1, 1, 1)
statusLbl.TextTransparency = 0
statusLbl.Text = out
if expTaskLbl and expTaskLbl.Parent then expTaskLbl.Text = "⚡ " .. out end
statusLbl:SetAttribute("__Updating", false)
end
State.RefreshIslandCallback = function() syncStatus(true) end
syncStatus(false)

if statusLbl:GetAttribute("__LockedStatusColor") ~= SID then
statusLbl:SetAttribute("__LockedStatusColor", SID)
statusLbl:GetPropertyChangedSignal("TextColor3"):Connect(function()
if isAlive() and statusLbl.TextColor3 ~= Color3.new(1, 1, 1) then
statusLbl.TextColor3 = Color3.new(1, 1, 1)
end
end)
statusLbl:GetPropertyChangedSignal("TextTransparency"):Connect(function()
if isAlive() and statusLbl.TextTransparency ~= 0 then
statusLbl.TextTransparency = 0
end
end)
statusLbl:GetPropertyChangedSignal("Text"):Connect(function()
if isAlive() and not statusLbl:GetAttribute("__Updating") then
syncStatus(false)
end
end)
end

local stStroke = statusLbl:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.15, Color = c3(8, 12, 22), Transparency = 0.22 }, statusLbl)
stStroke.Thickness = 1.15
stStroke.Color = c3(8, 12, 22)
stStroke.Transparency = 0.22
local tg = statusLbl:FindFirstChild("TextRainbow")
if tg then tg:Destroy() end
statusLbl.TextColor3 = Color3.new(1, 1, 1)

local exp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if statusLbl:GetAttribute("__IslandSession") == SID and exp then return end
statusLbl:SetAttribute("__IslandSession", SID)
for _, r in ipairs(getScanRoots()) do
for _, d in ipairs(r:GetDescendants()) do
if d.Name == "ChilliV5_ExpandedIsland" then
pcall(d.Destroy, d)
end
end
end

pill.Parent = venyxGui
pill.AnchorPoint = v2(0.5, 0)
pill.ZIndex = 9999
pill.Active = true
pill.Visible = true
statusLbl.Active = false
hint.Active = true
pill.Position = State.IslandUserPos or u2(0.5, 0, 0, 6)
if not pill:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pill) end
local ps = pill:FindFirstChild("IslandStroke") or mk("UIStroke", { Name = "IslandStroke", Thickness = 1.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = c3(55, 205, 255), Transparency = 0.12 }, pill)
local oldPsGrad = ps:FindFirstChildOfClass("UIGradient")
if oldPsGrad then oldPsGrad:Destroy() end
ps.Color = c3(55, 205, 255)
ps.Thickness = 1.5
ps.Transparency = 0.12

-- ============================================================================
-- DYNAMIC ISLAND LIQUID GLASS PANEL & MODERN BUTTONS
-- ============================================================================
local COLLAPSED_EXP_H = 166
local OPEN_NOTE_EXP_H = 266
exp = mk("Frame", {
Name = "ChilliV5_ExpandedIsland",
AnchorPoint = v2(0.5, 0),
Position = pill.Position,
Size = u2(0, 312, 0, COLLAPSED_EXP_H),
BackgroundColor3 = Color3.new(1, 1, 1),
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Visible = false,
Active = true,
ClipsDescendants = true,
ZIndex = 10000
}, venyxGui)

if pill:GetAttribute("__LockedIslandVis") ~= SID then
pill:SetAttribute("__LockedIslandVis", SID)
pill:GetPropertyChangedSignal("Visible"):Connect(function()
if isAlive() and exp and exp.Parent and not exp.Visible and not pill.Visible then
pill.Visible = true
end
end)
end

mk("UICorner", { CornerRadius = UDim.new(0, 20) }, exp)
mk("UIGradient", {
Name = "LiquidGlassPanelGrad",
Rotation = 90,
Color = ColorSequence.new({
csk(0.00, c3(34, 48, 78)),
csk(0.22, c3(16, 22, 38)),
csk(0.78, c3(10, 14, 24)),
csk(1.00, c3(22, 34, 58))
}),
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0.00, 0.06),
NumberSequenceKeypoint.new(0.30, 0.10),
NumberSequenceKeypoint.new(1.00, 0.06)
})
}, exp)

local expStroke = mk("UIStroke", { Thickness = 1.6, Color = c3(85, 195, 255), Transparency = 0.14, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, exp)
mk("Frame", {
Name = "LiquidGlassTopSpecular",
AnchorPoint = v2(0.5, 0),
Position = u2(0.5, 0, 0, 1),
Size = u2(1, -16, 0, 18),
BackgroundColor3 = Color3.new(1, 1, 1),
BackgroundTransparency = 0.78,
BorderSizePixel = 0,
Active = false,
ZIndex = 10001
}, exp)
mk("ImageLabel", { Name = "IslandCosmicBg", Position = u2(0, 0, 0, 0), Size = u2(1, 0, 0, 42), BackgroundTransparency = 1, Image = HEADER_BAR_IMG_ID, ImageRectOffset = v2(15, 60), ImageRectSize = v2(650, 170), ScaleType = Enum.ScaleType.Stretch, ImageTransparency = 0.28, Active = false, ZIndex = 10000 }, exp)

local expLogo = mk("Frame", { Position = u2(0, 10, 0, 7), Size = u2(0, 26, 0, 26), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 10002 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, expLogo)
mk("UIStroke", { Thickness = 1.2, Color = c3(95, 195, 255) }, expLogo)
local expLogoImg = mk("ImageLabel", { AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(1, 1), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = 10003 }, expLogo)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, expLogoImg)

local colBtn = mk("TextButton", { Size = u2(0, 28, 0, 22), Position = u2(1, -36, 0, 8), BackgroundColor3 = c3(26, 36, 58), BackgroundTransparency = 0.15, BorderSizePixel = 0, Text = "▲", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = c3(195, 235, 255), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, colBtn)
mk("UIStroke", { Thickness = 1, Color = c3(120, 200, 255), Transparency = 0.35 }, colBtn)

local ISLAND_CYCLE_STATES = {
{
text = "Đang rảnh",
icon = "⚡",
stroke = c3(55, 210, 255),
bg = c3(18, 30, 54),
grad = ColorSequence.new({
csk(0.00, c3(65, 155, 255)),
csk(0.35, c3(22, 42, 78)),
csk(1.00, c3(12, 20, 38))
})
},
{
text = "Tự động cướp",
icon = "🔥",
stroke = c3(255, 110, 45),
bg = c3(48, 20, 22),
grad = ColorSequence.new({
csk(0.00, c3(245, 80, 45)),
csk(0.35, c3(78, 24, 26)),
csk(1.00, c3(28, 12, 16))
})
},
{
text = "Hoàn thành",
icon = "✅",
stroke = c3(50, 255, 145),
bg = c3(16, 46, 30),
grad = ColorSequence.new({
csk(0.00, c3(45, 210, 120)),
csk(0.35, c3(18, 62, 40)),
csk(1.00, c3(10, 26, 18))
})
}
}

local curIslandStateIdx = 1
local miniIslandAnimToken = 0
local taskBox = mk("TextButton", { Name = "IslandTaskCycleBtn", Size = u2(1, -20, 0, 25), Position = u2(0, 10, 0, 36), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.05, BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, taskBox)
local taskBoxGrad = mk("UIGradient", {
Name = "TaskBoxStateGrad",
Rotation = 90,
Color = ISLAND_CYCLE_STATES[1].grad
}, taskBox)
local taskBoxStroke = mk("UIStroke", { Thickness = 1.3, Color = c3(55, 210, 255), Transparency = 0.16, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, taskBox)
expTaskLbl = mk("TextLabel", { Size = u2(1, -16, 1, 0), Position = u2(0, 8, 0, 0), BackgroundTransparency = 1, Text = "⚡ " .. (statusLbl.Text or "Đang rảnh"), Font = Enum.Font.GothamBold, TextSize = 10.8, TextColor3 = Color3.new(1, 1, 1), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 10002 }, taskBox)

local function cycleMiniIslandState()
playIslandSfx("tap")
curIslandStateIdx = (curIslandStateIdx % #ISLAND_CYCLE_STATES) + 1
local st = ISLAND_CYCLE_STATES[curIslandStateIdx]
miniIslandAnimToken = miniIslandAnimToken + 1
local myToken = miniIslandAnimToken
State.MorphingMiniIsland = true

if expTaskLbl and expTaskLbl.Parent then
expTaskLbl.Text = st.icon .. " " .. st.text
end
if statusLbl and statusLbl.Parent then
statusLbl:SetAttribute("__Updating", true)
statusLbl.Text = st.icon .. " " .. st.text
statusLbl:SetAttribute("__Updating", false)
end

local fastExpandInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
if glassGrad and glassGrad.Parent then
glassGrad.Color = st.grad
end
if pill and pill.Parent then
TweenService:Create(pill, fastExpandInfo, { Size = u2(0, 42, 0, 44) }):Play()
end
if pad and pad.Parent then
TweenService:Create(pad, fastExpandInfo, { PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 22) }):Play()
end
if ps and ps.Parent then
TweenService:Create(ps, fastExpandInfo, { Color = st.stroke, Thickness = 2.5, Transparency = 0 }):Play()
end
if leftBadge and leftBadge.Parent then
TweenService:Create(leftBadge, fastExpandInfo, { Size = u2(0, 31, 0, 31) }):Play()
end
if lbStroke and lbStroke.Parent then
TweenService:Create(lbStroke, fastExpandInfo, { Color = st.stroke, Thickness = 1.8 }):Play()
end
if hStroke and hStroke.Parent then
TweenService:Create(hStroke, fastExpandInfo, { Color = st.stroke, Transparency = 0.08 }):Play()
end

if taskBoxGrad and taskBoxGrad.Parent then
taskBoxGrad.Color = st.grad
end
if taskBox and taskBox.Parent then
TweenService:Create(taskBox, fastExpandInfo, { Size = u2(1, -10, 0, 29), Position = u2(0, 5, 0, 34), BackgroundTransparency = 0 }):Play()
end
if taskBoxStroke and taskBoxStroke.Parent then
TweenService:Create(taskBoxStroke, fastExpandInfo, { Color = st.stroke, Thickness = 2.3, Transparency = 0 }):Play()
end
if expStroke and expStroke.Parent then
TweenService:Create(expStroke, fastExpandInfo, { Color = st.stroke, Thickness = 2.1, Transparency = 0.02 }):Play()
end

task.delay(0.28, function()
if not isAlive() or myToken ~= miniIslandAnimToken then return end
local fastShrinkInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
if pill and pill.Parent then
TweenService:Create(pill, fastShrinkInfo, { Size = u2(0, 0, 0, 38) }):Play()
end
if pad and pad.Parent then
TweenService:Create(pad, fastShrinkInfo, { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }):Play()
end
if ps and ps.Parent then
TweenService:Create(ps, fastShrinkInfo, { Color = st.stroke, Thickness = 1.6, Transparency = 0.12 }):Play()
end
if leftBadge and leftBadge.Parent then
TweenService:Create(leftBadge, fastShrinkInfo, { Size = u2(0, 28, 0, 28) }):Play()
end
if lbStroke and lbStroke.Parent then
TweenService:Create(lbStroke, fastShrinkInfo, { Color = st.stroke, Thickness = 1.2 }):Play()
end
if taskBox and taskBox.Parent then
TweenService:Create(taskBox, fastShrinkInfo, { Size = u2(1, -20, 0, 25), Position = u2(0, 10, 0, 36), BackgroundTransparency = 0.05 }):Play()
end
if taskBoxStroke and taskBoxStroke.Parent then
TweenService:Create(taskBoxStroke, fastShrinkInfo, { Color = st.stroke, Thickness = 1.3, Transparency = 0.16 }):Play()
end
if expStroke and expStroke.Parent then
TweenService:Create(expStroke, fastShrinkInfo, { Color = st.stroke, Thickness = 1.6, Transparency = 0.14 }):Play()
end
task.delay(0.14, function()
if myToken == miniIslandAnimToken then
State.MorphingMiniIsland = false
end
end)
end)
end

taskBox.MouseButton1Click:Connect(cycleMiniIslandState)

local cap = mk("Frame", { Size = u2(1, -20, 0, 28), Position = u2(0, 10, 0, 65), BackgroundColor3 = c3(18, 24, 38), BackgroundTransparency = 0.12, BorderSizePixel = 0, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cap)
mk("UIStroke", { Thickness = 1, Color = c3(90, 145, 225), Transparency = 0.42 }, cap)
local sld = mk("Frame", { Size = u2(0.5, -4, 1, -4), Position = (State.Language == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 10002 }, cap)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, sld)
mk("UIGradient", {
Rotation = 90,
Color = ColorSequence.new({
csk(0.00, c3(95, 145, 255)),
csk(1.00, c3(65, 95, 225))
})
}, sld)
local bVI = mk("TextButton", { Size = u2(0.5, 0, 1, 0), BackgroundTransparency = 1, Text = "🇻🇳 TIẾNG VIỆT", Font = Enum.Font.GothamBold, TextSize = 10.2, TextColor3 = (State.Language == "VI" and Color3.new(1, 1, 1) or c3(160, 180, 210)), ZIndex = 10003 }, cap)
local bEN = mk("TextButton", { Size = u2(0.5, 0, 1, 0), Position = u2(0.5, 0, 0, 0), BackgroundTransparency = 1, Text = "🌐 ENGLISH", Font = Enum.Font.GothamBold, TextSize = 10.2, TextColor3 = (State.Language == "EN" and Color3.new(1, 1, 1) or c3(160, 180, 210)), ZIndex = 10003 }, cap)

local cfgBtn = mk("TextButton", { Name = "AutoFarmConfigBtn", Size = u2(1, -20, 0, 30), Position = u2(0, 10, 0, 97), BackgroundColor3 = c3(22, 26, 42), BackgroundTransparency = 0.06, BorderSizePixel = 0, Text = "⚡ CONFIG SETTING AUTO FARM", Font = Enum.Font.GothamBlack, TextSize = 10.4, TextColor3 = c3(255, 232, 115), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cfgBtn)
mk("UIStroke", { Thickness = 1.3, Color = c3(245, 195, 75), Transparency = 0.16, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, cfgBtn)
cfgBtn.MouseButton1Click:Connect(function() playIslandSfx("action") runAutoFarmMacro(venyxGui, cfgBtn) end)

local noteBtn = mk("TextButton", { Name = "SettingNoteToggleBtn", Size = u2(1, -20, 0, 25), Position = u2(0, 10, 0, 132), BackgroundColor3 = c3(20, 28, 46), BackgroundTransparency = 0.12, BorderSizePixel = 0, Text = "", AutoButtonColor = true, ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, noteBtn)
mk("UIStroke", { Thickness = 1, Color = c3(85, 145, 225), Transparency = 0.30, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, noteBtn)
local noteBadge = mk("Frame", { Name = "NoteNewBadge", AnchorPoint = v2(0, 0.5), Position = u2(0, 6, 0.5, 0), Size = u2(0, 54, 0, 17), BackgroundColor3 = c3(32, 22, 56), BorderSizePixel = 0, Active = false, ZIndex = 10004 }, noteBtn)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, noteBadge)
mk("UIStroke", { Thickness = 1, Color = c3(245, 195, 75), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, noteBadge)
mk("TextLabel", { Name = "BadgeTxt", Size = u2s(1, 1), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 8.5, TextColor3 = c3(255, 230, 95), Text = "👑 MỚI", Active = false, ZIndex = 10005 }, noteBadge)
local noteSmallLbl = mk("TextLabel", { Name = "NoteSmallTitle", Size = u2(1, -86, 1, 0), Position = u2(0, 66, 0, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 9.6, TextColor3 = c3(215, 235, 255), TextXAlignment = Enum.TextXAlignment.Left, Text = "Setting Auto Farm (Bấm xem note)", Active = false, ZIndex = 10004 }, noteBtn)
local noteArrowLbl = mk("TextLabel", { Name = "NoteArrow", Size = u2(0, 18, 1, 0), Position = u2(1, -22, 0, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 10, TextColor3 = c3(165, 225, 255), Text = "▼", Active = false, ZIndex = 10004 }, noteBtn)
local noteDrawer = mk("Frame", { Name = "SettingNoteDrawer", Size = u2(1, -20, 0, 96), Position = u2(0, 10, 0, 161), BackgroundColor3 = c3(14, 18, 30), BackgroundTransparency = 0.06, BorderSizePixel = 0, Visible = false, ClipsDescendants = true, ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(0, 12) }, noteDrawer)
mk("UIStroke", { Thickness = 1.1, Color = c3(80, 130, 205), Transparency = 0.22, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, noteDrawer)
mk("TextLabel", { Size = u2(1, -96, 0, 18), Position = u2(0, 10, 0, 4), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 9.5, TextColor3 = c3(255, 225, 95), TextXAlignment = Enum.TextXAlignment.Left, Text = "⚡ SETTING AUTO FARM", ZIndex = 10004 }, noteDrawer)
local vipBadge = mk("Frame", { AnchorPoint = v2(1, 0), Position = u2(1, -8, 0, 4), Size = u2(0, 82, 0, 16), BackgroundColor3 = c3(20, 34, 28), BorderSizePixel = 0, ZIndex = 10004 }, noteDrawer)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, vipBadge)
mk("UIStroke", { Thickness = 1, Color = c3(85, 255, 165), Transparency = 0.2 }, vipBadge)
mk("TextLabel", { Name = "BadgeTxt", Size = u2s(1, 1), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 8.0, TextColor3 = c3(110, 255, 175), Text = "🛡️ VIP 24/7", ZIndex = 10005 }, vipBadge)
local l1 = mk("TextLabel", { Size = u2(1, -14, 0, 18), Position = u2(0, 7, 0, 23), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 8.2, TextScaled = true, TextColor3 = c3(235, 245, 255), TextXAlignment = Enum.TextXAlignment.Left, Text = "+ Tự động săn trứng Secret 1B+ (phù hợp cho tất cả thiết bị, người chơi)", ZIndex = 10004 }, noteDrawer)
mk("UITextSizeConstraint", { MaxTextSize = 8.5, MinTextSize = 6.5 }, l1)
mk("TextLabel", { Size = u2(1, -14, 0, 17), Position = u2(0, 7, 0, 41), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 8.8, TextColor3 = c3(220, 235, 255), TextXAlignment = Enum.TextXAlignment.Left, Text = "+ Tự động làm tất cả nhiệm vụ sự kiện (A-Z)", ZIndex = 10004 }, noteDrawer)
mk("TextLabel", { Size = u2(1, -14, 0, 17), Position = u2(0, 7, 0, 59), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 8.8, TextColor3 = c3(255, 230, 145), TextXAlignment = Enum.TextXAlignment.Left, Text = "+ Chạy máy chạy bộ và bán pet dưới 1B", ZIndex = 10004 }, noteDrawer)
mk("TextLabel", { Size = u2(1, -14, 0, 17), Position = u2(0, 7, 0, 76), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 9.0, TextColor3 = c3(95, 255, 165), TextXAlignment = Enum.TextXAlignment.Left, Text = "+++ Setting treo 24/7 không văng", ZIndex = 10004 }, noteDrawer)

local noteOpen = false
noteBtn.MouseButton1Click:Connect(function()
playIslandSfx("tap")
noteOpen = not noteOpen
if noteOpen then
noteDrawer.Visible = true
noteArrowLbl.Text = "▲"
noteSmallLbl.Text = "Setting Auto Farm (Bấm thu gọn)"
TweenService:Create(exp, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = u2(0, 312, 0, OPEN_NOTE_EXP_H) }):Play()
else
noteArrowLbl.Text = "▼"
noteSmallLbl.Text = "Setting Auto Farm (Bấm xem note)"
local nTw = TweenService:Create(exp, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = u2(0, 312, 0, COLLAPSED_EXP_H) })
nTw:Play()
nTw.Completed:Connect(function()
if not noteOpen then noteDrawer.Visible = false end
end)
end
end)

State.AntiAfkEnabled = true
if not State.AntiAfkHooked then
State.AntiAfkHooked = true
pcall(function()
LocalPlayer.Idled:Connect(function()
if State.AntiAfkEnabled then
pcall(function()
local cam = workspace.CurrentCamera
if cam then cam.CFrame = cam.CFrame end
end)
end
end)
end)
end

local function setLang(l)
playIslandSfx("tap")
if State.Language == l then return end
State.Language = l
if writefile then pcall(writefile, LANG_FILE, l) end
TweenService:Create(sld, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = (l == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)) }):Play()
bVI.TextColor3 = l == "VI" and Color3.new(1, 1, 1) or c3(160, 180, 210)
bEN.TextColor3 = l == "EN" and Color3.new(1, 1, 1) or c3(160, 180, 210)
refreshAllTexts()
end
bVI.MouseButton1Click:Connect(function() setLang("VI") end)
bEN.MouseButton1Click:Connect(function() setLang("EN") end)

local open, lastToggleClock = false, -10
local function toggle()
if os.clock() - lastToggleClock < 0.12 then return end
lastToggleClock = os.clock()
open = not open
playIslandSfx(open and "open" or "close")
if open then
exp.Position = pill.Position
local targetH = noteOpen and OPEN_NOTE_EXP_H or COLLAPSED_EXP_H
exp.Size = u2(0, 240, 0, 36)
exp.Visible = true
pill.Visible = false
TweenService:Create(exp, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = u2(0, 312, 0, targetH) }):Play()
else
local tw = TweenService:Create(exp, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Size = u2(0, 240, 0, 36) })
tw:Play()
tw.Completed:Connect(function()
if not open then
exp.Visible = false
pill.Visible = true
end
end)
end
end
State.CollapseIslandFn = function()
if open then toggle() end
end

if hint:IsA("GuiButton") then
hint.MouseButton1Click:Connect(toggle)
else
hint.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
toggle()
end
end)
end
colBtn.MouseButton1Click:Connect(toggle)

local lastPillTouchClock = -10
local function onIn(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
if os.clock() - lastPillTouchClock < 0.08 then return end
lastPillTouchClock = os.clock()
local start = i.Position
local startP = pill.Position
local dragConn, upConn, chgConn = nil, nil, nil
local hasMoved = false
local finished = false
local function finishInput()
if finished then return end
finished = true
if dragConn then dragConn:Disconnect() end
if upConn then upConn:Disconnect() end
if chgConn then chgConn:Disconnect() end
task.delay(0.05, function() State.DraggingIsland = false end)
if not hasMoved and not open then
cycleMiniIslandState()
end
end
dragConn = UserInputService.InputChanged:Connect(function(im)
if im.UserInputType == Enum.UserInputType.MouseMovement or im.UserInputType == Enum.UserInputType.Touch then
local d = im.Position - start
if math.abs(d.X) > 10 or math.abs(d.Y) > 10 then
hasMoved = true
State.DraggingIsland = true
local newPos = u2(startP.X.Scale, startP.X.Offset + d.X, startP.Y.Scale, startP.Y.Offset + d.Y)
pill.Position = newPos
State.IslandUserPos = newPos
if exp and exp.Visible then exp.Position = newPos end
end
end
end)
upConn = UserInputService.InputEnded:Connect(function(ie)
if ie.UserInputType == Enum.UserInputType.MouseButton1 or ie.UserInputType == Enum.UserInputType.Touch then
finishInput()
end
end)
if i.Changed then
chgConn = i.Changed:Connect(function()
if i.UserInputState == Enum.UserInputState.End or i.UserInputState == Enum.UserInputState.Cancel then
finishInput()
end
end)
end
end
end
pill.InputBegan:Connect(onIn)
statusLbl.InputBegan:Connect(onIn)
if leftBadge then leftBadge.InputBegan:Connect(onIn) end
end

local function cleanupStrayLogos(gui, win)
if not gui then return end
pcall(function()
if win then
for _, ch in ipairs(win:GetChildren()) do
if ch.Name == "ChilliCircleDisc" or ch.Name == "ChilliV5CoverLogo" or ch.Name == "PerfectCircleAspect" then
ch:Destroy()
end
end
end
for _, d in ipairs(gui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and (d.Text == "Vx" or d.Text == "VX") then
d:SetAttribute("__HiddenVxLogo", true)
d.TextTransparency = 1
end
end
end)
end

local function setupCircleLogo(obj, win)
if not obj or not obj:IsA("GuiObject") or obj == win then return end
if obj.Name == "ChilliV5_ExpandedIsland" or obj:FindFirstChild("IslandExpandHint") or obj:FindFirstChild("IslandLogoBadge") then return end
if obj.AbsoluteSize.X > 135 or obj.AbsoluteSize.Y > 135 or obj.AbsoluteSize.X < 18 or obj.AbsoluteSize.Y < 18 then return end
local top = obj
top:SetAttribute("__SizeLockedV5Pro", true)
top.BackgroundTransparency = 1
top.Size = u2(0, 62, 0, 62)
if not top:FindFirstChild("PerfectCircleAspect") then
mk("UIAspectRatioConstraint", { Name = "PerfectCircleAspect", AspectRatio = 1 }, top)
end
for _, ch in ipairs(top:GetDescendants()) do
if ch.Name ~= "ChilliCircleDisc" and ch.Name ~= "ChilliV5CoverLogo" and not ch:IsDescendantOf(top:FindFirstChild("ChilliCircleDisc") or top) then
if ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch:SetAttribute("__HiddenVxLogo", true)
ch.TextTransparency = 1
elseif ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
if ch.Name ~= "ChilliV5CoverLogo" then ch.ImageTransparency = 1 end
end
end
end
local disc = top:FindFirstChild("ChilliCircleDisc")
if not disc then
disc = mk("Frame", {
Name = "ChilliCircleDisc",
AnchorPoint = v2(0.5, 0.5),
Position = u2s(0.5, 0.5),
Size = u2s(1, 1),
BackgroundColor3 = c3(0, 0, 0),
BorderSizePixel = 0,
ClipsDescendants = true,
Active = false,
ZIndex = 50
}, top)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, disc)
end
local cov = disc:FindFirstChild("ChilliV5CoverLogo")
if not cov then
cov = mk("ImageLabel", {
Name = "ChilliV5CoverLogo",
AnchorPoint = v2(0.5, 0.5),
Position = u2s(0.5, 0.5),
Size = u2s(1, 1),
BackgroundTransparency = 1,
Image = LOGO_ID,
ScaleType = Enum.ScaleType.Crop,
Active = false,
ZIndex = 51
}, disc)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cov)
local covStroke = mk("UIStroke", {
Name = "RainbowBorder",
Thickness = 2.2,
Color = Color3.new(1, 1, 1),
ApplyStrokeMode = Enum.ApplyStrokeMode.Border
}, cov)
addGrad(mk("UIGradient", { Color = RAINBOW }, covStroke))
end
if not top:GetAttribute("__ChilliInstantToggleHooked") then
top:SetAttribute("__ChilliInstantToggleHooked", true)
local function onToggleTap()
State.CloseHideUntil = nil
if State.SyncWindowFn then pcall(State.SyncWindowFn) end
end
if top:IsA("GuiButton") then
top.MouseButton1Down:Connect(onToggleTap)
end
top.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
onToggleTap()
end
end)
for _, ch in ipairs(top:GetDescendants()) do
if ch:IsA("GuiButton") then
ch.MouseButton1Down:Connect(onToggleTap)
end
end
end
end

-- ============================================================================
-- [PHẦN 4] KIẾN TRÚC GIAO DIỆN CHÍNH DARK MODE V8 SUPREME (CHỐNG LAG & SIDEBAR UIListLayout)
-- ============================================================================
local PAGE_HEADER_TITLES = {
["dashboard"] = true, ["home"] = true, ["trang chủ"] = true,
["steal"] = true, ["săn trứng"] = true, ["lấy trứng"] = true, ["cướp trứng"] = true,
["farm"] = true, ["tự cày"] = true, ["tự động cày"] = true,
["events"] = true, ["event"] = true, ["sự kiện"] = true,
["player"] = true, ["localplayer"] = true, ["nhân vật"] = true, ["người chơi"] = true,
["misc"] = true, ["miscellaneous"] = true, ["chức năng khác"] = true, ["khác"] = true,
["settings"] = true, ["setting"] = true, ["cài đặt"] = true, ["hệ thống"] = true, ["system"] = true
}

local function isProfileOrPlayerInfo(d)
if not d or not d:IsA("TextLabel") then return false end
local lp = game:GetService("Players").LocalPlayer
local pName = lp and lp.Name or ""
local pDisplay = lp and lp.DisplayName or ""
local t = d.Text or ""
local tLow = t:lower()
if (pName ~= "" and t:find(pName, 1, true)) or (pDisplay ~= "" and t:find(pDisplay, 1, true)) then
return true
end
if tLow:find("chào mừng") or tLow:find("welcome") or tLow:find("delta") or tLow:find("sae") or tLow:find("chilli") then
return true
end
local par = d.Parent
if par and (par:FindFirstChildOfClass("ImageLabel") or par:FindFirstChildOfClass("ImageButton")) then
return true
end
local gpar = par and par.Parent
if gpar and (gpar:FindFirstChildOfClass("ImageLabel") or gpar:FindFirstChildOfClass("ImageButton")) then
return true
end
return false
end

local function applySenaV8Architecture(win, titleLbl)
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
for _, bf in ipairs(bgFrames) do bf.BackgroundColor3 = c3(10, 12, 20) end
win.ClipsDescendants = true
end)
local strokeTarget = mainBg or win
local winStroke = strokeTarget:FindFirstChild("ChilliProWindowStroke") or win:FindFirstChild("ChilliProWindowStroke")
if not winStroke then
winStroke = mk("UIStroke", { Name = "ChilliProWindowStroke", Thickness = 1.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = c3(55, 72, 110), Transparency = 0.2 }, strokeTarget)
else
local oldWg = winStroke:FindFirstChildOfClass("UIGradient")
if oldWg then oldWg:Destroy() end
winStroke.Color = c3(55, 72, 110)
winStroke.Thickness = 1.4
winStroke.Transparency = 0.2
end
local wpParent = mainBg or win
local wp = wpParent:FindFirstChild("ChilliSenaWallpaper") or win:FindFirstChild("ChilliSenaWallpaper")
if not wp then
wp = mk("ImageLabel", {
Name = "ChilliSenaWallpaper", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2s(1, 1), BackgroundColor3 = c3(6, 8, 14), BackgroundTransparency = 0.06,
Image = WALLPAPER_IMAGE_ID, ImageColor3 = Color3.new(1, 1, 1), ImageTransparency = 0.05,
ResampleMode = Enum.ResamplerMode.Default, ScaleType = Enum.ScaleType.Crop,
Active = false, Selectable = false, ZIndex = 0
}, wpParent)
mk("UICorner", { CornerRadius = UDim.new(0, 10) }, wp)
else
wp.Image = WALLPAPER_IMAGE_ID
wp.ImageColor3 = Color3.new(1, 1, 1)
wp.ImageTransparency = 0.05
wp.BackgroundColor3 = c3(6, 8, 14)
wp.BackgroundTransparency = 0.06
wp.ZIndex = 0
end
local pageWallpapers = { wp }
local sectionCards = {}
local curBaseOpacity = (mainBg.BackgroundTransparency < 0.95) and mainBg.BackgroundTransparency or 0.15

if not State.MenuInteriorStyled then
State.MenuInteriorStyled = true
local cardT = 0.58
for _, d in ipairs(win:GetDescendants()) do
if not d:GetAttribute("__ChilliElemStyled") then
if d:IsA("ScrollingFrame") and (not d:FindFirstAncestorOfClass("ScrollingFrame")) and (d.AbsolutePosition.X - winX) > 35 and (d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.50) and (d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.40) then
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundTransparency = 1
d.ScrollingEnabled = true
if d.ZIndex < 3 then d.ZIndex = 3 end
local p = d.Parent
while p and p ~= win and p ~= mainBg do
if p:IsA("GuiObject") and p.AbsoluteSize.X >= win.AbsoluteSize.X * 0.42 and (p.AbsolutePosition.X - winX) > 28 then
p.BackgroundTransparency = 1
end
p = p.Parent
end
elseif d:IsA("Frame") and not d.Name:find("^Chilli") and not d:FindFirstAncestorOfClass("ScrollingFrame") and d ~= win and d ~= mainBg then
if d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.48 and d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.38 and (d.AbsolutePosition.X - winX) > 28 then
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundTransparency = 1
end
elseif d:IsA("Frame") and not d.Name:find("^Chilli") and d:FindFirstAncestorOfClass("ScrollingFrame") ~= nil and d.AbsoluteSize.X >= 145 and d.AbsoluteSize.Y >= 38 and d.BackgroundTransparency < 0.94 and d:FindFirstChildOfClass("UICorner") ~= nil then
d:SetAttribute("__IsChilliCard", true)
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundColor3 = c3(10, 12, 22)
d.BackgroundTransparency = cardT
table.insert(sectionCards, d)
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
mainBg.BackgroundTransparency = math.clamp(curT + 0.72, 0.88, 0.98)
end
for i = 2, #bgFrames do
local bf = bgFrames[i]
if bf and bf.Parent and bf ~= mainBg then
bf.BackgroundTransparency = 1
end
end
wp.ImageTransparency = math.clamp(0.05 + curT * 0.35, 0.04, 0.65)
wp.BackgroundTransparency = math.clamp(0.06 + curT * 0.40, 0.05, 0.70)
local cardT = math.clamp(0.54 + curT * 0.30, 0.50, 0.85)
for i = #sectionCards, 1, -1 do
local card = sectionCards[i]
if card and card.Parent then
card.BackgroundTransparency = cardT
else
table.remove(sectionCards, i)
end
end
syncingOpacity = false
end
for _, bf in ipairs(bgFrames) do
if not bf:GetAttribute("__WpSyncHooked") then
bf:SetAttribute("__WpSyncHooked", true)
bf:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() syncWallpaperAndOldBg(bf) end)
end
end
pcall(syncWallpaperAndOldBg, nil)
pcall(function()
local oldCosmicHolder = win:FindFirstChild("ChilliCosmicHolder")
if oldCosmicHolder then oldCosmicHolder:Destroy() end
local oldHeaderOv = wpParent:FindFirstChild("ChilliHeaderOverlay")
if oldHeaderOv then oldHeaderOv:Destroy() end
local oldBotBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if oldBotBar then oldBotBar:Destroy() end
local oldTGrad = titleLbl:FindFirstChild("TitleUltraGrad")
if oldTGrad then oldTGrad:Destroy() end
titleLbl.TextTransparency = 0
titleLbl.TextColor3 = Color3.new(1, 1, 1)
titleLbl.Font = Enum.Font.GothamBold
end)

-- 1. CƠ CHẾ CHỐNG LAG KHI MỞ/TẮT MENU: Chỉ thao tác Visible, KHÔNG DÙNG TWEEN UISCALE ĐỂ TRÁNH DELAY & LỆCH HƯỚNG
local fullWinSize = win.Size
local winScale = win:FindFirstChild("ChilliFastOpenScale")
if winScale then winScale:Destroy() end
local lastWasOpen = false
local function syncWindowVisibilityInstant()
if not win or not win.Parent then return end
local isOffscreen = (win.AbsolutePosition.X < -500 or win.AbsolutePosition.Y < -500)
local isSizeZero = (win.AbsoluteSize.X < 24 or win.AbsoluteSize.Y < 24)
local isForceClosing = (State.CloseHideUntil ~= nil) and (os.clock() < State.CloseHideUntil)
local isOpen = not ((not win.Visible) or isOffscreen or isSizeZero or isForceClosing)
if winStroke then
winStroke.Enabled = isOpen
winStroke.Transparency = isOpen and 0.2 or 1
end
for _, pw in ipairs(pageWallpapers) do if pw and pw.Parent then pw.Visible = isOpen end end
if titleLbl and titleLbl.Parent then titleLbl.TextTransparency = 0 end
lastWasOpen = isOpen
end
State.SyncWindowFn = syncWindowVisibilityInstant
syncWindowVisibilityInstant()

if not win:GetAttribute("__InstantHideHooked") then
win:SetAttribute("__InstantHideHooked", true)
win:GetPropertyChangedSignal("Visible"):Connect(function()
if win.Visible then State.CloseHideUntil = nil end
syncWindowVisibilityInstant()
end)
win:GetPropertyChangedSignal("Size"):Connect(function()
if win.AbsoluteSize.Y > 85 then State.CloseHideUntil = nil end
syncWindowVisibilityInstant()
end)
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
State.CloseHideUntil = os.clock() + 0.15
if winStroke then winStroke.Enabled = false end
for _, pw in ipairs(pageWallpapers) do if pw and pw.Parent then pw.Visible = false end end
end)
end
end
end
end
end

-- ============================================================================
-- 2. CỤM NÚT TAB (SIDEBAR) THON GỌN (120px) CHỈ DÙNG UIListLayout
-- ============================================================================
local SIDEBAR_PALETTE = {
c3(37, 99, 235),   -- Tab 1: Trang chủ (Xanh biển)
c3(239, 68, 68),   -- Tab 2: Lấy trứng (Đỏ rực)
c3(245, 158, 11),  -- Tab 3: Tự cày (Cam hổ phách)
c3(168, 85, 247),  -- Tab 4: Sự kiện (Tím neon)
c3(236, 72, 153),  -- Tab 5: Nhân vật (Hồng cánh sen)
c3(16, 185, 129),  -- Tab 6: Cài đặt (Xanh lục bảo)
c3(14, 165, 233),  -- Tab 7: Máy chủ (Xanh Cyan)
c3(139, 92, 246)   -- Tab 8: Khác (Tím Violet)
}
local SIDEBAR_TAB_BILINGUAL = {
{ vi = "Trang chủ", en = "Home", icon = "" },
{ vi = "Lấy trứng", en = "Steal", icon = STEAL_TAB_ICON_ID },
{ vi = "Tự cày", en = "Farm", icon = "" },
{ vi = "Sự kiện", en = "Events", icon = "" },
{ vi = "Nhân vật", en = "Player", icon = "" },
{ vi = "Cài đặt", en = "Settings", icon = "" },
{ vi = "Máy chủ", en = "Server", icon = "" },
{ vi = "Khác", en = "Misc", icon = "" }
}

pcall(function()
local navButtons = {}
local navContainer = nil
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and (d.AbsolutePosition.X - winX) < 165 and d.AbsolutePosition.Y > hy + 15 then
local children = {}
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("GuiObject") and ch.AbsoluteSize.X >= 20 and ch.AbsoluteSize.X <= 175 and ch.AbsoluteSize.Y >= 20 and ch.AbsoluteSize.Y <= 90 then
ch.Visible = true
table.insert(children, ch)
end
end
if #children >= 5 and #children <= 8 then
navContainer = d
State.ActiveNavContainer = d
if d.ZIndex < 15 then d.ZIndex = 15 end
for _, nb in ipairs(children) do
if nb.ZIndex < 16 then nb.ZIndex = 16 end
end
navButtons = children
break
end
end
end

if #navButtons >= 2 then
table.sort(navButtons, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)
local CONTENT_START_X = 142

pcall(function()
if navContainer then
navContainer.Parent = win
navContainer.Position = u2(0, 10, 0, 46)
navContainer.Size = u2(0, 120, 1, -55)
navContainer.ClipsDescendants = false
navContainer.BackgroundTransparency = 1

for _, ch in ipairs(navContainer:GetChildren()) do
if ch:IsA("UIPadding") or ch:IsA("UIGridLayout") then
ch:Destroy()
end
end
local listLayout = navContainer:FindFirstChildOfClass("UIListLayout") or mk("UIListLayout", { Parent = navContainer })
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)
end

local function shiftContentTarget(sib)
if not sib or not sib:IsA("GuiObject") or sib == win or sib == mainBg or sib == navContainer or sib:IsDescendantOf(navContainer) or navContainer:IsDescendantOf(sib) then return end
local isHdr = (titleLbl and (sib == titleLbl.Parent or titleLbl:IsDescendantOf(sib)))
local isWp = (sib.Name:find("^Chilli") and (sib.Name:find("Wallpaper") or sib.Name:find("Stroke") or sib.Name:find("Cosmic") or sib.Name:find("Logo")))
if isHdr or isWp then return end

if not sib:GetAttribute("__ChilliShiftedRightV12") then
local sx = sib.Position.X.Offset
local sy = sib.Position.Y.Offset
local relY = sib.AbsolutePosition.Y - win.AbsolutePosition.Y
local relX = sib.AbsolutePosition.X - win.AbsolutePosition.X
if (sx >= 15 and sx <= 148) or (relX >= 15 and relX <= 148 and relY >= 20) then
local ancShifted = false
local p = sib.Parent
while p and p ~= win and p ~= mainBg do
if p:GetAttribute("__ChilliShiftedRightV12") then ancShifted = true break end
p = p.Parent
end
if not ancShifted then
sib:SetAttribute("__ChilliShiftedRightV12", true)
local targetX = math.max(sx, CONTENT_START_X)
sib.Position = u2(sib.Position.X.Scale, targetX, sib.Position.Y.Scale, sy)
if sib.Size.X.Scale > 0.4 or sib.Size.X.Offset > 180 then
sib.Size = u2(sib.Size.X.Scale, sib.Size.X.Offset - 88, sib.Size.Y.Scale, sib.Size.Y.Offset)
end
end
end
end
end

for _, sib in ipairs(win:GetDescendants()) do
if sib:IsA("GuiObject") then
shiftContentTarget(sib)
end
end
end)

State.SystemTabBtn = navButtons[6] or navButtons[#navButtons]
local tabSquircles = {}
local tabStrokes = {}
local tabBars = {}
local tabShines = {}
local tabViLabels = {}
local tabEnLabels = {}

local function setActiveTabVisual(activeIdx, playSnd)
if playSnd then playIslandSfx("tap") end
local fastTabTw = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
for i = 1, #navButtons do
local sq = tabSquircles[i]
local st = tabStrokes[i]
local bar = tabBars[i]
local sh = tabShines[i]
local viL = tabViLabels[i]
local enL = tabEnLabels[i]
local isAct = (i == activeIdx)
local bColor = SIDEBAR_PALETTE[((i - 1) % #SIDEBAR_PALETTE) + 1]
if sq and sq.Parent then
TweenService:Create(sq, fastTabTw, {
Size = u2s(1, 1),
BackgroundColor3 = isAct and bColor or c3(16, 20, 32),
BackgroundTransparency = isAct and 0.08 or 0.45
}):Play()
end
if st and st.Parent then
TweenService:Create(st, fastTabTw, {
Thickness = isAct and 1.5 or 1.0,
Color = isAct and Color3.new(1, 1, 1) or bColor,
Transparency = isAct and 0.05 or 0.45
}):Play()
end
if sh and sh.Parent then
sh.Visible = true
TweenService:Create(sh, fastTabTw, {
BackgroundTransparency = isAct and 0.50 or 0.88
}):Play()
end
if bar and bar.Parent then
bar.Visible = isAct
end
if viL and viL.Parent then
viL.TextColor3 = c3(255, 255, 255)
end
if enL and enL.Parent then
enL.TextColor3 = isAct and c3(255, 255, 255) or c3(185, 195, 210)
end
end
end

State.RefreshSidebarTabsCallback = function()
for i = 1, #navButtons do
local viL = tabViLabels[i]
local enL = tabEnLabels[i]
local info = SIDEBAR_TAB_BILINGUAL[i]
if info then
if viL and viL.Parent then
viL.Text = (State.Language == "EN") and info.en or info.vi
end
if enL and enL.Parent then
enL.Text = (State.Language == "EN") and info.vi or info.en
end
end
end
end

local function CreateTab(nameVN, nameEN, iconId, idx, btn)
local badgeColor = SIDEBAR_PALETTE[((idx - 1) % #SIDEBAR_PALETTE) + 1]
pcall(function()
btn.LayoutOrder = idx
btn.Size = u2(1, 0, 0, 38)
btn.BackgroundTransparency = 1
btn.ClipsDescendants = true
end)

local squircle = btn:FindFirstChild("ChilliSenaSquircle")
if not squircle then
squircle = mk("Frame", {
Name = "ChilliSenaSquircle",
AnchorPoint = v2(0.5, 0.5),
Position = u2s(0.5, 0.5),
Size = u2s(1, 1),
BackgroundColor3 = (idx == 1) and badgeColor or c3(16, 20, 32),
BackgroundTransparency = (idx == 1) and 0.08 or 0.45,
BorderSizePixel = 0,
ClipsDescendants = true,
Active = false,
ZIndex = btn.ZIndex + 1
}, btn)
else
squircle.AnchorPoint = v2(0.5, 0.5)
squircle.Position = u2s(0.5, 0.5)
squircle.Size = u2s(1, 1)
squircle.BackgroundColor3 = (idx == 1) and badgeColor or c3(16, 20, 32)
squircle.BackgroundTransparency = (idx == 1) and 0.08 or 0.45
squircle.ClipsDescendants = true
end

local sqCorner = squircle:FindFirstChildOfClass("UICorner") or mk("UICorner", { CornerRadius = UDim.new(0, 10) }, squircle)
sqCorner.CornerRadius = UDim.new(0, 10)

local sqStroke = squircle:FindFirstChild("ChilliTabStroke") or mk("UIStroke", {
Name = "ChilliTabStroke",
Thickness = (idx == 1) and 1.5 or 1.0,
Color = (idx == 1) and Color3.new(1, 1, 1) or badgeColor,
Transparency = (idx == 1) and 0.05 or 0.45,
ApplyStrokeMode = Enum.ApplyStrokeMode.Border
}, squircle)
sqStroke.Thickness = (idx == 1) and 1.5 or 1.0
sqStroke.Color = (idx == 1) and Color3.new(1, 1, 1) or badgeColor
sqStroke.Transparency = (idx == 1) and 0.05 or 0.45

local glassShine = squircle:FindFirstChild("ChilliTabGlassShine")
if not glassShine then
glassShine = mk("Frame", {
Name = "ChilliTabGlassShine",
AnchorPoint = v2(0.5, 0),
Position = u2(0.5, 0, 0, 1),
Size = u2(1, -4, 0.46, 0),
BackgroundColor3 = Color3.new(1, 1, 1),
BackgroundTransparency = (idx == 1) and 0.50 or 0.88,
BorderSizePixel = 0,
Active = false,
ZIndex = squircle.ZIndex + 1
}, squircle)
mk("UICorner", { CornerRadius = UDim.new(0, 8) }, glassShine)
mk("UIGradient", {
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.10),
NumberSequenceKeypoint.new(0.65, 0.60),
NumberSequenceKeypoint.new(1, 1.0)
})
}, glassShine)
else
glassShine.BackgroundTransparency = (idx == 1) and 0.50 or 0.88
end

local actBar = squircle:FindFirstChild("ChilliTabActiveBar") or mk("Frame", {
Name = "ChilliTabActiveBar",
AnchorPoint = v2(0, 0.5),
Position = u2(0, 2, 0.5, 0),
Size = u2(0, 3, 0, 16),
BackgroundColor3 = Color3.new(1, 1, 1),
BorderSizePixel = 0,
Visible = (idx == 1),
Active = false,
ZIndex = squircle.ZIndex + 3
}, squircle)
actBar.Position = u2(0, 2, 0.5, 0)
actBar.Size = u2(0, 3, 0, 16)
actBar.Visible = (idx == 1)
if not actBar:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, actBar) end

local hasFoundIcon = false
for _, ch in ipairs(btn:GetDescendants()) do
if ch ~= squircle and not ch:IsDescendantOf(squircle) and ch.Name ~= "ChilliStealTabIcon" and ch.Name ~= "ChilliTabCaption" and ch.Name ~= "ChilliTabCaptionEn" then
if ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
if not hasFoundIcon and idx ~= 2 then
hasFoundIcon = true
local p = ch.Parent
while p and p ~= btn do
if p:IsA("GuiObject") then
p.Visible = true
p.ClipsDescendants = false
p.BackgroundTransparency = 1
if p.ZIndex < squircle.ZIndex + 4 then
p.ZIndex = squircle.ZIndex + 4
end
end
p = p.Parent
end
ch.ZIndex = squircle.ZIndex + 5
ch.ImageColor3 = Color3.new(1, 1, 1)
ch.ImageTransparency = 0
ch.AnchorPoint = v2(0, 0.5)
ch.Position = u2(0, 6, 0.5, 0)
ch.Size = u2(0, 16, 0, 16)
ch.Visible = true
else
ch.Visible = false
ch.ImageTransparency = 1
end
elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch:SetAttribute("__HiddenVxLogo", true)
ch.TextTransparency = 1
ch.Visible = false
ch.Text = ""
elseif ch:IsA("Frame") and ch ~= squircle then
ch.BackgroundTransparency = 1
end
end
end

if idx == 2 then
local stealIcon = squircle:FindFirstChild("ChilliStealTabIcon") or btn:FindFirstChild("ChilliStealTabIcon")
if not stealIcon then
stealIcon = mk("ImageLabel", {
Name = "ChilliStealTabIcon",
AnchorPoint = v2(0, 0.5),
Position = u2(0, 6, 0.5, 0),
Size = u2(0, 16, 0, 16),
BackgroundTransparency = 1,
Image = STEAL_TAB_ICON_ID,
ImageColor3 = Color3.new(1, 1, 1),
ScaleType = Enum.ScaleType.Fit,
Active = false,
Selectable = false,
ZIndex = squircle.ZIndex + 5
}, squircle)
else
stealIcon.Parent = squircle
stealIcon.Image = STEAL_TAB_ICON_ID
stealIcon.AnchorPoint = v2(0, 0.5)
stealIcon.Position = u2(0, 6, 0.5, 0)
stealIcon.Size = u2(0, 16, 0, 16)
stealIcon.ImageTransparency = 0
stealIcon.Visible = true
stealIcon.ZIndex = squircle.ZIndex + 5
end
else
local oldExtraIcon = squircle:FindFirstChild("ChilliStealTabIcon") or btn:FindFirstChild("ChilliStealTabIcon")
if oldExtraIcon then oldExtraIcon:Destroy() end
end

local viLbl = squircle:FindFirstChild("ChilliTabCaption") or mk("TextLabel", {
Name = "ChilliTabCaption",
AnchorPoint = v2(0, 0),
Position = u2(0, 30, 0, 3),
Size = u2(1, -34, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextColor3 = c3(255, 255, 255),
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Center,
Text = (State.Language == "EN") and nameEN or nameVN,
TextTruncate = Enum.TextTruncate.None,
Active = false,
ZIndex = squircle.ZIndex + 6
}, squircle)
viLbl:SetAttribute("__HiddenVxLogo", true)
viLbl.AnchorPoint = v2(0, 0)
viLbl.Position = u2(0, 30, 0, 3)
viLbl.Size = u2(1, -34, 0, 18)
viLbl.Font = Enum.Font.GothamBold
viLbl.TextSize = 13
viLbl.TextColor3 = c3(255, 255, 255)
viLbl.TextXAlignment = Enum.TextXAlignment.Left
viLbl.TextYAlignment = Enum.TextYAlignment.Center
viLbl.TextTruncate = Enum.TextTruncate.None
viLbl.TextTransparency = 0
viLbl.Visible = true
viLbl.ZIndex = squircle.ZIndex + 6
viLbl.Text = (State.Language == "EN") and nameEN or nameVN
local viSt = viLbl:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.1, Color = c3(8, 10, 18), Transparency = 0.15 }, viLbl)
viSt.Thickness = 1.1
viSt.Color = c3(8, 10, 18)
viSt.Transparency = 0.15

local enLbl = squircle:FindFirstChild("ChilliTabCaptionEn") or mk("TextLabel", {
Name = "ChilliTabCaptionEn",
AnchorPoint = v2(0, 0),
Position = u2(0, 30, 0, 21),
Size = u2(1, -34, 0, 13),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 9,
TextColor3 = c3(185, 195, 210),
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Center,
Text = (State.Language == "EN") and nameVN or nameEN,
TextTruncate = Enum.TextTruncate.None,
Active = false,
ZIndex = squircle.ZIndex + 6
}, squircle)
enLbl:SetAttribute("__HiddenVxLogo", true)
enLbl.AnchorPoint = v2(0, 0)
enLbl.Position = u2(0, 30, 0, 21)
enLbl.Size = u2(1, -34, 0, 13)
enLbl.Font = Enum.Font.Gotham
enLbl.TextSize = 9
enLbl.TextColor3 = c3(185, 195, 210)
enLbl.TextXAlignment = Enum.TextXAlignment.Left
enLbl.TextYAlignment = Enum.TextYAlignment.Center
enLbl.TextTruncate = Enum.TextTruncate.None
enLbl.TextTransparency = 0
enLbl.Visible = true
enLbl.ZIndex = squircle.ZIndex + 6
enLbl.Text = (State.Language == "EN") and nameVN or nameEN
if not enLbl:FindFirstChildOfClass("UIStroke") then mk("UIStroke", { Thickness = 0.8, Color = c3(6, 8, 16), Transparency = 0.20 }, enLbl) end

tabViLabels[idx] = viLbl
tabEnLabels[idx] = enLbl
tabSquircles[idx] = squircle
tabStrokes[idx] = sqStroke
tabBars[idx] = actBar
tabShines[idx] = glassShine
if not btn:GetAttribute("__ChilliTabClickHooked") then
btn:SetAttribute("__ChilliTabClickHooked", true)
if btn:IsA("GuiButton") then
btn.MouseButton1Click:Connect(function()
setActiveTabVisual(idx, true)
end)
else
btn.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
setActiveTabVisual(idx, true)
end
end)
end
end
return btn
end

for idx, btn in ipairs(navButtons) do
local tabInfo = SIDEBAR_TAB_BILINGUAL[idx] or { vi = "Mục " .. tostring(idx), en = "Tab " .. tostring(idx), icon = "" }
CreateTab(tabInfo.vi, tabInfo.en, tabInfo.icon, idx, btn)
end
end
end)
end

local venyxGuiLocked = nil
local function patchVenyxGui(gui, titleLbl)
gui:SetAttribute("__IsChilliVenyxGui", true)
pcall(function() gui.Enabled = true end)

if titleLbl:GetAttribute("__TitleShiftedV8") ~= SID then
titleLbl:SetAttribute("__TitleShiftedV8", SID)
local tx = titleLbl.Position.X.Offset
if tx < 45 then
titleLbl.Position = u2(titleLbl.Position.X.Scale, 56, titleLbl.Position.Y.Scale, titleLbl.Position.Y.Offset)
end
end

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
State.ActiveVenyxGui = gui
if win then
State.ActiveMainWin = win
pcall(cleanupStrayLogos, gui, win)

if win:GetAttribute("__ChilliV7ArchSession") ~= SID or not State.SystemTabBtn then
win:SetAttribute("__ChilliV7ArchSession", SID)
pcall(applySenaV8Architecture, win, titleLbl)
end

pcall(function()
local topBar = (titleLbl.Parent and titleLbl.Parent ~= win and titleLbl.Parent:IsA("GuiObject") and titleLbl.Parent.AbsoluteSize.Y <= 60) and titleLbl.Parent or nil
if topBar then
for _, c in ipairs(topBar:GetChildren()) do
if c.Name == "ChilliHeaderLogoBadge" or c.Name == "ChilliHeaderLogo" then
c:Destroy()
end
end
end

local oldGrad = titleLbl:FindFirstChild("ChilliTitleGrad") or titleLbl:FindFirstChild("TitleUltraGrad")
if oldGrad then oldGrad:Destroy() end
local oldStroke = titleLbl:FindFirstChild("ChilliTitleStroke")
if oldStroke then oldStroke:Destroy() end

titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextColor3 = Color3.new(1, 1, 1)
titleLbl.TextTransparency = 0
titleLbl.AutomaticSize = Enum.AutomaticSize.X
titleLbl.Text = NEW_TITLE

for _, d in ipairs(win:GetDescendants()) do
if d ~= titleLbl then
if d:IsA("TextLabel") or d:IsA("TextButton") then
local t = (d.Text or ""):match("^%s*(.-)%s*$")
if t == "vx" or t == "Vx" or t == "VX" then
d.Text = ""
d.Visible = false
d.TextTransparency = 1
end
end
end
end
end)

local function lockHidePageTitleLabel(d)
if not d or not d:IsA("TextLabel") or d == titleLbl then return end
if State.ActiveNavContainer and d:IsDescendantOf(State.ActiveNavContainer) then return end
if d:FindFirstAncestorOfClass("ScrollingFrame") then return end
if isProfileOrPlayerInfo(d) then
d:SetAttribute("__HiddenVxLogo", nil)
d:SetAttribute("__LockedPageHeaderHide", nil)
d.TextTransparency = 0
d.Visible = true
return
end
local rawT = (d:GetAttribute("OrigRawText") or d.Text or ""):lower():match("^%s*(.-)%s*$") or ""
local curT = (d.Text or ""):lower():match("^%s*(.-)%s*$") or ""
if PAGE_HEADER_TITLES[rawT] or PAGE_HEADER_TITLES[curT] then
d:SetAttribute("__HiddenVxLogo", true)
d.TextTransparency = 1
d.Visible = false
d.Position = u2(0, -9999, 0, -9999)
if not d:GetAttribute("__LockedPageHeaderHide") then
d:SetAttribute("__LockedPageHeaderHide", true)
d:GetPropertyChangedSignal("Text"):Connect(function()
if not isProfileOrPlayerInfo(d) then
d.TextTransparency = 1
d.Visible = false
end
end)
d:GetPropertyChangedSignal("TextTransparency"):Connect(function()
if not isProfileOrPlayerInfo(d) and d.TextTransparency ~= 1 then
d.TextTransparency = 1
end
end)
d:GetPropertyChangedSignal("Visible"):Connect(function()
if not isProfileOrPlayerInfo(d) and d.Visible then
d.Visible = false
end
end)
end
end
end

for _, d in ipairs(win:GetDescendants()) do
if d:IsA("TextLabel") then
if isProfileOrPlayerInfo(d) then
d:SetAttribute("__HiddenVxLogo", nil)
d:SetAttribute("__LockedPageHeaderHide", nil)
d.TextTransparency = 0
d.Visible = true
else
lockHidePageTitleLabel(d)
end
end
end

if not win:GetAttribute("__ChilliShiftListenerHooked") then
win:SetAttribute("__ChilliShiftListenerHooked", true)
win.DescendantAdded:Connect(function(ch)
if not isAlive() then return end
if ch:IsA("TextLabel") and not (State.ActiveNavContainer and ch:IsDescendantOf(State.ActiveNavContainer)) and ch ~= titleLbl then
if isProfileOrPlayerInfo(ch) then
ch.Visible = true
ch.TextTransparency = 0
else
local txt = (ch.Text or ""):lower():match("^%s*(.-)%s*$") or ""
local relY = ch.AbsolutePosition.Y - win.AbsolutePosition.Y
if PAGE_HEADER_TITLES[txt] and relY > 36 and (relY < 90 or (ch.Parent and not ch.Parent:IsA("ScrollingFrame"))) then
ch.Visible = false
ch.Text = ""
ch.TextTransparency = 1
end
end
end
end)
end
end
for _, tc in ipairs(gui:GetChildren()) do
if tc:IsA("GuiObject") and tc ~= win and tc.Name ~= "ChilliV5_ExpandedIsland" and not tc:FindFirstChild("IslandExpandHint") then
pcall(setupCircleLogo, tc, win)
end
end
return (win ~= nil)
end

-- ============================================================================
-- GHOST TRANSLATOR DAEMON (FLAT ARRAY POLLING) - NO STACK OVERFLOW
-- ============================================================================
local activeLabels = {}
local function trackInstance(inst)
if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
if not inst:GetAttribute("__ViTrk") then
inst:SetAttribute("__ViTrk", true)
table.insert(activeLabels, inst)
end
end
end

local function scanRootsForGuis()
local roots = { CoreGui }
if gethui then pcall(function() table.insert(roots, gethui()) end) end
local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if pg then table.insert(roots, pg) end
for _, root in ipairs(roots) do
for _, gui in ipairs(root:GetChildren()) do
if gui:IsA("ScreenGui") and not IGNORED_GUIS[gui.Name] then
if not gui:GetAttribute("__ViHk") then
gui:SetAttribute("__ViHk", true)
for _, d in ipairs(gui:GetDescendants()) do trackInstance(d) end
gui.DescendantAdded:Connect(trackInstance)
end
end
end
end
end

local RunService = game:GetService("RunService")
local idx = 1
RunService.Heartbeat:Connect(function()
if not isAlive() or #activeLabels == 0 then return end
local count = 0
local limit = 600
while idx <= #activeLabels and count < limit do
local inst = activeLabels[idx]
if not inst.Parent then
table.remove(activeLabels, idx)
else
if inst:IsA("TextBox") then
local ph = inst.PlaceholderText
if ph and ph ~= "" and ph ~= inst:GetAttribute("__LastPh") then
local tr = translateFullText(ph)
if tr and tr ~= ph then pcall(function() inst.PlaceholderText = tr end) end
inst:SetAttribute("__LastPh", tr)
end
else
local txt = inst.Text
if txt and txt ~= "" and txt ~= inst:GetAttribute("__LastTxt") then
if txt:find("[\194-\244][\128-\191]") and not stillHasUntranslatedEnglish(txt) then
inst:SetAttribute("__LastTxt", txt)
else
local tr = translateFullText(txt)
if tr and tr ~= txt then pcall(function() inst.Text = tr end) end
inst:SetAttribute("__LastTxt", tr)
end
end
end
idx = idx + 1
end
count = count + 1
end
if idx > #activeLabels then idx = 1 end
end)

task.spawn(function()
while task.wait(1.5) do
if not isAlive() then break end
pcall(scanRootsForGuis)
local sg = CoreGui:FindFirstChild("RobloxGui") or CoreGui
if not venyxGuiLocked then
for _, gui in ipairs(sg:GetChildren()) do
if gui:IsA("ScreenGui") and not IGNORED_GUIS[gui.Name] then
local titleLbl = nil
for _, d in ipairs(gui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" then
local t = (d.Text or ""):match("^%s*(.-)%s*$")
if (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
titleLbl = d
break
end
end
end
if titleLbl then
local ok, res = pcall(patchVenyxGui, gui, titleLbl)
if ok and res then venyxGuiLocked = gui end
end
end
end
end
end
end)
