-- ==============================================================================
--  RONNEI HUB - 100% PERFECT HEADER DOCK & FULL REWARDS LOCALIZATION
--  Tự ẩn khi bấm nút [-], chừa rộng 150px lộ rõ 3 nút, dịch chuẩn 100% Phần Thưởng
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn sạch bản cũ
local cleanList = {
    "Ronnei_PinMaster_Diagnostic", 
    "Ronnei_UniversalPinMaster", 
    "Ronnei_DirectHookMaster", 
    "Ronnei_FixedTargetMaster",
    "Ronnei_AllTabsMaster",
    "Ronnei_TopLockedMaster",
    "Ronnei_UltimateMaster",
    "Ronnei_HeaderDockedMaster",
    "Ronnei_PerfectDockMaster"
}
for _, name in ipairs(cleanList) do
    pcall(function()
        if CoreGuiService:FindFirstChild(name) then CoreGuiService[name]:Destroy() end
        if gethui and gethui():FindFirstChild(name) then gethui()[name]:Destroy() end
    end)
end

local THEME = {
    BarBG      = Color3.fromRGB(16, 17, 24),       -- Đen tím chuẩn màu nền Header Fyy
    CardBG     = Color3.fromRGB(24, 27, 38),       -- Nền thẻ nút
    Border     = Color3.fromRGB(45, 55, 75),       -- Viền kim loại mảnh
    AccentMint = Color3.fromRGB(0, 230, 120),      -- Xanh ngọc Cyber Mint
    ToggleOff  = Color3.fromRGB(38, 43, 56),       -- Nút khi tắt (OFF)
    TextMain   = Color3.fromRGB(245, 248, 255),    -- Màu chữ chính
    TextSub    = Color3.fromRGB(150, 160, 180),    -- Màu chữ phụ
    FontB      = Enum.Font.GothamBold,
    FontM      = Enum.Font.GothamMedium
}

-- ==================== BẢNG TỪ ĐIỂN TỔNG HỢP TOÀN BỘ CÁC TAB ====================
local RAW_TRANSLATIONS = {
    -- 1. TAB PHẦN THƯỞNG (REWARDS) - KHẮC PHỤC TRIỆT ĐỂ
    {"Claim All Index Rewards", "Nhận Hết Thưởng Sưu Tập"},
    {"Claim All Index Phần thưởng", "Nhận Hết Thưởng Sưu Tập"},
    {"Index Rewards", "Phần Thưởng Sưu Tập (Index)"},
    {"Index Phần thưởng", "Phần Thưởng Sưu Tập (Index)"},
    {"Auto Claim Offline Money", "Tự Nhận Tiền Ngoại Tuyến"},
    {"Claim Offline Money", "Nhận Tiền Ngoại Tuyến"},
    {"Offline Money", "Tiền Ngoại Tuyến (Offline)"},
    {"Auto Claim Index", "Tự Nhận Thưởng Sưu Tập"},

    -- 2. TAB HÌNH ẢNH (VISUAL / ESP)
    {"Plot Egg ESP", "ESP Trứng Khu Đất"},
    {"Egg ESP", "ESP Trứng"},
    {"ESP Details", "Chi Tiết ESP"},
    {"ESP Value", "Hiển Thị Giá Trị Trứng"},
    {"Weight (Kg)", "Khối lượng (Kg)"},
    {"Rarity", "Độ hiếm"},
    {"Name", "Tên"},

    -- 3. TAB WEBHOOK
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
    {"Announce Egg Spawns", "Thông Báo Trứng Xuất Hiện"},
    {"Tag Everyone On Steal", "Tag @everyone Khi Trộm Trứng"},
    {"Tag Everyone On Trộm trứng", "Tag @everyone Khi Trộm Trứng"},
    {"Alert Roblox Disconnect", "Cảnh Báo Mất Kết Nối Roblox"},
    {"Send Now", "Gửi Ngay"},
    {"Select...", "Chọn..."},

    -- 4. TAB GÓI VIP (PREMIUM)
    {"Dashboard Monitoring", "Giám Sát Bảng Điều Khiển"},
    {"Premium Access", "Quyền Truy Cập VIP"},
    {"Gói VIP Access", "Quyền Truy Cập VIP"},
    {"Pair your dashboard account once and keep monitoring enabled automatically.", "Ghép nối tài khoản một lần để tự động duy trì giám sát."},
    {"Pairing Code", "Mã Ghép Nối"},
    {"Connect", "Kết Nối"},
    {"Enable Monitoring", "Bật Giám Sát"},

    -- 5. TAB TIỆN ÍCH (UTILITY)
    {"Performance", "Hiệu Năng"},
    {"Boost FPS", "Tăng Tốc FPS (Giảm Lag)"},
    {"Server", "Máy Chủ"},
    {"Auto Server Hop", "Tự Đổi Máy Chủ"},
    {"Auto Upgrades", "Tự Động Nâng Cấp"},
    {"Target Treadmill Lv (0 = max)", "Cấp Máy Chạy Mục Tiêu (0 = max)"},
    {"Target Base Lv (0 = max)", "Cấp Căn Cứ Mục Tiêu (0 = max)"},
    {"Auto Upgrade Treadmill", "Tự Nâng Cấp Máy Chạy"},
    {"Auto Upgrade Base", "Tự Nâng Cấp Căn Cứ"},

    -- 6. TAB CẤU HÌNH (CONFIG)
    {"Configurations", "Quản Lý Cấu Hình"},
    {"Profile Name", "Tên Cấu Hình"},
    {"Profile", "Cấu Hình"},
    {"Save Config", "Lưu Cấu Hình"},
    {"Load Config", "Tải Cấu Hình"},
    {"Delete Config", "Xóa Cấu Hình"},
    {"No saved profiles", "Chưa có cấu hình lưu"},
    {"No profiles", "Không có cấu hình"},
    {"Automatic Startup", "Tự Động Khởi Động"},
    {"No profile selected", "Chưa chọn cấu hình"},
    {"Select and save a profile, then enable automatic loading.", "Chọn và lưu cấu hình, rồi bật tự nạp."},
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

    -- 7. TAB TÚI ĐỒ (INVENTORY)
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

    -- 8. TAB TRỘM TRỨNG (STEAL)
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

    -- 9. TAB TỔNG QUAN (OVERVIEW)
    {"Your account and current session", "Tài khoản và phiên chơi hiện tại"},
    {"Get help or join the community", "Nhận trợ giúp hoặc vào Discord"},
    {"Need Support?", "Cần hỗ trợ?"},
    {"Join Discord", "Vào Discord"},
    {"Connected", "Đã kết nối"},

    -- 10. THÔNG SỐ RUNTIME
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
    {"Default", "Mặc định"},
    {"MANUAL", "THỦ CÔNG"},
    {"Refresh", "Làm Mới"},

    -- 11. SIDEBAR TABS
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
    {"Mutations", "Đột biến"},
    {"Areas", "Khu vực"},
    {"Safety", "Bảo Vệ An Toàn"}
}

