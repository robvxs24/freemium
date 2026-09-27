-- ==============================================================================
--  WHUB CUSTOM WIDGET - UI HIJACKING ENGINE
--  Tối ưu hóa:
--    1. Chạy ngầm WHUB: Tự động nạp loadstring và bypass key.
--    2. Phantom Hide: Ẩn hoàn toàn Menu và Logo gốc của WHUB mà không gây lỗi.
--    3. Custom Widget: Giao diện "Instant TP Steal" Bottom-Center cực ngầu.
--    4. Logic Bind: Bấm nút trên Widget sẽ tự động điều khiển tính năng của WHUB.
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

    -- Khung nền (Dark Blue/Purple)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 260, 0, 75)
    Container.AnchorPoint = Vector2.new(0.5, 1)
    Container.Position = UDim2.new(0.5, 0, 1, -25) -- Cạnh dưới giữa màn hình
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
    EyeImage.Size = UDim2.new(0, 55, 0, 55)
    EyeImage.Position = UDim2.new(0, 10, 0.5, -27.5)
    EyeImage.Image = "rbxassetid://13580436940" -- ID Mắt Anime (Có thể thay đổi)
    EyeImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    EyeImage.Parent = Container
    
    local EyeCorner = Instance.new("UICorner")
    EyeCorner.CornerRadius = UDim.new(0, 12)
    EyeCorner.Parent = EyeImage
    
    local EyeStroke = Instance.new("UIStroke")
    EyeStroke.Color = Color3.fromRGB(220, 190, 80)
    EyeStroke.Thickness = 1.5
    EyeStroke.Parent = EyeImage

    -- Chữ WHUB
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 100, 0, 20)
    Title.Position = UDim2.new(0, 75, 0, 12)
    Title.BackgroundTransparency = 1
    Title.Text = "WHUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(220, 190, 80) -- Vàng Gold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    -- Chữ instant tp steal
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 120, 0, 25)
    SubTitle.Position = UDim2.new(0, 75, 0, 32)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "instant tp steal"
    SubTitle.Font = Enum.Font.GothamBlack
    SubTitle.TextSize = 16
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = Container

    -- Nút Toggle (Công tắc)
    local ToggleTrack = Instance.new("TextButton")
    ToggleTrack.Size = UDim2.new(0, 54, 0, 28)
    ToggleTrack.Position = UDim2.new(1, -65, 0.5, -14)
    ToggleTrack.BackgroundColor3 = Color3.fromRGB(40, 20, 80) -- Tím đậm
    ToggleTrack.Text = ""
    ToggleTrack.Parent = Container

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = ToggleTrack

    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Color = Color3.fromRGB(220, 190, 80)
    TrackStroke.Thickness = 1.5
    TrackStroke.Parent = ToggleTrack

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
local originalWhubButton = nil

-- Hiệu ứng click và gửi lệnh
ToggleBtn.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    
    if isToggled then
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -24, 0.5, -10)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 40, 180)}):Play()
    else
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -10)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 20, 80)}):Play()
    end

    -- Bắn tín hiệu giả lập (Virtual Click) vào nút gốc của WHUB
    if originalWhubButton and getconnections then
        pcall(function()
            for _, conn in ipairs(getconnections(originalWhubButton.MouseButton1Click)) do
                conn:Fire()
            end
            for _, conn in ipairs(getconnections(originalWhubButton.InputBegan)) do
                conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
            end
        end)
    end
end)

-- ==================== 2. MẮT THẦN: ẨN WHUB & TÌM NÚT GỐC ====================
task.spawn(function()
    while task.wait(0.5) do
        local roots = {CoreGui, LocalPlayer:FindFirstChild("PlayerGui")}
        if gethui then pcall(function() table.insert(roots, gethui()) end) end

        for _, root in ipairs(roots) do
            if root then
                for _, gui in ipairs(root:GetChildren()) do
                    if gui:IsA("ScreenGui") and gui.Name ~= "WHUB_Custom_Widget" then
                        local isWHUB = false
                        
                        -- Quét tìm chữ WHUB để xác định đúng giao diện
                        for _, desc in ipairs(gui:GetDescendants()) do
                            if desc:IsA("TextLabel") and desc.Text:lower():find("whub") then
                                isWHUB = true
                                break
                            end
                        end

                        if isWHUB then
                            -- Kỹ thuật Phantom Hide: Đẩy giao diện gốc văng ra khỏi màn hình
                            local mainFrame = gui:FindFirstChildWhichIsA("Frame")
                            if mainFrame and not mainFrame:GetAttribute("HiddenByNono") then
                                mainFrame:SetAttribute("HiddenByNono", true)
                                mainFrame.Position = UDim2.new(9999, 0, 9999, 0)
                                mainFrame.Visible = false
                                gui.Enabled = false
                            end

                            -- Tìm nút "Instant TP Steal" của bản gốc để liên kết với Widget
                            if not originalWhubButton then
                                for _, desc in ipairs(gui:GetDescendants()) do
                                    if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                                        local txt = desc.Text:lower()
                                        if txt:find("instant") and txt:find("steal") then
                                            -- Lấy nút bấm (Parent hoặc chính nó)
                                            originalWhubButton = desc:FindFirstAncestorOfClass("TextButton") or desc
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

-- ==================== 3. NẠP SCRIPT WHUB GỐC ====================
getgenv().SCRIPT_KEY = "KEYLESS"
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ba8f09cf06d30d431b514907755c5ca97a771538d4c441642b311911f0ae86f7/download"))()
    end)
end)
