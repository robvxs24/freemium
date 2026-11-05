-- ============================================================================
-- BANANA HUB V1.0.6+ (GOLD PREMIUM EDITION) | VIỆT HÓA 100% & DYNAMIC ISLAND DỊU MẮT
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- 1. Hiển thị chuẩn 100% Logo Banana Cat (ID: 87447945720038) bằng rbxthumb://type=Asset
--    kèm lớp phủ chống ghi đè hoạt ảnh spritesheet trên Header, Nút Nổi và Dynamic Island
-- 2. Việt hóa toàn diện 100% mọi Tab (Trang Chủ, Trứng, Quản Lý, Sự Kiện, Nhân Vật,
--    Hiển Thị, Cài Đặt, Tìm Thú / Pet Finder, Nhật Ký Cập Nhật What's New)
-- 3. Bê nguyên Hình Ảnh Icon & Trạng Thái thực tế từ Header vào Dynamic Island (Realtime)
-- 4. Giao diện Vàng Sang Trọng (Luxury Gold Premium) dịu mắt, chống chói 100%
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

-- Quản lý trạng thái phiên chạy
local env = (getgenv and getgenv()) or _G
env.__FiggyIslandState = env.__FiggyIslandState or {}
local State = env.__FiggyIslandState
State.SessionId = (State.SessionId or 0) + 1
local SID = State.SessionId
State.Language = State.Language or "VI" -- "VI" hoặc "EN"
State.CurrentRawStatus = State.CurrentRawStatus or "Idle"
State.CurrentStatusImage = State.CurrentStatusImage or ""
State.CurrentStatusImageColor = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
State.CurrentStatusRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
State.CurrentStatusRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
State.CurrentStatusEmoji = State.CurrentStatusEmoji or ""
State.SoundEnabled = (State.SoundEnabled ~= false)
State.IsExpanded = false
State.NoteOpen = false
State.TrackedLabels = State.TrackedLabels or {}
State.FastCache = {}
State.CachedSounds = State.CachedSounds or {}
State.OrigFiggyLogoAssetIds = State.OrigFiggyLogoAssetIds or {}
State.BananaLogoOverlays = State.BananaLogoOverlays or {}

local function isAlive()
	return State.SessionId == SID
end

-- ============================================================================
-- 1. KHỞI CHẠY TRỰC TIẾP SCRIPT GỐC (FIGGY / BANANA HUB LOADER)
-- ============================================================================
local FIGGY_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"

task.spawn(function()
	loadstring(game:HttpGet(FIGGY_LOADER_URL))()
end)

local IGNORED_SCREEN_GUIS = {
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

-- Nhận diện chính xác ScreenGui của Figgy Hub / Banana Hub
local function isFiggyTargetGui(gui)
	if not gui then return false end
	if gui:GetAttribute("__VerifiedFiggyGui") then return true end
	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end
	for _, d in ipairs(desc) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = d.Text or ""
			if t == "Figgy Hub" or t == "Banana Hub" or t == "FrostyFig"
				or t == "Steal an Egg" or t == "Cướp Trứng"
				or t == "WHAT'S NEW" or t == "CÓ GÌ MỚI"
				or t == "AUTO STEAL" or t == "TỰ ĐỘNG CƯỚP TRỨNG"
				or t == "UFO SIGHTINGS" or t == "PHÁT HIỆN UFO"
				or t == "EQUIP BEST" or t == "TRANG BỊ MẠNH NHẤT"
				or t == "Guard: OFF" or t == "Bảo vệ: TẮT"
				or t:find("^Shortcut %d+$") or t:find("^Phím Tắt %d+$")
				or t:find("^THANH NHANH %d+$") or t:find("^QUICK BAR %d+$")
			then
				gui:SetAttribute("__VerifiedFiggyGui", true)
				return true
			end
		end
	end
	return false
end

-- ============================================================================
-- 2. HỆ THỐNG ÂM THANH TƯƠNG TÁC (MENU & DYNAMIC ISLAND - ZERO LATENCY)
-- ============================================================================
local SOUND_CONFIG = {
	open   = { id = "rbxassetid://6895079853", vol = 0.55, spd = 1.06 },
	close  = { id = "rbxassetid://6895079853", vol = 0.45, spd = 0.86 },
	tap    = { id = "rbxassetid://6026984224", vol = 0.52, spd = 1.14 },
	action = { id = "rbxassetid://4590662766", vol = 0.55, spd = 1.08 },
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
		for k in pairs(SOUND_CONFIG) do
			getCachedSound(k)
		end
	end)
end)

local lastSoundClock = 0
local function playUiSound(kind)
	if not State.SoundEnabled then return end
	local now = os.clock()
	if kind == "tap" and (now - lastSoundClock < 0.045) then return end
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
-- 3. BẢNG MÀU LUXURY GOLD PREMIUM & LOGO BANANA CAT (HIỂN THỊ 100% MỌI THIẾT BỊ)
-- ============================================================================
-- Sử dụng chuẩn rbxthumb://type=Asset để hiển thị trực tiếp mọi ID ảnh/Decal (87447945720038)
-- không bao giờ bị trống/đen ô như rbxassetid:// khi truyền Decal ID!
local BANANA_CAT_ASSET_ID = "87447945720038"
local BANANA_CAT_LOGO     = "rbxthumb://type=Asset&id=" .. BANANA_CAT_ASSET_ID .. "&w=420&h=420"
local DOWN_ARROW_ICON     = "rbxassetid://6031091004"

-- Nếu Executor hỗ trợ game:GetObjects, tự động lấy thêm Texture gốc làm phương án dự phòng
task.spawn(function()
	pcall(function()
		if game.GetObjects then
			local objs = game:GetObjects("rbxassetid://" .. BANANA_CAT_ASSET_ID)
			if objs and objs[1] then
				local o = objs[1]
				local tex = (o:IsA("Decal") or o:IsA("Texture")) and o.Texture or (o:IsA("ImageLabel") and o.Image) or nil
				if type(tex) == "string" and tex ~= "" then
					BANANA_CAT_LOGO = tex
					for _, ov in ipairs(State.BananaLogoOverlays) do
						if ov and ov.Parent then
							pcall(function() ov.Image = BANANA_CAT_LOGO end)
						end
					end
				end
				pcall(function() o:Destroy() end)
			end
		end
	end)
end)

-- Bảng màu Vàng Sang Trọng (Luxury Matte Gold Premium - Dịu mắt, Không trói mắt)
local GOLD_PRIMARY_TEXT   = Color3.fromRGB(238, 206, 118) -- Vàng Champagne sang trọng
local GOLD_BRIGHT_TITLE   = Color3.fromRGB(246, 212, 102) -- Vàng Hoàng Gia cho tiêu đề Banana Hub
local GOLD_ACCENT_FILL    = Color3.fromRGB(198, 154, 52)  -- Vàng đồng trầm cho thanh gạt/tab trong menu
local GOLD_BORDER_STROKE  = Color3.fromRGB(176, 138, 56)  -- Viền vàng kim mờ sang trọng
local GOLD_SOFT_CREAM     = Color3.fromRGB(224, 216, 198) -- Chữ kem ấm dịu mắt trong Dynamic Island
local GOLD_MUTED_SUBTEXT  = Color3.fromRGB(154, 146, 128) -- Chữ phụ xám vàng êm dịu

-- Nền & Nút trong Dynamic Island (Tông Đen Obsidian & Nâu Vàng Espresso chống chói mắt)
local ISLAND_BG_DARK      = Color3.fromRGB(16, 16, 20)    -- Đen khói mờ sâu
local ISLAND_CARD_BG      = Color3.fromRGB(24, 23, 20)    -- Nền thẻ trạng thái ấm dịu
local BTN_ACTIVE_BG       = Color3.fromRGB(52, 42, 22)    -- Nền nút đang chọn: Nâu Vàng Espresso dịu mắt (không chói)
local BTN_ACTIVE_STROKE   = Color3.fromRGB(196, 156, 62)  -- Viền nút đang chọn: Vàng kim
local BTN_ACTIVE_TEXT     = Color3.fromRGB(240, 208, 120) -- Chữ nút đang chọn: Vàng kem dịu
local BTN_INACTIVE_BG     = Color3.fromRGB(24, 24, 28)    -- Nền nút thường: Xám than tối
local BTN_INACTIVE_STROKE = Color3.fromRGB(52, 48, 42)    -- Viền nút thường

local function isFiggyPurpleColor(col)
	if not col then return false end
	return (col.B > 0.44 and col.R > 0.28 and (col.B - col.G) > 0.12)
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

-- Hàm gắn lớp phủ Logo Banana Cat chống bị hoạt ảnh spritesheet của Figgy Hub làm mất ảnh
local function injectBananaLogoIntoContainer(logoImg)
	if not logoImg or not logoImg.Parent then return end
	local container = logoImg.Parent
	if not container:IsA("GuiObject") then return end

	local oldId = logoImg.Image or ""
	if oldId ~= "" and oldId ~= BANANA_CAT_LOGO and not oldId:find(BANANA_CAT_ASSET_ID, 1, true) then
		State.OrigFiggyLogoAssetIds[oldId] = true
	end

	logoImg:SetAttribute("__IsBananaBrandLogo", true)

	pcall(function()
		-- Ẩn hoạt ảnh spritesheet quả sung gốc (vốn cắt ImageRectOffset làm mất hình)
		logoImg.ImageTransparency = 1
		logoImg.Image = BANANA_CAT_LOGO
		logoImg.ImageRectOffset = Vector2.new(0, 0)
		logoImg.ImageRectSize = Vector2.new(0, 0)
	end)

	if logoImg:GetAttribute("__BananaLogoHooked") ~= SID then
		logoImg:SetAttribute("__BananaLogoHooked", SID)
		logoImg:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
			if isAlive() and logoImg.ImageTransparency < 0.99 then
				pcall(function() logoImg.ImageTransparency = 1 end)
			end
		end)
	end

	-- Tạo ImageLabel độc lập hiển thị Banana Cat rõ nét 100% bên trong khung chứa Logo
	local overlay = container:FindFirstChild("BananaCatFixedOverlay")
	if not overlay then
		overlay = Instance.new("ImageLabel")
		overlay.Name = "BananaCatFixedOverlay"
		overlay.AnchorPoint = Vector2.new(0.5, 0.5)
		overlay.Position = UDim2.fromScale(0.5, 0.5)
		overlay.Size = UDim2.fromScale(0.90, 0.90)
		overlay.BackgroundTransparency = 1
		overlay.Image = BANANA_CAT_LOGO
		overlay.ImageColor3 = Color3.fromRGB(255, 255, 255)
		overlay.ImageTransparency = 0
		overlay.ScaleType = Enum.ScaleType.Crop
		overlay.Active = false
		overlay.ZIndex = math.max((logoImg.ZIndex or 5) + 3, (container.ZIndex or 5) + 3)
		overlay.Parent = container

		local ovCorner = Instance.new("UICorner")
		ovCorner.CornerRadius = UDim.new(0, 8)
		ovCorner.Parent = overlay

		table.insert(State.BananaLogoOverlays, overlay)
	else
		overlay.Image = BANANA_CAT_LOGO
		overlay.ImageTransparency = 0
		overlay.Visible = true
	end

	pcall(function()
		if container.AbsoluteSize.X <= 72 then
			container.BackgroundColor3 = Color3.fromRGB(28, 24, 16)
			container.BackgroundTransparency = 0.08
			local st = container:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", container)
			st.Color = GOLD_BORDER_STROKE
			st.Thickness = 1.3
			st.Transparency = 0.15
		end
	end)
