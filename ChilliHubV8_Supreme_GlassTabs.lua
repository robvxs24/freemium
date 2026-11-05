--!strict
-- ============================================================================
-- BANANA HUB | LUXURY GOLD PREMIUM EDITION
-- KHỐI 4: AVATAR_RENDERER (DYNAMIC WALK ANIMATION & 3D WORLDMODEL SYSTEM)
-- Logo: Banana Cat (rbxassetid://87447945720038)
-- Màu chủ đạo: Gold Premium (Vàng Hoàng Gia Sang Trọng #FFE66E - #EBB937 - #C88C1E)
-- ============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	pcall(function()
		LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	end)
	LocalPlayer = Players.LocalPlayer
end

-- Quản lý phiên chạy an toàn & dọn dẹp khi chạy lại script
local env = (getgenv and getgenv()) or _G
env.__BananaHubSession = (env.__BananaHubSession or 0) + 1
local SID = env.__BananaHubSession
local function isAlive()
	return env.__BananaHubSession == SID
end

-- ============================================================================
-- 1. HẰNG SỐ, ASSET ID & BẢNG MÀU VÀNG SANG TRỌNG (GOLD PREMIUM PALETTE)
-- ============================================================================
local BANANA_CAT_LOGO = "rbxassetid://87447945720038"

-- ID Animation chuẩn dự phòng cho R15 và R6
local ANIM_IDS = {
	R15 = {
		Walk = "http://www.roblox.com/asset/?id=507777826",
		Idle = "http://www.roblox.com/asset/?id=507766388",
		Run  = "http://www.roblox.com/asset/?id=507767714"
	},
	R6 = {
		Walk = "http://www.roblox.com/asset/?id=180426354",
		Idle = "http://www.roblox.com/asset/?id=180435571",
		Run  = "http://www.roblox.com/asset/?id=180426354"
	}
}

-- Bảng màu Gold Premium sang trọng
local GOLD_PALETTE = {
	ObsidianBg   = Color3.fromRGB(16, 17, 22),       -- Đen tuyền sâu thẳm
	CardBg       = Color3.fromRGB(24, 25, 32),       -- Nền thẻ kính tối
	GlassTint    = Color3.fromRGB(32, 30, 26),       -- Kính ám hổ phách trầm
	LightGold    = Color3.fromRGB(255, 235, 130),     -- Vàng sáng hoàng gia (#FFE66E)
	MetallicGold = Color3.fromRGB(235, 185, 55),      -- Vàng kim loại chuẩn (#EBB937)
	AmberGold    = Color3.fromRGB(200, 140, 30),      -- Vàng hổ phách (#C88C1E)
	DeepGold     = Color3.fromRGB(140, 95, 18),       -- Vàng đồng trầm (#8C5F12)
	TextPrimary  = Color3.fromRGB(255, 248, 225),     -- Trắng ngà hoàng kim
	TextMuted    = Color3.fromRGB(185, 175, 150),     -- Xám vàng dịu mắt
	StatusMoving = Color3.fromRGB(85, 235, 145),      -- Xanh ngọc lục bảo (Di chuyển)
	StatusIdle   = Color3.fromRGB(255, 215, 65),      -- Vàng hổ phách (Đứng yên)
}

local GOLD_GRADIENT_SEQUENCE = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, GOLD_PALETTE.LightGold),
	ColorSequenceKeypoint.new(0.35, GOLD_PALETTE.MetallicGold),
	ColorSequenceKeypoint.new(0.70, GOLD_PALETTE.AmberGold),
	ColorSequenceKeypoint.new(1.00, GOLD_PALETTE.LightGold)
})

-- ============================================================================
-- 2. ĐỊNH NGHĨA KIỂU DỮ LIỆU & MODULE AVATAR_RENDERER
-- ============================================================================
local Avatar_Renderer = {}
Avatar_Renderer.__index = Avatar_Renderer

--[[
    Kiểu dữ liệu cấu hình Renderer (RendererConfig):
    - Parent: GuiObject? (Khung chứa giao diện)
    - Player: Player? (Người chơi cần render, mặc định LocalPlayer)
    - Size: UDim2? (Kích thước khung 3D)
    - Position: UDim2? (Vị trí hiển thị)
    - ShowStats: boolean? (Hiện thông số tốc độ & tên)
    - AutoRotate: boolean? (Tự động xoay Avatar)
--]]

-- Hàm tiện ích lấy gốc an toàn
local function getSafeTargetGui()
	local target = nil
	if gethui then
		pcall(function() target = gethui() end)
	end
	if not target and CoreGui then
		pcall(function() target = CoreGui end)
	end
	if not target and LocalPlayer then
		target = LocalPlayer:FindFirstChildOfClass("PlayerGui")
	end
	return target or game:GetService("Workspace")
end

-- ============================================================================
-- 3. HÀM TÌM KIẾM ANIMATION ID THỰC CỦA NGƯỜI CHƠI (CÓ DỰ PHÒNG CHUẨN)
-- ============================================================================
local function extractCharacterAnimationIds(character, humanoid)
	local isR15 = (humanoid.RigType == Enum.HumanoidRigType.R15)
	local defaultTable = isR15 and ANIM_IDS.R15 or ANIM_IDS.R6

	local walkId = defaultTable.Walk
	local idleId = defaultTable.Idle

	local animateScript = character:FindFirstChild("Animate")
	if animateScript then
		-- 1. Tìm Walk Animation ID
		pcall(function()
			local walkFolder = animateScript:FindFirstChild("walk") or animateScript:FindFirstChild("run")
			if walkFolder then
				local animObj = walkFolder:FindFirstChildWhichIsA("Animation")
				if animObj and animObj.AnimationId and #animObj.AnimationId > 8 then
					walkId = animObj.AnimationId
				end
			end
		end)

		-- 2. Tìm Idle Animation ID
		pcall(function()
			local idleFolder = animateScript:FindFirstChild("idle")
			if idleFolder then
				local animObj = idleFolder:FindFirstChild("Animation1") or idleFolder:FindFirstChildWhichIsA("Animation")
				if animObj and animObj.AnimationId and #animObj.AnimationId > 8 then
					idleId = animObj.AnimationId
				end
			end
		end)
	end

	return walkId, idleId
end

-- ============================================================================
-- 4. KHỞI TẠO BẢN CLONE AN TOÀN TRONG WORLDMODEL
-- ============================================================================
local function prepareCleanAvatarClone(character)
	character.Archivable = true
	local clone = character:Clone()
	character.Archivable = false

	if not clone then return nil end
	clone.Name = "BananaHub_AvatarClone"

	-- Xóa bỏ script, âm thanh và phụ kiện thừa không cần thiết trong 3D Viewport
	for _, desc in ipairs(clone:GetDescendants()) do
		if desc:IsA("Script") or desc:IsA("LocalScript") or desc:IsA("Sound") then
			desc:Destroy()
		elseif desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.CanTouch = false
			desc.CanQuery = false
			-- Chỉ neo HumanoidRootPart để nhân vật không rơi khỏi bệ, giữ các khớp cử động cho hoạt ảnh
			if desc.Name == "HumanoidRootPart" then
				desc.Anchored = true
			else
				desc.Anchored = false
			end
		end
	end

	local cloneHumanoid = clone:FindFirstChildOfClass("Humanoid")
	if cloneHumanoid then
		cloneHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		cloneHumanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
		cloneHumanoid.NameDisplayDistance = 0
		cloneHumanoid.HealthDisplayDistance = 0
		cloneHumanoid.PlatformStand = true
	end

	return clone
end

-- ============================================================================
-- 5. KHỞI TẠO MODULE RENDERER CHÍNH
-- ============================================================================
function Avatar_Renderer.new(userConfig)
	local config = userConfig or {}
	local targetPlayer = config.Player or LocalPlayer
	local showStats = (config.ShowStats ~= false)
	local autoRotateInit = (config.AutoRotate ~= false)

	local self = setmetatable({}, Avatar_Renderer)
	self.Connections = {}
	self.RotationAngle = 0
	self.AutoRotate = autoRotateInit
	self.IsWalking = false
	self.ManualDragRotation = 0

	-- 1. Khung chứa chính (Container) với hiệu ứng Gold Premium
	local container = Instance.new("Frame")
	container.Name = "AvatarRendererCard"
	container.Size = config.Size or UDim2.new(0, 240, 0, showStats and 340 or 270)
	container.Position = config.Position or UDim2.new(0, 16, 0, 70)
	container.BackgroundColor3 = GOLD_PALETTE.CardBg
	container.BorderSizePixel = 0
	container.ClipsDescendants = true
	self.Container = container

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 14)
	cardCorner.Parent = container

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Name = "GoldPremiumBorder"
	cardStroke.Color = GOLD_PALETTE.MetallicGold
	cardStroke.Thickness = 1.6
	cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	cardStroke.Parent = container

	local strokeGrad = Instance.new("UIGradient")
	strokeGrad.Color = GOLD_GRADIENT_SEQUENCE
	strokeGrad.Rotation = 45
	strokeGrad.Parent = cardStroke

	-- Hiệu ứng phản quang vàng ánh kim mặt trên (Gold Glass Shimmer)
	local goldTopShimmer = Instance.new("Frame")
	goldTopShimmer.Name = "GoldTopShimmer"
	goldTopShimmer.Size = UDim2.new(1, 0, 0, 32)
	goldTopShimmer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	goldTopShimmer.BorderSizePixel = 0
	goldTopShimmer.ZIndex = 5
	goldTopShimmer.Parent = container

	local shimmerGrad = Instance.new("UIGradient")
	shimmerGrad.Rotation = 90
	shimmerGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, GOLD_PALETTE.LightGold),
		ColorSequenceKeypoint.new(1.00, GOLD_PALETTE.DeepGold)
	})
	shimmerGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 0.75),
		NumberSequenceKeypoint.new(0.60, 0.92),
		NumberSequenceKeypoint.new(1.00, 1.00)
	})
	shimmerGrad.Parent = goldTopShimmer

	-- 2. ViewportFrame & WorldModel
	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "AvatarViewport"
	viewport.Size = UDim2.new(1, -16, 0, 210)
	viewport.Position = UDim2.new(0, 8, 0, 8)
	viewport.BackgroundColor3 = GOLD_PALETTE.ObsidianBg
	viewport.BackgroundTransparency = 0.25
	viewport.BorderSizePixel = 0
	viewport.Ambient = Color3.fromRGB(220, 205, 180)
	viewport.LightColor = Color3.fromRGB(255, 240, 200)
	viewport.LightDirection = Vector3.new(-1, -2, -1.5).Unit
	viewport.ZIndex = 2
	viewport.Parent = container
	self.Viewport = viewport

	local vpCorner = Instance.new("UICorner")
	vpCorner.CornerRadius = UDim.new(0, 10)
	vpCorner.Parent = viewport

	local vpStroke = Instance.new("UIStroke")
	vpStroke.Color = GOLD_PALETTE.AmberGold
	vpStroke.Thickness = 1.0
	vpStroke.Transparency = 0.35
	vpStroke.Parent = viewport

	local worldModel = Instance.new("WorldModel")
	worldModel.Name = "AvatarWorldModel"
	worldModel.Parent = viewport
	self.WorldModel = worldModel

	local camera = Instance.new("Camera")
	camera.Name = "AvatarRendererCamera"
	camera.FieldOfView = 36
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	self.Camera = camera

	-- 3. Khung điều khiển nhanh trên 3D Viewport (Xoay, Bật/Tắt Auto-Rotate)
	local controlRow = Instance.new("Frame")
	controlRow.Name = "ViewportControls"
	controlRow.Size = UDim2.new(1, -12, 0, 24)
	controlRow.Position = UDim2.new(0, 6, 1, -30)
	controlRow.BackgroundTransparency = 1
	controlRow.ZIndex = 6
	controlRow.Parent = viewport

	local autoRotateBtn = Instance.new("TextButton")
	autoRotateBtn.Name = "AutoRotateToggleBtn"
	autoRotateBtn.Size = UDim2.new(0.5, -4, 1, 0)
	autoRotateBtn.Position = UDim2.new(0, 0, 0, 0)
	autoRotateBtn.BackgroundColor3 = GOLD_PALETTE.GlassTint
	autoRotateBtn.BackgroundTransparency = 0.2
	autoRotateBtn.Font = Enum.Font.GothamBold
	autoRotateBtn.TextSize = 9.5
	autoRotateBtn.TextColor3 = self.AutoRotate and GOLD_PALETTE.LightGold or GOLD_PALETTE.TextMuted
	autoRotateBtn.Text = self.AutoRotate and "🔄 Xoay: BẬT" or "⏸️ Xoay: TẮT"
	autoRotateBtn.AutoButtonColor = false
	autoRotateBtn.ZIndex = 7
	autoRotateBtn.Parent = controlRow
	Instance.new("UICorner", autoRotateBtn).CornerRadius = UDim.new(0, 6)
	local arbStroke = Instance.new("UIStroke", autoRotateBtn)
	arbStroke.Color = GOLD_PALETTE.AmberGold
	arbStroke.Thickness = 1
	arbStroke.Transparency = 0.4

	local resetCamBtn = Instance.new("TextButton")
	resetCamBtn.Name = "ResetCamBtn"
	resetCamBtn.Size = UDim2.new(0.5, -4, 1, 0)
	resetCamBtn.Position = UDim2.new(0.5, 4, 0, 0)
	resetCamBtn.BackgroundColor3 = GOLD_PALETTE.GlassTint
	resetCamBtn.BackgroundTransparency = 0.2
	resetCamBtn.Font = Enum.Font.GothamBold
	resetCamBtn.TextSize = 9.5
	resetCamBtn.TextColor3 = GOLD_PALETTE.TextPrimary
	resetCamBtn.Text = "🎯 Góc Chuẩn"
	resetCamBtn.AutoButtonColor = false
	resetCamBtn.ZIndex = 7
	resetCamBtn.Parent = controlRow
	Instance.new("UICorner", resetCamBtn).CornerRadius = UDim.new(0, 6)
	local rcbStroke = Instance.new("UIStroke", resetCamBtn)
	rcbStroke.Color = GOLD_PALETTE.AmberGold
	rcbStroke.Thickness = 1
	rcbStroke.Transparency = 0.4

	-- 4. Bảng thông số người chơi & trạng thái di chuyển (Gold Stats Panel)
	local statsPanel = Instance.new("Frame")
	statsPanel.Name = "AvatarStatsPanel"
	statsPanel.Size = UDim2.new(1, -16, 0, 108)
	statsPanel.Position = UDim2.new(0, 8, 0, 224)
	statsPanel.BackgroundColor3 = GOLD_PALETTE.ObsidianBg
	statsPanel.BackgroundTransparency = 0.35
	statsPanel.BorderSizePixel = 0
	statsPanel.ZIndex = 3
	statsPanel.Visible = showStats
	statsPanel.Parent = container
	Instance.new("UICorner", statsPanel).CornerRadius = UDim.new(0, 10)
	local spStroke = Instance.new("UIStroke", statsPanel)
	spStroke.Color = GOLD_PALETTE.AmberGold
	spStroke.Thickness = 1
	spStroke.Transparency = 0.5

	-- Thẻ trạng thái động: Đang đi bộ / Đang đứng yên
	local statusIndicator = Instance.new("Frame")
	statusIndicator.Name = "StatusIndicator"
	statusIndicator.Size = UDim2.new(1, -12, 0, 26)
	statusIndicator.Position = UDim2.new(0, 6, 0, 6)
	statusIndicator.BackgroundColor3 = GOLD_PALETTE.CardBg
	statusIndicator.BorderSizePixel = 0
	statusIndicator.ZIndex = 4
	statusIndicator.Parent = statsPanel
	Instance.new("UICorner", statusIndicator).CornerRadius = UDim.new(0, 6)

	local statusDot = Instance.new("Frame")
	statusDot.Name = "StatusDot"
	statusDot.Size = UDim2.new(0, 8, 0, 8)
	statusDot.Position = UDim2.new(0, 8, 0.5, -4)
	statusDot.BackgroundColor3 = GOLD_PALETTE.StatusIdle
	statusDot.BorderSizePixel = 0
	statusDot.ZIndex = 5
	statusDot.Parent = statusIndicator
	Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)
	local dotGlow = Instance.new("UIStroke", statusDot)
	dotGlow.Color = GOLD_PALETTE.StatusIdle
	dotGlow.Thickness = 2
	dotGlow.Transparency = 0.4

	local statusText = Instance.new("TextLabel")
	statusText.Name = "StatusText"
	statusText.Size = UDim2.new(1, -26, 1, 0)
	statusText.Position = UDim2.new(0, 22, 0, 0)
	statusText.BackgroundTransparency = 1
	statusText.Font = Enum.Font.GothamBold
	statusText.TextSize = 10.5
	statusText.TextColor3 = GOLD_PALETTE.LightGold
	statusText.TextXAlignment = Enum.TextXAlignment.Left
	statusText.Text = "TRẠNG THÁI: ĐANG ĐỨNG YÊN"
	statusText.ZIndex = 5
	statusText.Parent = statusIndicator

	-- Thông số tên nhân vật & tốc độ di chuyển thực tế
	local playerInfoLbl = Instance.new("TextLabel")
	playerInfoLbl.Name = "PlayerInfoLbl"
	playerInfoLbl.Size = UDim2.new(1, -12, 0, 16)
	playerInfoLbl.Position = UDim2.new(0, 8, 0, 38)
	playerInfoLbl.BackgroundTransparency = 1
	playerInfoLbl.Font = Enum.Font.GothamBold
	playerInfoLbl.TextSize = 10
	playerInfoLbl.TextColor3 = GOLD_PALETTE.TextPrimary
	playerInfoLbl.TextXAlignment = Enum.TextXAlignment.Left
	playerInfoLbl.Text = "NHÂN VẬT: " .. (targetPlayer and targetPlayer.DisplayName or "Player")
	playerInfoLbl.ZIndex = 4
	playerInfoLbl.Parent = statsPanel

	local speedMetricLbl = Instance.new("TextLabel")
	speedMetricLbl.Name = "SpeedMetricLbl"
	speedMetricLbl.Size = UDim2.new(1, -12, 0, 16)
	speedMetricLbl.Position = UDim2.new(0, 8, 0, 58)
	speedMetricLbl.BackgroundTransparency = 1
	speedMetricLbl.Font = Enum.Font.RobotoMono
	speedMetricLbl.TextSize = 9.5
	speedMetricLbl.TextColor3 = GOLD_PALETTE.TextMuted
	speedMetricLbl.TextXAlignment = Enum.TextXAlignment.Left
	speedMetricLbl.Text = "TỐC ĐỘ THỰC: 16.0 studs/s (x1.00)"
	speedMetricLbl.ZIndex = 4
	speedMetricLbl.Parent = statsPanel

	local bananaBadge = Instance.new("TextLabel")
	bananaBadge.Name = "BananaBadge"
	bananaBadge.Size = UDim2.new(1, -12, 0, 18)
	bananaBadge.Position = UDim2.new(0, 8, 0, 80)
	bananaBadge.BackgroundTransparency = 1
	bananaBadge.Font = Enum.Font.GothamBlack
	bananaBadge.TextSize = 9.5
	bananaBadge.TextColor3 = GOLD_PALETTE.MetallicGold
	bananaBadge.TextXAlignment = Enum.TextXAlignment.Left
	bananaBadge.Text = "👑 BANANA HUB • GOLD PREMIUM ENGINE"
	bananaBadge.ZIndex = 4
	bananaBadge.Parent = statsPanel

	-- ========================================================================
	-- 6. HÀM NẠP VÀ ĐỒNG BỘ HOẠT ẢNH DI ĐỘNG (WALK ANIMATION SETUP)
	-- ========================================================================
	local function setupAvatarAndAnimations(character)
		-- Dọn dẹp bản clone cũ nếu có
		if self.CloneModel then
			pcall(function() self.CloneModel:Destroy() end)
			self.CloneModel = nil
		end
		self.IdleTrack = nil
		self.WalkTrack = nil
		self.Animator = nil

		local realHumanoid = character:WaitForChild("Humanoid", 5)
		if not realHumanoid or not realHumanoid:IsA("Humanoid") then return end

		-- Chuẩn bị bản clone sạch
		local clone = prepareCleanAvatarClone(character)
		if not clone then return end
		clone.Parent = worldModel
		self.CloneModel = clone

		local cloneHumanoid = clone:FindFirstChildOfClass("Humanoid")
		if not cloneHumanoid then return end

		local animator = cloneHumanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = cloneHumanoid
		end
		self.Animator = animator

		-- Lấy ID animation đi bộ và đứng yên
		local walkId, idleId = extractCharacterAnimationIds(character, realHumanoid)

		local walkAnim = Instance.new("Animation")
		walkAnim.AnimationId = walkId

		local idleAnim = Instance.new("Animation")
		idleAnim.AnimationId = idleId

		local okIdle, idleTrack = pcall(function()
			local tr = animator:LoadAnimation(idleAnim)
			tr.Looped = true
			tr.Priority = Enum.AnimationPriority.Idle
			return tr
		end)

		local okWalk, walkTrack = pcall(function()
			local tr = animator:LoadAnimation(walkAnim)
			tr.Looped = true
			tr.Priority = Enum.AnimationPriority.Movement
			return tr
		end)

		if okIdle and idleTrack then
			self.IdleTrack = idleTrack
			idleTrack:Play(0)
		end
		if okWalk and walkTrack then
			self.WalkTrack = walkTrack
		end

		-- Hàm cập nhật logic chuyển động (Dynamic Movement Detection)
		local function updateMovement()
			if not isAlive() or not realHumanoid or not realHumanoid.Parent then return end
			local moveMagnitude = realHumanoid.MoveDirection.Magnitude
			local isMoving = (moveMagnitude > 0.1)

			if isMoving then
				if not self.IsWalking then
					self.IsWalking = true
					if self.IdleTrack then
						self.IdleTrack:Stop(0.15)
					end
					if self.WalkTrack then
						self.WalkTrack:Play(0.15)
					end
					statusText.Text = "TRẠNG THÁI: ĐANG DI CHUYỂN"
					statusText.TextColor3 = GOLD_PALETTE.StatusMoving
					statusDot.BackgroundColor3 = GOLD_PALETTE.StatusMoving
					dotGlow.Color = GOLD_PALETTE.StatusMoving
				end

				-- Đồng bộ tốc độ hoạt ảnh của bản Clone với tốc độ di chuyển thực tế
				if self.WalkTrack then
					local walkSpeed = realHumanoid.WalkSpeed
					local speedMultiplier = math.clamp(walkSpeed / 16.0, 0.25, 4.0)
					self.WalkTrack:AdjustSpeed(speedMultiplier)
					speedMetricLbl.Text = string.format("TỐC ĐỘ THỰC: %.1f studs/s (x%.2f)", walkSpeed, speedMultiplier)
				end
			else
				if self.IsWalking then
					self.IsWalking = false
					if self.WalkTrack then
						self.WalkTrack:Stop(0.15)
					end
					if self.IdleTrack then
						self.IdleTrack:Play(0.15)
					end
					statusText.Text = "TRẠNG THÁI: ĐANG ĐỨNG YÊN"
					statusText.TextColor3 = GOLD_PALETTE.StatusIdle
					statusDot.BackgroundColor3 = GOLD_PALETTE.StatusIdle
					dotGlow.Color = GOLD_PALETTE.StatusIdle
					speedMetricLbl.Text = string.format("TỐC ĐỘ THỰC: %.1f studs/s (Nghỉ)", realHumanoid.WalkSpeed)
				end
			end
		end

		-- Kết nối lắng nghe thay đổi MoveDirection của Humanoid thực tế
		if self.Connections["MoveDirectionConn"] then
			self.Connections["MoveDirectionConn"]:Disconnect()
		end
		self.Connections["MoveDirectionConn"] = realHumanoid:GetPropertyChangedSignal("MoveDirection"):Connect(updateMovement)

		if self.Connections["WalkSpeedConn"] then
			self.Connections["WalkSpeedConn"]:Disconnect()
		end
		self.Connections["WalkSpeedConn"] = realHumanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if self.IsWalking and self.WalkTrack then
				local spd = realHumanoid.WalkSpeed
				local mult = math.clamp(spd / 16.0, 0.25, 4.0)
				self.WalkTrack:AdjustSpeed(mult)
				speedMetricLbl.Text = string.format("TỐC ĐỘ THỰC: %.1f studs/s (x%.2f)", spd, mult)
			end
		end)

		-- Chạy kiểm tra khởi tạo ngay lập tức
		updateMovement()
	end

	-- Lắng nghe khởi tạo nhân vật
	if targetPlayer.Character then
		task.spawn(function()
			setupAvatarAndAnimations(targetPlayer.Character)
		end)
	end
	self.Connections["CharAddedConn"] = targetPlayer.CharacterAdded:Connect(function(newChar)
		task.delay(0.2, function()
			if isAlive() then
				setupAvatarAndAnimations(newChar)
			end
		end)
	end)

	-- ========================================================================
	-- 7. CẬP NHẬT CAMERA CÓ ĐỘ NẢY BỒNG BỀNH (BOBBING MOTION) & XOAY 3D
	-- ========================================================================
	self.Connections["RenderSteppedConn"] = RunService.RenderStepped:Connect(function(dt)
		if not isAlive() or not self.CloneModel or not self.CloneModel.Parent then return end
		local rootPart = self.CloneModel:FindFirstChild("HumanoidRootPart") or self.CloneModel.PrimaryPart or self.CloneModel:FindFirstChild("Torso") or self.CloneModel:FindFirstChild("UpperTorso")
		if not rootPart or not rootPart:IsA("BasePart") then return end

		-- Tính toán góc quay tự động hoặc do người dùng kéo
		if self.AutoRotate then
			self.RotationAngle = (self.RotationAngle + dt * 0.8) % (math.pi * 2)
		end
		local totalAngle = self.RotationAngle + self.ManualDragRotation

		-- Hiệu ứng bồng bềnh tự nhiên theo nhịp chân bước (Bobbing Motion)
		local isMoving = self.IsWalking
		local bobbleSpeed = isMoving and 10.5 or 2.2
		local bobbleAmpY = isMoving and 0.08 or 0.018
		local bobbleAmpX = isMoving and 0.035 or 0.012

		local clock = os.clock()
		local offsetY = math.sin(clock * bobbleSpeed) * bobbleAmpY
		local offsetX = math.cos(clock * (bobbleSpeed * 0.5)) * bobbleAmpX

		local centerPos = rootPart.Position + Vector3.new(0, 0.3 + offsetY, 0)
		local camDistance = 4.7
		local camHeight = 0.35

		local camPos = centerPos + Vector3.new(
			math.sin(totalAngle) * camDistance + offsetX,
			camHeight,
			math.cos(totalAngle) * camDistance
		)

		self.Camera.CFrame = CFrame.lookAt(camPos, centerPos)
	end)

	-- ========================================================================
	-- 8. TƯƠNG TÁC XOAY 3D BẰNG CHUỘT / CẢM ỨNG & ĐIỀU KHIỂN
	-- ========================================================================
	local dragging = false
	local dragStart = Vector2.new(0, 0)
	local startAngle = 0

	viewport.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = Vector2.new(input.Position.X, input.Position.Y)
			startAngle = self.ManualDragRotation
			self.AutoRotate = false
			autoRotateBtn.Text = "⏸️ Xoay: TẮT"
			autoRotateBtn.TextColor3 = GOLD_PALETTE.TextMuted
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local deltaX = input.Position.X - dragStart.X
			self.ManualDragRotation = startAngle - (deltaX * 0.015)
		end
	end)

	local function stopDrag()
		dragging = false
	end
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			stopDrag()
		end
	end)

	autoRotateBtn.Activated:Connect(function()
		self.AutoRotate = not self.AutoRotate
		autoRotateBtn.Text = self.AutoRotate and "🔄 Xoay: BẬT" or "⏸️ Xoay: TẮT"
		autoRotateBtn.TextColor3 = self.AutoRotate and GOLD_PALETTE.LightGold or GOLD_PALETTE.TextMuted
	end)

	resetCamBtn.Activated:Connect(function()
		self.ManualDragRotation = 0
		self.RotationAngle = 0
		self.AutoRotate = true
		autoRotateBtn.Text = "🔄 Xoay: BẬT"
		autoRotateBtn.TextColor3 = GOLD_PALETTE.LightGold
	end)

	-- Gắn vào đối tượng cha nếu được chỉ định
	if config.Parent then
		container.Parent = config.Parent
	end

	-- Tự động dọn dẹp khi UI container bị Destroy
	container.Destroying:Connect(function()
		self:Destroy()
	end)

	return self
