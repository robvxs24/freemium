-- ==============================================================================
--  RONNEI HUB - 100% TOP-PINNED & FULL TRANSLATOR FOR FYY COMMUNITY
--  Khóa chặt mép trên (Không văng xuống đáy) | Nhận diện chữ ký 10 Tab
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn sạch toàn bộ các bản ghim cũ
local cleanList = {
    "Ronnei_PinMaster_Diagnostic", 
    "Ronnei_UniversalPinMaster", 
    "Ronnei_DirectHookMaster", 
    "Ronnei_FixedTargetMaster",
    "Ronnei_AllTabsMaster",
    "Ronnei_TopLockedMaster"
}
for _, name in ipairs(cleanList) do
    pcall(function()
        if CoreGuiService:FindFirstChild(name) then CoreGuiService[name]:Destroy() end
        if gethui and gethui():FindFirstChild(name) then gethui()[name]:Destroy() end
    end)
end

local THEME = {
    BarBG      = Color3.fromRGB(14, 16, 22),
    CardBG     = Color3.fromRGB(22, 26, 36),
    Border     = Color3.fromRGB(45, 55, 75),
    AccentMint = Color3.fromRGB(0, 230, 120),
    ToggleOff  = Color3.fromRGB(38, 43, 56),
    TextMain   = Color3.fromRGB(245, 248, 255),
    TextSub    = Color3.fromRGB(150, 160, 180),
    FontB      = Enum.Font.GothamBold,
    FontM      = Enum.Font.GothamMedium
}

