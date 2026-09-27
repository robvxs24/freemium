-- ==============================================================================
--  WHUB CUSTOM WIDGET - ULTRA STEALTH & COMPACT EDITION V11.0
--  Tối ưu hóa:
--    1. PRE-HOOK STEALTH: Ném Menu và Logo Private Hub ra ngoài trong 0ms (không bị chớp).
--    2. DEFAULT ON: Nút Anti Hit được kích hoạt BẬT SẴN ngay khi khởi động.
--    3. COMPACT PILL UI: Thu nhỏ kích thước chuẩn tỉ lệ 170x38 như ảnh mẫu.
--    4. FIX Ô TRẮNG: Loại bỏ background trắng, giữ icon luôn sắc nét.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. TẠO WIDGET MINI (CHUẨN TỈ LỆ ẢNH 2) ====================
local function createCompactWidget()
    local old = CoreGui:FindFirstChild("WHUB_Compact_Widget")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WHUB_Compact_Widget"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = CoreGui

    -- Khung nền dạng Pill siêu gọn (170x38)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 172, 0, 38)
    Container.AnchorPoint = Vector2.new(0.5, 1)
    Container.Position = UDim2.new(0.5, 0, 1, -16) -- Nằm sát trên Hotbar
    Container.BackgroundColor3 = Color3.fromRGB(18, 14, 32)
    Container.BackgroundTransparency = 0.1
    Container.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Container

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(220, 185, 80) -- Viền Vàng Gold
    UIStroke.Thickness = 1.2
    UIStroke.Parent = Container

    -- Icon Eye (Chống trắng hoàn toàn)
    local EyeImage = Instance.new("ImageLabel")
    EyeImage.Size = UDim2.new(0, 26, 0, 26)
    EyeImage.Position = UDim2.new(0, 6, 0.5, -13)
    EyeImage.Image = "rbxassetid://10650215716"
    EyeImage.BackgroundTransparency = 1
    EyeImage.ScaleType = Enum.ScaleType.Crop
    EyeImage.Parent = Container
    
    local EyeCorner = Instance.new("UICorner")
    EyeCorner.CornerRadius = UDim.new(0, 6)
    EyeCorner.Parent = EyeImage
    
    local EyeStroke = Instance.new("UIStroke")
    EyeStroke.Color = Color3.fromRGB(220, 185, 80)
    EyeStroke.Thickness = 1
    EyeStroke.Parent = EyeImage

    -- Nhãn WHUB
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 75, 0, 13)
    Title.Position = UDim2.new(0, 38, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = "WHUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 10
    Title.TextColor3 = Color3.fromRGB(220, 185, 80)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    -- Nhãn instant tp steal
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 85, 0, 15)
    SubTitle.Position = UDim2.new(0, 38, 0, 18)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "instant tp steal"
    SubTitle.Font = Enum.Font.GothamBlack
    SubTitle.TextSize = 11
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = Container

    -- Công tắc Toggle dạng Pill
    local ToggleTrack = Instance.new("TextButton")
    ToggleTrack.Size = UDim2.new(0, 36, 0, 18)
    ToggleTrack.Position = UDim2.new(1, -42, 0.5, -9)
    -- BẬT SẴN: Màu tím hoạt động
    ToggleTrack.BackgroundColor3 = Color3.fromRGB(110, 45, 185)
    ToggleTrack.Text = ""
    ToggleTrack.Parent = Container

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = ToggleTrack

    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Color = Color3.fromRGB(220, 185, 80)
    TrackStroke.Thickness = 1
    TrackStroke.Parent = ToggleTrack

    -- Con trượt (Knob) - BẬT SẴN: Nằm bên phải
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new(1, -15, 0.5, -6)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleTrack

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    return Container, ToggleTrack, Knob
end

local WidgetContainer, ToggleBtn, ToggleKnob = createCompactWidget()
local isToggled = true -- MẶC ĐỊNH BẬT SẴN
local originalAntiHitBtn = nil
local hasAutoSynced = false

