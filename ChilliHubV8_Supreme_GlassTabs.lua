-- ============================================================================
-- BANANA HUB V1.0.6+ (LUXURY GOLD EDITION) | SIÊU TỐC - MƯỢT MÀ - THẨM MỸ CAO CẤP
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- Khắc phục triệt để:
-- 1. [TỐC ĐỘ]: Khởi động tức thì (Zero-Delay Startup), loại bỏ các tác vụ chặn mạng
-- 2. [HIỆU NĂNG]: Không quét BillboardGui/Game UI, 100% Event-Driven, không gây giật lag
-- 3. [THẨM MỸ]: Huy hiệu Huy Chương Vàng (Gold Coin Badge) bo tròn mềm mại cho Banana Cat,
--    hòa tan nền trắng, biến nút tím thành nút Vàng Hoàng Gia sang trọng với hiệu ứng nhún mượt
-- ============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	pcall(function()
		LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	end)
	LocalPlayer = Players.LocalPlayer
end

-- Quản lý phiên chạy & dọn kết nối cũ
local env = (getgenv and getgenv()) or _G
env.__FiggyIslandState = env.__FiggyIslandState or {}
local State = env.__FiggyIslandState
State.SessionId = (State.SessionId or 0) + 1
local SID = State.SessionId

if type(State.ActiveConnections) == "table" then
	for _, conn in ipairs(State.ActiveConnections) do
		pcall(function() conn:Disconnect() end)
	end
end
State.ActiveConnections = {}

local function trackConn(conn)
	if conn then table.insert(State.ActiveConnections, conn) end
	return conn
end

local function isAlive()
	return State.SessionId == SID
end

State.Language = State.Language or "VI"
State.CurrentRawStatus = State.CurrentRawStatus or "Idle"
State.CurrentStatusImage = State.CurrentStatusImage or ""
State.CurrentStatusImageColor = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
State.CurrentStatusRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
State.CurrentStatusRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
State.CurrentStatusEmoji = State.CurrentStatusEmoji or ""
State.SoundEnabled = (State.SoundEnabled ~= false)
State.IsExpanded = false
State.NoteOpen = false
State.TrackedLabels = {}
State.FastCache = {}
State.CachedSounds = State.CachedSounds or {}

-- ============================================================================
-- 1. KHỞI CHẠY SIÊU TỐC SCRIPT GỐC (INSTANT LAUNCH)
-- ============================================================================
local FIGGY_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"

task.spawn(function()
	loadstring(game:HttpGet(FIGGY_LOADER_URL))()
end)

-- Danh sách tuyệt đối không đụng vào (UI hệ thống và UI gốc của game Steal an Egg)
local EXCLUDED_GUI_NAMES = {
	BananaDynamicIsland = true,
	FiggyDynamicIsland = true,
	RobloxGui = true,
	TopBarApp = true,
	TouchGui = true,
	Chat = true,
	BubbleChat = true,
	ExperienceChat = true,
	BackpackGui = true,
	PlayerList = true,
	InGameMenu = true,
	PurchasePrompt = true,
	TeleportGui = true,
	Shop = true,
	Index = true,
	Finder = true,
}

local function getUiRoots()
	local roots, seen = {}, {}
	local function add(r)
		if r and not seen[r] then
			seen[r] = true
			table.insert(roots, r)
		end
	end
	pcall(function() add(CoreGui) end)
	if gethui then pcall(function() add(gethui()) end) end
	if get_hidden_gui then pcall(function() add(get_hidden_gui()) end) end
	if gethiddenui then pcall(function() add(gethiddenui()) end) end
	if LocalPlayer then
		add(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	return roots
end

-- Nhận diện CHÍNH XÁC ScreenGui của Banana Hub (Không bao giờ nhầm lẫn với Game UI)
local function isStrictFiggyGui(gui)
	if not gui then return false end
	if gui:GetAttribute("__StrictBananaGui") then return true end
	local gName = gui.Name or ""
	if EXCLUDED_GUI_NAMES[gName] or gName:find("^Old_") then return false end

	-- Bỏ qua toàn bộ BillboardGui (tránh gắn nhầm vào tổ trứng 3D trong game)
	if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then return false end

	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end

	for _, d in ipairs(desc) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = d.Text or ""
			-- Chỉ nhận diện khi có đúng tên tiêu đề hoặc từ khóa riêng biệt của Hub
			if t == "Figgy Hub" or t == "Banana Hub" or t == "FrostyFig"
				or t == "WHAT'S NEW" or t == "CÓ GÌ MỚI"
				or t == "AUTO STEAL" or t == "TỰ ĐỘNG CƯỚP TRỨNG"
				or t == "UFO SIGHTINGS" or t == "PHÁT HIỆN UFO"
				or t == "EQUIP BEST" or t == "TRANG BỊ MẠNH NHẤT"
			then
				gui:SetAttribute("__StrictBananaGui", true)
				return true
			end
		end
	end
	return false
end

-- ============================================================================
-- 2. HỆ THỐNG ÂM THANH TƯƠNG TÁC (TỨC THÌ, KHÔNG DELAY)
-- ============================================================================
local SOUND_CONFIG = {
	open   = { id = "rbxassetid://6895079853", vol = 0.55, spd = 1.06 },
	close  = { id = "rbxassetid://6895079853", vol = 0.44, spd = 0.88 },
	logo   = { id = "rbxassetid://6895079853", vol = 0.60, spd = 1.15 },
	tap    = { id = "rbxassetid://6026984224", vol = 0.48, spd = 1.14 },
	action = { id = "rbxassetid://4590662766", vol = 0.52, spd = 1.08 },
}

local function getCachedSound(kind)
	local key = kind or "tap"
	local cfg = SOUND_CONFIG[key] or SOUND_CONFIG.tap
	local snd = State.CachedSounds[key]
	if not (snd and snd.Parent) then
		snd = Instance.new("Sound")
		snd.Name = "BananaGoldSfx_" .. key
		snd.SoundId = cfg.id
		snd.Volume = cfg.vol
		snd.PlaybackSpeed = cfg.spd
		snd.Parent = SoundService
		State.CachedSounds[key] = snd
	end
	return snd
end

task.defer(function()
	pcall(function()
		for k in pairs(SOUND_CONFIG) do getCachedSound(k) end
	end)
end)

local lastSoundClock = 0
local function playUiSound(kind)
	if not State.SoundEnabled then return end
	local now = os.clock()
	if kind == "tap" and (now - lastSoundClock < 0.04) then return end
	lastSoundClock = now
	pcall(function()
		local snd = getCachedSound(kind or "tap")
		snd.TimePosition = 0
		if SoundService.PlayLocalSound then
			pcall(function() SoundService:PlayLocalSound(snd) end)
		end
		pcall(function() snd:Play() end)
	end)
end

-- ============================================================================
-- 3. BẢNG MÀU LUXURY GOLD & THIẾT KẾ HUY HIỆU VÀNG CAO CẤP (ANTI-GLARE)
-- ============================================================================
local BANANA_CAT_LOGO     = "rbxassetid://87447945720038"
local DOWN_ARROW_ICON     = "rbxassetid://6031091004"

local GOLD_PRIMARY_TEXT   = Color3.fromRGB(240, 210, 124) -- Vàng Champagne
local GOLD_BRIGHT_TITLE   = Color3.fromRGB(248, 218, 108) -- Vàng Hoàng Gia
local GOLD_ACCENT_FILL    = Color3.fromRGB(198, 154, 52)  -- Vàng đồng
local GOLD_BORDER_STROKE  = Color3.fromRGB(218, 172, 64)  -- Viền vàng kim
local GOLD_SOFT_CREAM     = Color3.fromRGB(226, 218, 202) -- Trắng kem ấm
local GOLD_MUTED_SUBTEXT  = Color3.fromRGB(156, 148, 130) -- Chữ phụ

local ISLAND_BG_DARK      = Color3.fromRGB(16, 16, 20)
local ISLAND_CARD_BG      = Color3.fromRGB(24, 23, 20)
local BTN_ACTIVE_BG       = Color3.fromRGB(52, 42, 22)
local BTN_ACTIVE_STROKE   = Color3.fromRGB(196, 156, 62)
local BTN_ACTIVE_TEXT     = Color3.fromRGB(240, 208, 120)
local BTN_INACTIVE_BG     = Color3.fromRGB(24, 24, 28)
local BTN_INACTIVE_STROKE = Color3.fromRGB(52, 48, 42)

-- Nền kem sang trọng làm tan biến viền trắng của ảnh Banana Cat
local BADGE_CREAM_GOLD_BG = Color3.fromRGB(246, 238, 216)

local function isFiggyPurpleColor(col)
	if not col then return false end
	return (col.B > 0.44 and col.R > 0.28 and (col.B - col.G) > 0.12)
end

local function applyMetallicGoldGradient(target)
	if not target then return end
	local grad = target:FindFirstChild("LuxuryGoldGradient") or Instance.new("UIGradient")
	grad.Name = "LuxuryGoldGradient"
	grad.Rotation = 45
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 238, 170)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(218, 172, 64)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(148, 108, 28)),
	})
	grad.Parent = target
	return grad