-- ==================== TỪ ĐIỂN DỊCH THUẬT TOÀN DIỆN ====================
local RAW_TRANSLATIONS = {
    -- 1. Tab Tổng quan (Overview)
    {"Your account and current session", "Tài khoản và phiên chơi hiện tại"},
    {"Get help or join the community", "Nhận trợ giúp hoặc vào Discord"},
    {"Need Support?", "Cần hỗ trợ?"},
    {"Join Discord", "Vào Discord"},
    {"Connected", "Đã kết nối"},

    -- 2. Tab Hình ảnh (Visual / ESP)
    {"Plot Egg ESP", "ESP Trứng Khu Đất"},
    {"Egg ESP", "ESP Trứng"},
    {"ESP Details", "Chi Tiết ESP"},
    {"ESP Value", "Hiển Thị Giá Trị Trứng"},
    {"Weight (Kg)", "Khối lượng (Kg)"},

    -- 3. Tab Webhook
    {"Discord Webhook", "Discord Webhook"},
    {"Webhook URL", "Đường Dẫn Webhook"},
    {"Rarity Filter", "Bộ Lọc Độ Hiếm"},
    {"Enable Webhook", "Bật Webhook"},
    {"Enable Filter Rarity", "Bật Lọc Độ Hiếm"},
    {"Include Backpack", "Kèm Túi Đồ"},
    {"Include Plot Details", "Kèm Chi Tiết Khu Đất"},
    {"SPAWN ANNOUNCEMENTS", "THÔNG BÁO XUẤT HIỆN TRỨNG"},
    {"Announcement Rarity", "Độ Hiếm Thông Báo"},
    {"Announcement Độ hiếm", "Độ Hiếm Thông Báo"},
    {"Announce Egg Spawns", "Thông Báo Khi Trứng Xuất Hiện"},
    {"Tag Everyone On Steal", "Tag @everyone Khi Trộm Trứng"},
    {"Tag Everyone On Trộm trứng", "Tag @everyone Khi Trộm Trứng"},
    {"Alert Roblox Disconnect", "Cảnh Báo Mất Kết Nối Roblox"},
    {"Send Now", "Gửi Ngay"},
    {"Select...", "Chọn..."},

    -- 4. Tab Gói VIP (Premium)
    {"Dashboard Monitoring", "Giám Sát Bảng Điều Khiển"},
    {"Premium Access", "Quyền Truy Cập VIP"},
    {"Gói VIP Access", "Quyền Truy Cập VIP"},
    {"Pair your dashboard account once and keep monitoring enabled automatically.", "Ghép nối tài khoản một lần và tự động duy trì giám sát."},
    {"Pairing Code", "Mã Ghép Nối"},
    {"Connect", "Kết Nối"},
    {"Enable Monitoring", "Bật Giám Sát"},

    -- 5. Tab Tiện ích (Utility)
    {"Performance", "Hiệu Năng"},
    {"Boost FPS", "Tăng Tốc FPS (Giảm Lag)"},
    {"Auto Server Hop", "Tự Đổi Máy Chủ"},
    {"Auto Upgrades", "Tự Động Nâng Cấp"},
    {"Target Treadmill Lv (0 = max)", "Cấp Máy Chạy Mục Tiêu (0 = max)"},
    {"Target Base Lv (0 = max)", "Cấp Căn Cứ Mục Tiêu (0 = max)"},
    {"Auto Upgrade Treadmill", "Tự Nâng Cấp Máy Chạy"},
    {"Auto Upgrade Base", "Tự Nâng Cấp Căn Cứ"},

    -- 6. Tab Cấu hình (Config)
    {"Configurations", "Quản Lý Cấu Hình"},
    {"Profile Name", "Tên Hồ Sơ"},
    {"Profile", "Hồ Sơ"},
    {"Save Config", "Lưu Cấu Hình"},
    {"Load Config", "Tải Cấu Hình"},
    {"Delete Config", "Xóa Cấu Hình"},
    {"No saved profiles", "Chưa có hồ sơ lưu"},
    {"No profiles", "Không có hồ sơ"},
    {"Automatic Startup", "Tự Động Khởi Động"},
    {"No profile selected", "Chưa chọn hồ sơ"},
    {"Select and save a profile, then enable automatic loading.", "Chọn và lưu hồ sơ, rồi bật tự nạp."},
    {"Load selected config on execute", "Tự nạp cấu hình khi chạy script"},
    {"Automatically restores the selected profile when the hub starts.", "Tự động khôi phục cấu hình khi mở hub."},
    {"Teleport Persistence", "Duy Trì Khi Đổi Server"},
    {"FyyCommunity Loader", "Trình Nạp FyyCommunity"},
    {"Enable this to restore the loader after changing servers.", "Bật để nạp lại script khi đổi server."},
    {"Re-execute Loader on Teleport", "Chạy Lại Trình Nạp Khi Chuyển Server"},
    {"Runs the latest FyyCommunity loader after changing servers.", "Tự chạy bản nạp mới nhất khi chuyển server."},
    {"Import & Export", "Nhập & Xuất Cấu Hình"},
    {"Config JSON", "Mã JSON Cấu Hình"},
    {"Paste JSON", "Dán mã JSON"},
    {"Copy JSON", "Sao Chép JSON"},
    {"Import JSON", "Nhập mã JSON"},

    -- 7. Tab Túi đồ (Inventory)
    {"Inventory Runtime", "Trạng Thái Túi Đồ Live"},
    {"Auto Sell Egg", "Tự Động Bán Trứng"},
    {"Sell Rarities (empty = sell all)", "Độ hiếm bán (trống = bán hết)"},
    {"Max Kg (0 = off)", "Khối lượng tối đa (0 = tắt)"},
    {"Equipped:", "Đang dùng:"},
    {"Egg sell:", "Bán trứng:"},
    {"Pet sell:", "Bán thú cưng:"},
    {"Sell all", "Bán tất cả"},
    {"Operation: Idle", "Thao tác: Đang chờ"},
    {"Operation:", "Thao tác:"},
    {"Last:", "Lần cuối:"},
    {"Sold:", "Đã bán:"},
    {"Fuse:", "Hợp nhất:"},
    {"Equip:", "Trang bị:"},
    {"Pets:", "Thú cưng:"},

    -- 8. Tab Trộm trứng (Steal)
    {"Ride your treadmill while Auto Steal has no target.", "Dùng máy chạy khi không có mục tiêu trộm."},
    {"Only feed infected eggs in selected rarities.", "Chỉ cho ăn trứng nhiễm theo độ hiếm."},
    {"Steal, bank, and feed infected eggs.", "Trộm, cất kho và cho ăn trứng nhiễm."},
    {"Open pending monster chests.", "Mở các rương quái vật đang chờ."},
    {"Rollback / Slow ? Tune up", "Bị giật / Chậm ? Hãy tăng tốc"},
    {"Supports 1m, 200m, 1b", "Hỗ trợ 1m, 200m, 1b"},
    {"Disable During Automation", "Tắt khi đang chạy tự động"},
    {"Target Heaviest Egg", "Nhắm quả trứng nặng nhất"},
    {"Minimum Steal Value", "Giá trị trộm tối thiểu"},
    {"Minimum Weight (Kg)", "Khối lượng tối thiểu (Kg)"},
    {"Auto Feed Parasite", "Tự Cho Ký Sinh Ăn"},
    {"Steal Highest Value", "Trộm giá trị cao nhất"},
    {"Auto Use Treadmill", "Tự dùng máy chạy bộ"},
    {"Filter by Mutation", "Lọc theo đột biến"},
    {"Treadmill Manager", "Quản Lý Máy Chạy"},
    {"Feed the Parasite", "Cho Ký Sinh Ăn"},
    {"Monster Parasite", "Quái Ký Sinh"},
    {"Filter by Rarity", "Lọc theo độ hiếm"},
    {"Auto Open Chest", "Tự Động Mở Rương"},
    {"Filter by Area", "Lọc theo khu vực"},
    {"Filter by Name", "Lọc theo tên"},
    {"Target Filters", "Bộ Lọc Mục Tiêu"},
    {"Feed Rarities", "Độ hiếm cho ăn"},
    {"Egg Runtime", "Trạng Thái Trứng Live"},
    {"Steal Mode", "Chế Độ Trộm"},
    {"Auto Steal", "Tự Động Trộm"},
    {"Anti Guard", "Chống Bảo Vệ"},
    {"Anti Trap", "Chống Bẫy"},

    -- 9. Thông số Runtime
    {"Target: None", "Mục tiêu: Không có"},
    {"Result: Idle", "Kết quả: Đang chờ"},
    {"Available:", "Khả dụng:"},
    {"Matching:", "Khớp:"},
    {"Target:", "Mục tiêu:"},
    {"Result:", "Kết quả:"},
    {"Rarest:", "Hiếm nhất:"},
    {"Heaviest:", "Nặng nhất:"},
    {"Chests", "Rương"},
    {"Feeds", "Lượt ăn"},
    {"Players", "Người chơi"},
    {"days", "ngày"},
    {"Disabled", "Đã tắt"},
    {"Enabled", "Đã bật"},
    {"Tween...", "Bay Mượt (Tween)"},
    {"Speed", "Tốc Độ"},
    {"Not...", "Chưa chọn..."},
    {"Ready", "Sẵn sàng"},
    {"READY", "SẴN SÀNG"},
    {"IDLE", "ĐANG CHỜ"},
    {"Idle", "Đang chờ"},
    {"GAME", "TRÒ CHƠI"},
    {"SERVER", "MÁY CHỦ"},
    {"Server", "Máy chủ"},
    {"Default", "Mặc định"},
    {"MANUAL", "THỦ CÔNG"},
    {"Refresh", "Làm Mới"},

    -- 10. Danh mục Sidebar Tabs
    {"Overview", "Tổng quan"},
    {"OVERVIEW", "TỔNG QUAN"},
    {"Steal", "Trộm trứng"},
    {"Egg Panel", "Bảng trứng"},
    {"Inventory", "Túi đồ"},
    {"Eggs", "Trứng"},
    {"Rewards", "Phần thưởng"},
    {"Visual", "Hình ảnh"},
    {"Webhook", "Webhook"},
    {"Premium", "Gói VIP"},
    {"Utility", "Tiện ích"},
    {"Config", "Cấu hình"},
    {"Rarities", "Độ hiếm"},
    {"Rarity", "Độ hiếm"},
    {"Name", "Tên"},
    {"Mutations", "Đột biến"},
    {"Areas", "Khu vực"},
    {"Safety", "Bảo Vệ An Toàn"}
}