-- Sắp xếp chuỗi dài lên trước để không bị nuốt chuỗi con
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

-- ==================== TẠO THANH GHIM DOCKED VÀO HEADER ====================
local isVietnamese = true
local OriginalTexts = {}
local targetFyyWindow = nil

local PinGui = Instance.new("ScreenGui")
PinGui.Name = "Ronnei_PerfectDockMaster"
PinGui.ResetOnSpawn = false
PinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PinGui.DisplayOrder = 999999
PinGui.Parent = (gethui and gethui()) or CoreGuiService

local PinBar = Instance.new("Frame", PinGui)
PinBar.Name = "RonneiHeaderBar"
PinBar.Size = UDim2.new(0, 430, 0, 32)
PinBar.Position = UDim2.new(0, 0, 0, -100)
PinBar.BackgroundColor3 = THEME.BarBG
PinBar.BorderSizePixel = 0
PinBar.Visible = false

Instance.new("UICorner", PinBar).CornerRadius = UDim.new(0, 6)
local BarStroke = Instance.new("UIStroke", PinBar)
BarStroke.Color = THEME.AccentMint
BarStroke.Thickness = 1.2

-- Nhấn giữ thanh để kéo cả cửa sổ Fyy
local dragging, dragStart, startWinPos = false, nil, nil
PinBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if targetFyyWindow and targetFyyWindow.Parent then
            dragging = true
            dragStart = input.Position
            startWinPos = targetFyyWindow.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if targetFyyWindow and targetFyyWindow.Parent then
            local delta = input.Position - dragStart
            targetFyyWindow.Position = UDim2.new(startWinPos.X.Scale, startWinPos.X.Offset + delta.X, startWinPos.Y.Scale, startWinPos.Y.Offset + delta.Y)
        end
    end
end)

-- Huy hiệu TikTok Ronnei Hub
local TikTokBadge = Instance.new("Frame", PinBar)
TikTokBadge.Size = UDim2.new(0, 145, 0, 22)
TikTokBadge.Position = UDim2.new(0, 6, 0.5, 0)
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

-- Nút gạt chuyển ngôn ngữ ON / OFF
local ControlBox = Instance.new("Frame", PinBar)
ControlBox.Size = UDim2.new(0, 175, 0, 24)
ControlBox.Position = UDim2.new(1, -6, 0.5, 0)
ControlBox.AnchorPoint = Vector2.new(1, 0.5)
ControlBox.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 6)

local BoxStroke = Instance.new("UIStroke", ControlBox)
BoxStroke.Color = THEME.Border
BoxStroke.Thickness = 1