end

local function applyGoldGradientToTitle(titleLbl)
	if not titleLbl or titleLbl:FindFirstChild("BananaGoldTitleGrad") then return end
	titleLbl.TextColor3 = GOLD_BRIGHT_TITLE
	local grad = Instance.new("UIGradient")
	grad.Name = "BananaGoldTitleGrad"
	grad.Rotation = 90
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 232, 150)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(235, 190, 75)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(198, 148, 42)),
	})
	grad.Parent = titleLbl
end

local function playCircularLogoPulse(container, badgeImg, goldStroke, baseThickness)
	playUiSound("logo")
	if not container or not container.Parent then return end
	local defaultThick = baseThickness or 1.8
	pcall(function()
		TweenService:Create(container, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset - 4, container.Size.Y.Scale, container.Size.Y.Offset - 4)
		}):Play()
		if goldStroke then
			TweenService:Create(goldStroke, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Thickness = defaultThick + 1.2
			}):Play()
		end
		task.delay(0.085, function()
			if container and container.Parent then
				TweenService:Create(container, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset + 4, container.Size.Y.Scale, container.Size.Y.Offset + 4)
				}):Play()
			end
			if goldStroke and goldStroke.Parent then
				TweenService:Create(goldStroke, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Thickness = defaultThick
				}):Play()
			end
		end)
	end)
end

-- Trang trí khung nút thành Huy Hiệu Vàng Sang Trọng (Đồng bộ, Tinh tế, Hòa tan nền trắng)
local function decorateAsLuxuryGoldBadge(container, strokeThickness, isInnerBadge)
	if not container or not container:IsA("GuiObject") then return end
	local cw, ch = container.AbsoluteSize.X, container.AbsoluteSize.Y
	if cw > 72 or ch > 72 or cw < 14 or ch < 14 then return end

	-- Ẩn sprite quả sung cũ
	for _, desc in ipairs(container:GetDescendants()) do
		if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) and desc.Name ~= "BananaCatBadgeImage" then
			pcall(function() desc.ImageTransparency = 1 end)
			if desc:GetAttribute("__HideOrigConnected") ~= SID then
				desc:SetAttribute("__HideOrigConnected", SID)
				trackConn(desc:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
					if isAlive() and desc.ImageTransparency < 0.99 then
						pcall(function() desc.ImageTransparency = 1 end)
					end
				end))
			end
		end
	end

	pcall(function()
		container.BackgroundColor3 = isInnerBadge and BADGE_CREAM_GOLD_BG or Color3.fromRGB(24, 20, 16)
		container.BackgroundTransparency = 0
		local corner = container:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = container
	end)

	local thick = strokeThickness or 1.8
	local stroke = container:FindFirstChild("LuxuryGoldStroke") or container:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
	stroke.Name = "LuxuryGoldStroke"
	stroke.Color = GOLD_BORDER_STROKE
	stroke.Thickness = thick
	stroke.Transparency = 0.05
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = container
	applyMetallicGoldGradient(stroke)

	-- Lớp đệm Huy Hiệu Vàng Kem tròn bên trong để ảnh Banana Cat hòa quyện 100%
	local innerDisc = container:FindFirstChild("GoldBadgeInnerDisc")
	if not innerDisc then
		innerDisc = Instance.new("Frame")
		innerDisc.Name = "GoldBadgeInnerDisc"
		innerDisc.AnchorPoint = Vector2.new(0.5, 0.5)
		innerDisc.Position = UDim2.fromScale(0.5, 0.5)
		innerDisc.Size = UDim2.new(1, -4, 1, -4)
		innerDisc.BackgroundColor3 = BADGE_CREAM_GOLD_BG
		innerDisc.BorderSizePixel = 0
		innerDisc.ClipsDescendants = true
		innerDisc.ZIndex = (container.ZIndex or 5) + 2
		innerDisc.Parent = container
		Instance.new("UICorner", innerDisc).CornerRadius = UDim.new(1, 0)
	end

	local badgeImg = innerDisc:FindFirstChild("BananaCatBadgeImage")
	if not badgeImg then
		badgeImg = Instance.new("ImageLabel")
		badgeImg.Name = "BananaCatBadgeImage"
		badgeImg.AnchorPoint = Vector2.new(0.5, 0.5)
		badgeImg.Position = UDim2.fromScale(0.5, 0.5)
		badgeImg.Size = UDim2.new(0.88, 0, 0.88, 0)
		badgeImg.BackgroundTransparency = 1
		badgeImg.Image = BANANA_CAT_LOGO
		badgeImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
		badgeImg.ScaleType = Enum.ScaleType.Fit
		badgeImg.ZIndex = (innerDisc.ZIndex or 7) + 1
		badgeImg.Parent = innerDisc
	else
		badgeImg.Image = BANANA_CAT_LOGO
		badgeImg.Visible = true
	end

	-- Gắn hiệu ứng nhún nhẹ & âm thanh khi chạm
	if container:GetAttribute("__PulseHooked") ~= SID then
		container:SetAttribute("__PulseHooked", SID)
		if container:IsA("TextButton") or container:IsA("ImageButton") then
			trackConn(container.Activated:Connect(function()
				if isAlive() then playCircularLogoPulse(container, badgeImg, stroke, thick) end
			end))
		else
			trackConn(container.InputBegan:Connect(function(inp)
				if not isAlive() then return end
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					playCircularLogoPulse(container, badgeImg, stroke, thick)
				end
			end))
		end
	end