-- Sắp xếp chuỗi dài lên trước để không nuốt từ ngữ
table.sort(RAW_TRANSLATIONS, function(a, b)
    return #a[1] > #b[1]
end)

local function replacePlain(str, findStr, repStr)
    if typeof(str) ~= "string" or typeof(findStr) ~= "string" or str == "" or findStr == "" then return str end
    local s, e = string.find(str, findStr, 1, true)
    if not s then return str end
    local res = {}
    while s do
        table.insert(res, string.sub(str, 1, s - 1))
        table.insert(res, repStr)
        str = string.sub(str, e + 1)
        s, e = string.find(str, findStr, 1, true)
    end
    table.insert(res, str)
    return table.concat(res)
end

local function translateText(raw)
    if typeof(raw) ~= "string" or raw == "" then return raw end
    local res = raw
    for _, item in ipairs(RAW_TRANSLATIONS) do
        res = replacePlain(res, item[1], item[2])
    end
    return res
end

-- ==================== TẠO THANH GHIM (KHÓA MẶC ĐỊNH Ở ĐỈNH MÀN HÌNH) ====================
local isVietnamese = true
local OriginalTexts = {}

local PinGui = Instance.new("ScreenGui")
PinGui.Name = "Ronnei_TopLockedMaster"
PinGui.ResetOnSpawn = false
PinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PinGui.DisplayOrder = 999999
PinGui.Parent = (gethui and gethui()) or CoreGuiService

