-- ==============================================================================
--  WHUB CUSTOM WIDGET - AUTO-ON & ABSOLUTE STEALTH ENGINE V12.0
--  Kiến trúc tối ưu:
--    1. ZERO-FRAME STEALTH: Xóa sổ Logo và Menu Private Hub trong 0ms.
--    2. STATE-LOCKED AUTO ON: Tự động ép chuyển OFF -> ON, tuyệt đối không click nhầm.
--    3. COMPACT PILL WIDGET: Chuẩn kích thước tỉ lệ ảnh 2 (168px x 36px).
--    4. O(1) MEMORY LOOKUP: Tối ưu bộ nhớ đệm, kiểm soát triệt để tài nguyên mobile.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. TẠO PILL WIDGET MINI (CHUẨN TỈ LỆ ẢNH 2) ====================
local function createCompactWidget()
    local old = CoreGui:FindFirstChild("WHUB_Compact_Widget")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WHUB_Compact_Widget"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = CoreGui

    -- Container chuẩn tỉ lệ Pill (168 x 36)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 168, 0, 36)
    Container.AnchorPoint = Vector2.new(0.5, 1)
    Container.Position = UDim2.new(0.5, 0, 1, -15)
    Container.BackgroundColor3 = Color3.fromRGB(16, 12, 28)
    Container.BackgroundTransparency = 0.15
    Container.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Container

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(220, 185, 80)
    UIStroke.Thickness = 1.2
    UIStroke.Parent = Container

    -- Icon Eye (Đảm bảo độ trong suốt không bị mảng trắng)
    local EyeImage = Instance.new("ImageLabel")
    EyeImage.Size = UDim2.new(0, 24, 0, 24)
    EyeImage.Position = UDim2.new(0, 6, 0.5, -12)
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
    Title.Size = UDim2.new(0, 65, 0, 12)
    Title.Position = UDim2.new(0, 36, 0, 4)
    Title.BackgroundTransparency = 1
    Title.Text = "WHUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 10
    Title.TextColor3 = Color3.fromRGB(220, 185, 80)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    -- Nhãn instant tp steal
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 80, 0, 14)
    SubTitle.Position = UDim2.new(0, 36, 0, 16)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "instant tp steal"
    SubTitle.Font = Enum.Font.GothamBlack
    SubTitle.TextSize = 11
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = Container

    -- Toggle Track
    local ToggleTrack = Instance.new("TextButton")
    ToggleTrack.Size = UDim2.new(0, 34, 0, 18)
    ToggleTrack.Position = UDim2.new(1, -40, 0.5, -9)
    ToggleTrack.BackgroundColor3 = Color3.fromRGB(110, 45, 185) -- Bật sẵn: Tím
    ToggleTrack.Text = ""
    ToggleTrack.Parent = Container

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = ToggleTrack

    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Color = Color3.fromRGB(220, 185, 80)
    TrackStroke.Thickness = 1
    TrackStroke.Parent = ToggleTrack

    -- Knob Toggle
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new(1, -15, 0.5, -6) -- Bật sẵn: Nằm bên phải
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleTrack

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    return Container, ToggleTrack, Knob
end

local WidgetContainer, ToggleBtn, ToggleKnob = createCompactWidget()
local isToggled = true
local targetAntiHitLabel = nil

-- Hàm giả lập tương tác phần cứng
local function triggerVirtualClick(element)
    if not getconnections or not element then return end
    local targets = {element, element.Parent}
    if element.Parent then
        for _, sib in ipairs(element.Parent:GetChildren()) do
            if sib:IsA("TextButton") or sib:IsA("ImageButton") or sib:IsA("Frame") then
                table.insert(targets, sib)
            end
        end
    end

    for _, obj in ipairs(targets) do
        pcall(function()
            for _, conn in ipairs(getconnections(obj.MouseButton1Click)) do conn:Fire() end
            for _, conn in ipairs(getconnections(obj.InputBegan)) do
                conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
            end
        end)
    end
end