end

-- ============================================================================
-- 4. BỘ TỪ ĐIỂN & ĐỘNG CƠ DỊCH THUẬT SIÊU NHẸ (EVENT-DRIVEN)
-- ============================================================================
local EXACT_VI = {
	["Figgy Hub"] = "Banana Hub",
	["figgy hub"] = "Banana Hub",
	["FIGGY HUB"] = "BANANA HUB",
	["Figgy"] = "Banana Hub",
	["Banana Hub"] = "Banana Hub",
	["Steal an Egg"] = "Cướp Trứng",
	["Lemon"] = "Vàng Hoàng Gia (Gold)",
	["Idle"] = "Đang rảnh",
	["• Idle"] = "• Đang rảnh",
	["Running"] = "Đang chạy",
	["• Running"] = "• Đang chạy",
	["Home"] = "Trang Chủ",
	["Dashboard"] = "Trang Chủ",
	["Eggs"] = "Trứng",
	["Egg"] = "Trứng",
	["Steal"] = "Cướp Trứng",
	["Manage"] = "Quản Lý",
	["Management"] = "Quản Lý",
	["Farm"] = "Tự Cày",
	["Events"] = "Sự Kiện",
	["Event"] = "Sự Kiện",
	["System"] = "Hệ Thống",
	["Player"] = "Nhân Vật",
	["Visuals"] = "Hiển Thị",
	["Visual"] = "Hiển Thị",
	["ESP"] = "Định Vị (ESP)",
	["Settings"] = "Cài Đặt",
	["Setting"] = "Cài Đặt",
	["Config"] = "Cấu Hình",
	["Server"] = "Máy Chủ",
	["STOLEN"] = "ĐÃ CƯỚP",
	["IN PEN"] = "TRONG CHUỒNG",
	["INCOME /S"] = "THU NHẬP /GIÂY",
	["LAST EGG"] = "TRỨNG GẦN NHẤT",
	["BEST STEAL"] = "CƯỚP GIÁ TRỊ NHẤT",
	["Pet bag"] = "Túi thú cưng",
	["Egg bag"] = "Túi trứng",
	["Rejoin"] = "Vào lại server",
	["Find server"] = "Tìm máy chủ",
	["Copy Job ID"] = "Sao chép Job ID",
	["Unload"] = "Tắt Script",
	["WHAT'S NEW"] = "CÓ GÌ MỚI",
	["NEW"] = "MỚI",
	["Finder"] = "Tìm Thú",
	["Slow Mode"] = "Chế độ mượt",
	["Automation"] = "Tự Động",
	["Predictor"] = "Dự Đoán",
	["Auto Steal"] = "Tự động cướp trứng",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["STATUS"] = "TRẠNG THÁI",
	["SPEED"] = "TỐC ĐỘ",
	["FILTER"] = "BỘ LỌC",
	["BỘ LỌC"] = "BỘ LỌC",
	["Inventory"] = "Túi Đồ",
	["Place & Hatch"] = "Đặt & Ấp Trứng",
	["Upgrades"] = "Nâng Cấp",
	["Crafting"] = "Chế Tạo",
	["EQUIP BEST"] = "TRANG BỊ MẠNH NHẤT",
	["PETS"] = "THÚ CƯNG",
	["SELL EGGS"] = "BÁN TRỨNG",
	["SPACE LEFT"] = "CHỖ TRỐNG",
	["UFO SIGHTINGS"] = "PHÁT HIỆN UFO",
	["Guard: OFF"] = "Bảo vệ: TẮT",
	["Guard: ON"] = "Bảo vệ: BẬT",
	["Open >"] = "Mở >",
}

local GRAMMAR_VI = {
	{ pat = "^(.-)[Cc]arrying%s+(.+)$", rep = "%1Đang mang %2" },
	{ pat = "^(.-)[Hh]olding%s+(.+)$", rep = "%1Đang giữ %2" },
	{ pat = "^(.-)[Ss]tealing%s+(.+)$", rep = "%1Đang cướp %2" },
	{ pat = "^(.-)[Ff]arming%s+(.+)$", rep = "%1Đang cày %2" },
	{ pat = "^[Ss]ession%s+([%d:]+)$", rep = "Phiên: %1" },
	{ pat = "^Figgy%s+SAE%s*%-%s*[Uu]pdate%s+(.+)$", rep = "Banana Hub - Bản cập nhật %1" },
	{ pat = "^(%d+)%s+hours?%s+ago$", rep = "%1 giờ trước" },
	{ pat = "^([%d%.]+)%s*st/s%s*now$", rep = "%1 bước/giây hiện tại" },
	{ pat = "^(%d+)%s+[Ff]ree$", rep = "Còn trống %1 ô" },
	{ pat = "^[Tt]his%s+session$", rep = "trong phiên này" },
	{ pat = "^[Mm]ove%s+[Tt]o%s+[Ee]gg$", rep = "Di chuyển tới trứng" },
	{ pat = "^[Ss]ell%s+[Cc]heapest%s+[Ee]gg$", rep = "Bán trứng rẻ nhất khi đầy túi" },
	{ pat = "^[Mm]akes%s+room%s+when%s+the%s+.-%s+is%s+full$", rep = "Tự bán dọn chỗ khi túi trứng đầy" },
	{ pat = "^QUICK BAR (%d+)$", rep = "THANH NHANH %1" },
}