local PinBar = Instance.new("Frame", PinGui)
PinBar.Name = "RonneiBar"
PinBar.Size = UDim2.new(0, 540, 0, 38)
PinBar.Position = UDim2.new(0.5, -270, 0, 6) -- Cố định ở mép trên màn hình
PinBar.BackgroundColor3 = THEME.BarBG
PinBar.BorderSizePixel = 0
PinBar.Visible = true

Instance.new("UICorner", PinBar).CornerRadius = UDim.new(0, 8)
local BarStroke = Instance.new("UIStroke", PinBar)
BarStroke.Color = THEME.AccentMint
BarStroke.Thickness = 1.4

-- Kéo thả tự do
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(PinBar)

local TikTokBadge = Instance.new("Frame", PinBar)
TikTokBadge.Size = UDim2.new(0, 160, 0, 24)
TikTokBadge.Position = UDim2.new(0, 10, 0.5, 0)
TikTokBadge.AnchorPoint = Vector2.new(0, 0.5)
TikTokBadge.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", TikTokBadge).CornerRadius = UDim.new(1, 0)

local BadgeStroke = Instance.new("UIStroke", TikTokBadge)
BadgeStroke.Color = THEME.AccentMint
BadgeStroke.Thickness = 1.2

local BadgeGrad = Instance.new("UIGradient", BadgeStroke)
BadgeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 230, 120))
})

local TikTokText = Instance.new("TextLabel", TikTokBadge)
TikTokText.Size = UDim2.new(1, 0, 1, 0)
TikTokText.BackgroundTransparency = 1
TikTokText.Text = "TikTok: ronnei7.htk"
TikTokText.Font = THEME.FontB
TikTokText.TextSize = 11
TikTokText.TextColor3 = THEME.TextMain

task.spawn(function()
    local rot = 0
    while TikTokBadge.Parent do
        rot = (rot + 3) % 360
        BadgeGrad.Rotation = rot
        task.wait(0.04)
    end
end)

local ControlBox = Instance.new("Frame", PinBar)
ControlBox.Size = UDim2.new(0, 210, 0, 26)
ControlBox.Position = UDim2.new(1, -10, 0.5, 0)
ControlBox.AnchorPoint = Vector2.new(1, 0.5)
ControlBox.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 6)

local BoxStroke = Instance.new("UIStroke", ControlBox)
BoxStroke.Color = THEME.Border
BoxStroke.Thickness = 1

local StatusLabel = Instance.new("TextLabel", ControlBox)
StatusLabel.Size = UDim2.new(1, -48, 1, 0)
StatusLabel.Position = UDim2.new(0, 8, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Tiếng Việt (ON)"
StatusLabel.Font = THEME.FontB
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = THEME.AccentMint
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SwitchBtn = Instance.new("TextButton", ControlBox)
SwitchBtn.Size = UDim2.new(0, 36, 0, 18)
SwitchBtn.Position = UDim2.new(1, -42, 0.5, 0)
SwitchBtn.AnchorPoint = Vector2.new(0, 0.5)
SwitchBtn.BackgroundColor3 = THEME.AccentMint
SwitchBtn.Text = ""
SwitchBtn.AutoButtonColor = false
Instance.new("UICorner", SwitchBtn).CornerRadius = UDim.new(1, 0)

local Knob = Instance.new("Frame", SwitchBtn)
Knob.Size = UDim2.new(0, 14, 0, 14)
Knob.Position = UDim2.new(1, -16, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.BorderSizePixel = 0
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

local function setLanguage(state)
    isVietnamese = state
    if isVietnamese then
        StatusLabel.Text = "Tiếng Việt (ON)"
        StatusLabel.TextColor3 = THEME.AccentMint
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, 0)}):Play()
    else
        StatusLabel.Text = "English (OFF)"
        StatusLabel.TextColor3 = THEME.TextSub
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
    end
end

SwitchBtn.MouseButton1Click:Connect(function() setLanguage(not isVietnamese) end)
ControlBox.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        setLanguage(not isVietnamese)
    end
end)

-- Khởi chạy script Fyy gốc
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://fyycommunity.com/"))()
    end)