end

-- ============================================================================
-- 4. BỘ TỪ ĐIỂN & ĐỘNG CƠ VIỆT HÓA TOÀN DIỆN 100% (BAO GỒM 7931.JPG & 7915.JPG)
-- ============================================================================
local EXACT_VI = {
	-- Thương hiệu & Header
	["Figgy Hub"] = "Banana Hub",
	["figgy hub"] = "Banana Hub",
	["FIGGY HUB"] = "BANANA HUB",
	["Figgy"] = "Banana Hub",
	["Banana Hub"] = "Banana Hub",
	["Steal an Egg"] = "Cướp Trứng",
	["Steal An Egg"] = "Cướp Trứng",
	["steal an egg"] = "Cướp Trứng",
	["Lemon"] = "Vàng Hoàng Gia (Gold)",

	-- Trạng thái
	["Idle"] = "Đang rảnh",
	["• Idle"] = "• Đang rảnh",
	["Running"] = "Đang chạy",
	["• Running"] = "• Đang chạy",
	["Working"] = "Đang chạy",
	["Active"] = "Đang bật",
	["ACTIVE"] = "ĐANG BẬT",
	["Inactive"] = "Đang tắt",
	["INACTIVE"] = "ĐANG TẮT",
	["Farming"] = "Đang cày",
	["Stealing"] = "Đang cướp trứng",
	["Searching"] = "Đang tìm kiếm",
	["Search"] = "Tìm kiếm...",
	["Search..."] = "Tìm kiếm...",
	["Find option"] = "Tìm tùy chọn...",
	["🔍 Find option"] = "🔍 Tìm tùy chọn...",

	-- Tab Sidebar
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
	["Configs"] = "Cấu Hình",
	["Server"] = "Máy Chủ",

	-- Tab Trang Chủ (Home - Trong ảnh 7931.jpg)
	["STOLEN"] = "ĐÃ CƯỚP",
	["Stolen"] = "Đã cướp",
	["IN PEN"] = "TRONG CHUỒNG",
	["In Pen"] = "Trong chuồng",
	["In pen"] = "Trong chuồng",
	["INCOME /S"] = "THU NHẬP /GIÂY",
	["INCOME/S"] = "THU NHẬP /GIÂY",
	["Income /s"] = "Thu nhập /giây",
	["Income/s"] = "Thu nhập /giây",
	["LAST EGG"] = "TRỨNG GẦN NHẤT",
	["Last Egg"] = "Trứng gần nhất",
	["Last egg"] = "Trứng gần nhất",
	["BEST STEAL"] = "CƯỚP GIÁ TRỊ NHẤT",
	["Best Steal"] = "Cướp giá trị nhất",
	["Best steal"] = "Cướp giá trị nhất",
	["Pet bag"] = "Túi thú cưng",
	["Pet Bag"] = "Túi Thú Cưng",
	["PET BAG"] = "TÚI THÚ CƯNG",
	["Egg bag"] = "Túi trứng",
	["Egg Bag"] = "Túi Trứng",
	["EGG BAG"] = "TÚI TRỨNG",
	["Rejoin"] = "Vào lại server",
	["REJOIN"] = "VÀO LẠI SERVER",
	["Find server"] = "Tìm máy chủ",
	["Find Server"] = "Tìm máy chủ",
	["FIND SERVER"] = "TÌM MÁY CHỦ",
	["Server Hop"] = "Đổi máy chủ",
	["Server hop"] = "Đổi máy chủ",
	["Copy Job ID"] = "Sao chép Job ID",
	["Copy job ID"] = "Sao chép Job ID",
	["COPY JOB ID"] = "SAO CHÉP JOB ID",
	["Unload"] = "Tắt Script",
	["UNLOAD"] = "TẮT SCRIPT",
	["WHAT'S NEW"] = "CÓ GÌ MỚI",
	["What's New"] = "Có gì mới",
	["What's new"] = "Có gì mới",
	["NEW"] = "MỚI",
	["New"] = "Mới",
	["Figgy SAE - Update v1.05"] = "Banana Hub - Bản cập nhật v1.05",
	["Figgy SAE - Update v1.06"] = "Banana Hub - Bản cập nhật v1.06",
	["Figgy SAE - Update v1.04"] = "Banana Hub - Bản cập nhật v1.04",

	-- Nội dung What's New trong ảnh 7931.jpg
	["v1.05: New Pet Finder above Shop with live logs, Min Value, Min Rarity, Auto Join, Force Join and a settings page with Sort By, age limits, new log alerts and an option to hide the server full popup. Pets and buttons have a springy hover, and the fig logo uses it too and plays its animation when you hover or click it. Fixed UFO eggs not being delivered, and debris is now collected inside the Rare UFO instead of on its roof."] = "v1.05: Thêm tính năng Tìm Thú Cưng (Pet Finder) phía trên Cửa Hàng với nhật ký trực tiếp, Giá trị tối thiểu, Độ hiếm tối thiểu, Tự động vào, Ép vào server và trang cài đặt Sắp xếp, giới hạn thời gian, âm báo mới cùng tùy chọn ẩn thông báo đầy máy chủ. Thú cưng, nút bấm và logo Banana Hub có hiệu ứng chuyển động đàn hồi mượt mà khi chạm. Đã sửa lỗi không giao trứng UFO và tự thu thập mảnh vỡ bên trong UFO Hiếm.",
	["v1.04: Language setting in Settings > Interface: the hub in 18 languages, using Roblox's own translations first. The fig logo plays its animation on click or tap, and dragging it moves the window. Fixed a hidden error that could make the menu stutter after some actions."] = "v1.04: Hỗ trợ đa ngôn ngữ trong Cài Đặt > Giao Diện và tích hợp trình dịch tự động Banana Hub. Logo phát hoạt ảnh khi chạm và hỗ trợ kéo để di chuyển cửa sổ. Đã khắc phục lỗi ẩn gây khựng menu sau một số thao tác.",

	-- Tính năng Finder (Pet Finder bên trái màn hình)
	["Finder"] = "Tìm Thú",
	["FINDER"] = "TÌM THÚ",
	["Pet Finder"] = "Tìm Thú Cưng",
	["PET FINDER"] = "TÌM THÚ CƯNG",
	["Slow Mode"] = "Chế độ mượt",
	["Live Logs"] = "Nhật ký trực tiếp",
	["Live logs"] = "Nhật ký trực tiếp",
	["LIVE LOGS"] = "NHẬT KÝ TRỰC TIẾP",
	["Min Value"] = "Giá trị tối thiểu",
	["Min value"] = "Giá trị tối thiểu",
	["MIN VALUE"] = "GIÁ TRỊ TỐI THIỂU",
	["Min Rarity"] = "Độ hiếm tối thiểu",
	["Min rarity"] = "Độ hiếm tối thiểu",
	["MIN RARITY"] = "ĐỘ HIẾM TỐI THIỂU",
	["Auto Join"] = "Tự động vào",
	["Auto join"] = "Tự động vào",
	["AUTO JOIN"] = "TỰ ĐỘNG VÀO",
	["Force Join"] = "Ép vào server",
	["Force join"] = "Ép vào server",
	["FORCE JOIN"] = "ÉP VÀO SERVER",
	["Sort By"] = "Sắp xếp theo",
	["Sort by"] = "Sắp xếp theo",
	["SORT BY"] = "SẮP XẾP THEO",
	["Age Limits"] = "Giới hạn thời gian",
	["Age limits"] = "Giới hạn thời gian",
	["Age limit"] = "Giới hạn thời gian",
	["New Log Alerts"] = "Âm báo nhật ký mới",
	["New log alerts"] = "Âm báo nhật ký mới",
	["Hide Server Full Popup"] = "Ẩn thông báo đầy máy chủ",
	["Hide server full popup"] = "Ẩn thông báo đầy máy chủ",
	["Join"] = "Vào ngay",
	["JOIN"] = "VÀO NGAY",
	["Clear"] = "Xóa",
	["CLEAR"] = "XÓA",
	["Pause"] = "Tạm dừng",
	["Resume"] = "Tiếp tục",

	-- Tab Trứng (Trong ảnh 7915.jpg)
	["Automation"] = "Tự Động",
	["AUTOMATION"] = "TỰ ĐỘNG",
	["Predictor"] = "Dự Đoán",
	["PREDICTOR"] = "DỰ ĐOÁN",
	["Auto Steal"] = "Tự động cướp trứng",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["Auto steal"] = "Tự động cướp trứng",
	["this session"] = "trong phiên này",
	["This session"] = "Trong phiên này",
	["this PHIÊN CHƠI"] = "trong phiên này",
	["This PHIÊN CHƠI"] = "Trong phiên này",
	["PHIÊN CHƠI"] = "phiên này",
	["STATUS"] = "TRẠNG THÁI",
	["Status"] = "Trạng thái",
	["Auto steal: Off"] = "Tự động cướp: Tắt",
	["Auto steal: On"] = "Tự động cướp: Bật",
	["Auto Steal: Off"] = "Tự động cướp: Tắt",
	["Auto Steal: On"] = "Tự động cướp: Bật",
	["Tự động cướp: Tắt"] = "Tự động cướp: Tắt",
	["Tự động cướp: Bật"] = "Tự động cướp: Bật",
	["SPEED"] = "TỐC ĐỘ",
	["Speed"] = "Tốc độ",
	["Move To Egg"] = "Di chuyển tới trứng",
	["Move to Egg"] = "Di chuyển tới trứng",
	["Move to egg"] = "Di chuyển tới trứng",
	["Go to egg"] = "Di chuyển tới trứng",
	["Go to Egg"] = "Di chuyển tới trứng",
	["Go To Egg"] = "Di chuyển tới trứng",
	["Di Chuyển To trứng"] = "Di chuyển tới trứng",
	["Di chuyển To trứng"] = "Di chuyển tới trứng",
	["Di chuyển tới trứng"] = "Di chuyển tới trứng",
	["dịch chuyển"] = "Dịch chuyển",
	["Dịch chuyển"] = "Dịch chuyển",
	["Teleport"] = "Dịch chuyển",
	["Fast Tween"] = "Bay Nhanh (Fast Tween)",
	["Fast tween"] = "Bay Nhanh (Fast Tween)",
	["Walk"] = "Đi bộ",
	["Delivery method"] = "Phương thức giao trứng",
	["Delivery Method"] = "Phương thức giao trứng",
	["Phương thức giao trứng"] = "Phương thức giao trứng",
	["Teleport zones"] = "Khu vực dịch chuyển",
	["Teleport Zones"] = "Khu vực dịch chuyển",
	["Khu vực dịch chuyển"] = "Khu vực dịch chuyển",
	["Titan Temple"] = "Đền Titan",
	["Enchanted Forest"] = "Rừng Phù Phép",
	["Light Dark"] = "Sáng Tối",
	["Cherry Blossom"] = "Hoa Anh Đào",
	["Prehistoric"] = "Tiền Sử",
	["Volcano"] = "Núi Lửa",
	["Snow"] = "Tuyết",
	["Desert"] = "Sa Mạc",
	["Steal missing index eggs"] = "Cướp trứng thiếu trong Mục lục",
	["Steal Missing Index Eggs"] = "Cướp trứng thiếu trong Mục lục",
	["Cướp trứng thiếu trong Mục lục"] = "Cướp trứng thiếu trong Mục lục",

	-- Bộ Lọc
	["FILTER"] = "BỘ LỌC",
	["Filter"] = "Bộ lọc",
	["BỘ LỌC"] = "BỘ LỌC",
	["Area"] = "Khu vực",
	["Zones"] = "Khu vực",
	["Zone"] = "Khu vực",
	["Khu vực"] = "Khu vực",
	["Steal first"] = "Ưu tiên cướp trước",
	["Steal First"] = "Ưu tiên cướp trước",
	["Steal Priority"] = "Ưu tiên cướp trước",
	["Ưu tiên cướp trước"] = "Ưu tiên cướp trước",
	["Highest Earnings"] = "Thu nhập cao nhất",
	["Lowest Earnings"] = "Thu nhập thấp nhất",
	["Best value"] = "Giá trị cao nhất",
	["Lowest value"] = "Giá trị thấp nhất",
	["Best rarity"] = "Độ hiếm cao nhất",
	["Best mutation"] = "Đột biến tốt nhất",
	["Mutation"] = "Đột biến",
	["Mutations"] = "Đột biến",
	["Đột biến"] = "Đột biến",
	["No selection"] = "Chưa chọn",
	["Chưa chọn"] = "Chưa chọn",
	["Rarity"] = "Độ hiếm",
	["Rarities"] = "Độ hiếm",
	["Độ hiếm"] = "Độ hiếm",
	["Only these eggs"] = "Chỉ những trứng này",
	["Only These Eggs"] = "Chỉ những trứng này",
	["Chỉ những trứng này"] = "Chỉ những trứng này",
	["Min $/s"] = "Tối thiểu $/giây",
	["Tối thiểu $/giây"] = "Tối thiểu $/giây",
	["Min KG"] = "Cân nặng tối thiểu (KG)",
	["Max KG"] = "Cân nặng tối đa (KG)",
	["Sell Cheapest Egg"] = "Bán trứng rẻ nhất khi đầy túi",
	["Sell cheapest egg"] = "Bán trứng rẻ nhất khi đầy túi",
	["bán Cheapest trứng"] = "Bán trứng rẻ nhất khi đầy túi",
	["Bán Cheapest trứng"] = "Bán trứng rẻ nhất khi đầy túi",
	["Sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
	["Makes room when the egg bag is full"] = "Tự bán dọn chỗ khi túi trứng đầy",
	["Makes room when the trứng túi is full"] = "Tự bán dọn chỗ khi túi trứng đầy",
	["Makes room when the bag is full"] = "Tự bán dọn chỗ khi túi đầy",
	["None"] = "Không có",
	["Không có"] = "Không có",
	["Off"] = "Tắt",
	["Tắt"] = "Tắt",
	["On"] = "Bật",
	["Bật"] = "Bật",

	-- Tab Quản Lý
	["Inventory"] = "Túi Đồ",
	["INVENTORY"] = "TÚI ĐỒ",
	["Place & Hatch"] = "Đặt & Ấp Trứng",
	["PLACE & HATCH"] = "ĐẶT & ẤP TRỨNG",
	["Upgrades"] = "Nâng Cấp",
	["UPGRADES"] = "NÂNG CẤP",
	["Crafting"] = "Chế Tạo",
	["CRAFTING"] = "CHẾ TẠO",
	["EQUIP BEST"] = "TRANG BỊ MẠNH NHẤT",
	["Equip Best"] = "Trang Bị Mạnh Nhất",
	["Equip best"] = "Trang bị mạnh nhất",
	["PETS"] = "THÚ CƯNG",
	["Pets"] = "Thú Cưng",
	["EQUIPPED"] = "ĐANG TRANG BỊ",
	["Equipped"] = "Đang Trang Bị",
	["Auto Equip Best Pets"] = "Tự động trang bị thú cưng mạnh nhất",
	["Auto equip best pets"] = "Tự động trang bị thú cưng mạnh nhất",
	["Tự động Equip Best thú cưng"] = "Tự động trang bị thú cưng mạnh nhất",
	["Equip best pets"] = "Trang bị thú cưng mạnh nhất",
	["Open Pet Bag"] = "Mở Túi Thú Cưng",
	["Open Egg Bag"] = "Mở Túi Trứng",
	["Open"] = "Mở",
	["OPEN"] = "MỞ",
	["Open >"] = "Mở >",
	["Close"] = "Đóng",
	["CLOSE"] = "ĐÓNG",
	["AUTO FAVORITE"] = "TỰ ĐỘNG KHÓA YÊU THÍCH",
	["Auto Favorite"] = "Tự động khóa yêu thích",
	["Auto favorite"] = "Tự động khóa yêu thích",
	["FAVORITED"] = "ĐÃ YÊU THÍCH",
	["Favorited"] = "Đã Yêu Thích",
	["UNFAVORITED"] = "CHƯA YÊU THÍCH",
	["Unfavorited"] = "Chưa Yêu Thích",
	["Categories"] = "Danh mục",
	["SELL EGGS"] = "BÁN TRỨNG",
	["Sell Eggs"] = "Bán Trứng",
	["Sell eggs"] = "Bán trứng",
	["SPACE LEFT"] = "CHỖ TRỐNG",
	["Space Left"] = "Chỗ Trống",
	["Space left"] = "Chỗ trống",
	["Egg Names"] = "Tên trứng",
	["Pet Names"] = "Tên thú cưng",
	["Egg Rarities"] = "Độ hiếm trứng",
	["Pet Rarities"] = "Độ hiếm thú cưng",
	["Sell Rule"] = "Quy tắc bán",
	["Match All"] = "Khớp tất cả",
	["Match Any"] = "Khớp bất kỳ",
	["Maximum Rarity"] = "Độ hiếm tối đa",
	["Minimum Rarity"] = "Độ hiếm tối thiểu",
	["Keep Mutated Eggs"] = "Giữ lại trứng đột biến",
	["Keep mutated eggs"] = "Giữ lại trứng đột biến",
	["Never Sell Species"] = "Không bán các loài này",
	["Never Sell Eggs"] = "Không bán các trứng này",

	-- Tab Nhân Vật, Hiển Thị, Cài Đặt
	["WalkSpeed"] = "Tốc độ chạy",
	["Walk Speed"] = "Tốc độ chạy",
	["Walk speed"] = "Tốc độ chạy",
	["JumpPower"] = "Lực nhảy",
	["Jump Power"] = "Lực nhảy",
	["Jump power"] = "Lực nhảy",
	["Jump Height"] = "Độ cao nhảy",
	["Infinite Jump"] = "Nhảy vô hạn",
	["Infinite jump"] = "Nhảy vô hạn",
	["NoClip"] = "Đi xuyên tường (Noclip)",
	["Noclip"] = "Đi xuyên tường (Noclip)",
	["Fly"] = "Bay (Fly)",
	["Anti AFK"] = "Chống văng (Anti-AFK)",
	["Anti-AFK"] = "Chống văng (Anti-AFK)",
	["Interface"] = "Giao Diện",
	["INTERFACE"] = "GIAO DIỆN",
	["Theme"] = "Chủ đề màu",
	["THEME"] = "CHỦ ĐỀ MÀU",
	["Language"] = "Ngôn ngữ",
	["LANGUAGE"] = "NGÔN NGỮ",
	["Keybinds"] = "Phím tắt",
	["KEYBINDS"] = "PHÍM TẮT",
	["Quick Bar"] = "Thanh Nhanh",
	["QUICK BAR"] = "THANH NHANH",
	["Notifications"] = "Thông Báo",
	["NOTIFICATIONS"] = "THÔNG BÁO",
	["Save Config"] = "Lưu cấu hình",
	["Load Config"] = "Tải cấu hình",
	["Delete Config"] = "Xóa cấu hình",

	-- UFO & Sự Kiện
	["UFO"] = "UFO (Đĩa Bay)",
	["UFO SIGHTINGS"] = "PHÁT HIỆN UFO",
	["Auto UFO"] = "Tự động săn UFO",
	["Collect UFO Debris"] = "Thu thập mảnh vỡ UFO",
	["Farm Rare UFO"] = "Cày UFO hiếm",
	["Auto Trade Debris"] = "Tự động đổi mảnh vỡ",
	["Teleport If Far From Egg"] = "Dịch chuyển nếu ở xa trứng",
	["UFO STATUS"] = "TRẠNG THÁI UFO",
	["EGGS"] = "TRỨNG",
	["DEBRIS"] = "MẢNH VỠ",
	["SEASONAL"] = "SỰ KIỆN THEO MÙA",
	["BUTTERFLY EVENT"] = "SỰ KIỆN BƯỚM",
	["ESSENCE"] = "TINH CHẤT",
	["CAUGHT"] = "ĐÃ BẮT",
	["NET"] = "VỢT BẮT",
	["THE HOLLOW"] = "VỰC HOLLOW",
	["WINS"] = "SỐ TRẬN THẮNG",
	["STEAL"] = "CƯỚP NGAY",
	["Guard: OFF"] = "Bảo vệ: TẮT",
	["Guard: ON"] = "Bảo vệ: BẬT",
}

local LOWER_VI = {}
local VI_TO_EN = {}
for enKey, viVal in pairs(EXACT_VI) do
	local lk = string.lower(enKey)
	if not LOWER_VI[lk] or enKey:upper() ~= enKey then
		LOWER_VI[lk] = viVal
	end
	if enKey ~= "Figgy Hub" and enKey ~= "figgy hub" and enKey ~= "FIGGY HUB" and enKey ~= "Figgy" then
		if not VI_TO_EN[viVal] then
			VI_TO_EN[viVal] = enKey
		end
		local lv = string.lower(viVal)
		if not VI_TO_EN[lv] then
			VI_TO_EN[lv] = enKey
		end
	end
end

local GRAMMAR_VI = {
	-- Trạng thái mang trứng/hoạt động trên Header & Thẻ Trạng Thái
	{ pat = "^(.-)[Cc]arrying%s+(.+)$", rep = "%1Đang mang %2" },
	{ pat = "^(.-)[Hh]olding%s+(.+)$", rep = "%1Đang giữ %2" },
	{ pat = "^(.-)[Ss]tealing%s+(.+)$", rep = "%1Đang cướp %2" },
	{ pat = "^(.-)[Ff]arming%s+(.+)$", rep = "%1Đang cày %2" },
	{ pat = "^(.-)[Ss]elling%s+(.+)$", rep = "%1Đang bán %2" },
	{ pat = "^(.-)[Mm]oving%s+to%s+(.+)$", rep = "%1Đang tới %2" },
	{ pat = "^(.-)[Tt]eleporting%s+to%s+(.+)$", rep = "%1Đang dịch chuyển tới %2" },
	{ pat = "^(.-)[Ww]aiting%s+for%s+(.+)$", rep = "%1Đang chờ %2" },
	{ pat = "^(.-)[Ww]aiting(.*)$", rep = "%1Đang chờ%2" },

	-- Bộ đếm phiên chơi & thời gian trong Trang Chủ (7931.jpg)
	{ pat = "^[Ss]ession%s+([%d:]+)$", rep = "Phiên: %1" },
	{ pat = "^Phiên%s+này%s+([%d:]+)$", rep = "Phiên: %1" },
	{ pat = "^Figgy%s+SAE%s*%-%s*[Uu]pdate%s+(.+)$", rep = "Banana Hub - Bản cập nhật %1" },
	{ pat = "^(%d+)%s+hours?%s+ago$", rep = "%1 giờ trước" },
	{ pat = "^(%d+)%s+minutes?%s+ago$", rep = "%1 phút trước" },
	{ pat = "^(%d+)%s+days?%s+ago$", rep = "%1 ngày trước" },
	{ pat = "^(%d+)%s+seconds?%s+ago$", rep = "%1 giây trước" },
	{ pat = "^in%s+(%d+m%s*%d*s?)$", rep = "sau %1" },

	-- Thông số Tab Trứng (7915.jpg)
	{ pat = "^([%d%.]+)%s*st/s%s*now$", rep = "%1 bước/giây hiện tại" },
	{ pat = "^([%d%.]+)%s*st/s$", rep = "%1 bước/giây" },
	{ pat = "^(%d+)%s+[Ff]ree$", rep = "Còn trống %1 ô" },
	{ pat = "^[Tt]his%s+session$", rep = "trong phiên này" },
	{ pat = "^[Tt]his%s+PHIÊN%s+CHƠI$", rep = "trong phiên này" },
	{ pat = "^[Mm]ove%s+[Tt]o%s+[Ee]gg$", rep = "Di chuyển tới trứng" },
	{ pat = "^[Gg]o%s+[Tt]o%s+[Ee]gg$", rep = "Di chuyển tới trứng" },
	{ pat = "^[Ss]ell%s+[Cc]heapest%s+[Ee]gg$", rep = "Bán trứng rẻ nhất khi đầy túi" },
	{ pat = "^[Mm]akes%s+room%s+when%s+the%s+.-%s+is%s+full$", rep = "Tự bán dọn chỗ khi túi trứng đầy" },
	{ pat = "^[Nn]ext%s+UFO%s+in%s+(.+)$", rep = "UFO tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+event%s+in%s+(.+)$", rep = "Sự kiện tiếp theo sau %1" },
	{ pat = "^[Ss]hortcut%s+(%d+)$", rep = "Phím Tắt %1" },
	{ pat = "^QUICK BAR (%d+)$", rep = "THANH NHANH %1" },
	{ pat = "^[Gg]uard:%s*[Oo][Ff][Ff]$", rep = "Bảo vệ: TẮT" },
	{ pat = "^[Gg]uard:%s*[Oo][Nn]$", rep = "Bảo vệ: BẬT" },
	{ pat = "^[Mm]in%s+%$/s(.*)$", rep = "Tối thiểu $/giây%1" },
	{ pat = "^[Mm]ax%s+%$/s(.*)$", rep = "Tối đa $/giây%1" },
	{ pat = "^[Mm]in%s+KG(.*)$", rep = "Cân nặng tối thiểu (KG)%1" },
	{ pat = "^[Mm]ax%s+KG(.*)$", rep = "Cân nặng tối đa (KG)%1" },
	{ pat = "^[Oo]pen%s+(.+)%s+[Bb]ag$", rep = "Mở Túi %1" },
	{ pat = "^[Kk]eep%s+[Mm]utated%s+(.+)$", rep = "Giữ lại %1 đột biến" },
	{ pat = "^[Nn]ever%s+[Ss]ell%s+(.+)$", rep = "Không bán %1" },
	{ pat = "^[Mm]aximum%s+(.+)$", rep = "Tối đa %1" },
	{ pat = "^[Mm]inimum%s+(.+)$", rep = "Tối thiểu %1" },
	{ pat = "^[Cc]ollect%s+UFO%s+(.+)$", rep = "Thu thập %1 UFO" },
	{ pat = "^[Ff]arm%s+[Rr]are%s+(.+)$", rep = "Cày %1 hiếm" },
	{ pat = "^[Tt]eleport%s+[Ii]f%s+[Ff]ar%s+[Ff]rom%s+(.+)$", rep = "Dịch chuyển nếu ở xa %1" },
	{ pat = "^[Aa]uto%s+[Ee]quip%s+[Bb]est%s+(.+)$", rep = "Tự động trang bị %1 mạnh nhất" },
	{ pat = "^[Aa]uto%s+[Ss]teal:%s*[Oo][Ff][Ff]$", rep = "Tự động cướp: Tắt" },
	{ pat = "^[Aa]uto%s+[Ss]teal:%s*[Oo][Nn]$", rep = "Tự động cướp: Bật" },
	{ pat = "^[Aa]uto%s+(.+)$", rep = "Tự động %1" },
}

local PHRASES_VI = {
	{ "figgy sae - update", "Banana Hub - Bản cập nhật" },
	{ "figgy hub", "Banana Hub" },
	{ "what's new", "CÓ GÌ MỚI" },
	{ "in pen", "TRONG CHUỒNG" },
	{ "income /s", "THU NHẬP /GIÂY" },
	{ "income/s", "THU NHẬP /GIÂY" },
	{ "last egg", "TRỨNG GẦN NHẤT" },
	{ "best steal", "CƯỚP GIÁ TRỊ NHẤT" },
	{ "pet bag", "Túi thú cưng" },
	{ "egg bag", "Túi trứng" },
	{ "find server", "Tìm máy chủ" },
	{ "copy job id", "Sao chép Job ID" },
	{ "new pet finder above shop", "Tính năng Tìm Thú Cưng phía trên Cửa Hàng" },
	{ "with live logs", "với nhật ký trực tiếp" },
	{ "min value", "Giá trị tối thiểu" },
	{ "min rarity", "Độ hiếm tối thiểu" },
	{ "auto join", "Tự động vào" },
	{ "force join", "Ép vào server" },
	{ "settings page", "trang cài đặt" },
	{ "sort by", "Sắp xếp theo" },
	{ "age limits", "giới hạn thời gian" },
	{ "new log alerts", "âm báo nhật ký mới" },
	{ "hide the server full popup", "ẩn thông báo đầy máy chủ" },
	{ "hide server full popup", "Ẩn thông báo đầy máy chủ" },
	{ "the fig logo", "logo Banana Hub" },
	{ "fig logo", "logo Banana Hub" },
	{ "hours ago", "giờ trước" },
	{ "minutes ago", "phút trước" },
	{ "days ago", "ngày trước" },
	{ "makes room when the egg bag is full", "Tự bán dọn chỗ khi túi trứng đầy" },
	{ "makes room when the trứng túi is full", "Tự bán dọn chỗ khi túi trứng đầy" },
	{ "makes room when the", "Tự bán dọn chỗ khi" },
	{ "sell cheapest egg", "Bán trứng rẻ nhất khi đầy túi" },
	{ "bán cheapest trứng", "Bán trứng rẻ nhất khi đầy túi" },
	{ "move to egg", "Di chuyển tới trứng" },
	{ "go to egg", "Di chuyển tới trứng" },
	{ "di chuyển to trứng", "Di chuyển tới trứng" },
	{ "this session", "trong phiên này" },
	{ "this phiên chơi", "trong phiên này" },
	{ "equip best pets", "trang bị thú cưng mạnh nhất" },
	{ "equip best", "trang bị mạnh nhất" },
	{ "open pet bag", "Mở Túi Thú Cưng" },
	{ "open egg bag", "Mở Túi Trứng" },
	{ "space left", "Chỗ Trống" },
	{ "egg names", "Tên trứng" },
	{ "pet names", "Tên thú cưng" },
	{ "egg rarities", "Độ hiếm trứng" },
	{ "pet rarities", "Độ hiếm thú cưng" },
	{ "sell rule", "Quy tắc bán" },
	{ "match all", "Khớp tất cả" },
	{ "match any", "Khớp bất kỳ" },
	{ "maximum rarity", "Độ hiếm tối đa" },
	{ "minimum rarity", "Độ hiếm tối thiểu" },
	{ "keep mutated eggs", "Giữ lại trứng đột biến" },
	{ "never sell species", "Không bán các loài này" },
	{ "never sell eggs", "Không bán các trứng này" },
	{ "no selection", "Chưa chọn" },
	{ "place & hatch", "Đặt & Ấp Trứng" },
	{ "highest earnings", "Thu nhập cao nhất" },
	{ "lowest earnings", "Thu nhập thấp nhất" },
	{ "fast tween", "Bay Nhanh (Fast Tween)" },
	{ "titan temple", "Đền Titan" },
	{ "enchanted forest", "Rừng Phù Phép" },
	{ "cherry blossom", "Hoa Anh Đào" },
	{ "light dark", "Sáng Tối" },
	{ "walk speed", "Tốc độ chạy" },
	{ "jump power", "Lực nhảy" },
	{ "infinite jump", "Nhảy vô hạn" },
	{ "save config", "Lưu cấu hình" },
	{ "load config", "Tải cấu hình" },
	{ "delete config", "Xóa cấu hình" },
}

local WORDS_VI = {
	figgy = "Banana Hub",
	rejoin = "Vào lại server",
	unload = "Tắt Script",
	finder = "Tìm Thú",
	income = "thu nhập",
	pen = "chuồng",
	last = "gần nhất",
	stolen = "đã cướp",
	update = "bản cập nhật",
	hours = "giờ",
	hour = "giờ",
	minutes = "phút",
	minute = "phút",
	ago = "trước",
	new = "mới",
	copy = "sao chép",
	find = "tìm",
	server = "máy chủ",
	join = "vào",
	force = "ép",
	sort = "sắp xếp",
	clear = "xóa",
	pause = "tạm dừng",
	resume = "tiếp tục",
	cheapest = "rẻ nhất",
	move = "di chuyển",
	to = "tới",
	free = "trống",
	now = "hiện tại",
	session = "Phiên",
	equip = "trang bị",
	equipped = "đang trang bị",
	best = "mạnh nhất",
	favorited = "đã thích",
	unfavorited = "chưa thích",
	favorite = "yêu thích",
	categories = "danh mục",
	category = "danh mục",
	selection = "lựa chọn",
	space = "chỗ",
	left = "trống",
	names = "tên",
	name = "tên",
	rule = "quy tắc",
	maximum = "tối đa",
	minimum = "tối thiểu",
	keep = "giữ lại",
	mutated = "đột biến",
	never = "không bao giờ",
	species = "loài",
	upgrades = "nâng cấp",
	upgrade = "nâng cấp",
	crafting = "chế tạo",
	craft = "chế tạo",
	place = "đặt",
	hatch = "ấp",
	sell = "bán",
	open = "mở",
	close = "đóng",
	bag = "túi",
	ufo = "UFO",
	debris = "mảnh vỡ",
	sightings = "phát hiện",
	seasonal = "theo mùa",
	essence = "tinh chất",
	caught = "đã bắt",
	net = "vợt bắt",
	hollow = "Vực Hollow",
	wins = "thắng",
	status = "trạng thái",
	egg = "trứng",
	eggs = "trứng",
	pet = "thú cưng",
	pets = "thú cưng",
	mutation = "đột biến",
	mutations = "đột biến",
	rarity = "độ hiếm",
	rarities = "độ hiếm",
	steal = "cướp",
	stealing = "đang cướp",
	farm = "cày",
	farming = "đang cày",
	collect = "thu thập",
	trade = "đổi",
	teleport = "dịch chuyển",
	auto = "tự động",
	rare = "hiếm",
	idle = "Đang rảnh",
	running = "Đang chạy",
	waiting = "Đang chờ",
	carrying = "Đang mang",
	holding = "Đang giữ",
	guard = "bảo vệ",
	player = "người chơi",
	speed = "tốc độ",
	value = "giá trị",
	earnings = "thu nhập",
	none = "không có",
	all = "tất cả",
	any = "bất kỳ",
	match = "khớp",
	settings = "cài đặt",
	interface = "giao diện",
	language = "ngôn ngữ",
	theme = "chủ đề",
}

local function isPlayerUsername(str)
	if not str or str == "" then return false end
	if string.sub(str, 1, 1) == "@" then return true end
	if LocalPlayer then
		if str == LocalPlayer.Name or str == LocalPlayer.DisplayName then
			return true
		end
	end
	return false
end

local function applyPhrasesAndWords(str)
	local out = str
	for i = 1, #PHRASES_VI do
		local pair = PHRASES_VI[i]
		local guard = 0
		while guard < 4 do
			local sIdx, eIdx = string.find(string.lower(out), pair[1], 1, true)
			if not sIdx then break end
			out = string.sub(out, 1, sIdx - 1) .. pair[2] .. string.sub(out, eIdx + 1)
			guard = guard + 1
		end
	end
	out = out:gsub("([\128-\255%a']+)", function(w)
		if string.find(w, "[\128-\255]") then return w end
		local lw = string.lower(w)
		return WORDS_VI[lw] or LOWER_VI[lw] or w
	end)
	return out
end

local function translateRawSegment(rawText, targetLang)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
	local lead, trimmed, trail = rawText:match("^(%s*)(.-)(%s*)$")
	if not trimmed or trimmed == "" then return rawText end

	-- Không dịch tên tài khoản người chơi
	if isPlayerUsername(trimmed) then
		return rawText
	end

	-- Luôn giữ thương hiệu "Banana Hub" ở cả 2 ngôn ngữ
	if trimmed == "Figgy Hub" or trimmed == "figgy hub" or trimmed == "Banana Hub" or trimmed == "Figgy" then
		return lead .. "Banana Hub" .. trail
	end

	local bulletPrefix, afterBullet = trimmed:match("^(•%s*)(.+)$")
	if not bulletPrefix then
		bulletPrefix, afterBullet = trimmed:match("^(●%s*)(.+)$")
	end
	if bulletPrefix and afterBullet then
		return lead .. bulletPrefix .. translateRawSegment(afterBullet, targetLang) .. trail
	end

	local cacheKey = targetLang .. "|" .. trimmed
	if State.FastCache[cacheKey] then
		return lead .. State.FastCache[cacheKey] .. trail
	end

	if targetLang == "VI" then
		local exact = EXACT_VI[trimmed] or LOWER_VI[string.lower(trimmed)]
		if exact then
			State.FastCache[cacheKey] = exact
			return lead .. exact .. trail
		end

		-- Bắt đoạn văn What's New dài theo phiên bản (v1.05, v1.04...)
		if trimmed:find("^v1%.05:%s+New Pet Finder") then
			local rep = EXACT_VI["v1.05: New Pet Finder above Shop with live logs, Min Value, Min Rarity, Auto Join, Force Join and a settings page with Sort By, age limits, new log alerts and an option to hide the server full popup. Pets and buttons have a springy hover, and the fig logo uses it too and plays its animation when you hover or click it. Fixed UFO eggs not being delivered, and debris is now collected inside the Rare UFO instead of on its roof."]
			State.FastCache[cacheKey] = rep
			return lead .. rep .. trail
		elseif trimmed:find("^v1%.04:%s+Language setting") then
			local rep = EXACT_VI["v1.04: Language setting in Settings > Interface: the hub in 18 languages, using Roblox's own translations first. The fig logo plays its animation on click or tap, and dragging it moves the window. Fixed a hidden error that could make the menu stutter after some actions."]
			State.FastCache[cacheKey] = rep
			return lead .. rep .. trail
		end

		for i = 1, #GRAMMAR_VI do
			local g = GRAMMAR_VI[i]
			if string.find(trimmed, g.pat) then
				local rep = string.gsub(trimmed, g.pat, g.rep)
				rep = applyPhrasesAndWords(rep)
				State.FastCache[cacheKey] = rep
				return lead .. rep .. trail
			end
		end

		-- Dịch cụm từ và từ đơn cho mọi nhãn tiếng Anh còn lại
		local rep = applyPhrasesAndWords(trimmed)
		if rep ~= trimmed then
			State.FastCache[cacheKey] = rep
			return lead .. rep .. trail
		end

		return rawText
	else
		local rev = VI_TO_EN[trimmed] or VI_TO_EN[string.lower(trimmed)]
		if rev then
			State.FastCache[cacheKey] = rev
			return lead .. rev .. trail
		end
		local carryPrefix, carryVal = trimmed:match("^(.-)Đang%s+mang%s+(.+)$")
		if carryVal then
			return lead .. (carryPrefix or "") .. "Carrying " .. carryVal .. trail
		end
		local holdPrefix, holdVal = trimmed:match("^(.-)Đang%s+giữ%s+(.+)$")
		if holdVal then
			return lead .. (holdPrefix or "") .. "Holding " .. holdVal .. trail
		end
		return rawText
	end
end

local function translateString(rawText, targetLang)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
	if string.find(rawText, "<[^>]+>") then
		return (string.gsub(rawText, "([^<>]+)", function(seg)
			return translateRawSegment(seg, targetLang)
		end))
	end
	return translateRawSegment(rawText, targetLang)
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

	if State.Language == "EN" then
		if isIdle then return prefixEmoji .. "Idle" end
		if low == "đang chạy" then return prefixEmoji .. "Running" end
		local enStr = translateRawSegment(clean, "EN")
		return prefixEmoji .. ((enStr and enStr ~= "") and enStr or clean)
	else
		if isIdle then return prefixEmoji .. "Đang rảnh" end
		if low == "running" or low == "working" or low == "active" or low == "đang chạy" then
			return prefixEmoji .. "Đang chạy"
		end
		local viStr = translateRawSegment(clean, "VI")
		if viStr and viStr ~= clean then
			return prefixEmoji .. viStr
		end
		return prefixEmoji .. clean
	end
end

-- ============================================================================
-- 5. THIẾT KẾ BANANA HUB DYNAMIC ISLAND (GOLD PREMIUM - ANTI-GLARE DỊU MẮT)
-- ============================================================================
local PINNED_PILL_POS   = UDim2.new(0.5, 0, 0, 6)
local PINNED_DRAWER_POS = UDim2.new(0.5, 0, 0, 48)

local function applyGoldMatteGlass(frame, cornerRadius, bgAlpha, strokeColor, strokeThickness)
	frame.BackgroundColor3 = ISLAND_BG_DARK
	frame.BackgroundTransparency = bgAlpha or 0.14
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or UDim.new(1, 0)
	corner.Parent = frame

	local stroke = frame:FindFirstChild("GoldMatteRimStroke") or Instance.new("UIStroke")
	stroke.Name = "GoldMatteRimStroke"
	stroke.Color = strokeColor or GOLD_BORDER_STROKE
	stroke.Thickness = strokeThickness or 1.2
	stroke.Transparency = 0.28
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame

	local strokeGrad = stroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
	strokeGrad.Rotation = 90
	strokeGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(232, 192, 92)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(168, 130, 48)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(112, 86, 30)),
	})
	strokeGrad.Parent = stroke

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

	local okParent = pcall(function()
		islandGui.Parent = CoreGui
	end)
	if not okParent or not islandGui.Parent then
		if gethui then
			pcall(function() islandGui.Parent = gethui() end)
		end
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

	pillFrame:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and pillFrame.Position ~= PINNED_PILL_POS then
			pillFrame.Position = PINNED_PILL_POS
		end
	end)

	applyGoldMatteGlass(pillFrame, UDim.new(1, 0), 0.12, GOLD_BORDER_STROKE, 1.3)

	-- [Bên trái]: Khung Avatar Banana Cat (rbxthumb://type=Asset&id=87447945720038) viền Vàng Gold
	local logoOrb = Instance.new("Frame")
	logoOrb.Name = "BananaCatLogoOrb"
	logoOrb.AnchorPoint = Vector2.new(0, 0.5)
	logoOrb.Position = UDim2.new(0, 6, 0.5, 0)
	logoOrb.Size = UDim2.new(0, 26, 0, 26)
	logoOrb.BackgroundColor3 = Color3.fromRGB(32, 27, 18)
	logoOrb.BackgroundTransparency = 0.10
	logoOrb.BorderSizePixel = 0
	logoOrb.ClipsDescendants = true
	logoOrb.ZIndex = 22
	logoOrb.Parent = pillFrame

	local orbCorner = Instance.new("UICorner")
	orbCorner.CornerRadius = UDim.new(1, 0)
	orbCorner.Parent = logoOrb

	local orbStroke = Instance.new("UIStroke")
	orbStroke.Color = GOLD_BORDER_STROKE
	orbStroke.Thickness = 1.1
	orbStroke.Transparency = 0.20
	orbStroke.Parent = logoOrb

	local bananaLogoImg = Instance.new("ImageLabel")
	bananaLogoImg.Name = "BananaCatImage"
	bananaLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
	bananaLogoImg.Position = UDim2.fromScale(0.5, 0.5)
	bananaLogoImg.Size = UDim2.new(0, 24, 0, 24)
	bananaLogoImg.BackgroundTransparency = 1
	bananaLogoImg.Image = BANANA_CAT_LOGO
	bananaLogoImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
	bananaLogoImg.ScaleType = Enum.ScaleType.Crop
	bananaLogoImg.ZIndex = 23
	bananaLogoImg.Parent = logoOrb
	Instance.new("UICorner", bananaLogoImg).CornerRadius = UDim.new(1, 0)
	table.insert(State.BananaLogoOverlays, bananaLogoImg)

	-- [Khung Trạng Thái Bê Nguyên Từ Header]: Chứa Icon Trạng Thái + Chữ Trạng Thái thực tế
	local statusBadgeContainer = Instance.new("Frame")
	statusBadgeContainer.Name = "TransplantedStatusBadge"
	statusBadgeContainer.AnchorPoint = Vector2.new(0, 0.5)
	statusBadgeContainer.Position = UDim2.new(0, 38, 0.5, 0)
	statusBadgeContainer.Size = UDim2.new(1, -64, 0, 26)
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
	statusIconImg.Image = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or BANANA_CAT_LOGO
	statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
	statusIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
	statusIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
	statusIconImg.ScaleType = Enum.ScaleType.Fit
	statusIconImg.ZIndex = 23
	statusIconImg.Parent = statusBadgeContainer

	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0, 0.5)
	centerStatusLabel.Position = UDim2.new(0, 26, 0.5, 0)
	centerStatusLabel.Size = UDim2.new(1, -32, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = GOLD_PRIMARY_TEXT
	centerStatusLabel.TextSize = 11.5
	centerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	centerStatusLabel.Text = formatIslandStatusText(State.CurrentRawStatus)
	centerStatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
	centerStatusLabel.ZIndex = 23
	centerStatusLabel.Parent = statusBadgeContainer

	-- [Bên phải]: Icon mũi tên mở rộng
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
	-- BẢNG MỞ RỘNG BÊN TRONG (GOLD PREMIUM DRAWER - CHỐNG TRÓI MẮT 100%)
	-- ========================================================================
	local EXP_W = 316
	local COLLAPSED_EXP_H = 172
	local OPEN_NOTE_EXP_H = 260

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

	expandPanel:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and expandPanel.Position ~= PINNED_DRAWER_POS then
			expandPanel.Position = PINNED_DRAWER_POS
		end
	end)

	applyGoldMatteGlass(expandPanel, UDim.new(0, 18), 0.10, GOLD_BORDER_STROKE, 1.3)

	-- Header Bảng Mở Rộng với Avatar Banana Cat
	local expLogoOrb = Instance.new("Frame")
	expLogoOrb.Position = UDim2.new(0, 12, 0, 10)
	expLogoOrb.Size = UDim2.new(0, 28, 0, 28)
	expLogoOrb.BackgroundColor3 = Color3.fromRGB(32, 27, 18)
	expLogoOrb.BackgroundTransparency = 0.10
	expLogoOrb.BorderSizePixel = 0
	expLogoOrb.ClipsDescendants = true
	expLogoOrb.ZIndex = 32
	expLogoOrb.Parent = expandPanel
	Instance.new("UICorner", expLogoOrb).CornerRadius = UDim.new(1, 0)
	local elStroke = Instance.new("UIStroke", expLogoOrb)
	elStroke.Color = GOLD_BORDER_STROKE
	elStroke.Thickness = 1

	local expLogoImg = Instance.new("ImageLabel")
	expLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
	expLogoImg.Position = UDim2.fromScale(0.5, 0.5)
	expLogoImg.Size = UDim2.new(0, 26, 0, 26)
	expLogoImg.BackgroundTransparency = 1
	expLogoImg.Image = BANANA_CAT_LOGO
	expLogoImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
	expLogoImg.ScaleType = Enum.ScaleType.Crop
	expLogoImg.ZIndex = 33
	expLogoImg.Parent = expLogoOrb
	Instance.new("UICorner", expLogoImg).CornerRadius = UDim.new(1, 0)
	table.insert(State.BananaLogoOverlays, expLogoImg)

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
	expSubBadge.Text = "● ĐỒNG BỘ TRẠNG THÁI THỜI GIAN THỰC"
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

	-- Thẻ hiển thị trạng thái bê nguyên từ Banana Hub vào
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

	-- Thanh gạt chọn ngôn ngữ (Nền Nâu Vàng Espresso dịu mắt + Viền Vàng Kim, không trói mắt)
	local langTrack = Instance.new("Frame")
	langTrack.Name = "LanguageGlassTrack"
	langTrack.Position = UDim2.new(0, 12, 0, 78)
	langTrack.Size = UDim2.new(1, -24, 0, 30)
	langTrack.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	langTrack.BorderSizePixel = 0
	langTrack.ZIndex = 32
	langTrack.Parent = expandPanel
	Instance.new("UICorner", langTrack).CornerRadius = UDim.new(0, 8)
	local ltStroke = Instance.new("UIStroke", langTrack)
	ltStroke.Color = BTN_INACTIVE_STROKE
	ltStroke.Thickness = 1

	local btnVI = Instance.new("TextButton")
	btnVI.Name = "BtnVietnamese"
	btnVI.Position = UDim2.new(0, 3, 0, 3)
	btnVI.Size = UDim2.new(0.5, -5, 1, -6)
	btnVI.BorderSizePixel = 0
	btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
	btnVI.Font = Enum.Font.GothamBold
	btnVI.Text = "🇻🇳 Tiếng Việt"
	btnVI.TextSize = 10.5
	btnVI.TextColor3 = (State.Language == "VI") and BTN_ACTIVE_TEXT or GOLD_MUTED_SUBTEXT
	btnVI.AutoButtonColor = false
	btnVI.ZIndex = 34
	btnVI.Parent = langTrack
	Instance.new("UICorner", btnVI).CornerRadius = UDim.new(0, 6)
	local btnVIStroke = Instance.new("UIStroke", btnVI)
	btnVIStroke.Color = (State.Language == "VI") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
	btnVIStroke.Thickness = 1
	btnVIStroke.Transparency = (State.Language == "VI") and 0.15 or 0.55

	local btnEN = Instance.new("TextButton")
	btnEN.Name = "BtnEnglish"
	btnEN.Position = UDim2.new(0.5, 2, 0, 3)
	btnEN.Size = UDim2.new(0.5, -5, 1, -6)
	btnEN.BorderSizePixel = 0
	btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
	btnEN.Font = Enum.Font.GothamBold
	btnEN.Text = "🇺🇸 English"
	btnEN.TextSize = 10.5
	btnEN.TextColor3 = (State.Language == "EN") and BTN_ACTIVE_TEXT or GOLD_MUTED_SUBTEXT
	btnEN.AutoButtonColor = false
	btnEN.ZIndex = 34
	btnEN.Parent = langTrack
	Instance.new("UICorner", btnEN).CornerRadius = UDim.new(0, 6)
	local btnENStroke = Instance.new("UIStroke", btnEN)
	btnENStroke.Color = (State.Language == "EN") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
	btnENStroke.Thickness = 1
	btnENStroke.Transparency = (State.Language == "EN") and 0.15 or 0.55

	-- Hàng nút chức năng
	local actionRow = Instance.new("Frame")
	actionRow.Name = "ActionRow"
	actionRow.Position = UDim2.new(0, 12, 0, 114)
	actionRow.Size = UDim2.new(1, -24, 0, 26)
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
	soundToggleBtn.TextSize = 9.5
	soundToggleBtn.TextColor3 = GOLD_SOFT_CREAM
	soundToggleBtn.Text = State.SoundEnabled and "🔊 Âm thanh: BẬT" or "🔇 Âm thanh: TẮT"
	soundToggleBtn.AutoButtonColor = false
	soundToggleBtn.ZIndex = 34
	soundToggleBtn.Parent = actionRow
	Instance.new("UICorner", soundToggleBtn).CornerRadius = UDim.new(0, 6)
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
	rescanBtn.TextSize = 9.5
	rescanBtn.TextColor3 = GOLD_PRIMARY_TEXT
	rescanBtn.Text = "⚡ Làm mới & Đồng bộ"
	rescanBtn.AutoButtonColor = false
	rescanBtn.ZIndex = 34
	rescanBtn.Parent = actionRow
	Instance.new("UICorner", rescanBtn).CornerRadius = UDim.new(0, 6)
	local rbStroke = Instance.new("UIStroke", rescanBtn)
	rbStroke.Color = BTN_ACTIVE_STROKE
	rbStroke.Thickness = 1
	rbStroke.Transparency = 0.30

	-- Ngăn thông tin
	local noteToggleBtn = Instance.new("TextButton")
	noteToggleBtn.Name = "SettingNoteToggleBtn"
	noteToggleBtn.Position = UDim2.new(0, 12, 0, 144)
	noteToggleBtn.Size = UDim2.new(1, -24, 0, 22)
	noteToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	noteToggleBtn.BorderSizePixel = 0
	noteToggleBtn.Text = "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
	noteToggleBtn.Font = Enum.Font.GothamMedium
	noteToggleBtn.TextSize = 9
	noteToggleBtn.TextColor3 = GOLD_MUTED_SUBTEXT
	noteToggleBtn.AutoButtonColor = false
	noteToggleBtn.ZIndex = 33
	noteToggleBtn.Parent = expandPanel
	Instance.new("UICorner", noteToggleBtn).CornerRadius = UDim.new(0, 6)
	local ntbStroke = Instance.new("UIStroke", noteToggleBtn)
	ntbStroke.Color = BTN_INACTIVE_STROKE
	ntbStroke.Thickness = 1

	local noteDrawer = Instance.new("Frame")
	noteDrawer.Name = "SettingNoteDrawer"
	noteDrawer.Position = UDim2.new(0, 12, 0, 170)
	noteDrawer.Size = UDim2.new(1, -24, 0, 80)
	noteDrawer.BackgroundColor3 = ISLAND_CARD_BG
	noteDrawer.BorderSizePixel = 0
	noteDrawer.Visible = false
	noteDrawer.ClipsDescendants = true
	noteDrawer.ZIndex = 33
	noteDrawer.Parent = expandPanel
	Instance.new("UICorner", noteDrawer).CornerRadius = UDim.new(0, 8)
	local ndStroke = Instance.new("UIStroke", noteDrawer)
	ndStroke.Color = Color3.fromRGB(92, 74, 34)
	ndStroke.Thickness = 1
	ndStroke.Transparency = 0.40

	local ndHeader = Instance.new("TextLabel", noteDrawer)
	ndHeader.Position = UDim2.new(0, 8, 0, 4)
	ndHeader.Size = UDim2.new(1, -16, 0, 14)
	ndHeader.BackgroundTransparency = 1
	ndHeader.Font = Enum.Font.GothamBold
	ndHeader.TextSize = 9
	ndHeader.TextColor3 = GOLD_PRIMARY_TEXT
	ndHeader.TextXAlignment = Enum.TextXAlignment.Left
	ndHeader.Text = "🍌 BANANA HUB • LUXURY GOLD PREMIUM"
	ndHeader.ZIndex = 35

	local ndLine1 = Instance.new("TextLabel", noteDrawer)
	ndLine1.Position = UDim2.new(0, 8, 0, 20)
	ndLine1.Size = UDim2.new(1, -16, 0, 16)
	ndLine1.BackgroundTransparency = 1
	ndLine1.Font = Enum.Font.GothamMedium
	ndLine1.TextSize = 8.5
	ndLine1.TextColor3 = GOLD_SOFT_CREAM
	ndLine1.TextXAlignment = Enum.TextXAlignment.Left
	ndLine1.Text = "+ Bê nguyên Icon & Trạng thái thực tế vào Dynamic Island"
	ndLine1.ZIndex = 35

	local ndLine2 = Instance.new("TextLabel", noteDrawer)
	ndLine2.Position = UDim2.new(0, 8, 0, 38)
	ndLine2.Size = UDim2.new(1, -16, 0, 16)
	ndLine2.BackgroundTransparency = 1
	ndLine2.Font = Enum.Font.GothamMedium
	ndLine2.TextSize = 8.5
	ndLine2.TextColor3 = GOLD_MUTED_SUBTEXT
	ndLine2.TextXAlignment = Enum.TextXAlignment.Left
	ndLine2.Text = "+ Logo Banana Cat (87447945720038) chuẩn rbxthumb 100% hiển thị"
	ndLine2.ZIndex = 35

	local ndLine3 = Instance.new("TextLabel", noteDrawer)
	ndLine3.Position = UDim2.new(0, 8, 0, 56)
	ndLine3.Size = UDim2.new(1, -16, 0, 16)
	ndLine3.BackgroundTransparency = 1
	ndLine3.Font = Enum.Font.GothamMedium
	ndLine3.TextSize = 8.5
	ndLine3.TextColor3 = Color3.fromRGB(145, 210, 165)
	ndLine3.TextXAlignment = Enum.TextXAlignment.Left
	ndLine3.Text = "+ Việt hóa 100% toàn bộ các Tab, Nhật ký & Nút bấm dịu mắt"
	ndLine3.ZIndex = 35

	-- Cập nhật giao diện khi đổi trạng thái hoặc ngôn ngữ
	local function updatePillVisuals()
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		centerStatusLabel.Text = displayTxt
		cardStatusLbl.Text = displayTxt

		local hasCustomImg = (State.CurrentStatusImage ~= nil and State.CurrentStatusImage ~= "")
		local curImg = hasCustomImg and State.CurrentStatusImage or BANANA_CAT_LOGO
		local curCol = hasCustomImg and (State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)) or Color3.fromRGB(255, 255, 255)
		local curOff = hasCustomImg and (State.CurrentStatusRectOffset or Vector2.new(0, 0)) or Vector2.new(0, 0)
		local curSz  = hasCustomImg and (State.CurrentStatusRectSize or Vector2.new(0, 0)) or Vector2.new(0, 0)

		statusIconImg.Image = curImg
		statusIconImg.ImageColor3 = curCol
		statusIconImg.ImageRectOffset = curOff
		statusIconImg.ImageRectSize = curSz

		cardIconImg.Image = curImg
		cardIconImg.ImageColor3 = curCol
		cardIconImg.ImageRectOffset = curOff
		cardIconImg.ImageRectSize = curSz

		expSubBadge.Text = (State.Language == "EN") and "● REALTIME STATUS • ANTI-GLARE GOLD" or "● ĐỒNG BỘ TRẠNG THÁI THỜI GIAN THỰC"
		collapseBtn.Text = (State.Language == "EN") and "Collapse ▲" or "Thu gọn ▲"
		soundToggleBtn.Text = State.SoundEnabled
			and ((State.Language == "EN") and "🔊 Sound: ON" or "🔊 Âm thanh: BẬT")
			or ((State.Language == "EN") and "🔇 Sound: OFF" or "🔇 Âm thanh: TẮT")
		rescanBtn.Text = (State.Language == "EN") and "⚡ Refresh & Sync" or "⚡ Làm mới & Đồng bộ"

		btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
		btnVI.TextColor3 = (State.Language == "VI") and BTN_ACTIVE_TEXT or GOLD_MUTED_SUBTEXT
		btnVIStroke.Color = (State.Language == "VI") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
		btnVIStroke.Transparency = (State.Language == "VI") and 0.15 or 0.55

		btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
		btnEN.TextColor3 = (State.Language == "EN") and BTN_ACTIVE_TEXT or GOLD_MUTED_SUBTEXT
		btnENStroke.Color = (State.Language == "EN") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
		btnENStroke.Transparency = (State.Language == "EN") and 0.15 or 0.55

		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(196, math.min(320, 96 + textLen * 7))
		TweenService:Create(
			pillFrame,
			TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, targetWidth, 0, 38) }
		):Play()
	end

	State.UpdateIslandVisuals = updatePillVisuals
	State.IslandGui = islandGui
	State.IslandPill = pillFrame
	State.IslandStatusLabel = centerStatusLabel
	State.IslandStatusIcon = statusIconImg

	noteToggleBtn.Activated:Connect(function()
		playUiSound("tap")
		State.NoteOpen = not State.NoteOpen
		if State.NoteOpen then
			noteDrawer.Visible = true
			noteToggleBtn.Text = "Thông tin Banana Hub Gold Premium (Thu gọn) ▲"
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, EXP_W, 0, OPEN_NOTE_EXP_H)
			}):Play()
		else
			noteToggleBtn.Text = "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
			local tw = TweenService:Create(expandPanel, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, EXP_W, 0, COLLAPSED_EXP_H)
			})
			tw:Play()
			if tw.Completed then
				tw.Completed:Connect(function()
					if not State.NoteOpen then noteDrawer.Visible = false end
				end)
			end
		end
	end)

	soundToggleBtn.Activated:Connect(function()
		State.SoundEnabled = not State.SoundEnabled
		if State.SoundEnabled then
			playUiSound("action")
		end
		updatePillVisuals()
	end)

	rescanBtn.Activated:Connect(function()
		playUiSound("action")
		if State.RefreshAllMenus then
			task.spawn(State.RefreshAllMenus)
		end
	end)

	local lastToggleClock = -10
	local function toggleIslandExpand()
		if os.clock() - lastToggleClock < 0.14 then return end
		lastToggleClock = os.clock()
		State.IsExpanded = not State.IsExpanded
		playUiSound(State.IsExpanded and "open" or "close")

		if State.IsExpanded then
			expandPanel.Position = PINNED_DRAWER_POS
			local targetH = State.NoteOpen and OPEN_NOTE_EXP_H or COLLAPSED_EXP_H
			expandPanel.Visible = true
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, EXP_W, 0, targetH) }):Play()
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
		else
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
			expandPanel.Visible = false
		end
	end

	pillClickBtn.Activated:Connect(toggleIslandExpand)
	collapseBtn.Activated:Connect(toggleIslandExpand)

	btnVI.Activated:Connect(function()
		playUiSound("action")
		if State.Language ~= "VI" then
			State.Language = "VI"
			updatePillVisuals()
			if State.RefreshAllMenus then
				task.spawn(State.RefreshAllMenus)
			end
		end
	end)

	btnEN.Activated:Connect(function()
		playUiSound("action")
		if State.Language ~= "EN" then
			State.Language = "EN"
			updatePillVisuals()
			if State.RefreshAllMenus then
				task.spawn(State.RefreshAllMenus)
			end
		end
	end)

	updatePillVisuals()
	return islandGui