local function translateRawSegment(rawText)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
	local lead, trimmed, trail = rawText:match("^(%s*)(.-)(%s*)$")
	if not trimmed or trimmed == "" then return rawText end

	if trimmed == "Figgy Hub" or trimmed == "figgy hub" or trimmed == "Banana Hub" then
		return lead .. "Banana Hub" .. trail
	end

	if State.FastCache[trimmed] then
		return lead .. State.FastCache[trimmed] .. trail
	end

	local exact = EXACT_VI[trimmed]
	if exact then
		State.FastCache[trimmed] = exact
		return lead .. exact .. trail
	end

	for i = 1, #GRAMMAR_VI do
		local g = GRAMMAR_VI[i]
		if string.find(trimmed, g.pat) then
			local rep = string.gsub(trimmed, g.pat, g.rep)
			State.FastCache[trimmed] = rep
			return lead .. rep .. trail
		end
	end

	return rawText
end

local function formatIslandStatusText(rawStatus)
	local clean = tostring(rawStatus or "Idle"):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or "Idle"
	local low = string.lower(clean)
	local isIdle = (low == "" or low == "idle" or low == "đang rảnh")

	local prefixEmoji = State.CurrentStatusEmoji or ""
	if prefixEmoji ~= "" and not string.find(clean, prefixEmoji, 1, true) then
		prefixEmoji = prefixEmoji .. " "
	else
		prefixEmoji = ""
	end

	if isIdle then return prefixEmoji .. "Đang rảnh" end
	if low == "running" or low == "working" or low == "active" or low == "đang chạy" then
		return prefixEmoji .. "Đang chạy"
	end
	local viStr = translateRawSegment(clean)
	return prefixEmoji .. ((viStr and viStr ~= clean) and viStr or clean)
end

-- ============================================================================
-- 5. THIẾT KẾ BANANA HUB DYNAMIC ISLAND (HUY HIỆU VÀNG CAO CẤP)
-- ============================================================================
local PINNED_PILL_POS   = UDim2.new(0.5, 0, 0, 6)
local PINNED_DRAWER_POS = UDim2.new(0.5, 0, 0, 48)

local function applyGoldMatteGlass(frame, cornerRadius, bgAlpha)
	frame.BackgroundColor3 = ISLAND_BG_DARK
	frame.BackgroundTransparency = bgAlpha or 0.14
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or UDim.new(1, 0)
	corner.Parent = frame

	local stroke = frame:FindFirstChild("GoldMatteRimStroke") or Instance.new("UIStroke")
	stroke.Name = "GoldMatteRimStroke"
	stroke.Color = GOLD_BORDER_STROKE
	stroke.Thickness = 1.3
	stroke.Transparency = 0.20
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame
	applyMetallicGoldGradient(stroke)
	return stroke
end