end)

-- ==================== BỘ NHẬN DIỆN CHỮ KÝ SIDEBAR (MULTI-TAB SIGNATURE) ====================
local SIDEBAR_KEYWORDS = {
    "Overview", "Tổng quan",
    "Steal", "Trộm trứng",
    "Egg Panel", "Bảng trứng",
    "Inventory", "Túi đồ",
    "Eggs", "Trứng",
    "Rewards", "Phần thưởng",
    "Visual", "Hình ảnh",
    "Webhook", "Gói VIP", "Premium",
    "Utility", "Tiện ích",
    "Config", "Cấu hình"
}

local function isFyyWindowContainer(container)
    if container == PinGui or container.Name == "RobloxGui" or container.Name == "PurchasePrompt" then
        return false
    end
    local score = 0
    pcall(function()
        for _, d in ipairs(container:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                local txt = d.Text
                if txt and #txt > 0 then
                    for _, kw in ipairs(SIDEBAR_KEYWORDS) do
                        if txt == kw or txt:find(kw, 1, true) then
                            score = score + 1
                            if score >= 3 then return end
                        end
                    end
                end
            end
        end
    end)
    return score >= 3
end

local function findFyyWindowRoot()
    local scopes = {}
    if gethui then pcall(function() table.insert(scopes, gethui()) end) end
    pcall(function() table.insert(scopes, CoreGuiService) end)
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        table.insert(scopes, LocalPlayer.PlayerGui)
    end

    for _, scope in ipairs(scopes) do
        local ok, children = pcall(function() return scope:GetChildren() end)
        if ok and children then
            for _, child in ipairs(children) do
                if isFyyWindowContainer(child) then
                    return child
                end
            end
        end
    end
    return nil
end

-- ==================== VÒNG LẶP ĐIỀU PHỐI VÀ DỊCH TỨC THỜI ====================
task.spawn(function()
    local fyyRoot = nil
    local fyyWindowFrame = nil

    while true do
        pcall(function()
            if not fyyRoot or not fyyRoot.Parent or not isFyyWindowContainer(fyyRoot) then
                fyyRoot = findFyyWindowRoot()
                fyyWindowFrame = nil
            end

            if fyyRoot then
                local descs = fyyRoot:GetDescendants()

                -- 1. Quét và dịch toàn diện tất cả các nhãn
                for _, elem in ipairs(descs) do
                    if elem:IsA("TextLabel") or elem:IsA("TextButton") then
                        local cur = elem.Text
                        if cur and cur ~= "" then
                            local lastApplied = elem:GetAttribute("Ronnei_LastApplied")
                            if cur ~= lastApplied then
                                OriginalTexts[elem] = cur
                            end

                            local orig = OriginalTexts[elem] or cur

                            if isVietnamese then
                                local vi = translateText(orig)
                                if elem.Text ~= vi then
                                    elem:SetAttribute("Ronnei_LastApplied", vi)
                                    elem.Text = vi
                                end
                            else
                                if elem.Text ~= orig then
                                    elem:SetAttribute("Ronnei_LastApplied", nil)
                                    elem.Text = orig
                                end
                            end
                        end
                    end
                end

                -- 2. Tìm Frame cửa sổ Fyy để căn thanh ghim (KHÓA CHẶT Ở ĐỈNH, KHÔNG BỊ VĂNG XUỐNG ĐÁY)
                if not fyyWindowFrame or not fyyWindowFrame.Parent then
                    local maxArea = 0
                    for _, obj in ipairs(descs) do
                        if obj:IsA("GuiObject") and obj.Visible then
                            local w, h = obj.AbsoluteSize.X, obj.AbsoluteSize.Y
                            if w > 300 and h > 200 and (w * h) > maxArea then
                                maxArea = w * h
                                fyyWindowFrame = obj
                            end
                        end
                    end
                end

                if fyyWindowFrame and fyyWindowFrame.Visible then
                    local winPos = fyyWindowFrame.AbsolutePosition
                    local winSize = fyyWindowFrame.AbsoluteSize
                    
                    -- Khóa an toàn: luôn nằm sát mép trên cửa sổ Fyy (tối thiểu Y = 4)
                    local targetY = math.max(4, winPos.Y - 40)
                    PinBar.Position = UDim2.new(0, winPos.X, 0, targetY)
                    PinBar.Size = UDim2.new(0, winSize.X, 0, 38)
                end
            end
        end)
        task.wait(0.12)
    end
end)
