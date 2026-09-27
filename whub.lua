-- ==============================================================================
--  WHUB DUAL-CORE WIDGET - PHANTOM HIJACKING ENGINE
--  Tối ưu hóa:
--    1. Time-Snapshotting: Nhận diện và tóm gọn UI của script ngay khi vừa load.
--    2. Shadow Realm: Bắn tọa độ của Menu và Logo gốc ra 9999, xóa sổ khỏi tầm nhìn.
--    3. Dual-Toggle Widget: Tích hợp cả "Instant TP Steal" và "Anti Hit".
--    4. Chạy ngầm 100% chức năng cốt lõi của WHUB.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. CHỤP ẢNH KHÔNG GIAN (TRƯỚC KHI LOAD) ====================
local existingGuis = {}
for _, gui in ipairs(CoreGui:GetChildren()) do existingGuis[gui] = true end
if LocalPlayer:FindFirstChild("PlayerGui") then
    for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do existingGuis[gui] = true end
end

local targetButtons = {
    tpSteal = nil,
    antiHit = nil
}

-- ==================== 2. TẠO CUSTOM WIDGET (BOTTOM-CENTER) ====================
local function createCustomUI()
    local old = CoreGui:FindFirstChild("WHUB_Custom_Widget")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WHUB_Custom_Widget"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = CoreGui

    -- Khung nền (Dark Blue/Purple)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 260, 0, 100) -- Kéo dài để chứa 2 nút
    Container.AnchorPoint = Vector2.new(0.5, 1)
    Container.Position = UDim2.new(0.5, 0, 1, -25) 
    Container.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
    Container.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = Container

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(220, 190, 80) -- Viền Vàng Gold
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Container

    -- Logo Anime Eye
    local EyeImage = Instance.new("ImageLabel")
    EyeImage.Size = UDim2.new(0, 60, 0, 60)
    EyeImage.Position = UDim2.new(0, 12, 0.5, -30)
    EyeImage.Image = "rbxassetid://13580436940" 
    EyeImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    EyeImage.Parent = Container
    
    local EyeCorner = Instance.new("UICorner")
    EyeCorner.CornerRadius = UDim.new(0, 12)
    EyeCorner.Parent = EyeImage
    
    local EyeStroke = Instance.new("UIStroke")
    EyeStroke.Color = Color3.fromRGB(220, 190, 80)
    EyeStroke.Thickness = 1.5
    EyeStroke.Parent = EyeImage

    -- Chữ WHUB (Tiêu đề)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 100, 0, 20)
    Title.Position = UDim2.new(0, 85, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "WHUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(220, 190, 80)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    -- Hàm tạo các hàng Toggle (Công tắc)
    local function createToggleRow(yPos, labelText, keyName)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0, 110, 0, 20)
        Label.Position = UDim2.new(0, 85, 0, yPos)
        Label.BackgroundTransparency = 1
        Label.Text = labelText
        Label.Font = Enum.Font.GothamBlack
        Label.TextSize = 15
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container

        local Track = Instance.new("TextButton")
        Track.Size = UDim2.new(0, 46, 0, 24)
        Track.Position = UDim2.new(1, -60, 0, yPos - 2)
        Track.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
        Track.Text = ""
        Track.Parent = Container

        local TrackCorner = Instance.new("UICorner")
        TrackCorner.CornerRadius = UDim.new(1, 0)
        TrackCorner.Parent = Track

        local TrackStroke = Instance.new("UIStroke")
        TrackStroke.Color = Color3.fromRGB(220, 190, 80)
        TrackStroke.Thickness = 1.5
        TrackStroke.Parent = Track

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 16, 0, 16)
        Knob.Position = UDim2.new(0, 4, 0.5, -8)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.Parent = Track

        local KnobCorner = Instance.new("UICorner")
        KnobCorner.CornerRadius = UDim.new(1, 0)
        KnobCorner.Parent = Knob

        -- Logic Bật/Tắt & Liên kết
        local isToggled = false
        Track.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            if isToggled then
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -20, 0.5, -8)}):Play()
                TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 40, 180)}):Play()
            else
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -8)}):Play()
                TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 20, 80)}):Play()
            end

            -- Bắn lệnh ảo (Virtual Click) vào nút gốc đang tàng hình
            local targetBtn = targetButtons[keyName]
            if targetBtn and getconnections then
                pcall(function()
                    for _, conn in ipairs(getconnections(targetBtn.MouseButton1Click)) do conn:Fire() end
                    for _, conn in ipairs(getconnections(targetBtn.InputBegan)) do
                        conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                    end
                end)
            end
        end)
    end

    -- Khởi tạo 2 hàng công tắc
    createToggleRow(35, "instant tp steal", "tpSteal")
    createToggleRow(65, "anti hit", "antiHit")
end

createCustomUI()

-- ==================== 3. MẮT THẦN: TÀNG HÌNH UI & LIÊN KẾT NÚT ====================
task.spawn(function()
    while task.wait(0.5) do
        local roots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        if gethui then pcall(function() table.insert(roots, gethui()) end) end

        for _, root in ipairs(roots) do
            if root then
                for _, gui in ipairs(root:GetChildren()) do
                    -- Nếu phát hiện UI MỚI (chưa có trước khi load) và không phải là Widget của ta
                    if not existingGuis[gui] and gui.Name ~= "WHUB_Custom_Widget" and gui:IsA("ScreenGui") then
                        
                        -- Quét mọi thành phần con trong UI này
                        for _, child in ipairs(gui:GetDescendants()) do
                            
                            -- Đày ải (Shadow Realm): Bắn tọa độ của Menu/Logo ra ngoài không gian
                            if (child:IsA("Frame") or child:IsA("ImageButton")) and not child:GetAttribute("HiddenByNono") then
                                child:SetAttribute("HiddenByNono", true)
                                child.Position = UDim2.new(9999, 0, 9999, 0)
                                child.Visible = false
                            end

                            -- Cào dữ liệu: Trích xuất các nút chức năng để liên kết
                            if child:IsA("TextLabel") or child:IsA("TextButton") then
                                local txt = child.Text:lower()
                                if txt:find("instant") and txt:find("steal") then
                                    targetButtons.tpSteal = child:FindFirstAncestorOfClass("TextButton") or child
                                elseif txt:find("anti") and (txt:find("hit") or txt:find("guard")) then
                                    targetButtons.antiHit = child:FindFirstAncestorOfClass("TextButton") or child
                                end
                            end
                        end
                        
                    end
                end
            end
        end
    end
end)

-- ==================== 4. NẠP SCRIPT WHUB GỐC ====================
getgenv().SCRIPT_KEY = "KEYLESS"
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ba8f09cf06d30d431b514907755c5ca97a771538d4c441642b311911f0ae86f7/download"))()
    end)
end)
