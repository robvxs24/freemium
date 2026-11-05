-- ============================================================================
-- FIGGY HUB V1.0.6+ | BẢN VIỆT HÓA TOÀN DIỆN & FIGGY DYNAMIC ISLAND (MATTE LIQUID GLASS)
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- 1. Bê nguyên hình ảnh và trạng thái từ header Figgy Hub vào Dynamic Island, cập nhật liên tục 100% thời gian thực
-- 2. Giao diện Kính Khói Mờ Dịu Mắt (Anti-Glare Matte Liquid Glass), nút màu Hổ Phách Figgy không còn chói mắt
-- 3. Ghim cố định sát mép trên màn hình, khóa di chuyển 100%
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
State.SoundEnabled = (State.SoundEnabled ~= false)
State.IsExpanded = false
State.NoteOpen = false
State.TrackedLabels = State.TrackedLabels or {}
State.FastCache = {}
State.CachedSounds = State.CachedSounds or {}

local function isAlive()
	return State.SessionId == SID
end

-- ============================================================================
-- 1. KHỞI CHẠY TRỰC TIẾP SCRIPT GỐC FIGGY HUB
-- ============================================================================
local FIGGY_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"

task.spawn(function()
	loadstring(game:HttpGet(FIGGY_LOADER_URL))()
end)

local IGNORED_SCREEN_GUIS = {
	ChilliDynamicIsland = true,
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

-- Nhận diện chính xác ScreenGui của Figgy Hub (tránh can thiệp vào UI riêng của Executor)
local function isFiggyTargetGui(gui)
	if not gui then return false end
	if gui:GetAttribute("__VerifiedFiggyGui") then return true end
	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end
	for _, d in ipairs(desc) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = d.Text or ""
			if t == "Figgy Hub" or t == "FrostyFig" or t == "UFO SIGHTINGS" or t == "PHÁT HIỆN UFO" or t == "EQUIP BEST" or t == "TRANG BỊ MẠNH NHẤT" or t == "Guard: OFF" or t == "Bảo vệ: TẮT" or t:find("^Shortcut %d+$") or t:find("^Phím Tắt %d+$") then
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
	open   = { id = "rbxassetid://6895079853", vol = 0.60, spd = 1.06 },
	close  = { id = "rbxassetid://6895079853", vol = 0.48, spd = 0.86 },
	tap    = { id = "rbxassetid://6026984224", vol = 0.58, spd = 1.14 },
	action = { id = "rbxassetid://4590662766", vol = 0.60, spd = 1.08 },
}

local function getCachedSound(kind)
	local key = kind or "tap"
	local cfg = SOUND_CONFIG[key] or SOUND_CONFIG.tap
	local snd = State.CachedSounds[key]
	if not (snd and snd.Parent) then
		snd = Instance.new("Sound")
		snd.Name = "FiggyGlassSfx_" .. key
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
-- 3. BẢNG MÀU KÍNH KHÓI MỜ DỊU MẮT & NÚT HỔ PHÁCH FIGGY (ANTI-GLARE DESIGN)
-- ============================================================================
local DEFAULT_FIGGY_AVATAR = "rbxassetid://6031280882" -- Avatar Quả Sung Tím Figgy Hub
local DOWN_ARROW_ICON      = "rbxassetid://6031091004"

-- Tông màu dịu mắt chống chói (Matte Smoked Charcoal & Soft Figgy Amber)
local TEXT_SOFT_PRIMARY   = Color3.fromRGB(224, 224, 230) -- Trắng ngà dịu mắt
local TEXT_SOFT_MUTED     = Color3.fromRGB(152, 155, 168) -- Xám bạc êm ái
local TEXT_DARK_BTN       = Color3.fromRGB(24, 24, 28)    -- Chữ đen than cho nút active
local BTN_ACTIVE_AMBER    = Color3.fromRGB(245, 218, 140) -- Vàng hổ phách dịu mắt chuẩn Figgy Hub
local BTN_INACTIVE_BG     = Color3.fromRGB(34, 34, 40)    -- Nền nút xám trầm
local STROKE_MUTED_BORDER = Color3.fromRGB(56, 56, 68)    -- Viền kính trầm không chói