-- Hàm mô phỏng Click
local function forceVirtualClick(targetLabel)
    if not getconnections then return end
    local targetsToClick = {targetLabel}
    if targetLabel.Parent then
        table.insert(targetsToClick, targetLabel.Parent)
        for _, sibling in ipairs(targetLabel.Parent:GetChildren()) do
            if sibling:IsA("TextButton") or sibling:IsA("ImageButton") or sibling:IsA("Frame") then
                table.insert(targetsToClick, sibling)
            end
        end
    end

    for _, t in ipairs(targetsToClick) do
        pcall(function()
            for _, conn in ipairs(getconnections(t.MouseButton1Click)) do conn:Fire() end
            for _, conn in ipairs(getconnections(t.InputBegan)) do
                conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
            end
            for _, conn in ipairs(getconnections(t.InputBegan)) do
                conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
            end
        end)
    end
end

-- Tương tác chuyển đổi Bật/Tắt trên Widget
ToggleBtn.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    if isToggled then
        TweenService:Create(ToggleKnob, TweenInfo.new(0.18), {Position = UDim2.new(1, -15, 0.5, -6)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(110, 45, 185)}):Play()
    else
        TweenService:Create(ToggleKnob, TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0.5, -6)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(40, 20, 75)}):Play()
    end

    if originalAntiHitBtn then
        forceVirtualClick(originalAntiHitBtn)
    end
end)

-- ==================== 2. MAI PHỤC TRIỆT ĐỂ: PHANTOM SWIPE 0MS ====================
local function hideOriginalElement(inst)
    if not inst then return end
    pcall(function()
        inst.Position = UDim2.new(9999, 0, 9999, 0)
        inst.Visible = false
        if inst:IsA("GuiObject") then
            inst.Active = false
        end
    end)
end

local function checkAndHideTarget(desc)
    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
        local txt = ""
        pcall(function() txt = desc.Text:lower() end)
        local name = desc.Name:lower()

        -- Nhận diện Menu hoặc Logo Private Hub
        if txt:find("private") or txt:find("anti hit") or txt:find("steal an egg") or name:find("private") then
            local rootScreen = desc:FindFirstAncestorOfClass("ScreenGui")
            if rootScreen and rootScreen.Name ~= "WHUB_Compact_Widget" then
                -- Đẩy toàn bộ các khung con cấp cao nhất ra ngoài màn hình
                for _, child in ipairs(rootScreen:GetChildren()) do
                    hideOriginalElement(child)
                end
            end

            -- Nhận diện và liên kết nút Anti Hit
            if txt:find("anti hit") and not originalAntiHitBtn then
                originalAntiHitBtn = desc
                -- Tự động kích hoạt bật nếu script gốc đang tắt
                if not hasAutoSynced then
                    hasAutoSynced = true
                    task.defer(function()
                        if txt:find("off") or not txt:find("on") then
                            forceVirtualClick(desc)
                        end
                    end)
                end
            end
        end
    end
end

-- Mai phục từ trước khi script tải: bắt mọi phần tử sinh ra
local searchRoots = {CoreGui, LocalPlayer:WaitForChild("PlayerGui")}
if gethui then pcall(function() table.insert(searchRoots, gethui()) end) end

for _, root in ipairs(searchRoots) do
    root.DescendantAdded:Connect(function(desc)
        checkAndHideTarget(desc)
    end)
end

-- Quét thần tốc từng frame trong 4 giây đầu để diệt tận gốc mọi logo vẽ trễ
task.spawn(function()
    local startTime = tick()
    while tick() - startTime < 4 do
        RunService.RenderStepped:Wait()
        for _, root in ipairs(searchRoots) do
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "WHUB_Compact_Widget" then
                    for _, desc in ipairs(gui:GetDescendants()) do
                        checkAndHideTarget(desc)
                    end
                end
            end
        end
    end
end)

-- ==================== 3. KÍCH HOẠT SCRIPT PRIVATE HUB ====================
getgenv().SCRIPT_KEY = "KEYLESS"
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ba8f09cf06d30d431b514907755c5ca97a771538d4c441642b311911f0ae86f7/download"))()
    end)
end)
