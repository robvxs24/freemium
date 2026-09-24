-- ==============================================================================
--  LENNON HUB KAITUN - IMMORTAL ENGINE V6.0 (PHANTOM SHIELD - UI OVERRIDE)
--  Tối ưu hóa:
--    1. Nạp đúng luồng script gốc Lennon Hub (Luarmor Loader).
--    2. SỬA LỖI KÉO THẢ: Tách nút X khỏi TopBar. Di chuyển menu thoải mái.
--    3. PHANTOM SHIELD: Đè khiên tàng hình lên nút X để lừa Luarmor, ép UI luôn bung to.
--    4. Lõi dịch thuật bất tử: Dịch chính xác 100%, không crash, không tụt FPS.
--    5. Nút bấm Frosted Slate Top-Center (Y=15).
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP LUARMOR SCRIPT GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/4595fe31a5f7a8b4f4dd7071f3119ef7.lua"))()
    end)
end)

-- ==================== 2. TỪ ĐIỂN ĐA NGÔN NGỮ ====================
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

local MAP_VI = {
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "CÀY CUỐC (KAITUN)",
    ["DR. SCRAMBLE"] = "SỰ KIỆN DR. SCRAMBLE",
    ["WEBHOOK"] = "CÀI ĐẶT WEBHOOK",
    ["BEST EGG"] = "TRỨNG TỐT NHẤT",
    ["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP",
    ["ONE SHOT"] = "MỘT LẦN",
    ["LOOP READY"] = "SẴN SÀNG LẶP",
    ["LOOP"] = "LẶP LẠI",
    ["START"] = "BẮT ĐẦU",
    ["STOP"] = "DỪNG LẠI",
    ["RARITY FILTER"] = "BỘ LỌC ĐỘ HIẾM",
    ["DISCORD WEBHOOK URL"] = "ĐƯỜNG DẪN WEBHOOK DISCORD",
    
    ["Auto Treadmill"] = "Tự Động Chạy Máy Tập",
    ["Auto Hatch Eggs"] = "Tự Động Ấp Trứng",
    ["Anti-AFK"] = "Chống Treo Máy (AFK)",
    ["Auto Place Eggs"] = "Tự Đặt Trứng",
    ["Offline Earnings"] = "Nhận Tiền Offline",
    ["Anti-Trap"] = "Chống Dính Bẫy",
    ["Auto Hunt Drones"] = "Tự Động Săn Drone",
    ["Auto Open Vault"] = "Tự Động Mở Hầm",
    ["Secret Cave"] = "Hang Động Bí Ẩn",
    ["Auto Lost Parts"] = "Tự Nhặt Phụ Tùng",
    ["Auto Buy Shop"] = "Tự Động Mua Cửa Hàng",
    ["Send Steals"] = "Báo Cáo Cướp Trứng",
    ["Test Webhook"] = "Kiểm Tra Webhook",
    
    ["Auto steal running automations on hold"] = "Đang tự động cướp, các tính năng khác tạm dừng",
    ["No steals logged yet"] = "Chưa có lượt cướp nào được ghi lại",
    
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Cosmic"] = "Vũ Trụ (Cosmic)"
}

local MAP_PH = {
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "KAITUN (AUTO-FARM)",
    ["DR. SCRAMBLE"] = "EVENT NI DR. SCRAMBLE",
    ["WEBHOOK"] = "WEBHOOK SETTINGS",
    ["BEST EGG"] = "PINAKAMAGANDANG ITLOG",
    ["AUTO STEAL"] = "AUTO NAKAW",
    ["ONE SHOT"] = "ISANG BESES",
    ["LOOP READY"] = "HANDANG UMULIT",
    ["LOOP"] = "PAULIT-ULIT",
    ["START"] = "SIMULAN",
    ["STOP"] = "IHINTO",
    ["RARITY FILTER"] = "FILTER NG RARITY",
    ["DISCORD WEBHOOK URL"] = "DISCORD WEBHOOK URL",
    
    ["Auto Treadmill"] = "Auto Treadmill",
    ["Auto Hatch Eggs"] = "Auto Pusa ng Itlog",
    ["Anti-AFK"] = "Laban sa AFK",
    ["Auto Place Eggs"] = "Auto Lagay ng Itlog",
    ["Offline Earnings"] = "Kita Offline",
    ["Anti-Trap"] = "Laban sa Bitag",
    ["Auto Hunt Drones"] = "Auto Hunt Drones",
    ["Auto Open Vault"] = "Auto Bukas ng Vault",
    ["Secret Cave"] = "Sikretong Kuweba",
    ["Auto Lost Parts"] = "Auto Kolekta ng Parts",
    ["Auto Buy Shop"] = "Auto Bili sa Shop",
    ["Send Steals"] = "Ipadala ang mga Nakaw",
    ["Test Webhook"] = "I-test ang Webhook",
    
    ["Auto steal running automations on hold"] = "Umaandar ang auto nakaw, naka-pause ang iba",
    ["No steals logged yet"] = "Wala pang nakaw na naitala",
    
    ["Secret"] = "Secret",
    ["Eternal"] = "Eternal",
    ["Divine"] = "Divine",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic"
}

local MAP_ID = {
    ["LENNON HUB"] = "LENNON HUB",
    ["KAITUN"] = "FARMING OTOMATIS",
    ["DR. SCRAMBLE"] = "EVENT DR. SCRAMBLE",
    ["WEBHOOK"] = "PENGATURAN WEBHOOK",
    ["BEST EGG"] = "TELUR TERBAIK",
    ["AUTO STEAL"] = "AUTO CURI",
    ["ONE SHOT"] = "SEKALI SAJA",
    ["LOOP READY"] = "SIAP BERULANG",
    ["LOOP"] = "TERUS MENERUS",
    ["START"] = "MULAI",
    ["STOP"] = "BERHENTI",
    ["RARITY FILTER"] = "FILTER RARITY",
    ["DISCORD WEBHOOK URL"] = "URL WEBHOOK DISCORD",
    
    ["Auto Treadmill"] = "Auto Treadmill",
    ["Auto Hatch Eggs"] = "Auto Tetas Telur",
    ["Anti-AFK"] = "Anti AFK",
    ["Auto Place Eggs"] = "Auto Taruh Telur",
    ["Offline Earnings"] = "Penghasilan Offline",
    ["Anti-Trap"] = "Anti Perangkap",
    ["Auto Hunt Drones"] = "Auto Hunt Drone",
    ["Auto Open Vault"] = "Auto Buka Brankas",
    ["Secret Cave"] = "Gua Rahasia",
    ["Auto Lost Parts"] = "Auto Ambil Suku Cadang",
    ["Auto Buy Shop"] = "Auto Beli di Toko",
    ["Send Steals"] = "Kirim Info Curi",
    ["Test Webhook"] = "Tes Webhook",
    
    ["Auto steal running automations on hold"] = "Auto curi jalan, otomatisasi lain ditahan",
    ["No steals logged yet"] = "Belum ada curian tercatat",
    
    ["Secret"] = "Secret",
    ["Eternal"] = "Eternal",
    ["Divine"] = "Divine",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic"
}

local DYNAMIC_PATTERNS = {
    {
        pattern = "^IDLE / (%d+:%d+)$",
        format  = function(lang, timeStr) 
            if lang == "VI" then return "ĐANG CHỜ LỆNH / " .. timeStr 
            elseif lang == "PH" then return "BAKANTE / " .. timeStr 
            elseif lang == "ID" then return "DIAM / " .. timeStr 
            end return "IDLE / " .. timeStr 
        end
    },
    {
        pattern = "^IDLE / (%d+:%d+:%d+)$",
        format  = function(lang, timeStr) 
            if lang == "VI" then return "ĐANG CHỜ LỆNH / " .. timeStr 
            elseif lang == "PH" then return "BAKANTE / " .. timeStr 
            elseif lang == "ID" then return "DIAM / " .. timeStr 
            end return "IDLE / " .. timeStr 
        end
    }
}

local SortedVI, SortedPH, SortedID = {}, {}, {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
for en, ph in pairs(MAP_PH) do table.insert(SortedPH, {en = en, out = ph, len = #en}) end
for en, id in pairs(MAP_ID) do table.insert(SortedID, {en = en, out = id, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)
table.sort(SortedPH, function(a, b) return a.len > b.len end)
table.sort(SortedID, function(a, b) return a.len > b.len end)

-- ==================== 3. KHIÊN TÀNG HÌNH (PHANTOM SHIELD) ====================
task.spawn(function()
    local function fireVirtualClick(btn)
        if not getconnections then return end
        pcall(function()
            for _, conn in ipairs(getconnections(btn.InputBegan)) do
                if type(conn.Function) == "function" then
                    conn.Function(btn, {UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                end
            end
            for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                if type(conn.Function) == "function" then conn.Function() end
            end
        end)
    end

    while task.wait(0.2) do
        local roots = {gethui and pcall(gethui) and gethui() or CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        for _, root in ipairs(roots) do
            if root then
                for _, inst in ipairs(root:GetDescendants()) do
                    if inst:IsA("TextLabel") and inst.Text:find("LENNON HUB") then
                        local mainFrame = inst:FindFirstAncestorOfClass("Frame")
                        local screenGui = inst:FindFirstAncestorOfClass("ScreenGui")
                        
                        if mainFrame and screenGui and not screenGui:GetAttribute("PhantomShield_Added") then
                            screenGui:SetAttribute("PhantomShield_Added", true)
                            
                            -- Tìm nút Expand/Collapse (+ hoặc x)
                            local expandBtn
                            for _, desc in ipairs(mainFrame:GetDescendants()) do
                                if (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
                                    if desc.AbsoluteSize.X > 0 and desc.AbsoluteSize.X < 40 and desc.AbsoluteSize.Y < 40 then
                                        local t = desc.Text:lower()
                                        if t == "+" or t == "x" or t == "×" or t == "-" then
                                            expandBtn = desc
                                            break
                                        end
                                    end
                                end
                            end

                            if expandBtn then
                                -- 1. Tạo Khiên Tàng Hình đè trực tiếp lên nút X
                                local shield = Instance.new("TextButton")
                                shield.Name = "PhantomShield"
                                shield.Size = UDim2.new(1.8, 0, 1.8, 0)
                                shield.Position = UDim2.new(-0.4, 0, -0.4, 0)
                                shield.BackgroundTransparency = 1
                                shield.Text = ""
                                shield.ZIndex = 2147483647
                                shield.Parent = expandBtn
                                
                                -- 2. Lõi theo dõi trạng thái: Chỉ kích hoạt Khiên khi là dấu X
                                RunService.RenderStepped:Connect(function()
                                    if not expandBtn or not expandBtn.Parent then return end
                                    local t = expandBtn.Text:lower()
                                    
                                    if t == "x" or t == "×" or t == "-" then
                                        shield.Visible = true
                                    else
                                        shield.Visible = false
                                        -- Auto Expand Gắt: Thấy dấu + là tự click bung ra ngay
                                        if mainFrame.Visible then
                                            fireVirtualClick(expandBtn)
                                        end
                                    end
                                end)
                                
                                -- 3. Đánh lừa Luarmor: Chạm vào Khiên -> Ẩn Frame (Luarmor vẫn nghĩ là đang bật)
                                local function hideMenu()
                                    if mainFrame then
                                        mainFrame.Visible = false
                                    end
                                end
                                shield.MouseButton1Click:Connect(hideMenu)
                                shield.InputBegan:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.Touch then hideMenu() end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ==================== 4. LÕI DỊCH THUẬT BẤT TỬ ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
    end

    local result = raw
    local matched = false

    local sortedMap = SortedVI
    if currentLanguage == "PH" then sortedMap = SortedPH
    elseif currentLanguage == "ID" then sortedMap = SortedID end

    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local trimmed = result:gsub("^%s*(.-)%s*$", "%1")
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            result = item.format(currentLanguage, unpack(matches))
            matched = true
            break
        end
    end

    if not matched then
        for _, item in ipairs(sortedMap) do
            if result:find(item.en, 1, true) then
                result = replaceAll(result, item.en, item.out)
                matched = true
            end
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}
local DebounceTracker = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_LangToggle_Slate") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    local mappedText = translateText(original)
    
    if inst.Text ~= mappedText then
        inst:SetAttribute("__IsTranslating", true)
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

        if DebounceTracker[inst] and tick() - DebounceTracker[inst] < 0.1 then return end
        DebounceTracker[inst] = tick()

        local current = inst.Text
        local isKnown = false
        
        local map = MAP_VI
        if currentLanguage == "PH" then map = MAP_PH
        elseif currentLanguage == "ID" then map = MAP_ID end
        
        if currentLanguage ~= "EN" then
            for _, translated in pairs(map) do
                if current:find(translated, 1, true) then
                    isKnown = true
                    break
                end
            end
            
            if not isKnown then
                for _, item in ipairs(DYNAMIC_PATTERNS) do
                    local trimmed = current:gsub("^%s*(.-)%s*$", "%1")
                    local matches = {trimmed:match(item.pattern)}
                    if #matches > 0 then
                        isKnown = true 
                        break
                    end
                end
            end
        else
            isKnown = (current == inst:GetAttribute("OriginalRawText"))
        end

        if not isKnown then
            inst:SetAttribute("OriginalRawText", current)
        end
        
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

-- ==================== 5. NÚT ĐỔI NGÔN NGỮ (TOP-CENTER Y=15) ====================
local function createLangToggleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_LangToggle_Slate")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_LangToggle_Slate"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Container = Instance.new("Frame", ScreenGui)
    Container.Size = UDim2.new(0, 136, 0, 28)
    Container.AnchorPoint = Vector2.new(0.5, 0)
    Container.Position = UDim2.new(0.5, 0, 0, 15)
    Container.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    Container.BackgroundTransparency = 0.2
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke", Container)
    Stroke.Color = Color3.fromRGB(160, 45, 45) 
    Stroke.Thickness = 1.0

    local Icon = Instance.new("TextLabel", Container)
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌐"
    Icon.TextSize = 14

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -36, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Tiếng Việt"
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(240, 130, 130)
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ClickBtn = Instance.new("TextButton", Container)
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""

    local dragging, dragStart, startPos = false, nil, nil
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Container.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Container.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    ClickBtn.MouseButton1Click:Connect(function()
        if currentLanguage == "VI" then
            currentLanguage = "PH"
            Label.Text = "Filipino"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(245, 205, 110)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 135, 60)}):Play()
        elseif currentLanguage == "PH" then
            currentLanguage = "ID"
            Label.Text = "Indonesia"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 220, 240)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 140, 160)}):Play()
        elseif currentLanguage == "ID" then
            currentLanguage = "EN"
            Label.Text = "English"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(215, 180, 180)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 45, 45)}):Play()
        else
            currentLanguage = "VI"
            Label.Text = "Tiếng Việt"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 130, 130)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 45, 45)}):Play()
        end
        updateAllActive()
    end)
end

-- ==================== 6. BỘ QUÉT DEFER BẢO MẬT ====================
task.delay(4.5, function()
    createLangToggleUI()

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
            end
            if i % 20 == 0 then RunService.RenderStepped:Wait() end
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
                    end
                end)
            end)
        end
    end
end)