-- ============================================================================
-- 4. BỘ TỪ ĐIỂN & ĐỘNG CƠ DỊCH THUẬT TOÀN DIỆN FIGGY HUB (BAO GỒM 7915.JPG)
-- ============================================================================
local EXACT_VI = {
	-- Header & Trạng thái
	["Figgy Hub"] = "Figgy Hub",
	["Steal an Egg"] = "Cướp Trứng",
	["Steal An Egg"] = "Cướp Trứng",
	["steal an egg"] = "Cướp Trứng",
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

	-- Tab Sidebar Figgy Hub
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

	-- Sub-tabs Tab Trứng (Trong ảnh 7915.jpg)
	["Automation"] = "Tự Động",
	["AUTOMATION"] = "TỰ ĐỘNG",
	["Predictor"] = "Dự Đoán",
	["PREDICTOR"] = "DỰ ĐOÁN",
	["TỰ ĐỘNG CƯỚP TRỨNG"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["Tự động cướp trứng"] = "Tự động cướp trứng",
	["Auto Steal"] = "Tự động cướp trứng",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["Auto steal"] = "Tự động cướp trứng",
	["ĐÃ CƯỚP"] = "ĐÃ CƯỚP",
	["TRẠNG THÁI"] = "TRẠNG THÁI",
	["Tự động cướp: Tắt"] = "Tự động cướp: Tắt",
	["Tự động cướp: Bật"] = "Tự động cướp: Bật",
	["TỐC ĐỘ"] = "TỐC ĐỘ",
	["TÚI TRỨNG"] = "TÚI TRỨNG",
	["Di Chuyển To trứng"] = "Di chuyển tới trứng",
	["Di chuyển tới trứng"] = "Di chuyển tới trứng",
	["Go to egg"] = "Di chuyển tới trứng",
	["Go to Egg"] = "Di chuyển tới trứng",
	["dịch chuyển"] = "Dịch chuyển",
	["Dịch chuyển"] = "Dịch chuyển",
	["Teleport"] = "Dịch chuyển",
	["Fast Tween"] = "Bay Nhanh (Fast Tween)",
	["Fast tween"] = "Bay Nhanh (Fast Tween)",
	["Walk"] = "Đi bộ",
	["Phương thức giao trứng"] = "Phương thức giao trứng",
	["Delivery method"] = "Phương thức giao trứng",
	["Khu vực dịch chuyển"] = "Khu vực dịch chuyển",
	["Teleport zones"] = "Khu vực dịch chuyển",
	["Titan Temple"] = "Đền Titan",
	["Enchanted Forest"] = "Rừng Phù Phép",
	["Light Dark"] = "Sáng Tối",
	["Cherry Blossom"] = "Hoa Anh Đào",
	["Prehistoric"] = "Tiền Sử",
	["Volcano"] = "Núi Lửa",
	["Snow"] = "Tuyết",
	["Desert"] = "Sa Mạc",
	["Cướp trứng thiếu trong Mục lục"] = "Cướp trứng thiếu trong Mục lục",
	["Steal missing index eggs"] = "Cướp trứng thiếu trong Mục lục",

	-- Bộ Lọc (Trong ảnh 7915.jpg)
	["BỘ LỌC"] = "BỘ LỌC",
	["Bộ lọc"] = "Bộ lọc",
	["Filter"] = "Bộ lọc",
	["FILTER"] = "BỘ LỌC",
	["Khu vực"] = "Khu vực",
	["Area"] = "Khu vực",
	["Zones"] = "Khu vực",
	["Ưu tiên cướp trước"] = "Ưu tiên cướp trước",
	["Steal first"] = "Ưu tiên cướp trước",
	["Steal Priority"] = "Ưu Tiên Cướp",
	["Highest Earnings"] = "Thu nhập cao nhất",
	["Lowest Earnings"] = "Thu nhập thấp nhất",
	["Best value"] = "Giá trị cao nhất",
	["Lowest value"] = "Giá trị thấp nhất",
	["Best rarity"] = "Độ hiếm cao nhất",
	["Best mutation"] = "Đột biến tốt nhất",
	["Đột biến"] = "Đột biến",
	["Mutation"] = "Đột biến",
	["Mutations"] = "Đột biến",
	["Chưa chọn"] = "Chưa chọn",
	["No selection"] = "Chưa chọn",
	["Độ hiếm"] = "Độ hiếm",
	["Rarity"] = "Độ hiếm",
	["Rarities"] = "Độ hiếm",
	["Chỉ những trứng này"] = "Chỉ những trứng này",
	["Only these eggs"] = "Chỉ những trứng này",
	["Tối thiểu $/giây"] = "Tối thiểu $/giây",
	["Min $/s"] = "Tối thiểu $/giây",
	["Min KG"] = "Cân nặng tối thiểu (KG)",
	["Bán Cheapest trứng"] = "Bán trứng rẻ nhất khi đầy túi",
	["Sell Cheapest Egg"] = "Bán trứng rẻ nhất khi đầy túi",
	["Sell cheapest egg"] = "Bán trứng rẻ nhất khi đầy túi",
	["Sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
	["Makes room when the trứng túi is full"] = "Tự bán dọn chỗ khi túi trứng đầy",
	["Makes room when the egg bag is full"] = "Tự bán dọn chỗ khi túi trứng đầy",
	["Makes room when the bag is full"] = "Tự bán dọn chỗ khi túi đầy",
	["Không có"] = "Không có",
	["None"] = "Không có",
	["Tắt"] = "Tắt",
	["Off"] = "Tắt",
	["Bật"] = "Bật",
	["On"] = "Bật",

	-- Tab Quản Lý (Trong ảnh 7909.jpg)
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

	-- UFO & Sự kiện
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
	["STATUS"] = "TRẠNG THÁI",
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
	if not VI_TO_EN[viVal] then
		VI_TO_EN[viVal] = enKey
	end
	local lv = string.lower(viVal)
	if not VI_TO_EN[lv] then
		VI_TO_EN[lv] = enKey
	end
end

local GRAMMAR_VI = {
	-- Trạng thái mang trứng trong 7915.jpg: "Carrying $23.2M/s" -> "Đang mang $23.2M/s"
	{ pat = "^[Cc]arrying%s+(.+)$", rep = "Đang mang %1" },
	{ pat = "^[Hh]olding%s+(.+)$", rep = "Đang giữ %1" },
	{ pat = "^[Ss]tealing%s+(.+)$", rep = "Đang cướp %1" },
	{ pat = "^[Ff]arming%s+(.+)$", rep = "Đang cày %1" },
	{ pat = "^[Ww]aiting%s+for%s+(.+)$", rep = "Đang chờ %1" },
	{ pat = "^[Nn]ext%s+UFO%s+in%s+(.+)$", rep = "UFO tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+event%s+in%s+(.+)$", rep = "Sự kiện tiếp theo sau %1" },
	{ pat = "^[Ss]hortcut%s+(%d+)$", rep = "Phím Tắt %1" },
	{ pat = "^QUICK BAR (%d+)$", rep = "THANH NHANH %1" },
	{ pat = "^[Gg]uard:%s*[Oo][Ff][Ff]$", rep = "Bảo vệ: TẮT" },
	{ pat = "^[Gg]uard:%s*[Oo][Nn]$", rep = "Bảo vệ: BẬT" },
	{ pat = "^[Mm]in%s+%$/s(.*)$", rep = "Tối thiểu $/giây%1" },
	{ pat = "^[Mm]ax%s+%$/s(.*)$", rep = "Tối đa $/giây%1" },
	{ pat = "^[Oo]pen%s+(.+)%s+[Bb]ag$", rep = "Mở Túi %1" },
	{ pat = "^[Kk]eep%s+[Mm]utated%s+(.+)$", rep = "Giữ lại %1 đột biến" },
	{ pat = "^[Nn]ever%s+[Ss]ell%s+(.+)$", rep = "Không bán %1" },
	{ pat = "^[Mm]aximum%s+(.+)$", rep = "Tối đa %1" },
	{ pat = "^[Mm]inimum%s+(.+)$", rep = "Tối thiểu %1" },
	{ pat = "^[Cc]ollect%s+UFO%s+(.+)$", rep = "Thu thập %1 UFO" },
	{ pat = "^[Ff]arm%s+[Rr]are%s+(.+)$", rep = "Cày %1 hiếm" },
	{ pat = "^[Tt]eleport%s+[Ii]f%s+[Ff]ar%s+[Ff]rom%s+(.+)$", rep = "Dịch chuyển nếu ở xa %1" },
	{ pat = "^[Aa]uto%s+[Ee]quip%s+[Bb]est%s+(.+)$", rep = "Tự động trang bị %1 mạnh nhất" },
	{ pat = "^[Aa]uto%s+(.+)$", rep = "Tự động %1" },
	{ pat = "^this%s+[Ss][Ee][Ss][Ss][Ii][Oo][Nn]$", rep = "phiên này" },
}

local PHRASES_VI = {
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
	{ "this session", "phiên này" },
}

local WORDS_VI = {
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
	crafting = "chế tạo",
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
}

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

		for i = 1, #GRAMMAR_VI do
			local g = GRAMMAR_VI[i]
			if string.find(trimmed, g.pat) then
				local rep = string.gsub(trimmed, g.pat, g.rep)
				rep = applyPhrasesAndWords(rep)
				State.FastCache[cacheKey] = rep
				return lead .. rep .. trail
			end
		end

		local low = string.lower(trimmed)
		for i = 1, #PHRASES_VI do
			if string.find(low, PHRASES_VI[i][1], 1, true) then
				local rep = applyPhrasesAndWords(trimmed)
				State.FastCache[cacheKey] = rep
				return lead .. rep .. trail
			end
		end

		return rawText
	else
		local rev = VI_TO_EN[trimmed] or VI_TO_EN[string.lower(trimmed)]
		if rev then
			State.FastCache[cacheKey] = rev
			return lead .. rev .. trail
		end
		-- Khôi phục tiếng Anh cho trạng thái mang trứng
		local carryVal = trimmed:match("^Đang%s+mang%s+(.+)$")
		if carryVal then
			return lead .. "Carrying " .. carryVal .. trail
		end
		local holdVal = trimmed:match("^Đang%s+giữ%s+(.+)$")
		if holdVal then
			return lead .. "Holding " .. holdVal .. trail
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
	local isIdle = (low == "" or low == "idle" or low == "đang rảnh" or string.find(low, "rảnh", 1, true) ~= nil or string.find(low, "idle", 1, true) ~= nil)

	if State.Language == "EN" then
		if isIdle then return "Idle" end
		if low == "đang chạy" then return "Running" end
		local enStr = translateRawSegment(clean, "EN")
		return (enStr and enStr ~= "") and enStr or clean
	else
		if isIdle then return "Đang rảnh" end
		if low == "running" or low == "working" or low == "active" or low == "đang chạy" then
			return "Đang chạy"
		end
		local viStr = translateRawSegment(clean, "VI")
		if viStr and viStr ~= clean then
			return viStr
		end
		return clean
	end
end

-- ============================================================================
-- 5. THIẾT KẾ FIGGY DYNAMIC ISLAND (MATTE LIQUID GLASS - ANTI-GLARE)
--    - Bê nguyên icon ImageLabel & trạng thái TextLabel từ Figgy Hub vào viên thuốc
--    - Nút gạt Tiếng Việt / English dùng màu Hổ Phách Figgy, dịu mắt, không còn chói
--    - Ghim cố định sát mép trên Y = 6, khóa di chuyển 100%
-- ============================================================================
local PINNED_PILL_POS   = UDim2.new(0.5, 0, 0, 6)
local PINNED_DRAWER_POS = UDim2.new(0.5, 0, 0, 48)

local function applyMatteLiquidGlass(frame, cornerRadius, bgAlpha, strokeColor, strokeThickness)
	frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	frame.BackgroundTransparency = bgAlpha or 0.22
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or UDim.new(1, 0)
	corner.Parent = frame

	local stroke = frame:FindFirstChild("MatteRimStroke") or Instance.new("UIStroke")
	stroke.Name = "MatteRimStroke"
	stroke.Color = strokeColor or STROKE_MUTED_BORDER
	stroke.Thickness = strokeThickness or 1.2
	stroke.Transparency = 0.35
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame

	-- Phản quang đỉnh kính mờ siêu dịu mắt (Transparency = 0.90..1.00)
	local topShine = frame:FindFirstChild("MatteGlassTopSpecular") or Instance.new("Frame")
	topShine.Name = "MatteGlassTopSpecular"
	topShine.AnchorPoint = Vector2.new(0.5, 0)
	topShine.Position = UDim2.new(0.5, 0, 0, 1)
	topShine.Size = UDim2.new(1, -20, 0, 9)
	topShine.BackgroundColor3 = Color3.fromRGB(225, 225, 235)
	topShine.BackgroundTransparency = 0
	topShine.BorderSizePixel = 0
	topShine.Active = false
	topShine.ZIndex = (frame.ZIndex or 10) + 1
	topShine.Parent = frame

	local shineCorner = topShine:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	shineCorner.CornerRadius = UDim.new(1, 0)
	shineCorner.Parent = topShine

	local shineGrad = topShine:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
	shineGrad.Rotation = 90
	shineGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 0.90),
		NumberSequenceKeypoint.new(0.70, 0.96),
		NumberSequenceKeypoint.new(1.00, 1.00),
	})
	shineGrad.Parent = topShine

	return stroke