local function createIndependentFiggyDynamicIsland()
	for _, root in ipairs(getUiRoots()) do
		for _, gName in ipairs({ "BananaDynamicIsland", "FiggyDynamicIsland" }) do
			local old = root:FindFirstChild(gName)
			if old then
				pcall(function()
					old.Name = "Old_BananaDynamicIsland"
					old.Enabled = false
					old:Destroy()
				end)
			end
		end
	end

	local islandGui = Instance.new("ScreenGui")
	islandGui.Name = "BananaDynamicIsland"
	islandGui.ResetOnSpawn = false
	islandGui.IgnoreGuiInset = true
	islandGui.DisplayOrder = 999999
	islandGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local okParent = pcall(function() islandGui.Parent = CoreGui end)
	if not okParent or not islandGui.Parent then
		if gethui then pcall(function() islandGui.Parent = gethui() end) end
	end
	if not islandGui.Parent and LocalPlayer then
		islandGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
	end

	-- ========================================================================
	-- VIÊN THUỐC NGOÀI (DYNAMIC ISLAND PILL - GHIM CỐ ĐỊNH Y = 6)
	-- ========================================================================
	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = PINNED_PILL_POS
	pillFrame.Size = UDim2.new(0, 210, 0, 38)
	pillFrame.Active = true
	pillFrame.ZIndex = 20
	pillFrame.Parent = islandGui

	trackConn(pillFrame:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and pillFrame.Position ~= PINNED_PILL_POS then
			pillFrame.Position = PINNED_PILL_POS
		end
	end))

	applyGoldMatteGlass(pillFrame, UDim.new(1, 0), 0.12)

	-- [Bên trái]: Huy Hiệu Vàng Sang Trọng Banana Cat (Bo tròn, hòa tan nền trắng)
	local logoBadge = Instance.new("Frame")
	logoBadge.Name = "BananaCatGoldBadge"
	logoBadge.AnchorPoint = Vector2.new(0, 0.5)
	logoBadge.Position = UDim2.new(0, 6, 0.5, 0)
	logoBadge.Size = UDim2.new(0, 28, 0, 28)
	logoBadge.ZIndex = 22
	logoBadge.Parent = pillFrame
	decorateAsLuxuryGoldBadge(logoBadge, 1.8, true)

	-- [Khung Trạng Thái Bê Nguyên Từ Header]
	local statusBadgeContainer = Instance.new("Frame")
	statusBadgeContainer.Name = "TransplantedStatusBadge"
	statusBadgeContainer.AnchorPoint = Vector2.new(0, 0.5)
	statusBadgeContainer.Position = UDim2.new(0, 40, 0.5, 0)
	statusBadgeContainer.Size = UDim2.new(1, -66, 0, 26)
	statusBadgeContainer.BackgroundColor3 = Color3.fromRGB(24, 22, 18)
	statusBadgeContainer.BackgroundTransparency = 0.25
	statusBadgeContainer.BorderSizePixel = 0
	statusBadgeContainer.ZIndex = 22
	statusBadgeContainer.Parent = pillFrame
	Instance.new("UICorner", statusBadgeContainer).CornerRadius = UDim.new(1, 0)

	local badgeInnerStroke = Instance.new("UIStroke")
	badgeInnerStroke.Color = Color3.fromRGB(115, 92, 42)
	badgeInnerStroke.Thickness = 1
	badgeInnerStroke.Transparency = 0.45
	badgeInnerStroke.Parent = statusBadgeContainer

	local statusIconImg = Instance.new("ImageLabel")
	statusIconImg.Name = "TransplantedStatusIcon"
	statusIconImg.AnchorPoint = Vector2.new(0, 0.5)
	statusIconImg.Position = UDim2.new(0, 7, 0.5, 0)
	statusIconImg.Size = UDim2.new(0, 15, 0, 15)
	statusIconImg.BackgroundTransparency = 1
	statusIconImg.Image = State.CurrentStatusImage or ""
	statusIconImg.Visible = (State.CurrentStatusImage ~= nil and State.CurrentStatusImage ~= "")
	statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
	statusIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
	statusIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
	statusIconImg.ScaleType = Enum.ScaleType.Fit
	statusIconImg.ZIndex = 23
	statusIconImg.Parent = statusBadgeContainer

	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0, 0.5)
	centerStatusLabel.Position = statusIconImg.Visible and UDim2.new(0, 26, 0.5, 0) or UDim2.new(0, 10, 0.5, 0)
	centerStatusLabel.Size = statusIconImg.Visible and UDim2.new(1, -32, 1, 0) or UDim2.new(1, -16, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = GOLD_PRIMARY_TEXT
	centerStatusLabel.TextSize = 11.5
	centerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	centerStatusLabel.Text = formatIslandStatusText(State.CurrentRawStatus)
	centerStatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
	centerStatusLabel.ZIndex = 23
	centerStatusLabel.Parent = statusBadgeContainer

	local rightArrow = Instance.new("ImageLabel")
	rightArrow.Name = "ArrowIcon"
	rightArrow.AnchorPoint = Vector2.new(1, 0.5)
	rightArrow.Position = UDim2.new(1, -8, 0.5, 0)
	rightArrow.Size = UDim2.new(0, 12, 0, 12)
	rightArrow.BackgroundTransparency = 1
	rightArrow.Image = DOWN_ARROW_ICON
	rightArrow.ImageColor3 = GOLD_MUTED_SUBTEXT
	rightArrow.ScaleType = Enum.ScaleType.Fit
	rightArrow.ZIndex = 23
	rightArrow.Parent = pillFrame

	local pillClickBtn = Instance.new("TextButton")
	pillClickBtn.Name = "IslandToggleButton"
	pillClickBtn.Size = UDim2.fromScale(1, 1)
	pillClickBtn.BackgroundTransparency = 1
	pillClickBtn.Text = ""
	pillClickBtn.AutoButtonColor = false
	pillClickBtn.ZIndex = 25
	pillClickBtn.Parent = pillFrame

	-- ========================================================================
	-- BẢNG MỞ RỘNG BÊN TRONG (GOLD PREMIUM DRAWER)
	-- ========================================================================
	local EXP_W = 316
	local COLLAPSED_EXP_H = 168

	local expandPanel = Instance.new("Frame")
	expandPanel.Name = "LanguageDrawer"
	expandPanel.AnchorPoint = Vector2.new(0.5, 0)
	expandPanel.Position = PINNED_DRAWER_POS
	expandPanel.Size = UDim2.new(0, EXP_W, 0, COLLAPSED_EXP_H)
	expandPanel.Visible = false
	expandPanel.Active = true
	expandPanel.ClipsDescendants = true
	expandPanel.ZIndex = 30
	expandPanel.Parent = islandGui

	trackConn(expandPanel:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and expandPanel.Position ~= PINNED_DRAWER_POS then
			expandPanel.Position = PINNED_DRAWER_POS
		end
	end))

	applyGoldMatteGlass(expandPanel, UDim.new(0, 18), 0.10)

	local expLogoBadge = Instance.new("Frame")
	expLogoBadge.Position = UDim2.new(0, 12, 0, 10)
	expLogoBadge.Size = UDim2.new(0, 28, 0, 28)
	expLogoBadge.ZIndex = 32
	expLogoBadge.Parent = expandPanel
	decorateAsLuxuryGoldBadge(expLogoBadge, 1.6, true)

	local expTitle = Instance.new("TextLabel")
	expTitle.Position = UDim2.new(0, 48, 0, 9)
	expTitle.Size = UDim2.new(0, 180, 0, 15)
	expTitle.BackgroundTransparency = 1
	expTitle.Font = Enum.Font.GothamBold
	expTitle.TextSize = 11.5
	expTitle.TextColor3 = GOLD_BRIGHT_TITLE
	expTitle.TextXAlignment = Enum.TextXAlignment.Left
	expTitle.Text = "BANANA HUB • GOLD PREMIUM"
	expTitle.ZIndex = 33
	expTitle.Parent = expandPanel
	applyGoldGradientToTitle(expTitle)

	local expSubBadge = Instance.new("TextLabel")
	expSubBadge.Position = UDim2.new(0, 48, 0, 24)
	expSubBadge.Size = UDim2.new(0, 180, 0, 12)
	expSubBadge.BackgroundTransparency = 1
	expSubBadge.Font = Enum.Font.GothamMedium
	expSubBadge.TextSize = 8.5
	expSubBadge.TextColor3 = GOLD_MUTED_SUBTEXT
	expSubBadge.TextXAlignment = Enum.TextXAlignment.Left
	expSubBadge.Text = "● ĐỒNG BỘ SIÊU TỐC • ZERO LAG"
	expSubBadge.ZIndex = 33
	expSubBadge.Parent = expandPanel

	local collapseBtn = Instance.new("TextButton")
	collapseBtn.Name = "CollapseIslandBtn"
	collapseBtn.Position = UDim2.new(1, -78, 0, 11)
	collapseBtn.Size = UDim2.new(0, 66, 0, 22)
	collapseBtn.BackgroundColor3 = BTN_INACTIVE_BG
	collapseBtn.BorderSizePixel = 0
	collapseBtn.Text = "Thu gọn ▲"
	collapseBtn.Font = Enum.Font.GothamMedium
	collapseBtn.TextSize = 9.5
	collapseBtn.TextColor3 = GOLD_SOFT_CREAM
	collapseBtn.AutoButtonColor = false
	collapseBtn.ZIndex = 34
	collapseBtn.Parent = expandPanel
	Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(1, 0)
	local cbStroke = Instance.new("UIStroke", collapseBtn)
	cbStroke.Color = BTN_INACTIVE_STROKE
	cbStroke.Thickness = 1

	local liveStatusCard = Instance.new("Frame")
	liveStatusCard.Name = "LiveStatusCard"
	liveStatusCard.Position = UDim2.new(0, 12, 0, 44)
	liveStatusCard.Size = UDim2.new(1, -24, 0, 28)
	liveStatusCard.BackgroundColor3 = ISLAND_CARD_BG
	liveStatusCard.BorderSizePixel = 0
	liveStatusCard.ZIndex = 32
	liveStatusCard.Parent = expandPanel
	Instance.new("UICorner", liveStatusCard).CornerRadius = UDim.new(0, 8)
	local lscStroke = Instance.new("UIStroke", liveStatusCard)
	lscStroke.Color = Color3.fromRGB(92, 74, 34)
	lscStroke.Thickness = 1
	lscStroke.Transparency = 0.35

	local cardIconImg = Instance.new("ImageLabel")
	cardIconImg.Name = "CardIcon"
	cardIconImg.AnchorPoint = Vector2.new(0, 0.5)
	cardIconImg.Position = UDim2.new(0, 8, 0.5, 0)
	cardIconImg.Size = UDim2.new(0, 16, 0, 16)
	cardIconImg.BackgroundTransparency = 1
	cardIconImg.Image = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or BANANA_CAT_LOGO
	cardIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
	cardIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
	cardIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
	cardIconImg.ScaleType = Enum.ScaleType.Fit
	cardIconImg.ZIndex = 33
	cardIconImg.Parent = liveStatusCard

	local cardStatusLbl = Instance.new("TextLabel")
	cardStatusLbl.Name = "CardStatusText"
	cardStatusLbl.Position = UDim2.new(0, 30, 0, 0)
	cardStatusLbl.Size = UDim2.new(1, -38, 1, 0)
	cardStatusLbl.BackgroundTransparency = 1
	cardStatusLbl.Font = Enum.Font.GothamBold
	cardStatusLbl.TextSize = 11
	cardStatusLbl.TextColor3 = GOLD_PRIMARY_TEXT
	cardStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
	cardStatusLbl.TextTruncate = Enum.TextTruncate.AtEnd
	cardStatusLbl.Text = formatIslandStatusText(State.CurrentRawStatus)
	cardStatusLbl.ZIndex = 33
	cardStatusLbl.Parent = liveStatusCard

	local actionRow = Instance.new("Frame")
	actionRow.Name = "ActionRow"
	actionRow.Position = UDim2.new(0, 12, 0, 80)
	actionRow.Size = UDim2.new(1, -24, 0, 30)
	actionRow.BackgroundTransparency = 1
	actionRow.ZIndex = 32
	actionRow.Parent = expandPanel

	local soundToggleBtn = Instance.new("TextButton")
	soundToggleBtn.Name = "SoundToggleBtn"
	soundToggleBtn.Position = UDim2.new(0, 0, 0, 0)
	soundToggleBtn.Size = UDim2.new(0.5, -4, 1, 0)
	soundToggleBtn.BackgroundColor3 = BTN_INACTIVE_BG
	soundToggleBtn.BorderSizePixel = 0
	soundToggleBtn.Font = Enum.Font.GothamMedium
	soundToggleBtn.TextSize = 10
	soundToggleBtn.TextColor3 = GOLD_SOFT_CREAM
	soundToggleBtn.Text = State.SoundEnabled and "🔊 Âm thanh: BẬT" or "🔇 Âm thanh: TẮT"
	soundToggleBtn.AutoButtonColor = false
	soundToggleBtn.ZIndex = 34
	soundToggleBtn.Parent = actionRow
	Instance.new("UICorner", soundToggleBtn).CornerRadius = UDim.new(0, 8)
	local sbStroke = Instance.new("UIStroke", soundToggleBtn)
	sbStroke.Color = BTN_INACTIVE_STROKE
	sbStroke.Thickness = 1

	local rescanBtn = Instance.new("TextButton")
	rescanBtn.Name = "RescanTranslateBtn"
	rescanBtn.Position = UDim2.new(0.5, 4, 0, 0)
	rescanBtn.Size = UDim2.new(0.5, -4, 1, 0)
	rescanBtn.BackgroundColor3 = BTN_ACTIVE_BG
	rescanBtn.BorderSizePixel = 0
	rescanBtn.Font = Enum.Font.GothamMedium
	rescanBtn.TextSize = 10
	rescanBtn.TextColor3 = GOLD_PRIMARY_TEXT
	rescanBtn.Text = "⚡ Làm mới Menu"
	rescanBtn.AutoButtonColor = false
	rescanBtn.ZIndex = 34
	rescanBtn.Parent = actionRow
	Instance.new("UICorner", rescanBtn).CornerRadius = UDim.new(0, 8)
	local rbStroke = Instance.new("UIStroke", rescanBtn)
	rbStroke.Color = BTN_ACTIVE_STROKE
	rbStroke.Thickness = 1
	rbStroke.Transparency = 0.30

	local infoBanner = Instance.new("Frame")
	infoBanner.Name = "InfoBanner"
	infoBanner.Position = UDim2.new(0, 12, 0, 120)
	infoBanner.Size = UDim2.new(1, -24, 0, 36)
	infoBanner.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	infoBanner.BorderSizePixel = 0
	infoBanner.ZIndex = 32
	infoBanner.Parent = expandPanel
	Instance.new("UICorner", infoBanner).CornerRadius = UDim.new(0, 8)

	local ibText = Instance.new("TextLabel", infoBanner)
	ibText.Size = UDim2.fromScale(1, 1)
	ibText.BackgroundTransparency = 1
	ibText.Font = Enum.Font.GothamMedium
	ibText.TextSize = 9.5
	ibText.TextColor3 = GOLD_MUTED_SUBTEXT
	ibText.Text = "🍌 Banana Hub Luxury Gold • Khởi động tức thì & Zero Lag"
	ibText.ZIndex = 33

	local function updatePillVisuals()
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		centerStatusLabel.Text = displayTxt
		cardStatusLbl.Text = displayTxt

		local hasCustomImg = (State.CurrentStatusImage ~= nil and State.CurrentStatusImage ~= "")
		statusIconImg.Visible = hasCustomImg
		if hasCustomImg then
			statusIconImg.Image = State.CurrentStatusImage
			statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
			statusIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
			statusIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
			centerStatusLabel.Position = UDim2.new(0, 26, 0.5, 0)
			centerStatusLabel.Size = UDim2.new(1, -32, 1, 0)

			cardIconImg.Image = State.CurrentStatusImage
			cardIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
			cardIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
			cardIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
		else
			centerStatusLabel.Position = UDim2.new(0, 10, 0.5, 0)
			centerStatusLabel.Size = UDim2.new(1, -16, 1, 0)
		end

		soundToggleBtn.Text = State.SoundEnabled and "🔊 Âm thanh: BẬT" or "🔇 Âm thanh: TẮT"

		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(196, math.min(320, 96 + textLen * 7))
		TweenService:Create(pillFrame, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, targetWidth, 0, 38)
		}):Play()
	end

	State.UpdateIslandVisuals = updatePillVisuals
	State.IslandGui = islandGui
	State.IslandPill = pillFrame
	State.IslandStatusLabel = centerStatusLabel
	State.IslandStatusIcon = statusIconImg

	trackConn(soundToggleBtn.Activated:Connect(function()
		State.SoundEnabled = not State.SoundEnabled
		if State.SoundEnabled then playUiSound("action") end
		updatePillVisuals()
	end))

	trackConn(rescanBtn.Activated:Connect(function()
		playUiSound("action")
		if State.RefreshAllMenus then task.spawn(State.RefreshAllMenus) end
	end))

	local lastToggleClock = -10
	local function toggleIslandExpand()
		if os.clock() - lastToggleClock < 0.14 then return end
		lastToggleClock = os.clock()
		State.IsExpanded = not State.IsExpanded
		playCircularLogoPulse(logoBadge, nil, 1.8)

		if State.IsExpanded then
			expandPanel.Position = PINNED_DRAWER_POS
			expandPanel.Visible = true
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, EXP_W, 0, COLLAPSED_EXP_H) }):Play()
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
		else
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
			expandPanel.Visible = false
		end
	end

	trackConn(pillClickBtn.Activated:Connect(toggleIslandExpand))
	trackConn(collapseBtn.Activated:Connect(toggleIslandExpand))

	updatePillVisuals()
	return islandGui