end

-- ============================================================================
-- 9. HÀM DỌN DẸP & KHẮC PHỤC RÒ RỈ BỘ NHỚ (LEAK-PROOF CLEANUP)
-- ============================================================================
function Avatar_Renderer:Destroy()
	-- Ngắt toàn bộ kết nối sự kiện (Disconnect All)
	for key, conn in pairs(self.Connections) do
		if conn and conn.Disconnect then
			pcall(function() conn:Disconnect() end)
		end
		self.Connections[key] = nil
	end

	-- Dừng và giải phóng các AnimationTrack
	if self.IdleTrack then
		pcall(function()
			self.IdleTrack:Stop(0)
			self.IdleTrack:Destroy()
		end)
		self.IdleTrack = nil
	end
	if self.WalkTrack then
		pcall(function()
			self.WalkTrack:Stop(0)
			self.WalkTrack:Destroy()
		end)
		self.WalkTrack = nil
	end

	-- Xóa bản clone và camera
	if self.CloneModel then
		pcall(function() self.CloneModel:Destroy() end)
		self.CloneModel = nil
	end
	if self.Camera then
		pcall(function() self.Camera:Destroy() end)
		self.Camera = nil
	end

	if self.Container and self.Container.Parent then
		pcall(function() self.Container:Destroy() end)
	end