end

-- ============================================================================
-- 6. BÊ NGUYÊN HÌNH ẢNH & TRẠNG THÁI TỪ HEADER BANANA HUB VÀO DYNAMIC ISLAND
-- ============================================================================
local NON_STATUS_TEXTS = {
	["figgy hub"] = true,
	["banana hub"] = true,
	["frostyfig"] = true,
	["steal an egg"] = true,
	["cướp trứng"] = true,
	["search"] = true,
	["search..."] = true,
	["tìm kiếm..."] = true,
	["find option"] = true,
	["tìm tùy chọn..."] = true,
	["-"] = true,
	["+"] = true,
	["×"] = true,
	["x"] = true,
}

local function isIgnoredHeaderLabel(txt)
	if not txt or txt == "" then return true end
	local low = string.lower((txt:match("^%s*(.-)%s*$") or ""))
	if NON_STATUS_TEXTS[low] then return true end
	if low:find("^v%d+%.%d+") then return true end
	return false
end

local function cloakOriginalStatusBadge(badgeFrame)
	if not badgeFrame or not badgeFrame:IsA("GuiObject") then return end
	pcall(function()
		badgeFrame.BackgroundTransparency = 1
		for _, ch in ipairs(badgeFrame:GetDescendants()) do
			if ch:IsA("UIStroke") then
				ch.Transparency = 1
			elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
				ch.TextTransparency = 1
				ch.TextStrokeTransparency = 1
				ch.BackgroundTransparency = 1
			elseif ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
				ch.ImageTransparency = 1
				ch.BackgroundTransparency = 1
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
	local emojiObj = State.LiveFiggyEmojiLabel
	local fallbackTxtObj = State.FallbackStatusCardLabel

	local rawText = ""
	if txtObj and txtObj.Parent then
		rawText = txtObj:GetAttribute("__FiggyOrigText") or txtObj.Text or ""
		if rawText == "" then
			rawText = txtObj.Text or ""
		end
	end

	if (rawText == "" or rawText == "Idle" or rawText == "Đang rảnh") and fallbackTxtObj and fallbackTxtObj.Parent then
		local fbText = fallbackTxtObj:GetAttribute("__FiggyOrigText") or fallbackTxtObj.Text or ""
		if fbText ~= "" and not isIgnoredHeaderLabel(fbText) then
			rawText = fbText
		end
	end

	if rawText ~= "" then
		State.CurrentRawStatus = rawText
	end

	if imgObj and imgObj.Parent and (imgObj.Image or "") ~= "" then
		State.CurrentStatusImage = imgObj.Image
		State.CurrentStatusImageColor = imgObj.ImageColor3 or Color3.fromRGB(255, 255, 255)
		State.CurrentStatusRectOffset = imgObj.ImageRectOffset or Vector2.new(0, 0)
		State.CurrentStatusRectSize = imgObj.ImageRectSize or Vector2.new(0, 0)
	end

	if emojiObj and emojiObj.Parent and emojiObj ~= txtObj then
		local em = (emojiObj.Text or ""):match("^%s*(.-)%s*$") or ""
		if em ~= "" and #em <= 8 then
			State.CurrentStatusEmoji = em
		end
	else
		State.CurrentStatusEmoji = ""
	end

	if State.LiveFiggyBadgeFrame and State.LiveFiggyBadgeFrame.Parent then
		cloakOriginalStatusBadge(State.LiveFiggyBadgeFrame)
	end

	if State.UpdateIslandVisuals then
		pcall(State.UpdateIslandVisuals)
	end
end

local function bindHeaderAndLogosFromTitle(titleLbl)
	if not titleLbl or not titleLbl.Parent then return end

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

	-- 1. Thay Logo trên Header sang Banana Cat bằng lớp phủ BananaCatFixedOverlay
	for _, d in ipairs(headerContainer:GetDescendants()) do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Name ~= "BananaCatFixedOverlay" and d.Parent ~= State.LiveFiggyBadgeFrame then
			local isLeftOfTitle = (d.AbsolutePosition.X <= titleLbl.AbsolutePosition.X + 24)
			local isSquareLogo = (d.AbsoluteSize.X >= 14 and d.AbsoluteSize.X <= 54 and math.abs(d.AbsoluteSize.X - d.AbsoluteSize.Y) <= 10)
			if isLeftOfTitle and isSquareLogo then
				injectBananaLogoIntoContainer(d)
			end
		end
	end

	-- 2. Tìm Thanh Trạng Thái (Status Pill) nằm trên Header (bên phải "Banana Hub" / "v1.0.5")
	for _, desc in ipairs(headerContainer:GetDescendants()) do
		if desc:IsA("Frame") and not desc:FindFirstChildWhichIsA("TextBox") then
			if not desc:IsAncestorOf(titleLbl) and desc ~= titleLbl.Parent then
				local candidateTxt = nil
				local candidateEmoji = nil
				local candidateImg = nil

				for _, ch in ipairs(desc:GetDescendants()) do
					if (ch:IsA("ImageLabel") or ch:IsA("ImageButton")) and ch.Name ~= "BananaCatFixedOverlay" then
						candidateImg = ch
					elseif ch:IsA("TextLabel") then
						local t = (ch.Text or ""):match("^%s*(.-)%s*$") or ""
						if t ~= "" and not isIgnoredHeaderLabel(t) then
							if #t <= 4 and not t:find("%w") then
								candidateEmoji = ch
							else
								candidateTxt = ch
							end
						end
					end
				end

				if candidateTxt then
					if State.LiveFiggyTextLabel ~= candidateTxt then
						State.LiveFiggyTextLabel = candidateTxt
						State.LiveFiggyImageLabel = candidateImg
						State.LiveFiggyEmojiLabel = candidateEmoji
						State.LiveFiggyBadgeFrame = desc

						candidateTxt:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets)
						if candidateImg then
							candidateImg:GetPropertyChangedSignal("Image"):Connect(syncStatusFromLiveWidgets)
							candidateImg:GetPropertyChangedSignal("ImageColor3"):Connect(syncStatusFromLiveWidgets)
						end
						if candidateEmoji then
							candidateEmoji:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets)
						end
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