local StatusLabel = Instance.new("TextLabel", ControlBox)
StatusLabel.Size = UDim2.new(1, -44, 1, 0)
StatusLabel.Position = UDim2.new(0, 8, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Tiếng Việt (ON)"
StatusLabel.Font = THEME.FontB
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = THEME.AccentMint
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SwitchBtn = Instance.new("TextButton", ControlBox)
SwitchBtn.Size = UDim2.new(0, 34, 0, 16)
SwitchBtn.Position = UDim2.new(1, -38, 0.5, 0)
SwitchBtn.AnchorPoint = Vector2.new(0, 0.5)
SwitchBtn.BackgroundColor3 = THEME.AccentMint
SwitchBtn.Text = ""
SwitchBtn.AutoButtonColor = false
Instance.new("UICorner", SwitchBtn).CornerRadius = UDim.new(1, 0)

local Knob = Instance.new("Frame", SwitchBtn)
Knob.Size = UDim2.new(0, 12, 0, 12)
Knob.Position = UDim2.new(1, -14, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.BorderSizePixel = 0
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

local function updateLanguage(state)
    isVietnamese = state
    if isVietnamese then
        StatusLabel.Text = "Tiếng Việt (ON)"
        StatusLabel.TextColor3 = THEME.AccentMint
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, 0)}):Play()
    else
        StatusLabel.Text = "English (OFF)"
        StatusLabel.TextColor3 = THEME.TextSub
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
    end
end

SwitchBtn.MouseButton1Click:Connect(function() updateLanguage(not isVietnamese) end)
ControlBox.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        updateLanguage(not isVietnamese)
    end
end)

-- Khởi chạy script Fyy gốc
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://fyycommunity.com/"))()
    end)
end)

-- ==================== BỘ QUÉT TẦNG BỘ NHỚ VÀ DỊCH TẬN GỐC ====================
local function findFyyWindow()
    local function scanRoot(root)
        if not root then return nil end
        local ok, descs = pcall(function() return root:GetDescendants() end)
        if not ok or not descs then return nil end
        for _, obj in ipairs(descs) do
            if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and not obj:IsDescendantOf(PinGui) then
                local t = obj.Text
                if t == "Overview" or t == "Tổng quan" or t == "Steal" or t == "Trộm trứng" or t:find("Fyy", 1, true) then
                    local p = obj
                    while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= root do
                        p = p.Parent
                    end
                    if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 320 and p.AbsoluteSize.Y > 200 then
                        return p
                    end
                end
            end
        end
        return nil
    end

    local found = nil
    if gethui then found = scanRoot(gethui()) end
    if not found then found = scanRoot(CoreGuiService) end
    if not found and LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then found = scanRoot(LocalPlayer.PlayerGui) end
    if not found and getinstances then
        for _, ins in ipairs(getinstances()) do
            if (ins:IsA("TextLabel") or ins:IsA("TextButton")) and not ins:IsDescendantOf(PinGui) then
                local t = ins.Text
                if t == "Overview" or t == "Tổng quan" or t == "Steal" or t == "Trộm trứng" then
                    local p = ins
                    while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= game do
                        p = p.Parent
                    end
                    if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 320 and p.AbsoluteSize.Y > 200 then
                        return p
                    end
                end
            end
        end
    end
    return found
end

-- Vòng lặp khóa vị trí RenderStepped: Tự ẩn khi thu nhỏ & chừa rộng 150px
RunService.RenderStepped:Connect(function()
    if targetFyyWindow and targetFyyWindow.Parent and targetFyyWindow.Visible then
        local winSize = targetFyyWindow.AbsoluteSize
        local winPos = targetFyyWindow.AbsolutePosition

        -- Khi bấm dấu trừ [-], chiều cao cửa sổ bị co nhỏ lại (< 100px) hoặc ẩn đi: Tự động ẩn thanh ghim
        if winSize.Y < 100 then
            PinBar.Visible = false
        else
            PinBar.Visible = true
            -- Chừa rộng 150px bên phải để lộ trọn vẹn cả 3 nút [-] [□] [X]
            local targetWidth = math.max(200, winSize.X - 150)
            PinBar.Position = UDim2.new(0, winPos.X + 4, 0, winPos.Y + 2)
            PinBar.Size = UDim2.new(0, targetWidth, 0, 32)
        end
    else
        PinBar.Visible = false
    end
end)

-- Vòng lặp quét và áp dụng dịch trực tiếp
task.spawn(function()
    while true do
        pcall(function()
            if not targetFyyWindow or not targetFyyWindow.Parent then
                targetFyyWindow = findFyyWindow()
            end

            if targetFyyWindow then
                local descs = targetFyyWindow:GetDescendants()
                for _, elem in ipairs(descs) do
                    if (elem:IsA("TextLabel") or elem:IsA("TextButton")) and not elem:IsDescendantOf(PinGui) then
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
            end
        end)
        task.wait(0.12)
    end
end)