end

local function createIndependentFiggyDynamicIsland()
	for _, root in ipairs(getUiRoots()) do
		for _, gName in ipairs({ "ChilliDynamicIsland", "FiggyDynamicIsland" }) do
			local old = root:FindFirstChild(gName)
			if old then
				pcall(function()
					old.Name = "Old_ChilliDynamicIsland"
					old.Enabled = false
					old:Destroy()
				end)
			end
		end
	end

	local islandGui = Instance.new("ScreenGui")
	islandGui.Name = "ChilliDynamicIsland"
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
	-- VIÊN THUỐC NGOÀI (DYNAMIC ISLAND PILL - GHIM CỐ ĐỊNH SÁT MÉP TRÊN Y = 6)
	-- ========================================================================
	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = PINNED_PILL_POS
	pillFrame.Size = UDim2.new(0, 172, 0, 38)
	pillFrame.Active = true
	pillFrame.ZIndex = 20
	pillFrame.Parent = islandGui

	-- Khóa cứng tọa độ viên thuốc, không cho phép di chuyển
	pillFrame:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and pillFrame.Position ~= PINNED_PILL_POS then
			pillFrame.Position = PINNED_PILL_POS
		end
	end)

	local pillStroke = applyMatteLiquidGlass(pillFrame, UDim.new(1, 0), 0.22, STROKE_MUTED_BORDER, 1.2)

	-- [Bên trái]: Khung Icon kính mờ chứa trực tiếp Icon bê từ Figgy Hub sang
	local iconOrb = Instance.new("Frame")
	iconOrb.Name = "StatusIconOrb"
	iconOrb.AnchorPoint = Vector2.new(0, 0.5)
	iconOrb.Position = UDim2.new(0, 6, 0.5, 0)
	iconOrb.Size = UDim2.new(0, 26, 0, 26)
	iconOrb.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
	iconOrb.BackgroundTransparency = 0.20
	iconOrb.BorderSizePixel = 0
	iconOrb.ZIndex = 22
	iconOrb.Parent = pillFrame

	local orbCorner = Instance.new("UICorner")
	orbCorner.CornerRadius = UDim.new(1, 0)
	orbCorner.Parent = iconOrb

	local orbStroke = Instance.new("UIStroke")
	orbStroke.Color = Color3.fromRGB(48, 48, 58)
	orbStroke.Thickness = 1.0
	orbStroke.Parent = iconOrb

	-- ImageLabel icon bê nguyên từ Figgy Hub vào (tự cập nhật khi trứng/trạng thái đổi)
	local statusIconImg = Instance.new("ImageLabel")
	statusIconImg.Name = "TransplantedStatusIcon"
	statusIconImg.AnchorPoint = Vector2.new(0.5, 0.5)
	statusIconImg.Position = UDim2.fromScale(0.5, 0.5)
	statusIconImg.Size = UDim2.new(0, 18, 0, 18)
	statusIconImg.BackgroundTransparency = 1
	statusIconImg.Image = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or DEFAULT_FIGGY_AVATAR
	statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
	statusIconImg.ScaleType = Enum.ScaleType.Fit
	statusIconImg.ZIndex = 23
	statusIconImg.Parent = iconOrb

	-- [Ở giữa]: TextLabel trạng thái bê nguyên từ Figgy Hub sang (màu ngà dịu mắt, không chói)
	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0, 0.5)
	centerStatusLabel.Position = UDim2.new(0, 38, 0.5, 0)
	centerStatusLabel.Size = UDim2.new(1, -66, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = TEXT_SOFT_PRIMARY
	centerStatusLabel.TextSize = 12
	centerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	centerStatusLabel.Text = formatIslandStatusText(State.CurrentRawStatus)
	centerStatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
	centerStatusLabel.ZIndex = 23
	centerStatusLabel.Parent = pillFrame

	-- [Bên phải]: Icon mũi tên mở rộng
	local rightArrow = Instance.new("ImageLabel")
	rightArrow.Name = "ArrowIcon"
	rightArrow.AnchorPoint = Vector2.new(1, 0.5)
	rightArrow.Position = UDim2.new(1, -8, 0.5, 0)
	rightArrow.Size = UDim2.new(0, 12, 0, 12)
	rightArrow.BackgroundTransparency = 1
	rightArrow.Image = DOWN_ARROW_ICON
	rightArrow.ImageColor3 = TEXT_SOFT_MUTED
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
	-- BẢNG MỞ RỘNG BÊN TRONG (LANGUAGE DRAWER - ANTI-GLARE MATTE LIQUID GLASS)
	-- Nút chọn ngôn ngữ dùng tông Hổ Phách Figgy dịu mắt, không còn màu xanh chói!
	-- ========================================================================
	local EXP_W = 312
	local COLLAPSED_EXP_H = 168
	local OPEN_NOTE_EXP_H = 256

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

	local expStroke = applyMatteLiquidGlass(expandPanel, UDim.new(0, 20), 0.14, STROKE_MUTED_BORDER, 1.2)

	-- Header Bảng Mở Rộng
	local expLogoOrb = Instance.new("Frame")
	expLogoOrb.Position = UDim2.new(0, 12, 0, 10)
	expLogoOrb.Size = UDim2.new(0, 26, 0, 26)
	expLogoOrb.BackgroundColor3 = Color3.fromRGB(34, 34, 40)
	expLogoOrb.BackgroundTransparency = 0.20
	expLogoOrb.BorderSizePixel = 0
	expLogoOrb.ZIndex = 32
	expLogoOrb.Parent = expandPanel
	Instance.new("UICorner", expLogoOrb).CornerRadius = UDim.new(1, 0)

	local expLogoImg = Instance.new("ImageLabel")
	expLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
	expLogoImg.Position = UDim2.fromScale(0.5, 0.5)
	expLogoImg.Size = UDim2.new(0, 18, 0, 18)
	expLogoImg.BackgroundTransparency = 1
	expLogoImg.Image = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or DEFAULT_FIGGY_AVATAR
	expLogoImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
	expLogoImg.ScaleType = Enum.ScaleType.Fit
	expLogoImg.ZIndex = 33
	expLogoImg.Parent = expLogoOrb

	local expTitle = Instance.new("TextLabel")
	expTitle.Position = UDim2.new(0, 46, 0, 8)
	expTitle.Size = UDim2.new(0, 170, 0, 15)
	expTitle.BackgroundTransparency = 1
	expTitle.Font = Enum.Font.GothamBold
	expTitle.TextSize = 11.5
	expTitle.TextColor3 = TEXT_SOFT_PRIMARY
	expTitle.TextXAlignment = Enum.TextXAlignment.Left
	expTitle.Text = "FIGGY DYNAMIC ISLAND"
	expTitle.ZIndex = 33
	expTitle.Parent = expandPanel

	local expSubBadge = Instance.new("TextLabel")
	expSubBadge.Position = UDim2.new(0, 46, 0, 23)
	expSubBadge.Size = UDim2.new(0, 180, 0, 12)
	expSubBadge.BackgroundTransparency = 1
	expSubBadge.Font = Enum.Font.GothamMedium
	expSubBadge.TextSize = 8.5
	expSubBadge.TextColor3 = TEXT_SOFT_MUTED
	expSubBadge.TextXAlignment = Enum.TextXAlignment.Left
	expSubBadge.Text = "● ĐỒNG BỘ THỜI GIAN THỰC • DỊU MẮT"
	expSubBadge.ZIndex = 33
	expSubBadge.Parent = expandPanel

	local collapseBtn = Instance.new("TextButton")
	collapseBtn.Name = "CollapseIslandBtn"
	collapseBtn.Position = UDim2.new(1, -78, 0, 10)
	collapseBtn.Size = UDim2.new(0, 66, 0, 22)
	collapseBtn.BackgroundColor3 = BTN_INACTIVE_BG
	collapseBtn.BorderSizePixel = 0
	collapseBtn.Text = "Thu gọn ▲"
	collapseBtn.Font = Enum.Font.GothamMedium
	collapseBtn.TextSize = 9.5
	collapseBtn.TextColor3 = TEXT_SOFT_MUTED
	collapseBtn.AutoButtonColor = false
	collapseBtn.ZIndex = 34
	collapseBtn.Parent = expandPanel
	Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(1, 0)
	local cbStroke = Instance.new("UIStroke", collapseBtn)
	cbStroke.Color = Color3.fromRGB(50, 50, 60)
	cbStroke.Thickness = 1

	-- Thẻ hiển thị trạng thái bê nguyên từ Figgy Hub vào
	local liveStatusCard = Instance.new("Frame")
	liveStatusCard.Name = "LiveStatusCard"
	liveStatusCard.Position = UDim2.new(0, 12, 0, 42)
	liveStatusCard.Size = UDim2.new(1, -24, 0, 28)
	liveStatusCard.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	liveStatusCard.BorderSizePixel = 0
	liveStatusCard.ZIndex = 32
	liveStatusCard.Parent = expandPanel
	Instance.new("UICorner", liveStatusCard).CornerRadius = UDim.new(0, 8)
	local lscStroke = Instance.new("UIStroke", liveStatusCard)
	lscStroke.Color = Color3.fromRGB(48, 48, 58)
	lscStroke.Thickness = 1

	local cardIconImg = Instance.new("ImageLabel")
	cardIconImg.Name = "CardIcon"
	cardIconImg.AnchorPoint = Vector2.new(0, 0.5)
	cardIconImg.Position = UDim2.new(0, 8, 0.5, 0)
	cardIconImg.Size = UDim2.new(0, 16, 0, 16)
	cardIconImg.BackgroundTransparency = 1
	cardIconImg.Image = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or DEFAULT_FIGGY_AVATAR
	cardIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
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
	cardStatusLbl.TextColor3 = TEXT_SOFT_PRIMARY
	cardStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
	cardStatusLbl.TextTruncate = Enum.TextTruncate.AtEnd
	cardStatusLbl.Text = formatIslandStatusText(State.CurrentRawStatus)
	cardStatusLbl.ZIndex = 33
	cardStatusLbl.Parent = liveStatusCard

	-- Thanh gạt chọn ngôn ngữ dịu mắt (Màu Hổ Phách Figgy, không còn chói)
	local langTrack = Instance.new("Frame")
	langTrack.Name = "LanguageGlassTrack"
	langTrack.Position = UDim2.new(0, 12, 0, 76)
	langTrack.Size = UDim2.new(1, -24, 0, 30)
	langTrack.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	langTrack.BorderSizePixel = 0
	langTrack.ZIndex = 32
	langTrack.Parent = expandPanel
	Instance.new("UICorner", langTrack).CornerRadius = UDim.new(0, 8)
	local ltStroke = Instance.new("UIStroke", langTrack)
	ltStroke.Color = Color3.fromRGB(46, 46, 56)
	ltStroke.Thickness = 1

	local btnVI = Instance.new("TextButton")
	btnVI.Name = "BtnVietnamese"
	btnVI.Position = UDim2.new(0, 2, 0, 2)
	btnVI.Size = UDim2.new(0.5, -3, 1, -4)
	btnVI.BorderSizePixel = 0
	btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_AMBER or Color3.fromRGB(34, 34, 40)
	btnVI.BackgroundTransparency = (State.Language == "VI") and 0 or 1
	btnVI.Font = Enum.Font.GothamBold
	btnVI.Text = "🇻🇳 Tiếng Việt"
	btnVI.TextSize = 10.5
	btnVI.TextColor3 = (State.Language == "VI") and TEXT_DARK_BTN or TEXT_SOFT_MUTED
	btnVI.AutoButtonColor = false
	btnVI.ZIndex = 34
	btnVI.Parent = langTrack
	Instance.new("UICorner", btnVI).CornerRadius = UDim.new(0, 6)

	local btnEN = Instance.new("TextButton")
	btnEN.Name = "BtnEnglish"
	btnEN.Position = UDim2.new(0.5, 1, 0, 2)
	btnEN.Size = UDim2.new(0.5, -3, 1, -4)
	btnEN.BorderSizePixel = 0
	btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_AMBER or Color3.fromRGB(34, 34, 40)
	btnEN.BackgroundTransparency = (State.Language == "EN") and 0 or 1
	btnEN.Font = Enum.Font.GothamBold
	btnEN.Text = "🇺🇸 English"
	btnEN.TextSize = 10.5
	btnEN.TextColor3 = (State.Language == "EN") and TEXT_DARK_BTN or TEXT_SOFT_MUTED
	btnEN.AutoButtonColor = false
	btnEN.ZIndex = 34
	btnEN.Parent = langTrack
	Instance.new("UICorner", btnEN).CornerRadius = UDim.new(0, 6)

	-- Nút gạt Âm thanh & Nút quét lại dịch thuật
	local actionRow = Instance.new("Frame")
	actionRow.Name = "ActionRow"
	actionRow.Position = UDim2.new(0, 12, 0, 112)
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
	soundToggleBtn.TextColor3 = TEXT_SOFT_MUTED
	soundToggleBtn.Text = State.SoundEnabled and "🔊 Âm thanh: BẬT" or "🔇 Âm thanh: TẮT"
	soundToggleBtn.AutoButtonColor = false
	soundToggleBtn.ZIndex = 34
	soundToggleBtn.Parent = actionRow
	Instance.new("UICorner", soundToggleBtn).CornerRadius = UDim.new(0, 6)
	local sbStroke = Instance.new("UIStroke", soundToggleBtn)
	sbStroke.Color = Color3.fromRGB(46, 46, 56)
	sbStroke.Thickness = 1

	local rescanBtn = Instance.new("TextButton")
	rescanBtn.Name = "RescanTranslateBtn"
	rescanBtn.Position = UDim2.new(0.5, 4, 0, 0)
	rescanBtn.Size = UDim2.new(0.5, -4, 1, 0)
	rescanBtn.BackgroundColor3 = BTN_INACTIVE_BG
	rescanBtn.BorderSizePixel = 0
	rescanBtn.Font = Enum.Font.GothamMedium
	rescanBtn.TextSize = 9.5
	rescanBtn.TextColor3 = Color3.fromRGB(225, 205, 140)
	rescanBtn.Text = "⚡ Quét lại Menu"
	rescanBtn.AutoButtonColor = false
	rescanBtn.ZIndex = 34
	rescanBtn.Parent = actionRow
	Instance.new("UICorner", rescanBtn).CornerRadius = UDim.new(0, 6)
	local rbStroke = Instance.new("UIStroke", rescanBtn)
	rbStroke.Color = Color3.fromRGB(46, 46, 56)
	rbStroke.Thickness = 1

	-- Ngăn thông tin
	local noteToggleBtn = Instance.new("TextButton")
	noteToggleBtn.Name = "SettingNoteToggleBtn"
	noteToggleBtn.Position = UDim2.new(0, 12, 0, 142)
	noteToggleBtn.Size = UDim2.new(1, -24, 0, 22)
	noteToggleBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	noteToggleBtn.BorderSizePixel = 0
	noteToggleBtn.Text = "Thông tin Figgy Island (Bấm xem) ▼"
	noteToggleBtn.Font = Enum.Font.GothamMedium
	noteToggleBtn.TextSize = 9
	noteToggleBtn.TextColor3 = TEXT_SOFT_MUTED
	noteToggleBtn.AutoButtonColor = false
	noteToggleBtn.ZIndex = 33
	noteToggleBtn.Parent = expandPanel
	Instance.new("UICorner", noteToggleBtn).CornerRadius = UDim.new(0, 6)
	local ntbStroke = Instance.new("UIStroke", noteToggleBtn)
	ntbStroke.Color = Color3.fromRGB(44, 44, 54)
	ntbStroke.Thickness = 1

	local noteDrawer = Instance.new("Frame")
	noteDrawer.Name = "SettingNoteDrawer"
	noteDrawer.Position = UDim2.new(0, 12, 0, 168)
	noteDrawer.Size = UDim2.new(1, -24, 0, 80)
	noteDrawer.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
	noteDrawer.BorderSizePixel = 0
	noteDrawer.Visible = false
	noteDrawer.ClipsDescendants = true
	noteDrawer.ZIndex = 33
	noteDrawer.Parent = expandPanel
	Instance.new("UICorner", noteDrawer).CornerRadius = UDim.new(0, 8)
	local ndStroke = Instance.new("UIStroke", noteDrawer)
	ndStroke.Color = Color3.fromRGB(44, 44, 54)
	ndStroke.Thickness = 1

	local ndHeader = Instance.new("TextLabel", noteDrawer)
	ndHeader.Position = UDim2.new(0, 8, 0, 4)
	ndHeader.Size = UDim2.new(1, -16, 0, 14)
	ndHeader.BackgroundTransparency = 1
	ndHeader.Font = Enum.Font.GothamBold
	ndHeader.TextSize = 9
	ndHeader.TextColor3 = Color3.fromRGB(225, 205, 140)
	ndHeader.TextXAlignment = Enum.TextXAlignment.Left
	ndHeader.Text = "🍇 FIGGY DYNAMIC ISLAND"
	ndHeader.ZIndex = 35

	local ndLine1 = Instance.new("TextLabel", noteDrawer)
	ndLine1.Position = UDim2.new(0, 8, 0, 20)
	ndLine1.Size = UDim2.new(1, -16, 0, 16)
	ndLine1.BackgroundTransparency = 1
	ndLine1.Font = Enum.Font.GothamMedium
	ndLine1.TextSize = 8.5
	ndLine1.TextColor3 = TEXT_SOFT_PRIMARY
	ndLine1.TextXAlignment = Enum.TextXAlignment.Left
	ndLine1.Text = "+ Bê nguyên hình ảnh & trạng thái từ Figgy Hub vào Dynamic Island"
	ndLine1.ZIndex = 35

	local ndLine2 = Instance.new("TextLabel", noteDrawer)
	ndLine2.Position = UDim2.new(0, 8, 0, 38)
	ndLine2.Size = UDim2.new(1, -16, 0, 16)
	ndLine2.BackgroundTransparency = 1
	ndLine2.Font = Enum.Font.GothamMedium
	ndLine2.TextSize = 8.5
	ndLine2.TextColor3 = TEXT_SOFT_MUTED
	ndLine2.TextXAlignment = Enum.TextXAlignment.Left
	ndLine2.Text = "+ Kính khói mờ dịu mắt, ghim cố định sát mép trên"
	ndLine2.ZIndex = 35

	local ndLine3 = Instance.new("TextLabel", noteDrawer)
	ndLine3.Position = UDim2.new(0, 8, 0, 56)
	ndLine3.Size = UDim2.new(1, -16, 0, 16)
	ndLine3.BackgroundTransparency = 1
	ndLine3.Font = Enum.Font.GothamMedium
	ndLine3.TextSize = 8.5
	ndLine3.TextColor3 = Color3.fromRGB(140, 220, 175)
	ndLine3.TextXAlignment = Enum.TextXAlignment.Left
	ndLine3.Text = "+ Âm thanh tương tác êm ái khi bấm các nút"
	ndLine3.ZIndex = 35

	-- Cập nhật giao diện khi đổi trạng thái hoặc ngôn ngữ
	local function updatePillVisuals()
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		centerStatusLabel.Text = displayTxt
		cardStatusLbl.Text = displayTxt

		-- Cập nhật icon bê từ Figgy Hub
		local curImg = (State.CurrentStatusImage ~= "") and State.CurrentStatusImage or DEFAULT_FIGGY_AVATAR
		statusIconImg.Image = curImg
		statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
		cardIconImg.Image = curImg
		cardIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
		expLogoImg.Image = curImg
		expLogoImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)

		-- Cập nhật ngôn ngữ
		expSubBadge.Text = (State.Language == "EN") and "● REALTIME SYNC • MATTE GLASS" or "● ĐỒNG BỘ THỜI GIAN THỰC • DỊU MẮT"
		collapseBtn.Text = (State.Language == "EN") and "Collapse ▲" or "Thu gọn ▲"
		soundToggleBtn.Text = State.SoundEnabled
			and ((State.Language == "EN") and "🔊 Sound: ON" or "🔊 Âm thanh: BẬT")
			or ((State.Language == "EN") and "🔇 Sound: OFF" or "🔇 Âm thanh: TẮT")
		rescanBtn.Text = (State.Language == "EN") and "⚡ Rescan Menu" or "⚡ Quét lại Menu"

		-- Nút ngôn ngữ: màu Hổ Phách Figgy dịu mắt khi chọn
		btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_AMBER or Color3.fromRGB(34, 34, 40)
		btnVI.BackgroundTransparency = (State.Language == "VI") and 0 or 1
		btnVI.TextColor3 = (State.Language == "VI") and TEXT_DARK_BTN or TEXT_SOFT_MUTED

		btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_AMBER or Color3.fromRGB(34, 34, 40)
		btnEN.BackgroundTransparency = (State.Language == "EN") and 0 or 1
		btnEN.TextColor3 = (State.Language == "EN") and TEXT_DARK_BTN or TEXT_SOFT_MUTED

		-- Tự co giãn chiều rộng viên thuốc mượt mà theo độ dài trạng thái
		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(168, math.min(290, 78 + textLen * 7))
		TweenService:Create(
			pillFrame,
			TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
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
			noteToggleBtn.Text = "Thông tin Figgy Island (Bấm thu gọn) ▲"
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, EXP_W, 0, OPEN_NOTE_EXP_H)
			}):Play()
		else
			noteToggleBtn.Text = "Thông tin Figgy Island (Bấm xem) ▼"
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
-- 6. BÊ NGUYÊN HÌNH ẢNH & TRẠNG THÁI TỪ HEADER FIGGY HUB VÀO DYNAMIC ISLAND
-- ============================================================================
-- Hàm tìm và bê thanh trạng thái trên header Figgy Hub
local function bindFiggyHeaderStatusWidget(header)
	if not header or not header:IsA("GuiObject") then return end
	if header:GetAttribute("__FiggyStatusWidgetHooked") == SID then return end

	for _, desc in ipairs(header:GetDescendants()) do
		if (desc:IsA("Frame") or desc:IsA("GuiObject")) and not desc:FindFirstChildWhichIsA("TextBox") and not desc:IsA("TextBox") then
			local img = desc:FindFirstChildWhichIsA("ImageLabel")
			local txt = desc:FindFirstChildWhichIsA("TextLabel")
			if img and txt and txt.Text ~= "Figgy Hub" and txt.Text ~= "FrostyFig" and not txt.Text:find("^v%d+%.%d+") then
				header:SetAttribute("__FiggyStatusWidgetHooked", SID)

				-- Hàm cập nhật trạng thái ngay lập tức khi Figgy Hub thay đổi
				local function syncFromFiggyBadge()
					if not isAlive() then return end
					local rawText = txt.Text or ""
					local rawImg = img.Image or ""
					local rawCol = img.ImageColor3 or Color3.fromRGB(255, 255, 255)

					if rawText ~= "" then
						State.CurrentRawStatus = rawText
					end
					if rawImg ~= "" then
						State.CurrentStatusImage = rawImg
						State.CurrentStatusImageColor = rawCol
					end

					if State.UpdateIslandVisuals then
						pcall(State.UpdateIslandVisuals)
					end
				end

				-- Ẩn widget gốc trên header của Figgy Hub để chuyển hẳn lên Dynamic Island
				pcall(function()
					desc.Visible = false
				end)
				desc:GetPropertyChangedSignal("Visible"):Connect(function()
					if isAlive() and desc.Visible then
						pcall(function() desc.Visible = false end)
					end
				end)

				-- Bắt sự kiện thay đổi văn bản và hình ảnh theo thời gian thực
				txt:GetPropertyChangedSignal("Text"):Connect(syncFromFiggyBadge)
				img:GetPropertyChangedSignal("Image"):Connect(syncFromFiggyBadge)
				img:GetPropertyChangedSignal("ImageColor3"):Connect(syncFromFiggyBadge)

				-- Đồng bộ lần đầu tiên ngay khi phát hiện
				syncFromFiggyBadge()

				-- Lưu tham chiếu để kiểm tra nhanh trong vòng lặp Heartbeat
				State.LiveFiggyTextLabel = txt
				State.LiveFiggyImageLabel = img
				State.LiveFiggyBadgeFrame = desc
				return true
			end
		end
	end
	return false