end

function Avatar_Renderer:SetAutoRotate(enabled)
	self.AutoRotate = enabled
end

function Avatar_Renderer:ResetCamera()
	self.ManualDragRotation = 0
	self.RotationAngle = 0
end

-- ============================================================================
-- 10. GIAO DIỆN CHÍNH "BANANA HUB" SANG TRỌNG VÀNG GOLD PREMIUM (AUTO-MOUNT)
-- ============================================================================
local function createBananaHubGoldWindow()
	local targetRoot = getSafeTargetGui()

	-- Dọn dẹp phiên bản cũ nếu có
	for _, root in ipairs({ CoreGui, (gethui and gethui()) or nil, LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui") or nil }) do
		if root then
			local old = root:FindFirstChild("BananaHub_MainWindowGui")
			if old then pcall(function() old:Destroy() end) end
		end
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "BananaHub_MainWindowGui"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999980
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = targetRoot

	-- Khung cửa sổ chính Banana Hub
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "BananaHub_MainFrame"
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.Size = UDim2.new(0, 520, 0, 420)
	mainFrame.BackgroundColor3 = GOLD_PALETTE.ObsidianBg
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Active = true
	mainFrame.Parent = screenGui

	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
	local mainStroke = Instance.new("UIStroke", mainFrame)
	mainStroke.Color = GOLD_PALETTE.MetallicGold
	mainStroke.Thickness = 2.0
	mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local mainGrad = Instance.new("UIGradient", mainStroke)
	mainGrad.Color = GOLD_GRADIENT_SEQUENCE
	mainGrad.Rotation = 45

	-- Header Bar Hoàng Kim
	local headerBar = Instance.new("Frame")
	headerBar.Name = "HeaderBar"
	headerBar.Size = UDim2.new(1, 0, 0, 48)
	headerBar.BackgroundColor3 = GOLD_PALETTE.CardBg
	headerBar.BorderSizePixel = 0
	headerBar.Parent = mainFrame
	Instance.new("UICorner", headerBar).CornerRadius = UDim.new(0, 16)

	-- Logo Banana Cat (rbxassetid://87447945720038)
	local logoFrame = Instance.new("Frame")
	logoFrame.Name = "BananaLogoOrb"
	logoFrame.AnchorPoint = Vector2.new(0, 0.5)
	logoFrame.Position = UDim2.new(0, 12, 0.5, 0)
	logoFrame.Size = UDim2.new(0, 32, 0, 32)
	logoFrame.BackgroundColor3 = GOLD_PALETTE.GlassTint
	logoFrame.BorderSizePixel = 0
	logoFrame.ClipsDescendants = true
	logoFrame.Parent = headerBar
	Instance.new("UICorner", logoFrame).CornerRadius = UDim.new(1, 0)

	local logoStroke = Instance.new("UIStroke", logoFrame)
	logoStroke.Color = GOLD_PALETTE.LightGold
	logoStroke.Thickness = 1.4

	local logoImg = Instance.new("ImageLabel")
	logoImg.Name = "BananaCatIcon"
	logoImg.AnchorPoint = Vector2.new(0.5, 0.5)
	logoImg.Position = UDim2.fromScale(0.5, 0.5)
	logoImg.Size = UDim2.fromScale(0.92, 0.92)
	logoImg.BackgroundTransparency = 1
	logoImg.Image = BANANA_CAT_LOGO
	logoImg.ScaleType = Enum.ScaleType.Fit
	logoImg.Parent = logoFrame

	-- Tiêu đề Banana Hub
	local titleLbl = Instance.new("TextLabel")
	titleLbl.Name = "HubTitle"
	titleLbl.Position = UDim2.new(0, 52, 0, 7)
	titleLbl.Size = UDim2.new(0, 200, 0, 18)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Font = Enum.Font.GothamBlack
	titleLbl.TextSize = 14
	titleLbl.TextColor3 = GOLD_PALETTE.TextPrimary
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Text = "BANANA HUB"
	titleLbl.Parent = headerBar

	local titleGrad = Instance.new("UIGradient", titleLbl)
	titleGrad.Color = GOLD_GRADIENT_SEQUENCE

	local subTitleLbl = Instance.new("TextLabel")
	subTitleLbl.Name = "HubSubtitle"
	subTitleLbl.Position = UDim2.new(0, 52, 0, 26)
	subTitleLbl.Size = UDim2.new(0, 240, 0, 14)
	subTitleLbl.BackgroundTransparency = 1
	subTitleLbl.Font = Enum.Font.GothamBold
	subTitleLbl.TextSize = 9.5
	subTitleLbl.TextColor3 = GOLD_PALETTE.AmberGold
	subTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
	subTitleLbl.Text = "⭐ LUXURY GOLD PREMIUM EDITION • AVATAR 3D"
	subTitleLbl.Parent = headerBar

	-- Nút đóng cửa sổ
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseBtn"
	closeBtn.AnchorPoint = Vector2.new(1, 0.5)
	closeBtn.Position = UDim2.new(1, -12, 0.5, 0)
	closeBtn.Size = UDim2.new(0, 28, 0, 28)
	closeBtn.BackgroundColor3 = GOLD_PALETTE.CardBg
	closeBtn.BorderSizePixel = 0
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.Text = "✕"
	closeBtn.TextSize = 12
	closeBtn.TextColor3 = GOLD_PALETTE.TextMuted
	closeBtn.AutoButtonColor = false
	closeBtn.Parent = headerBar
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
	local cbStroke = Instance.new("UIStroke", closeBtn)
	cbStroke.Color = GOLD_PALETTE.AmberGold
	cbStroke.Thickness = 1.0

	closeBtn.Activated:Connect(function()
		screenGui:Destroy()
	end)

	-- Hỗ trợ kéo thả cửa sổ chính
	local dragging, dragStart, startPos = false, nil, nil
	headerBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			if input.Changed then
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
						dragging = false
					end
				end)
			end
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- Khởi tạo Khối 4: Avatar_Renderer 3D bên trái
	local renderer = Avatar_Renderer.new({
		Parent = mainFrame,
		Player = LocalPlayer,
		Size = UDim2.new(0, 220, 0, 350),
		Position = UDim2.new(0, 14, 0, 58),
		ShowStats = true,
		AutoRotate = true,
	})

	-- Khu vực tính năng bên phải (Features & Settings Panel)
	local rightPanel = Instance.new("Frame")
	rightPanel.Name = "RightFeaturesPanel"
	rightPanel.Size = UDim2.new(1, -262, 0, 350)
	rightPanel.Position = UDim2.new(0, 248, 0, 58)
	rightPanel.BackgroundColor3 = GOLD_PALETTE.CardBg
	rightPanel.BorderSizePixel = 0
	rightPanel.Parent = mainFrame
	Instance.new("UICorner", rightPanel).CornerRadius = UDim.new(0, 12)
	local rpStroke = Instance.new("UIStroke", rightPanel)
	rpStroke.Color = GOLD_PALETTE.AmberGold
	rpStroke.Thickness = 1.2
	rpStroke.Transparency = 0.4

	local featureTitle = Instance.new("TextLabel")
	featureTitle.Position = UDim2.new(0, 14, 0, 10)
	featureTitle.Size = UDim2.new(1, -28, 0, 18)
	featureTitle.BackgroundTransparency = 1
	featureTitle.Font = Enum.Font.GothamBlack
	featureTitle.TextSize = 12
	featureTitle.TextColor3 = GOLD_PALETTE.LightGold
	featureTitle.TextXAlignment = Enum.TextXAlignment.Left
	featureTitle.Text = "🍌 BANANA HUB • TRÌNH ĐIỀU KHIỂN"
	featureTitle.Parent = rightPanel

	local descLbl = Instance.new("TextLabel")
	descLbl.Position = UDim2.new(0, 14, 0, 32)
	descLbl.Size = UDim2.new(1, -28, 0, 36)
	descLbl.BackgroundTransparency = 1
	descLbl.Font = Enum.Font.GothamMedium
	descLbl.TextSize = 9.5
	descLbl.TextColor3 = GOLD_PALETTE.TextMuted
	descLbl.TextXAlignment = Enum.TextXAlignment.Left
	descLbl.TextWrapped = true
	descLbl.Text = "Hệ thống Avatar 3D tự động phát hiện người chơi đi bộ/đứng yên và đồng bộ tốc độ di chuyển thực tế."
	descLbl.Parent = rightPanel

	-- Danh sách phím tắt tính năng nhanh (Gold Action Cards)
	local function createGoldActionBtn(name, yPos, title, sub)
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.Size = UDim2.new(1, -28, 0, 48)
		btn.Position = UDim2.new(0, 14, 0, yPos)
		btn.BackgroundColor3 = GOLD_PALETTE.ObsidianBg
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Parent = rightPanel
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		local bStroke = Instance.new("UIStroke", btn)
		bStroke.Color = GOLD_PALETTE.AmberGold
		bStroke.Thickness = 1.0
		bStroke.Transparency = 0.35

		local bTitle = Instance.new("TextLabel", btn)
		bTitle.Position = UDim2.new(0, 12, 0, 8)
		bTitle.Size = UDim2.new(1, -24, 0, 16)
		bTitle.BackgroundTransparency = 1
		bTitle.Font = Enum.Font.GothamBold
		bTitle.TextSize = 11
		bTitle.TextColor3 = GOLD_PALETTE.LightGold
		bTitle.TextXAlignment = Enum.TextXAlignment.Left
		bTitle.Text = title

		local bSub = Instance.new("TextLabel", btn)
		bSub.Position = UDim2.new(0, 12, 0, 26)
		bSub.Size = UDim2.new(1, -24, 0, 14)
		bSub.BackgroundTransparency = 1
		bSub.Font = Enum.Font.GothamMedium
		bSub.TextSize = 9
		bSub.TextColor3 = GOLD_PALETTE.TextMuted
		bSub.TextXAlignment = Enum.TextXAlignment.Left
		bSub.Text = sub

		btn.MouseEnter:Connect(function()
			bStroke.Color = GOLD_PALETTE.LightGold
			bStroke.Transparency = 0.1
		end)
		btn.MouseLeave:Connect(function()
			bStroke.Color = GOLD_PALETTE.AmberGold
			bStroke.Transparency = 0.35
		end)
		return btn
	end

	local b1 = createGoldActionBtn("SpeedTestBtn", 76, "⚡ Tăng Tốc Độ Đi Bộ (WalkSpeed +16)", "Thử nghiệm tăng tốc độ để thấy hoạt ảnh chạy nhanh hơn")
	local b2 = createGoldActionBtn("ResetSpeedBtn", 132, "🔄 Đặt Lại Tốc Độ Mặc Định (16 studs/s)", "Khôi phục lại tốc độ đi bộ tiêu chuẩn")
	local b3 = createGoldActionBtn("CameraViewBtn", 188, "🎥 Tự Động Xoay Avatar 360°", "Bật/Tắt chế độ quay đều Camera quanh Avatar")
	local b4 = createGoldActionBtn("ReloadAvatarBtn", 244, "✨ Tải Lại Avatar Người Chơi", "Cập nhật ngoại hình mới nhất của nhân vật")

	b1.Activated:Connect(function()
		pcall(function()
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = math.min(hum.WalkSpeed + 16, 120)
			end
		end)
	end)

	b2.Activated:Connect(function()
		pcall(function()
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = 16
			end
		end)
	end)

	b3.Activated:Connect(function()
		renderer:SetAutoRotate(not renderer.AutoRotate)
	end)

	b4.Activated:Connect(function()
		pcall(function()
			if LocalPlayer.Character then
				renderer:Destroy()
				renderer = Avatar_Renderer.new({
					Parent = mainFrame,
					Player = LocalPlayer,
					Size = UDim2.new(0, 220, 0, 350),
					Position = UDim2.new(0, 14, 0, 58),
					ShowStats = true,
					AutoRotate = true,
				})
			end
		end)
	end)

	-- Footer Bản Quyền Banana Hub
	local footerLbl = Instance.new("TextLabel")
	footerLbl.Position = UDim2.new(0, 14, 1, -38)
	footerLbl.Size = UDim2.new(1, -28, 0, 24)
	footerLbl.BackgroundTransparency = 1
	footerLbl.Font = Enum.Font.RobotoMono
	footerLbl.TextSize = 8.5
	footerLbl.TextColor3 = GOLD_PALETTE.AmberGold
	footerLbl.TextXAlignment = Enum.TextXAlignment.Center
	footerLbl.Text = "Banana Hub v2.0 • Gold Premium • Made with Banana Cat 🍌"
	footerLbl.Parent = rightPanel

	return screenGui
end

-- ============================================================================
-- 11. TỰ ĐỘNG THỰC THI (AUTO-RUN DEMO) & XUẤT MODULE
-- ============================================================================
task.spawn(function()
	pcall(createBananaHubGoldWindow)
end)

return Avatar_Renderer