local function checkDirectStatusLabelCandidate(lbl)
	if not lbl or not lbl:IsA("TextLabel") or not lbl.Parent then return end
	local raw = lbl:GetAttribute("__FiggyOrigText") or lbl.Text or ""
	local clean = raw:match("^%s*(.-)%s*$") or ""
	if clean == "" or isIgnoredHeaderLabel(clean) then return end

	local low = string.lower(clean)
	local looksLikeLiveStatus = (
		low == "idle" or low == "đang rảnh"
		or low:find("carrying ", 1, true) ~= nil
		or low:find("đang mang ", 1, true) ~= nil
		or low:find("holding ", 1, true) ~= nil
		or low:find("đang giữ ", 1, true) ~= nil
		or low:find("stealing", 1, true) ~= nil
		or low:find("đang cướp", 1, true) ~= nil
		or low:find("moving to", 1, true) ~= nil
		or low:find("selling", 1, true) ~= nil
	)

	if not looksLikeLiveStatus then return end

	local badgeFrame = lbl.Parent
	if badgeFrame and badgeFrame:IsA("GuiObject") then
		local img = badgeFrame:FindFirstChildWhichIsA("ImageLabel", true) or badgeFrame:FindFirstChildWhichIsA("ImageButton", true)
		if badgeFrame.AbsoluteSize.Y > 0 and badgeFrame.AbsoluteSize.Y <= 38 then
			if State.LiveFiggyTextLabel ~= lbl then
				State.LiveFiggyTextLabel = lbl
				State.LiveFiggyImageLabel = img
				State.LiveFiggyBadgeFrame = badgeFrame
				lbl:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets)
				if img then
					img:GetPropertyChangedSignal("Image"):Connect(syncStatusFromLiveWidgets)
					img:GetPropertyChangedSignal("ImageColor3"):Connect(syncStatusFromLiveWidgets)
				end
			end
			cloakOriginalStatusBadge(badgeFrame)
			syncStatusFromLiveWidgets()
		else
			if State.FallbackStatusCardLabel ~= lbl then
				State.FallbackStatusCardLabel = lbl
				lbl:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets)
				if img and not State.LiveFiggyImageLabel then
					State.LiveFiggyImageLabel = img
				end
			end
			syncStatusFromLiveWidgets()
		end
	end