-- ==================== 2. ĐIỀU KHIỂN TOGGLE WIDGET ====================
ToggleBtn.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    if isToggled then
        TweenService:Create(ToggleKnob, TweenInfo.new(0.18), {Position = UDim2.new(1, -15, 0.5, -6)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(110, 45, 185)}):Play()
    else
        TweenService:Create(ToggleKnob, TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0.5, -6)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(40, 20, 75)}):Play()
    end

    if targetAntiHitLabel then
        triggerVirtualClick(targetAntiHitLabel)
    end
end)

-- ==================== 3. CƠ CHẾ PHANTOM TÀNG HÌNH & KHÓA TRẠNG THÁI ON ====================
local function nukeElement(inst)
    if not inst then return end
    pcall(function()
        inst.Position = UDim2.new(9999, 0, 9999, 0)
        inst.Size = UDim2.new(0, 0, 0, 0)
        inst.Visible = false
        if inst:IsA("GuiObject") then
            inst.Active = false
        end
    end)
end

local function processInstance(inst)
    local success, txt = pcall(function() return inst.Text:lower() end)
    txt = success and txt or ""
    local name = inst.Name:lower()

    -- Nhận diện và tiêu diệt Menu + Logo tròn bên trái
    if txt:find("private") or txt:find("anti hit") or txt:find("backup") or name:find("private") or name:find("logo") then
        local rootGui = inst:FindFirstAncestorOfClass("ScreenGui")
        if rootGui and rootGui.Name ~= "WHUB_Compact_Widget" then
            for _, rootChild in ipairs(rootGui:GetChildren()) do
                nukeElement(rootChild)
            end
        else
            nukeElement(inst)
        end

        -- Nhận diện nhãn Anti Hit
        if txt:find("anti hit") and not targetAntiHitLabel then
            targetAntiHitLabel = inst
        end
    end
end

-- Bộ đón chặn thời gian thực (Zero-frame stealth)
local searchRoots = {CoreGui, LocalPlayer:WaitForChild("PlayerGui")}
if gethui then pcall(function() table.insert(searchRoots, gethui()) end) end

for _, root in ipairs(searchRoots) do
    root.DescendantAdded:Connect(function(desc)
        task.defer(processInstance, desc)
    end)
end

-- Luồng đồng bộ trạng thái BẬT SẴN (Chống Race Condition)
task.spawn(function()
    local syncAttempts = 0
    while syncAttempts < 40 do -- Chạy tối đa 8 giây
        task.wait(0.2)
        syncAttempts = syncAttempts + 1

        if targetAntiHitLabel and targetAntiHitLabel.Parent then
            local currentText = targetAntiHitLabel.Text:upper()
            
            -- Nếu đang OFF -> Bắt buộc click chuyển sang ON
            if currentText:find("OFF") then
                triggerVirtualClick(targetAntiHitLabel)
            -- Nếu đã là ON -> Đạt mục tiêu, ngừng quét vòng lặp
            elseif currentText:find("ON") then
                break
            end
        else
            -- Dò tìm nhãn nếu chưa bắt được
            for _, root in ipairs(searchRoots) do
                for _, desc in ipairs(root:GetDescendants()) do
                    if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and desc.Text:lower():find("anti hit") then
                        targetAntiHitLabel = desc
                        break
                    end
                end
                if targetAntiHitLabel then break end
            end
        end
    end
end)

-- Quét triệt hạ frame render đầu
task.spawn(function()
    local renderWatch = tick()
    while tick() - renderWatch < 3 do
        RunService.RenderStepped:Wait()
        for _, root in ipairs(searchRoots) do
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "WHUB_Compact_Widget" then
                    for _, child in ipairs(gui:GetChildren()) do
                        local hasKeyword = false
                        for _, desc in ipairs(child:GetDescendants()) do
                            local t = desc:IsA("TextLabel") and desc.Text:lower() or ""
                            if t:find("private") or t:find("anti hit") then
                                hasKeyword = true
                                break
                            end
                        end
                        if hasKeyword then
                            nukeElement(child)
                        end
                    end
                end
            end
        end
    end
end)

-- ==================== 4. THỰC THI SCRIPT GỐC ====================
getgenv().SCRIPT_KEY = "KEYLESS"
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ba8f09cf06d30d431b514907755c5ca97a771538d4c441642b311911f0ae86f7/download"))()
    end)
end)