end

-- ============================================================================
-- 6. ĐỒNG BỘ TRẠNG THÁI HEADER REALTIME VÀO DYNAMIC ISLAND
-- ============================================================================
local function cloakOriginalStatusBadge(badgeFrame)
	if not badgeFrame or not badgeFrame:IsA("GuiObject") then return end
	pcall(function()
		badgeFrame.BackgroundTransparency = 1
		for _, ch in ipairs(badgeFrame:GetDescendants()) do
			if ch:IsA("UIStroke") then ch.Transparency = 1
			elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
				ch.TextTransparency = 1; ch.TextStrokeTransparency = 1; ch.BackgroundTransparency = 1
			elseif ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
				ch.ImageTransparency = 1; ch.BackgroundTransparency = 1
			elseif ch:IsA("Frame") then
				ch.BackgroundTransparency = 1
			end
		end
	end)
end

local function syncStatusFromLiveWidgets()
	if not isAlive() then return end
	local txtObj = State.LiveFiggyTextLabel
	local imgObj = State.LiveFiggyImageLabel

	local rawText = ""
	if txtObj and txtObj.Parent then
		rawText = txtObj:GetAttribute("__FiggyOrigText") or txtObj.Text or ""
		if rawText == "" then rawText = txtObj.Text or "" end
	end

	if rawText ~= "" then State.CurrentRawStatus = rawText end

	if imgObj and imgObj.Parent and (imgObj.Image or "") ~= "" then
		State.CurrentStatusImage = imgObj.Image
		State.CurrentStatusImageColor = imgObj.ImageColor3 or Color3.fromRGB(255, 255, 255)
		State.CurrentStatusRectOffset = imgObj.ImageRectOffset or Vector2.new(0, 0)
		State.CurrentStatusRectSize = imgObj.ImageRectSize or Vector2.new(0, 0)
	end

	if State.LiveFiggyBadgeFrame and State.LiveFiggyBadgeFrame.Parent then
		cloakOriginalStatusBadge(State.LiveFiggyBadgeFrame)
	end

	if State.UpdateIslandVisuals then pcall(State.UpdateIslandVisuals) end