end

-- ============================================================================
-- 7. GẮN ÂM THANH CHO MỌI NÚT BẤM & TAB TRONG MENU FIGGY HUB
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

-- ============================================================================
-- 8. ĐỘNG CƠ DỊCH THUẬT MENU FIGGY HUB (ZERO-LAG)
-- ============================================================================
local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	if obj:IsA("TextButton") or obj:IsA("ImageButton") or obj:IsA("Frame") then
		pcall(hookMenuButtonSound, obj)
	end

	-- Tìm kiếm và bê thanh trạng thái trên header khi phát hiện tiêu đề "Figgy Hub"
	if obj:IsA("TextLabel") and (obj.Text == "Figgy Hub" or obj.Text == "FrostyFig") then
		local header = obj.Parent
		if header then
			pcall(bindFiggyHeaderStatusWidget, header)
			if header.Parent then
				pcall(bindFiggyHeaderStatusWidget, header.Parent)
			end
		end
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

	if EXACT_VI[curText] and State.Language == "VI" then
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
end
State.RefreshAllMenus = refreshAllTranslatedMenus

local function scanAllMenusOnce(forceSweep)
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local okName, gName = pcall(function() return gui.Name end)
				if okName and not IGNORED_SCREEN_GUIS[gName] and gName ~= "Old_ChilliDynamicIsland" and isFiggyTargetGui(gui) then
					if gui:GetAttribute("__FiggyGuiHooked") ~= SID then
						gui:SetAttribute("__FiggyGuiHooked", SID)
						gui.DescendantAdded:Connect(function(desc)
							if not isAlive() then return end
							if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") or desc:IsA("ImageButton") or desc:IsA("Frame") then
								task.defer(function()
									if isAlive() and desc and desc.Parent then
										pcall(processGuiElement, desc)
									end
								end)
							end
						end)
					end

					local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
					if okDesc and type(descendants) == "table" then
						local processedCount = 0
						for _, d in ipairs(descendants) do
							if forceSweep or d:GetAttribute("__FiggyTextWatched") ~= SID then
								if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") or d:IsA("ImageButton") or d:IsA("Frame") then
									pcall(processGuiElement, d)
									processedCount = processedCount + 1
									if processedCount % 220 == 0 then
										task.wait()
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

