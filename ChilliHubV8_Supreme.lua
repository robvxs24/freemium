if not math.clamp then math.clamp=function(v,a,b)return math.max(a,math.min(b,v))end end
local CLIENT_TYPE="STANDARD"
pcall(function()
local ex=""
if identifyexecutor then ex=tostring(identifyexecutor()or "")
elseif getexecutorname then ex=tostring(getexecutorname()or "")end
local low=ex:lower()
if low:find("arceus")or low:find("spdm")or low:find("neo")or type(arceus)=="table" then
CLIENT_TYPE="ARCEUS"
elseif low:find("delta")or type(delta)=="table" then
CLIENT_TYPE="DELTA"
elseif low:find("codex")or low:find("vega")or type(codex)=="table" then
CLIENT_TYPE="CODEX"
elseif low:find("fluxus")or type(fluxus)=="table" then
CLIENT_TYPE="FLUXUS"
end
end)
local IS_ARCEUS=(CLIENT_TYPE=="ARCEUS")
local NEW_TITLE="Chilli Hub V8"
local LOGO_ID="rbxassetid://74441610995894"
local HEADER_BAR_IMG_ID="rbxassetid://83726521558450"
local STEAL_TAB_ICON_ID="rbxassetid://91536384271341"
local WALLPAPER_IMAGE_ID="rbxassetid://90615151648668"
local c3,u2,u2s,v2,csk=Color3.fromRGB,UDim2.new,UDim2.fromScale,Vector2.new,ColorSequenceKeypoint.new
local EF,EES,EED,ETX,ETY,EASM,EUIT,twi=Enum.Font,Enum.EasingStyle,Enum.EasingDirection,Enum.TextXAlignment,Enum.TextYAlignment,Enum.ApplyStrokeMode,Enum.UserInputType,TweenInfo.new
local LOGO_BG,BLACK_BG=c3(12,12,18),c3(8,8,12)
local MY_URL="https://raw.githubusercontent.com/napun67/stealanegg/refs/heads/main/chillihubv8.lua"
local VENYX_URL="https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local AUTO_FILE,LANG_FILE="ChilliHubV5_AutoRun.lua","ChilliV5_Lang.txt"
local PRESET_JSON=[=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":true,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":true,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]
if isfile and delfile then
pcall(function()
if isfile(AUTO_FILE)then delfile(AUTO_FILE)end
end)
end
local function safeHttpGet(url)
for attempt=1,2 do
local ok1,res1=pcall(function()return game:HttpGet(url)end)
if ok1 and type(res1)=="string" and #res1>10 then return res1 end
local ok2,res2=pcall(function()return game:HttpGet(url,true)end)
if ok2 and type(res2)=="string" and #res2>10 then return res2 end
local ok3,res3=pcall(function()return game:HttpGetAsync(url)end)
if ok3 and type(res3)=="string" and #res3>10 then return res3 end
local req=request or http_request or(http and http.request)or(syn and syn.request)or(fluxus and fluxus.request)or(delta and delta.request)or(arceus and arceus.request)or(codex and codex.request)
if req then
local rOk,rRes=pcall(req,{Url=url,Method="GET"})
if rOk and type(rRes)=="table" and type(rRes.Body)=="string" and #rRes.Body>10 then return rRes.Body end
end
if attempt==1 then task.wait(0.25)end
end
return nil
end
local env=(getgenv and getgenv())or _G
env.__ChilliV5State=env.__ChilliV5State or{
SessionId=0,Language="VI",ActiveHub="CHILLI",ActiveGradients={},
TrackedTexts={},TrackedFpsLabels={},
NoticeShown=false,StartClock=os.clock()
}
local State=env.__ChilliV5State
State.SessionId=(State.SessionId or 0)+1
State.ActiveHub="CHILLI"
State.CloseHideUntil=nil
State.StartClock=State.StartClock or os.clock()
State.JoiningLeastServerBusy=false
State.ScanningFinderBusy=false
State.MacroBusy=false
State.TrackedFinderJoinBtns={}
local SID=State.SessionId
local function isAlive()return State.SessionId==SID end
pcall(function()
if isfile and isfile(LANG_FILE)then
local s=(readfile(LANG_FILE)or ""):match("^%s*(.-)%s*$")
if s=="EN" or s=="VI" then State.Language=s end
end
end)
local Players=game:GetService("Players")
local LocalPlayer=Players.LocalPlayer
if not LocalPlayer then
pcall(function()LocalPlayer=Players:GetPropertyChangedSignal("LocalPlayer"):Wait()end)
LocalPlayer=Players.LocalPlayer
end
local TweenService=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")
local Stats=game:GetService("Stats")
local SoundService=game:GetService("SoundService")
local HttpService=game:GetService("HttpService")
local TeleportService=game:GetService("TeleportService")
local GuiService=game:GetService("GuiService")
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local function getScanRoots()
local r,seen={},{}
local function addRoot(inst)
if inst and not seen[inst] then
seen[inst]=true
table.insert(r,inst)
end
end
if gethui then
pcall(function()addRoot(gethui())end)
end
pcall(function()addRoot(CoreGui)end)
local pg=LocalPlayer and(LocalPlayer:FindFirstChildOfClass("PlayerGui")or LocalPlayer:FindFirstChild("PlayerGui"))
addRoot(pg)
return r
end
local IGNORED_GUIS={
RobloxGui=true,TopBarApp=true,TouchGui=true,Chat=true,BubbleChat=true,
Freecam=true,BackpackGui=true,PlayerList=true,PurchasePrompt=true,
ChilliV5_NoticeGui=true,ChilliV8_MasterIslandGui=true,ChilliV7_GetKeyUI=true,ChilliV7_InputBlocker=true,CoreScriptsRootProvider=true,
ExperienceChat=true,SettingsClippingShield=true,InGameMenu=true,TeleportGui=true,
RobloxNetworkPauseNotification=true
}
local function isVenyxScreenGui(gui)
if not gui or not gui:IsA("ScreenGui")or IGNORED_GUIS[gui.Name] then return false end
if gui==State.ActiveVenyxGui or gui:GetAttribute("__IsChilliVenyxGui")or gui:GetAttribute("__ChilliV8Patched")or gui:GetAttribute("__ChilliV7Patched")then
return true
end
if gui:GetAttribute("__IsChilliFinderGui")then return false end
local lastChk=gui:GetAttribute("__VenyxCheckClock")
if lastChk and(os.clock()-lastChk<2.0)then return false end
gui:SetAttribute("__VenyxCheckClock",os.clock())
for _,d in ipairs(gui:GetDescendants())do
if d.Name=="ChilliHeaderOverlay" or d.Name=="ChilliProWindowStroke" or d.Name=="ChilliCircleDisc" or d.Name=="ChilliUltraBadgePill" then
gui:SetAttribute("__IsChilliVenyxGui",true)
return true
end
if(d:IsA("TextLabel")or d:IsA("TextButton"))and not d:FindFirstAncestorOfClass("ScrollingFrame")then
local t=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$")
if t=="VENYX" or t==NEW_TITLE or t=="Chilli Hub Ultra" or t=="Chilli Hub V5" or t=="Chilli V5 |" then
gui:SetAttribute("__IsChilliVenyxGui",true)
return true
end
end
end
return false
end
local function isVenyxUiPresent()
for _,root in ipairs(getScanRoots())do
local list=root:IsA("ScreenGui")and{root}or root:GetChildren()
for _,ch in ipairs(list)do
if ch:IsA("ScreenGui")and not IGNORED_GUIS[ch.Name] then
for _,d in ipairs(ch:GetDescendants())do
if(d:IsA("TextLabel")or d:IsA("TextButton"))and d.Name~="ChilliUltraTitleBadge" and d.Name~="ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")then
local t=d.Text
if(t=="VENYX" or t==NEW_TITLE or t=="Chilli Hub Ultra" or t=="Chilli Hub V5" or t=="Chilli V5 |")and not d:FindFirstAncestorOfClass("ScrollingFrame")then
pcall(function()ch.Enabled=true end)
return true
end
end
end
end
end
end
return false
end
local function setupSafeTeleportHook()
local rq=env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport or queue_on_teleport or queueonteleport or(syn and syn.queue_on_teleport)or(fluxus and fluxus.queue_on_teleport)or(delta and delta.queue_on_teleport)
if not rq then return end
env.__ChilliOrigQueue=rq
local clearQ=env.clearteleportqueue or env.clear_teleport_queue or clearteleportqueue or clear_teleport_queue or(syn and syn.clear_teleport_queue)or(fluxus and fluxus.clear_teleport_queue)or(delta and delta.clear_teleport_queue)
local boot='--[[CHILLI_V8_AUTHORIZED_TELEPORT]]\ntask.spawn(function()\n\tif not game:IsLoaded() then game.Loaded:Wait() end\n\tloadstring(game:HttpGet("https://raw.githubusercontent.com/napun67/stealanegg/refs/heads/main/chillihubv8.lua"))()\nend)'
local safeLock=function(c)
pcall(function()
if tostring(c or ""):find("CHILLI_V8_AUTHORIZED_TELEPORT",1,true)then
rq(c)
else
if clearQ then pcall(clearQ)end
if env.__ChilliBootQueuedSession~=SID then
env.__ChilliBootQueuedSession=SID
rq(boot)
end
end
end)
end
pcall(function()
if clearQ then pcall(clearQ)end
env.queue_on_teleport=safeLock
env.queueonteleport=safeLock
_G.queue_on_teleport=safeLock
_G.queueonteleport=safeLock
if env.__ChilliBootQueuedSession~=SID then
env.__ChilliBootQueuedSession=SID
pcall(rq,boot)
end
if not env.__ChilliOnTpHooked and LocalPlayer then
env.__ChilliOnTpHooked=true
LocalPlayer.OnTeleport:Connect(function()
pcall(function()
if clearQ then pcall(clearQ)end
pcall(rq,boot)
end)
end)
end
end)
end
local function clearStaleVenyxLocks()
for _,tbl in ipairs({env,_G,type(shared)=="table" and shared or nil})do
if type(tbl)=="table" then
for k,v in pairs(tbl)do
if type(k)=="string" and not k:find("^__Chilli")and not k:find("^__VenyxLaunch")then
local lk=k:lower()
if(lk:find("venyx")or lk:find("chilli")or lk:find("codium")or lk:find("sae")or lk:find("hub")or lk:find("loaded"))and type(v)~="function" then
pcall(function()tbl[k]=nil end)
end
end
end
end
end
end
local function launchVenyxBase()
if isVenyxUiPresent()then return end
if env.__VenyxLaunchingNow and(os.clock()-(env.__VenyxLaunchClock or 0)<4)then return end
env.__VenyxLaunchingNow=true
env.__VenyxLaunchClock=os.clock()
task.spawn(function()
if not game:IsLoaded()then game.Loaded:Wait()end
pcall(clearStaleVenyxLocks)
local rawCode=safeHttpGet(VENYX_URL)
if rawCode then
local fn=loadstring(rawCode)
if type(fn)=="function" then
pcall(fn)
end
else
pcall(function()loadstring(game:HttpGet(VENYX_URL))()end)
end
env.__VenyxLaunchingNow=false
task.delay(1.0,function()
pcall(setupSafeTeleportHook)
end)
end)
end
for _,root in ipairs(getScanRoots())do
root.ChildAdded:Connect(function(ch)
if not isAlive()then return end
if ch:IsA("ScreenGui")and not IGNORED_GUIS[ch.Name] then
task.defer(function()
if not isAlive()or not ch or not ch.Parent then return end
end)
end
end)
end
launchVenyxBase()
local function mk(cls,props,parent)
local inst=Instance.new(cls)
for k,v in pairs(props)do inst[k]=v end
if parent then inst.Parent=parent end
return inst
end
local function addGrad(g)
if g then
pcall(function()g.Rotation=35 end)
end
return g
end
local RAINBOW=ColorSequence.new({
csk(0.00,c3(255,45,85)),csk(0.17,c3(255,155,35)),csk(0.33,c3(255,235,45)),
csk(0.50,c3(45,255,145)),csk(0.67,c3(45,195,255)),csk(0.83,c3(185,85,255)),csk(1.00,c3(255,45,85))
})
local ULTRA_TEXT_GRAD=ColorSequence.new({
csk(0.00,c3(235,245,255)),csk(0.32,c3(155,212,250)),csk(0.68,c3(192,170,248)),
csk(1.00,c3(238,188,225))
})
local ULTRA_CARD_GRAD=ColorSequence.new({
csk(0.00,c3(70,210,255)),csk(0.50,c3(170,95,255)),csk(1.00,c3(255,75,195))
})
local LIQUID_TEXT_GRAD=ColorSequence.new({
csk(0.00,c3(250,253,255)),csk(0.35,c3(185,232,255)),
csk(0.70,c3(225,215,255)),csk(1.00,c3(250,253,255))
})
local LIQUID_GLASS_COLOR=ColorSequence.new({
csk(0.00,c3(145,190,235)),csk(0.20,c3(22,30,48)),
csk(0.78,c3(12,16,28)),csk(1.00,c3(48,82,132))
})
local LIQUID_GLASS_TRANS=NumberSequence.new({
NumberSequenceKeypoint.new(0.00,0.18),
NumberSequenceKeypoint.new(0.22,0.28),
NumberSequenceKeypoint.new(0.78,0.26),
NumberSequenceKeypoint.new(1.00,0.20)
})
local GREEN_COLOR=c3(50,255,100)
local currentFakeFps=math.random(80,120)
local currentFakeMs=math.random(15,80)
local function getFakeFps()
return currentFakeFps
end
local function getLivePing()
return currentFakeMs
end
local function isFpsTxt(t)
if type(t)~="string" then return false end
local clean=t:gsub("<[^>]+>",""):lower()
if #clean>65 then return false end
return(clean:find("fps",1,true)~=nil and(clean:find("ms",1,true)~=nil or clean:find("ping",1,true)~=nil))
end
local function ensureStandaloneNeonFpsGui()
pcall(function()
for _,root in ipairs(getScanRoots())do
local oldG=root:FindFirstChild("ChilliV8_NeonFpsPillGui")
if oldG then oldG:Destroy()end
end
end)
return nil
end
local function formatFpsPingText()
return string.format("%d FPS  -  %d ms",currentFakeFps,currentFakeMs)
end
local function hookFps(lbl)
if not lbl or not(lbl:IsA("TextLabel")or lbl:IsA("TextButton"))then return end
State.TrackedFpsLabels[lbl]=true
pcall(function()
local p=lbl.Parent
if p and p:IsA("GuiObject")then
p.Visible=true
for _,ch in ipairs(p:GetChildren())do
if(ch:IsA("TextLabel")or ch:IsA("TextButton"))and ch~=lbl then
ch.Visible=false
ch.TextTransparency=1
end
end
end
lbl:SetAttribute("__UpdatingFps",true)
lbl.RichText=false
lbl.Visible=true
lbl.TextTransparency=0
lbl.Font=EF.GothamBold
lbl.TextColor3=GREEN_COLOR
lbl.Text=formatFpsPingText()
lbl:SetAttribute("__UpdatingFps",false)
if lbl:GetAttribute("__FpsHookSession")~=SID then
lbl:SetAttribute("__FpsHookSession",SID)
lbl:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive()or lbl:GetAttribute("__UpdatingFps")then return end
lbl:SetAttribute("__UpdatingFps",true)
lbl.TextColor3=GREEN_COLOR
lbl.Text=formatFpsPingText()
lbl:SetAttribute("__UpdatingFps",false)
end)
lbl:GetPropertyChangedSignal("TextColor3"):Connect(function()
if not isAlive()or lbl:GetAttribute("__UpdatingFps")then return end
if lbl.TextColor3~=GREEN_COLOR then
lbl:SetAttribute("__UpdatingFps",true)
lbl.TextColor3=GREEN_COLOR
lbl:SetAttribute("__UpdatingFps",false)
end
end)
end
end)
end
local function scanForFpsPills()
local pg=LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
for _,root in ipairs(getScanRoots())do
if root~=pg then
for _,ch in ipairs(root:GetChildren())do
if ch.Name=="RobloxGui" then
for _,sub in ipairs(ch:GetChildren())do
if not IGNORED_GUIS[sub.Name] then
for _,d in ipairs(sub:GetDescendants())do
if d:IsA("TextLabel")and isFpsTxt(d.Text)then
pcall(hookFps,d)
end
end
end
end
elseif not IGNORED_GUIS[ch.Name] then
for _,d in ipairs(ch:GetDescendants())do
if d:IsA("TextLabel")and isFpsTxt(d.Text)then
pcall(hookFps,d)
end
end
end
end
end
end
end
task.spawn(function()
pcall(ensureStandaloneNeonFpsGui)
pcall(scanForFpsPills)
while isAlive()do
currentFakeFps=math.random(80,120)
currentFakeMs=math.random(15,80)
local txtNow=formatFpsPingText()
for lbl in pairs(State.TrackedFpsLabels)do
if lbl and lbl.Parent then
pcall(function()
lbl:SetAttribute("__UpdatingFps",true)
lbl.Visible=true
lbl.TextTransparency=0
lbl.TextColor3=GREEN_COLOR
lbl.Text=txtNow
lbl:SetAttribute("__UpdatingFps",false)
end)
else
State.TrackedFpsLabels[lbl]=nil
end
end
task.wait(1)
end
end)
local FastCache={}
local function hasVi(s)
return type(s)=="string" and s~="" and(s:find("\225[\186\187][\128-\191]")~=nil or s:find("\195[\128-\191]")~=nil or s:find("\196[\130\131\144\145\168\169]")~=nil or s:find("\197[\168\169\175\176]")~=nil)
end
local translateText,translateStatus,stripRichTags,applyTrans,hookTrans,refreshAllTexts
local hopToLeastPlayersServer,executeRawHopToLeastPlayersServer,watchFinderHudButton,hookChilliFinderJoin,watchFinderTextObj,hookLoginFrameTrigger,translateFinderHudState,scanChilliFinderButtons
do
local EXACT_VI={["Home"]="Trang Chủ",["Dashboard"]="Trang Chủ",["Steal"]="Săn Trứng",["Farm"]="Tự Cày",["Event"]="Sự Kiện",["Events"]="Sự Kiện",["Player"]="Nhân Vật",["System"]="Cài Đặt",["Settings"]="Cài Đặt",["Halloween & Shooting Star"]="Halloween & Sao Băng",["Halloween & sao băng"]="Halloween & Sao Băng",["HALLOWEEN & SHOOTING STAR"]="HALLOWEEN & SAO BĂNG",["HALLOWEEN & SAO BĂNG"]="HALLOWEEN & SAO BĂNG",["The Hollow"]="Vực Hollow",["Hollow"]="Vực Hollow",["Steal missing Halloween index"]="Cướp trứng Halloween thiếu trong Chỉ mục",["Steal missing Halloween index eggs"]="Cướp trứng Halloween thiếu trong Chỉ mục",["cướp missing Halloween index"]="Cướp trứng Halloween thiếu trong Chỉ mục",["Place eggs in pen and hatch missing in Egg Index"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",["Place and hatch eggs missing from your Egg Index"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",["Đặt trứng vào chuồng và hatch thiếu trong Chỉ mục trứng"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",["PUMPKIN BOSS"]="BOSS BÍ NGÔ",["Pumpkin Boss"]="Boss Bí Ngô",["Auto Pumpkin Boss"]="Tự đánh Boss Bí Ngô",["Auto dodge attacks"]="Tự động né đòn đánh",["Dodge attacks"]="Tự động né đòn đánh",["Auto claim mastery"]="Tự động nhận thưởng Thông Thạo",["Tự động nhận mastery"]="Tự động nhận thưởng Thông Thạo",["Claim mastery"]="Nhận thưởng Thông Thạo",["Mastery"]="Thông Thạo",["MASTERY"]="THÔNG THẠO",["Stub pickup speed"]="Tốc độ nhặt Cuống Bí Ngô",["Pickup speed"]="Tốc độ nhặt vật phẩm",["Tốc độ cuống pickup"]="Tốc độ nhặt Cuống Bí Ngô",["Auto manor key"]="Tự lấy chìa khóa dinh thự",["Manor key"]="Chìa khóa dinh thự",["MANOR KEY"]="CHÌA KHÓA DINH THỰ",["KILLS"]="SỐ LẦN HẠ",["Kills"]="Số lần hạ",["BOSS"]="TRÙM (BOSS)",["ALIVE"]="CÒN SỐNG",["Alive"]="Còn sống",["DEAD"]="ĐÃ HẠ",["Dead"]="Đã hạ",["SPAWNED"]="ĐÃ XUẤT HIỆN",["Spawned"]="Đã xuất hiện",["NOT SPAWNED"]="CHƯA XUẤT HIỆN",["Not spawned"]="Chưa xuất hiện",["Cooldown"]="Đang hồi",["COOLDOWN"]="ĐANG HỒI",["Active"]="Đang bật",["ACTIVE"]="ĐANG BẬT",["Inactive"]="Đang tắt",["INACTIVE"]="ĐANG TẮT",["Sign In"]="Miễn phí",["SIGN IN"]="MIỄN PHÍ",["Sign trong"]="Miễn phí",["Sign Up"]="Đăng ký",["No plan"]="Miễn phí",["FORCE JOIN"]="TỰ VÀO SAU",["Force Join"]="Tự vào sau",["MIN VALUE"]="GIÁ TỐI THIỂU",["RARITY"]="ĐỘ HIẾM",["ACCOUNT"]="TÀI KHOẢN",["Account"]="Tài khoản",["Chilli Finder"]="Chilli Finder Free",["Chill Finder Free"]="Chilli Finder Free",["Chilli Finder Free"]="Chilli Finder Free",["Top 5 recent eggs | Book at chillihub.pro"]="Top 5 trứng mới nhất | Chilli Finder Free",["Sign in with your chillihub.pro account to join"]="Top 5 trứng mới nhất | Chilli Finder Free",["Sign in with your chillihub.pro account"]="Top 5 trứng mới nhất | Chilli Finder Free",["No active booking. Book hours at chillihub.pro"]="Top 5 trứng mới nhất | Chilli Finder Free",["Finder"]="Tìm Trứng",["FINDER"]="TÌM TRỨNG",["finder"]="tìm trứng",["Scanning..."]="Đang quét...",["Scanning"]="Đang quét...",["Searching..."]="Đang tìm...",["Searching"]="Đang tìm...",["Checking..."]="Đang kiểm tra...",["Checking"]="Đang kiểm tra...",["Found!"]="Đã thấy!",["Found"]="Đã thấy",["Egg Found!"]="Có trứng mới!",["Egg Found"]="Có trứng mới",["Waiting..."]="Đang chờ...",["Waiting"]="Đang chờ...",["No Eggs"]="Hết trứng",["None"]="Không có",["Auto On"]="Tự động: BẬT",["Auto Off"]="Tự động: TẮT",["AUTO ON"]="TỰ ĐỘNG: BẬT",["AUTO OFF"]="TỰ ĐỘNG: TẮT",["Cooldown"]="Đang hồi...",["Ready"]="Sẵn sàng",["Chilli Finder"]="Chill Finder Free",["Top 5 recent eggs | Book at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",["Sign in with your chillihub.pro account to join"]="Top 5 recent eggs | Chill Finder Free",["Sign in with your chillihub.pro account"]="Top 5 recent eggs | Chill Finder Free",["No active booking. Book hours at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",["Venyx"]="Chilli Hub",["VENYX"]="Chilli Hub V8 Supreme",["Media"]="Mạng Xã Hội",["Chat"]="Trò Chuyện",["Features"]="Tính Năng",["Egg"]="Trứng (Egg)",["Pet"]="Thú Cưng (Pet)",["Activities"]="Hoạt Động",["Barn"]="Chuồng Trại",["Others"]="Khác",["Keyless"]="Không cần Key",["Anime"]="Chế độ Anime",["Search..."]="Tìm kiếm...",["Steal Egg"]="Cướp Trứng",["Filtering"]="Bộ Lọc",["Strict Filter"]="Lọc Nghiêm Ngặt",["Only target eggs that match every filter you set."]="Chỉ cướp trứng khớp với mọi bộ lọc bạn đã cài.",["Steal Priority"]="Ưu Tiên Cướp",["Select Area"]="Chọn Khu Vực",["Select Rarity"]="Chọn Độ Hiếm",["Select Pet"]="Chọn Thú Cưng",["Select Mutation"]="Chọn Đột Biến",["Min Value"]="Giá Trị Tối Thiểu",["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."]="Chỉ cướp trứng kiếm được ít nhất mức này mỗi giây (VD: 500k, 1.5m). Nhập 0 để tắt.",["Indexing"]="Chỉ Mục (Index)",["Auto Claim Index"]="Tự Nhận Thưởng Chỉ Mục",["Redeems unlocked index rewards."]="Tự động nhận phần thưởng từ danh mục đã mở khóa.",["Auto Indexing"]="Tự Động Thu Thập Chỉ Mục",["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."]="Chỉ cướp các trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",["Steal Settings"]="Cài Đặt Cướp",["Steal Mode"]="Chế Độ Cướp",["Normal flies to the egg, Instant Steal works in every area."]="Bình thường sẽ bay tới trứng. Cướp Tức Thì hoạt động ở mọi khu vực.",["Normal"]="Bình Thường",["Delivery Mode"]="Chế Độ Giao Trứng",["Recommended Delivery Mode: Speed Match or Steady"]="Khuyên dùng: Tốc độ khớp hoặc Ổn định",["Speed Match"]="Tốc độ khớp",["Steady"]="Ổn định",["Steal From Player"]="Cướp Từ Người Chơi",["Steals eggs from other players."]="Cướp trứng từ tay người chơi khác.",["Server Hop (No Target)"]="Đổi Server (Khi Hết Mục Tiêu)",["Hops server when no target is found."]="Tự động đổi máy chủ khi không tìm thấy trứng mục tiêu.",["Drop for Friend"]="Nhặt Hộ Bạn Bè",["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."]="Mang trứng đến điểm hẹn, thả xuống cho bạn bè nhặt và đi tìm trứng khác.",["Flies to field eggs, grabs them and brings them home."]="Bay tới bãi, nhặt trứng và mang về nhà.",["Steal Other Script"]="Cướp Của Script Khác",["Grabs eggs other players drop near safezone."]="Nhặt trứng mà các người chơi dùng script khác làm rớt gần vùng an toàn.",["Steal Status"]="Trạng Thái Cướp",["Shows the Auto Steal status panel."]="Hiển thị bảng trạng thái tự động cướp.",["Open Steal Panel"]="Mở Bảng Cướp Trứng",["Find and steal World and Halloween eggs by hand."]="Tìm và cướp trứng Thế Giới / Halloween bằng tay.",["Open Steal History"]="Mở Lịch Sử Cướp",["Open the last 10 steal results in a separate window."]="Mở 10 kết quả cướp gần nhất ở cửa sổ riêng.",["Egg Utilities"]="Tiện Ích Trứng",["Open Egg Predictor"]="Mở Dự Đoán Trứng",["Open standalone egg cycle predictor window."]="Mở cửa sổ dự đoán chu kỳ trứng riêng biệt.",["Egg Inventory Value"]="Giá Trị Trứng Trong Túi",["Show generation rate (/s) and sell price on backpack egg slots."]="Hiển thị tốc độ sinh tiền (/s) và giá bán trên từng ô trứng trong ba lô.",["Place Egg"]="Đặt Trứng Vào Chuồng",["Hatch Egg"]="Ấp Trứng",["Stop At Rarity"]="Dừng Lại Ở Độ Hiếm",["Eggs of this rarity or higher won't be placed."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi đặt.",["Eggs of this rarity or higher won't be hatched."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi ấp.",["Whitelist"]="Danh Sách Trắng (Ưu Tiên)",["Blacklist"]="Danh Sách Đen (Bỏ Qua)",["Whitelist Rarity"]="Ưu Tiên Độ Hiếm",["Whitelist Pet"]="Ưu Tiên Thú Cưng",["Whitelist Mutation"]="Ưu Tiên Đột Biến",["Blacklist Rarity"]="Bỏ Qua Độ Hiếm",["Blacklist Pet"]="Bỏ Qua Thú Cưng",["Blacklist Mutation"]="Bỏ Qua Đột Biến",["Auto Place Egg"]="Tự Động Đặt Trứng",["Places matching eggs from your bag into the pen. Whitelist picks which eggs, blacklist always blocks."]="Đặt trứng phù hợp từ túi vào chuồng. Ưu tiên các mục trong Whitelist, luôn chặn mục trong Blacklist.",["Auto Place Indexing"]="Tự Động Đặt Lấy Chỉ Mục",["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."]="Chỉ tự động đặt các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist và Blacklist.",["Automatically hatch ready eggs matching the selected filters."]="Tự động ấp các trứng đã sẵn sàng và khớp với bộ lọc.",["Auto Hatch Indexing"]="Tự Động Ấp Lấy Chỉ Mục",["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."]="Chỉ ấp các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist, vẫn áp dụng Blacklist.",["Sell Egg"]="Bán Trứng",["Keep Above"]="Giữ Lại Trên Mức",["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."]="Không bao giờ bán trứng kiếm được trên mức này mỗi giây (VD: 100m). Nhập 0 để tắt.",["Sells eggs that pass your filters. Placed eggs are never sold."]="Bán trứng lọt qua bộ lọc. Trứng đã đặt trong chuồng sẽ không bao giờ bị bán.",["Sell On Inventory Full"]="Chỉ Bán Khi Đầy Túi",["Only sell when your egg backpack is full."]="Chỉ kích hoạt bán khi ba lô chứa trứng đã đầy.",["Player Stats"]="Thống Kê Người Chơi",["Money"]="Tiền",["Gems"]="Đá Quý",["Equipped"]="Đang Trang Bị",["Gain"]="Tăng Tốc Độ",["Inventory"]="Túi Đồ",["Map"]="Bản Đồ",["World"]="Thế Giới",["Discord webhook URL for sending notifications."]="Đường dẫn Webhook Discord để gửi thông báo.",["Ping @everyone"]="Tag @everyone",["Mention @everyone in Discord when a new egg is claimed."]="Gắn thẻ @everyone trên Discord khi nhận được trứng mới.",["Egg Webhook"]="Webhook Trứng",["Select Egg Rarity"]="Chọn Độ Hiếm Của Trứng",["Enable New Egg Claimed"]="Bật Thông Báo Trứng Mới",["Send webhook notification when stealing/claiming a new egg."]="Gửi thông báo Webhook khi cướp/nhận được trứng mới.",["Player Webhook"]="Webhook Người Chơi",["Stats Interval (Min)"]="Khoảng Thời Gian Báo Thống Kê (Phút)",["Enable Player Stats"]="Bật Thông Báo Thống Kê",["Periodically send player stats to Discord."]="Định kỳ gửi thông số người chơi qua Discord.",["Test Webhook"]="Thử Nghiệm Webhook",["Send Stats Now"]="Gửi Thống Kê Ngay Lúc Này",["Immediately send stats to Discord."]="Gửi ngay thông số người chơi vào Discord.",["Test Egg Webhook"]="Gửi Thử Webhook Trứng",["Simulate claiming an egg."]="Mô phỏng thao tác nhận trứng để kiểm tra.",["Admin Abuse Boost (BETA)"]="Nhận Buff Quyền Admin (BETA)",["Halloween Dimension"]="Không Gian Halloween",["Ghost Dog Quest"]="Nhiệm Vụ Chó Ma",["Abandoned Manor"]="Dinh Thự Bỏ Hoang",["Pumpkin King"]="Vua Bí Ngô",["just now"]="vừa xong",["Just now"]="Vừa xong",["Inventory values"]="Giá trị túi đồ",["Find option"]="Tìm tùy chọn",["🔍 Find option"]="🔍 Tìm tùy chọn",["Tip: you can also hold any feature to pin it or set a key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",["Tip: you can also hold any feature to pin it or set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",["Tip: you can also hold any feature to pin it hoặc set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",["v1.4.2: Fixed some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",["v1.4.2: đã sửa some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",["v1.4.1: Movement speed up to 110%, improved Fast Tween"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",["v1.4.1: Di Chuyển tốc độ up tới 110%, improved Fast Bay (Tween)"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",["v1.4.0: Auto Pumpkin Boss (dodges attacks, fires cannons, collects Pumpkin Stubs), auto manor key, and Go to Egg Leap (replaces old Go to Egg)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",["v1.4.0: tự động bí ngô Boss (dodges attacks, fires cannons, collects bí ngô Stubs), tự động manor key, và Di Chuyển tới trứng Leap (replaces old Di Chuyển tới trứng)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",["v1.3.0: Anti guard fires again, and finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",["v1.3.0: Anti vệ sĩ fires again, và finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",["Go to Egg Leap"]="Nhảy Tới Trứng",["Go to egg leap"]="Nhảy tới trứng",["Manor key"]="Chìa khóa dinh thự",["Pumpkin Stubs"]="Cuống Bí Ngô",["Going into the Halloween Dimension"]="Đang vào Không gian Halloween",["Going into Halloween Dimension"]="Đang vào Không gian Halloween",["Leaving Halloween Dimension"]="Đang rời Không gian Halloween",["Entering Halloween Dimension"]="Đang vào Không gian Halloween",["v1.2.9: New optimizer modes: Balanced, Strong (way much higher FPS, ultra-low GPU), no lag spike when you turn it on"]="v1.2.9: Chế độ tối ưu mới: Cân bằng, Mạnh (tăng FPS cực cao, siêu nhẹ GPU), không bị khựng lag khi bật",["v1.2.8: Inventory values, see how much every pet and every egg in your backpack is worth"]="v1.2.8: Giá trị túi đồ, xem giá trị của từng pet và từng quả trứng trong ba lô",["v1.2.7: Auto race The Hollow"]="v1.2.7: Tự động đua sự kiện The Hollow",["v1.2.7: Auto race Hollow"]="v1.2.7: Tự động đua sự kiện Hollow",["Auto race Hollow"]="Tự động đua sự kiện Hollow",["Balanced"]="Cân bằng",["Strong"]="Mạnh",["v1.2.6: Mutate eggs you choose with multiple mutations, much shorter delay between tasks and instant take back when someone grabs your egg"]="v1.2.6: Đột biến trứng tự chọn với nhiều đột biến, giảm độ trễ giữa các tác vụ và giật lại tức thì khi bị cướp",["v1.2.5: Teleport to egg"]="v1.2.5: Dịch chuyển tới trứng",["Riding the Phantom Express"]="Đang đi Tàu Bóng Ma",["Fighting Small monster"]="Đang đánh quái vật nhỏ",["Fighting Medium monster"]="Đang đánh quái vật vừa",["Fighting Large monster"]="Đang đánh quái vật lớn",["UI scale"]="Kích cỡ Menu",["Show / hide UI"]="Phím ẩn / hiện Menu",["Opacity"]="Độ trong suốt",["Tone"]="Tông màu",["Dim the game"]="Làm tối nền game",["QUICK BARS"]="THANH PHÍM TẮT NHANH",["Quick bars"]="Thanh phím tắt nhanh",["Show quick bars"]="Hiện thanh phím tắt nhanh",["Keybinds"]="Phím tắt",["Bar size"]="Kích cỡ thanh nhanh",["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT",["All"]="Tất cả",["Pinned"]="Đã ghim",["Clear all quick bars"]="Xóa hết thanh nhanh",["Clear all keybinds"]="Xóa hết phím tắt",["DEFAULTS"]="MẶC ĐỊNH",["Reset to defaults"]="Khôi phục mặc định",["Reset"]="Đặt lại",["Turn off all toggles"]="Tắt toàn bộ công tắc",["Turn off"]="Tắt hết",["Steal An Egg"]="Cướp Trứng",["CANDY CORN"]="KẸO NGÔ",["Candy Corn"]="Kẹo Ngô",["Calculate mutations"]="Tính thử đột biến",["Cards show the value with these mutations added"]="Thẻ trứng sẽ hiển thị giá trị sau khi cộng thêm các đột biến này",["Delivery speed"]="Tốc độ mang trứng về",["Change if steal fails"]="Hãy chỉnh giảm xuống nếu cướp trứng bị lỗi",["Auto farm monsters"]="Tự động cày quái vật",["Auto kill monsters"]="Tự động đánh quái vật",["Bat"]="Gậy Dơi (Bat)",["Instant steal"]="Cướp tức thì",["Admin treadmill"]="Máy tập Admin",["CURSED ISLAND WARS"]="ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",["Cursed Island Wars"]="Đại Chiến Đảo Nguyền Rủa",["Waiting for Cursed Island Wars"]="Đang chờ Đại Chiến Đảo Nguyền Rủa",["Auto play Cursed Island Wars"]="Tự động chơi Đại Chiến Đảo Nguyền Rủa",["Island Wars target"]="Mục tiêu Đảo Nguyền Rủa",["Enemies and base"]="Kẻ địch và Căn cứ",["Walls and crystal"]="Tường chắn và Pha lê",["Catching a pumpkin"]="Đang nhặt bí ngô",["Carrying a pumpkin to the altar"]="Đang mang bí ngô tới bệ thờ",["Delivering a pumpkin to the altar"]="Đang giao bí ngô tới bệ thờ",["FIX"]="SỬA LỖI",["Most tokens"]="Nhiều kẹo/xu nhất",["Admin abuse works like Chilli: admin treadmill, Capture the egg, minigame eggs and Instant steal"]="Lạm dụng Admin hoạt động chuẩn: Máy tập Admin, Cướp trứng sự kiện, trứng Minigame và Cướp tức thì",["Fixed lag back with the Tween delivery method"]="Đã sửa lỗi giật lùi (lag back) khi mang trứng về bằng chế độ Bay (Tween)",["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",["v1.1.0: Halloween tasks follow Task order, Walk speed for monsters, pumpkins and ghosts, Use weapons picks every weapon, Lab and Race shop removed"]="v1.1.0: Nhiệm vụ Halloween tuân theo Thứ tự tác vụ, thêm Tốc độ chạy khi săn quái, bí ngô và ma, Sử dụng vũ khí tự chọn mọi loại vũ khí, đã gỡ bỏ Phòng Lab và Shop Đua Xe",["Halloween: Dimension eggs, monsters, Ghost Dog quest, fishing, Phantom Express and Cursed Island Wars"]="Sự kiện Halloween: Trứng Không gian Halloween, đánh quái, nhiệm vụ Chó Ma, câu cá, Tàu Ma Phantom Express và Đại Chiến Đảo Nguyền Rủa",["Idle"]="Đang rảnh",["Waiting"]="Đang chờ",["Nothing"]="Không có gì",["Off"]="Tắt",["OFF"]="TẮT",["On"]="Bật",["ON"]="BẬT",["No egg matches your targets"]="Không có trứng nào khớp mục tiêu",["No eggs match your targets"]="Không có trứng nào khớp mục tiêu",["No egg matches filter"]="Không có trứng khớp bộ lọc",["No eggs match filter"]="Không có trứng khớp bộ lọc",["No target egg found"]="Không tìm thấy trứng mục tiêu",["No matching eggs"]="Không có trứng nào khớp",["No valid targets"]="Không có mục tiêu hợp lệ",["Bag is full"]="Túi đã đầy",["Egg bag is full"]="Túi trứng đã đầy",["Pet bag is full"]="Túi pet đã đầy",["Pen is full"]="Chuồng ấp đã đầy",["Field is closed"]="Sân trứng đang đóng",["Waiting for field to open"]="Đang chờ sân trứng mở",["Waiting for eggs to spawn"]="Đang chờ trứng xuất hiện",["Waiting in safe zone"]="Đợi ở vùng an toàn",["Returning to safe zone"]="Đang về vùng an toàn",["Returning home"]="Đang quay về nhà",["Delivering egg"]="Đang giao trứng về chuồng",["Dropping egg"]="Đang thả trứng",["Selling eggs"]="Đang bán trứng",["Selling pets"]="Đang bán pet",["Hatching eggs"]="Đang ấp trứng",["Placing eggs"]="Đang đặt trứng",["Mutating eggs"]="Đang đột biến trứng",["Fusing pets"]="Đang dung hợp pet",["Hopping server"]="Đang đổi máy chủ",["Rejoining"]="Đang vào lại phòng",["Avoiding guard"]="Đang né vệ sĩ",["Using treadmill"]="Đang chạy máy tập",["Upgrading treadmill"]="Đang nâng cấp máy tập",["Upgrading base"]="Đang nâng cấp căn cứ",["Claiming rewards"]="Đang nhận thưởng",["Claiming offline cash"]="Đang nhận tiền ngoại tuyến",["Joining race"]="Đang vào đường đua",["Racing"]="Đang đua xe",["Welcome Home"]="Trang Chủ",["Welcome back"]="Chào mừng trở lại",["Venyx Discord"]="Chilli Hub Discord",["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ",["Copy Invite"]="Chép Link Mời",["Copy link"]="Chép Link Mời",["Discord"]="Chilli Hub",["MONEY /S"]="TIỀN /GIÂY",["CASH / S"]="TIỀN / GIÂY",["OPEN"]="MỞ",["Open"]="Mở",["Close"]="Đóng",["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",["Beta version"]="Phiên bản Beta",["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",["Rejoin"]="Vào lại",["Server hop"]="Đổi server",["Copy Job ID"]="Chép Job ID",["Unload hub"]="Tắt Hub",["Unload"]="Tắt Hub",["Save config"]="Lưu cấu hình",["Hide UI"]="Ẩn Menu",["SESSION"]="PHIÊN CHƠI",["STOLEN"]="ĐÃ CƯỚP",["LAST EGG"]="TRỨNG CUỐI",["PLACED"]="ĐÃ ĐẶT",["HATCHED"]="ĐÃ ẤP",["NIGHT IN"]="ĐÊM SAU",["NEXT NIGHT"]="ĐÊM SAU",["SESSION TIME"]="THỜI GIAN",["TIME"]="THỜI GIAN",["BEST STEAL"]="CƯỚP TỐT NHẤT",["EGG BAG"]="TÚI TRỨNG",["PET BAG"]="TÚI PET",["WHAT'S NEW"]="CÓ GÌ MỚI",["NEW"]="MỚI",["Search"]="Tìm kiếm",["Filter"]="Lọc tìm",["Auto Steal"]="Tự Động Cướp",["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",["Auto steal"]="Tự động cướp",["Egg Predictor"]="Dự Đoán Trứng",["Go to egg"]="Di chuyển tới trứng",["Teleport to egg"]="Dịch chuyển tới trứng",["Walk to egg"]="Đi bộ tới trứng",["Tween to egg"]="Bay mượt tới trứng",["Teleport zones"]="Khu vực dịch chuyển",["Tween"]="Bay (Tween)",["Walk"]="Đi bộ",["Delivery method"]="Cách mang về",["Instant steps"]="Tức thì từng bước",["Instant"]="Tức thì",["Teleport"]="Dịch chuyển",["Fast tween speed"]="Tốc độ bay nhanh",["Tween speed"]="Tốc độ bay",["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục",["Steal back from players"]="Cướp lại từ người chơi",["Steal from other players"]="Cướp từ người chơi khác",["Anti guard"]="Chống vệ sĩ",["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn",["FILTER"]="BỘ LỌC",["Zones"]="Khu vực",["Steal first"]="Ưu tiên cướp",["Best value"]="Giá trị cao nhất",["Lowest value"]="Giá trị thấp nhất",["Best rarity"]="Độ hiếm cao nhất",["Best mutation"]="Đột biến tốt nhất",["Biggest"]="Kích thước to nhất",["Closest"]="Khoảng cách gần nhất",["Nearest"]="Gần nhất",["Mutations"]="Đột biến",["Rarities"]="Độ hiếm",["Only these eggs"]="Chỉ những trứng này",["Min value /s"]="Giá trị tối thiểu /s",["Max value /s"]="Giá trị tối đa /s",["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi",["Keep lab eggs"]="Giữ lại trứng Lab",["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ",["Auto hop server"]="Tự đổi máy chủ",["Auto hop"]="Tự động đổi server",["Hop now"]="Đổi server ngay",["First hop after"]="Đổi lần đầu sau",["Hop when"]="Đổi khi",["After stealing a match"]="Sau khi cướp đủ trứng lọc",["No matching egg"]="Không có trứng phù hợp",["Rare from"]="Độ hiếm từ",["Hop delay"]="Độ trễ đổi server",["Only sell eggs below /s"]="Chỉ bán trứng dưới mức /s",["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG",["Sort eggs"]="Sắp xếp trứng",["Preview card"]="Thẻ xem trước",["Pick one"]="Chọn một mục",["Pick any"]="Chọn bất kỳ",["Value"]="Giá trị",["Rarity"]="Độ hiếm",["Time left"]="Thời gian còn lại",["Default"]="Mặc định",["Clear"]="Xóa chọn",["Select all"]="Chọn tất cả",["SIZE"]="KÍCH CỠ",["WEIGHT"]="CÂN NẶNG",["READY"]="SẴN SÀNG",["IN BAG"]="TRONG TÚI",["GROWING"]="ĐANG LỚN",["Hatch now"]="Ấp ngay",["Hold egg"]="Cầm trứng",["Fly to egg"]="Bay tới trứng",["Steal egg"]="Cướp trứng",["Enchanted Forest"]="Rừng Phù Phép",["Light Dark"]="Sáng Tối",["Titan Temple"]="Đền Titan",["Cherry Blossom"]="Hoa Anh Đào",["Prehistoric"]="Tiền Sử",["Abyss Ocean"]="Đáy Đại Dương",["Volcano"]="Núi Lửa",["Snow"]="Tuyết",["Jungle"]="Rừng Rậm",["Desert"]="Sa Mạc",["Lake"]="Hồ Nước",["Forest"]="Khu Rừng",["Silver"]="Bạc",["Rainbow"]="Cầu Vồng",["Golden"]="Vàng",["Fractured"]="Rạn Nứt",["Scrambled"]="Hỗn Loạn",["Enchanted"]="Phù Phép",["Nitro"]="Nitro",["SCRAMBLED"]="HỖN LOẠN",["NITRO"]="NITRO",["FRACTURED"]="RẠN NỨT",["ENCHANTED"]="PHÙ PHÉP",["Pen"]="Chuồng Ấp",["PEN"]="CHUỒNG ẤP",["Treadmill"]="Máy Tập",["TREADMILL"]="MÁY TẬP CHẠY",["Mutate"]="Đột Biến",["Sell"]="Bán",["SELL"]="BÁN TỰ ĐỘNG",["Fuse"]="Dung Hợp",["FUSE"]="DUNG HỢP",["Priority"]="Ưu Tiên",["PRIORITY"]="THỨ TỰ ƯU TIÊN",["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG",["Auto place"]="Tự động đặt trứng",["Place when"]="Đặt khi",["Always"]="Luôn luôn",["Place first"]="Ưu tiên đặt",["KEEP EGGS"]="GIỮ LẠI TRỨNG",["Eggs to keep"]="Trứng cần giữ",["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG",["Auto hatch"]="Tự động ấp trứng",["Equip best pets"]="Trang bị pet mạnh nhất",["READY NOW"]="SẴN SÀNG ẤP",["Auto treadmill"]="Tự chạy máy tập",["Auto upgrade treadmill"]="Tự nâng cấp máy tập",["PROGRESS"]="TIẾN TRÌNH",["Auto upgrade base"]="Tự nâng cấp căn cứ",["Auto buy trails"]="Tự mua vệt sáng",["Auto claim offline cash"]="Tự nhận tiền ngoại tuyến",["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục",["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN",["Auto mutate"]="Tự động đột biến",["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN",["Use items"]="Dùng vật phẩm",["Mutate first"]="Ưu tiên đột biến",["Skip eggs with"]="Bỏ qua trứng đã có",["Auto buy Nitro"]="Tự mua Nitro",["PETS"]="THÚ CƯNG (PETS)",["EGGS"]="TRỨNG (EGGS)",["Auto sell pets"]="Tự động bán pet",["Auto sell eggs"]="Tự động bán trứng",["Sell all eggs now"]="Bán hết trứng ngay",["Sell all pets now"]="Bán hết Pet ngay",["Sell rarities"]="Độ hiếm bán",["Never sell"]="Không bao giờ bán",["Only mutations"]="Chỉ bán đột biến",["Only below /s"]="Chỉ dưới mức /s",["Keep mutated"]="Giữ lại đồ đột biến",["LAB EGGS"]="TRỨNG PHÒNG LAB",["FAVORITE"]="YÊU THÍCH (KHÓA)",["Auto favorite"]="Tự động khóa bảo vệ",["Favorite matching now"]="Khóa đồ khớp lọc ngay",["Unfavorite pets not matching"]="Bỏ thích Pet không khớp",["Always favorite"]="Luôn khóa Yêu thích",["Auto sell lab eggs"]="Tự động bán trứng Lab",["Match"]="Điều kiện khớp",["All picked rules"]="Khớp tất cả quy tắc",["Any picked rule"]="Khớp bất kỳ quy tắc",["Favorite equipped"]="Khóa pet đang trang bị",["FUSE MACHINE"]="MÁY DUNG HỢP",["No 3 matching pets"]="Chưa đủ 3 pet cùng loại",["Auto fuse"]="Tự động dung hợp",["Fuse first"]="Ưu tiên dung hợp",["Lowest rarity"]="Độ hiếm thấp nhất",["Highest rarity"]="Độ hiếm cao nhất",["Use pets"]="Sử dụng pet",["Lowest value first"]="Giá trị thấp nhất trước",["Highest value first"]="Giá trị cao nhất trước",["Skip mutated"]="Bỏ qua pet đột biến",["Eject odd pets"]="Đẩy pet lẻ ra ngoài",["FUSE FILTER"]="BỘ LỌC DUNG HỢP",["Only these pets"]="Chỉ những pet này",["Never fuse"]="Không bao giờ dung hợp",["FUSE PREDICTOR"]="DỰ ĐOÁN DUNG HỢP",["SLOTS"]="Ô CHỨA",["STATUS"]="TRẠNG THÁI",["LIKELY SIZE"]="KÍCH CỠ DỰ KIẾN",["CHANCE"]="TỶ LỆ",["VALUE"]="GIÁ TRỊ",["BEST CASE"]="TỐT NHẤT CÓ THỂ",["TASK ORDER"]="THỨ TỰ TÁC VỤ",["Task order"]="Thứ tự tác vụ",["Reset order"]="Đặt lại thứ tự",["DOING"]="ĐANG LÀM",["WAITING"]="ĐANG CHỜ",["Steal filter eggs"]="Cướp trứng theo bộ lọc",["Shooting Star"]="Bắt Sao Băng",["Racing Event"]="Sự Kiện Đua Xe",["Butterfly"]="Bắt Bướm",["Steal wisp eggs"]="Cướp trứng Wisp",["Wisp"]="Nhặt Wisp",["Steal missing index"]="Cướp trứng thiếu trong Chỉ mục",["Steal lab eggs"]="Cướp trứng phòng Lab",["Place"]="Đặt trứng vào chuồng",["Butterfly machine"]="Máy đổi Bướm",["Race"]="Đua Xe",["RACE"]="ĐUA XE",["Star"]="Sao Băng",["STAR"]="SAO BĂNG",["BUTTERFLY"]="BẮT BƯỚM",["Lab"]="Phòng Lab",["LAB"]="PHÒNG LAB",["AA"]="Admin (AA)",["Halloween"]="Halloween",["HALLOWEEN"]="HALLOWEEN",["HALLOWEEN DIMENSION"]="KHÔNG GIAN HALLOWEEN",["Auto steal Halloween eggs"]="Tự động cướp trứng Halloween",["Instant steal Halloween eggs"]="Cướp tức thì trứng Halloween",["Steal speed"]="Tốc độ cướp",["Halloween eggs"]="Trứng Halloween",["Halloween rarities"]="Độ hiếm Halloween",["Auto Pumpkin Moon"]="Tự làm sự kiện Trăng Bí Ngô",["Auto buy Halloween Dimension Egg"]="Tự mua trứng Không gian Halloween",["Walk speed"]="Tốc độ chạy bộ",["GHOST DOG AND FISHING"]="CHÓ MA VÀ CÂU CÁ",["QUEST"]="NHIỆM VỤ",["Done"]="Đã xong",["FISH CAUGHT"]="CÁ ĐÃ CÂU",["Auto Ghost Dog quest"]="Tự làm nhiệm vụ Chó Ma",["Auto fishing"]="Tự động câu cá",["Cast luck"]="Tỷ lệ câu may mắn",["Perfect"]="Hoàn hảo (Perfect)",["MONSTERS"]="QUÁI VẬT",["Monsters"]="Tên quái vật",["Monster order"]="Thứ tự đánh quái",["Rarest first"]="Hiếm nhất trước",["PHANTOM EXPRESS"]="TÀU MA PHANTOM EXPRESS",["TRAIN"]="CHUYẾN TÀU",["Not here"]="Chưa đến",["SOULS"]="LINH HỒN",["Auto Phantom Express"]="Tự động cướp Tàu Ma",["Auto vacuum Ghouler boss"]="Tự hút linh hồn Boss Ghouler",["Ghost target"]="Mục tiêu ma",["Auto trade souls"]="Tự động đổi linh hồn",["RACING EVENT"]="SỰ KIỆN ĐUA XE",["NEXT RACE"]="ĐUA TIẾP THEO",["WINS"]="THẮNG",["TROPHIES"]="CÚP",["Auto race"]="Tự động đua xe",["Race speed"]="Tốc độ đua",["Use power-ups"]="Tự dùng vật phẩm tăng tốc",["REWARDS"]="PHẦN THƯỞNG",["Auto claim rewards"]="Tự nhận phần thưởng",["Auto equip racer"]="Tự trang bị xe đua",["Racer"]="Xe đua",["Best owned"]="Tốt nhất đang có",["Auto buy shop"]="Tự mua vật phẩm Shop",["Shop items"]="Vật phẩm Shop",["SHOOTING STAR"]="SAO BĂNG RƠI",["LANDS IN"]="RƠI SAU",["CATCH"]="BẮT SAO BĂNG",["CAUGHT"]="ĐÃ BẮT",["EXPIRES IN"]="BIẾN MẤT SAU",["SLIPPED"]="TUỘT MẤT",["TRIES"]="SỐ LẦN THỬ",["DISTANCE"]="KHOẢNG CÁCH",["Auto catch shooting star"]="Tự động bắt sao băng",["BUTTERFLY BLOOM"]="MÙA BƯỚM NỞ",["Auto butterfly bloom"]="Tự động bắt bướm",["EMERALD"]="LỤC BẢO",["SAPPHIRE"]="LAM NGỌC",["AMETHYST"]="THẠCH ANH TÍM",["RADIANT"]="RỰC RỠ",["ESSENCE"]="TINH CHẤT",["Catch mode"]="Chế độ bắt",["Stand"]="Đứng yên",["Chase"]="Đuổi theo",["BUTTERFLY MACHINE"]="MÁY ĐỔI BƯỚM",["Auto trade up"]="Tự nâng cấp bậc bướm",["Trade"]="Giao dịch đổi",["Smart trade for essence"]="Đổi bướm lấy tinh chất thông minh",["Auto craft essence"]="Tự chế tạo tinh chất",["WISP COMPANION"]="ĐỒNG HÀNH WISP",["Catch priority"]="Ưu tiên bắt",["Rarest"]="Hiếm nhất",["Catch"]="Loại bướm bắt",["Catch speed"]="Tốc độ bắt",["Auto wisp quest"]="Tự làm nhiệm vụ Wisp",["Auto banjo cricket"]="Tự bắt dế Banjo",["STAGE"]="GIAI ĐOẠN",["LAB ODDS"]="TỶ LỆ PHÒNG LAB",["BANNER"]="BĂNG RÔN",["ENDS IN"]="KẾT THÚC SAU",["BANNER CHANCE"]="TỶ LỆ BĂNG RÔN",["NEXT"]="TIẾP THEO",["Experimental Pets"]="Pet Thí Nghiệm",["Biohazard Pets"]="Pet Sinh Học",["Lab banners"]="Băng rôn phòng Lab",["Auto trade in"]="Tự động đổi trứng Lab",["Auto reroll recipe"]="Tự đổi lại công thức",["Place lab reward eggs"]="Đặt trứng thưởng từ Lab",["ADMIN ABUSE"]="LẠM DỤNG ADMIN (ABUSE)",["No admin boost right now"]="Hiện không có buff Admin nào",["Instant steal (Admin Treadmill)"]="Cướp tức thì (Máy tập Admin)",["Use admin treadmill"]="Tự dùng máy tập Admin",["CAPTURE THE EGG"]="CƯỚP TRỨNG SỰ KIỆN",["Auto capture event egg"]="Tự bắt trứng sự kiện",["Take it from the holder"]="Giật trứng từ người đang cầm",["Hold height"]="Độ cao giữ trứng",["Keep away"]="Khoảng cách né tránh",["MINIGAME EGGS"]="TRỨNG MINIGAME",["Auto steal minigame egg"]="Tự cướp trứng Minigame",["ESP"]="Định Vị (ESP)",["Move"]="Di Chuyển",["MOVE"]="DI CHUYỂN",["Combat"]="Chiến Đấu",["COMBAT"]="CHIẾN ĐẤU",["FIELD EGGS"]="TRỨNG NGOÀI SÂN",["Egg ESP"]="ESP Trứng",["Show"]="Hiển thị",["Name"]="Tên",["Fixed size"]="Cố định kích cỡ",["OTHERS"]="MỤC KHÁC",["Pen egg ESP"]="ESP trứng trong chuồng",["Other pens ESP"]="ESP chuồng người khác",["Guard ESP"]="ESP Vệ sĩ",["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ",["Player ESP"]="ESP Người chơi",["ESP size"]="Kích cỡ ESP",["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN",["Speed boost"]="Tăng tốc chạy",["Boost speed"]="Tốc độ tăng thêm",["Infinite jump"]="Nhảy vô hạn",["God mode"]="Bất tử (God mode)",["PROTECTION"]="BẢO VỆ NHÂN VẬT",["Anti ragdoll"]="Chống ngã (Anti Ragdoll)",["Ignore traps"]="Bỏ qua bẫy",["Instant prompts"]="Tương tác nhấn giữ tức thì",["Anti AFK"]="Chống treo máy (Anti AFK)",["Invisible"]="Tàng hình",["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",["Auto hit"]="Tự động đánh",["Hit who"]="Mục tiêu đánh",["Nearest player"]="Người chơi gần nhất",["Chosen player"]="Người chơi chỉ định",["Egg carrier"]="Người đang ôm trứng",["Chase speed"]="Tốc độ đuổi theo",["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG",["Hit aura"]="Vòng đánh tự động (Hit Aura)",["Skip friends"]="Bỏ qua bạn bè",["WEAPONS"]="VŨ KHÍ",["Use weapons"]="Sử dụng vũ khí",["Hold each"]="Thời gian cầm mỗi món",["Server"]="Máy Chủ",["SERVER"]="MÁY CHỦ",["Webhook"]="Webhook",["WEBHOOK"]="WEBHOOK",["Optimizer"]="Tối Ưu Hóa",["OPTIMIZER"]="TỐI ƯU HÓA",["Interface"]="Giao Diện",["INTERFACE"]="GIAO DIỆN",["GAME HUD"]="TRÊN MÀN HÌNH GAME",["Steal panel button on game HUD"]="Hiện nút Bảng Cướp trên màn hình",["Config"]="Cấu Hình",["CONFIG"]="CẤU HÌNH",["CONFIGS"]="QUẢN LÝ CẤU HÌNH",["Configs"]="Danh sách cấu hình",["ACTIVE"]="ĐANG DÙNG",["SAVED CONFIGS"]="ĐÃ LƯU",["Set as active config"]="Đặt làm cấu hình chính",["Set active"]="Kích hoạt",["Save changes"]="Lưu thay đổi",["Save"]="Lưu",["Overwrite"]="Lưu đè",["PROFILES"]="HỒ SƠ CẤU HÌNH",["New config name"]="Tên cấu hình mới",["Config name"]="Tên cấu hình",["Auto if empty"]="Tự đặt nếu trống",["Create config"]="Tạo cấu hình mới",["Create"]="Tạo mới",["Pick to delete"]="Chọn mục cần xóa",["Delete picked"]="Xóa mục đã chọn",["Delete"]="Xóa",["Restore deleted"]="Khôi phục mục đã xóa",["Export config"]="Xuất mã cấu hình",["Export to clipboard"]="Chép mã cấu hình",["Import text"]="Dán mã cấu hình",["Paste config text"]="Dán mã JSON vào đây",["Paste config JSON here"]="Dán mã JSON vào đây",["Import config"]="Nhập cấu hình",["Import"]="Nhập",["Config imported"]="Đã nhập cấu hình",["Config loaded"]="Đã nạp cấu hình",["Later"]="Để sau",["Apply now"]="Áp dụng ngay",["Hop to"]="Chuyển tới server",["Least players"]="Ít người chơi nhất",["Most players"]="Đông người chơi nhất",["Random"]="Ngẫu nhiên",["Hop server"]="Đổi máy chủ",["Hop"]="Đổi ngay",["Rejoin this server"]="Vào lại máy chủ này",["Copy"]="Sao chép",["JOIN AND STAY"]="VÀO PHÒNG & DUY TRÌ",["Job ID"]="Mã phòng (Job ID)",["Paste a Job ID"]="Dán mã Job ID vào đây",["Join that server"]="Vào máy chủ đó",["Join"]="Vào ngay",["Rejoin on kick"]="Tự vào lại khi bị văng/kick",["Auto load script"]="Tự chạy lại script khi chuyển server",["DISCORD WEBHOOK"]="WEBHOOK DISCORD",["Webhook URL"]="Đường dẫn Webhook",["Ping role ID"]="ID Vai trò (Role ID)",["Ping user ID"]="ID Người dùng (User ID)",["Ping everyone"]="Tag @everyone",["WHAT TO POST"]="NỘI DUNG GỬI BÁO CÁO",["Post stolen eggs"]="Báo cáo trứng cướp được",["Post fused eggs"]="Báo cáo trứng dung hợp",["POSTED"]="ĐÃ GỬI",["Send a test post"]="Gửi tin nhắn thử nghiệm",["Test"]="Thử nghiệm",["Post when bag is full"]="Gửi thông báo khi đầy túi",["GRAPHICS"]="ĐỒ HỌA",["Low graphics"]="Đồ họa thấp (Tăng FPS)",["Disable 3D Render"]="Tắt kết xuất 3D (Treo máy)",["Background color"]="Màu nền màn hình",["Black"]="Màu Đen",["White"]="Màu Trắng",["Hide game UI"]="Ẩn giao diện gốc của Game",["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)",["FPS cap"]="Giới hạn FPS",["FPS position"]="Vị trí thanh FPS",["Show FPS and ping"]="Hiện chỉ số FPS và Ping",["BASES"]="CĂN CỨ (BASES)",["Hide other players' pets and eggs"]="Ẩn pet và trứng của người chơi khác",["Hide my pets and eggs"]="Ẩn pet và trứng của bản thân",["Theme"]="Chủ đề màu",["Toggle key"]="Phím đóng/mở Menu",["Quick bar"]="Thanh phím tắt nhanh",["QUICK BAR"]="THANH PHÍM TẮT NHANH",["Auto save"]="Tự động lưu cấu hình",["Auto load"]="Tự động nạp cấu hình",["Auto load on join"]="Tự động nạp khi vào game",["Load config"]="Nạp cấu hình",["Load"]="Nạp cấu hình",["Reset config"]="Đặt lại mặc định",["Delete config"]="Xóa cấu hình",["Common"]="Phổ Thông",["Uncommon"]="Thường",["Rare"]="Hiếm",["Epic"]="Sử Thi",["Legendary"]="Huyền Thoại",["Mythic"]="Thần Thoại",["Cosmic"]="Vũ Trụ",["Secret"]="Bí Ẩn",["Divine"]="Thánh Thần",["Eternal"]="Vĩnh Cửu",["COMMON"]="PHỔ THÔNG",["UNCOMMON"]="THƯỜNG",["RARE"]="HIẾM",["EPIC"]="SỬ THI",["LEGENDARY"]="HUYỀN THOẠI",["MYTHIC"]="THẦN THOẠI",["COSMIC"]="VŨ TRỤ",["SECRET"]="BÍ ẨN",["DIVINE"]="THÁNH THẦN",["ETERNAL"]="VĨNH CỬU",["Radiant"]="Rực Rỡ",["Amethyst"]="Thạch Anh Tím",["Sapphire"]="Lam Ngọc",["Emerald"]="Ngọc Lục Bảo"
}
local LOWER_VI={}
for k,v in pairs(EXACT_VI)do
local lk=k:lower()
if not LOWER_VI[lk] or k:upper()~=k then
LOWER_VI[lk]=v
end
end
local GRAMMAR_VI={
{pat="^[Gg]oing%s+into%s+(.+)$",rep="Đang vào %1"},
{pat="^[Ll]eaving%s+(.+)$",rep="Đang rời %1"},
{pat="^[Ee]ntering%s+(.+)$",rep="Đang vào %1"},
{pat="^[Vv]acuuming%s+ghosts%s*(.*)$",rep="Đang hút bóng ma %1"},
{pat="^[Rr]iding%s+(.+)$",rep="Đang đi %1"},
{pat="^[Ff]ighting%s+[Ss]mall%s+monster$",rep="Đang đánh quái vật nhỏ"},
{pat="^[Ff]ighting%s+[Mm]edium%s+monster$",rep="Đang đánh quái vật vừa"},
{pat="^[Ff]ighting%s+[Ll]arge%s+monster$",rep="Đang đánh quái vật lớn"},
{pat="^[Aa]uto play (.+)$",rep="Tự động chơi %1"},{pat="^[Aa]uto farm (.+)$",rep="Tự động cày %1"},
{pat="^[Aa]uto kill (.+)$",rep="Tự động tiêu diệt %1"},{pat="^[Aa]uto catch (.+)$",rep="Tự động bắt %1"},
{pat="^[Aa]uto collect (.+)$",rep="Tự động thu thập %1"},{pat="^[Aa]uto buy (.+)$",rep="Tự động mua %1"},
{pat="^[Aa]uto sell (.+)$",rep="Tự động bán %1"},{pat="^[Aa]uto claim (.+)$",rep="Tự động nhận %1"},
{pat="^[Aa]uto upgrade (.+)$",rep="Tự động nâng cấp %1"},{pat="^[Aa]uto craft (.+)$",rep="Tự động chế tạo %1"},
{pat="^[Aa]uto trade (.+)$",rep="Tự động trao đổi %1"},{pat="^[Aa]uto equip (.+)$",rep="Tự động trang bị %1"},
{pat="^[Aa]uto steal (.+)$",rep="Tự động cướp %1"},{pat="^[Ii]nstant steal (.+)$",rep="Cướp tức thì %1"},
{pat="^[Aa]uto (.+) quest$",rep="Tự làm nhiệm vụ %1"},{pat="^[Aa]uto (.+)$",rep="Tự động %1"},
{pat="^[Cc]alculate (.+)$",rep="Tính thử %1"},{pat="^[Cc]hange if (.+) fails$",rep="Chỉnh lại nếu %1 bị lỗi"},
{pat="^(.+) speed$",rep="Tốc độ %1"},{pat="^(.+) target$",rep="Mục tiêu %1"},
{pat="^(.+) order$",rep="Thứ tự %1"},{pat="^(.+) priority$",rep="Ưu tiên %1"},
{pat="^(.+) mode$",rep="Chế độ %1"},{pat="^(.+) filter$",rep="Bộ lọc %1"},
{pat="^[Hh]alloween: carrying (.+) to safety$",rep="Halloween: đang mang %1 đến nơi an toàn"},
{pat="^[Hh]alloween: (.+)$",rep="Halloween: %1"},
{pat="^[Nn]o eggs? match%w* your (.+)$",rep="Không có trứng nào khớp %1"},
{pat="^[Nn]o eggs? match%w* (.+)$",rep="Không có trứng nào khớp %1"},
{pat="^[Nn]o pets? match%w* (.+)$",rep="Không có pet nào khớp %1"},
{pat="^[Nn]o (.+) found(.*)$",rep="Không tìm thấy %1%2"},
{pat="^[Cc]arrying (.+) to safe zone(.*)$",rep="Đang mang %1 về vùng an toàn%2"},
{pat="^[Cc]arrying (.+) to base(.*)$",rep="Đang mang %1 về căn cứ%2"},
{pat="^[Cc]arrying (.+) to pen(.*)$",rep="Đang mang %1 về chuồng%2"},
{pat="^[Cc]arrying (.+) to (.+)$",rep="Đang mang %1 tới %2"},
{pat="^[Cc]arrying (.+) home(.*)$",rep="Đang mang %1 về nhà%2"},
{pat="^[Cc]arrying (.+)$",rep="Đang mang %1"},
{pat="^[Dd]elivering (.+) to (.+)$",rep="Đang giao %1 tới %2"},
{pat="^[Dd]elivering (.+) home(.*)$",rep="Đang giao %1 về nhà%2"},
{pat="^[Dd]elivering (.+)$",rep="Đang giao %1"},
{pat="^[Bb]ringing (.+) to (.+)$",rep="Đang đem %1 tới %2"},
{pat="^[Tt]aking (.+) from (.+)$",rep="Đang giật %1 từ %2"},
{pat="^[Ss]tealing (.+) from (.+)$",rep="Đang cướp %1 từ %2"},
{pat="^[Ss]tealing (.+)$",rep="Đang cướp %1"},
{pat="^[Gg]rabbing (.+)$",rep="Đang nhặt %1"},{pat="^[Pp]icking up (.+)$",rep="Đang nhặt %1"},
{pat="^[Cc]ollecting (.+)$",rep="Đang thu thập %1"},{pat="^[Dd]ropping (.+) at (.+)$",rep="Đang thả %1 tại %2"},
{pat="^[Tt]weening to (.+)$",rep="Đang bay tới %1"},{pat="^[Tt]eleporting to (.+)$",rep="Đang dịch chuyển tới %1"},
{pat="^[Gg]oing to (.+)$",rep="Đang đi tới %1"},{pat="^[Mm]oving to (.+)$",rep="Đang di chuyển tới %1"},
{pat="^[Ww]alking to (.+)$",rep="Đang chạy tới %1"},{pat="^[Rr]unning to (.+)$",rep="Đang chạy tới %1"},
{pat="^[Ff]lying to (.+)$",rep="Đang bay tới %1"},{pat="^[Rr]eturning to (.+)$",rep="Đang quay về %1"},
{pat="^[Pp]lacing (.+)$",rep="Đang đặt %1"},{pat="^[Hh]atching (.+)$",rep="Đang ấp %1"},
{pat="^[Mm]utating (.+)$",rep="Đang đột biến %1"},{pat="^[Ss]elling (.+)$",rep="Đang bán %1"},
{pat="^[Ff]using (.+)$",rep="Đang dung hợp %1"},{pat="^[Uu]pgrading (.+)$",rep="Đang nâng cấp %1"},
{pat="^[Bb]uying (.+)$",rep="Đang mua %1"},{pat="^[Cc]laiming (.+)$",rep="Đang nhận %1"},
{pat="^[Ee]quipping (.+)$",rep="Đang trang bị %1"},{pat="^[Cc]atching (.+)$",rep="Đang bắt %1"},
{pat="^[Cc]hasing (.+)$",rep="Đang đuổi theo %1"},{pat="^[Aa]ttacking (.+)$",rep="Đang tấn công %1"},
{pat="^[Hh]itting (.+)$",rep="Đang đánh %1"},{pat="^[Kk]illing (.+)$",rep="Đang tiêu diệt %1"},
{pat="^[Tt]rading in (.+)$",rep="Đang đổi %1"},{pat="^[Cc]rafting (.+)$",rep="Đang chế tạo %1"},
{pat="^[Aa]voiding (.+)$",rep="Đang né %1"},{pat="^[Ww]aiting for (.+)$",rep="Đang chờ %1"},
{pat="^[Ww]aiting in (.+)$",rep="Đang đợi ở %1"},{pat="^[Ww]aiting %((.+)%)$",rep="Đang chờ (%1)"},
{pat="^[Ss]earching for (.+)$",rep="Đang tìm %1"},{pat="^[Ff]arming (.+)$",rep="Đang cày %1"},
{pat="^[Uu]sing (.+)$",rep="Đang dùng %1"},{pat="^[Jj]oining (.+)$",rep="Đang tham gia %1"},
{pat="^[Hh]opping (.+)$",rep="Đang đổi %1"}
}
local PHRASES_VI={
{"steal missing halloween index","Cướp trứng Halloween thiếu trong Chỉ mục"},
{"missing halloween index","Halloween thiếu trong Chỉ mục"},
{"hatch missing in egg index","ấp trứng thiếu trong Chỉ mục"},
{"in egg index","trong Chỉ mục trứng"},
{"egg index","Chỉ mục trứng"},
{"auto claim mastery","Tự động nhận thưởng Thông Thạo"},
{"claim mastery","nhận thưởng Thông Thạo"},
{"stub pickup speed","Tốc độ nhặt Cuống Bí Ngô"},
{"pickup speed","Tốc độ nhặt vật phẩm"},
{"cuống pickup","nhặt Cuống Bí Ngô"},
{"cursed island wars","Đại Chiến Đảo Nguyền Rủa"},{"island wars","Đảo Nguyền Rủa"},{"phantom express","Tàu Ma Phantom Express"},
{"pumpkin moon","Trăng Bí Ngô"},{"halloween dimension","Không gian Halloween"},{"ghost dog","Chó Ma"},
{"enemies and base","Kẻ địch và Căn cứ"},{"walls and crystal","Tường chắn và Pha lê"},{"candy corn","Kẹo Ngô"},
{"admin treadmill","máy tập Admin"},{"instant steal","cướp tức thì"},{"capture the egg","Cướp trứng sự kiện"},
{"no egg matches your targets","Không có trứng nào khớp mục tiêu"},{"no eggs match filter","Không có trứng khớp bộ lọc"},
{"waiting for field to open","Đang chờ sân trứng mở"},{"waiting for eggs to spawn","Đang chờ trứng xuất hiện"},
{"waiting in safe zone","Đợi ở vùng an toàn"},{"returning to safe zone","Đang về vùng an toàn"},
{"to the altar","tới bệ thờ"},{"to altar","tới bệ thờ"},{"the altar","bệ thờ"},{"a pumpkin","bí ngô"},
{"egg bag is full","Túi trứng đã đầy"},{"pet bag is full","Túi pet đã đầy"},{"bag is full","Túi đã đầy"},
{"pen is full","Chuồng đã đầy"},{"field is closed","Sân trứng đang đóng"},{"safe zone","vùng an toàn"},
{"other players","người chơi khác"},{"missing index","thiếu trong Chỉ mục"},{"shooting star","sao băng"},
{"butterfly bloom","mùa bướm nở"},{"racing event","sự kiện đua xe"},{"offline cash","tiền ngoại tuyến"},
{"index rewards","thưởng Chỉ mục"},{"lab eggs","trứng Lab"},{"event egg","trứng sự kiện"},
{"minigame eggs","trứng Minigame"},{"minigame egg","trứng Minigame"},{"wisp eggs","trứng Wisp"},
{"to safe zone","về vùng an toàn"},{"to safety","đến nơi an toàn"},{"to base","về căn cứ"},{"to pen","vào chuồng"},
{"was added to your configs","đã được thêm vào danh sách cấu hình"},
{"fixed some bugs","đã sửa một số lỗi vặt"},{"some bugs","một số lỗi vặt"},
{"movement speed up to","tốc độ di chuyển lên tới"},{"di chuyển tốc độ up tới","tốc độ di chuyển lên tới"},
{"improved fast bay (tween)","cải thiện Bay Nhanh (Fast Tween)"},{"improved fast tween","cải thiện Bay Nhanh (Fast Tween)"},{"fast tween","Bay Nhanh (Fast Tween)"},
{"auto pumpkin boss","tự đánh Boss Bí Ngô"},{"tự động bí ngô boss","tự đánh Boss Bí Ngô"},
{"dodges attacks","né đòn tấn công"},{"fires cannons","bắn đại bác"},
{"collects pumpkin stubs","nhặt Cuống Bí Ngô"},{"collects bí ngô stubs","nhặt Cuống Bí Ngô"},{"pumpkin stubs","Cuống Bí Ngô"},
{"auto manor key","tự lấy chìa khóa dinh thự"},{"tự động manor key","tự lấy chìa khóa dinh thự"},{"manor key","chìa khóa dinh thự"},
{"go to egg leap","Nhảy Tới Trứng"},{"di chuyển tới trứng leap","Nhảy Tới Trứng"},
{"replaces old go to egg","thay thế Đi Tới Trứng cũ"},{"replaces old di chuyển tới trứng","thay thế Đi Tới Trứng cũ"},{"replaces old","thay thế bản cũ"},
{"anti guard fires again","Chống vệ sĩ hoạt động trở lại"},{"anti vệ sĩ fires again","Chống vệ sĩ hoạt động trở lại"},{"fires again","hoạt động trở lại"},
{"finishes about twice as fast","hoàn tất nhanh gấp đôi"},{"twice as fast","nhanh gấp đôi"},
{"you can also hold any feature to pin it","bạn có thể nhấn giữ tính năng bất kỳ để ghim"},
{"set a key","gán phím tắt"},{"set key","gán phím tắt"},
{"inventory values","Giá trị túi đồ"},{"find option","Tìm tùy chọn"},{"just now","vừa xong"}
}
local VI_TO_EN={
["trang chủ"]="Home",["săn trứng"]="Steal",["tự cày"]="Farm",
["sự kiện"]="Events",["nhân vật"]="Player",["cài đặt"]="Settings",
["tự động cướp"]="Auto steal",["tự động"]="Auto",["dịch chuyển tới trứng"]="Go to egg",
["di chuyển tới trứng"]="Go to egg",["cách mang về"]="Delivery method",
["khu vực dịch chuyển"]="Teleport zones",["cướp trứng thiếu trong chỉ mục"]="Steal missing index eggs",
["cướp từ người chơi khác"]="Steal from other players",["chống vệ sĩ"]="Anti guard",
["thả trứng ở vùng an toàn"]="Drop eggs at safe zone",["chỉ những trứng này"]="Only these eggs",
["giá tối thiểu /s"]="Min value /s",["giá tối thiểu"]="Min value",
["bán trứng rẻ nhất khi đầy túi"]="Sell cheapest egg when bag is full",
["chỉ dưới mức /s"]="Only below /s",["không có"]="None",["không"]="None",
["giá trị cao nhất"]="Best value",["thánh thần"]="Divine",["vĩnh cửu"]="Eternal",
["bí ẩn"]="Secret",["vũ trụ"]="Cosmic",["thần thoại"]="Mythic",
["huyền thoại"]="Legendary",["sử thi"]="Epic",["hiếm"]="Rare",
["thường"]="Common",["tắt"]="Off",["bật"]="On",["tất cả"]="All",
["tìm trứng"]="Finder",["đang rảnh"]="Idle",["vào ngay"]="Join",
["tự vào sau"]="Force join",["độ hiếm"]="Rarity",["tài khoản"]="Account",
["miễn phí"]="Free",["ẩn"]="Hide",["hiện"]="Show",
["tự động: tắt"]="AUTO OFF",["tự động: bật"]="AUTO ON",
["đang tìm..."]="Searching...",["đang quét..."]="Scanning...",["đã thấy!"]="Found!"
}
for k,v in pairs(EXACT_VI)do
if type(v)=="string" and type(k)=="string" then
local lk=v:lower()
if not VI_TO_EN[lk] then VI_TO_EN[lk]=k end
end
end
local WORDS_VI={
hatch="ấp",hatches="ấp",hatched="đã ấp",
mastery="Thông Thạo",pickup="nhặt",missing="còn thiếu",
index="Chỉ mục",indexed="đã mở Chỉ mục",
kills="số lần hạ",kill="hạ",alive="còn sống",dead="đã hạ",
spawned="đã xuất hiện",hollow="Vực Hollow",abyss="Vực Thẳm",
wisp="Wisp",banjo="Banjo",cricket="dế",
leaving="Đang rời",entering="Đang vào",vacuuming="Đang hút",riding="Đang đi",choose="chọn",multiple="nhiều",shorter="ngắn hơn",delay="độ trễ",between="giữa",tasks="tác vụ",grabs="cướp",
idle="Đang rảnh",carrying="Đang mang",delivering="Đang giao",stealing="Đang cướp",grabbing="Đang nhặt",
picking="Đang nhặt",collecting="Đang thu thập",holding="Đang giữ",capturing="Đang bắt giữ",dropping="Đang thả",
tweening="Đang bay",teleporting="Đang dịch chuyển",going="Đang đi",moving="Đang di chuyển",walking="Đang đi bộ",
running="Đang chạy",flying="Đang bay",returning="Đang quay về",placing="Đang đặt",hatching="Đang ấp",
mutating="Đang đột biến",selling="Đang bán",fusing="Đang dung hợp",upgrading="Đang nâng cấp",buying="Đang mua",
claiming="Đang nhận",equipping="Đang trang bị",catching="Đang nhặt",chasing="Đang đuổi theo",attacking="Đang tấn công",
hitting="Đang đánh",killing="Đang tiêu diệt",trading="Đang đổi",crafting="Đang chế tạo",avoiding="Đang né",
waiting="Đang chờ",searching="Đang tìm",scanning="Đang quét",farming="Đang cày",using="Đang dùng",
joining="Đang vào",hopping="Đang đổi",rejoining="Đang vào lại",finding="Đang tìm",racing="Đang đua",
ready="Sẵn sàng",nothing="Không có gì",none="Không có",no="Không có",pumpkin="bí ngô",pumpkins="bí ngô",
altar="bệ thờ",monster="quái vật",monsters="quái vật",ghost="ma",ghosts="ma",soul="linh hồn",souls="linh hồn",
train="chuyến tàu",boss="Boss",cursed="nguyền rủa",island="đảo",wars="đại chiến",enemies="kẻ địch",
walls="tường chắn",crystal="pha lê",candy="kẹo",corn="ngô",fishing="câu cá",fish="cá",quest="nhiệm vụ",
dimension="không gian",delivery="mang về",calculate="tính thử",mutation="đột biến",mutations="đột biến",
weapon="vũ khí",weapons="vũ khí",removed="đã gỡ bỏ",added="đã thêm",fixed="đã sửa",egg="trứng",eggs="trứng",
pet="pet",pets="pet",matches="khớp",match="khớp",matching="khớp",your="của bạn",target="mục tiêu",
targets="mục tiêu",filter="bộ lọc",home="về nhà",base="căn cứ",pen="chuồng",pens="chuồng",field="sân trứng",
zone="khu vực",zones="khu vực",bag="túi",full="đầy",empty="trống",closed="đóng",open="mở",guard="vệ sĩ",
guards="vệ sĩ",player="người chơi",players="người chơi",server="máy chủ",treadmill="máy tập",race="đua xe",
star="sao băng",butterfly="bướm",portal="cổng",rewards="thưởng",reward="thưởng",cash="tiền",found="tìm thấy",
speed="tốc độ",instant="tức thì",steal="cướp",auto="tự động",to="tới",from="từ",["in"]="trong",at="tại",
["for"]="cho",with="với",["and"]="và",["or"]="hoặc",
some="một số",bug="lỗi",bugs="lỗi",improved="cải thiện",fast="nhanh",up="lên",
dodges="né",dodge="né",attacks="đòn đánh",attack="tấn công",fires="bắn",fire="bắn",
cannons="đại bác",cannon="đại bác",collects="nhặt",collect="nhặt",stubs="cuống",stub="cuống",
manor="dinh thự",key="chìa khóa",keys="chìa khóa",leap="nhảy vọt",replaces="thay thế",replace="thay thế",
old="cũ",new="mới",anti="chống",again="lại",finishes="hoàn tất",finish="hoàn tất",
about="khoảng",twice="gấp đôi",as="như",tip="Mẹo",also="cũng",can="có thể",
hold="nhấn giữ",any="bất kỳ",feature="tính năng",features="tính năng",pin="ghim",
it="nó",set="gán",option="tùy chọn",options="tùy chọn",find="tìm",
inventory="túi đồ",values="giá trị",value="giá trị",now="ngay",just="vừa"
}
local DYN_VI={
{pat="^(v[%d%.]+):%s*[Ff]ixed some bugs%.?$",rep="%1: Đã sửa một số lỗi vặt"},
{pat="^(v[%d%.]+):%s*đã sửa some bugs%.?$",rep="%1: Đã sửa một số lỗi vặt"},
{pat="^(v[%d%.]+):%s*[Mm]ovement speed up to (%d+%%),%s*improved [Ff]ast [Tt]ween.*$",rep="%1: Tăng tốc độ di chuyển lên tới %2, cải thiện Bay Nhanh (Fast Tween)"},
{pat="^(v[%d%.]+):%s*[Aa]uto [Pp]umpkin [Bb]oss.*$",rep="%1: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng"},
{pat="^(v[%d%.]+):%s*[Aa]nti guard fires again.*$",rep="%1: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi"},
{pat="^QUICK BAR (%d+)$",rep="THANH NHANH %1"},
{pat="^[Ee]%.g%. (.+)$",rep="VD: %1"},
{pat="^(.+) Egg$",rep="Trứng %1"},
{pat="^(%d+) seconds? ago$",rep="%1 giây trước"},
{pat="^(%d+) hours? ago$",rep="%1 giờ trước"},
{pat="^(%d+) days? ago$",rep="%1 ngày trước"},
{pat="^(%d+) minutes? ago$",rep="%1 phút trước"},
{pat="Venyx(.-)just now",rep="Chilli Hub%1vừa xong"},
{pat="Venyx(.-)(%d+) seconds? ago",rep="Chilli Hub%1%2 giây trước"},
{pat="^(.+) was added to your configs%. Apply it now%??$",rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?"},
{pat="^(.+) was added to your configs$",rep="Đã thêm '%1' vào danh sách cấu hình"},
{pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support",rep="Chào mừng tới Chilli Hub V8 (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ"},
{pat="Venyx(.-)(%d+) hours? ago",rep="Chilli Hub%1%2 giờ trước"},
{pat="Venyx(.-)(%d+) minutes? ago",rep="Chilli Hub%1%2 phút trước"},
{pat="Venyx(.-)(%d+) days? ago",rep="Chilli Hub%1%2 ngày trước"},
{pat="^ALL (%d+)$",rep="TẤT CẢ %1"},{pat="^READY (%d+)$",rep="SẴN SÀNG %1"},
{pat="^GROWING (%d+)$",rep="ĐANG LỚN %1"},{pat="^IN BAG (%d+)$",rep="TRONG TÚI %1"},
{pat="Pen (%d+/%d+).-(%d+) egg%(s%) ready to place",rep="Chuồng %1 · %2 trứng sẵn sàng đặt"},
{pat="(%d+) egg%(s%) can be mutated",rep="%1 trứng có thể đột biến"},
{pat="(%d+) pet%(s%) match",rep="%1 pet khớp bộ lọc"},{pat="(%d+) egg%(s%) match",rep="%1 trứng khớp bộ lọc"},
{pat="(%d+) lab egg%(s%) match",rep="%1 trứng Lab khớp bộ lọc"},{pat="^(%d+) pets$",rep="%1 thú cưng"},
{pat="(%d+ / %d+) players · (.+)",rep="%1 người chơi · %2"},
{pat="Experimental Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="Pet Thí Nghiệm · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},
{pat="Biohazard Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="Pet Sinh Học · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},
{pat="Unstable DNA · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="DNA Bất Ổn · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},
{pat="^Mythic · 1 in ([%d%.]+)$",rep="Thần Thoại · 1 trên %1"},
{pat="^Cosmic · 1 in ([%d%.]+)$",rep="Vũ Trụ · 1 trên %1"},
{pat="^Secret · 1 in ([%d%.]+)$",rep="Bí Ẩn · 1 trên %1"},
{pat="^Divine · 1 in ([%d%.]+)$",rep="Thánh Thần · 1 trên %1"},
{pat="^Eternal · 1 in ([%d%.]+)$",rep="Vĩnh Cửu · 1 trên %1"},
{pat="^First hop after (%d+)s$",rep="Đổi lần đầu sau %1 giây"},
{pat="^Hold each ([%d%.]+)s$",rep="Cầm mỗi món %1 giây"},
{pat="^(%d+) selected$",rep="Đã chọn %1 mục"},
{pat="^(%d+)%s*/%s*(%d+) selected$",rep="Đã chọn %1/%2"}
}
local function stripArt(s)
return((" " .. s .. " "):gsub("%s+[Aa]%s+"," "):gsub("%s+[Aa]n%s+"," "):gsub("%s+[Tt]he%s+"," "):match("^%s*(.-)%s*$")or s)
end
local function applyPhrases(s)
local out=s
for i=1,#PHRASES_VI do
local p=PHRASES_VI[i]
local guard=0
while guard<6 do
local a,b=out:lower():find(p[1],1,true)
if not a then break end
out=out:sub(1,a-1).. p[2] .. out:sub(b+1)
guard=guard+1
end
end
return out
end
local function applyWords(s)
return(stripArt(s):gsub("([\128-\255%a']+)",function(w)
if w:find("[\128-\255]")then return w end
local l=w:lower()
return WORDS_VI[l] or LOWER_VI[l] or w
end))
end
translateStatus=function(en)
if not en or en=="" then return State.Language=="EN" and "Idle" or "Đang rảnh" end
local t=(en:match("^%s*(.-)%s*$")or en):gsub("%.+$","")
if State.Language=="EN" then return t=="Đang rảnh" and "Idle" or t end
if t:lower()=="idle" or t=="Đang rảnh" then return "Đang rảnh" end
local ck="ST|" .. t
if FastCache[ck] then return FastCache[ck] end
if EXACT_VI[t] or LOWER_VI[t:lower()] then
local r=EXACT_VI[t] or LOWER_VI[t:lower()]
FastCache[ck]=r
return r
end
local out=stripArt(t)
for i=1,#GRAMMAR_VI do
if out:find(GRAMMAR_VI[i].pat)then
out=out:gsub(GRAMMAR_VI[i].pat,GRAMMAR_VI[i].rep)
break
end
end
out=applyWords(applyPhrases(out)):gsub("%s+"," "):match("^%s*(.-)%s*$")or out
FastCache[ck]=out
return out
end
translateText=function(raw)
if not raw or raw=="" then return raw end
local ck=State.Language .. "|" .. raw
if FastCache[ck] then return FastCache[ck] end
if raw:find("Venyx SAE",1,true)then
raw=raw:gsub("Venyx SAE","Chilli SAE")
elseif raw=="VENYX" or raw=="Chilli Hub V5" or raw=="Chilli V5 |" then
raw=NEW_TITLE
elseif raw=="Venyx" then
raw="Chilli Hub"
end
if State.Language=="EN" then
local out=raw
local low=raw:lower():match("^%s*(.-)%s*$")
if VI_TO_EN[low] then
out=VI_TO_EN[low]
elseif VI_TO_EN[raw] then
out=VI_TO_EN[raw]
end
FastCache[ck]=out
return out
end
local norm=(raw:match("^%s*(.-)%s*$")or raw):gsub("%s+"," ")
if norm:match("^[%$%+%-%d%.%,%/%%sxhm]+$")or(norm:match("^v%d+%.%d+")and #norm<10)then
FastCache[ck]=raw
return raw
end
if EXACT_VI[norm] or LOWER_VI[norm:lower()] then
local r=EXACT_VI[norm] or LOWER_VI[norm:lower()]
FastCache[ck]=r
return r
end
local dots=norm:match("^(.+)%.%.%.$")
if dots then
dots=dots:match("^%s*(.-)%s*$")or dots
local m=EXACT_VI[dots] or LOWER_VI[dots:lower()]
if m then
FastCache[ck]=m .. "..."
return FastCache[ck]
end
end
local pfx,wp=norm:match("^([^%w%s]+%s*)(.+)$")
if pfx and wp and(EXACT_VI[wp] or LOWER_VI[wp:lower()])then
FastCache[ck]=pfx ..(EXACT_VI[wp] or LOWER_VI[wp:lower()])
return FastCache[ck]
end
for i=1,#DYN_VI do
if norm:find(DYN_VI[i].pat)then
FastCache[ck]=norm:gsub(DYN_VI[i].pat,DYN_VI[i].rep)
return FastCache[ck]
end
end
local res,hit=norm,false
local caps=(norm:upper()==norm and norm:find("%a")~=nil)
for i=1,#GRAMMAR_VI do
if res:find(GRAMMAR_VI[i].pat)then
res=res:gsub(GRAMMAR_VI[i].pat,GRAMMAR_VI[i].rep)
hit=true
break
end
end
local phr=applyPhrases(res)
if hit or phr~=res or res:find("%s")then
local fin=applyWords(phr):gsub("Venyx","Chilli Hub"):gsub("%s+"," "):match("^%s*(.-)%s*$")or res
if caps and fin~=norm then fin=fin:upper()end
FastCache[ck]=fin
return fin
end
FastCache[ck]=raw
return raw
end
stripRichTags=function(s)
if type(s)~="string" then return "" end
return(s:gsub("<[^>]+>",""):match("^%s*(.-)%s*$")or "")
end
applyTrans=function(inst)
if not(inst:IsA("TextLabel")or inst:IsA("TextButton")or inst:IsA("TextBox"))then return end
if inst:GetAttribute("__IslandDone")or inst:GetAttribute("__FpsHookSession")or inst:GetAttribute("__HiddenVxLogo")
or inst.Name=="IslandExpandHint" or inst.Name=="ChilliUltraTitleBadge" or inst.Name=="ChilliIslandTitle" or inst.Name=="BadgeTxt" or inst.Name=="ChilliTabCaption" or inst.Name=="ChilliTabCaptionEn" or inst.Name=="ChilliFakeFpsOverlay" or inst.Name=="NeonFpsText"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland")or inst:FindFirstAncestor("ChilliHeaderOverlay")or inst:FindFirstAncestor("ChilliSenaBottomBar")
or inst:GetAttribute("__IsTranslating")then return end
if inst:IsA("TextBox")then
local phL=(inst.PlaceholderText or ""):lower()
local txL=(inst.Text or ""):lower()
if phL:find("password",1,true)or phL:find("user",1,true)or txL=="hihi" then
local curr=inst.Parent
for _=1,4 do
if not curr or curr:IsA("ScreenGui")or curr==State.ActiveFinderWin then break end
if curr:IsA("GuiObject")and curr.AbsoluteSize.Y<=260 then
curr.Visible=false
curr.Position=u2(2,0,2,0)
hookLoginFrameTrigger(curr)
break
end
curr=curr.Parent
end
end
local ph=inst:GetAttribute("OrigPlaceholder")or inst:GetAttribute("OrigPh")
if not ph and inst.PlaceholderText~="" and not hasVi(inst.PlaceholderText)then
ph=inst.PlaceholderText
inst:SetAttribute("OrigPlaceholder",ph)
inst:SetAttribute("OrigPh",ph)
end
if ph then inst.PlaceholderText=translateText(ph)end
if not inst:IsFocused()then
local bt=inst.Text
if bt=="Off" or bt=="Tắt" or bt=="None" or bt=="Không có" then
local ob=inst:GetAttribute("OrigBoxText")or((bt=="Tắt")and "Off" or((bt=="Không có")and "None" or bt))
inst:SetAttribute("OrigBoxText",ob)
local mb=translateText(ob)
if inst.Text~=mb then
inst:SetAttribute("__IsTranslating",true)
pcall(function()inst.Text=mb end)
inst:SetAttribute("__IsTranslating",false)
end
end
end
return
end
local rt=inst.Text
if isFpsTxt(rt)then
hookFps(inst)
return
end
local orig=inst:GetAttribute("OrigRawText")
if not orig or(rt~="" and rt~=inst:GetAttribute("__LastTranslated")and not hasVi(rt))then
orig=rt
inst:SetAttribute("OrigRawText",orig)
end
local rawLow=(orig or ""):lower():match("^%s*(.-)%s*$")
if translateFinderHudState and(rawLow:find("force join",1,true)or rawLow:find("min value",1,true)or rawLow:find("rarity",1,true)or rawLow:find("account",1,true)or rawLow:find("auto off",1,true)or rawLow:find("auto on",1,true))then
local fMap=translateFinderHudState(orig)
if fMap and fMap~=orig then
inst:SetAttribute("__LastTranslated",fMap)
if inst.Text~=fMap then
inst:SetAttribute("__IsTranslating",true)
pcall(function()inst.Text=fMap end)
inst:SetAttribute("__IsTranslating",false)
end
return
end
end
if State.Language=="EN" then
local enText=orig or VI_TO_EN[rt:lower()] or VI_TO_EN[rt] or rt
inst:SetAttribute("__LastTranslated",enText)
if inst.Text~=enText then
inst:SetAttribute("__IsTranslating",true)
pcall(function()inst.Text=enText end)
inst:SetAttribute("__IsTranslating",false)
end
return
end
local mapped=translateText(orig)
inst:SetAttribute("__LastTranslated",mapped)
if inst.Text~=mapped then
inst:SetAttribute("__IsTranslating",true)
pcall(function()inst.Text=mapped end)
inst:SetAttribute("__IsTranslating",false)
end
local checkLow=(orig or ""):lower():match("^%s*(.-)%s*$")
if checkLow=="join" or mapped=="Vào ngay" or rt=="Vào ngay" or rt=="Join" then
if hookChilliFinderJoin then pcall(hookChilliFinderJoin,inst)end
elseif watchFinderTextObj and(checkLow=="chilli finder" or checkLow:find("chillihub.pro",1,true)or checkLow:find("top 5 recent eggs",1,true)or checkLow=="sign in" or checkLow=="sign up")then
pcall(watchFinderTextObj,inst)
end
end
hookTrans=function(inst)
if not(inst:IsA("TextLabel")or inst:IsA("TextButton")or inst:IsA("TextBox"))then return end
if inst.Name=="ChilliFakeFpsOverlay" or inst:GetAttribute("__IslandDone")or inst:GetAttribute("__HiddenVxLogo")or inst.Name=="IslandExpandHint"
or inst.Name=="ChilliUltraTitleBadge" or inst.Name=="ChilliIslandTitle" or inst.Name=="BadgeTxt" or inst.Name=="ChilliTabCaption" or inst.Name=="ChilliTabCaptionEn" or inst.Name=="ChilliFakeFpsOverlay" or inst.Name=="NeonFpsText"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland")or inst:FindFirstAncestor("ChilliHeaderOverlay")or inst:FindFirstAncestor("ChilliSenaBottomBar")then return end
if not inst:IsA("TextBox")and isFpsTxt(inst.Text)then
hookFps(inst)
return
end
applyTrans(inst)
if inst:GetAttribute("__TransHookSession")==SID then return end
inst:SetAttribute("__TransHookSession",SID)
table.insert(State.TrackedTexts,inst)
local inScroll=inst:FindFirstAncestorOfClass("ScrollingFrame")~=nil
if inScroll and inst:IsA("TextLabel")and #inst.Text>16 and not inst.Text:find("%d")then
return
end
inst:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive()or inst:GetAttribute("__IsTranslating")or inst:GetAttribute("__IslandDone")or inst:GetAttribute("__HiddenVxLogo")then return end
local cur=inst.Text
if cur=="" or cur==inst:GetAttribute("__LastTranslated")then return end
if not inst:IsA("TextBox")and isFpsTxt(cur)then
hookFps(inst)
return
end
if cur:match("^[%$%+%-%d%.%,%/%%sxhm%s:]+$")then return end
if inst:IsA("TextBox")then
applyTrans(inst)
return
end
if not hasVi(cur)then
inst:SetAttribute("OrigRawText",cur)
applyTrans(inst)
end
end)
end
refreshAllTexts=function()
if not isAlive()then return end
table.clear(FastCache)
for i=#State.TrackedTexts,1,-1 do
local el=State.TrackedTexts[i]
if el and el.Parent then
pcall(applyTrans,el)
pcall(watchFinderHudButton,el)
else
table.remove(State.TrackedTexts,i)
end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback)end
if State.RefreshSidebarTabsCallback then pcall(State.RefreshSidebarTabsCallback)end
if State.ActiveFinderWin and State.ActiveFinderWin.Parent then
pcall(scanChilliFinderButtons)
end
end
end
local function fireBtn(btn)
if not btn or not btn.Parent then return false end
local fired=false
local clickable=(btn:IsA("TextButton")or btn:IsA("ImageButton"))and btn
or btn:FindFirstAncestorWhichIsA("TextButton")or btn:FindFirstAncestorWhichIsA("ImageButton")
or(btn.Parent and(btn.Parent:FindFirstChildWhichIsA("TextButton")or btn.Parent:FindFirstChildWhichIsA("ImageButton")))
or btn
local targets={}
local seenT={}
local inScroll=btn:FindFirstAncestorOfClass("ScrollingFrame")~=nil
local candidateList=inScroll and{clickable,btn,btn.Parent}or{clickable,btn,btn.Parent,btn.Parent and btn.Parent.Parent}
for _,tObj in ipairs(candidateList)do
if tObj and tObj:IsA("GuiObject")and not seenT[tObj] then
if not inScroll or(tObj.AbsoluteSize.X<=175 and tObj.AbsoluteSize.Y<=52)then
seenT[tObj]=true
table.insert(targets,tObj)
end
end
end
for _,targetObj in ipairs(targets)do
local cx=math.floor(targetObj.AbsolutePosition.X+targetObj.AbsoluteSize.X*0.5)
local cy=math.floor(targetObj.AbsolutePosition.Y+targetObj.AbsoluteSize.Y*0.5)
local pos3=Vector3.new(cx,cy,0)
if getconnections then
for _,sigName in ipairs({"MouseButton1Click","Activated","MouseButton1Down","MouseButton1Up"})do
pcall(function()
local sig=targetObj[sigName]
if sig then
for _,conn in ipairs(getconnections(sig))do
if conn.Function then
task.spawn(conn.Function)
fired=true
elseif conn.Fire then
pcall(conn.Fire,conn)
fired=true
end
end
end
end)
end
if not fired and not IS_ARCEUS then
pcall(function()
for _,uType in ipairs({EUIT.MouseButton1,EUIT.Touch})do
local changedCbs={}
local fakeSig={
Connect=function(_,fn)
if type(fn)=="function" then table.insert(changedCbs,fn)end
return{Connected=true,Disconnect=function(s)s.Connected=false end}
end,
Once=function(_,fn)
if type(fn)=="function" then table.insert(changedCbs,fn)end
return{Connected=true,Disconnect=function(s)s.Connected=false end}
end,
Wait=function()return "UserInputState" end
}
local fakeInput={
UserInputType=uType,
UserInputState=Enum.UserInputState.Begin,
Position=pos3,
Delta=Vector3.zero,
KeyCode=Enum.KeyCode.Unknown,
Changed=fakeSig,
GetPropertyChangedSignal=function()return fakeSig end,
IsA=function(_,cls)return cls=="InputObject" end
}
for _,conn in ipairs(getconnections(targetObj.InputBegan))do
if conn.Function then
pcall(conn.Function,fakeInput,false)
fired=true
elseif conn.Fire then
pcall(conn.Fire,conn,fakeInput,false)
fired=true
end
end
fakeInput.UserInputState=Enum.UserInputState.End
for _,cb in ipairs(changedCbs)do
pcall(cb,"UserInputState")
end
for _,conn in ipairs(getconnections(targetObj.InputEnded))do
if conn.Function then
pcall(conn.Function,fakeInput,false)
fired=true
elseif conn.Fire then
pcall(conn.Fire,conn,fakeInput,false)
fired=true
end
end
end
end)
end
end
if firesignal and(targetObj:IsA("TextButton")or targetObj:IsA("ImageButton"))then
pcall(function()
firesignal(targetObj.MouseButton1Click)
fired=true
end)
pcall(function()
firesignal(targetObj.Activated)
fired=true
end)
end
end
return fired
end
local function isControlVisibleOnTab(el,rootGui)
if not(el and el.Parent)then return false end
local curr=el
while curr and curr~=rootGui and not curr:IsA("ScreenGui")do
if curr:IsA("GuiObject")and not curr.Visible then return false end
curr=curr.Parent
end
return el.AbsoluteSize.X>8 and el.AbsoluteSize.Y>6
end
local function findSystemTabBtn(gui)
if State.SystemTabBtn and State.SystemTabBtn.Parent and State.SystemTabBtn:IsDescendantOf(gui)then
return State.SystemTabBtn
end
for _,d in ipairs(gui:GetDescendants())do
if d:IsA("GuiObject")and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")and not d:FindFirstAncestorOfClass("ScrollingFrame")then
local children={}
for _,ch in ipairs(d:GetChildren())do
if ch:IsA("GuiObject")and ch.AbsoluteSize.X>=18 and ch.AbsoluteSize.X<=70 and ch.AbsoluteSize.Y>=18 and ch.AbsoluteSize.Y<=70 then
table.insert(children,ch)
end
end
if #children>=5 and #children<=8 then
table.sort(children,function(a,b)return a.AbsolutePosition.Y<b.AbsolutePosition.Y end)
State.SystemTabBtn=children[6] or children[#children]
return State.SystemTabBtn
end
end
end
return State.SystemTabBtn
end
local function findImportBoxAndButtons(venyxGui,requireVisible)
local box=nil
local btnList={}
for _,d in ipairs(venyxGui:GetDescendants())do
if d:IsA("TextBox")and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")and not d:FindFirstAncestor("ChilliHeaderOverlay")then
local ph=(d:GetAttribute("OrigPlaceholder")or d:GetAttribute("OrigPh")or d.PlaceholderText or ""):lower()
if ph:find("paste",1,true)or ph:find("dán",1,true)or ph:find("json",1,true)then
if not ph:find("job id",1,true)and not ph:find("webhook",1,true)and not ph:find("empty",1,true)and not ph:find("trống",1,true)then
if not requireVisible or isControlVisibleOnTab(d,venyxGui)then
box=d
end
end
end
end
end
if box then
local bx,by=box.AbsolutePosition.X,box.AbsolutePosition.Y
local seenBtn={}
for _,d in ipairs(venyxGui:GetDescendants())do
if(d:IsA("TextButton")or d:IsA("TextLabel"))and d~=box and not d:IsDescendantOf(box)and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")and not d:FindFirstAncestor("ChilliHeaderOverlay")then
if not requireVisible or isControlVisibleOnTab(d,venyxGui)then
local dx=d.AbsolutePosition.X-bx
local dy=d.AbsolutePosition.Y-by
local ot=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$"):lower()
local ct=(d.Text or ""):match("^%s*(.-)%s*$"):lower()
local isImportLabel=(ot=="import" or ot=="import config" or ct=="nhập" or ct=="nhập cấu hình")
if isImportLabel and(by<=10 or(dx>=-25 and dy>=6 and dy<=98))and not seenBtn[d] then
seenBtn[d]=true
table.insert(btnList,d)
end
end
end
end
end
return box,btnList
end
local function highlightTargetButton(btnObj)
if not btnObj then return end
pcall(function()
local pill=(btnObj.Parent and btnObj.Parent:IsA("GuiObject")and btnObj.Parent.AbsoluteSize.X<=170 and btnObj.Parent.AbsoluteSize.Y<=48)and btnObj.Parent or btnObj
local oldHl=pill:FindFirstChild("ChilliImportHighlightStroke")
if oldHl then oldHl:Destroy()end
local hl=mk("UIStroke",{
Name="ChilliImportHighlightStroke",
Thickness=2.6,
Color=c3(80,255,160),
ApplyStrokeMode=EASM.Border,
Transparency=0
},pill)
addGrad(mk("UIGradient",{Color=RAINBOW},hl))
task.delay(6,function()
if hl and hl.Parent then hl:Destroy()end
end)
end)
end
local function setChilliChildrenVisible(venyxGui,showChilli)
if not venyxGui or not venyxGui.Parent then return end
pcall(function()venyxGui.Enabled=true end)
local pill=State.ActiveStatusLbl and State.ActiveStatusLbl.Parent
local exp=venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
for _,ch in ipairs(venyxGui:GetChildren())do
if ch:IsA("GuiObject")and ch~=pill and ch~=exp and not ch:FindFirstChild("IslandLogoBadge")then
if not showChilli then
if ch.Visible then
ch:SetAttribute("__ChilliSavedVis",true)
pcall(function()ch.Visible=false end)
end
else
if ch:GetAttribute("__ChilliSavedVis")or ch==State.ActiveMainWin then
ch:SetAttribute("__ChilliSavedVis",nil)
pcall(function()ch.Visible=true end)
end
end
end
end
end
local function switchHub(targetHub)
State.ActiveHub="CHILLI"
end
local function runAutoFarmMacro(venyxGui,btnLbl)
if State.MacroBusy then return end
State.MacroBusy=true
task.spawn(function()
local okMacro,_=pcall(function()
if State.ActiveHub~="CHILLI" and State.SwitchHubFn then
pcall(State.SwitchHubFn,"CHILLI")
task.wait(0.10)
end
if State.ActiveVenyxGui and State.ActiveVenyxGui.Parent then
venyxGui=State.ActiveVenyxGui
pcall(function()venyxGui.Enabled=true end)
end
if btnLbl then btnLbl.Text="⏳ ĐANG MỞ MỤC CẤU HÌNH..." end
local expPanel=venyxGui and venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if expPanel and expPanel.Visible then
expPanel.Visible=false
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent and State.ActiveStatusLbl.Parent:IsA("GuiObject")then
State.ActiveStatusLbl.Parent.Visible=true
end
end
State.AllowMenuCloseNow=false
State.IsMenuAuthorizedClosed=false
if State.ActiveMainWin and State.ActiveMainWin.Parent and not State.ActiveMainWin.Visible then
if State.AnimateOpenFn then
pcall(State.AnimateOpenFn)
else
State.ActiveMainWin.Visible=true
end
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
task.wait(0.18)
end
local sysBtn=findSystemTabBtn(venyxGui)
if sysBtn then
fireBtn(sysBtn)
task.wait(0.24)
end
for _,d in ipairs(venyxGui:GetDescendants())do
if(d:IsA("TextButton")or d:IsA("TextLabel"))and not d:FindFirstAncestorOfClass("ScrollingFrame")and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")and not d:FindFirstAncestor("ChilliHeaderOverlay")and not d:FindFirstAncestor("ChilliTabToast")then
local ot=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$")
local ct=(d.Text or ""):match("^%s*(.-)%s*$")
if ot=="Config" or ct=="Cấu Hình" then
fireBtn(d)
end
end
end
task.wait(0.30)
local importBox,importBtns=findImportBoxAndButtons(venyxGui,true)
if not importBox then
importBox,importBtns=findImportBoxAndButtons(venyxGui,false)
end
if not importBox then
if btnLbl then
btnLbl.Text="⚠️ MỞ MỤC CẤU HÌNH TRƯỚC!"
task.wait(2)
btnLbl.Text="⚡ CONFIG SETTING AUTO FARM"
end
return
end
local sf=importBox:FindFirstAncestorOfClass("ScrollingFrame")
if sf then
pcall(function()
sf.CanvasPosition=v2(0,math.max(360,sf.AbsoluteCanvasSize.Y))
end)
task.wait(0.12)
end
local hasHihi2=(State.ImportRunCount or 0)>0
if not hasHihi2 then
for _,d in ipairs(venyxGui:GetDescendants())do
if(d:IsA("TextLabel")or d:IsA("TextButton"))and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")then
local t=(d.Text or ""):lower()
if t:find("hihi 2",1,true)then
hasHihi2=true
break
end
end
end
end
State.ImportRunCount=(State.ImportRunCount or 0)+1
local payloadJson=PRESET_JSON
if hasHihi2 then
local freshName="hihi 2 #" .. tostring(math.random(10,99))
payloadJson=PRESET_JSON:gsub('"name":"hihi 2"','"name":"' .. freshName .. '"',1)
end
if setclipboard then
pcall(setclipboard,payloadJson)
end
importBox:SetAttribute("__IsTranslating",true)
pcall(function()importBox.ClearTextOnFocus=false end)
importBox.Text=""
task.wait(0.05)
importBox.Text=payloadJson
task.wait(0.08)
if getconnections then
pcall(function()
for _,conn in ipairs(getconnections(importBox:GetPropertyChangedSignal("Text")))do
if conn.Function then pcall(conn.Function)elseif conn.Fire then pcall(conn.Fire,conn)end
end
for _,conn in ipairs(getconnections(importBox.Changed))do
if conn.Function then pcall(conn.Function,"Text")elseif conn.Fire then pcall(conn.Fire,conn,"Text")end
end
end)
end
if firesignal then
pcall(function()firesignal(importBox.FocusLost,true)end)
end
if getconnections then
pcall(function()
for _,conn in ipairs(getconnections(importBox.FocusLost))do
if conn.Function then pcall(conn.Function,true)elseif conn.Fire then pcall(conn.Fire,conn,true)end
end
end)
end
importBox:SetAttribute("__IsTranslating",false)
if sf then
pcall(function()
sf.CanvasPosition=v2(0,math.max(360,sf.AbsoluteCanvasSize.Y))
end)
end
task.wait(0.20)
local _,freshBtns=findImportBoxAndButtons(venyxGui,true)
if #freshBtns>0 then importBtns=freshBtns end
for _,bObj in ipairs(importBtns)do
highlightTargetButton(bObj)
fireBtn(bObj)
end
task.wait(0.35)
for pass=1,2 do
for _,d in ipairs(venyxGui:GetDescendants())do
if(d:IsA("TextButton")or d:IsA("TextLabel"))and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")then
local ot=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$")
local cur=(d.Text or ""):match("^%s*(.-)%s*$")
if ot=="Apply now" or cur=="Áp dụng ngay" or ot=="Overwrite" or cur=="Lưu đè" then
if isControlVisibleOnTab(d,venyxGui)then
highlightTargetButton(d)
fireBtn(d)
end
end
end
end
task.wait(0.15)
end
for _,d in ipairs(venyxGui:GetDescendants())do
if(d:IsA("TextButton")or d:IsA("TextLabel"))and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")then
local ot=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$")
local cur=(d.Text or ""):match("^%s*(.-)%s*$")
if ot=="Set active" or cur=="Kích hoạt" then
if isControlVisibleOnTab(d,venyxGui)then
fireBtn(d)
break
end
end
end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback)end
if btnLbl then
btnLbl.Text="✅ ĐÃ DÁN JSON & MỞ NÚT NHẬP!"
task.wait(1.8)
btnLbl.Text="⚡ CONFIG SETTING AUTO FARM"
end
end)
State.MacroBusy=false
end)
end
local playIslandSfx,setupIsland,cleanupStrayLogos,setupCircleLogo,applySenaV7Architecture,setupBubbleToggle
local venyxGuiLocked=nil
do
local ISLAND_SFX_CFG={
open={id="rbxassetid://6895079853",vol=0.75,spd=1.06},
close={id="rbxassetid://6895079853",vol=0.55,spd=0.86},
tap={id="rbxassetid://6026984224",vol=0.70,spd=1.12},
action={id="rbxassetid://4590662766",vol=0.72,spd=1.08}
}
State.CachedIslandSfx=State.CachedIslandSfx or{}
local function getIslandSound(mode)
local key=mode or "tap"
local cfg=ISLAND_SFX_CFG[key] or ISLAND_SFX_CFG.tap
local snd=State.CachedIslandSfx[key]
if not(snd and snd.Parent)then
snd=Instance.new("Sound")
snd.Name="ChilliV8_Sfx_" .. key
snd.SoundId=cfg.id
snd.Volume=cfg.vol
snd.PlaybackSpeed=cfg.spd
snd.Parent=SoundService
State.CachedIslandSfx[key]=snd
end
return snd
end
task.defer(function()
pcall(function()
for k in pairs(ISLAND_SFX_CFG)do getIslandSound(k)end
end)
end)
playIslandSfx=function(mode)
pcall(function()
local snd=getIslandSound(mode)
snd.TimePosition=0
if SoundService.PlayLocalSound then
pcall(function()SoundService:PlayLocalSound(snd)end)
end
pcall(function()snd:Play()end)
end)
end
setupIsland=function(statusLbl,venyxGui)
local pill=statusLbl and statusLbl.Parent
if not(pill and pill:IsA("GuiObject"))then return false end
if isFpsTxt(statusLbl.Text)then return false end
statusLbl:SetAttribute("__IslandDone",true)
State.ActiveStatusLbl=statusLbl
local keptBadge=nil
for _,ch in ipairs(pill:GetChildren())do
if(ch:IsA("UIGradient")and ch.Name~="LiquidGlassSheen")or ch.Name=="IslandClickHitbox" or ch.Name=="ChilliHeaderLogo" or ch.Name=="ChilliCircleDisc" then
pcall(ch.Destroy,ch)
elseif ch.Name=="IslandLogoBadge" then
if not keptBadge then
keptBadge=ch
else
pcall(ch.Destroy,ch)
end
elseif ch:IsA("Frame")or ch:IsA("ImageLabel")or ch:IsA("ImageButton")then
if ch~=statusLbl and ch.Name~="IslandExpandHint" and ch.Name~="LiquidGlassTopSpecular" and ch.Name~="IslandLiveDot" then
ch.Visible=false
end
end
end
pill.BackgroundColor3=Color3.new(1,1,1)
pill.BackgroundTransparency=0
pill.Size=u2(0,0,0,40)
pill.AutomaticSize=Enum.AutomaticSize.X
local pillScale=pill:FindFirstChild("IslandFluidScale")or mk("UIScale",{Name="IslandFluidScale",Scale=1.0},pill)
local MODERN_PILL_GRAD=ColorSequence.new({
csk(0.00,c3(28,38,64)),
csk(0.35,c3(14,19,34)),
csk(0.75,c3(9,12,22)),
csk(1.00,c3(20,30,52))
})
local glassGrad=pill:FindFirstChild("LiquidGlassSheen")or mk("UIGradient",{
Name="LiquidGlassSheen",
Rotation=90,
Color=MODERN_PILL_GRAD,
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0.00,0.04),
NumberSequenceKeypoint.new(0.50,0.08),
NumberSequenceKeypoint.new(1.00,0.04)
})
},pill)
glassGrad.Rotation=90
glassGrad.Color=MODERN_PILL_GRAD
if pill:GetAttribute("__LockedIslandBg")~=SID then
pill:SetAttribute("__LockedIslandBg",SID)
pill:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
if isAlive()and pill.BackgroundColor3~=Color3.new(1,1,1)then
pill.BackgroundColor3=Color3.new(1,1,1)
end
end)
pill:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
if isAlive()and pill.BackgroundTransparency~=0 then
pill.BackgroundTransparency=0
end
end)
pill:GetPropertyChangedSignal("Size"):Connect(function()
if isAlive()and not State.MorphingMiniIsland and pill.Size.Y.Offset<36 then
pill.Size=u2(0,0,0,40)
end
end)
pill:GetPropertyChangedSignal("Position"):Connect(function()
if isAlive()and not State.DraggingIsland and pill.Position.Y.Offset>14 then
pill.Position=State.IslandUserPos or u2(0.5,0,0,6)
end
end)
end
local pillLayout=pill:FindFirstChildOfClass("UIListLayout")
if not pillLayout then
pillLayout=mk("UIListLayout",{
Parent=pill,
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Center,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder
})
else
pillLayout.FillDirection=Enum.FillDirection.Horizontal
pillLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
pillLayout.VerticalAlignment=Enum.VerticalAlignment.Center
pillLayout.Padding=UDim.new(0,8)
end
local pad=pill:FindFirstChildOfClass("UIPadding")or mk("UIPadding",{},pill)
pad.PaddingLeft=UDim.new(0,10)
pad.PaddingRight=UDim.new(0,10)
pad.PaddingTop=UDim.new(0,2)
pad.PaddingBottom=UDim.new(0,2)
local leftBadge=pill:FindFirstChild("IslandLogoBadge")
local lbStroke=nil
if not leftBadge then
leftBadge=mk("Frame",{Name="IslandLogoBadge",LayoutOrder=-10,Size=u2(0,28,0,28),BackgroundColor3=c3(10,14,24),BorderSizePixel=0,ClipsDescendants=true,Active=false,ZIndex=10000},pill)
mk("UICorner",{CornerRadius=UDim.new(1,0)},leftBadge)
local lbImg=mk("ImageLabel",{Name="LogoImg",AnchorPoint=v2(0.5,0.5),Position=u2s(0.5,0.5),Size=u2s(0.92,0.92),BackgroundTransparency=1,Image=LOGO_ID,ScaleType=Enum.ScaleType.Fit,Active=false,ZIndex=10001},leftBadge)
mk("UICorner",{CornerRadius=UDim.new(1,0)},lbImg)
lbStroke=mk("UIStroke",{Thickness=1.4,Color=c3(85,210,255),Transparency=0.1,ApplyStrokeMode=EASM.Border},leftBadge)
else
leftBadge.Size=u2(0,28,0,28)
leftBadge.BackgroundColor3=c3(10,14,24)
leftBadge.Active=false
lbStroke=leftBadge:FindFirstChildOfClass("UIStroke")
local lbImg=leftBadge:FindFirstChildOfClass("ImageLabel")
if lbImg then
lbImg.Image=LOGO_ID
lbImg.Size=u2s(0.92,0.92)
lbImg.ScaleType=Enum.ScaleType.Fit
if not lbStroke then lbStroke=lbImg:FindFirstChildOfClass("UIStroke")end
end
end
local liveDot=pill:FindFirstChild("IslandLiveDot")
if not liveDot then
liveDot=mk("Frame",{Name="IslandLiveDot",LayoutOrder=1,Size=u2(0,7,0,7),BackgroundColor3=c3(65,245,155),BorderSizePixel=0,Active=false,ZIndex=10001},pill)
mk("UICorner",{CornerRadius=UDim.new(1,0)},liveDot)
mk("UIStroke",{Thickness=1.5,Color=c3(65,245,155),Transparency=0.55},liveDot)
else
liveDot.Visible=true
end
local hint=pill:FindFirstChild("IslandExpandHint")
if not hint then
hint=mk("TextButton",{Name="IslandExpandHint",LayoutOrder=99,Size=u2(0,26,0,22),BackgroundColor3=c3(24,34,58),BackgroundTransparency=0.12,BorderSizePixel=0,Text="▾",Font=EF.GothamBlack,TextSize=12,TextColor3=c3(195,235,255),AutoButtonColor=true,Active=true,ZIndex=10000},pill)
else
hint.Size=u2(0,26,0,22)
hint.BackgroundColor3=c3(24,34,58)
hint.BackgroundTransparency=0.12
hint.Text="▾"
hint.Font=EF.GothamBlack
hint.TextSize=12
hint.TextColor3=c3(195,235,255)
end
if not hint:FindFirstChildOfClass("UICorner")then mk("UICorner",{CornerRadius=UDim.new(1,0)},hint)end
local hStroke=hint:FindFirstChildOfClass("UIStroke")or mk("UIStroke",{Thickness=1.1,Color=c3(135,215,255),Transparency=0.28},hint)
hStroke.Color=c3(135,215,255)
hStroke.Transparency=0.28
local expTaskLbl=nil
local function syncStatus(fromSaved)
if statusLbl:GetAttribute("__Updating")then return end
statusLbl:SetAttribute("__Updating",true)
local cur=(statusLbl.Text or ""):gsub("●",""):gsub("•",""):gsub("✨%s*rainbow",""):match("^%s*(.-)%s*$")or ""
local en=statusLbl:GetAttribute("OrigStatusEn")or statusLbl:GetAttribute("OrigRawText")
if not fromSaved and cur~="" and cur~=statusLbl:GetAttribute("__LastTranslatedStatus")and not hasVi(cur)then
en=cur
statusLbl:SetAttribute("OrigStatusEn",en)
end
local out=(translateStatus and translateStatus(en or cur))or cur
if out=="" then out="Đang rảnh" end
statusLbl:SetAttribute("__LastTranslatedStatus",out)
statusLbl.RichText=false
statusLbl.LayoutOrder=2
statusLbl.AutomaticSize=Enum.AutomaticSize.XY
statusLbl.Font=EF.GothamBold
statusLbl.TextSize=13
statusLbl.TextColor3=c3(242,248,255)
statusLbl.TextTransparency=0
statusLbl.Text=out
if expTaskLbl and expTaskLbl.Parent then expTaskLbl.Text="⚡ Trạng thái: " .. out end
statusLbl:SetAttribute("__Updating",false)
end
State.RefreshIslandCallback=function()syncStatus(true)end
syncStatus(false)
if statusLbl:GetAttribute("__LockedStatusColor")~=SID then
statusLbl:SetAttribute("__LockedStatusColor",SID)
statusLbl:GetPropertyChangedSignal("TextColor3"):Connect(function()
if isAlive()and statusLbl.TextColor3~=c3(242,248,255)then
statusLbl.TextColor3=c3(242,248,255)
end
end)
statusLbl:GetPropertyChangedSignal("TextTransparency"):Connect(function()
if isAlive()and statusLbl.TextTransparency~=0 then
statusLbl.TextTransparency=0
end
end)
statusLbl:GetPropertyChangedSignal("Text"):Connect(function()
if isAlive()and not statusLbl:GetAttribute("__Updating")then
syncStatus(false)
end
end)
end
local stStroke=statusLbl:FindFirstChildOfClass("UIStroke")or mk("UIStroke",{Thickness=1.15,Color=c3(8,12,22),Transparency=0.22},statusLbl)
stStroke.Thickness=1.15
stStroke.Color=c3(8,12,22)
stStroke.Transparency=0.22
local tg=statusLbl:FindFirstChild("TextRainbow")
if tg then tg:Destroy()end
local exp=venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if statusLbl:GetAttribute("__IslandSession")==SID and exp and pill.Parent==venyxGui then return true end
statusLbl:SetAttribute("__IslandSession",SID)
for _,r in ipairs(getScanRoots())do
for _,d in ipairs(r:GetDescendants())do
if d.Name=="ChilliV5_ExpandedIsland" then
pcall(d.Destroy,d)
end
end
end
pill.Parent=venyxGui
pill.AnchorPoint=v2(0.5,0)
pill.ZIndex=9999
pill.Active=true
pill.Visible=true
statusLbl.Active=false
hint.Active=true
pill.Position=State.IslandUserPos or u2(0.5,0,0,6)
if not pill:FindFirstChildOfClass("UICorner")then mk("UICorner",{CornerRadius=UDim.new(1,0)},pill)end
local ps=pill:FindFirstChild("IslandStroke")or mk("UIStroke",{Name="IslandStroke",Thickness=1.5,ApplyStrokeMode=EASM.Border,Color=c3(85,205,255),Transparency=0.14},pill)
local oldPsGrad=ps:FindFirstChildOfClass("UIGradient")
if oldPsGrad then oldPsGrad:Destroy()end
ps.Color=c3(85,205,255)
ps.Thickness=1.5
ps.Transparency=0.14
local COLLAPSED_EXP_H=176
local OPEN_NOTE_EXP_H=276
local EXP_W=328
exp=mk("Frame",{
Name="ChilliV5_ExpandedIsland",
AnchorPoint=v2(0.5,0),
Position=pill.Position,
Size=u2(0,EXP_W,0,COLLAPSED_EXP_H),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.04,
BorderSizePixel=0,
Visible=false,
Active=true,
ClipsDescendants=true,
ZIndex=10000
},venyxGui)
local expScale=mk("UIScale",{Name="ExpFluidScale",Scale=1.0},exp)
if pill:GetAttribute("__LockedIslandVis")~=SID then
pill:SetAttribute("__LockedIslandVis",SID)
pill:GetPropertyChangedSignal("Visible"):Connect(function()
if isAlive()and exp and exp.Parent and not exp.Visible and not pill.Visible then
pill.Visible=true
end
end)
end
mk("UICorner",{CornerRadius=UDim.new(0,22)},exp)
mk("UIGradient",{
Name="LiquidGlassPanelGrad",
Rotation=90,
Color=ColorSequence.new({
csk(0.00,c3(30,42,72)),
csk(0.25,c3(15,20,36)),
csk(0.80,c3(9,13,24)),
csk(1.00,c3(20,30,54))
}),
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0.00,0.04),
NumberSequenceKeypoint.new(0.35,0.08),
NumberSequenceKeypoint.new(1.00,0.04)
})
},exp)
local expStroke=mk("UIStroke",{Thickness=1.6,Color=c3(95,205,255),Transparency=0.16,ApplyStrokeMode=EASM.Border},exp)
mk("Frame",{
Name="LiquidGlassTopSpecular",
AnchorPoint=v2(0.5,0),
Position=u2(0.5,0,0,1),
Size=u2(1,-20,0,16),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.84,
BorderSizePixel=0,
Active=false,
ZIndex=10001
},exp)
local expLogo=mk("Frame",{Position=u2(0,12,0,8),Size=u2(0,28,0,28),BackgroundColor3=c3(10,14,24),BorderSizePixel=0,ClipsDescendants=true,Active=false,ZIndex=10002},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},expLogo)
mk("UIStroke",{Thickness=1.3,Color=c3(95,205,255),Transparency=0.15},expLogo)
local expLogoImg=mk("ImageLabel",{AnchorPoint=v2(0.5,0.5),Position=u2s(0.5,0.5),Size=u2s(0.92,0.92),BackgroundTransparency=1,Image=LOGO_ID,ScaleType=Enum.ScaleType.Fit,Active=false,ZIndex=10003},expLogo)
mk("UICorner",{CornerRadius=UDim.new(1,0)},expLogoImg)
local expTitle=mk("TextLabel",{Name="ChilliIslandTitle",Position=u2(0,48,0,7),Size=u2(0,150,0,16),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=12,TextColor3=Color3.new(1,1,1),TextXAlignment=ETX.Left,Text="CHILLI ISLAND V8",Active=false,ZIndex=10003},exp)
mk("UIGradient",{Color=ULTRA_TEXT_GRAD},expTitle)
mk("TextLabel",{Name="ChilliUltraTitleBadge",Position=u2(0,48,0,22),Size=u2(0,160,0,12),BackgroundTransparency=1,Font=EF.GothamBold,TextSize=9,TextColor3=c3(110,245,175),TextXAlignment=ETX.Left,Text="● LIVE CONTROL • ZERO LAG",Active=false,ZIndex=10003},exp)
local colBtn=mk("TextButton",{Size=u2(0,68,0,24),Position=u2(1,-80,0,10),BackgroundColor3=c3(24,34,58),BackgroundTransparency=0.12,BorderSizePixel=0,Text="Thu gọn ▲",Font=EF.GothamBold,TextSize=9.5,TextColor3=c3(205,238,255),ZIndex=10003},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},colBtn)
mk("UIStroke",{Thickness=1,Color=c3(120,200,255),Transparency=0.32},colBtn)
local ISLAND_CYCLE_STATES={
{
text="Đang rảnh",
icon="⚡",
dot=c3(65,245,155),
stroke=c3(75,210,255),
grad=ColorSequence.new({
csk(0.00,c3(55,135,235)),
csk(0.45,c3(22,42,78)),
csk(1.00,c3(14,22,42))
})
},
{
text="Tự động cướp",
icon="🔥",
dot=c3(255,135,55),
stroke=c3(255,120,55),
grad=ColorSequence.new({
csk(0.00,c3(225,78,48)),
csk(0.45,c3(74,24,28)),
csk(1.00,c3(28,12,18))
})
},
{
text="Hoàn thành",
icon="✅",
dot=c3(55,255,145),
stroke=c3(65,245,155),
grad=ColorSequence.new({
csk(0.00,c3(42,195,115)),
csk(0.45,c3(18,58,38)),
csk(1.00,c3(10,26,18))
})
}
}
local curIslandStateIdx=1
local miniIslandAnimToken=0
local taskBox=mk("TextButton",{Name="IslandTaskCycleBtn",Size=u2(1,-24,0,28),Position=u2(0,12,0,42),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.04,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=10001},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},taskBox)
local taskBoxGrad=mk("UIGradient",{
Name="TaskBoxStateGrad",
Rotation=90,
Color=ISLAND_CYCLE_STATES[1].grad
},taskBox)
local taskBoxStroke=mk("UIStroke",{Thickness=1.2,Color=c3(75,210,255),Transparency=0.20,ApplyStrokeMode=EASM.Border},taskBox)
expTaskLbl=mk("TextLabel",{Size=u2(1,-20,1,0),Position=u2(0,10,0,0),BackgroundTransparency=1,Text="⚡ Trạng thái: " ..(statusLbl.Text or "Đang rảnh"),Font=EF.GothamBold,TextSize=10.8,TextColor3=Color3.new(1,1,1),TextXAlignment=ETX.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=10002},taskBox)
mk("TextLabel",{Name="BadgeTxt",AnchorPoint=v2(1,0.5),Position=u2(1,-10,0.5,0),Size=u2(0,68,0,16),BackgroundTransparency=1,Text="Chạm đổi •",Font=EF.GothamBold,TextSize=9.2,TextColor3=c3(195,228,255),TextXAlignment=ETX.Right,ZIndex=10002},taskBox)
local function cycleMiniIslandState()
playIslandSfx("tap")
curIslandStateIdx=(curIslandStateIdx % #ISLAND_CYCLE_STATES)+1
local st=ISLAND_CYCLE_STATES[curIslandStateIdx]
miniIslandAnimToken=miniIslandAnimToken+1
local myToken=miniIslandAnimToken
State.MorphingMiniIsland=true
if expTaskLbl and expTaskLbl.Parent then
expTaskLbl.Text=st.icon .. " Trạng thái: " .. st.text
end
if statusLbl and statusLbl.Parent then
statusLbl:SetAttribute("__Updating",true)
statusLbl.Text=st.text
statusLbl:SetAttribute("__Updating",false)
end
if liveDot and liveDot.Parent then
liveDot.BackgroundColor3=st.dot
end
local fastExpandInfo=twi(0.14,EES.Quart,EED.Out)
if pillScale and pillScale.Parent then
TweenService:Create(pillScale,fastExpandInfo,{Scale=1.06}):Play()
end
if ps and ps.Parent then
TweenService:Create(ps,fastExpandInfo,{Color=st.stroke,Thickness=2.0,Transparency=0.02}):Play()
end
if lbStroke and lbStroke.Parent then
TweenService:Create(lbStroke,fastExpandInfo,{Color=st.stroke,Thickness=1.7}):Play()
end
if taskBoxGrad and taskBoxGrad.Parent then
taskBoxGrad.Color=st.grad
end
if taskBoxStroke and taskBoxStroke.Parent then
TweenService:Create(taskBoxStroke,fastExpandInfo,{Color=st.stroke,Thickness=1.8,Transparency=0.04}):Play()
end
if expStroke and expStroke.Parent then
TweenService:Create(expStroke,fastExpandInfo,{Color=st.stroke,Thickness=1.9,Transparency=0.06}):Play()
end
task.delay(0.22,function()
if not isAlive()or myToken~=miniIslandAnimToken then return end
local fastShrinkInfo=twi(0.16,EES.Back,EED.Out)
if pillScale and pillScale.Parent then
TweenService:Create(pillScale,fastShrinkInfo,{Scale=1.0}):Play()
end
if ps and ps.Parent then
TweenService:Create(ps,fastShrinkInfo,{Color=st.stroke,Thickness=1.5,Transparency=0.14}):Play()
end
if lbStroke and lbStroke.Parent then
TweenService:Create(lbStroke,fastShrinkInfo,{Color=st.stroke,Thickness=1.3}):Play()
end
if taskBoxStroke and taskBoxStroke.Parent then
TweenService:Create(taskBoxStroke,fastShrinkInfo,{Color=st.stroke,Thickness=1.2,Transparency=0.20}):Play()
end
if expStroke and expStroke.Parent then
TweenService:Create(expStroke,fastShrinkInfo,{Color=st.stroke,Thickness=1.6,Transparency=0.16}):Play()
end
task.delay(0.16,function()
if myToken==miniIslandAnimToken then
State.MorphingMiniIsland=false
end
end)
end)
end
taskBox.MouseButton1Click:Connect(cycleMiniIslandState)
local cap=mk("Frame",{Size=u2(1,-24,0,28),Position=u2(0,12,0,74),BackgroundColor3=c3(14,19,32),BackgroundTransparency=0.08,BorderSizePixel=0,ZIndex=10001},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},cap)
mk("UIStroke",{Thickness=1,Color=c3(85,145,225),Transparency=0.45},cap)
local sld=mk("Frame",{Size=u2(0.5,-4,1,-4),Position=(State.Language=="VI" and u2(0,2,0,2)or u2(0.5,2,0,2)),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=10002},cap)
mk("UICorner",{CornerRadius=UDim.new(1,0)},sld)
mk("UIGradient",{
Rotation=90,
Color=ColorSequence.new({
csk(0.00,c3(75,135,245)),
csk(1.00,c3(55,88,215))
})
},sld)
local bVI=mk("TextButton",{Size=u2(0.5,0,1,0),BackgroundTransparency=1,Text="🇻🇳 TIẾNG VIỆT",Font=EF.GothamBold,TextSize=10.2,TextColor3=(State.Language=="VI" and Color3.new(1,1,1)or c3(160,180,210)),ZIndex=10003},cap)
local bEN=mk("TextButton",{Size=u2(0.5,0,1,0),Position=u2(0.5,0,0,0),BackgroundTransparency=1,Text="🌐 ENGLISH",Font=EF.GothamBold,TextSize=10.2,TextColor3=(State.Language=="EN" and Color3.new(1,1,1)or c3(160,180,210)),ZIndex=10003},cap)
local cfgBtn=mk("TextButton",{Name="AutoFarmConfigBtn",Size=u2(1,-24,0,32),Position=u2(0,12,0,106),BackgroundColor3=c3(24,28,46),BackgroundTransparency=0.04,BorderSizePixel=0,Text="⚡ CONFIG SETTING AUTO FARM",Font=EF.GothamBlack,TextSize=10.5,TextColor3=c3(255,232,125),ZIndex=10003},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},cfgBtn)
mk("UIStroke",{Thickness=1.3,Color=c3(245,195,75),Transparency=0.18,ApplyStrokeMode=EASM.Border},cfgBtn)
cfgBtn.MouseButton1Click:Connect(function()playIslandSfx("action")runAutoFarmMacro(venyxGui,cfgBtn)end)
local noteBtn=mk("TextButton",{Name="SettingNoteToggleBtn",Size=u2(1,-24,0,26),Position=u2(0,12,0,142),BackgroundColor3=c3(18,25,42),BackgroundTransparency=0.10,BorderSizePixel=0,Text="",AutoButtonColor=true,ZIndex=10003},exp)
mk("UICorner",{CornerRadius=UDim.new(1,0)},noteBtn)
mk("UIStroke",{Thickness=1,Color=c3(85,145,225),Transparency=0.35,ApplyStrokeMode=EASM.Border},noteBtn)
local noteBadge=mk("Frame",{Name="NoteNewBadge",AnchorPoint=v2(0,0.5),Position=u2(0,6,0.5,0),Size=u2(0,54,0,18),BackgroundColor3=c3(32,22,56),BorderSizePixel=0,Active=false,ZIndex=10004},noteBtn)
mk("UICorner",{CornerRadius=UDim.new(1,0)},noteBadge)
mk("UIStroke",{Thickness=1,Color=c3(245,195,75),ApplyStrokeMode=EASM.Border},noteBadge)
mk("TextLabel",{Name="BadgeTxt",Size=u2s(1,1),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=8.5,TextColor3=c3(255,230,95),Text="👑 MỚI",Active=false,ZIndex=10005},noteBadge)
local noteSmallLbl=mk("TextLabel",{Name="NoteSmallTitle",Size=u2(1,-86,1,0),Position=u2(0,66,0,0),BackgroundTransparency=1,Font=EF.GothamBold,TextSize=9.6,TextColor3=c3(215,235,255),TextXAlignment=ETX.Left,Text="Setting Auto Farm (Bấm xem note)",Active=false,ZIndex=10004},noteBtn)
local noteArrowLbl=mk("TextLabel",{Name="NoteArrow",Size=u2(0,18,1,0),Position=u2(1,-22,0,0),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=10,TextColor3=c3(165,225,255),Text="▼",Active=false,ZIndex=10004},noteBtn)
local noteDrawer=mk("Frame",{Name="SettingNoteDrawer",Size=u2(1,-24,0,94),Position=u2(0,12,0,172),BackgroundColor3=c3(12,16,28),BackgroundTransparency=0.04,BorderSizePixel=0,Visible=false,ClipsDescendants=true,ZIndex=10003},exp)
mk("UICorner",{CornerRadius=UDim.new(0,14)},noteDrawer)
mk("UIStroke",{Thickness=1.1,Color=c3(80,130,205),Transparency=0.28,ApplyStrokeMode=EASM.Border},noteDrawer)
mk("TextLabel",{Size=u2(1,-96,0,18),Position=u2(0,10,0,4),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=9.5,TextColor3=c3(255,225,95),TextXAlignment=ETX.Left,Text="⚡ SETTING AUTO FARM",ZIndex=10004},noteDrawer)
local vipBadge=mk("Frame",{AnchorPoint=v2(1,0),Position=u2(1,-8,0,4),Size=u2(0,82,0,16),BackgroundColor3=c3(20,34,28),BorderSizePixel=0,ZIndex=10004},noteDrawer)
mk("UICorner",{CornerRadius=UDim.new(1,0)},vipBadge)
mk("UIStroke",{Thickness=1,Color=c3(85,255,165),Transparency=0.2},vipBadge)
mk("TextLabel",{Name="BadgeTxt",Size=u2s(1,1),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=8.0,TextColor3=c3(110,255,175),Text="🛡️ VIP 24/7",ZIndex=10005},vipBadge)
local l1=mk("TextLabel",{Size=u2(1,-14,0,18),Position=u2(0,8,0,22),BackgroundTransparency=1,Font=EF.GothamBold,TextSize=8.2,TextScaled=true,TextColor3=c3(235,245,255),TextXAlignment=ETX.Left,Text="+ Tự động săn trứng Secret 1B+ (phù hợp cho tất cả thiết bị, người chơi)",ZIndex=10004},noteDrawer)
mk("UITextSizeConstraint",{MaxTextSize=8.5,MinTextSize=6.5},l1)
mk("TextLabel",{Size=u2(1,-14,0,17),Position=u2(0,8,0,40),BackgroundTransparency=1,Font=EF.GothamBold,TextSize=8.8,TextColor3=c3(220,235,255),TextXAlignment=ETX.Left,Text="+ Tự động làm tất cả nhiệm vụ sự kiện (A-Z)",ZIndex=10004},noteDrawer)
mk("TextLabel",{Size=u2(1,-14,0,17),Position=u2(0,8,0,57),BackgroundTransparency=1,Font=EF.GothamBold,TextSize=8.8,TextColor3=c3(255,230,145),TextXAlignment=ETX.Left,Text="+ Chạy máy chạy bộ và bán pet dưới 1B",ZIndex=10004},noteDrawer)
mk("TextLabel",{Size=u2(1,-14,0,17),Position=u2(0,8,0,74),BackgroundTransparency=1,Font=EF.GothamBlack,TextSize=9.0,TextColor3=c3(95,255,165),TextXAlignment=ETX.Left,Text="+++ Setting treo 24/7 không văng",ZIndex=10004},noteDrawer)
local noteOpen=false
noteBtn.MouseButton1Click:Connect(function()
playIslandSfx("tap")
noteOpen=not noteOpen
if noteOpen then
noteDrawer.Visible=true
noteArrowLbl.Text="▲"
noteSmallLbl.Text="Setting Auto Farm (Bấm thu gọn)"
TweenService:Create(exp,twi(0.18,EES.Quart,EED.Out),{Size=u2(0,EXP_W,0,OPEN_NOTE_EXP_H)}):Play()
else
noteArrowLbl.Text="▼"
noteSmallLbl.Text="Setting Auto Farm (Bấm xem note)"
local nTw=TweenService:Create(exp,twi(0.16,EES.Quart,EED.Out),{Size=u2(0,EXP_W,0,COLLAPSED_EXP_H)})
nTw:Play()
nTw.Completed:Connect(function()
if not noteOpen then noteDrawer.Visible=false end
end)
end
end)
State.AntiAfkEnabled=true
if not State.AntiAfkHooked then
State.AntiAfkHooked=true
pcall(function()
LocalPlayer.Idled:Connect(function()
if State.AntiAfkEnabled then
pcall(function()
local cam=workspace.CurrentCamera
if cam then cam.CFrame=cam.CFrame end
end)
end
end)
end)
end
local function setLang(l)
playIslandSfx("tap")
if State.Language==l then return end
State.Language=l
if writefile then pcall(writefile,LANG_FILE,l)end
TweenService:Create(sld,twi(0.16,EES.Quart,EED.Out),{Position=(l=="VI" and u2(0,2,0,2)or u2(0.5,2,0,2))}):Play()
bVI.TextColor3=l=="VI" and Color3.new(1,1,1)or c3(160,180,210)
bEN.TextColor3=l=="EN" and Color3.new(1,1,1)or c3(160,180,210)
refreshAllTexts()
end
bVI.MouseButton1Click:Connect(function()setLang("VI")end)
bEN.MouseButton1Click:Connect(function()setLang("EN")end)
local open,lastToggleClock=false,-10
local function toggle()
if os.clock()-lastToggleClock<0.14 then return end
lastToggleClock=os.clock()
open=not open
playIslandSfx(open and "open" or "close")
if open then
exp.Position=pill.Position
local targetH=noteOpen and OPEN_NOTE_EXP_H or COLLAPSED_EXP_H
exp.Size=u2(0,220,0,40)
expScale.Scale=0.94
exp.Visible=true
pill.Visible=false
TweenService:Create(expScale,twi(0.20,EES.Back,EED.Out),{Scale=1.0}):Play()
TweenService:Create(exp,twi(0.20,EES.Quart,EED.Out),{Size=u2(0,EXP_W,0,targetH)}):Play()
else
TweenService:Create(expScale,twi(0.14,EES.Quart,EED.In),{Scale=0.94}):Play()
local tw=TweenService:Create(exp,twi(0.14,EES.Quart,EED.In),{Size=u2(0,210,0,38)})
tw:Play()
tw.Completed:Connect(function()
if not open then
exp.Visible=false
pillScale.Scale=0.95
pill.Visible=true
TweenService:Create(pillScale,twi(0.16,EES.Back,EED.Out),{Scale=1.0}):Play()
end
end)
end
end
State.CollapseIslandFn=function()
if open then toggle()end
end
if hint:IsA("GuiButton")then
hint.MouseButton1Click:Connect(toggle)
end
hint.InputBegan:Connect(function(i)
if i.UserInputType==EUIT.MouseButton1 or i.UserInputType==EUIT.Touch then
toggle()
end
end)
colBtn.MouseButton1Click:Connect(toggle)
local lastPillTouchClock=-10
local function onIn(i)
if i.UserInputType==EUIT.MouseButton1 or i.UserInputType==EUIT.Touch then
if os.clock()-lastPillTouchClock<0.08 then return end
lastPillTouchClock=os.clock()
local start=i.Position
local startP=pill.Position
local dragConn,upConn,chgConn=nil,nil,nil
local hasMoved=false
local finished=false
local function finishInput()
if finished then return end
finished=true
if dragConn then dragConn:Disconnect()end
if upConn then upConn:Disconnect()end
if chgConn then chgConn:Disconnect()end
task.delay(0.05,function()State.DraggingIsland=false end)
if not hasMoved and not open then
toggle()
end
end
dragConn=UserInputService.InputChanged:Connect(function(im)
if im.UserInputType==EUIT.MouseMovement or im.UserInputType==EUIT.Touch then
local d=im.Position-start
if math.abs(d.X)>10 or math.abs(d.Y)>10 then
hasMoved=true
State.DraggingIsland=true
local newPos=u2(startP.X.Scale,startP.X.Offset+d.X,startP.Y.Scale,startP.Y.Offset+d.Y)
pill.Position=newPos
State.IslandUserPos=newPos
if exp and exp.Visible then exp.Position=newPos end
end
end
end)
upConn=UserInputService.InputEnded:Connect(function(ie)
if ie.UserInputType==EUIT.MouseButton1 or ie.UserInputType==EUIT.Touch then
finishInput()
end
end)
if i.Changed then
chgConn=i.Changed:Connect(function()
if i.UserInputState==Enum.UserInputState.End or i.UserInputState==Enum.UserInputState.Cancel then
finishInput()
end
end)
end
end
end
pill.InputBegan:Connect(onIn)
statusLbl.InputBegan:Connect(onIn)
if leftBadge then leftBadge.InputBegan:Connect(onIn)end
return true
end
local function killVxLogo(d)
if not d or not d:IsA("GuiObject")then return end
d:SetAttribute("__HiddenVxLogo",true)
d.BackgroundTransparency=1
if d:IsA("TextLabel")or d:IsA("TextButton")then
d.TextTransparency=1
elseif d:IsA("ImageLabel")or d:IsA("ImageButton")then
d.ImageTransparency=1
end
if not d:GetAttribute("__VxKillLock")then
d:SetAttribute("__VxKillLock",true)
d:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
if d.BackgroundTransparency~=1 then d.BackgroundTransparency=1 end
end)
if d:IsA("TextLabel")or d:IsA("TextButton")then
d:GetPropertyChangedSignal("TextTransparency"):Connect(function()
if d.TextTransparency~=1 then d.TextTransparency=1 end
end)
elseif d:IsA("ImageLabel")or d:IsA("ImageButton")then
d:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
if d.ImageTransparency~=1 then d.ImageTransparency=1 end
end)
end
end
end
cleanupStrayLogos=function(gui,win)
if not gui then return end
pcall(function()
if win then
for _,ch in ipairs(win:GetChildren())do
if ch.Name=="ChilliCircleDisc" or ch.Name=="ChilliV5CoverLogo" or ch.Name=="PerfectCircleAspect" or ch.Name=="ChilliHeaderLogoBadge" then
ch:Destroy()
end
end
end
for _,d in ipairs(gui:GetDescendants())do
if d:IsA("TextLabel")or d:IsA("TextButton")then
local t=(d.Text or ""):lower():match("^%s*(.-)%s*$")
if t=="vx" or t=="v" or t=="x" then
killVxLogo(d)
end
end
end
end)
end
setupCircleLogo=function(obj,win)
if not obj or not obj:IsA("GuiObject")or obj==win then return end
if obj.Name=="ChilliV5_ExpandedIsland" or obj:FindFirstChild("IslandExpandHint")or obj:FindFirstChild("IslandLogoBadge")then return end
local isBtn=obj:IsA("GuiButton")or obj:FindFirstChildOfClass("GuiButton")~=nil
local isSmall=(obj.AbsoluteSize.X>0 and obj.AbsoluteSize.X<=135 and obj.AbsoluteSize.Y<=135)or(obj.Size.X.Offset>=20 and obj.Size.X.Offset<=135)
if not isBtn and not isSmall then return end
local top=obj
top:SetAttribute("__SizeLockedV5Pro",true)
top.BackgroundTransparency=1
top.Visible=true
top.Size=u2(0,58,0,58)
if not top:FindFirstChild("PerfectCircleAspect")then
mk("UIAspectRatioConstraint",{Name="PerfectCircleAspect",AspectRatio=1},top)
end
for _,ch in ipairs(top:GetDescendants())do
if ch.Name~="ChilliCircleDisc" and ch.Name~="ChilliV5CoverLogo" and not ch:IsDescendantOf(top:FindFirstChild("ChilliCircleDisc")or top)then
if ch:IsA("TextLabel")or ch:IsA("TextButton")then
killVxLogo(ch)
elseif ch:IsA("ImageLabel")or ch:IsA("ImageButton")then
if ch.Name~="ChilliV5CoverLogo" then ch.ImageTransparency=1 end
end
end
end
local disc=top:FindFirstChild("ChilliCircleDisc")or mk("Frame",{
Name="ChilliCircleDisc",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2s(1,1),
BackgroundColor3=c3(0,0,0),
BorderSizePixel=0,
ClipsDescendants=true,
Active=false,
ZIndex=50
},top)
disc.Visible=true
if not disc:FindFirstChildOfClass("UICorner")then mk("UICorner",{CornerRadius=UDim.new(1,0)},disc)end
local cov=disc:FindFirstChild("ChilliV5CoverLogo")or mk("ImageLabel",{
Name="ChilliV5CoverLogo",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2s(1,1),
BackgroundTransparency=1,
Image=LOGO_ID,
ScaleType=Enum.ScaleType.Crop,
Active=false,
ZIndex=51
},disc)
cov.Visible=true
cov.Image=LOGO_ID
cov.ImageTransparency=0
if not cov:FindFirstChildOfClass("UICorner")then mk("UICorner",{CornerRadius=UDim.new(1,0)},cov)end
local covStroke=cov:FindFirstChild("RainbowBorder")or mk("UIStroke",{
Name="RainbowBorder",
Thickness=2.2,
Color=Color3.new(1,1,1),
ApplyStrokeMode=EASM.Border
},cov)
covStroke.Enabled=true
if not covStroke:FindFirstChildOfClass("UIGradient")then
addGrad(mk("UIGradient",{Color=RAINBOW},covStroke))
end
if not top:GetAttribute("__ChilliInstantToggleHooked")then
top:SetAttribute("__ChilliInstantToggleHooked",true)
local function onToggleTap()
State.CloseHideUntil=nil
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
end
if top:IsA("GuiButton")then
top.MouseButton1Down:Connect(onToggleTap)
end
top.InputBegan:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
onToggleTap()
end
end)
for _,ch in ipairs(top:GetDescendants())do
if ch:IsA("GuiButton")then
ch.MouseButton1Down:Connect(onToggleTap)
end
end
end
end
local PAGE_HEADER_TITLES={
["dashboard"]=true,["home"]=true,["trang chủ"]=true,
["steal"]=true,["săn trứng"]=true,["lấy trứng"]=true,["cướp trứng"]=true,
["farm"]=true,["tự cày"]=true,["tự động cày"]=true,
["events"]=true,["event"]=true,["sự kiện"]=true,
["player"]=true,["localplayer"]=true,["nhân vật"]=true,["người chơi"]=true,
["misc"]=true,["miscellaneous"]=true,["chức năng khác"]=true,["khác"]=true,
["settings"]=true,["setting"]=true,["cài đặt"]=true,["hệ thống"]=true,["system"]=true
}
local function isProfileOrPlayerInfo(d)
if not d or not d:IsA("TextLabel")then return false end
local lp=game:GetService("Players").LocalPlayer
local pName=lp and lp.Name or ""
local pDisplay=lp and lp.DisplayName or ""
local t=d.Text or ""
local tLow=t:lower()
if(pName~="" and t:find(pName,1,true))or(pDisplay~="" and t:find(pDisplay,1,true))then
return true
end
if tLow:find("chào mừng")or tLow:find("welcome")or tLow:find("delta")or tLow:find("sae")or tLow:find("chilli")then
return true
end
local par=d.Parent
if par and(par:FindFirstChildOfClass("ImageLabel")or par:FindFirstChildOfClass("ImageButton"))then
return true
end
local gpar=par and par.Parent
if gpar and(gpar:FindFirstChildOfClass("ImageLabel")or gpar:FindFirstChildOfClass("ImageButton"))then
return true
end
return false
end
local SIDEBAR_PALETTE={
c3(37,99,235),
c3(239,68,68),
c3(245,158,11),
c3(168,85,247),
c3(236,72,153),
c3(16,185,129),
}
local SIDEBAR_GRAD_PAIRS={
{c3(37,99,235),c3(56,189,248)},
{c3(239,68,68),c3(251,146,60)},
{c3(245,158,11),c3(253,224,71)},
{c3(168,85,247),c3(217,70,239)},
{c3(236,72,153),c3(251,113,133)},
{c3(16,185,129),c3(45,212,191)},
}
local function playModernTabSound()
pcall(function()
if playIslandSfx then
pcall(playIslandSfx,"tap")
end
local ss=game:GetService("SoundService")
local snd=Instance.new("Sound")
snd.SoundId="rbxassetid://6026984224"
snd.Volume=0.85
snd.PlaybackSpeed=1.15
snd.Parent=ss
if ss.PlayLocalSound then
pcall(function()ss:PlayLocalSound(snd)end)
else
pcall(function()snd:Play()end)
end
game:GetService("Debris"):AddItem(snd,2)
end)
end
local function detectActiveTabIndexFromDom(win,hy,winX)
if not win then return nil end
for _,d in ipairs(win:GetDescendants())do
if d:IsA("TextLabel")and d.Visible and not d.Name:find("^Chilli")and not d:FindFirstAncestorOfClass("ScrollingFrame")then
if(d.TextSize or 14)>=15 and d.AbsolutePosition.Y>hy+8 and d.AbsolutePosition.Y<hy+110 and(d.AbsolutePosition.X-winX)<260 then
local p=d.Parent
local allVis=true
while p and p~=win do
if p:IsA("GuiObject")and not p.Visible then
allVis=false
break
end
p=p.Parent
end
if allVis then
local t=(d.Text or ""):lower()
if t:find("bảng điều khiển",1,true)or t:find("trang chủ",1,true)or t:find("dashboard",1,true)or t:find("home",1,true)then
return 1
elseif t:find("cướp trứng",1,true)or t:find("săn trứng",1,true)or t:find("steal",1,true)then
return 2
elseif t:find("tự động cày",1,true)or t:find("tự cày",1,true)or t:find("cày",1,true)or t:find("farm",1,true)then
return 3
elseif t:find("sự kiện",1,true)or t:find("event",1,true)then
return 4
elseif t:find("người chơi",1,true)or t:find("nhân vật",1,true)or t:find("player",1,true)then
return 5
elseif t:find("cài đặt",1,true)or t:find("hệ thống",1,true)or t:find("setting",1,true)or t:find("system",1,true)then
return 6
end
end
end
end
end
return nil
end
applySenaV7Architecture=function(win,titleLbl)
if not win or not titleLbl then return end
for _,oldL in ipairs(win:GetDescendants())do
local nm=oldL.Name
if nm=="ChilliCosmicHolder"
or nm=="ChilliSenaBottomBar"
or nm=="ChilliHeaderBottomGlow"
or nm=="ChilliSidebarRightGlow"
or nm=="ChilliTabActiveBar"
or nm=="ChilliLuxuryCardStroke"
or nm=="ChilliControlNeonGrad"
or nm=="ChilliTabToast"
or nm=="ChilliTabRipple" then
oldL:Destroy()
elseif nm=="ChilliMainChilliLogo" and oldL.Parent~=win then
oldL:Destroy()
end
end
titleLbl.TextColor3=Color3.new(1,1,1)
titleLbl.Font=EF.GothamBlack
titleLbl.TextTransparency=0
local tGrad=titleLbl:FindFirstChild("TitleUltraGrad")
if not tGrad then
tGrad=mk("UIGradient",{Name="TitleUltraGrad",Color=ULTRA_TEXT_GRAD},titleLbl)
else
tGrad.Color=ULTRA_TEXT_GRAD
end
if not titleLbl:FindFirstChild("TitleUltraStroke")then
mk("UIStroke",{Name="TitleUltraStroke",Thickness=1.2,Color=c3(10,8,20),Transparency=0.25},titleLbl)
end
local hdrBaseZ=math.max(15,(titleLbl.ZIndex or 5)+8)
local mainChilliLogo=win:FindFirstChild("ChilliMainChilliLogo")
if not mainChilliLogo then
mainChilliLogo=mk("Frame",{
Name="ChilliMainChilliLogo",
AnchorPoint=v2(0.5,0.5),
Position=u2(0,23,0,19),
Size=u2(0,27,0,27),
BackgroundColor3=c3(12,15,24),
BackgroundTransparency=0,
BorderSizePixel=0,
ClipsDescendants=true,
Active=false,
ZIndex=hdrBaseZ
},win)
mk("UICorner",{CornerRadius=UDim.new(1,0)},mainChilliLogo)
mk("UIStroke",{
Thickness=1.3,
Color=c3(255,95,75),
Transparency=0.25,
ApplyStrokeMode=EASM.Border
},mainChilliLogo)
mk("ImageLabel",{
Name="LogoImg",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2s(0.90,0.90),
BackgroundTransparency=1,
Image="rbxassetid://74441610995894",
ScaleType=Enum.ScaleType.Fit,
Active=false,
ZIndex=hdrBaseZ+1
},mainChilliLogo)
else
local oldMcStroke=mainChilliLogo:FindFirstChildOfClass("UIStroke")
if oldMcStroke then
local oldMcGrad=oldMcStroke:FindFirstChildOfClass("UIGradient")
if oldMcGrad then oldMcGrad:Destroy()end
oldMcStroke.Color=c3(255,95,75)
oldMcStroke.Thickness=1.3
oldMcStroke.Transparency=0.25
end
mainChilliLogo.AnchorPoint=v2(0.5,0.5)
mainChilliLogo.Position=u2(0,23,0,19)
mainChilliLogo.Size=u2(0,27,0,27)
mainChilliLogo.Visible=true
mainChilliLogo.ZIndex=hdrBaseZ
end
State.MainChilliLogo=mainChilliLogo
local hy,tx=titleLbl.AbsolutePosition.Y,titleLbl.AbsolutePosition.X
local winX,winY=win.AbsolutePosition.X,win.AbsolutePosition.Y
local bgFrames={}
if win.BackgroundTransparency<0.98 then
table.insert(bgFrames,win)
end
for _,d in ipairs(win:GetDescendants())do
if d:IsA("GuiObject")and not d.Name:find("^Chilli")
and d.AbsoluteSize.X>=win.AbsoluteSize.X*0.82
and d.AbsoluteSize.Y>=win.AbsoluteSize.Y*0.82 then
if d.BackgroundTransparency<0.98 then
table.insert(bgFrames,d)
end
for _,st in ipairs(d:GetChildren())do
if st:IsA("UIStroke")and st.Name~="ChilliProWindowStroke" then
st.Transparency=1
st.Enabled=false
end
end
end
end
for _,st in ipairs(win:GetChildren())do
if st:IsA("UIStroke")and st.Name~="ChilliProWindowStroke" then
st.Transparency=1
st.Enabled=false
end
end
local mainBg=bgFrames[1] or win
pcall(function()
for _,bf in ipairs(bgFrames)do
bf.BackgroundColor3=c3(9,10,16)
end
win.ClipsDescendants=true
end)
local strokeTarget=mainBg or win
local winStroke=strokeTarget:FindFirstChild("ChilliProWindowStroke")or win:FindFirstChild("ChilliProWindowStroke")
if not winStroke then
winStroke=mk("UIStroke",{
Name="ChilliProWindowStroke",
Thickness=1.4,
ApplyStrokeMode=EASM.Border,
Color=c3(55,72,110),
Transparency=0.20
},strokeTarget)
else
local oldWg=winStroke:FindFirstChildOfClass("UIGradient")
if oldWg then oldWg:Destroy()end
winStroke.Thickness=1.4
winStroke.Color=c3(55,72,110)
winStroke.Transparency=0.20
end
local wpParent=mainBg or win
local wp=wpParent:FindFirstChild("ChilliSenaWallpaper")or win:FindFirstChild("ChilliSenaWallpaper")
if not wp then
wp=mk("ImageLabel",{
Name="ChilliSenaWallpaper",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2s(1,1),
BackgroundTransparency=1,
Image=WALLPAPER_IMAGE_ID,
ImageTransparency=0.36,
ScaleType=Enum.ScaleType.Crop,
Active=false,
ZIndex=math.max(1,wpParent.ZIndex)
},wpParent)
mk("UICorner",{CornerRadius=UDim.new(0,10)},wp)
else
wp.Image=WALLPAPER_IMAGE_ID
end
local sectionCards={}
for _,d in ipairs(win:GetDescendants())do
if d:IsA("ScrollingFrame")and(d.AbsolutePosition.X-winX)>35 and(d.AbsoluteSize.X>=win.AbsoluteSize.X*0.45)then
d.BackgroundTransparency=1
local p=d.Parent
while p and p~=win and p~=mainBg do
if p:IsA("Frame")and p.AbsoluteSize.X>=win.AbsoluteSize.X*0.65 then
p.BackgroundTransparency=1
end
p=p.Parent
end
for _,card in ipairs(d:GetChildren())do
if card:IsA("Frame")and card.AbsoluteSize.X>=120 then
card.BackgroundColor3=c3(13,15,25)
for _,st in ipairs(card:GetChildren())do
if st:IsA("UIStroke")then
if st.Name=="ChilliLuxuryCardStroke" then
st:Destroy()
else
st.Enabled=true
st.Transparency=0.65
end
end
end
table.insert(sectionCards,card)
end
end
end
end
for _,d in ipairs(win:GetDescendants())do
if(d:IsA("TextLabel")or d:IsA("TextButton"))and not d.Name:find("^Chilli")and d~=titleLbl then
local txt=d.Text or ""
local isBigPageTitle=((d.TextSize or 14)>=15 and d.AbsolutePosition.Y>hy+8 and d.AbsolutePosition.Y<hy+105 and(d.AbsolutePosition.X-winX)<260 and not d:FindFirstAncestorOfClass("ScrollingFrame"))
local isSectionHeader=(txt:upper()==txt and #txt>=4 and(d.TextSize or 14)<=13 and d:FindFirstAncestorOfClass("ScrollingFrame")~=nil)
if isBigPageTitle or isSectionHeader then
d.TextColor3=c3(242,246,255)
local ig=d:FindFirstChild("ChilliInnerUltraGrad")
if not ig then
mk("UIGradient",{Name="ChilliInnerUltraGrad",Color=ULTRA_TEXT_GRAD},d)
else
ig.Color=ULTRA_TEXT_GRAD
end
elseif d:FindFirstAncestorOfClass("ScrollingFrame")and d:IsA("TextLabel")then
local c=d.TextColor3
if c.R>0.85 and c.G>0.85 and c.B>0.85 then
d.TextColor3=c3(214,224,242)
end
end
end
end
local function syncWallpaperAndOldBg()
if not wp or not wp.Parent then return end
local curT=0.35
for _,bf in ipairs(bgFrames)do
if bf and bf.Parent and bf.BackgroundTransparency<0.98 then
curT=bf.BackgroundTransparency
break
end
end
wp.ImageTransparency=math.clamp(0.16+curT*0.78,0.16,0.94)
local cardT=math.clamp(0.24+curT*0.58,0.22,0.88)
for _,card in ipairs(sectionCards)do
if card and card.Parent then
card.BackgroundTransparency=cardT
end
end
end
for _,bf in ipairs(bgFrames)do
if not bf:GetAttribute("__WpSyncHooked")then
bf:SetAttribute("__WpSyncHooked",true)
bf:GetPropertyChangedSignal("BackgroundTransparency"):Connect(syncWallpaperAndOldBg)
end
end
syncWallpaperAndOldBg()
local headerBar=nil
local curr=titleLbl
while curr and curr~=win do
if curr:IsA("GuiObject")
and curr.AbsoluteSize.X>=(win.AbsoluteSize.X*0.60)
and curr.AbsoluteSize.Y>=14 and curr.AbsoluteSize.Y<=95
and not curr:FindFirstChildOfClass("UIListLayout")then
headerBar=curr
break
end
curr=curr.Parent
end
for _,it in ipairs(win:GetDescendants())do
if(it:IsA("TextLabel")or it:IsA("TextButton")or it:IsA("ImageLabel")or it:IsA("ImageButton"))
and it~=titleLbl
and not it.Name:find("^Chilli")
and not it:IsDescendantOf(mainChilliLogo)
and not it:FindFirstAncestorOfClass("ScrollingFrame")then
local p,s=it.AbsolutePosition,it.AbsoluteSize
if s.X>0 and s.X<=42 and s.Y>0 and s.Y<=36
and(p.X-winX)>=-2 and(p.X+s.X-winX)<=46
and(p.Y-winY)>=-2 and(p.Y+s.Y-winY)<=38 then
if it:IsA("TextLabel")or it:IsA("TextButton")then
it.TextTransparency=1
it.Text=""
elseif it:IsA("ImageLabel")or it:IsA("ImageButton")then
it.ImageTransparency=1
end
end
end
end
for _,sc in ipairs(win:GetDescendants())do
if sc:IsA("ScrollingFrame")and(sc.AbsolutePosition.X-winX)>65 and sc.AbsoluteSize.X>=win.AbsoluteSize.X*0.45 then
for _,sub in ipairs(sc:GetDescendants())do
if sub.Name=="ChilliSenaSquircle" or sub.Name=="ChilliStealTabIcon" or sub.Name=="ChilliSidebarNeonLine" or sub.Name=="ChilliTabRipple" then
local par=sub.Parent
sub:Destroy()
if par and par:IsA("GuiObject")then
par.BackgroundTransparency=0.15
end
end
end
end
end
if win.AbsoluteSize.X>=200 and win.AbsoluteSize.Y>=140 then
State.SavedFullWinSize=win.Size
end
local function syncWindowVisibilityInstant()
if not win or not win.Parent or State.IsBubbleAnimating then return end
if win.Visible and win.AbsoluteSize.X>=200 and win.AbsoluteSize.Y>=140 then
State.SavedFullWinSize=win.Size
end
local isOffscreen=(win.AbsolutePosition.X<-500 or win.AbsolutePosition.Y<-500)
local isSizeZero=(win.AbsoluteSize.X>0 and(win.AbsoluteSize.X<95 or win.AbsoluteSize.Y<75))
local isHdrHidden=(headerBar~=nil)and(not headerBar.Visible)
local isForceClosing=(State.CloseHideUntil~=nil)and(os.clock()<State.CloseHideUntil)
local isRealBgHidden=(mainBg~=win)and(mainBg.BackgroundTransparency>=0.99)
if win.Visible and(isSizeZero or isHdrHidden or isRealBgHidden)then
win.Visible=false
if State.SyncBubbleIconFn then pcall(State.SyncBubbleIconFn,false,true)end
end
local isClosed=(not win.Visible)or isOffscreen or isSizeZero or isHdrHidden or isForceClosing or isRealBgHidden
local isOpen=not isClosed
if winStroke then
winStroke.Enabled=isOpen
winStroke.Transparency=isOpen and 0.20 or 1
end
if wp then wp.Visible=isOpen end
if mainChilliLogo then mainChilliLogo.Visible=isOpen end
end
State.SyncWindowFn=syncWindowVisibilityInstant
syncWindowVisibilityInstant()
if win:GetAttribute("__InstantHideHooked")~=SID then
win:SetAttribute("__InstantHideHooked",SID)
win:GetPropertyChangedSignal("Visible"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Size"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Position"):Connect(syncWindowVisibilityInstant)
if mainBg and mainBg~=win then
mainBg:GetPropertyChangedSignal("BackgroundTransparency"):Connect(syncWindowVisibilityInstant)
end
end
if win.AbsoluteSize.X>=200 then
for _,d in ipairs(win:GetDescendants())do
if d:IsA("GuiObject")and not d.Name:find("^Chilli")and not d:IsA("TextBox")and not d:FindFirstChildOfClass("TextBox")and not d:FindFirstAncestorOfClass("ScrollingFrame")then
local relX=d.AbsolutePosition.X-win.AbsolutePosition.X
local relY=d.AbsolutePosition.Y-win.AbsolutePosition.Y
if relY>=-2 and relY<36 and relX>(win.AbsoluteSize.X-44)and d.AbsoluteSize.X>0 and d.AbsoluteSize.X<=40 and d.AbsoluteSize.Y>0 and d.AbsoluteSize.Y<=36 then
d.Active=false
d.Visible=false
d.Position=u2(0,-9999,0,-9999)
d.Size=u2(0,0,0,0)
if getconnections and not IS_ARCEUS then
for _,sigName in ipairs({"MouseButton1Click","MouseButton1Down","Activated","InputBegan"})do
pcall(function()
local sig=d[sigName]
if sig then
for _,conn in ipairs(getconnections(sig))do
if conn.Disconnect then pcall(conn.Disconnect,conn)
elseif conn.Disable then pcall(conn.Disable,conn)end
end
end
end)
end
end
end
end
end
end
local navButtons={}
for _,d in ipairs(win:GetDescendants())do
if d:IsA("GuiObject")and not d.Name:find("^Chilli")and(d.AbsolutePosition.X-winX)<75 and d.AbsolutePosition.Y>hy+12 and d.AbsoluteSize.X<=95 then
local children={}
for _,ch in ipairs(d:GetChildren())do
if ch:IsA("GuiObject")and not ch.Name:find("^Chilli")and ch.AbsoluteSize.X>=20 and ch.AbsoluteSize.X<=70 and ch.AbsoluteSize.Y>=20 and ch.AbsoluteSize.Y<=70 then
ch.Visible=true
local oldCardStroke=ch:FindFirstChild("ChilliLuxuryCardStroke")
if oldCardStroke then oldCardStroke:Destroy()end
table.insert(children,ch)
end
end
if #children>=5 and #children<=8 then
table.sort(children,function(a,b)return a.AbsolutePosition.Y<b.AbsolutePosition.Y end)
pcall(function()d.BackgroundTransparency=1 end)
if d.ZIndex<15 then d.ZIndex=15 end
for _,nb in ipairs(children)do
pcall(function()nb.BackgroundTransparency=1 end)
if nb.ZIndex<16 then nb.ZIndex=16 end
end
navButtons=children
break
end
end
end
if #navButtons>=5 then
State.SystemTabBtn=navButtons[6] or navButtons[#navButtons]
State.CurrentNavButtons=navButtons
local detectedTabIdx=detectActiveTabIndexFromDom(win,hy,winX)
if detectedTabIdx then
State.ActiveSidebarTabIdx=detectedTabIdx
elseif not State.ActiveSidebarTabIdx then
State.ActiveSidebarTabIdx=1
end
local fastTabTween=twi(0.14,EES.Quart,EED.Out)
local function updateTabActiveStyles(activeIdx)
State.ActiveSidebarTabIdx=activeIdx
local btns=State.CurrentNavButtons or navButtons
for i,b in ipairs(btns)do
local sq=b and b:FindFirstChild("ChilliSenaSquircle")
if sq then
local st=sq:FindFirstChild("SquircleStroke")or sq:FindFirstChildOfClass("UIStroke")
local shine=sq:FindFirstChild("ChilliTabGlassShine")
local oldBar=sq:FindFirstChild("ChilliTabActiveBar")
if oldBar then oldBar:Destroy()end
if i==activeIdx then
TweenService:Create(sq,fastTabTween,{
Size=u2(0,32,0,32),
BackgroundTransparency=0.06
}):Play()
if st then
st.Color=c3(255,255,255)
st.Thickness=1.4
TweenService:Create(st,fastTabTween,{
Transparency=0.18
}):Play()
end
if shine then
shine.Visible=true
shine.BackgroundTransparency=0.78
end
else
TweenService:Create(sq,fastTabTween,{
Size=u2(0,30,0,30),
BackgroundTransparency=1
}):Play()
if st then
TweenService:Create(st,fastTabTween,{
Transparency=1
}):Play()
end
if shine then
shine.Visible=false
shine.BackgroundTransparency=1
end
end
end
end
end
State.UpdateSidebarTabStyles=updateTabActiveStyles
for idx,btn in ipairs(navButtons)do
btn.Visible=true
pcall(function()btn.BackgroundTransparency=1 end)
if btn:GetAttribute("__BgLockHooked")~=SID then
btn:SetAttribute("__BgLockHooked",SID)
btn:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
if btn.BackgroundTransparency<1 then
btn.BackgroundTransparency=1
end
end)
end
if btn.ZIndex<16 then btn.ZIndex=16 end
local badgeColor=SIDEBAR_PALETTE[((idx-1)% #SIDEBAR_PALETTE)+1]
local gradPair=SIDEBAR_GRAD_PAIRS[((idx-1)% #SIDEBAR_GRAD_PAIRS)+1]
local isInitActive=(idx==(State.ActiveSidebarTabIdx or 1))
local squircle=btn:FindFirstChild("ChilliSenaSquircle")
if not squircle then
squircle=mk("Frame",{
Name="ChilliSenaSquircle",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=isInitActive and u2(0,32,0,32)or u2(0,30,0,30),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=isInitActive and 0.06 or 1,
BorderSizePixel=0,
Active=false,
ZIndex=btn.ZIndex+1
},btn)
mk("UICorner",{CornerRadius=UDim.new(0,8)},squircle)
mk("UIGradient",{
Name="SquircleGrad",
Rotation=45,
Color=ColorSequence.new({
csk(0,gradPair[1]),
csk(1,gradPair[2])
})
},squircle)
mk("UIStroke",{
Name="SquircleStroke",
Thickness=1.4,
Color=c3(255,255,255),
Transparency=isInitActive and 0.18 or 1,
ApplyStrokeMode=EASM.Border
},squircle)
local glassShine=mk("Frame",{
Name="ChilliTabGlassShine",
AnchorPoint=v2(0.5,0),
Position=u2(0.5,0,0,1),
Size=u2(0.86,0,0.42,0),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=isInitActive and 0.78 or 1,
Visible=isInitActive,
BorderSizePixel=0,
Active=false,
ZIndex=squircle.ZIndex+1
},squircle)
mk("UICorner",{CornerRadius=UDim.new(0,7)},glassShine)
else
squircle.Visible=true
squircle.ZIndex=btn.ZIndex+1
local oldBar=squircle:FindFirstChild("ChilliTabActiveBar")
if oldBar then oldBar:Destroy()end
end
for _,ch in ipairs(btn:GetDescendants())do
if ch~=squircle and not ch:IsDescendantOf(squircle)and ch.Name~="ChilliStealTabIcon" then
if ch:IsA("GuiObject")then
ch.ZIndex=squircle.ZIndex+4
end
if ch:IsA("Frame")and ch.AbsoluteSize.X>=20 and ch.AbsoluteSize.Y>=20 then
ch.BackgroundTransparency=1
elseif ch:IsA("ImageLabel")or ch:IsA("ImageButton")then
ch.Visible=true
ch.ImageColor3=Color3.new(1,1,1)
if idx~=2 then
ch.ImageTransparency=0
end
elseif ch:IsA("TextLabel")or ch:IsA("TextButton")then
ch.Visible=true
ch.TextColor3=Color3.new(1,1,1)
if idx~=2 then
ch.TextTransparency=0
end
end
end
end
if idx==2 then
for _,desc in ipairs(btn:GetDescendants())do
if desc~=squircle and not desc:IsDescendantOf(squircle)and desc.Name~="ChilliStealTabIcon" and not desc:IsA("UICorner")and not desc:IsA("UIStroke")then
if desc:IsA("ImageLabel")or desc:IsA("ImageButton")then
desc.ImageTransparency=1
elseif desc:IsA("TextLabel")or desc:IsA("TextButton")then
desc:SetAttribute("__HiddenVxLogo",true)
desc.TextTransparency=1
elseif desc:IsA("Frame")then
desc.BackgroundTransparency=1
local st=desc:FindFirstChildOfClass("UIStroke")
if st then st.Transparency=1 end
end
end
end
local stealIcon=btn:FindFirstChild("ChilliStealTabIcon")
if not stealIcon then
stealIcon=mk("ImageLabel",{
Name="ChilliStealTabIcon",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2s(0.84,0.84),
BackgroundTransparency=1,
Image=STEAL_TAB_ICON_ID,
ScaleType=Enum.ScaleType.Fit,
Active=false,
Selectable=false,
ZIndex=squircle.ZIndex+5
},btn)
mk("UIAspectRatioConstraint",{AspectRatio=1},stealIcon)
else
stealIcon.Visible=true
stealIcon.Image=STEAL_TAB_ICON_ID
stealIcon.ImageTransparency=0
stealIcon.Size=u2s(0.84,0.84)
stealIcon.ZIndex=squircle.ZIndex+5
end
end
if btn:GetAttribute("__TabEffectHooked")~=SID then
btn:SetAttribute("__TabEffectHooked",SID)
local function triggerThisTab()
local now=os.clock()
if now-(State.LastTabClickTime or 0)<0.08 then return end
State.LastTabClickTime=now
playModernTabSound()
if State.UpdateSidebarTabStyles then
pcall(State.UpdateSidebarTabStyles,idx)
end
end
local hookTargets={btn}
for _,desc in ipairs(btn:GetDescendants())do
if desc:IsA("GuiObject")and not desc.Name:find("^Chilli")then
table.insert(hookTargets,desc)
end
end
for _,hObj in ipairs(hookTargets)do
if hObj:IsA("GuiButton")then
hObj.Activated:Connect(triggerThisTab)
hObj.MouseButton1Click:Connect(triggerThisTab)
hObj.MouseButton1Down:Connect(triggerThisTab)
end
end
end
end
if win:GetAttribute("__SidebarGlobalInputHooked")~=SID then
win:SetAttribute("__SidebarGlobalInputHooked",SID)
if env.__ChilliSidebarInputConn then
pcall(function()env.__ChilliSidebarInputConn:Disconnect()end)
end
env.__ChilliSidebarInputConn=UserInputService.InputBegan:Connect(function(inp)
if not isAlive()or not win or not win.Parent or not win.Visible then return end
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
local pos=inp.Position
local btns=State.CurrentNavButtons
if btns then
for idx,b in ipairs(btns)do
if b and b.Parent and b.Visible then
local bp,bs=b.AbsolutePosition,b.AbsoluteSize
if pos.X>=bp.X-4 and pos.X<=bp.X+bs.X+4 and pos.Y>=bp.Y-3 and pos.Y<=bp.Y+bs.Y+3 then
local now=os.clock()
if now-(State.LastTabClickTime or 0)>=0.08 then
State.LastTabClickTime=now
playModernTabSound()
if State.UpdateSidebarTabStyles then
pcall(State.UpdateSidebarTabStyles,idx)
end
end
break
end
end
end
end
end
end)
end
pcall(updateTabActiveStyles,State.ActiveSidebarTabIdx or 1)
end
win:SetAttribute("__SenaArchApplied",SID)
end
setupBubbleToggle=function(gui,win,titleLbl)
if not gui or not win then return end
if win:GetAttribute("__ChilliBubbleHooked")==SID then return end
win:SetAttribute("__ChilliBubbleHooked",SID)
if env.__ChilliBubbleHeartbeatConn then
pcall(function()env.__ChilliBubbleHeartbeatConn:Disconnect()end)
env.__ChilliBubbleHeartbeatConn=nil
end
local TweenSvc=game:GetService("TweenService")
local UserInputSvc=game:GetService("UserInputService")
State.IsBubbleAnimating=false
local function hideNativeVxToggleOnly(ch)
if not ch or not ch:IsA("GuiObject")or ch==win or ch.Name=="ChilliV5_ExpandedIsland" or ch:FindFirstChild("IslandExpandHint")or ch.Name=="ChilliCrystalBubble" then
return
end
local isVxToggle=false
if ch.AbsoluteSize.X>0 and ch.AbsoluteSize.X<=75 and ch.AbsoluteSize.Y>0 and ch.AbsoluteSize.Y<=75 then
for _,d in ipairs(ch:GetDescendants())do
if d:IsA("TextLabel")or d:IsA("TextButton")then
local t=(d.Text or ""):lower():match("^%s*(.-)%s*$")
if t=="vx" or t=="v" or t=="" then
isVxToggle=true
break
end
end
end
end
if isVxToggle then
ch.BackgroundTransparency=1
for _,sub in ipairs(ch:GetDescendants())do
if sub:IsA("TextLabel")or sub:IsA("TextButton")then
sub.TextTransparency=1
sub.BackgroundTransparency=1
elseif sub:IsA("ImageLabel")or sub:IsA("ImageButton")then
sub.ImageTransparency=1
sub.BackgroundTransparency=1
elseif sub:IsA("Frame")then
sub.BackgroundTransparency=1
elseif sub:IsA("UIStroke")then
sub.Transparency=1
end
end
end
end
for _,ch in ipairs(gui:GetChildren())do
pcall(hideNativeVxToggleOnly,ch)
end
if gui:GetAttribute("__ChilliChildAddedHooked")~=SID then
gui:SetAttribute("__ChilliChildAddedHooked",SID)
gui.ChildAdded:Connect(function(ch)
task.defer(function()
pcall(hideNativeVxToggleOnly,ch)
end)
end)
end
local bubble=gui:FindFirstChild("ChilliCrystalBubble")
if not bubble then
bubble=Instance.new("ImageButton")
bubble.Name="ChilliCrystalBubble"
bubble.AnchorPoint=v2(0.5,0.5)
bubble.Position=u2(0,36,0.5,-20)
bubble.Size=u2(0,56,0,56)
bubble.BackgroundColor3=c3(15,18,30)
bubble.BackgroundTransparency=1
bubble.ImageTransparency=1
bubble.AutoButtonColor=false
bubble.BorderSizePixel=0
bubble.ZIndex=99999
bubble.Visible=true
bubble.Parent=gui
local container=Instance.new("Frame")
container.Name="ChilliBubbleContainer"
container.AnchorPoint=v2(0.5,0.5)
container.Position=u2s(0.5,0.5)
container.Size=u2s(1,1)
container.BackgroundColor3=c3(12,15,26)
container.BackgroundTransparency=0.04
container.BorderSizePixel=0
container.ClipsDescendants=true
container.Active=false
container.ZIndex=bubble.ZIndex+1
container.Parent=bubble
local bCorner=Instance.new("UICorner")
bCorner.CornerRadius=UDim.new(1,0)
bCorner.Parent=container
local bStroke=Instance.new("UIStroke")
bStroke.Name="BubbleStroke"
bStroke.Thickness=2.0
bStroke.Color=c3(110,215,255)
bStroke.Transparency=0.15
bStroke.ApplyStrokeMode=EASM.Border
bStroke.Parent=container
local pepperLogo=Instance.new("ImageLabel")
pepperLogo.Name="OriginPepperLogo"
pepperLogo.AnchorPoint=v2(0.5,0.5)
pepperLogo.Position=u2s(0.5,0.5)
pepperLogo.Size=u2s(0.92,0.92)
pepperLogo.BackgroundTransparency=1
pepperLogo.Image="rbxassetid://74441610995894"
pepperLogo.ScaleType=Enum.ScaleType.Fit
pepperLogo.Active=false
pepperLogo.ZIndex=container.ZIndex+2
pepperLogo.Parent=container
local pCorner=Instance.new("UICorner")
pCorner.CornerRadius=UDim.new(1,0)
pCorner.Parent=pepperLogo
local bubbleFrontDisc=Instance.new("Frame")
bubbleFrontDisc.Name="BubbleFrontDisc"
bubbleFrontDisc.AnchorPoint=v2(0.5,0.5)
bubbleFrontDisc.Position=u2s(0.5,0.5)
bubbleFrontDisc.Size=u2s(1,1)
bubbleFrontDisc.BackgroundColor3=c3(14,17,29)
bubbleFrontDisc.BackgroundTransparency=0
bubbleFrontDisc.BorderSizePixel=0
bubbleFrontDisc.ClipsDescendants=true
bubbleFrontDisc.Active=false
bubbleFrontDisc.ZIndex=container.ZIndex+4
bubbleFrontDisc.Parent=container
local bfCorner=Instance.new("UICorner")
bfCorner.CornerRadius=UDim.new(1,0)
bfCorner.Parent=bubbleFrontDisc
local shimmerImg=Instance.new("ImageLabel")
shimmerImg.Name="ShimmerGlow"
shimmerImg.AnchorPoint=v2(0.5,0.5)
shimmerImg.Position=u2s(0.5,0.5)
shimmerImg.Size=u2s(1.15,1.15)
shimmerImg.BackgroundTransparency=1
shimmerImg.Image="rbxassetid://4965945816"
shimmerImg.ImageColor3=c3(160,220,255)
shimmerImg.ImageTransparency=0.25
shimmerImg.Active=false
shimmerImg.ZIndex=bubbleFrontDisc.ZIndex+1
shimmerImg.Parent=bubbleFrontDisc
local centerLogo=Instance.new("ImageLabel")
centerLogo.Name="BubbleLogo"
centerLogo.AnchorPoint=v2(0.5,0.5)
centerLogo.Position=u2s(0.5,0.5)
centerLogo.Size=u2s(0.84,0.84)
centerLogo.BackgroundTransparency=1
centerLogo.Image="rbxassetid://91322208361913"
centerLogo.ScaleType=Enum.ScaleType.Fit
centerLogo.Active=false
centerLogo.ZIndex=bubbleFrontDisc.ZIndex+2
centerLogo.Parent=bubbleFrontDisc
local lCorner=Instance.new("UICorner")
lCorner.CornerRadius=UDim.new(1,0)
lCorner.Parent=centerLogo
end
local container=bubble:FindFirstChild("ChilliBubbleContainer")
if container then
local bSt=container:FindFirstChild("BubbleStroke")
if bSt then
local oldG=bSt:FindFirstChildOfClass("UIGradient")
if oldG then oldG:Destroy()end
bSt.Color=c3(110,215,255)
bSt.Thickness=2.0
bSt.Transparency=0.15
end
end
local bubbleFrontDisc=container and container:FindFirstChild("BubbleFrontDisc")
local shimmerImg=bubbleFrontDisc and bubbleFrontDisc:FindFirstChild("ShimmerGlow")
local centerLogo=bubbleFrontDisc and bubbleFrontDisc:FindFirstChild("BubbleLogo")
local function syncBubbleIconState(isMenuOpen,animated)
bubble.Visible=true
if not bubbleFrontDisc or not centerLogo then return end
if isMenuOpen then
if animated then
TweenSvc:Create(bubble,twi(0.10,EES.Quad,EED.Out),{
Size=u2(0,48,0,48)
}):Play()
task.delay(0.10,function()
TweenSvc:Create(bubble,twi(0.16,EES.Quart,EED.Out),{
Size=u2(0,56,0,56)
}):Play()
end)
local tw=TweenSvc:Create(centerLogo,twi(0.14,EES.Quart,EED.Out),{
ImageTransparency=1
})
TweenSvc:Create(bubbleFrontDisc,twi(0.14,EES.Quart,EED.Out),{
BackgroundTransparency=1
}):Play()
if shimmerImg then
TweenSvc:Create(shimmerImg,twi(0.14,EES.Quart,EED.Out),{
ImageTransparency=1
}):Play()
end
tw:Play()
tw.Completed:Connect(function()
if win and win.Visible then
bubbleFrontDisc.Visible=false
end
end)
else
bubbleFrontDisc.Visible=false
bubbleFrontDisc.BackgroundTransparency=1
centerLogo.ImageTransparency=1
if shimmerImg then shimmerImg.ImageTransparency=1 end
end
else
bubbleFrontDisc.Visible=true
if animated then
TweenSvc:Create(bubble,twi(0.10,EES.Quad,EED.Out),{
Size=u2(0,48,0,48)
}):Play()
task.delay(0.10,function()
TweenSvc:Create(bubble,twi(0.16,EES.Quart,EED.Out),{
Size=u2(0,56,0,56)
}):Play()
end)
TweenSvc:Create(bubbleFrontDisc,twi(0.14,EES.Quart,EED.Out),{
BackgroundTransparency=0
}):Play()
TweenSvc:Create(centerLogo,twi(0.14,EES.Quart,EED.Out),{
ImageTransparency=0
}):Play()
if shimmerImg then
TweenSvc:Create(shimmerImg,twi(0.14,EES.Quart,EED.Out),{
ImageTransparency=0.25
}):Play()
end
else
bubbleFrontDisc.BackgroundTransparency=0
centerLogo.ImageTransparency=0
if shimmerImg then shimmerImg.ImageTransparency=0.25 end
end
end
end
local dragging,dragInput,dragStart,startPos=false,nil,nil,nil
local totalDragDist=0
if not bubble:GetAttribute("__DragHooked")then
bubble:SetAttribute("__DragHooked",true)
bubble.InputBegan:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
dragging=true
dragStart=inp.Position
startPos=bubble.Position
totalDragDist=0
inp.Changed:Connect(function()
if inp.UserInputState==Enum.UserInputState.End then
dragging=false
end
end)
end
end)
bubble.InputChanged:Connect(function(inp)
if inp.UserInputType==EUIT.MouseMovement or inp.UserInputType==EUIT.Touch then
dragInput=inp
end
end)
UserInputSvc.InputChanged:Connect(function(inp)
if inp==dragInput and dragging and dragStart and startPos then
local delta=inp.Position-dragStart
totalDragDist=delta.Magnitude
if totalDragDist>6 then
bubble.Position=u2(
startPos.X.Scale,startPos.X.Offset+delta.X,
startPos.Y.Scale,startPos.Y.Offset+delta.Y
)
end
end
end)
end
local soundFolder=SoundService:FindFirstChild("ChilliBubbleSounds")
if not soundFolder then
soundFolder=Instance.new("Folder")
soundFolder.Name="ChilliBubbleSounds"
soundFolder.Parent=SoundService
end
local function playToggleSound(id,vol,spd)
pcall(function()
local s=soundFolder:FindFirstChild(id)
if not s then
s=Instance.new("Sound")
s.Name=id
s.SoundId=id
s.Parent=soundFolder
end
s.Volume=vol or 0.7
s.PlaybackSpeed=spd or 1.0
s:Play()
end)
end
local winScale=win:FindFirstChild("ChilliZeroLagScale")
if not winScale then
winScale=Instance.new("UIScale")
winScale.Name="ChilliZeroLagScale"
winScale.Scale=1.0
winScale.Parent=win
end
local hy=titleLbl and titleLbl.AbsolutePosition.Y or win.AbsolutePosition.Y
for _,d in ipairs(win:GetDescendants())do
if d:GetAttribute("__CloseSyncHooked")or d:GetAttribute("__ChilliCloseBubbleHooked")then
local dTxt=((d:IsA("TextButton")or d:IsA("TextLabel"))and(d.Text or "")or ""):match("^%s*(.-)%s*$")
if dTxt~="-" and dTxt~="—" then
d:SetAttribute("__CloseSyncHooked",nil)
d:SetAttribute("__ChilliCloseBubbleHooked",nil)
end
end
end
State.SyncBubbleIconFn=syncBubbleIconState
local function openMenuAnimated()
if State.IsBubbleAnimating then return end
State.IsBubbleAnimating=true
playToggleSound("rbxassetid://6895079853",0.75,1.05)
syncBubbleIconState(true,true)
if State.SavedFullWinSize and(win.Size.X.Offset<95 or win.Size.Y.Offset<75 or win.AbsoluteSize.X<95)then
win.Size=State.SavedFullWinSize
end
for _,ch in ipairs(win:GetChildren())do
if ch:IsA("Frame")and ch.Name~="ChilliSenaWallpaper" and ch.Name~="ChilliMainChilliLogo" and not ch.Visible then
ch.Visible=true
end
end
winScale.Scale=0.92
win.Visible=true
State.CloseHideUntil=nil
if win:GetAttribute("__SenaArchApplied")~=SID and titleLbl then
pcall(applySenaV7Architecture,win,titleLbl)
end
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
local openTween=TweenSvc:Create(winScale,twi(0.14,EES.Quart,EED.Out),{
Scale=1.0
})
openTween.Completed:Connect(function()
winScale.Scale=1.0
State.IsBubbleAnimating=false
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
end)
openTween:Play()
end
local function closeMenuAnimated()
if State.MacroBusy then return end
if State.IsBubbleAnimating then return end
if not win.Visible then
syncBubbleIconState(false,true)
return
end
State.IsBubbleAnimating=true
playToggleSound("rbxassetid://6895079853",0.65,1.25)
syncBubbleIconState(false,true)
local closeTween=TweenSvc:Create(winScale,twi(0.12,EES.Quart,EED.In),{
Scale=0.92
})
closeTween.Completed:Connect(function()
win.Visible=false
winScale.Scale=0.92
State.IsBubbleAnimating=false
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
end)
closeTween:Play()
end
State.AnimateOpenFn=openMenuAnimated
State.AnimateCloseFn=closeMenuAnimated
if bubble:GetAttribute("__TapHooked")~=SID then
bubble:SetAttribute("__TapHooked",SID)
local lastTapClock=0
local function handleBubbleTap()
if totalDragDist>12 then return end
local now=os.clock()
if now-lastTapClock<0.20 then return end
lastTapClock=now
if State.IsBubbleAnimating then return end
if win.Visible then
closeMenuAnimated()
else
openMenuAnimated()
end
end
if bubble:IsA("GuiButton")then
bubble.Activated:Connect(handleBubbleTap)
end
bubble.InputEnded:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
handleBubbleTap()
end
end)
end
local customMinusBtn=win:FindFirstChild("ChilliCustomMinusBtn")
if not customMinusBtn then
customMinusBtn=mk("TextButton",{
Name="ChilliCustomMinusBtn",
AnchorPoint=v2(1,0),
Position=u2(1,-7,0,7),
Size=u2(0,24,0,24),
BackgroundColor3=c3(24,28,42),
BackgroundTransparency=0.10,
BorderSizePixel=0,
Text="—",
Font=EF.GothamBlack,
TextSize=12,
TextColor3=c3(210,222,245),
AutoButtonColor=true,
Active=true,
ZIndex=9999
},win)
mk("UICorner",{CornerRadius=UDim.new(0,6)},customMinusBtn)
mk("UIStroke",{Thickness=1,Color=c3(70,90,135),Transparency=0.35},customMinusBtn)
else
customMinusBtn.Visible=true
customMinusBtn.ZIndex=9999
end
if customMinusBtn:GetAttribute("__MinusHooked")~=SID then
customMinusBtn:SetAttribute("__MinusHooked",SID)
local lastMinusClick=0
local function triggerMinusClose()
local now=os.clock()
if now-lastMinusClick<0.28 then return end
lastMinusClick=now
closeMenuAnimated()
end
customMinusBtn.MouseButton1Click:Connect(triggerMinusClose)
customMinusBtn.Activated:Connect(triggerMinusClose)
customMinusBtn.InputBegan:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
triggerMinusClose()
end
end)
end
win:GetPropertyChangedSignal("Visible"):Connect(function()
if not State.IsBubbleAnimating then
syncBubbleIconState(win.Visible,true)
if State.SyncWindowFn then pcall(State.SyncWindowFn)end
end
end)
syncBubbleIconState(win.Visible,false)
end
end
local function patchVenyxGui(gui,titleLbl)
gui:SetAttribute("__IsChilliVenyxGui",true)
pcall(function()gui.Enabled=true end)
pcall(setupSafeTeleportHook)
if titleLbl.Text~=NEW_TITLE then
titleLbl:SetAttribute("__IsTranslating",true)
titleLbl.Text=NEW_TITLE
titleLbl.AutomaticSize=Enum.AutomaticSize.X
titleLbl:SetAttribute("__IsTranslating",false)
end
local win,curr=nil,titleLbl
local cam=workspace.CurrentCamera
local vpX,vpY=(cam and cam.ViewportSize.X)or 1920,(cam and cam.ViewportSize.Y)or 1080
while curr.Parent and curr.Parent~=gui do
curr=curr.Parent
if curr:IsA("GuiObject")then
local aw,ah=curr.AbsoluteSize.X,curr.AbsoluteSize.Y
local sw,sh=curr.Size.X.Offset,curr.Size.Y.Offset
if(aw>=260 and ah>=165)or(aw==0 and sw>=260 and sh>=165)then
if aw<vpX*0.96 or ah<vpY*0.96 then win=curr end
end
end
end
local hy=titleLbl.AbsolutePosition.Y
State.ActiveVenyxGui=gui
if win then
State.ActiveMainWin=win
if gui:GetAttribute("__ChilliV8Patched")~=SID then
if State.SavedFullWinSize and(win.Size.X.Offset<95 or win.Size.Y.Offset<75)then
win.Size=State.SavedFullWinSize
end
win.Visible=true
for _,ch in ipairs(win:GetChildren())do
if ch:IsA("Frame")and ch.Name~="ChilliSenaWallpaper" and ch.Name~="ChilliMainChilliLogo" then
ch.Visible=true
end
end
end
pcall(cleanupStrayLogos,gui,win)
pcall(applySenaV7Architecture,win,titleLbl)
pcall(setupBubbleToggle,gui,win,titleLbl)
end
pcall(function()
for _,ch in ipairs(gui:GetChildren())do
if ch:FindFirstChild("IslandLogoBadge")and ch:FindFirstChildOfClass("TextBox")then
local tb=ch:FindFirstChildOfClass("TextBox")
tb:SetAttribute("__IslandDone",nil)
tb:SetAttribute("__IslandSession",nil)
tb.Text=""
for _,sub in ipairs(ch:GetChildren())do
if sub.Name=="IslandLogoBadge" or sub.Name=="IslandExpandHint" or sub.Name=="IslandStroke" then
sub:Destroy()
end
end
local hdrBar=titleLbl.Parent
if hdrBar and hdrBar:IsA("GuiObject")then
ch.Parent=hdrBar
ch.AnchorPoint=v2(1,0.5)
ch.Position=u2(1,-42,0.5,0)
ch.Size=u2(0,115,0,24)
ch.AutomaticSize=Enum.AutomaticSize.None
end
gui:SetAttribute("__IslandLocked",nil)
end
end
end)
local queue={}
for _,d in ipairs(gui:GetDescendants())do
if d:IsA("TextLabel")or d:IsA("TextButton")or d:IsA("TextBox")then
local txt=d.Text or ""
local hasDot=false
if d:IsA("TextLabel")and d.Parent and d.Parent:IsA("GuiObject")and d.Parent.AbsoluteSize.X<320 and not d.Parent:FindFirstChildOfClass("TextBox")then
for _,sb in ipairs(d.Parent:GetChildren())do
if sb:IsA("Frame")and sb.AbsoluteSize.X<=14 and sb.AbsoluteSize.Y<=14 then
hasDot=true
break
end
end
end
local isStatus=d:IsA("TextLabel")and(not isFpsTxt(txt))and(not gui:GetAttribute("__IslandLocked"))and(not d:FindFirstAncestorOfClass("ScrollingFrame"))and d.Parent and(not d.Parent:FindFirstChildOfClass("TextBox"))and(not titleLbl:IsDescendantOf(d.Parent))and math.abs(d.AbsolutePosition.Y-hy)<38 and d.AbsolutePosition.X>titleLbl.AbsolutePosition.X+50 and(hasDot or txt:lower():find("idle",1,true)or txt:find("Đang rảnh",1,true)or txt:find("Tự động",1,true))and not txt:find("v1.",1,true)
if isFpsTxt(txt)then
pcall(hookFps,d)
elseif isStatus or(d:IsA("TextLabel")and d:GetAttribute("__IslandDone"))then
local okIsl,resIsl=pcall(setupIsland,d,gui)
if okIsl and resIsl then
gui:SetAttribute("__IslandLocked",true)
end
elseif d:GetAttribute("__TransHookSession")~=SID then
queue[#queue+1]=d
end
end
end
if #queue>0 and not gui:GetAttribute("__BatchTranslating")then
gui:SetAttribute("__BatchTranslating",true)
task.spawn(function()
for i=1,#queue do
if not isAlive()then break end
if queue[i] and queue[i].Parent then pcall(hookTrans,queue[i])if watchFinderTextObj then pcall(watchFinderTextObj,queue[i])end end
if i %(IS_ARCEUS and 30 or 60)==0 then task.wait()end
end
gui:SetAttribute("__BatchTranslating",false)
end)
end
return(win~=nil)
end
local FINDER_BORDER_NEON_GRAD=ColorSequence.new({
csk(0.00,c3(255,65,125)),
csk(0.20,c3(255,195,45)),
csk(0.40,c3(55,255,165)),
csk(0.60,c3(45,215,255)),
csk(0.80,c3(195,95,255)),
csk(1.00,c3(255,65,125))
})
local FINDER_STATE_MAP={
["connecting..."]="Đang kết nối...",
["connecting"]="Đang kết nối...",
["reconnecting..."]="Đang kết nối lại...",
["reconnecting"]="Đang kết nối lại...",
["hopping..."]="Đang đổi server...",
["hopping"]="Đang đổi server...",
["new egg!"]="Trứng mới!",
["new egg"]="Trứng mới!",
["server full"]="Server đầy",
["full"]="Đầy",
["error"]="Lỗi",
["retry"]="Thử lại",
["retrying..."]="Đang thử lại...",
["finder"]="Tìm Trứng",
["chilli finder"]="Chilli Finder Free",
["chill finder free"]="Chilli Finder Free",
["chilli finder free"]="Chilli Finder Free",
["open finder"]="Mở Tìm Trứng",
["close finder"]="Đóng Tìm Trứng",
["show finder"]="Hiện Tìm Trứng",
["hide finder"]="Ẩn Tìm Trứng",
["auto off"]="TỰ ĐỘNG: TẮT",
["auto on"]="TỰ ĐỘNG: BẬT",
["auto: off"]="TỰ ĐỘNG: TẮT",
["auto: on"]="TỰ ĐỘNG: BẬT",
["auto join: off"]="TỰ VÀO: TẮT",
["auto join: on"]="TỰ VÀO: BẬT",
["force join"]="TỰ VÀO SAU",
["min value"]="GIÁ TỐI THIỂU",
["rarity"]="ĐỘ HIẾM",
["account"]="TÀI KHOẢN",
["any"]="Tất cả",
["all"]="Tất cả",
["none"]="Không",
["off"]="Tắt",
["on"]="Bật",
["instant"]="Tức thì",
["fast"]="Nhanh",
["normal"]="Thường",
["slow"]="Chậm",
["sign in"]="Miễn phí",
["sign trong"]="Miễn phí",
["sign up"]="Đăng ký",
["log in"]="Miễn phí",
["login"]="Miễn phí",
["no plan"]="Miễn phí",
["free"]="Miễn phí",
["hide"]="Ẩn",
["show"]="Hiện",
["active"]="Đang chạy",
["idle"]="Đang rảnh",
["paused"]="Tạm dừng",
["stopped"]="Đã dừng",
["ready"]="Sẵn sàng",
["cooldown"]="Đang hồi...",
["searching..."]="Đang tìm...",
["searching"]="Đang tìm...",
["scanning..."]="Đang quét...",
["scanning"]="Đang quét...",
["checking..."]="Đang kiểm tra...",
["checking"]="Đang kiểm tra...",
["waiting..."]="Đang chờ...",
["waiting"]="Đang chờ...",
["loading..."]="Đang tải...",
["loading"]="Đang tải...",
["joining..."]="Đang vào...",
["joining"]="Đang vào...",
["teleporting..."]="Đang chuyển...",
["teleporting"]="Đang chuyển...",
["found!"]="Đã thấy!",
["found"]="Đã thấy!",
["egg found!"]="Có trứng mới!",
["egg found"]="Có trứng mới!",
["no eggs"]="Chưa có trứng",
["no egg"]="Chưa có trứng",
["no recent eggs"]="Chưa có trứng",
["common"]="Phổ Thông",
["uncommon"]="Thường",
["rare"]="Hiếm",
["epic"]="Sử Thi",
["legendary"]="Huyền Thoại",
["mythical"]="Thần Thoại",
["mythic"]="Thần Thoại",
["divine"]="Thánh Thần",
["eternal"]="Vĩnh Cửu",
["secret"]="Bí Ẩn",
["cosmic"]="Vũ Trụ",
["celestial"]="Thiên Giới",
["exclusive"]="Độc Quyền",
["limited"]="Giới Hạn",
["golden"]="Vàng",
["gold"]="Vàng",
["silver"]="Bạc",
["rainbow"]="Cầu Vồng",
["diamond"]="Kim Cương",
["shiny"]="Lấp Lánh",
["hexed"]="Tà Thuật",
["cursed"]="Nguyền Rủa",
["blood"]="Huyết",
["void"]="Hư Không",
["galaxy"]="Vũ Trụ",
["lava"]="Dung Nham",
["ice"]="Băng Giá",
["frozen"]="Băng Giá",
["electric"]="Sấm Sét",
["toxic"]="Độc Tố",
["acid"]="Axit",
["join"]="Vào ngay",
["vào ngay"]="Vào ngay"
}
local function getFinderWindowFromObj(obj)
if not obj or not obj.Parent then return nil end
local winFrame=nil
local curr=obj.Parent
for _=1,6 do
if not curr or curr:IsA("ScreenGui")or curr==game then break end
if curr:GetAttribute("__IsChilliFinderContainer")or curr:FindFirstChild("ChillFinderRainbowBorder")then
return curr
end
if curr:IsA("GuiObject")then
if(curr.AbsoluteSize.X>=200 and curr.AbsoluteSize.Y>=180)or(curr.Size.X.Offset>=200 and curr.Size.Y.Offset>=180)then
winFrame=curr
end
end
curr=curr.Parent
end
if not winFrame and obj.Parent and obj.Parent.Parent and obj.Parent.Parent:IsA("GuiObject")and not obj.Parent.Parent:IsA("ScreenGui")then
winFrame=obj.Parent.Parent
end
return winFrame
end
local function styleMasterChillFinderFree(titleObj)
if not titleObj or not titleObj.Parent then return end
pcall(function()
local oldTGrad=titleObj:FindFirstChild("ChillFinderRainbowTxt")
if oldTGrad then oldTGrad:Destroy()end
titleObj.TextColor3=Color3.new(1,1,1)
local hdrFrame=titleObj.Parent
if hdrFrame and hdrFrame:IsA("GuiObject")then
local oldHLine=hdrFrame:FindFirstChild("ChillFinderHeaderNeonLine")
if oldHLine then oldHLine:Destroy()end
end
local winFrame=getFinderWindowFromObj(titleObj)
if winFrame then
winFrame:SetAttribute("__IsChilliFinderContainer",true)
State.ActiveFinderWin=winFrame
local wCorner=winFrame:FindFirstChildOfClass("UICorner")
if not wCorner then
mk("UICorner",{CornerRadius=UDim.new(0,10)},winFrame)
end
for _,st in ipairs(winFrame:GetChildren())do
if st:IsA("UIStroke")and st.Name~="ChillFinderRainbowBorder" then
st.Transparency=1
st.Enabled=false
end
end
local rb=winFrame:FindFirstChild("ChillFinderRainbowBorder")
if not rb then
rb=mk("UIStroke",{
Name="ChillFinderRainbowBorder",
Thickness=2.8,
Color=Color3.new(1,1,1),
ApplyStrokeMode=EASM.Border,
Transparency=0
},winFrame)
local bgGrad=mk("UIGradient",{Name="BorderNeonGrad",Color=FINDER_BORDER_NEON_GRAD},rb)
addGrad(bgGrad)
else
rb.Thickness=2.8
rb.Transparency=0
rb.Enabled=true
end
end
end)
end
local function isInsideChilliFinder(inst)
if not inst or not inst.Parent then return false end
if inst:GetAttribute("__IsFinderHudElement")then return true end
if inst:FindFirstAncestor("ChilliV5_ExpandedIsland")or inst:FindFirstAncestor("ChilliHeaderOverlay")then
return false
end
if State.ActiveFinderWin and State.ActiveFinderWin.Parent and inst:IsDescendantOf(State.ActiveFinderWin)then
return true
end
local sg=inst:FindFirstAncestorOfClass("ScreenGui")
if sg and sg:GetAttribute("__IsChilliFinderGui")and not isVenyxScreenGui(sg)then
return true
end
local curr=inst.Parent
for _=1,5 do
if not curr or curr:IsA("ScreenGui")or curr==game then break end
if curr:GetAttribute("__IsChilliFinderContainer")or curr.Name=="ChillFinderRainbowBorder" or curr.Name=="ChillFinderHeaderNeonLine" or curr:FindFirstChild("ChillFinderRainbowBorder")or curr:FindFirstChild("ChillFinderHeaderNeonLine")then
curr:SetAttribute("__IsChilliFinderContainer",true)
State.ActiveFinderWin=curr
return true
end
for _,ch in ipairs(curr:GetChildren())do
if ch:IsA("TextLabel")or ch:IsA("TextButton")then
local t=stripRichTags(ch.Text)
if(t:find("/s",1,true)or t:find("$",1,true))and(t:find("ago",1,true)or t:find("trước",1,true)or t:find("recent",1,true)or t:find("x",1,true))then
curr:SetAttribute("__IsChilliFinderContainer",true)
return true
elseif t=="Chilli Finder" or t=="Chill Finder Free" or t=="Chilli Finder Free" or t:find("chillihub.pro",1,true)or t:find("Top 5",1,true)or t:find("No active booking",1,true)or t=="FORCE JOIN" or t=="TỰ VÀO SAU" or t=="MIN VALUE" or t=="GIÁ TỐI THIỂU" then
curr:SetAttribute("__IsChilliFinderContainer",true)
return true
end
end
end
curr=curr.Parent
end
return false
end
hookLoginFrameTrigger=function(loginFrame)
if not loginFrame or not loginFrame:IsA("GuiObject")then return end
loginFrame.Visible=false
loginFrame.Position=u2(2,0,2,0)
if loginFrame:GetAttribute("__LockedHideSignIn")==SID then return end
loginFrame:SetAttribute("__LockedHideSignIn",SID)
loginFrame:GetPropertyChangedSignal("Visible"):Connect(function()
if not isAlive()then return end
if loginFrame.Visible then
pcall(function()
loginFrame.Visible=false
loginFrame.Position=u2(2,0,2,0)
end)
end
end)
end
local function hideFinderSignInBox(rootGui)
if os.clock()-(State.LastHideSignInClock or 0)<0.12 then return end
State.LastHideSignInClock=os.clock()
local root=(State.ActiveFinderWin and State.ActiveFinderWin.Parent and State.ActiveFinderWin)or rootGui
if not root then
for _,r in ipairs(getScanRoots())do
for _,d in ipairs(r:GetDescendants())do
if d:IsA("TextLabel")and(d.Text=="Chilli Finder" or d.Text=="Chilli Finder Free" or d.Text=="Top 5 trứng mới nhất | Chilli Finder Free")then
local win=getFinderWindowFromObj(d)
if win then root=win State.ActiveFinderWin=win break end
end
end
if root then break end
end
end
if not root then return end
pcall(function()
for _,d in ipairs(root:GetDescendants())do
if d:IsA("TextBox")then
local ph=(d.PlaceholderText or ""):lower()
local tx=(d.Text or ""):lower()
if ph:find("password",1,true)or ph:find("user",1,true)or tx=="hihi" or isInsideChilliFinder(d)then
local curr=d.Parent
for _=1,4 do
if not curr or curr:IsA("ScreenGui")or curr==State.ActiveFinderWin then break end
if curr:IsA("GuiObject")and curr.AbsoluteSize.Y<=260 then
curr.Visible=false
curr.Position=u2(2,0,2,0)
hookLoginFrameTrigger(curr)
break
end
curr=curr.Parent
end
end
elseif d:IsA("TextLabel")or d:IsA("TextButton")then
local t=stripRichTags(d.Text)
local tl=t:lower()
if t=="Sign Up" or t=="Đăng ký" or t=="Password" or tl:find("sign in with your",1,true)then
local curr=d.Parent
for _=1,4 do
if not curr or curr:IsA("ScreenGui")or curr==State.ActiveFinderWin then break end
if curr:IsA("GuiObject")and curr.AbsoluteSize.Y>=40 and curr.AbsoluteSize.Y<=260 and(curr:FindFirstChildWhichIsA("TextBox",true)or tl:find("sign in with your",1,true))then
curr.Visible=false
curr.Position=u2(2,0,2,0)
hookLoginFrameTrigger(curr)
break
end
curr=curr.Parent
end
elseif t=="Hide" or t=="Ẩn" or tl=="sign trong" or t=="Sign In" or t=="No plan" then
local accP=d.Parent
if accP then
for _,sib in ipairs(accP:GetChildren())do
local sibT=stripRichTags(sib.Text):upper()
if(sib:IsA("TextLabel")or sib:IsA("TextButton"))and(sibT=="ACCOUNT" or sibT=="TÀI KHOẢN")then
if not accP:GetAttribute("__AccBtnTouchHooked")then
accP:SetAttribute("__AccBtnTouchHooked",true)
accP.InputBegan:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
State.LastAccountBtnTouchClock=os.clock()
end
end)
end
if d.Text~="Miễn phí" and d.Text~="Free" then
d:SetAttribute("__IsTranslating",true)
d:SetAttribute("__TranslatingFinderHud",true)
pcall(function()d.Text=(State.Language=="EN")and "Free" or "Miễn phí" end)
d:SetAttribute("__TranslatingFinderHud",false)
d:SetAttribute("__IsTranslating",false)
end
end
end
end
end
end
end
end)
end
local function sanitizeChillFinderFreeObj(d)
if not d or not d.Parent then return end
if not(d:IsA("TextLabel")or d:IsA("TextButton"))then return end
if d:GetAttribute("__ModifyingFinderText")then return end
local raw=stripRichTags(d.Text)
if raw=="" then return end
local low=raw:lower()
if raw=="Chilli Finder" or raw=="Chill Finder Free" or raw=="Chilli Finder Free" or raw=="⚡ Chill Finder Free" then
d:SetAttribute("__ModifyingFinderText",true)
d:SetAttribute("__IsTranslating",true)
d:SetAttribute("OrigRawText","Chilli Finder Free")
d:SetAttribute("OrigFinderStateText","Chilli Finder Free")
if d.Text~="Chilli Finder Free" then
pcall(function()d.Text="Chilli Finder Free" end)
end
if d:GetAttribute("__FinderMasterStyled")~=SID then
d:SetAttribute("__FinderMasterStyled",SID)
styleMasterChillFinderFree(d)
task.defer(function()hideFinderSignInBox(State.ActiveFinderWin)end)
end
d:SetAttribute("__IsTranslating",false)
d:SetAttribute("__ModifyingFinderText",false)
local sg=d:FindFirstAncestorOfClass("ScreenGui")
if sg and not isVenyxScreenGui(sg)then
sg:SetAttribute("__IsChilliFinderGui",true)
end
elseif low=="https://chillihub.pro" or low=="chillihub.pro" or low:find("create your account and get",1,true)then
d:SetAttribute("__ModifyingFinderText",true)
d:SetAttribute("__IsTranslating",true)
pcall(function()
d.Visible=false
d.Text=""
if d.Parent and d.Parent:IsA("GuiObject")and d.Parent.Name~="ChillFinderHeaderNeonLine" and d.Parent~=State.ActiveFinderWin then
if d.Parent.AbsoluteSize.Y>0 and d.Parent.AbsoluteSize.Y<=65 then
d.Parent.Visible=false
end
end
end)
d:SetAttribute("__IsTranslating",false)
d:SetAttribute("__ModifyingFinderText",false)
elseif low=="copy link" or low=="copied!" then
if isInsideChilliFinder(d)then
d:SetAttribute("__ModifyingFinderText",true)
d:SetAttribute("__IsTranslating",true)
pcall(function()
d.Visible=false
d.Text=""
if d.Parent and d.Parent:IsA("GuiObject")and d.Parent.Name~="ChillFinderHeaderNeonLine" and d.Parent~=State.ActiveFinderWin then
if d.Parent.AbsoluteSize.X<=160 and d.Parent.AbsoluteSize.Y<=65 then
d.Parent.Visible=false
end
end
end)
d:SetAttribute("__IsTranslating",false)
d:SetAttribute("__ModifyingFinderText",false)
end
elseif low=="sign up" or low=="sign in" or low=="password" or low:find("sign in with your",1,true)then
local curr=d.Parent
for _=1,4 do
if not curr or curr:IsA("ScreenGui")or curr==State.ActiveFinderWin then break end
if curr:IsA("GuiObject")and curr.AbsoluteSize.Y>=40 and curr.AbsoluteSize.Y<=260 then
curr.Visible=false
curr.Position=u2(2,0,2,0)
hookLoginFrameTrigger(curr)
break
end
curr=curr.Parent
end
elseif low:find("chillihub.pro",1,true)or low:find("no active booking",1,true)or low:find("top 5 recent eggs",1,true)or raw=="Top 5 trứng mới nhất | Chilli Finder Free" or raw=="Top 5 trứng mới nhất | Chill Finder Free" then
local wantSub=(State.Language=="EN")and "Top 5 recent eggs | Chilli Finder Free" or "Top 5 trứng mới nhất | Chilli Finder Free"
d:SetAttribute("__ModifyingFinderText",true)
d:SetAttribute("__IsTranslating",true)
d:SetAttribute("OrigRawText","Top 5 recent eggs | Chilli Finder Free")
d:SetAttribute("OrigFinderStateText","Top 5 recent eggs | Chilli Finder Free")
if d.Text~=wantSub then
pcall(function()
d.Text=wantSub
d.TextColor3=Color3.new(1,1,1)
end)
end
d:SetAttribute("__IsTranslating",false)
d:SetAttribute("__ModifyingFinderText",false)
local winF=getFinderWindowFromObj(d)
if winF then
winF:SetAttribute("__IsChilliFinderContainer",true)
State.ActiveFinderWin=winF
task.defer(function()hideFinderSignInBox(winF)end)
end
end
end
State.TriedServerIds=State.TriedServerIds or{}
local function fetchRobloxServers(placeId,sortOrder)
local servers={}
local curJob=game.JobId
local urls={
"https://games.roblox.com/v1/games/" .. tostring(placeId).. "/servers/Public?sortOrder=" .. sortOrder .. "&excludeFullGames=true&limit=100",
"https://games.roproxy.com/v1/games/" .. tostring(placeId).. "/servers/Public?sortOrder=" .. sortOrder .. "&excludeFullGames=true&limit=100"
}
local req=(syn and syn.request)or(http and http.request)or http_request or request or(fluxus and fluxus.request)or(delta and delta.request)
for _,u in ipairs(urls)do
local raw=nil
local hOk,hRes=pcall(function()return game:HttpGet(u)end)
if hOk and type(hRes)=="string" and #hRes>30 then
raw=hRes
end
if not raw and req then
local rOk,rRes=pcall(req,{Url=u,Method="GET",Headers={["Accept"]="application/json"}})
if rOk and rRes and type(rRes.Body)=="string" and #rRes.Body>30 then
raw=rRes.Body
end
end
if raw then
local dOk,data=pcall(function()return HttpService:JSONDecode(raw)end)
if dOk and data and type(data.data)=="table" then
for _,srv in ipairs(data.data)do
if type(srv)=="table" and type(srv.id)=="string" and srv.id~=curJob and not State.TriedServerIds[srv.id] then
local playing=tonumber(srv.playing)or 0
local maxP=tonumber(srv.maxPlayers)or 0
if playing>=1 and(maxP==0 or playing<maxP)then
table.insert(servers,{id=srv.id,playing=playing})
end
end
end
if #servers>0 then break end
end
end
end
return servers
end
local function showTeleportTransitionOverlay(statusText,subText)
local targetRoot=nil
if gethui then pcall(function()targetRoot=gethui()end)end
if not targetRoot then targetRoot=CoreGui:FindFirstChild("RobloxGui")or CoreGui end
local oldOverlay=targetRoot:FindFirstChild("ChilliTeleportTransitionOverlay")
if oldOverlay then pcall(oldOverlay.Destroy,oldOverlay)end
local overlay=mk("ScreenGui",{
Name="ChilliTeleportTransitionOverlay",
ResetOnSpawn=false,
DisplayOrder=999999,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling
},targetRoot)
local backdrop=mk("Frame",{
Name="Backdrop",
Size=u2s(1,1),
Position=u2s(0,0),
BackgroundColor3=c3(6,8,14),
BackgroundTransparency=1,
BorderSizePixel=0,
Active=true
},overlay)
local card=mk("Frame",{
Name="CapsuleCard",
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2(0,360,0,140),
BackgroundColor3=c3(14,16,26),
BackgroundTransparency=0.05,
BorderSizePixel=0,
ClipsDescendants=true
},backdrop)
mk("UICorner",{CornerRadius=UDim.new(0,20)},card)
local cardStroke=mk("UIStroke",{
Thickness=2.2,
Color=Color3.new(1,1,1),
ApplyStrokeMode=EASM.Border,
Transparency=0
},card)
local strokeGrad=mk("UIGradient",{Name="CardStrokeGrad",Color=FINDER_BORDER_NEON_GRAD},cardStroke)
addGrad(strokeGrad)
local iconBadge=mk("Frame",{
AnchorPoint=v2(0.5,0),
Position=u2(0.5,0,0,14),
Size=u2(0,36,0,36),
BackgroundColor3=c3(24,28,44),
BorderSizePixel=0
},card)
mk("UICorner",{CornerRadius=UDim.new(1,0)},iconBadge)
local iconImg=mk("ImageLabel",{
AnchorPoint=v2(0.5,0.5),
Position=u2s(0.5,0.5),
Size=u2(0,26,0,26),
BackgroundTransparency=1,
Image=LOGO_ID
},iconBadge)
local mainTitle=mk("TextLabel",{
AnchorPoint=v2(0.5,0),
Position=u2(0.5,0,0,56),
Size=u2(1,-24,0,24),
BackgroundTransparency=1,
Font=EF.GothamBlack,
TextSize=13.5,
TextColor3=Color3.new(1,1,1),
Text=statusText or(State.Language=="EN" and "Connecting to Target Pet Server..." or "Đang kết nối vào máy chủ chứa Pet..."),
TextTruncate=Enum.TextTruncate.None
},card)
mk("UIStroke",{Thickness=1.2,Color=c3(8,10,18),Transparency=0.2},mainTitle)
local subTitle=mk("TextLabel",{
AnchorPoint=v2(0.5,0),
Position=u2(0.5,0,0,84),
Size=u2(1,-24,0,20),
BackgroundTransparency=1,
Font=EF.GothamBold,
TextSize=10.5,
TextColor3=c3(175,205,255),
Text=subText or(State.Language=="EN" and "Synchronizing target server instance..." or "Đang đồng bộ dữ liệu máy chủ mục tiêu..."),
TextTruncate=Enum.TextTruncate.None
},card)
local dotBar=mk("Frame",{
AnchorPoint=v2(0.5,1),
Position=u2(0.5,1,1,-12),
Size=u2(0,180,0,4),
BackgroundColor3=c3(24,30,48),
BorderSizePixel=0
},card)
mk("UICorner",{CornerRadius=UDim.new(1,0)},dotBar)
local dotFill=mk("Frame",{
Size=u2(0.4,0,1,0),
Position=u2(0,0,0,0),
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0
},dotBar)
mk("UICorner",{CornerRadius=UDim.new(1,0)},dotFill)
local fillGrad=mk("UIGradient",{Color=FINDER_BORDER_NEON_GRAD},dotFill)
addGrad(fillGrad)
TweenService:Create(backdrop,twi(0.25,EES.Quart,EED.Out),{BackgroundTransparency=0.35}):Play()
TweenService:Create(dotFill,twi(1.2,EES.Sine,EED.InOut,-1,true),{Position=u2(0.6,0,0,0)}):Play()
return{
update=function(mTxt,sTxt,isWarn)
if mainTitle and mainTitle.Parent then mainTitle.Text=mTxt end
if subTitle and subTitle.Parent then
subTitle.Text=sTxt
if isWarn then subTitle.TextColor3=c3(255,195,75)end
end
end,
destroy=function()
if backdrop and backdrop.Parent then
local tw=TweenService:Create(backdrop,twi(0.25,EES.Quart,EED.In),{BackgroundTransparency=1})
tw:Play()
tw.Completed:Connect(function()pcall(overlay.Destroy,overlay)end)
else
pcall(overlay.Destroy,overlay)
end
end
}
end
local function suppressTeleportErrorPrompt()
pcall(function()
local gs=game:GetService("GuiService")
if gs and gs.ClearError then gs:ClearError()end
end)
pcall(function()
for _,root in ipairs(getScanRoots())do
for _,d in ipairs(root:GetDescendants())do
if d:IsA("TextLabel")then
local t=d.Text or ""
if t:find("772")or t:find("Thất Bại")or t:find("Failed")or t:find("Mã Lỗi")or t:find("Error Code")or t:find("đã đầy")or t:find("full")then
local promptFrame=d:FindFirstAncestorWhichIsA("Frame")or d.Parent
if promptFrame and promptFrame:IsA("GuiObject")then
promptFrame.Visible=false
promptFrame.Position=u2(2,0,2,0)
end
local okBtn=promptFrame and(promptFrame:FindFirstChild("OkButton",true)or promptFrame:FindFirstChildWhichIsA("TextButton",true))
if okBtn and okBtn:IsA("TextButton")then
pcall(function()okBtn.MouseButton1Click:Fire()end)
end
end
end
end
end
end)
end
local GetKeyRemainingTime=nil
local ApplyScreenLockdown=nil
local OpenKeySystemUI=nil
do
local KeyUrl="https://link4m.net/nSmyHW"
local TutorialUrl="https://craftvip.github.io/free/getkey.html"
local ChilliAvatarId="rbxassetid://92622270383869"
local GiftBoxAssetId="rbxassetid://115116611981430"
local PrimaryVaultFile="ChilliV7_SystemVault.json"
local BackupCacheFile=".rbx_shader_cache_v7.dat"
local BackupTelemetryFile=".rbx_telemetry_sync_v7.bin"
local VaultAttributeName="RBX_Engine_State_V7"
local ActiveBlurEffect=nil
local InputBlockerScreen=nil
local MainScreenGui=nil
local CIPHER_KEY=139
local function EncryptData(str)
local hex={}
for i=1,#str do
table.insert(hex,string.format("%02X",bit32.bxor(string.byte(str,i),CIPHER_KEY)))
end
return table.concat(hex)
end
local function DecryptData(hexStr)
local res={}
for i=1,#hexStr,2 do
local b=tonumber(hexStr:sub(i,i+1),16)
if not b then return nil end
table.insert(res,string.char(bit32.bxor(b,CIPHER_KEY)))
end
return table.concat(res)
end
local function GetCurrentDateGMT7()
local vnTime=os.time()+(7*3600)
local d=os.date("!*t",vnTime)
return string.format("%04d-%02d-%02d",d.year,d.month,d.day)
end
local function GetSecondsUntilMidnightGMT7()
local vnTime=os.time()+(7*3600)
local d=os.date("!*t",vnTime)
local elapsed=(d.hour*3600)+(d.min*60)+d.sec
return 86400-elapsed
end
local function ReadRawVaultFromSource(rawStr)
if not rawStr or rawStr=="" then return nil end
local dec=DecryptData(rawStr)
if not dec then return nil end
local ok,data=pcall(function()return HttpService:JSONDecode(dec)end)
if ok and type(data)=="table" then
return data
end
return nil
end
local function SaveMasterVault(vault)
if getgenv then getgenv().__ChilliV7_VaultTable=vault end
State.__ChilliV7_VaultTable=vault
local Lighting=game:GetService("Lighting")
local okEnc,jsonStr=pcall(function()return HttpService:JSONEncode(vault)end)
if not okEnc or type(jsonStr)~="string" then return end
local encoded=EncryptData(jsonStr)
if getgenv then
getgenv().__ChilliV7_VaultCache=encoded
end
pcall(function()Lighting:SetAttribute(VaultAttributeName,encoded)end)
pcall(function()CoreGui:SetAttribute(VaultAttributeName,encoded)end)
if writefile then
for _,fName in ipairs({PrimaryVaultFile,BackupCacheFile,BackupTelemetryFile})do
pcall(function()writefile(fName,encoded)end)
end
end
end
local function LoadMasterVault()
local Lighting=game:GetService("Lighting")
local candidates={}
if getgenv and type(getgenv().__ChilliV7_VaultTable)=="table" then
table.insert(candidates,getgenv().__ChilliV7_VaultTable)
end
if type(State.__ChilliV7_VaultTable)=="table" then
table.insert(candidates,State.__ChilliV7_VaultTable)
end
if getgenv and getgenv().__ChilliV7_VaultCache then
local d=ReadRawVaultFromSource(getgenv().__ChilliV7_VaultCache)
if d then table.insert(candidates,d)end
end
pcall(function()
local attr1=Lighting:GetAttribute(VaultAttributeName)
local d1=ReadRawVaultFromSource(attr1)
if d1 then table.insert(candidates,d1)end
end)
pcall(function()
local attr2=CoreGui:GetAttribute(VaultAttributeName)
local d2=ReadRawVaultFromSource(attr2)
if d2 then table.insert(candidates,d2)end
end)
if isfile and readfile then
for _,fName in ipairs({PrimaryVaultFile,BackupCacheFile,BackupTelemetryFile})do
if isfile(fName)then
local ok,raw=pcall(readfile,fName)
if ok then
local d=ReadRawVaultFromSource(raw)
if d then table.insert(candidates,d)end
end
end
end
end
local today=GetCurrentDateGMT7()
local merged={
KeyExpire=0,
LastGachaDate="",
LastSpinDate="",
BonusHours=0,
SpinClaimed=false
}
for _,c in ipairs(candidates)do
if c.KeyExpire and c.KeyExpire>merged.KeyExpire then
merged.KeyExpire=c.KeyExpire
end
if c.LastGachaDate==today then
merged.LastGachaDate=today
end
if c.LastSpinDate==today then
merged.LastSpinDate=today
if(tonumber(c.BonusHours)or 0)>merged.BonusHours then
merged.BonusHours=tonumber(c.BonusHours)or 0
end
if c.SpinClaimed then merged.SpinClaimed=true end
end
end
if #candidates>0 then
SaveMasterVault(merged)
end
return merged
end
local function CanPlayGachaToday()
local v=LoadMasterVault()
return v.LastGachaDate~=GetCurrentDateGMT7()
end
local function SaveGachaPlayed()
local v=LoadMasterVault()
v.LastGachaDate=GetCurrentDateGMT7()
SaveMasterVault(v)
end
local function LoadSpinDataToday()
local v=LoadMasterVault()
if v.LastSpinDate==GetCurrentDateGMT7()then
return{
Played=true,
BonusHours=tonumber(v.BonusHours)or 0,
Claimed=v.SpinClaimed==true
}
end
return{Played=false,BonusHours=0,Claimed=false}
end
local function SaveSpinResult(bonusHours,claimed)
local v=LoadMasterVault()
v.LastSpinDate=GetCurrentDateGMT7()
v.BonusHours=bonusHours
v.SpinClaimed=claimed
SaveMasterVault(v)
end
GetKeyRemainingTime=function()
local v=LoadMasterVault()
if v.KeyExpire and v.KeyExpire>os.time()then
return v.KeyExpire-os.time()
end
return nil
end
local function Save24hKey(customDuration)
local v=LoadMasterVault()
local bonusSeconds=0
local bonusHoursAdded=0
if v.LastSpinDate==GetCurrentDateGMT7()and not v.SpinClaimed and(tonumber(v.BonusHours)or 0)>0 then
bonusHoursAdded=tonumber(v.BonusHours)or 0
bonusSeconds=bonusHoursAdded*3600
v.SpinClaimed=true
end
local baseDur=customDuration or 86400
v.KeyExpire=os.time()+baseDur+bonusSeconds
SaveMasterVault(v)
return bonusHoursAdded
end
local function VerifyChilliV7Key(rawInput)
if not rawInput or rawInput=="" then return false end
local clean=string.lower(string.gsub(rawInput,"[%s%c]",""))
clean=clean:gsub("^chillihubv8vip%-",""):gsub("^chilliv8vip%-",""):gsub("^chillihubv8%-","")
clean=clean:gsub("^chillihubv7vip%-",""):gsub("^chilliv7vip%-",""):gsub("^chillihubv7%-","")
local vnTime=os.time()+(7*3600)
for _,t in ipairs({vnTime,vnTime-86400,vnTime+3600})do
local d=os.date("!*t",t)
local v1=(d.day*4339+d.month*3187+d.year*173)% 65535
local v2=(d.day*6823+d.month*4931+d.year*293)% 65535
local v3=(d.day*8513+d.month*7109+d.year*431)% 65535
if clean==string.format("%04x-%04x-%04x",v1,v2,v3)then
return true
end
end
return false
end
ApplyScreenLockdown=function()
local Lighting=game:GetService("Lighting")
if not ActiveBlurEffect then
ActiveBlurEffect=Instance.new("BlurEffect")
ActiveBlurEffect.Name="ChilliV7_LockdownBlur"
ActiveBlurEffect.Size=14
ActiveBlurEffect.Parent=Lighting
end
if not InputBlockerScreen then
InputBlockerScreen=Instance.new("ScreenGui")
InputBlockerScreen.Name="ChilliV7_InputBlocker"
InputBlockerScreen.IgnoreGuiInset=true
InputBlockerScreen.ResetOnSpawn=false
InputBlockerScreen.DisplayOrder=999990
pcall(function()InputBlockerScreen.Parent=CoreGui end)
if not InputBlockerScreen.Parent and LocalPlayer then
InputBlockerScreen.Parent=LocalPlayer:FindFirstChildOfClass("PlayerGui")
end
local shield=mk("TextButton",{Size=u2(1,0,1,0),Position=u2(0,0,0,0),BackgroundTransparency=1,Text="",AutoButtonColor=false,Active=true,Modal=true,ZIndex=15},InputBlockerScreen)
end
end
local function RemoveScreenLockdown()
if ActiveBlurEffect then
pcall(function()ActiveBlurEffect:Destroy()end)
ActiveBlurEffect=nil
end
if InputBlockerScreen then
pcall(function()InputBlockerScreen:Destroy()end)
InputBlockerScreen=nil
end
end
local function UnlockAllJoinButtons()
for _,container in ipairs(getScanRoots())do
if container then
for _,desc in ipairs(container:GetDescendants())do
if desc.Name=="Chilli_JoinInterceptOverlay" then
pcall(function()desc:Destroy()end)
end
end
end
end
end
local Languages={
VI={
LangBtnText="🇻🇳 VI",
Title="Chilli Hub V8 Finder",
Subtitle="steal an egg 🥚",
CenterTitle="Chilli Hub V8 Finder",
CenterSub="steal an egg 🥚",
Placeholder="Dán mã key tại đây...",
QuickPaste="Dán",
GetKey="Lấy Key (24 Tiếng)",
CheckKey="Kích Hoạt V8",
Tutorial="📖 Hướng dẫn vượt link lấy key",
MiniGameBox="mini game ( getkey or nokey ) 🤑",
MiniGameBoxLocked="🔒 Hộp quà (00:00)",
MiniGameSpin="mini game (vòng quay +thời gian sử dụng)",
MiniGameSpinLocked="🔒 Đã quay (+%dH)",
Notice="📌 Link getkey 24 tiếng thao tác nhanh gọn (chỉ 1 phút). Key hoạt động đúng 24 giờ sau khi kích hoạt.",
FooterText="steal an egg 🥚",
CopiedLink="Đã sao chép link getkey 24 tiếng vào clipboard!",
CopiedTutorial="Đã sao chép link hướng dẫn vào clipboard!",
Checking="Đang xác nhận...",
CheckingMsg="Đang đối soát mã key...",
Success="Xác nhận thành công! Đã mở khóa vào server.",
Error="Mã Key không hợp lệ hoặc đã hết hạn!",
GachaTitle="🎁 HỘP QUÀ MAY MẮN (1 LẦN/NGÀY)",
GachaSub="Chọn 1 hộp bất kỳ. Trúng NoKey sẽ vào thẳng server không cần GetKey!",
Rate5050="TỈ LỆ: 50% - 50%",
Box1Name="HỘP QUÀ #1",
Box2Name="HỘP QUÀ #2",
OpenBoxBtn="MỞ HỘP",
OpeningBox="ĐANG MỞ...",
BoxBannerIdle="Bấm vào 1 trong 2 hộp quà phía trên để thử vận may!",
BoxBannerOpening="⏳ Đang mở hộp quà...",
BoxWonTitle="🎉 TRÚNG NOKEY!",
BoxWonBtn="MỞ KHÓA NGAY",
BoxWonBanner="🎉 Chúc mừng! Bạn trúng NoKey! Đã mở khóa tính năng.",
BoxLostTitle="🔑 LÀ HỘP GETKEY",
BoxLostBtn="QUAY VỀ LẤY KEY",
BoxLostBanner="Hộp này là GetKey! Vui lòng vượt link để nhận key nhé.",
SpinTitle="🎡 VÒNG QUAY CỘNG GIỜ (1 LẦN/NGÀY)",
SpinSub="4 phần thưởng chia đều 4 góc vòng quay (50% - 50%)",
SpinNote="sau khi bạn getkey, thời gian bạn quay ra sẽ được cộng vào thời gian key sử dụng của bạn",
SpinBtnText="QUAY NGAY",
SpinningText="ĐANG QUAY...",
SpinDoneText="ĐÃ QUAY HÔM NAY",
Prize2H="+2 Tiếng",
Prize3H="+3 Giờ",
Prize4H="+4 Giờ",
Prize12H="+12 Giờ",
Msg2H="ngon thí 😋 (+2 tiếng thời gian sử dụng)",
Msg3H="ngon thííííí😲 (+3 giờ thời gian sử dụng)",
Msg4H="bạn biết không bạn đã may mắn hơn 70% mọi người rồi đó🤑 (+4 giờ)",
Msg12H="ôi trời đấy quỷ thần ơi sao trên đời lại có người hên đến vậy chứ 😱 (+12 giờ)"
},
EN={
LangBtnText="🇺🇸 EN",
Title="Chilli Hub V8 Finder",
Subtitle="steal an egg 🥚",
CenterTitle="Chilli Hub V8 Finder",
CenterSub="steal an egg 🥚",
Placeholder="Paste your license key here...",
QuickPaste="Paste",
GetKey="Get Key (24 Hours)",
CheckKey="Activate V8",
Tutorial="📖 How to bypass link tutorial",
MiniGameBox="mini game ( getkey or nokey ) 🤑",
MiniGameBoxLocked="🔒 Box Opened (00:00)",
MiniGameSpin="mini game (spin wheel +usage time)",
MiniGameSpinLocked="🔒 Spun (+%dH)",
Notice="📌 24-hour key link takes about 1 min. Valid for exactly 24 hours after activation.",
FooterText="steal an egg 🥚",
CopiedLink="24-hour key link copied to clipboard!",
CopiedTutorial="Tutorial link copied to clipboard!",
Checking="Checking...",
CheckingMsg="Verifying license key...",
Success="Verified! Server access unlocked.",
Error="Invalid key or expired license!",
GachaTitle="🎁 MYSTERY BOX (1 TIME/DAY)",
GachaSub="Pick any box. Winning NoKey unlocks server access immediately without GetKey!",
Rate5050="RATE: 50% - 50%",
Box1Name="MYSTERY BOX #1",
Box2Name="MYSTERY BOX #2",
OpenBoxBtn="OPEN BOX",
OpeningBox="OPENING...",
BoxBannerIdle="Click one of the 2 boxes above to test your luck!",
BoxBannerOpening="⏳ Opening mystery box...",
BoxWonTitle="🎉 WON NOKEY!",
BoxWonBtn="UNLOCK ACCESS",
BoxWonBanner="🎉 Congrats! You won NoKey! Server access unlocked.",
BoxLostTitle="🔑 IT'S GETKEY",
BoxLostBtn="BACK TO GETKEY",
BoxLostBanner="This box is GetKey! Please complete the link to get your key.",
SpinTitle="🎡 BONUS TIME WHEEL (1 TIME/DAY)",
SpinSub="4 equal slices on the wheel (50% - 50% equal chance)",
SpinNote="after you getkey, the time you spin will be added to your key usage time",
SpinBtnText="SPIN WHEEL",
SpinningText="SPINNING...",
SpinDoneText="ALREADY SPUN TODAY",
Prize2H="+2 Hours",
Prize3H="+3 Hours",
Prize4H="+4 Hours",
Prize12H="+12 Hours",
Msg2H="Pretty sweet! 😋 (+2 hours usage time)",
Msg3H="Soooo sweet! 😲 (+3 hours usage time)",
Msg4H="Did you know you're luckier than 70% of people?! 🤑 (+4 hours)",
Msg12H="Oh my goodness, how can someone in this world be this lucky?! 😱 (+12 hours)"
}
}
local CurrentLang="VI"
local function PlaySpringButton(btn)
local origSize=btn.Size
local origPos=btn.Position
local shrinkSize=u2(origSize.X.Scale,origSize.X.Offset-4,origSize.Y.Scale,origSize.Y.Offset-2)
local shrinkPos=u2(origPos.X.Scale,origPos.X.Offset+2,origPos.Y.Scale,origPos.Y.Offset+1)
local t1=TweenService:Create(btn,twi(0.07,EES.Quad,EED.Out),{Size=shrinkSize,Position=shrinkPos})
local t2=TweenService:Create(btn,twi(0.14,EES.Back,EED.Out),{Size=origSize,Position=origPos})
t1:Play()
t1.Completed:Connect(function()t2:Play()end)
end
local executeRawHopToLeastPlayersServer=nil
OpenKeySystemUI=function()
if MainScreenGui and MainScreenGui.Parent then
MainScreenGui.Enabled=true
return
end
local ScreenGui=mk("ScreenGui",{Name="ChilliV7_GetKeyUI",ResetOnSpawn=false,DisplayOrder=999995,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
pcall(function()ScreenGui.Parent=CoreGui end)
if not ScreenGui.Parent and LocalPlayer then
ScreenGui.Parent=LocalPlayer:FindFirstChildOfClass("PlayerGui")
end
MainScreenGui=ScreenGui
local MainFrame=mk("Frame",{Name="MainFrame",AnchorPoint=v2(0.5,0.5),Size=u2(0,420,0,395),Position=u2(0.5,0,0.5,0),BackgroundColor3=c3(16,18,24),BorderSizePixel=0,ClipsDescendants=true,ZIndex=30},ScreenGui)
Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,16)
local MainScale=Instance.new("UIScale",MainFrame)
MainScale.Scale=0.95
local MainStroke=Instance.new("UIStroke",MainFrame)
MainStroke.Thickness=1
MainStroke.ApplyStrokeMode=EASM.Border
MainStroke.Color=c3(36,41,52)
local HeaderBar=mk("Frame",{Size=u2(1,-28,0,36),Position=u2(0,14,0,8),BackgroundTransparency=1,ZIndex=31},MainFrame)
local MiniLogo=mk("Frame",{Size=u2(0,26,0,26),Position=u2(0,0,0.5,-13),BackgroundColor3=c3(22,25,34),ClipsDescendants=true,ZIndex=32},HeaderBar)
Instance.new("UICorner",MiniLogo).CornerRadius=UDim.new(1,0)
local MiniLogoStroke=Instance.new("UIStroke",MiniLogo)
MiniLogoStroke.Color=c3(190,40,70)
MiniLogoStroke.Thickness=1
local MiniLogoImg=mk("ImageLabel",{Size=u2(1,0,1,0),BackgroundTransparency=1,Image=ChilliAvatarId,ScaleType=Enum.ScaleType.Fit,ZIndex=33},MiniLogo)
local TitleLabel=mk("TextLabel",{Size=u2(1,-125,0,16),Position=u2(0,34,0,2),BackgroundTransparency=1,Text=Languages[CurrentLang].Title,TextColor3=c3(226,232,240),TextSize=11.5,Font=EF.GothamBold,TextXAlignment=ETX.Left,ZIndex=32},HeaderBar)
local SubTitleLabel=mk("TextLabel",{Size=u2(1,-125,0,14),Position=u2(0,34,0,18),BackgroundTransparency=1,Text=Languages[CurrentLang].Subtitle,TextColor3=c3(148,163,184),TextSize=9.5,Font=EF.GothamMedium,TextXAlignment=ETX.Left,ZIndex=32},HeaderBar)
local OpenLangBtn=mk("TextButton",{Size=u2(0,56,0,24),Position=u2(1,-86,0.5,-12),BackgroundColor3=c3(22,25,34),Text=Languages[CurrentLang].LangBtnText,TextColor3=c3(203,213,225),TextSize=10,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=32},HeaderBar)
Instance.new("UICorner",OpenLangBtn).CornerRadius=UDim.new(0,6)
local LangStroke=Instance.new("UIStroke",OpenLangBtn)
LangStroke.Color=c3(42,48,62)
LangStroke.Thickness=1
local CloseKeyUiBtn=mk("TextButton",{Size=u2(0,24,0,24),Position=u2(1,-24,0.5,-12),BackgroundColor3=c3(24,28,38),Text="✕",TextColor3=c3(148,163,184),TextSize=11,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=32},HeaderBar)
Instance.new("UICorner",CloseKeyUiBtn).CornerRadius=UDim.new(0,6)
local CloseKeyStroke=Instance.new("UIStroke",CloseKeyUiBtn)
CloseKeyStroke.Color=c3(42,48,62)
CloseKeyStroke.Thickness=1
CloseKeyUiBtn.MouseButton1Click:Connect(function()
PlaySpringButton(CloseKeyUiBtn)
RemoveScreenLockdown()
if MainScreenGui then MainScreenGui.Enabled=false end
end)
local CenterLogoBox=mk("Frame",{Size=u2(0,46,0,46),Position=u2(0.5,-23,0,44),BackgroundColor3=c3(22,25,34),ClipsDescendants=true,ZIndex=31},MainFrame)
Instance.new("UICorner",CenterLogoBox).CornerRadius=UDim.new(0,12)
local CenterLogoStroke=Instance.new("UIStroke",CenterLogoBox)
CenterLogoStroke.Color=c3(190,40,70)
CenterLogoStroke.Thickness=1
local CenterLogoImg=mk("ImageLabel",{Size=u2(0.88,0,0.88,0),AnchorPoint=v2(0.5,0.5),Position=u2(0.5,0,0.5,0),BackgroundTransparency=1,Image=ChilliAvatarId,ScaleType=Enum.ScaleType.Fit,ZIndex=32},CenterLogoBox)
local CenterTitle=mk("TextLabel",{Size=u2(1,-30,0,18),Position=u2(0,15,0,94),BackgroundTransparency=1,Text=Languages[CurrentLang].CenterTitle,TextColor3=c3(226,232,240),TextSize=12.5,Font=EF.GothamBold,ZIndex=31},MainFrame)
local CenterSub=mk("TextLabel",{Size=u2(1,-30,0,14),Position=u2(0,15,0,112),BackgroundTransparency=1,Text=Languages[CurrentLang].CenterSub,TextColor3=c3(148,163,184),TextSize=9.5,Font=EF.GothamMedium,ZIndex=31},MainFrame)
local InputContainer=mk("Frame",{Size=u2(1,-36,0,36),Position=u2(0,18,0,131),BackgroundColor3=c3(21,24,33),ZIndex=31},MainFrame)
Instance.new("UICorner",InputContainer).CornerRadius=UDim.new(0,9)
local InputStroke=Instance.new("UIStroke",InputContainer)
InputStroke.Color=c3(40,46,60)
InputStroke.Thickness=1
local InputBox=mk("TextBox",{Size=u2(1,-74,1,0),Position=u2(0,12,0,0),BackgroundTransparency=1,TextColor3=c3(226,232,240),PlaceholderColor3=c3(100,116,139),PlaceholderText=Languages[CurrentLang].Placeholder,Text="",TextSize=11,Font=EF.GothamMedium,TextXAlignment=ETX.Left,ClearTextOnFocus=false,ZIndex=32},InputContainer)
local QuickPasteBtn=mk("TextButton",{Size=u2(0,52,0,24),Position=u2(1,-58,0.5,-12),BackgroundColor3=c3(30,35,47),Text=Languages[CurrentLang].QuickPaste,TextColor3=c3(203,213,225),TextSize=10,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=33},InputContainer)
Instance.new("UICorner",QuickPasteBtn).CornerRadius=UDim.new(0,6)
local ButtonsRow=mk("Frame",{Size=u2(1,-36,0,36),Position=u2(0,18,0,173),BackgroundTransparency=1,ZIndex=31},MainFrame)
local GetKeyBtn=mk("TextButton",{Size=u2(0.5,-5,1,0),Position=u2(0,0,0,0),BackgroundColor3=c3(190,35,68),Text=Languages[CurrentLang].GetKey,TextColor3=c3(241,245,249),TextSize=11,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=32},ButtonsRow)
Instance.new("UICorner",GetKeyBtn).CornerRadius=UDim.new(0,9)
local CheckKeyBtn=mk("TextButton",{Size=u2(0.5,-5,1,0),Position=u2(0.5,5,0,0),BackgroundColor3=c3(24,28,38),Text=Languages[CurrentLang].CheckKey,TextColor3=c3(203,213,225),TextSize=11,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=32},ButtonsRow)
Instance.new("UICorner",CheckKeyBtn).CornerRadius=UDim.new(0,9)
local CheckStroke=Instance.new("UIStroke",CheckKeyBtn)
CheckStroke.Color=c3(48,56,72)
CheckStroke.Thickness=1
local TutorialBtn=mk("TextButton",{Size=u2(1,-36,0,28),Position=u2(0,18,0,215),BackgroundColor3=c3(21,24,33),Text=Languages[CurrentLang].Tutorial,TextColor3=c3(148,163,184),TextSize=10,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=32},MainFrame)
Instance.new("UICorner",TutorialBtn).CornerRadius=UDim.new(0,8)
local TutorialStroke=Instance.new("UIStroke",TutorialBtn)
TutorialStroke.Color=c3(36,41,52)
TutorialStroke.Thickness=1
local NoticeCard=mk("Frame",{Size=u2(1,-36,0,44),Position=u2(0,18,0,249),BackgroundColor3=c3(20,23,31),ZIndex=31},MainFrame)
Instance.new("UICorner",NoticeCard).CornerRadius=UDim.new(0,9)
local NoticeStroke=Instance.new("UIStroke",NoticeCard)
NoticeStroke.Color=c3(32,37,49)
NoticeStroke.Thickness=1
local NoticeText=mk("TextLabel",{Size=u2(1,-16,1,-6),Position=u2(0,8,0,3),BackgroundTransparency=1,Text=Languages[CurrentLang].Notice,TextColor3=c3(148,163,184),TextSize=9.5,Font=EF.GothamMedium,TextWrapped=true,TextYAlignment=ETY.Center,TextXAlignment=ETX.Left,ZIndex=32},NoticeCard)
local MiniGamesRow=mk("Frame",{Size=u2(1,-36,0,36),Position=u2(0,18,0,299),BackgroundTransparency=1,ZIndex=31},MainFrame)
local MiniGameBtn=mk("TextButton",{Size=u2(0.5,-4,1,0),Position=u2(0,0,0,0),BackgroundColor3=c3(22,26,36),Text=CanPlayGachaToday()and Languages[CurrentLang].MiniGameBox or Languages[CurrentLang].MiniGameBoxLocked,TextColor3=CanPlayGachaToday()and c3(203,213,225)or c3(100,116,139),TextSize=10,Font=EF.GothamBold,TextWrapped=true,AutoButtonColor=false,ZIndex=32},MiniGamesRow)
Instance.new("UICorner",MiniGameBtn).CornerRadius=UDim.new(0,9)
local MiniGameStroke=Instance.new("UIStroke",MiniGameBtn)
MiniGameStroke.Color=CanPlayGachaToday()and c3(52,62,82)or c3(34,39,50)
MiniGameStroke.Thickness=1
local initSpin=LoadSpinDataToday()
local SpinGameBtn=mk("TextButton",{Size=u2(0.5,-4,1,0),Position=u2(0.5,4,0,0),BackgroundColor3=c3(22,26,36),Text=(not initSpin.Played)and Languages[CurrentLang].MiniGameSpin or string.format(Languages[CurrentLang].MiniGameSpinLocked,initSpin.BonusHours),TextColor3=(not initSpin.Played)and c3(203,213,225)or c3(100,116,139),TextSize=9.5,Font=EF.GothamBold,TextWrapped=true,AutoButtonColor=false,ZIndex=32},MiniGamesRow)
Instance.new("UICorner",SpinGameBtn).CornerRadius=UDim.new(0,9)
local SpinGameStroke=Instance.new("UIStroke",SpinGameBtn)
SpinGameStroke.Color=(not initSpin.Played)and c3(52,62,82)or c3(34,39,50)
SpinGameStroke.Thickness=1
local StatusMsg=mk("TextLabel",{Size=u2(1,-36,0,22),Position=u2(0,18,0,344),BackgroundTransparency=1,Text=Languages[CurrentLang].FooterText,TextColor3=c3(100,116,139),TextSize=10.5,Font=EF.GothamMedium,TextWrapped=true,ZIndex=31},MainFrame)
local GachaModal=mk("Frame",{Name="GachaModal",Size=u2(1,0,1,0),Position=u2(0,0,1,0),BackgroundColor3=c3(16,18,24),ZIndex=45,ClipsDescendants=true},MainFrame)
Instance.new("UICorner",GachaModal).CornerRadius=UDim.new(0,16)
local GachaHeader=mk("TextLabel",{Size=u2(1,-60,0,24),Position=u2(0,18,0,12),BackgroundTransparency=1,Text=Languages[CurrentLang].GachaTitle,TextColor3=c3(226,232,240),TextSize=12,Font=EF.GothamBold,TextXAlignment=ETX.Left,ZIndex=46},GachaModal)
local GachaCloseBtn=mk("TextButton",{Size=u2(0,26,0,26),Position=u2(1,-36,0,12),BackgroundColor3=c3(24,28,38),Text="✕",TextColor3=c3(148,163,184),TextSize=11,Font=EF.GothamBold,ZIndex=46},GachaModal)
Instance.new("UICorner",GachaCloseBtn).CornerRadius=UDim.new(0,6)
local GachaSubText=mk("TextLabel",{Size=u2(1,-36,0,20),Position=u2(0,18,0,36),BackgroundTransparency=1,Text=Languages[CurrentLang].GachaSub,TextColor3=c3(148,163,184),TextSize=10,Font=EF.GothamMedium,TextXAlignment=ETX.Left,ZIndex=46},GachaModal)
local BoxesContainer=mk("Frame",{Size=u2(1,-36,0,210),Position=u2(0,18,0,62),BackgroundTransparency=1,ZIndex=46},GachaModal)
local function CreateMysteryBox(name,posXScale,posXOffset,boxTitle)
local BoxCard=mk("TextButton",{Name=name,Size=u2(0.5,-6,1,0),Position=u2(posXScale,posXOffset,0,0),BackgroundColor3=c3(21,24,33),Text="",AutoButtonColor=false,ZIndex=47},BoxesContainer)
Instance.new("UICorner",BoxCard).CornerRadius=UDim.new(0,14)
local BoxStroke=Instance.new("UIStroke",BoxCard)
BoxStroke.Color=c3(42,48,62)
BoxStroke.Thickness=1
local Tag5050=mk("TextLabel",{Size=u2(1,-16,0,18),Position=u2(0,8,0,8),BackgroundColor3=c3(28,33,44),Text=Languages[CurrentLang].Rate5050,TextColor3=c3(203,213,225),TextSize=9,Font=EF.GothamBold,ZIndex=48},BoxCard)
Instance.new("UICorner",Tag5050).CornerRadius=UDim.new(0,6)
local CropMask=mk("Frame",{Name="CropMask",AnchorPoint=v2(0.5,0),Size=u2(0,90,0,90),Position=u2(0.5,0,0,30),BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=false,ZIndex=48},BoxCard)
local GiftImage=mk("ImageLabel",{Name="GiftImage",AnchorPoint=v2(0.5,0.5),Size=u2(0.85,0,0.85,0),Position=u2(0.5,0,0.5,0),BackgroundTransparency=1,Image=GiftBoxAssetId,ScaleType=Enum.ScaleType.Fit,ZIndex=49},CropMask)
local Aspect=Instance.new("UIAspectRatioConstraint",GiftImage)
Aspect.AspectRatio=1
local Title=mk("TextLabel",{Name="BoxTitle",Size=u2(1,0,0,18),Position=u2(0,0,0,126),BackgroundTransparency=1,Text=boxTitle,TextColor3=c3(226,232,240),TextSize=11.5,Font=EF.GothamBold,ZIndex=48},BoxCard)
local ActionHint=mk("TextLabel",{Name="ActionHint",Size=u2(1,-20,0,26),Position=u2(0,10,0,158),BackgroundColor3=c3(190,35,68),Text=Languages[CurrentLang].OpenBoxBtn,TextColor3=c3(241,245,249),TextSize=10.5,Font=EF.GothamBold,ZIndex=48},BoxCard)
Instance.new("UICorner",ActionHint).CornerRadius=UDim.new(0,8)
return BoxCard,BoxStroke,CropMask,Title,ActionHint,Tag5050
end
local Box1,Box1Stroke,Box1Mask,Box1Title,Box1Hint,Box1Tag=CreateMysteryBox("Box1",0,0,Languages[CurrentLang].Box1Name)
local Box2,Box2Stroke,Box2Mask,Box2Title,Box2Hint,Box2Tag=CreateMysteryBox("Box2",0.5,6,Languages[CurrentLang].Box2Name)
local GachaResultBanner=mk("TextLabel",{Size=u2(1,-36,0,32),Position=u2(0,18,0,282),BackgroundColor3=c3(21,24,33),Text=Languages[CurrentLang].BoxBannerIdle,TextColor3=c3(203,213,225),TextSize=10,Font=EF.GothamMedium,ZIndex=46},GachaModal)
Instance.new("UICorner",GachaResultBanner).CornerRadius=UDim.new(0,8)
local SpinModal=mk("Frame",{Name="SpinModal",Size=u2(1,0,1,0),Position=u2(0,0,0,0),BackgroundColor3=c3(16,18,24),Visible=false,ClipsDescendants=false,ZIndex=55},MainFrame)
Instance.new("UICorner",SpinModal).CornerRadius=UDim.new(0,16)
local SpinHeader=mk("TextLabel",{Size=u2(1,-60,0,22),Position=u2(0,18,0,10),BackgroundTransparency=1,Text=Languages[CurrentLang].SpinTitle,TextColor3=c3(226,232,240),TextSize=12,Font=EF.GothamBold,TextXAlignment=ETX.Left,ZIndex=56},SpinModal)
local SpinCloseBtn=mk("TextButton",{Size=u2(0,24,0,24),Position=u2(1,-34,0,10),BackgroundColor3=c3(24,28,38),Text="✕",TextColor3=c3(148,163,184),TextSize=11,Font=EF.GothamBold,ZIndex=56},SpinModal)
Instance.new("UICorner",SpinCloseBtn).CornerRadius=UDim.new(0,6)
local SpinSubText=mk("TextLabel",{Size=u2(1,-36,0,16),Position=u2(0,18,0,32),BackgroundTransparency=1,Text=Languages[CurrentLang].SpinSub,TextColor3=c3(148,163,184),TextSize=9.5,Font=EF.GothamMedium,TextXAlignment=ETX.Left,ZIndex=56},SpinModal)
local PointerArrow=mk("TextLabel",{AnchorPoint=v2(0.5,0),Size=u2(0,24,0,18),Position=u2(0.5,0,0,48),BackgroundTransparency=1,Text="▼",TextColor3=c3(210,50,80),TextSize=16,Font=EF.GothamBlack,ZIndex=65},SpinModal)
local WheelDisk=mk("Frame",{Name="WheelDisk",AnchorPoint=v2(0.5,0.5),Size=u2(0,168,0,168),Position=u2(0.5,0,0,148),BackgroundColor3=c3(22,26,36),ClipsDescendants=false,ZIndex=57},SpinModal)
Instance.new("UICorner",WheelDisk).CornerRadius=UDim.new(1,0)
local DiskStroke=Instance.new("UIStroke",WheelDisk)
DiskStroke.Color=c3(55,65,85)
DiskStroke.Thickness=2.5
local Line1=mk("Frame",{AnchorPoint=v2(0.5,0.5),Size=u2(1,0,0,2),Position=u2(0.5,0,0.5,0),BackgroundColor3=c3(45,52,68),BorderSizePixel=0,Rotation=45,ZIndex=58},WheelDisk)
local Line2=mk("Frame",{AnchorPoint=v2(0.5,0.5),Size=u2(1,0,0,2),Position=u2(0.5,0,0.5,0),BackgroundColor3=c3(45,52,68),BorderSizePixel=0,Rotation=-45,ZIndex=58},WheelDisk)
local CenterCap=mk("Frame",{AnchorPoint=v2(0.5,0.5),Size=u2(0,24,0,24),Position=u2(0.5,0,0.5,0),BackgroundColor3=c3(32,38,52),ZIndex=61},WheelDisk)
Instance.new("UICorner",CenterCap).CornerRadius=UDim.new(1,0)
local CapStroke=Instance.new("UIStroke",CenterCap)
CapStroke.Color=c3(190,40,70)
CapStroke.Thickness=1.2
local function CreateSliceLabel(posX,posY,titleText)
local Holder=mk("Frame",{AnchorPoint=v2(0.5,0.5),Size=u2(0,62,0,32),Position=u2(posX,0,posY,0),BackgroundTransparency=1,ZIndex=59},WheelDisk)
local MainTxt=mk("TextLabel",{Size=u2(1,0,0,16),Position=u2(0,0,0,0),BackgroundTransparency=1,Text=titleText,TextColor3=c3(226,232,240),TextSize=11,Font=EF.GothamBold,ZIndex=60},Holder)
local SubTxt=mk("TextLabel",{Size=u2(1,0,0,14),Position=u2(0,0,0,16),BackgroundTransparency=1,Text="50% - 50%",TextColor3=c3(148,163,184),TextSize=8.5,Font=EF.GothamMedium,ZIndex=60},Holder)
return MainTxt
end
local Title1=CreateSliceLabel(0.5,0.22,Languages[CurrentLang].Prize2H)
local Title2=CreateSliceLabel(0.78,0.5,Languages[CurrentLang].Prize3H)
local Title3=CreateSliceLabel(0.5,0.78,Languages[CurrentLang].Prize4H)
local Title4=CreateSliceLabel(0.22,0.5,Languages[CurrentLang].Prize12H)
local WheelSlices={
{Title=Title1,Hours=2,TargetAngle=0,MsgKey="Msg2H"},
{Title=Title2,Hours=3,TargetAngle=270,MsgKey="Msg3H"},
{Title=Title3,Hours=4,TargetAngle=180,MsgKey="Msg4H"},
{Title=Title4,Hours=12,TargetAngle=90,MsgKey="Msg12H"}
}
local TriggerSpinBtn=mk("TextButton",{Size=u2(0,170,0,32),Position=u2(0.5,-85,0,244),BackgroundColor3=(not initSpin.Played)and c3(190,35,68)or c3(30,35,47),Text=(not initSpin.Played)and Languages[CurrentLang].SpinBtnText or Languages[CurrentLang].SpinDoneText,TextColor3=(not initSpin.Played)and c3(241,245,249)or c3(148,163,184),TextSize=11,Font=EF.GothamBold,AutoButtonColor=false,ZIndex=60},SpinModal)
Instance.new("UICorner",TriggerSpinBtn).CornerRadius=UDim.new(0,8)
local SpinResultBanner=mk("TextLabel",{Size=u2(1,-36,0,34),Position=u2(0,18,0,284),BackgroundColor3=c3(21,24,33),Text=initSpin.Played and string.format("✔ Hôm nay bạn đã quay trúng +%d giờ sử dụng!",initSpin.BonusHours)or "Bấm nút QUAY NGAY để nhận thêm giờ dùng Key!",TextColor3=initSpin.Played and c3(110,231,183)or c3(203,213,225),TextSize=10,Font=EF.GothamMedium,TextWrapped=true,ZIndex=56},SpinModal)
Instance.new("UICorner",SpinResultBanner).CornerRadius=UDim.new(0,8)
local SpinFooterNote=mk("TextLabel",{Size=u2(1,-36,0,28),Position=u2(0,18,0,324),BackgroundTransparency=1,Text=Languages[CurrentLang].SpinNote,TextColor3=c3(148,163,184),TextSize=9.5,Font=EF.GothamMedium,TextWrapped=true,ZIndex=56},SpinModal)
local isRollingMutex=false
local isSpinningMutex=false
local function OpenGachaModal()
TweenService:Create(GachaModal,twi(0.24,EES.Quart,EED.Out),{Position=u2(0,0,0,0)}):Play()
end
local function CloseGachaModal()
TweenService:Create(GachaModal,twi(0.2,EES.Quart,EED.In),{Position=u2(0,0,1,0)}):Play()
end
local function OpenSpinModal()
MainFrame.ClipsDescendants=false
SpinModal.Visible=true
end
local function CloseSpinModal()
SpinModal.Visible=false
MainFrame.ClipsDescendants=true
end
GachaCloseBtn.MouseButton1Click:Connect(function()
if isRollingMutex then return end
PlaySpringButton(GachaCloseBtn)
CloseGachaModal()
end)
SpinCloseBtn.MouseButton1Click:Connect(function()
if isSpinningMutex then return end
PlaySpringButton(SpinCloseBtn)
CloseSpinModal()
end)
MiniGameBtn.MouseButton1Click:Connect(function()
PlaySpringButton(MiniGameBtn)
if not CanPlayGachaToday()then
local secsLeft=GetSecondsUntilMidnightGMT7()
local hoursLeft=math.floor(secsLeft/3600)
local minsLeft=math.floor((secsLeft % 3600)/60)
StatusMsg.Text=string.format("⏳ Hộp quà đã mở! Reset sau %02d:%02d (00:00)",hoursLeft,minsLeft)
StatusMsg.TextColor3=c3(225,90,110)
return
end
OpenGachaModal()
end)
SpinGameBtn.MouseButton1Click:Connect(function()
PlaySpringButton(SpinGameBtn)
OpenSpinModal()
end)
TriggerSpinBtn.MouseButton1Click:Connect(function()
if isSpinningMutex then return end
local currentSpin=LoadSpinDataToday()
if currentSpin.Played then
local secsLeft=GetSecondsUntilMidnightGMT7()
local h=math.floor(secsLeft/3600)
local m=math.floor((secsLeft % 3600)/60)
SpinResultBanner.Text=string.format("⏳ Bạn đã quay hôm nay (+%dH)! Reset sau %02d:%02d (00:00)",currentSpin.BonusHours,h,m)
SpinResultBanner.TextColor3=c3(225,90,110)
return
end
isSpinningMutex=true
PlaySpringButton(TriggerSpinBtn)
local roll=math.random(1,100)
local targetIndex=1
if roll<=50 then
targetIndex=1
elseif roll<=80 then
targetIndex=2
elseif roll<=98 then
targetIndex=3
else
targetIndex=4
end
local wonSlice=WheelSlices[targetIndex]
SaveSpinResult(wonSlice.Hours,false)
local activeKeyLeft=GetKeyRemainingTime()
if activeKeyLeft and activeKeyLeft>0 then
Save24hKey(activeKeyLeft)
end
SpinGameBtn.Text=string.format(Languages[CurrentLang].MiniGameSpinLocked,wonSlice.Hours)
SpinGameBtn.TextColor3=c3(100,116,139)
SpinGameStroke.Color=c3(34,39,50)
TriggerSpinBtn.Text=Languages[CurrentLang].SpinningText
TriggerSpinBtn.BackgroundColor3=c3(45,52,68)
SpinResultBanner.Text="🎡 Vòng quay đang xoay..."
SpinResultBanner.TextColor3=c3(203,213,225)
WheelDisk.Rotation=0
local finalRotation=(360*6)+wonSlice.TargetAngle
local spinTween=TweenService:Create(
WheelDisk,
twi(3.2,EES.Quart,EED.Out),
{Rotation=finalRotation}
)
spinTween:Play()
spinTween.Completed:Wait()
wonSlice.Title.TextColor3=c3(110,231,183)
DiskStroke.Color=c3(74,222,128)
TriggerSpinBtn.Text=Languages[CurrentLang].SpinDoneText
TriggerSpinBtn.BackgroundColor3=c3(30,35,47)
TriggerSpinBtn.TextColor3=c3(148,163,184)
SpinResultBanner.Text=Languages[CurrentLang][wonSlice.MsgKey]
SpinResultBanner.TextColor3=c3(110,231,183)
StatusMsg.Text=string.format("🎁 Đã lưu +%d giờ vào hệ thống!",wonSlice.Hours)
StatusMsg.TextColor3=c3(110,231,183)
isSpinningMutex=false
end)
local function ExecuteBoxRoll(chosenBox,otherBox,chosenStroke,chosenMask,chosenTitle,chosenHint)
if isRollingMutex then return end
isRollingMutex=true
SaveGachaPlayed()
MiniGameBtn.Text=Languages[CurrentLang].MiniGameBoxLocked
MiniGameBtn.TextColor3=c3(100,116,139)
MiniGameStroke.Color=c3(34,39,50)
TweenService:Create(otherBox,twi(0.25,EES.Quad),{BackgroundTransparency=0.65}):Play()
otherBox.Active=false
chosenStroke.Color=c3(203,213,225)
chosenHint.Text=Languages[CurrentLang].OpeningBox
chosenHint.BackgroundColor3=c3(45,52,68)
GachaResultBanner.Text=Languages[CurrentLang].BoxBannerOpening
for i=1,6 do
local angle=(i % 2==0)and 5 or-5
TweenService:Create(chosenMask,twi(0.06,EES.Quad),{Rotation=angle}):Play()
task.wait(0.065)
end
TweenService:Create(chosenMask,twi(0.08,EES.Back),{Rotation=0}):Play()
task.wait(0.2)
local roll=math.random(1,100)
local isNoKeyWon=(roll<=5)
if isNoKeyWon then
chosenStroke.Color=c3(74,222,128)
chosenTitle.Text=Languages[CurrentLang].BoxWonTitle
chosenTitle.TextColor3=c3(110,231,183)
chosenHint.Text=Languages[CurrentLang].BoxWonBtn
chosenHint.BackgroundColor3=c3(22,163,74)
GachaResultBanner.Text=Languages[CurrentLang].BoxWonBanner
GachaResultBanner.TextColor3=c3(110,231,183)
Save24hKey(GetSecondsUntilMidnightGMT7())
task.wait(0.8)
UnlockAllJoinButtons()
RemoveScreenLockdown()
if MainScreenGui then MainScreenGui.Enabled=false end
if State.PendingFinderJoinLbl and executeRawHopToLeastPlayersServer then
local pending=State.PendingFinderJoinLbl
State.PendingFinderJoinLbl=nil
task.defer(function()
executeRawHopToLeastPlayersServer(pending)
end)
end
else
chosenStroke.Color=c3(190,35,68)
chosenTitle.Text=Languages[CurrentLang].BoxLostTitle
chosenTitle.TextColor3=c3(225,90,110)
chosenHint.Text=Languages[CurrentLang].BoxLostBtn
chosenHint.BackgroundColor3=c3(140,25,50)
GachaResultBanner.Text=Languages[CurrentLang].BoxLostBanner
GachaResultBanner.TextColor3=c3(225,90,110)
task.wait(1.4)
CloseGachaModal()
isRollingMutex=false
StatusMsg.Text="📌 Mở trúng GetKey! Bấm 'Lấy Key (24 Tiếng)' để tiếp tục."
StatusMsg.TextColor3=c3(203,213,225)
end
end
Box1.MouseButton1Click:Connect(function()
ExecuteBoxRoll(Box1,Box2,Box1Stroke,Box1Mask,Box1Title,Box1Hint)
end)
Box2.MouseButton1Click:Connect(function()
ExecuteBoxRoll(Box2,Box1,Box2Stroke,Box2Mask,Box2Title,Box2Hint)
end)
QuickPasteBtn.MouseButton1Click:Connect(function()
PlaySpringButton(QuickPasteBtn)
local pasted=false
pcall(function()
if getclipboard then
InputBox.Text=getclipboard()
pasted=true
elseif fromclipboard then
InputBox.Text=fromclipboard()
pasted=true
end
end)
if not pasted then
InputBox:CaptureFocus()
end
end)
local isTutorialDebounce=false
TutorialBtn.MouseButton1Click:Connect(function()
if isTutorialDebounce then return end
isTutorialDebounce=true
PlaySpringButton(TutorialBtn)
if setclipboard then setclipboard(TutorialUrl)elseif toclipboard then toclipboard(TutorialUrl)end
TutorialBtn.Text="✔ Đã chép link HD"
TutorialBtn.TextColor3=c3(110,231,183)
StatusMsg.Text=Languages[CurrentLang].CopiedTutorial
StatusMsg.TextColor3=c3(110,231,183)
task.delay(2.2,function()
if TutorialBtn and TutorialBtn.Parent then
TutorialBtn.Text=Languages[CurrentLang].Tutorial
TutorialBtn.TextColor3=c3(148,163,184)
StatusMsg.Text=Languages[CurrentLang].FooterText
StatusMsg.TextColor3=c3(100,116,139)
end
isTutorialDebounce=false
end)
end)
GetKeyBtn.MouseButton1Click:Connect(function()
PlaySpringButton(GetKeyBtn)
if setclipboard then setclipboard(KeyUrl)elseif toclipboard then toclipboard(KeyUrl)end
GetKeyBtn.Text="✔ Đã Chép Link (24H)"
GetKeyBtn.BackgroundColor3=c3(22,163,74)
StatusMsg.Text=Languages[CurrentLang].CopiedLink
StatusMsg.TextColor3=c3(110,231,183)
task.delay(2.2,function()
if GetKeyBtn and GetKeyBtn.Parent then
GetKeyBtn.Text=Languages[CurrentLang].GetKey
GetKeyBtn.BackgroundColor3=c3(190,35,68)
StatusMsg.Text=Languages[CurrentLang].FooterText
StatusMsg.TextColor3=c3(100,116,139)
end
end)
end)
local isChecking=false
CheckKeyBtn.MouseButton1Click:Connect(function()
if isChecking then return end
isChecking=true
task.spawn(function()
PlaySpringButton(CheckKeyBtn)
CheckKeyBtn.Text=Languages[CurrentLang].Checking
StatusMsg.Text=Languages[CurrentLang].CheckingMsg
StatusMsg.TextColor3=c3(203,213,225)
task.wait(0.25)
local isKeyValid=VerifyChilliV7Key(InputBox.Text)
if isKeyValid then
local bonusAdded=Save24hKey()
CheckKeyBtn.Text="✔ Thành Công"
CheckKeyBtn.BackgroundColor3=c3(22,163,74)
if bonusAdded and bonusAdded>0 then
StatusMsg.Text=string.format("✔ Kích hoạt Key! (24H + %dH = %d Giờ)",bonusAdded,24+bonusAdded)
else
StatusMsg.Text=Languages[CurrentLang].Success
end
StatusMsg.TextColor3=c3(110,231,183)
task.wait(0.4)
UnlockAllJoinButtons()
RemoveScreenLockdown()
if MainScreenGui then MainScreenGui.Enabled=false end
isChecking=false
CheckKeyBtn.Text=Languages[CurrentLang].CheckKey
CheckKeyBtn.BackgroundColor3=c3(24,28,38)
if State.PendingFinderJoinLbl and executeRawHopToLeastPlayersServer then
local pending=State.PendingFinderJoinLbl
State.PendingFinderJoinLbl=nil
task.defer(function()
executeRawHopToLeastPlayersServer(pending)
end)
end
else
isChecking=false
CheckKeyBtn.Text=Languages[CurrentLang].CheckKey
StatusMsg.Text=Languages[CurrentLang].Error
StatusMsg.TextColor3=c3(225,90,110)
InputStroke.Color=c3(190,35,68)
local origOffset=MainFrame.Position.X.Offset
for _,off in ipairs({-5,5,-3,3,0})do
local t=TweenService:Create(MainFrame,twi(0.04,EES.Quad),{
Position=u2(0.5,off,0.5,0)
})
t:Play()
t.Completed:Wait()
end
MainFrame.Position=u2(0.5,origOffset,0.5,0)
task.wait(0.4)
InputStroke.Color=c3(40,46,60)
end
end)
end)
OpenLangBtn.MouseButton1Click:Connect(function()
PlaySpringButton(OpenLangBtn)
CurrentLang=(CurrentLang=="VI")and "EN" or "VI"
local data=Languages[CurrentLang]
local sp=LoadSpinDataToday()
OpenLangBtn.Text=data.LangBtnText
TitleLabel.Text=data.Title
SubTitleLabel.Text=data.Subtitle
CenterTitle.Text=data.CenterTitle
CenterSub.Text=data.CenterSub
InputBox.PlaceholderText=data.Placeholder
QuickPasteBtn.Text=data.QuickPaste
GetKeyBtn.Text=data.GetKey
CheckKeyBtn.Text=data.CheckKey
TutorialBtn.Text=data.Tutorial
MiniGameBtn.Text=CanPlayGachaToday()and data.MiniGameBox or data.MiniGameBoxLocked
SpinGameBtn.Text=(not sp.Played)and data.MiniGameSpin or string.format(data.MiniGameSpinLocked,sp.BonusHours)
NoticeText.Text=data.Notice
StatusMsg.Text=data.FooterText
GachaHeader.Text=data.GachaTitle
GachaSubText.Text=data.GachaSub
Box1Tag.Text=data.Rate5050
Box2Tag.Text=data.Rate5050
Box1Title.Text=data.Box1Name
Box2Title.Text=data.Box2Name
Box1Hint.Text=data.OpenBoxBtn
Box2Hint.Text=data.OpenBoxBtn
GachaResultBanner.Text=data.BoxBannerIdle
SpinHeader.Text=data.SpinTitle
SpinSubText.Text=data.SpinSub
SpinFooterNote.Text=data.SpinNote
Title1.Text=data.Prize2H
Title2.Text=data.Prize3H
Title3.Text=data.Prize4H
Title4.Text=data.Prize12H
TriggerSpinBtn.Text=(not sp.Played)and data.SpinBtnText or data.SpinDoneText
end)
MainFrame.BackgroundTransparency=1
MainScale.Scale=0.88
TweenService:Create(MainFrame,twi(0.22,EES.Quad,EED.Out),{BackgroundTransparency=0}):Play()
TweenService:Create(MainScale,twi(0.26,EES.Back,EED.Out),{Scale=0.95}):Play()
end
end
local function extractFinderPetNameFromJoinBtn(joinLbl)
if not joinLbl or not joinLbl.Parent then return nil end
local row=joinLbl.Parent
for _=1,4 do
if not row or row:IsA("ScreenGui")or row:IsA("ScrollingFrame")or row==State.ActiveFinderWin then break end
if row:IsA("GuiObject")and row.AbsoluteSize.X>=180 and row.AbsoluteSize.Y>=24 and row.AbsoluteSize.Y<=135 then
break
end
row=row.Parent
end
if not row or not row:IsA("GuiObject")then return nil end
local bestName=nil
local bestSize=-1
for _,d in ipairs(row:GetDescendants())do
if d:IsA("TextLabel")and d~=joinLbl and d.Visible then
local t=stripRichTags(d.Text or ""):match("^%s*(.-)%s*$")
local low=t:lower()
if #t>=3
and low~="join" and low~="vào ngay"
and not low:find("⏳",1,true)
and not low:find("copy",1,true)
and not low:find("trước",1,true)
and not low:find(" ago",1,true)
and not low:find("chillihub",1,true)
and not t:match("^%d+%s*/%s*%d+$")then
local sz=d.TextSize or 12
if sz>bestSize then
bestSize=sz
bestName=t
end
end
end
end
return bestName
end
executeRawHopToLeastPlayersServer=function(joinLbl)
if State.JoiningLeastServerBusy and(os.clock()-(State.LastJoinHopClock or 0)<2.0)then return end
State.JoiningLeastServerBusy=true
State.LastJoinHopClock=os.clock()
playIslandSfx("action")
local petName=extractFinderPetNameFromJoinBtn(joinLbl)
local petDisplay=(petName and #petName>0)and petName or((State.Language=="EN")and "Rare Pet" or "Pet Hiếm")
local initMain=(State.Language=="EN")
and("Joining server with " .. petDisplay .. "...")
or("Đang vào máy chủ có " .. petDisplay .. "...")
local initSub=(State.Language=="EN")
and("Synchronizing server instance for " .. petDisplay .. "...")
or("Đang đồng bộ phòng chứa " .. petDisplay .. "...")
local transOverlay=showTeleportTransitionOverlay(initMain,initSub)
task.spawn(function()
local origTxt=(State.Language=="EN")and "Join" or "Vào ngay"
local sg=joinLbl and joinLbl:FindFirstAncestorOfClass("ScreenGui")
hideFinderSignInBox(sg)
if joinLbl and(joinLbl:IsA("TextLabel")or joinLbl:IsA("TextButton"))then
joinLbl:SetAttribute("__IsTranslating",true)
joinLbl:SetAttribute("__TranslatingFinderHud",true)
pcall(function()joinLbl.Text="⏳ Đang vào..." end)
end
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent then
pcall(function()
State.ActiveStatusLbl:SetAttribute("__Updating",true)
State.ActiveStatusLbl.Text="⚡ Đang vào server có " .. petDisplay .. "..."
State.ActiveStatusLbl:SetAttribute("__Updating",false)
end)
end
pcall(setupSafeTeleportHook)
local placeId=game.PlaceId
local candidates=fetchRobloxServers(placeId,"Asc")
if #candidates==0 then
table.clear(State.TriedServerIds)
candidates=fetchRobloxServers(placeId,"Asc")
end
if #candidates==0 then
candidates=fetchRobloxServers(placeId,"Desc")
end
table.sort(candidates,function(a,b)return a.playing<b.playing end)
local teleportSuccess=false
local maxAttempts=math.min(#candidates,8)
for attemptIdx=1,maxAttempts do
local srvObj=candidates[attemptIdx]
if not srvObj then break end
local targetServer=srvObj.id
State.TriedServerIds[targetServer]=true
local failed=false
local tpConn=nil
pcall(function()
tpConn=TeleportService.TeleportInitFailed:Connect(function(player,teleportResult,errorMessage)
if player==LocalPlayer then
failed=true
suppressTeleportErrorPrompt()
end
end)
end)
local hopMainTxt=(State.Language=="EN")
and("Teleporting to server with " .. petDisplay .. "...")
or("Đang dịch chuyển vào server có " .. petDisplay .. "...")
local hopSubTxt=(State.Language=="EN")
and("Verified " .. petDisplay .. " location • Joining room...")
or("Đã xác thực vị trí " .. petDisplay .. " • Đang kết nối vào phòng...")
transOverlay.update(hopMainTxt,hopSubTxt,false)
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent then
pcall(function()
State.ActiveStatusLbl:SetAttribute("__Updating",true)
State.ActiveStatusLbl.Text="⚡ Đang kết nối tới " .. petDisplay .. "..."
State.ActiveStatusLbl:SetAttribute("__Updating",false)
end)
end
local okTp,errTp=pcall(function()
TeleportService:TeleportToPlaceInstance(placeId,targetServer,LocalPlayer)
end)
if not okTp then
failed=true
suppressTeleportErrorPrompt()
else
local startWait=os.clock()
while(os.clock()-startWait<1.6)and not failed do
task.wait(0.12)
suppressTeleportErrorPrompt()
end
end
if tpConn then pcall(function()tpConn:Disconnect()end)end
if not failed then
teleportSuccess=true
break
else
suppressTeleportErrorPrompt()
local warnMain=(State.Language=="EN")
and("Server with " .. petDisplay .. " is full (772)")
or("Máy chủ chứa " .. petDisplay .. " vừa đầy (772)")
local warnSub=(State.Language=="EN")
and("Switching to next server with " .. petDisplay .. "...")
or("Đang chuyển sang máy chủ tiếp theo có " .. petDisplay .. "...")
transOverlay.update(warnMain,warnSub,true)
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent then
pcall(function()
State.ActiveStatusLbl:SetAttribute("__Updating",true)
State.ActiveStatusLbl.Text="⚡ Phòng đầy (772), đang vào phòng khác có " .. petDisplay .. "..."
State.ActiveStatusLbl:SetAttribute("__Updating",false)
end)
end
task.wait(0.20)
end
end
if not teleportSuccess then
suppressTeleportErrorPrompt()
pcall(function()
if State.ActiveVenyxGui and State.ActiveVenyxGui.Parent then
for _,d in ipairs(State.ActiveVenyxGui:GetDescendants())do
if d:IsA("TextButton")or d:IsA("TextLabel")then
local ot=(d:GetAttribute("OrigRawText")or d.Text or ""):match("^%s*(.-)%s*$")
if ot=="Hop" or ot=="Hop server" or d.Text=="Đổi ngay" or d.Text=="Đổi máy chủ" then
pcall(fireBtn,d)
break
end
end
end
end
end)
end
task.wait(1.5)
if joinLbl and joinLbl.Parent then
pcall(function()joinLbl.Text=origTxt end)
joinLbl:SetAttribute("__TranslatingFinderHud",false)
joinLbl:SetAttribute("__IsTranslating",false)
end
transOverlay.destroy()
State.JoiningLeastServerBusy=false
end)
end
hopToLeastPlayersServer=function(joinLbl)
local keyLeft=GetKeyRemainingTime()
if not keyLeft or keyLeft<=0 then
State.PendingFinderJoinLbl=joinLbl
playIslandSfx("tap")
ApplyScreenLockdown()
if OpenKeySystemUI then
OpenKeySystemUI()
end
return
end
executeRawHopToLeastPlayersServer(joinLbl)
end
local function isFinderJoinLabel(inst)
if not inst or not inst.Parent then return false end
if inst.Name=="ChilliFinderJoinInterceptor" then return false end
if inst:FindFirstAncestor("ChilliV5_ExpandedIsland")or inst:FindFirstAncestor("ChilliHeaderOverlay")then return false end
local txtObj=inst
if not(inst:IsA("TextButton")or inst:IsA("TextLabel"))then
local c=inst:FindFirstChildWhichIsA("TextLabel")or inst:FindFirstChildWhichIsA("TextButton")
if c then txtObj=c else return false end
end
local rawT=stripRichTags(txtObj:GetAttribute("OrigFinderStateText")or txtObj:GetAttribute("OrigRawText")or txtObj.Text or ""):lower()
local curT=stripRichTags(txtObj.Text or ""):lower()
local conT=""
pcall(function()conT=stripRichTags(txtObj.ContentText or ""):lower()end)
if rawT:find("copy",1,true)or curT:find("copy",1,true)or curT:find("copied",1,true)or rawT:find("force",1,true)or curT:find("force",1,true)or rawT:find("sign",1,true)or curT:find("sign",1,true)or curT:find("đăng ký",1,true)or rawT:find("discord",1,true)or rawT:find("server",1,true)then
return false
end
return(rawT=="join" or curT=="join" or conT=="join" or curT=="vào ngay" or rawT=="vào ngay" or curT:find("⏳ đang vào",1,true)~=nil)
end
hookChilliFinderJoin=function(inst)
if not isFinderJoinLabel(inst)then return end
local alreadyTracked=false
for _,b in ipairs(State.TrackedFinderJoinBtns)do
if b==inst then alreadyTracked=true break end
end
if not alreadyTracked then
table.insert(State.TrackedFinderJoinBtns,inst)
end
if inst:GetAttribute("__FinderJoinHooked")==SID then return end
inst:SetAttribute("__FinderJoinHooked",SID)
local btnRoot=inst
if inst.Parent and inst.Parent:IsA("GuiObject")and inst.Parent~=State.ActiveFinderWin then
btnRoot=inst.Parent
end
local targets={inst,btnRoot}
local p2=btnRoot.Parent
if p2 and p2:IsA("GuiObject")and p2~=State.ActiveFinderWin and p2.AbsoluteSize.X<=220 and p2.AbsoluteSize.Y<=95 then
table.insert(targets,p2)
end
for _,d in ipairs(btnRoot:GetDescendants())do
if d:IsA("GuiObject")and d.Name~="ChilliFinderJoinInterceptor" then
table.insert(targets,d)
end
end
for _,tObj in ipairs(targets)do
pcall(function()tObj.Active=true end)
if getconnections and(tObj:IsA("TextButton")or tObj:IsA("ImageButton"))then
for _,sigName in ipairs({"MouseButton1Click","Activated"})do
pcall(function()
local sig=tObj[sigName]
if sig then
for _,conn in ipairs(getconnections(sig))do
if conn.Function and conn.Disable then pcall(conn.Disable,conn)end
end
end
end)
end
end
if tObj:IsA("TextButton")or tObj:IsA("ImageButton")then
tObj.MouseButton1Click:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
tObj.Activated:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
tObj.MouseButton1Down:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
end
if tObj:IsA("GuiObject")then
tObj.InputBegan:Connect(function(inp)
if not isAlive()then return end
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
hopToLeastPlayersServer(inst)
end
end)
end
end
local interceptor=btnRoot:FindFirstChild("ChilliFinderJoinInterceptor")
if not interceptor then
interceptor=mk("TextButton",{
Name="ChilliFinderJoinInterceptor",
Size=u2s(1,1),
Position=u2s(0,0),
BackgroundTransparency=1,
Text="",
AutoButtonColor=false,
Active=true,
ZIndex=math.max((inst.ZIndex or 1)+50,99999)
},btnRoot)
end
if interceptor:GetAttribute("__InterceptorHooked")~=SID then
interceptor:SetAttribute("__InterceptorHooked",SID)
interceptor.MouseButton1Click:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
interceptor.Activated:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
interceptor.MouseButton1Down:Connect(function()
if isAlive()then hopToLeastPlayersServer(inst)end
end)
interceptor.InputBegan:Connect(function(inp)
if not isAlive()then return end
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
hopToLeastPlayersServer(inst)
end
end)
end
end
local function translateSingleFinderSegment(seg)
if type(seg)~="string" or seg=="" then return seg end
local lead,body,trail=seg:match("^(%s*)(.-)(%s*)$")
if not body or body=="" then return seg end
local low=body:lower()
if body:find("⏳",1,true)then
return seg
end
if FINDER_STATE_MAP[low] then
return lead .. FINDER_STATE_MAP[low] .. trail
end
if low:find("chillihub.pro",1,true)or low:find("no active booking",1,true)or low:find("sign in with your",1,true)or low:find("top 5 recent eggs",1,true)then
return lead .. "Top 5 trứng mới nhất | Chilli Finder Free" .. trail
end
local secOnly=body:match("^(%d+)s$")
if secOnly then
return lead .. secOnly .. " giây" .. trail
end
local finderSuffix=body:match("^[Ff][Ii][Nn][Dd][Ee][Rr]%s*([%(%[:%-|].*)$")
if finderSuffix then
local sfx=finderSuffix:gsub("[Oo][Nn]","BẬT"):gsub("[Oo][Ff][Ff]","TẮT")
return lead .. "Tìm Trứng " .. sfx .. trail
end
local autoTimer=body:match("^[Aa][Uu][Tt][Oo]%s*([%(%[].-[%)%]])$")or body:match("^[Aa][Uu][Tt][Oo]%s*:%s*(.+)$")
if autoTimer then
local subLow=autoTimer:lower()
if subLow=="off" then return lead .. "TỰ ĐỘNG: TẮT" .. trail end
if subLow=="on" then return lead .. "TỰ ĐỘNG: BẬT" .. trail end
return lead .. "TỰ ĐỘNG: " .. autoTimer .. trail
end
local forceTimer=body:match("^[Ff][Oo][Rr][Cc][Ee]%s+[Jj][Oo][Ii][Nn]%s*[:%s]%s*(.+)$")
if not forceTimer and(low=="force join" or low=="force join:")then forceTimer="" end
if forceTimer~=nil then
if forceTimer=="" then return lead .. "TỰ VÀO SAU" .. trail end
local sNum=forceTimer:match("^(%d+)%s*[Ss]$")
if sNum then return lead .. "TỰ VÀO SAU " .. sNum .. " giây" .. trail end
local fLow=forceTimer:lower()
return lead .. "TỰ VÀO SAU " ..(FINDER_STATE_MAP[fLow] or forceTimer).. trail
end
local minVal=body:match("^[Mm][Ii][Nn]%s+[Vv][Aa][Ll][Uu][Ee]%s*[:%s]%s*(.+)$")
if not minVal and(low=="min value" or low=="min value:")then minVal="" end
if minVal~=nil then
if minVal=="" then return lead .. "GIÁ TỐI THIỂU" .. trail end
local mLow=minVal:lower()
return lead .. "GIÁ TỐI THIỂU " ..(FINDER_STATE_MAP[mLow] or minVal).. trail
end
local rarVal=body:match("^[Rr][Aa][Rr][Ii][Tt][Yy]%s*[:%s]%s*(.+)$")
if not rarVal and(low=="rarity" or low=="rarity:")then rarVal="" end
if rarVal~=nil then
if rarVal=="" then return lead .. "ĐỘ HIẾM" .. trail end
local rLow=rarVal:lower()
return lead .. "ĐỘ HIẾM " ..(FINDER_STATE_MAP[rLow] or rarVal).. trail
end
local accVal=body:match("^[Aa][Cc][Cc][Oo][Uu][Nn][Tt]%s*[:%s]%s*(.+)$")
if not accVal and(low=="account" or low=="account:")then accVal="" end
if accVal~=nil then
if accVal=="" then return lead .. "TÀI KHOẢN" .. trail end
local aLow=accVal:lower()
return lead .. "TÀI KHOẢN " ..(FINDER_STATE_MAP[aLow] or accVal).. trail
end
if body:find(" ago",1,true)or low:find("just now",1,true)then
local rep=body
rep=rep:gsub("(%d+)%s*s%s+ago","%1s trước")
rep=rep:gsub("(%d+)%s*m%s+ago","%1p trước")
rep=rep:gsub("(%d+)%s*h%s+ago","%1g trước")
rep=rep:gsub("(%d+)%s*d%s+ago","%1n trước")
rep=rep:gsub("[Jj]ust now","vừa xong")
return lead .. rep .. trail
end
if EXACT_VI[body] then
return lead .. EXACT_VI[body] .. trail
end
return seg
end
translateFinderHudState=function(txt)
if type(txt)~="string" or txt=="" then return txt end
if State.Language=="EN" then return txt end
if txt:find("<[^>]+>")then
local res=txt:gsub("([^<>]+)",function(chunk)
if chunk:find("\n")then
local parts={}
for line in(chunk .. "\n"):gmatch("(.-)\n")do
table.insert(parts,translateSingleFinderSegment(line))
end
return table.concat(parts,"\n")
end
return translateSingleFinderSegment(chunk)
end)
return res
end
if txt:find("\n")then
local parts={}
for line in(txt .. "\n"):gmatch("(.-)\n")do
table.insert(parts,translateSingleFinderSegment(line))
end
return table.concat(parts,"\n")
end
return translateSingleFinderSegment(txt)
end
watchFinderHudButton=function(lbl)
if not lbl or not(lbl:IsA("TextLabel")or lbl:IsA("TextButton"))then return end
if lbl.Name=="ChilliFinderJoinInterceptor" or lbl:FindFirstAncestor("ChilliV5_ExpandedIsland")or lbl:FindFirstAncestor("ChilliHeaderOverlay")then return end
local raw=stripRichTags(lbl:GetAttribute("OrigFinderStateText")or lbl.Text or "")
if raw=="" or raw:find("⏳",1,true)then return end
local low=raw:lower()
local isKnownFinderTxt=(FINDER_STATE_MAP[low]~=nil or raw:find(" ago",1,true)~=nil or raw:find("trước",1,true)~=nil or low:find("finder",1,true)~=nil or low:find("chillihub.pro",1,true)~=nil)
if not isKnownFinderTxt and not lbl:GetAttribute("__IsFinderHudElement")then
return
end
local inFinder=lbl:GetAttribute("__IsFinderHudElement")or isInsideChilliFinder(lbl)
local isHudFinderBtn=(low=="finder" or low=="tìm trứng" or low:find("finder",1,true))
if not inFinder and not isHudFinderBtn then return end
lbl:SetAttribute("__IsFinderHudElement",true)
local function updateText()
if lbl:GetAttribute("__TranslatingFinderHud")or lbl:GetAttribute("__ModifyingFinderText")then return end
local cur=lbl.Text or ""
if cur=="" then return end
local stripped=stripRichTags(cur)
if stripped:find("⏳",1,true)then return end
if cur~=lbl:GetAttribute("__LastFinderTranslated")and not hasVi(stripped)then
lbl:SetAttribute("OrigFinderStateText",cur)
end
local baseTxt=lbl:GetAttribute("OrigFinderStateText")or cur
local targetTxt=(State.Language=="EN")and baseTxt or translateFinderHudState(baseTxt)
if targetTxt and targetTxt~="" and targetTxt~=cur then
lbl:SetAttribute("__TranslatingFinderHud",true)
lbl:SetAttribute("__IsTranslating",true)
lbl:SetAttribute("__LastFinderTranslated",targetTxt)
pcall(function()lbl.Text=targetTxt end)
lbl:SetAttribute("__IsTranslating",false)
lbl:SetAttribute("__TranslatingFinderHud",false)
end
end
updateText()
if lbl:GetAttribute("__FinderHudWatched")~=SID then
lbl:SetAttribute("__FinderHudWatched",SID)
table.insert(State.TrackedTexts,lbl)
lbl:GetPropertyChangedSignal("Text"):Connect(function()
if isAlive()then
pcall(sanitizeChillFinderFreeObj,lbl)
updateText()
end
end)
if(low=="finder" or low=="tìm trứng")and not isInsideChilliFinder(lbl)then
local clickTarget=(lbl:IsA("TextButton")or lbl:IsA("ImageButton"))and lbl or lbl:FindFirstAncestorWhichIsA("GuiButton")or lbl.Parent
if clickTarget and clickTarget:IsA("GuiObject")and not clickTarget:GetAttribute("__FinderBtnCycleHooked")then
clickTarget:SetAttribute("__FinderBtnCycleHooked",true)
local FINDER_HUD_CYCLE={
{text="Tìm Trứng",color=c3(255,185,35)},
{text="Đang săn trứng",color=c3(45,215,135)},
{text="Đang quét...",color=c3(65,165,255)},
{text="Đang rảnh",color=c3(185,115,255)}
}
local hudCycleIdx=1
local function onHudFinderClick()
playIslandSfx("tap")
hudCycleIdx=(hudCycleIdx % #FINDER_HUD_CYCLE)+1
local st=FINDER_HUD_CYCLE[hudCycleIdx]
lbl:SetAttribute("__TranslatingFinderHud",true)
lbl:SetAttribute("__IsTranslating",true)
lbl:SetAttribute("__LastFinderTranslated",st.text)
pcall(function()lbl.Text=st.text end)
lbl:SetAttribute("__IsTranslating",false)
lbl:SetAttribute("__TranslatingFinderHud",false)
pcall(function()
TweenService:Create(clickTarget,twi(0.22,EES.Quart,EED.Out),{BackgroundColor3=st.color}):Play()
end)
if scanChilliFinderButtons then
task.delay(0.20,scanChilliFinderButtons)
end
end
if clickTarget:IsA("GuiButton")then
clickTarget.MouseButton1Click:Connect(onHudFinderClick)
else
clickTarget.InputBegan:Connect(function(inp)
if inp.UserInputType==EUIT.MouseButton1 or inp.UserInputType==EUIT.Touch then
onHudFinderClick()
end
end)
end
end
end
end
end
watchFinderTextObj=function(d)
if not d or not(d:IsA("TextButton")or d:IsA("TextLabel"))then return end
if d.Name=="ChilliFinderJoinInterceptor" then return end
if State.ActiveMainWin and d:IsDescendantOf(State.ActiveMainWin)then return end
pcall(sanitizeChillFinderFreeObj,d)
pcall(watchFinderHudButton,d)
local checkT=stripRichTags(d.Text):lower()
if checkT=="sign up" or checkT=="sign in" or checkT:find("sign in with your",1,true)or checkT=="password" then
pcall(hideFinderSignInBox,d)
end
if isFinderJoinLabel(d)then
pcall(hookChilliFinderJoin,d)
end
if d:GetAttribute("__FinderTxtWatched")~=SID then
d:SetAttribute("__FinderTxtWatched",SID)
d:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive()then return end
pcall(sanitizeChillFinderFreeObj,d)
pcall(watchFinderHudButton,d)
if isFinderJoinLabel(d)then
pcall(hookChilliFinderJoin,d)
end
end)
end
end
local ROBLOX_CORE_SUBFOLDERS={
TouchGui=true,BackpackGui=true,PlayerList=true,Chat=true,BubbleChat=true,
ExperienceChat=true,InGameMenu=true,TopBarApp=true,PurchasePrompt=true,
Freecam=true,TeleportGui=true,RobloxNetworkPauseNotification=true,
CoreScriptsRootProvider=true,SettingsClippingShield=true,ChilliV7_GetKeyUI=true,ChilliV7_InputBlocker=true
}
local function instantStyleFinder(win)
if not win or not win.Parent then return end
State.ActiveFinderWin=win
win:SetAttribute("__IsChilliFinderContainer",true)
hideFinderSignInBox(win)
local wCorner=win:FindFirstChildOfClass("UICorner")or mk("UICorner",{CornerRadius=UDim.new(0,10)},win)
local rb=win:FindFirstChild("ChillFinderRainbowBorder")
if not rb then
rb=mk("UIStroke",{
Name="ChillFinderRainbowBorder",
Thickness=2.8,
Color=Color3.new(1,1,1),
ApplyStrokeMode=EASM.Border,
Transparency=0
},win)
local bgGrad=mk("UIGradient",{Name="BorderNeonGrad",Color=FINDER_BORDER_NEON_GRAD},rb)
addGrad(bgGrad)
else
rb.Thickness=2.8
rb.Transparency=0
rb.Enabled=true
end
if win:GetAttribute("__FinderVisHooked")~=SID then
win:SetAttribute("__FinderVisHooked",SID)
win:GetPropertyChangedSignal("Visible"):Connect(function()
if isAlive()and win.Visible then
task.defer(function()
if isAlive()and win and win.Parent then
instantStyleFinder(win)
end
end)
end
end)
end
for _,d in ipairs(win:GetDescendants())do
if d:IsA("TextLabel")or d:IsA("TextButton")or d:IsA("TextBox")then
watchFinderTextObj(d)
end
end
end
local function findAndStyleFinderNow()
if State.ActiveFinderWin and State.ActiveFinderWin.Parent then
instantStyleFinder(State.ActiveFinderWin)
return true
end
local pg=LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
for _,root in ipairs(getScanRoots())do
if root~=pg then
for _,ch in ipairs(root:GetChildren())do
if ch.Name=="RobloxGui" then
for _,sub in ipairs(ch:GetChildren())do
if not ROBLOX_CORE_SUBFOLDERS[sub.Name] then
for _,d in ipairs(sub:GetDescendants())do
if d:IsA("TextLabel")and(d.Text=="Chilli Finder" or d.Text=="Chilli Finder Free" or d.Text:find("Top 5",1,true))then
local win=getFinderWindowFromObj(d)
if win then
instantStyleFinder(win)
return true
end
end
end
end
end
elseif not ROBLOX_CORE_SUBFOLDERS[ch.Name] then
for _,d in ipairs(ch:GetDescendants())do
if d:IsA("TextLabel")and(d.Text=="Chilli Finder" or d.Text=="Chilli Finder Free" or d.Text:find("Top 5",1,true))then
local win=getFinderWindowFromObj(d)
if win then
instantStyleFinder(win)
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
scanChilliFinderButtons=function()
if State.ActiveFinderWin and State.ActiveFinderWin.Parent then
instantStyleFinder(State.ActiveFinderWin)
return
end
findAndStyleFinderNow()
end
local function bindGuiEvents(gui)
if not gui or ROBLOX_CORE_SUBFOLDERS[gui.Name] or gui:GetAttribute("__ListenerSession")==SID then return end
gui:SetAttribute("__ListenerSession",SID)
gui.DescendantAdded:Connect(function(nd)
if not isAlive()then return end
if nd:FindFirstAncestor("Chat")or nd:FindFirstAncestor("TouchGui")or nd:FindFirstAncestor("InGameMenu")or nd:FindFirstAncestor("PlayerList")then return end
if nd:IsA("TextLabel")or nd:IsA("TextButton")or nd:IsA("TextBox")then
if not nd:IsA("TextBox")then
local rawT=(nd.Text or ""):match("^%s*(.-)%s*$")
if rawT=="Vx" or rawT=="VX" then
nd:SetAttribute("__HiddenVxLogo",true)
nd.TextTransparency=1
return
elseif rawT=="VENYX" and not nd:FindFirstAncestorOfClass("ScrollingFrame")then
nd:SetAttribute("__IsTranslating",true)
nd.Text=NEW_TITLE
nd:SetAttribute("__IsTranslating",false)
end
end
task.defer(function()
if not isAlive()or not nd or not nd.Parent then return end
if nd:IsA("TextButton")or nd:IsA("TextLabel")then
pcall(watchFinderTextObj,nd)
end
if not nd:IsA("TextBox")and isFpsTxt(nd.Text)then
pcall(hookFps,nd)
else
if nd:IsA("TextLabel")and State.ActiveVenyxGui and not State.ActiveVenyxGui:GetAttribute("__IslandLocked")and not nd:FindFirstAncestorOfClass("ScrollingFrame")then
local nt=(nd.Text or ""):lower()
if nt:find("idle",1,true)or(nd.Text or ""):find("Đang rảnh",1,true)then
local okI,resI=pcall(setupIsland,nd,State.ActiveVenyxGui)
if okI and resI then
State.ActiveVenyxGui:SetAttribute("__IslandLocked",true)
return
end
end
end
pcall(hookTrans,nd)
end
end)
end
end)
end
local function scanOnce(forcePass)
if not isAlive()then return false end
for _,root in ipairs(getScanRoots())do
local guis={}
if root:IsA("ScreenGui")and not ROBLOX_CORE_SUBFOLDERS[root.Name] then
table.insert(guis,root)
end
for _,ch in ipairs(root:GetChildren())do
if ch.Name=="RobloxGui" then
bindGuiEvents(ch)
for _,sub in ipairs(ch:GetChildren())do
if not ROBLOX_CORE_SUBFOLDERS[sub.Name] and(sub:IsA("ScreenGui")or sub:IsA("GuiObject")or sub:IsA("Folder"))then
table.insert(guis,sub)
end
end
elseif ch:IsA("ScreenGui")and not ROBLOX_CORE_SUBFOLDERS[ch.Name] then
table.insert(guis,ch)
elseif ch:IsA("Folder")or ch:IsA("Configuration")then
for _,sub in ipairs(ch:GetChildren())do
if sub:IsA("ScreenGui")and not ROBLOX_CORE_SUBFOLDERS[sub.Name] then
table.insert(guis,sub)
end
end
end
end
for _,gui in ipairs(guis)do
bindGuiEvents(gui)
if gui:GetAttribute("__ChilliV8Patched")~=SID or forcePass then
local titleLbl=nil
for _,d in ipairs(gui:GetDescendants())do
if(d:IsA("TextLabel")or d:IsA("TextButton"))and d.Name~="ChilliUltraTitleBadge" and d.Name~="ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland")and not d:FindFirstAncestor("ChilliHeaderOverlay")then
local t=(d.Text or ""):match("^%s*(.-)%s*$")
if t=="Vx" or t=="VX" then
d:SetAttribute("__HiddenVxLogo",true)
d.TextTransparency=1
elseif isFpsTxt(t)then
pcall(hookFps,d)
elseif(t=="VENYX" or t==NEW_TITLE or t=="Chilli Hub Ultra" or t=="Chilli Hub V5" or t=="Chilli V5 |")and not d:FindFirstAncestorOfClass("ScrollingFrame")then
titleLbl=d
end
local low=t:lower()
if low=="finder" or low=="tìm trứng" then
pcall(watchFinderHudButton,d)
end
end
end
if titleLbl then
local okDone,fullyPatched=pcall(patchVenyxGui,gui,titleLbl)
if okDone and fullyPatched then
venyxGuiLocked=gui
gui:SetAttribute("__ChilliV8Patched",SID)
end
end
end
end
end
return venyxGuiLocked~=nil
end
State.ScanOnceFn=scanOnce
for _,root in ipairs(getScanRoots())do
root.ChildAdded:Connect(function(ch)
if not isAlive()then return end
if not ROBLOX_CORE_SUBFOLDERS[ch.Name] then
bindGuiEvents(ch)
task.defer(function()
if isAlive()then
pcall(scanOnce,false)
pcall(scanChilliFinderButtons)
end
end)
end
end)
end
task.defer(function()
if isAlive()then
pcall(scanOnce,true)
pcall(scanChilliFinderButtons)
end
end)
local function tryBootPass(attempt)
if not isAlive()then return end
if not venyxGuiLocked then
if attempt==14 or attempt==28 then
env.__VenyxLaunchingNow=false
pcall(launchVenyxBase)
end
pcall(scanOnce,false)
pcall(findAndStyleFinderNow)
if not venyxGuiLocked and attempt<45 then
task.delay(0.25,function()
tryBootPass(attempt+1)
end)
end
else
pcall(findAndStyleFinderNow)
end
end
task.defer(function()
tryBootPass(1)
end)
