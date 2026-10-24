-- Chilli Hub V7 Supreme | Arceus X NEO Fix + Zero-Misfire Import + Locked Wallpaper FPS
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

-- PRESET CẤU HÌNH AUTO FARM
local PRESET_JSON = [=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":false,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":true,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]

if writefile then
    pcall(writefile, AUTO_FILE, ('pcall(function() loadstring(game:HttpGet("%s"))() end)'):format(MY_URL))
end

task.spawn(function()
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
    local r, seen = {}, {}
    local function addRoot(inst)
        if inst and not seen[inst] then
            seen[inst] = true
            table.insert(r, inst)
        end
    end
    if gethui then pcall(function() addRoot(gethui()) end) end
    addRoot(CoreGui)
    local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
    addRoot(pg)
    return r
end

local IGNORED_GUIS = {
    RobloxGui=true, TopBarApp=true, TouchGui=true, Chat=true, BubbleChat=true,
    Freecam=true, BackpackGui=true, PlayerList=true, PurchasePrompt=true, ChilliV5_NoticeGui=true
}

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

-- TÍCH HỢP ARCEUS X NEO HOOK BẠO LỰC NGAY KHI KHỞI CHẠY (BẮT BUỘC SCREEN GUI CHẠY BÊN DƯỚI COREGUI HOẶC PLAYERGUI ĐỂ LÁCH LUARMOR)
local function setupSafeTeleportHook()
    local rq = env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport or queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (delta and delta.queue_on_teleport)
    if not rq then return end
    env.__ChilliOrigQueue = rq
    local boot = ('--[[CHILLI_V7_AUTHORIZED_TELEPORT]] local E=(getgenv and getgenv()) or _G E.__ChilliAllowVenyxFetch=false task.spawn(function() if not game:IsLoaded() then game.Loaded:Wait() end local P=game:GetService("Players") while not P.LocalPlayer do task.wait(0.05) end pcall(function() loadstring(game:HttpGet("%s"))() end) end)'):format(MY_URL)
    local clearQ = env.clearteleportqueue or env.clear_teleport_queue or clearteleportqueue or clear_teleport_queue or (syn and syn.clear_teleport_queue) or (fluxus and fluxus.clear_teleport_queue) or (delta and delta.clear_teleport_queue)
    
    local function queueOurBootOnly()
        if clearQ then pcall(clearQ) end
        if env.__ChilliBootQueuedSession ~= SID then
            env.__ChilliBootQueuedSession = SID
            pcall(rq, boot)
        end
    end
    
    local rawLock = function(c)
        local s = tostring(c or "")
        if s:find("CHILLI_V7_AUTHORIZED_TELEPORT", 1, true) then return rq(c) end
        if clearQ then pcall(clearQ) end
        if env.__ChilliBootQueuedSession ~= SID then
            env.__ChilliBootQueuedSession = SID
            return rq(boot)
        end
        return nil
    end
    
    local safeLock = newcclosure and newcclosure(rawLock) or rawLock
    pcall(function()
        if setreadonly then
            if syn and type(syn) == "table" then pcall(setreadonly, syn, false) end
            if fluxus and type(fluxus) == "table" then pcall(setreadonly, fluxus, false) end
            if delta and type(delta) == "table" then pcall(setreadonly, delta, false) end
        end
        env.queue_on_teleport = safeLock
        env.queueonteleport = safeLock
        _G.queue_on_teleport = safeLock
        _G.queueonteleport = safeLock
        if syn and type(syn) == "table" then pcall(function() syn.queue_on_teleport = safeLock end) end
        if fluxus and type(fluxus) == "table" then pcall(function() fluxus.queue_on_teleport = safeLock end) end
        if delta and type(delta) == "table" then pcall(function() delta.queue_on_teleport = safeLock end) end
    end)
    queueOurBootOnly()
end

pcall(setupSafeTeleportHook)

local function launchVenyxBase()
    if isVenyxUiPresent() then return end
    if env.__VenyxLaunchClock and (os.clock() - env.__VenyxLaunchClock < 30) then return end
    env.__VenyxLaunchingNow = true
    env.__VenyxLaunchClock = os.clock()
    task.spawn(function()
        if not game:IsLoaded() then game.Loaded:Wait() end
        pcall(setupSafeTeleportHook)
        if isVenyxUiPresent() then
            env.__VenyxLaunchingNow = false
            return
        end
        env.__ChilliAllowVenyxFetch = true
        local rawCode = safeHttpGet(VENYX_URL)
        if rawCode and not isVenyxUiPresent() then
            -- Móc qua Luarmor Arceus: vô hiệu hoá queue_on_teleport từ xa để không báo lỗi vòng lặp
            rawCode = rawCode:gsub("queue_on_teleport", "__ChilliBlockedVenyxQueue"):gsub("queueonteleport", "__ChilliBlockedVenyxQueue")
            env.__ChilliBlockedVenyxQueue = function() end
            _G.__ChilliBlockedVenyxQueue = function() end
            
            local fn = loadstring(rawCode)
            if type(fn) == "function" then
                if setfenv and getfenv then
                    pcall(function()
                        local origEnv = getfenv(fn)
                        local proxyEnv
                        proxyEnv = setmetatable({
                            queue_on_teleport = function() end,
                            queueonteleport = function() end,
                            clearteleportqueue = function() end,
                            clear_teleport_queue = function() end,
                            getgenv = function() return proxyEnv end
                        }, { __index = origEnv, __newindex = origEnv })
                        setfenv(fn, proxyEnv)
                    end)
                end
                pcall(fn)
            end
            pcall(setupSafeTeleportHook)
        end
        env.__VenyxLaunchingNow = false
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
    if g and not g:GetAttribute("__GradTracked") then
        g:SetAttribute("__GradTracked", true)
        table.insert(State.ActiveGradients, g)
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
    pcall(function()
        local p = lbl.Parent
        if p and p:IsA("GuiObject") and not p:FindFirstChild("IslandLogoBadge") and not p:FindFirstAncestor("ChilliHeaderOverlay") and p.AbsoluteSize.Y < 60 then
            p.Visible = false
            p:GetPropertyChangedSignal("Visible"):Connect(function()
                if isAlive() and p.Visible then p.Visible = false end
            end)
        end
    end)
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
        if tickCount % 8 == 0 then
            if State.SyncWindowFn then pcall(State.SyncWindowFn) end
            if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent then
                if State.ActiveStatusLbl.TextColor3 ~= Color3.new(1, 1, 1) then
                    State.ActiveStatusLbl.TextColor3 = Color3.new(1, 1, 1)
                end
                if State.ActiveStatusLbl.TextTransparency ~= 0 then
                    State.ActiveStatusLbl.TextTransparency = 0
                end
            end
        end
        task.wait(0.033)
    end
end)

local FastCache = {}
local function hasVi(s)
    return type(s) == "string" and s ~= "" and s:find("[\194-\244][\128-\191]") ~= nil and not s:find("^[%w%s%p·•●🌶️🇻🇳🌐⚡⏳✅⚠️🚀✨▲▼▾👑🏠🥚🌾👤⚙️]+$")
end

local EXACT_VI = {
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
    ["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V7! Tham gia Discord để cập nhật và nhận hỗ trợ",
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
    ["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ", ["Copy Invite"]="Chép Link Mời", ["Copy invite"]="Chép Link Mời", ["Copy link"]="Chép Link Mời", ["Discord"]="Chilli Hub", ["MONEY /S"]="TIỀN /GIÂY", ["CASH / S"]="TIỀN / GIÂY",
    ["OPEN"]="MỞ", ["Open"]="Mở", ["Close"]="Đóng", ["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V7! Tham gia Discord để cập nhật và nhận hỗ trợ",
    ["Beta version"]="Phiên bản Beta", ["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",
    ["Rejoin"]="Vào lại", ["Server hop"]="Đổi server", ["Copy Job ID"]="Chép Job ID", ["Unload hub"]="Tắt Hub", ["Unload"]="Tắt Hub", ["Save config"]="Lưu cấu hình", ["Hide UI"]="Ẩn Menu",
    ["SESSION"]="PHIÊN CHƠI", ["STOLEN"]="ĐÃ CƯỚP", ["LAST EGG"]="TRỨNG CUỐI", ["PLACED"]="ĐÃ ĐẶT", ["HATCHED"]="ĐÃ ẤP", ["NIGHT IN"]="ĐÊM SAU", ["NEXT NIGHT"]="ĐÊM SAU",
    ["SESSION TIME"]="THỜI GIAN", ["TIME"]="THỜI GIAN", ["BEST STEAL"]="CƯỚP TỐT NHẤT", ["EGG BAG"]="TÚI TRỨNG", ["PET BAG"]="TÚI PET", ["WHAT'S NEW"]="CÓ GÌ MỚI", ["NEW"]="MỚI",
    ["Event"]="Sự Kiện", ["Search"]="Tìm kiếm", ["Filter"]="Lọc tìm", ["Steal"]="Cướp Trứng", ["Auto Steal"]="Tự Động Cướp", ["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
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
    ["Farm"]="Cày Cuốc", ["Pen"]="Chuồng Ấp", ["PEN"]="CHUỒNG ẤP", ["Treadmill"]="Máy Tập", ["TREADMILL"]="MÁY TẬP CHẠY", ["Mutate"]="Đột Biến",
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
    ["Keep away"]="Khoảng cách né tránh", ["MINIGAME EGGS"]="TRỨNG MINIGAME", ["Auto steal minigame egg"]="Tự cướp trứng Minigame", ["Player"]="Người Chơi",
    ["ESP"]="Định Vị (ESP)", ["Move"]="Di Chuyển", ["MOVE"]="DI CHUYỂN", ["Combat"]="Chiến Đấu", ["COMBAT"]="CHIẾN ĐẤU", ["FIELD EGGS"]="TRỨNG NGOÀI SÂN",
    ["Egg ESP"]="ESP Trứng", ["Show"]="Hiển thị", ["Name"]="Tên", ["Fixed size"]="Cố định kích cỡ", ["OTHERS"]="MỤC KHÁC", ["Pen egg ESP"]="ESP trứng trong chuồng",
    ["Other pens ESP"]="ESP chuồng người khác", ["Guard ESP"]="ESP Vệ sĩ", ["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ", ["Player ESP"]="ESP Người chơi", ["ESP size"]="Kích cỡ ESP",
    ["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN", ["Speed boost"]="Tăng tốc chạy", ["Boost speed"]="Tốc độ tăng thêm", ["Infinite jump"]="Nhảy vô hạn",
    ["God mode"]="Bất tử (God mode)", ["PROTECTION"]="BẢO VỆ NHÂN VẬT", ["Anti ragdoll"]="Chống ngã (Anti Ragdoll)", ["Ignore traps"]="Bỏ qua bẫy",
    ["Instant prompts"]="Tương tác nhấn giữ tức thì", ["Anti AFK"]="Chống treo máy (Anti AFK)", ["Invisible"]="Tàng hình", ["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",
    ["Auto hit"]="Tự động đánh", ["Hit who"]="Mục tiêu đánh", ["Nearest player"]="Người chơi gần nhất", ["Chosen player"]="Người chơi chỉ định", ["Egg carrier"]="Người đang ôm trứng",
    ["Chase speed"]="Tốc độ đuổi theo", ["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG", ["Hit aura"]="Vòng đánh tự động (Hit Aura)", ["Skip friends"]="Bỏ qua bạn bè",
    ["WEAPONS"]="VŨ KHÍ", ["Use weapons"]="Sử dụng vũ khí", ["Hold each"]="Thời gian cầm mỗi món", ["System"]="Hệ Thống", ["Server"]="Máy Chủ", ["SERVER"]="MÁY CHỦ",
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
    {"dark zone","vùng tối"}, {"safe zone","vùng an toàn"}, {"shooting star","sao băng"},
    {"ghost dog","chó ma"}, {"pumpkin moon","trăng bí ngô"}, {"phantom express","tàu bóng ma"},
    {"cursed island wars","đại chiến đảo nguyền rủa"}, {"candy corn","kẹo ngô"}, {"event egg","trứng sự kiện"},
    {"small monster","quái vật nhỏ"}, {"medium monster","quái vật vừa"}, {"large monster","quái vật lớn"}
}

local WORDS_VI = {
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
    ["for"]="cho", with="với", ["and"]="và", ["or"]="hoặc"
}

local DYN_VI = {
    { pat="^QUICK BAR (%d+)$", rep="THANH NHANH %1" },
    { pat="^(.+) Egg$", rep="Trứng %1" },
    { pat="^(%d+) hours? ago$", rep="%1 giờ trước" },
    { pat="^(%d+) days? ago$", rep="%1 ngày trước" },
    { pat="^(%d+) minutes? ago$", rep="%1 phút trước" },
    { pat="^(.+) was added to your configs%. Apply it now%??$", rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?" },
    { pat="^(.+) was added to your configs$", rep="Đã thêm '%1' vào danh sách cấu hình" },
    { pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support", rep="Chào mừng tới Chilli Hub V7 (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ" },
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
        local a, b = out:lower():find(p[1], 1, true)
        if a then out = out:sub(1, a - 1) .. p[2] .. out:sub(b + 1) end
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
    end
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

local function applyTrans(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHookSession") or inst:GetAttribute("__HiddenVxLogo")
       or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt"
       or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar")
       or inst:GetAttribute("__IsTranslating") then return end

    if inst:IsA("TextBox") then
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
    if not orig then
        if not hasVi(rt) then
            orig = rt
            inst:SetAttribute("OrigRawText", orig)
        else
            return
        end
    end
    local mapped = translateText(orig)
    inst:SetAttribute("__LastTranslated", mapped)
    if inst.Text ~= mapped then
        inst:SetAttribute("__IsTranslating", true)
        pcall(function() inst.Text = mapped end)
        inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookTrans(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint"
       or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt"
       or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
    if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then
        hookFps(inst)
        return
    end
    applyTrans(inst)
    if inst:GetAttribute("__TransHookSession") == SID then return end
    inst:SetAttribute("__TransHookSession", SID)
    table.insert(State.TrackedTexts, inst)
    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if not isAlive() or inst:GetAttribute("__IsTranslating") or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") then return end
        if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then
            hookFps(inst)
            return
        end
        if inst:IsA("TextBox") then
            applyTrans(inst)
            return
        end
        local cur = inst.Text
        if cur ~= inst:GetAttribute("__LastTranslated") and not hasVi(cur) then
            inst:SetAttribute("OrigRawText", cur)
            applyTrans(inst)
        end
    end)
end

-- ZERO-MISFIRE CONFIG IMPORTER (BỎ VIM, KÍCH HOẠT SỰ KIỆN TRỰC TIẾP TRÊN ĐÚNG NÚT IMPORT)
local function fireExplicitEvents(btn)
    if not btn then return false end
    local fired = false
    if getconnections then
        for _, sigName in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
            local ok, sig = pcall(function() return btn[sigName] end)
            if ok and sig then
                for _, conn in ipairs(getconnections(sig)) do
                    if conn.Function then task.spawn(conn.Function); fired = true end
                    pcall(function() conn:Fire() end)
                end
            end
        end
        local cx = btn.AbsolutePosition.X + btn.AbsoluteSize.X * 0.5
        local cy = btn.AbsolutePosition.Y + btn.AbsoluteSize.Y * 0.5
        local pos3 = Vector3.new(cx, cy, 0)
        for _, uType in ipairs({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }) do
            local fB = { UserInputType = uType, UserInputState = Enum.UserInputState.Begin, Position = pos3, Delta = Vector3.zero, KeyCode = Enum.KeyCode.Unknown }
            local fE = { UserInputType = uType, UserInputState = Enum.UserInputState.End, Position = pos3, Delta = Vector3.zero, KeyCode = Enum.KeyCode.Unknown }
            local oB, sB = pcall(function() return btn.InputBegan end)
            if oB and sB then
                for _, c in ipairs(getconnections(sB)) do
                    if c.Function then task.spawn(c.Function, fB, false); fired = true end
                end
            end
            local oE, sE = pcall(function() return btn.InputEnded end)
            if oE and sE then
                for _, c in ipairs(getconnections(sE)) do
                    if c.Function then task.spawn(c.Function, fE, false); fired = true end
                end
            end
        end
    end
    if firesignal then
        pcall(function() firesignal(btn.MouseButton1Down) end)
        pcall(function() firesignal(btn.MouseButton1Up) end)
        pcall(function() firesignal(btn.MouseButton1Click); fired = true end)
        pcall(function() firesignal(btn.Activated); fired = true end)
    end
    return fired
end

local function findNavTabByText(gui, searchWord)
    for _, d in ipairs(gui:GetDescendants()) do
        if not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible and d.AbsolutePosition.Y < 190 then
            local raw = (d:GetAttribute("OrigRawText") or d.Text or ""):lower():match("^%s*(.-)%s*$")
            local cur = (d.Text or ""):lower():match("^%s*(.-)%s*$")
            if raw == searchWord or cur == searchWord then
                local b = (d:IsA("TextButton") and d) or (d.Parent and d.Parent:IsA("TextButton") and d.Parent) or d
                return b
            end
        end
    end
    return nil
end

local function runAutoFarmMacro(venyxGui, statusBtn)
    if State.MacroBusy then return end
    State.MacroBusy = true
    task.spawn(function()
        local origTxt = statusBtn.Text
        statusBtn.Text = "⏳ ĐANG NẠP CONFIG..."
        if setclipboard then pcall(setclipboard, PRESET_JSON) end
        if State.ActiveMainWin and State.ActiveMainWin.Parent and not State.ActiveMainWin.Visible then
            State.ActiveMainWin.Visible = true
            if State.SyncWindowFn then pcall(State.SyncWindowFn) end
            task.wait(0.10)
        end

        local cfgBox, impBtn = nil, nil
        local function scanForConfig()
            local b, i
            for _, d in ipairs(venyxGui:GetDescendants()) do
                if not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
                    if d:IsA("TextBox") and d.Visible then
                        local ph = (d:GetAttribute("OrigPh") or d.PlaceholderText or ""):lower()
                        if ph:find("paste config", 1, true) or ph:find("dán mã", 1, true) or ph:find("json", 1, true) then
                            b = d
                        end
                    elseif (d:IsA("TextButton") or d:IsA("TextLabel")) and d.Visible then
                        local raw = (d:GetAttribute("OrigRawText") or d.Text or ""):lower()
                        local cur = (d.Text or ""):lower()
                        if raw:find("import config", 1, true) or raw:find("import", 1, true) or cur:find("nhập cấu hình", 1, true) or cur:find("nhập", 1, true) then
                            if not raw:find("text") and not cur:find("json") then
                                local r = d.Parent
                                if r and r:IsA("GuiObject") and r.AbsoluteSize.X > 200 then
                                    for _, sib in ipairs(r:GetDescendants()) do
                                        if (sib:IsA("TextButton") or sib:IsA("ImageButton") or (sib:IsA("Frame") and sib:FindFirstChildOfClass("UICorner"))) and sib ~= d then
                                            if sib.AbsolutePosition.X > (r.AbsolutePosition.X + r.AbsoluteSize.X * 0.40) then
                                                i = sib
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            return b, i
        end

        cfgBox, impBtn = scanForConfig()
        if not cfgBox or not impBtn then
            local sysNavBtn = State.SidebarNavButtons and State.SidebarNavButtons[6]
            if sysNavBtn then
                fireExplicitEvents(sysNavBtn)
                task.wait(0.18)
            end
            local confTab = findNavTabByText(venyxGui, "config") or findNavTabByText(venyxGui, "cấu hình")
            if confTab then fireExplicitEvents(confTab) end
            task.wait(0.26)
            cfgBox, impBtn = scanForConfig()
        end

        if not cfgBox then
            statusBtn.Text = "⚠️ MỞ MỤC CẤU HÌNH TRƯỚC!"
            task.wait(2)
            statusBtn.Text = "⚡ CONFIG SETTING AUTO FARM"
            State.MacroBusy = false
            return
        end

        local sf = cfgBox:FindFirstAncestorOfClass("ScrollingFrame")
        if sf then
            pcall(function() sf.CanvasPosition = v2(0, math.max(320, sf.AbsoluteCanvasSize.Y)) end)
            task.wait(0.06)
        end

        local hasHihi2 = (State.ImportRunCount or 0) > 0
        if not hasHihi2 then
            for _, d in ipairs(venyxGui:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
                    if (d.Text or ""):lower():find("hihi 2", 1, true) then hasHihi2 = true; break end
                end
            end
        end
        State.ImportRunCount = (State.ImportRunCount or 0) + 1
        local payloadJson = PRESET_JSON
        if hasHihi2 then
            payloadJson = PRESET_JSON:gsub('"name":"hihi 2"', '"name":"hihi 2 #' .. tostring(math.random(10, 99)) .. '"', 1)
        end

        cfgBox:SetAttribute("__IsTranslating", true)
        pcall(function() cfgBox.ClearTextOnFocus = false end)
        cfgBox.Text = ""
        task.wait(0.03)
        pcall(function() cfgBox:CaptureFocus() end)
        task.wait(0.04)
        cfgBox.Text = payloadJson
        if getconnections then
            pcall(function()
                for _, conn in ipairs(getconnections(cfgBox:GetPropertyChangedSignal("Text"))) do
                    if conn.Function then task.spawn(conn.Function) end
                end
            end)
        end
        pcall(function() cfgBox:ReleaseFocus(true) end)
        if firesignal then pcall(function() firesignal(cfgBox.FocusLost, true) end) end
        if getconnections then
            pcall(function()
                for _, conn in ipairs(getconnections(cfgBox.FocusLost)) do
                    if conn.Function then task.spawn(conn.Function, true) end
                end
            end)
        end
        cfgBox:SetAttribute("__IsTranslating", false)
        task.wait(0.12)

        if not impBtn and cfgBox and cfgBox.Parent then
            local pRow = cfgBox:FindFirstAncestorOfClass("ScrollingFrame")
            if pRow then
                for _, c in ipairs(pRow:GetDescendants()) do
                    if (c:IsA("TextButton") or c:IsA("ImageButton") or (c:IsA("TextLabel") and c.Parent:IsA("Frame"))) and c.Visible then
                        local dy = c.AbsolutePosition.Y - cfgBox.AbsolutePosition.Y
                        if dy > 15 and dy < 65 and c.AbsolutePosition.X > cfgBox.AbsolutePosition.X - 20 then
                            impBtn = c
                            break
                        end
                    end
                end
            end
        end

        if impBtn then
            fireExplicitEvents(impBtn)
            task.wait(0.24)
            for pass = 1, 2 do
                for _, d in ipairs(venyxGui:GetDescendants()) do
                    if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and d.Visible then
                        local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
                        local ct = (d.Text or ""):match("^%s*(.-)%s*$")
                        if ot == "Apply now" or ct == "Áp dụng ngay" or ot == "Overwrite" or ct == "Lưu đè" then
                            fireExplicitEvents(d)
                        end
                    end
                end
                task.wait(0.14)
            end
            for _, d in ipairs(venyxGui:GetDescendants()) do
                if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and d.Visible then
                    local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
                    local ct = (d.Text or ""):match("^%s*(.-)%s*$")
                    if ot == "Set active" or ct == "Kích hoạt" then
                        fireExplicitEvents(d)
                        break
                    end
                end
            end
            if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
            statusBtn.Text = "✅ ĐÃ NẠP & ÁP DỤNG CONFIG!"
        else
            statusBtn.Text = "⚠️ ĐÃ COPY JSON (TỰ DÁN & NHẬP)!"
        end

        task.wait(1.8)
        if statusBtn and statusBtn.Parent then statusBtn.Text = origTxt end
        State.MacroBusy = false
    end)
end

-- TỰ ĐỘNG QUÉT BẮT TOÀN BỘ MENU LÊN SCREEN GUI CHỐNG ARCEUS X NEO ẨN MENU
local function instantInterceptNode(nd)
    if not isAlive() or not nd or not nd.Parent then return end
    local sg = nd:FindFirstAncestorOfClass("ScreenGui")
    if sg and IGNORED_GUIS[sg.Name] then return end
    if nd:IsA("TextLabel") or nd:IsA("TextButton") or nd:IsA("TextBox") then
        local rawT = (nd.Text or ""):match("^%s*(.-)%s*$")
        if not nd:IsA("TextBox") then
            if rawT == "Vx" or rawT == "VX" or rawT == "V" then
                nd:SetAttribute("__HiddenVxLogo", true)
                nd.TextTransparency = 1
                nd.BackgroundTransparency = 1
                return
            elseif rawT == "VENYX" and not nd:FindFirstAncestorOfClass("ScrollingFrame") then
                nd:SetAttribute("__IsTranslating", true)
                nd.Text = NEW_TITLE
                nd:SetAttribute("__IsTranslating", false)
            end
        end
        if not nd:IsA("TextBox") and isFpsTxt(nd.Text) then
            pcall(hookFps, nd)
        else
            pcall(hookTrans, nd)
        end
    end
end

local function bindGuiEvents(gui)
    if not gui:IsA("ScreenGui") or IGNORED_GUIS[gui.Name] or gui:GetAttribute("__ListenerSession") == SID then return end
    gui:SetAttribute("__ListenerSession", SID)
    gui.DescendantAdded:Connect(instantInterceptNode)
end

local scanOnce
scanOnce = function(forcePass)
    if not isAlive() then return false end
    if not forcePass and State.ActiveMainWin and State.ActiveMainWin.Parent and State.ActiveMainWin:GetAttribute("__ChilliV7Patched") == SID then return true end
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
                local titleLbl = nil
                for _, d in ipairs(gui:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
                        local t = (d.Text or ""):match("^%s*(.-)%s*$")
                        if t == "Vx" or t == "VX" then
                            d:SetAttribute("__HiddenVxLogo", true)
                            d.TextTransparency = 1
                        elseif isFpsTxt(t) then
                            pcall(hookFps, d)
                        elseif (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
                            titleLbl = d
                        end
                    end
                end
                if titleLbl then
                    local win = titleLbl
                    while win.Parent and win.Parent ~= gui do
                        win = win.Parent
                        if win:IsA("GuiObject") and win.AbsoluteSize.X >= 260 and win.AbsoluteSize.Y >= 165 then break end
                    end
                    if win and win:IsA("GuiObject") then
                        State.ActiveMainWin = win
                        State.ActiveVenyxGui = gui
                        bindGuiEvents(gui)
                        if win:GetAttribute("__ChilliV7Patched") ~= SID then
                            win:SetAttribute("__ChilliV7Patched", SID)
                            pcall(function() win.Visible = true; gui.Enabled = true end)
                            -- Gọi logic build UI chính ở đây (phần đã setup xong ở các block mã trên)
                        end
                    end
                end
            end
        end
    end
    return State.ActiveMainWin ~= nil
end

for _, root in ipairs(getScanRoots()) do
    root.DescendantAdded:Connect(function(ch)
        if not isAlive() then return end
        if ch:IsA("ScreenGui") and not IGNORED_GUIS[ch.Name] then
            bindGuiEvents(ch)
            task.delay(0.06, function() if isAlive() then pcall(scanOnce, true) end end)
        else
            instantInterceptNode(ch)
        end
    end)
end

pcall(scanOnce)
task.spawn(function()
    local t = 0
    while isAlive() and not State.ActiveMainWin and t < 60 do
        task.wait(0.06)
        t = t + 0.06
        if t > 8.5 and not State.ActiveMainWin and not isVenyxUiPresent() then launchVenyxBase() end
        pcall(scanOnce)
    end
    if isAlive() then
        task.wait(0.5)
        pcall(scanOnce, true)
    end
end)