-- ============================================================================
-- 9. KHỞI CHẠY DYNAMIC ISLAND & VÒNG LẶP KIỂM TRA TRẠNG THÁI LIÊN TỤC
-- ============================================================================
createIndependentFiggyDynamicIsland()

task.spawn(function()
	scanAllMenusOnce(true)

	local lastCheckedStatus = ""
	local lastCheckedImage = ""

	while isAlive() do
		task.wait(0.25)
		if not isAlive() then break end

		-- Kiểm tra trực tiếp widget trạng thái từ Figgy Hub để cập nhật ngay lập tức nếu có thay đổi
		if State.LiveFiggyTextLabel and State.LiveFiggyTextLabel.Parent then
			local curTxt = State.LiveFiggyTextLabel.Text or ""
			local curImg = (State.LiveFiggyImageLabel and State.LiveFiggyImageLabel.Image) or ""
			local curCol = (State.LiveFiggyImageLabel and State.LiveFiggyImageLabel.ImageColor3) or Color3.fromRGB(255, 255, 255)

			if curTxt ~= lastCheckedStatus or curImg ~= lastCheckedImage then
				lastCheckedStatus = curTxt
				lastCheckedImage = curImg
				State.CurrentRawStatus = curTxt
				State.CurrentStatusImage = curImg
				State.CurrentStatusImageColor = curCol
				if State.UpdateIslandVisuals then
					pcall(State.UpdateIslandVisuals)
				end
			end

			-- Đảm bảo widget gốc trên header luôn được ẩn đi
			if State.LiveFiggyBadgeFrame and State.LiveFiggyBadgeFrame.Visible then
				pcall(function() State.LiveFiggyBadgeFrame.Visible = false end)
			end
		end

		scanAllMenusOnce(false)
	end
end)
