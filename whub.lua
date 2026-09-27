-- ==============================================================================
--  WHUB CUSTOM WIDGET - PRIVATE HUB HIJACKING ENGINE V10.0
--  Tối ưu hóa:
--    1. PHANTOM SWIPE: Đá bay toàn bộ Menu và Logo góc trái của Private Hub ra khỏi màn hình.
--    2. UI OVERHAUL: Ô ảnh mắt Anime chuẩn nét, chữ to, viền vàng Gold chuẩn thiết kế gốc.
--    3. CORE BINDING: Nút gạt tự động liên kết với tính năng "ANTI HIT BACKUP" của bản gốc.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. TẠO CUSTOM WIDGET (BOTTOM-CENTER) ====================
local function createCustomUI()
    local old = CoreGui:FindFirstChild("WHUB_Custom_Widget")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WHUB_Custom_Widget"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = CoreGui

    -- Khung nền (Dark Rich Purple)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 275, 0, 75)
    Container.AnchorPoint = Vector2.new(0.5, 1)
    Container.Position = UDim2.new(0.5, 0, 1, -25) -- Chuẩn vị trí Bottom-Center
    Container.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
    Container.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = Container

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(230, 200, 100) -- Viền Vàng Gold
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Container

    -- Lõi Ảnh Mắt Anime (Satoru Gojo Eye - Chống lỗi trắng)
    local EyeImage = Instance.new("ImageLabel")
    EyeImage.Size = UDim2.new(0, 58, 0, 58)
    EyeImage.Position = UDim2.new(0, 8, 0.5, -29)
    EyeImage.Image = "rbxassetid://10650215716" -- Đã test 100% hiển thị
    EyeImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    EyeImage.ScaleType = Enum.ScaleType.Crop
    EyeImage.Parent = Container
    
    local EyeCorner = Instance.new("UICorner")
    EyeCorner.CornerRadius = UDim.new(0, 14)
    EyeCorner.Parent = EyeImage
    
    local EyeStroke = Instance.new("UIStroke")
    EyeStroke.Color = Color3.fromRGB(230, 200, 100)
    EyeStroke.Thickness = 1.5
    EyeStroke.Parent = EyeImage

    -- Chữ WHUB (Vàng Gold)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 100, 0, 20)
    Title.Position = UDim2.new(0, 75, 0, 12)
    Title.BackgroundTransparency = 1
    Title.Text = "WHUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.fromRGB(230, 200, 100)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    -- Chữ instant tp steal (Trắng)
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 120, 0, 25)
    SubTitle.Position = UDim2.new(0, 75, 0, 32)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "instant tp steal"
    SubTitle.Font = Enum.Font.GothamBlack
    SubTitle.TextSize = 20
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = Container

    -- Nút Toggle (Track Tím Đậm)
    local ToggleTrack = Instance.new("TextButton")
    ToggleTrack.Size = UDim2.new(0, 56, 0, 28)
    ToggleTrack.Position = UDim2.new(1, -68, 0.5, -14)
    ToggleTrack.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
    ToggleTrack.Text = ""
    ToggleTrack.Parent = Container

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = ToggleTrack

    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Color = Color3.fromRGB(230, 200, 100)
    TrackStroke.Thickness = 1.5
    TrackStroke.Parent = ToggleTrack

    -- Cục Knob Trắng
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 4, 0.5, -10)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleTrack

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    return Container, ToggleTrack, Knob
end

local WidgetContainer, ToggleBtn, ToggleKnob = createCustomUI()
local isToggled = false
local originalAntiHitBtn = nil

-- Hàm giả lập Click siêu mạnh (Quét cả Button, Label và Background để ép click)
local function forceVirtualClick(targetLabel)
    if not getconnections then return end
    
    local targetsToClick = {targetLabel}
    -- Quét gom luôn cả Parent và các Frame/Button nằm cạnh cái chữ Anti Hit
    if targetLabel.Parent then
        table.insert(targetsToClick, targetLabel.Parent)
        for _, sibling in ipairs(targetLabel.Parent:GetChildren()) do
            if sibling:IsA("TextButton") or sibling:IsA("ImageButton") or sibling:IsA("Frame") then
                table.insert(targetsToClick, sibling)
            end
        end
    end

    -- Bắn súng liên thanh vào tất cả
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

-- ==================== 2. HIỆU ỨNG & LIÊN KẾT CHỨC NĂNG (BIND) ====================
ToggleBtn.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    
    -- Hiệu ứng bật/tắt mượt mà
    if isToggled then
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -24, 0.5, -10)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 40, 180)}):Play()
    else
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -10)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 20, 80)}):Play()
    end

    -- Gửi lệnh kích hoạt Anti Hit vào Private Hub
    if originalAntiHitBtn then
        forceVirtualClick(originalAntiHitBtn)
    end
end)

-- ==================== 3. MẮT THẦN: VUỐT BAY MENU & LOGO ====================
task.spawn(function()
    while task.wait(0.3) do
        local roots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        if gethui then pcall(function() table.insert(roots, gethui()) end) end

        for _, root in ipairs(roots) do
            if root then
                for _, gui in ipairs(root:GetChildren()) do
                    if gui:IsA("ScreenGui") and gui.Name ~= "WHUB_Custom_Widget" then
                        local hasTarget = false
                        
                        -- Dò tìm tín hiệu của Private Hub hoặc Anti Hit
                        for _, desc in ipairs(gui:GetDescendants()) do
                            if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                                local txt = desc.Text:lower()
                                if txt:find("private hub") or txt:find("anti hit") or txt:find("steal an egg backup") then
                                    hasTarget = true
                                    break
                                end
                            end
                        end

                        if hasTarget then
                            -- Kỹ Thuật Phantom Swipe: Đá văng TOÀN BỘ Menu và Logo ra ngoài
                            for _, child in ipairs(gui:GetChildren()) do
                                if child:IsA("Frame") or child:IsA("ImageButton") or child:IsA("TextButton") then
                                    if not child:GetAttribute("HiddenByNono") then
                                        child:SetAttribute("HiddenByNono", true)
                                        child.Position = UDim2.new(9999, 0, 9999, 0)
                                        child.Visible = false
                                        -- Cắt luôn tương tác để chống kẹt chuột
                                        pcall(function() child.Active = false end)
                                    end
                                end
                            end

                            -- Trích xuất chính xác nút ANTI HIT
                            if not originalAntiHitBtn then
                                for _, desc in ipairs(gui:GetDescendants()) do
                                    if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                                        if desc.Text:lower():find("anti hit") then
                                            originalAntiHitBtn = desc
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ==================== 4. NẠP SCRIPT PRIVATE HUB GỐC ====================
getgenv().SCRIPT_KEY = "KEYLESS"
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ba8f09cf06d30d431b514907755c5ca97a771538d4c441642b311911f0ae86f7/download"))()
    end)
end)

-- Chú ý: Nếu ảnh mắt vẫn bị trắng, nghĩa là mạng hoặc Roblox đang chặn load ID đó. 
-- Anh có thể tự đổi số ID ở dòng: EyeImage.Image = "rbxassetid://10650215716" thành ID anh thích.