end

local function bindHeaderAndLogosFromTitle(titleLbl)
	if not titleLbl or not titleLbl.Parent then return end
	if titleLbl.AbsoluteSize.Y > 0 and titleLbl.AbsoluteSize.Y < 13 then return end

	local headerContainer = titleLbl.Parent
	for _ = 1, 3 do
		if headerContainer and headerContainer.Parent and headerContainer.Parent:IsA("GuiObject") then
			if headerContainer.Parent.AbsoluteSize.Y > 0 and headerContainer.Parent.AbsoluteSize.Y <= 78 then
				headerContainer = headerContainer.Parent
			else
				break
			end
		end
	end

	if not headerContainer then return end

	-- Chỉ gắn Huy Hiệu Vàng vào đúng Logo nhỏ bên trái tiêu đề Banana Hub trên Header
	for _, d in ipairs(headerContainer:GetDescendants()) do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Name ~= "BananaCatBadgeImage" and d.Parent ~= State.LiveFiggyBadgeFrame then
			local box = (d.Parent and d.Parent:IsA("GuiObject") and d.Parent.AbsoluteSize.X <= 46 and d.Parent.AbsoluteSize.Y <= 46) and d.Parent or d
			local bw, bh = box.AbsoluteSize.X, box.AbsoluteSize.Y
			local isSmallSquare = (bw >= 16 and bw <= 46 and bh >= 16 and bh <= 46 and math.abs(bw - bh) <= 8)
			local isLeftOfTitle = (box.AbsolutePosition.X <= titleLbl.AbsolutePosition.X + 10)
			if isSmallSquare and isLeftOfTitle then
				decorateAsLuxuryGoldBadge(box, 1.6, true)
				break
			end
		end
	end

	-- Tìm Thanh Trạng Thái (Status Pill) trên Header
	for _, desc in ipairs(headerContainer:GetDescendants()) do
		if desc:IsA("Frame") and not desc:FindFirstChildWhichIsA("TextBox") and not desc:FindFirstChild("GoldBadgeInnerDisc") then
			if not desc:IsAncestorOf(titleLbl) and desc ~= titleLbl.Parent then
				local candidateTxt = nil
				local candidateImg = nil

				for _, ch in ipairs(desc:GetDescendants()) do
					if (ch:IsA("ImageLabel") or ch:IsA("ImageButton")) and ch.Name ~= "BananaCatBadgeImage" then
						candidateImg = ch
					elseif ch:IsA("TextLabel") then
						local t = (ch.Text or ""):match("^%s*(.-)%s*$") or ""
						if t ~= "" and t ~= "Banana Hub" and t ~= "Figgy Hub" and not t:find("^v%d+%.%d+") and t ~= "Cướp Trứng" then
							candidateTxt = ch
						end
					end
				end

				if candidateTxt then
					State.LiveFiggyTextLabel = candidateTxt
					State.LiveFiggyImageLabel = candidateImg
					State.LiveFiggyBadgeFrame = desc
					trackConn(candidateTxt:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets))
					if candidateImg then
						trackConn(candidateImg:GetPropertyChangedSignal("Image"):Connect(syncStatusFromLiveWidgets))
					end
					cloakOriginalStatusBadge(desc)
					syncStatusFromLiveWidgets()
					return true
				end
			end
		end
	end
	return false