end

-- ============================================================================
-- 7. THAY LOGO NÚT NỔI (FLOATING BUTTON) & PHỐI MÀU GOLD PREMIUM CHO MENU
-- ============================================================================
local function styleElementGoldAndLogo(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end
	if obj.Name == "BananaCatFixedOverlay" then return end

	if State.LiveFiggyBadgeFrame and (obj == State.LiveFiggyBadgeFrame or obj:IsDescendantOf(State.LiveFiggyBadgeFrame)) then
		return
	end

	-- 1. Thay thế Logo nút nổi (Floating Toggle Button) & Logo khớp ID gốc sang Banana Cat
	if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
		local imgId = obj.Image or ""
		local aw, ah = obj.AbsoluteSize.X, obj.AbsoluteSize.Y
		local par = obj.Parent
		local parW = (par and par:IsA("GuiObject")) and par.AbsoluteSize.X or 0
		local parH = (par and par:IsA("GuiObject")) and par.AbsoluteSize.Y or 0

		local isKnownFiggyLogo = (imgId ~= "" and State.OrigFiggyLogoAssetIds[imgId] == true)
		local isFloatingToggleLogo = (
			par and (par:IsA("Frame") or par:IsA("ImageButton") or par:IsA("TextButton") or par:IsA("CanvasGroup"))
			and parW >= 32 and parW <= 72 and math.abs(parW - parH) <= 10
			and aw >= 16 and aw <= 68 and math.abs(aw - ah) <= 10
			and (par.Parent and (par.Parent:IsA("ScreenGui") or (par.Parent.Parent and par.Parent.Parent:IsA("ScreenGui"))))
		)

		if isKnownFiggyLogo or isFloatingToggleLogo or obj:GetAttribute("__IsBananaBrandLogo") then
			injectBananaLogoIntoContainer(obj)
			return
		end

		if isFiggyPurpleColor(obj.ImageColor3) then
			pcall(function() obj.ImageColor3 = GOLD_PRIMARY_TEXT end)
		end
	end

	-- Nếu bản thân nút nổi là một Frame trống (do ảnh con đã bị ẩn hoặc tạo trễ), chèn luôn BananaCatFixedOverlay vào nút nổi
	if obj:IsA("Frame") or obj:IsA("TextButton") then
		local aw, ah = obj.AbsoluteSize.X, obj.AbsoluteSize.Y
		local isTopLevelSquareBtn = (
			aw >= 36 and aw <= 68 and math.abs(aw - ah) <= 8
			and obj.Parent and obj.Parent:IsA("ScreenGui")
			and obj:FindFirstChildOfClass("UICorner") ~= nil
			and not obj:FindFirstChildWhichIsA("TextLabel", true)
		)
		if isTopLevelSquareBtn then
			local childImg = obj:FindFirstChildWhichIsA("ImageLabel", true) or obj:FindFirstChildWhichIsA("ImageButton", true)
			if childImg and childImg.Name ~= "BananaCatFixedOverlay" then
				injectBananaLogoIntoContainer(childImg)
			elseif not obj:FindFirstChild("BananaCatFixedOverlay") then
				local overlay = Instance.new("ImageLabel")
				overlay.Name = "BananaCatFixedOverlay"
				overlay.AnchorPoint = Vector2.new(0.5, 0.5)
				overlay.Position = UDim2.fromScale(0.5, 0.5)
				overlay.Size = UDim2.fromScale(0.88, 0.88)
				overlay.BackgroundTransparency = 1
				overlay.Image = BANANA_CAT_LOGO
				overlay.ScaleType = Enum.ScaleType.Crop
				overlay.Active = false
				overlay.ZIndex = (obj.ZIndex or 5) + 3
				overlay.Parent = obj
				Instance.new("UICorner", overlay).CornerRadius = UDim.new(0, 8)
				table.insert(State.BananaLogoOverlays, overlay)
			end
		end
	end

	-- 2. Chuyển màu nền/viền/chữ màu Tím Figgy sang Vàng Sang Trọng (Gold Premium)
	if obj:IsA("GuiObject") then
		if obj.BackgroundTransparency < 0.98 and isFiggyPurpleColor(obj.BackgroundColor3) then
			pcall(function() obj.BackgroundColor3 = GOLD_ACCENT_FILL end)
		end
	end

	if obj:IsA("UIStroke") then
		if isFiggyPurpleColor(obj.Color) then
			pcall(function() obj.Color = GOLD_BORDER_STROKE end)
		end
	end

	if obj:IsA("TextLabel") or obj:IsA("TextButton") then
		if isFiggyPurpleColor(obj.TextColor3) then
			pcall(function() obj.TextColor3 = GOLD_PRIMARY_TEXT end)
		end
	end
end

-- ============================================================================
-- 8. GẮN ÂM THANH & ĐỘNG CƠ DỊCH THUẬT MENU BANANA HUB (ZERO-LAG)
-- ============================================================================
local function hookMenuButtonSound(inst)
	if not inst or not inst.Parent then return end
	if State.IslandGui and inst:IsDescendantOf(State.IslandGui) then return end
	if inst:GetAttribute("__FiggySfxHooked") == SID then return end

	if inst:IsA("TextButton") or inst:IsA("ImageButton") then
		inst:SetAttribute("__FiggySfxHooked", SID)
		inst.Activated:Connect(function()
			if isAlive() then
				playUiSound("tap")
			end
		end)
	elseif inst:IsA("Frame") then
		local aw, ah = inst.AbsoluteSize.X, inst.AbsoluteSize.Y
		local isToggleOrInteractive = (aw >= 28 and aw <= 220 and ah >= 16 and ah <= 44 and inst:FindFirstChildOfClass("UICorner") ~= nil)
		if isToggleOrInteractive then
			inst:SetAttribute("__FiggySfxHooked", SID)
			inst.InputBegan:Connect(function(inp)
				if not isAlive() then return end
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					playUiSound("tap")
				end
			end)
		end
	end
end

local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	pcall(styleElementGoldAndLogo, obj)

	if obj:IsA("TextButton") or obj:IsA("ImageButton") or obj:IsA("Frame") then
		pcall(hookMenuButtonSound, obj)
	end

	if obj:IsA("TextBox") then
		local ph = obj.PlaceholderText or ""
		if ph ~= "" then
			if not obj:GetAttribute("__FiggyOrigPlaceholder") then
				obj:SetAttribute("__FiggyOrigPlaceholder", ph)
			end
			local basePh = obj:GetAttribute("__FiggyOrigPlaceholder") or ph
			local targetPh = translateString(basePh, State.Language)
			if targetPh and targetPh ~= ph then
				pcall(function() obj.PlaceholderText = targetPh end)
			end
		end
		return
	end

	if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then return end
	if obj:GetAttribute("__IsTranslatingFiggy") then return end

	local curText = obj.Text or ""
	if curText == "" then return end

	if obj:IsA("TextLabel") and (curText == "Figgy Hub" or curText == "Banana Hub" or curText == "FrostyFig") then
		if curText == "Figgy Hub" then
			obj:SetAttribute("__FiggyOrigText", "Figgy Hub")
		end
		pcall(applyGoldGradientToTitle, obj)
		pcall(bindHeaderAndLogosFromTitle, obj)
	end

	if EXACT_VI[curText] and State.Language == "VI" and curText ~= "Figgy Hub" and curText ~= "Figgy" then
		obj:SetAttribute("__FiggyOrigText", VI_TO_EN[EXACT_VI[curText]] or curText)
	end

	local lastTranslated = obj:GetAttribute("__FiggyLastTranslated")
	if not obj:GetAttribute("__FiggyOrigText") or (lastTranslated and curText ~= lastTranslated) then
		obj:SetAttribute("__FiggyOrigText", curText)
	end

	local origText = obj:GetAttribute("__FiggyOrigText") or curText
	local translated = translateString(origText, State.Language)

	if translated and translated ~= curText then
		obj:SetAttribute("__IsTranslatingFiggy", true)
		obj:SetAttribute("__FiggyLastTranslated", translated)
		pcall(function()
			obj.Text = translated
		end)
		obj:SetAttribute("__IsTranslatingFiggy", false)
	end

	if obj:IsA("TextLabel") then
		pcall(checkDirectStatusLabelCandidate, obj)
		if obj == State.LiveFiggyTextLabel or obj == State.FallbackStatusCardLabel then
			pcall(syncStatusFromLiveWidgets)
		end
	end

	if obj:GetAttribute("__FiggyTextWatched") ~= SID then
		obj:SetAttribute("__FiggyTextWatched", SID)
		table.insert(State.TrackedLabels, obj)
		obj:GetPropertyChangedSignal("Text"):Connect(function()
			if not isAlive() or obj:GetAttribute("__IsTranslatingFiggy") then return end
			processGuiElement(obj)
		end)
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

local function scanAllMenusOnce(forceSweep)
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local okName, gName = pcall(function() return gui.Name end)
				if okName and not IGNORED_SCREEN_GUIS[gName] and gName ~= "Old_BananaDynamicIsland" and isFiggyTargetGui(gui) then
					if gui:GetAttribute("__FiggyGuiHooked") ~= SID then
						gui:SetAttribute("__FiggyGuiHooked", SID)
						gui.DescendantAdded:Connect(function(desc)
							if not isAlive() then return end
							task.defer(function()
								if isAlive() and desc and desc.Parent then
									pcall(processGuiElement, desc)
								end
							end)
						end)
					end

					local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
					if okDesc and type(descendants) == "table" then
						local processedCount = 0
						for _, d in ipairs(descendants) do
							if forceSweep or d:GetAttribute("__FiggyTextWatched") ~= SID then
								pcall(processGuiElement, d)
								processedCount = processedCount + 1
								if processedCount % 220 == 0 then
									task.wait()
								end
							else
								if d:IsA("Frame") or d:IsA("UIStroke") or d:IsA("ImageLabel") or d:IsA("ImageButton") then
									pcall(styleElementGoldAndLogo, d)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- ============================================================================
-- 9. KHỞI CHẠY DYNAMIC ISLAND & VÒNG LẶP ĐỒNG BỘ TRẠNG THÁI REALTIME (0.15s)
-- ============================================================================
createIndependentFiggyDynamicIsland()

task.spawn(function()
	scanAllMenusOnce(true)

	local sweepCounter = 0
	while isAlive() do
		task.wait(0.15)
		if not isAlive() then break end

		pcall(syncStatusFromLiveWidgets)

		sweepCounter = sweepCounter + 1
		if sweepCounter >= 4 then
			sweepCounter = 0
			scanAllMenusOnce(false)
		end
	end
end)