end

-- ============================================================================
-- 7. CHUYỂN NÚT TÍM THÀNH NÚT VÀNG HOÀNG GIA & KHÔNG ĐỤNG VÀO NÚT CỦA GAME
-- ============================================================================
local function checkAndDecorateBananaButton(obj)
	if not obj or not obj.Parent then return end
	if not (obj:IsA("Frame") or obj:IsA("ImageButton") or obj:IsA("TextButton")) then return end

	local aw, ah = obj.AbsoluteSize.X, obj.AbsoluteSize.Y
	if aw < 28 or aw > 68 or ah < 28 or ah > 68 or math.abs(aw - ah) > 8 then return end

	-- Bỏ qua nếu nằm trong game GUI (như Finder, Shop, Index, Backpack)
	local p = obj.Parent
	while p do
		local pn = p.Name or ""
		if pn == "Shop" or pn == "Index" or pn == "Finder" or pn == "TouchGui" or pn == "Backpack" then
			return
		end
		p = p.Parent
	end

	-- Kiểm tra nếu nút này chứa ảnh màu tím gốc của Figgy Hub (nút tím ở góc phải màn hình trong 7937.jpg)
	local hasPurpleImg = false
	for _, d in ipairs(obj:GetDescendants()) do
		if d:IsA("ImageLabel") or d:IsA("ImageButton") then
			if isFiggyPurpleColor(d.ImageColor3) or isFiggyPurpleColor(obj.BackgroundColor3) then
				hasPurpleImg = true
				break
			end
		end
	end

	if hasPurpleImg or isFiggyPurpleColor(obj.BackgroundColor3) then
		decorateAsLuxuryGoldBadge(obj, 2.0, false)
	end
end

local function styleElementGold(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end
	if obj.Name == "BananaCatBadgeImage" or obj.Name == "GoldBadgeInnerDisc" or obj.Name == "LuxuryGoldStroke" then return end

	checkAndDecorateBananaButton(obj)

	if isFiggyPurpleColor(obj.BackgroundColor3) then
		pcall(function() obj.BackgroundColor3 = GOLD_ACCENT_FILL end)
	end

	if obj:IsA("UIStroke") and isFiggyPurpleColor(obj.Color) then
		pcall(function() obj.Color = GOLD_BORDER_STROKE end)
	end

	if obj:IsA("TextLabel") or obj:IsA("TextButton") then
		if isFiggyPurpleColor(obj.TextColor3) then
			pcall(function() obj.TextColor3 = GOLD_PRIMARY_TEXT end)
		end
	end
end

-- ============================================================================
-- 8. GẮN ÂM THANH & VIỆT HÓA MENU (EVENT-DRIVEN 100%, KHÔNG VÒNG LẶP)
-- ============================================================================
local function hookMenuButtonSound(inst)
	if not inst or not inst.Parent then return end
	if State.IslandGui and inst:IsDescendantOf(State.IslandGui) then return end
	if inst:GetAttribute("__SfxHooked") == SID then return end

	if inst:IsA("TextButton") or inst:IsA("ImageButton") then
		inst:SetAttribute("__SfxHooked", SID)
		trackConn(inst.Activated:Connect(function()
			if isAlive() then playUiSound("tap") end
		end))
	end
end

local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	pcall(styleElementGold, obj)

	if obj:IsA("TextButton") or obj:IsA("ImageButton") then
		pcall(hookMenuButtonSound, obj)
	end

	if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then return end
	if obj:GetAttribute("__IsTranslating") then return end

	local curText = obj.Text or ""
	if curText == "" then return end

	if obj:IsA("TextLabel") and (curText == "Figgy Hub" or curText == "Banana Hub" or curText == "FrostyFig") then
		pcall(applyGoldGradientToTitle, obj)
		pcall(bindHeaderAndLogosFromTitle, obj)
	end

	local lastTranslated = obj:GetAttribute("__LastTranslated")
	if not obj:GetAttribute("__OrigText") or (lastTranslated and curText ~= lastTranslated) then
		obj:SetAttribute("__OrigText", curText)
	end

	local origText = obj:GetAttribute("__OrigText") or curText
	local translated = translateRawSegment(origText)

	if translated and translated ~= curText then
		obj:SetAttribute("__IsTranslating", true)
		obj:SetAttribute("__LastTranslated", translated)
		pcall(function() obj.Text = translated end)
		obj:SetAttribute("__IsTranslating", false)
	end

	if obj:GetAttribute("__TextWatched") ~= SID then
		obj:SetAttribute("__TextWatched", SID)
		table.insert(State.TrackedLabels, obj)
		trackConn(obj:GetPropertyChangedSignal("Text"):Connect(function()
			if not isAlive() or obj:GetAttribute("__IsTranslating") then return end
			processGuiElement(obj)
		end))
	end
end

local function refreshAllTranslatedMenus()
	State.FastCache = {}
	for i = #State.TrackedLabels, 1, -1 do
		local lbl = State.TrackedLabels[i]
		if lbl and lbl.Parent then
			pcall(processGuiElement, lbl)
		else
			table.remove(State.TrackedLabels, i)
		end
	end
	pcall(syncStatusFromLiveWidgets)
end
State.RefreshAllMenus = refreshAllTranslatedMenus

local function hookStrictGui(gui)
	if not gui or gui:GetAttribute("__GuiHooked") == SID then return end
	if not isStrictFiggyGui(gui) then return end
	gui:SetAttribute("__GuiHooked", SID)

	trackConn(gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		task.defer(function()
			if isAlive() and desc and desc.Parent then
				pcall(processGuiElement, desc)
			end
		end)
	end))

	task.spawn(function()
		local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
		if okDesc and type(descendants) == "table" then
			for i, d in ipairs(descendants) do
				if not isAlive() then break end
				pcall(processGuiElement, d)
				if i % 300 == 0 then task.wait() end
			end
		end
	end)
end

-- ============================================================================
-- 9. KHỞI CHẠY KHÔNG DELAY (ZERO DELAY STARTUP)
-- ============================================================================
createIndependentFiggyDynamicIsland()

task.spawn(function()
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do pcall(hookStrictGui, gui) end
		end

		trackConn(root.ChildAdded:Connect(function(newGui)
			if not isAlive() then return end
			task.delay(0.20, function()
				if isAlive() and newGui and newGui.Parent then pcall(hookStrictGui, newGui) end
			end)
		end))
	end
end)
