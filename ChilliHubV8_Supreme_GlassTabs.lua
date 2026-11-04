-- ============================================================================
-- FIGGY HUB V1.0.6+ | BẢN VIỆT HÓA TOÀN DIỆN & CHILLI DYNAMIC ISLAND LIQUID GLASS
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- Hiệu ứng Liquid Glass trong suốt mờ ảo cả bên ngoài viên thuốc lẫn bên trong bảng mở rộng
-- Âm thanh tương tác iOS Glass khi bấm mọi nút trên Menu Figgy Hub & Dynamic Island (Zero-Lag)
-- ============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	pcall(function()
		LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	end)
	LocalPlayer = Players.LocalPlayer
end

-- Quản lý trạng thái phiên chạy (chống trùng lặp khi chạy đè script)
local env = (getgenv and getgenv()) or _G
env.__FiggyChilliIslandState = env.__FiggyChilliIslandState or {}
local State = env.__FiggyChilliIslandState
State.SessionId = (State.SessionId or 0) + 1
local SID = State.SessionId
State.Language = State.Language or "VI" -- "VI" hoặc "EN"
State.CurrentRawStatus = State.CurrentRawStatus or "Idle"
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
-- 1. HỆ THỐNG ÂM THANH TƯƠNG TÁC (MENU & DYNAMIC ISLAND - ZERO LATENCY)
-- ============================================================================
local SOUND_CONFIG = {
	open   = { id = "rbxassetid://6895079853", vol = 0.78, spd = 1.06 }, -- Mở Dynamic Island
	close  = { id = "rbxassetid://6895079853", vol = 0.58, spd = 0.86 }, -- Đóng Dynamic Island
	tap    = { id = "rbxassetid://6026984224", vol = 0.72, spd = 1.14 }, -- Bấm nút Menu & Dynamic Island
	action = { id = "rbxassetid://4590662766", vol = 0.75, spd = 1.08 }, -- Chuyển ngôn ngữ / Trạng thái
}

local function getCachedSound(kind)
	local key = kind or "tap"
	local cfg = SOUND_CONFIG[key] or SOUND_CONFIG.tap
	local snd = State.CachedSounds[key]
	if not (snd and snd.Parent) then
		snd = Instance.new("Sound")
		snd.Name = "ChilliLiquidGlassSfx_" .. key
		snd.SoundId = cfg.id
		snd.Volume = cfg.vol
		snd.PlaybackSpeed = cfg.spd
		snd.Parent = SoundService
		State.CachedSounds[key] = snd
	end
	return snd
end

-- Nạp sẵn âm thanh vào SoundService
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
-- 2. HẰNG SỐ GIAO DIỆN LIQUID GLASS & TỰ ĐỘNG NẠP FIGGY HUB GỐC
-- ============================================================================
local FIGGY_LOADER_URL   = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"
local CHILLI_PEPPER_LOGO = "rbxassetid://74441610995894" -- Logo quả ớt chuẩn Chilli Hub
local DOWN_ARROW_ICON    = "rbxassetid://6031091004"     -- Icon mũi tên trỏ xuống

local IGNORED_SCREEN_GUIS = {
	ChilliDynamicIsland = true,
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

local function isFiggyHubAlreadyLoaded()
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local okN, gName = pcall(function() return gui.Name end)
				if okN and not IGNORED_SCREEN_GUIS[gName] then
					local okD, desc = pcall(function() return gui:GetDescendants() end)
					if okD and type(desc) == "table" then
						for _, d in ipairs(desc) do
							if d:IsA("TextLabel") or d:IsA("TextButton") then
								local t = (d.Text or ""):lower()
								if t:find("figgy hub", 1, true) or t:find("frostyfig", 1, true) or t:find("ufo sightings", 1, true) or t:find("equip best", 1, true) then
									return true
								end
							end
						end
					end
				end
			end
		end
	end
	return false
end

task.spawn(function()
	if not isFiggyHubAlreadyLoaded() then
		pcall(function()
			loadstring(game:HttpGet(FIGGY_LOADER_URL))()
		end)
	end
end)

-- ============================================================================
-- 3. BỘ TỪ ĐIỂN & ĐỘNG CƠ VIỆT HÓA 100% MENU FIGGY HUB V1.0.6+ (ZERO-LAG)
-- ============================================================================
local EXACT_VI = {
	-- Sửa lại các câu lỡ dịch dở từ phiên trước (nếu đang mở sẵn trên màn hình)
	["Tự động Equip Best thú cưng"] = "Tự động trang bị thú cưng mạnh nhất",
	["Tự động equip best thú cưng"] = "Tự động trang bị thú cưng mạnh nhất",

	-- Tiêu đề & Thanh trạng thái Figgy Hub
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

	-- Các Tab Menu Chính (Sidebar Figgy Hub)
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

	-- Tab Quản Lý (Manage) & Các Sub-tab trong ảnh 7909.jpg
	["Inventory"] = "Túi Đồ",
	["INVENTORY"] = "TÚI ĐỒ",
	["Place & Hatch"] = "Đặt & Ấp Trứng",
	["PLACE & HATCH"] = "ĐẶT & ẤP TRỨNG",
	["Upgrades"] = "Nâng Cấp",
	["UPGRADES"] = "NÂNG CẤP",
	["Crafting"] = "Chế Tạo",
	["CRAFTING"] = "CHẾ TẠO",

	-- Khung EQUIP BEST (Trong ảnh 7909.jpg)
	["EQUIP BEST"] = "TRANG BỊ MẠNH NHẤT",
	["Equip Best"] = "Trang Bị Mạnh Nhất",
	["Equip best"] = "Trang bị mạnh nhất",
	["PETS"] = "THÚ CƯNG",
	["Pets"] = "Thú Cưng",
	["EQUIPPED"] = "ĐANG TRANG BỊ",
	["Equipped"] = "Đang Trang Bị",
	["Auto Equip Best Pets"] = "Tự động trang bị thú cưng mạnh nhất",
	["Auto equip best pets"] = "Tự động trang bị thú cưng mạnh nhất",
	["Equip best pets"] = "Trang bị thú cưng mạnh nhất",
	["Equip Best Pets"] = "Trang Bị Thú Cưng Mạnh Nhất",
	["Open Pet Bag"] = "Mở Túi Thú Cưng",
	["Open Egg Bag"] = "Mở Túi Trứng",
	["Open"] = "Mở",
	["OPEN"] = "MỞ",
	["Close"] = "Đóng",
	["CLOSE"] = "ĐÓNG",

	-- Khung AUTO FAVORITE (Trong ảnh 7909.jpg)
	["AUTO FAVORITE"] = "TỰ ĐỘNG KHÓA YÊU THÍCH",
	["Auto Favorite"] = "Tự động khóa yêu thích",
	["Auto favorite"] = "Tự động khóa yêu thích",
	["FAVORITED"] = "ĐÃ YÊU THÍCH",
	["Favorited"] = "Đã Yêu Thích",
	["UNFAVORITED"] = "CHƯA YÊU THÍCH",
	["Unfavorited"] = "Chưa Yêu Thích",
	["Categories"] = "Danh mục",
	["CATEGORIES"] = "DANH MỤC",
	["Category"] = "Danh mục",
	["Rarities"] = "Độ hiếm",
	["RARITIES"] = "ĐỘ HIẾM",
	["Rarity"] = "Độ hiếm",
	["RARITY"] = "ĐỘ HIẾM",
	["Mutations"] = "Đột biến",
	["MUTATIONS"] = "ĐỘT BIẾN",
	["Mutation"] = "Đột biến",
	["MUTATION"] = "ĐỘT BIẾN",
	["None"] = "Không có",
	["NONE"] = "KHÔNG CÓ",
	["No selection"] = "Chưa chọn",
	["No Selection"] = "Chưa chọn",
	["NO SELECTION"] = "CHƯA CHỌN",
	["All"] = "Tất cả",
	["ALL"] = "TẤT CẢ",
	["Any"] = "Bất kỳ",
	["ANY"] = "BẤT KỲ",
	["Off"] = "Tắt",
	["OFF"] = "TẮT",
	["On"] = "Bật",
	["ON"] = "BẬT",

	-- Khung SELL EGGS & SELL PETS (Trong ảnh 7909.jpg)
	["SELL EGGS"] = "BÁN TRỨNG",
	["Sell Eggs"] = "Bán Trứng",
	["Sell eggs"] = "Bán trứng",
	["SELL PETS"] = "BÁN THÚ CƯNG",
	["Sell Pets"] = "Bán Thú Cưng",
	["Sell pets"] = "Bán thú cưng",
	["EGG BAG"] = "TÚI TRỨNG",
	["Egg Bag"] = "Túi Trứng",
	["PET BAG"] = "TÚI THÚ CƯNG",
	["Pet Bag"] = "Túi Thú Cưng",
	["SPACE LEFT"] = "CHỖ TRỐNG",
	["Space Left"] = "Chỗ Trống",
	["Space left"] = "Chỗ trống",
	["Egg Names"] = "Tên trứng",
	["EGG NAMES"] = "TÊN TRỨNG",
	["Pet Names"] = "Tên thú cưng",
	["PET NAMES"] = "TÊN THÚ CƯNG",
	["Egg Rarities"] = "Độ hiếm trứng",
	["EGG RARITIES"] = "ĐỘ HIẾM TRỨNG",
	["Pet Rarities"] = "Độ hiếm thú cưng",
	["PET RARITIES"] = "ĐỘ HIẾM THÚ CƯNG",
	["Egg Mutations"] = "Đột biến trứng",
	["Pet Mutations"] = "Đột biến thú cưng",
	["Min $/s"] = "Tối thiểu $/giây",
	["Max $/s"] = "Tối đa $/giây",
	["Min Value"] = "Giá trị tối thiểu",
	["Max Value"] = "Giá trị tối đa",
	["Min value /s"] = "Giá trị tối thiểu /giây",
	["Max value /s"] = "Giá trị tối đa /giây",
	["Auto Sell Eggs"] = "Tự động bán trứng",
	["Auto sell eggs"] = "Tự động bán trứng",
	["Auto Sell Pets"] = "Tự động bán thú cưng",
	["Auto sell pets"] = "Tự động bán thú cưng",
	["Sell Rule"] = "Quy tắc bán",
	["SELL RULE"] = "QUY TẮC BÁN",
	["Match All"] = "Khớp tất cả",
	["MATCH ALL"] = "KHỚP TẤT CẢ",
	["Match Any"] = "Khớp bất kỳ",
	["MATCH ANY"] = "KHỚP BẤT KỲ",
	["All picked rules"] = "Khớp tất cả quy tắc",
	["Any picked rule"] = "Khớp bất kỳ quy tắc",
	["Maximum Rarity"] = "Độ hiếm tối đa",
	["MAXIMUM RARITY"] = "ĐỘ HIẾM TỐI ĐA",
	["Minimum Rarity"] = "Độ hiếm tối thiểu",
	["MINIMUM RARITY"] = "ĐỘ HIẾM TỐI THIỂU",
	["Keep Mutated Eggs"] = "Giữ lại trứng đột biến",
	["Keep mutated eggs"] = "Giữ lại trứng đột biến",
	["Keep Mutated Pets"] = "Giữ lại thú cưng đột biến",
	["Keep mutated pets"] = "Giữ lại thú cưng đột biến",
	["Keep Mutated"] = "Giữ lại cá thể đột biến",
	["Keep mutated"] = "Giữ lại cá thể đột biến",
	["Keep Equipped"] = "Giữ lại thú đang đeo",
	["Keep Favorited"] = "Giữ lại mục yêu thích",
	["Never Sell Species"] = "Không bán các loài này",
	["Never sell species"] = "Không bán các loài này",
	["Never Sell Eggs"] = "Không bán các trứng này",
	["Never sell eggs"] = "Không bán các trứng này",
	["Never Sell Pets"] = "Không bán các thú này",
	["Never sell pets"] = "Không bán các thú này",
	["Never Sell Mutations"] = "Không bán các đột biến này",
	["Never sell"] = "Không bao giờ bán",
	["Never Sell"] = "Không bao giờ bán",
	["Sell All Eggs"] = "Bán hết trứng ngay",
	["Sell All Pets"] = "Bán hết thú cưng ngay",
	["Sell all eggs now"] = "Bán hết trứng ngay",
	["Sell all pets now"] = "Bán hết thú cưng ngay",
	["Sell Now"] = "Bán ngay",
	["Sell On Inventory Full"] = "Chỉ bán khi đầy túi",

	-- Các Sub-tab Đặt & Ấp Trứng (Place & Hatch), Nâng Cấp (Upgrades), Chế Tạo (Crafting)
	["PLACE EGGS"] = "ĐẶT TRỨNG VÀO CHUỒNG",
	["Place Eggs"] = "Đặt Trứng Vào Chuồng",
	["Place Egg"] = "Đặt Trứng Vào Chuồng",
	["HATCH EGGS"] = "ẤP TRỨNG TRONG CHUỒNG",
	["Hatch Eggs"] = "Ấp Trứng Trong Chuồng",
	["Hatch Egg"] = "Ấp Trứng Trong Chuồng",
	["PEN STATUS"] = "TRẠNG THÁI CHUỒNG ẤP",
	["Pen Status"] = "Trạng Thái Chuồng Ấp",
	["PLACED EGGS"] = "TRỨNG ĐANG ĐẶT",
	["READY TO HATCH"] = "SẴN SÀNG ẤP",
	["EMPTY SLOTS"] = "Ô CHUỒNG TRỐNG",
	["Auto Place Eggs"] = "Tự động đặt trứng",
	["Auto Place Egg"] = "Tự động đặt trứng",
	["Auto place"] = "Tự động đặt trứng",
	["Auto Hatch Eggs"] = "Tự động ấp trứng",
	["Auto Hatch Egg"] = "Tự động ấp trứng",
	["Auto hatch"] = "Tự động ấp trứng",
	["Place Priority"] = "Ưu tiên đặt trứng",
	["Hatch Priority"] = "Ưu tiên ấp trứng",
	["Place first"] = "Ưu tiên đặt trước",
	["Place when"] = "Đặt trứng khi",
	["Always"] = "Luôn luôn",
	["Stop At Rarity"] = "Dừng lại ở độ hiếm",
	["Place Missing Index Only"] = "Chỉ đặt trứng thiếu trong Mục lục",
	["Hatch Missing Index Only"] = "Chỉ ấp trứng thiếu trong Mục lục",
	["Auto Place Indexing"] = "Tự động đặt lấy Mục lục",
	["Auto Hatch Indexing"] = "Tự động ấp lấy Mục lục",
	["Whitelist"] = "Danh sách ưu tiên (Whitelist)",
	["Blacklist"] = "Danh sách chặn (Blacklist)",
	["Whitelist Rarity"] = "Ưu tiên độ hiếm",
	["Whitelist Pet"] = "Ưu tiên thú cưng",
	["Whitelist Mutation"] = "Ưu tiên đột biến",
	["Blacklist Rarity"] = "Bỏ qua độ hiếm",
	["Blacklist Pet"] = "Bỏ qua thú cưng",
	["Blacklist Mutation"] = "Bỏ qua đột biến",
	["KEEP EGGS"] = "GIỮ LẠI TRỨNG",
	["Keep eggs"] = "Giữ lại trứng",
	["Eggs to keep"] = "Danh sách trứng giữ lại",
	["Keep Above"] = "Giữ lại trên mức",

	["TREADMILL"] = "MÁY TẬP CHẠY BỘ",
	["Treadmill"] = "Máy Tập Chạy Bộ",
	["BASE UPGRADES"] = "NÂNG CẤP CĂN CỨ",
	["Base Upgrades"] = "Nâng Cấp Căn Cứ",
	["INDEX & REWARDS"] = "MỤC LỤC & PHẦN THƯỞNG",
	["Index & Rewards"] = "Mục Lục & Phần Thưởng",
	["TRAILS"] = "VỆT SÁNG (TRAILS)",
	["Trails"] = "Vệt Sáng",
	["Auto Treadmill"] = "Tự động chạy máy tập",
	["Auto treadmill"] = "Tự động chạy máy tập",
	["Auto Upgrade Treadmill"] = "Tự nâng cấp máy tập",
	["Auto upgrade treadmill"] = "Tự nâng cấp máy tập",
	["Auto Upgrade Base"] = "Tự nâng cấp căn cứ",
	["Auto upgrade base"] = "Tự nâng cấp căn cứ",
	["Auto Claim Offline Cash"] = "Tự nhận tiền ngoại tuyến",
	["Auto claim offline cash"] = "Tự nhận tiền ngoại tuyến",
	["Auto Claim Index"] = "Tự nhận thưởng Mục lục",
	["Auto Claim Index Rewards"] = "Tự nhận thưởng Mục lục",
	["Auto claim index rewards"] = "Tự nhận thưởng Mục lục",
	["Auto Claim Mastery"] = "Tự động nhận thưởng Thông Thạo",
	["Auto claim mastery"] = "Tự động nhận thưởng Thông Thạo",
	["Claim mastery"] = "Nhận thưởng Thông Thạo",
	["Mastery"] = "Thông Thạo",
	["MASTERY"] = "THÔNG THẠO",
	["Auto Buy Trails"] = "Tự động mua vệt sáng",
	["Auto buy trails"] = "Tự động mua vệt sáng",

	["FUSE MACHINE"] = "MÁY DUNG HỢP",
	["Fuse Machine"] = "Máy Dung Hợp",
	["Fuse machine"] = "Máy dung hợp",
	["FUSE PETS"] = "DUNG HỢP THÚ CƯNG",
	["Fuse Pets"] = "Dung Hợp Thú Cưng",
	["FUSE FILTER"] = "BỘ LỌC DUNG HỢP",
	["Fuse filter"] = "Bộ lọc dung hợp",
	["FUSE PREDICTOR"] = "DỰ ĐOÁN DUNG HỢP",
	["Auto Fuse"] = "Tự động dung hợp",
	["Auto fuse"] = "Tự động dung hợp",
	["Auto Fuse Pets"] = "Tự động dung hợp thú cưng",
	["Fuse first"] = "Ưu tiên dung hợp",
	["Fuse Priority"] = "Ưu tiên dung hợp",
	["Use pets"] = "Sử dụng thú cưng",
	["Never fuse"] = "Không bao giờ dung hợp",
	["Never Fuse"] = "Không bao giờ dung hợp",
	["Skip mutated"] = "Bỏ qua cá thể đột biến",
	["Skip Mutated"] = "Bỏ qua cá thể đột biến",
	["Skip Mutated Pets"] = "Bỏ qua thú đã đột biến",
	["Eject odd pets"] = "Đẩy thú lẻ ra ngoài",
	["Eject Odd Pets"] = "Đẩy thú lẻ ra ngoài",
	["MUTATE EGGS"] = "ĐỘT BIẾN TRỨNG",
	["Mutate Eggs"] = "Đột Biến Trứng",
	["MUTATION MACHINE"] = "MÁY ĐỘT BIẾN",
	["Mutation Machine"] = "Máy Đột Biến",
	["AUTO MUTATE"] = "TỰ ĐỘNG ĐỘT BIẾN",
	["Auto Mutate"] = "Tự động đột biến",
	["Auto mutate"] = "Tự động đột biến",
	["Auto Mutate Eggs"] = "Tự động đột biến trứng",
	["MUTATE FILTER"] = "BỘ LỌC ĐỘT BIẾN",
	["Mutate filter"] = "Bộ lọc đột biến",
	["Mutate first"] = "Ưu tiên đột biến",
	["Mutate Priority"] = "Ưu tiên đột biến",
	["Use items"] = "Sử dụng vật phẩm",
	["Mutation Items"] = "Vật phẩm đột biến",
	["Target Mutations"] = "Đột biến mục tiêu",
	["Skip eggs with"] = "Bỏ qua trứng đã có",
	["Auto buy Nitro"] = "Tự động mua Nitro",
	["Auto Buy Nitro"] = "Tự động mua Nitro",

	-- Mục UFO / SEASONAL / BUTTERFLY / THE HOLLOW / AA (Chuẩn theo ảnh 7901.jpg)
	["UFO"] = "UFO (Đĩa Bay)",
	["UFO SIGHTINGS"] = "PHÁT HIỆN UFO",
	["UFO Sightings"] = "Phát Hiện UFO",
	["Auto UFO"] = "Tự động săn UFO",
	["Collect UFO Debris"] = "Thu thập mảnh vỡ UFO",
	["Farm Rare UFO"] = "Cày UFO hiếm",
	["Auto Trade Debris"] = "Tự động đổi mảnh vỡ",
	["Teleport If Far From Egg"] = "Dịch chuyển nếu ở xa trứng",
	["UFO STATUS"] = "TRẠNG THÁI UFO",
	["UFO Status"] = "Trạng Thái UFO",
	["EGGS"] = "TRỨNG",
	["DEBRIS"] = "MẢNH VỠ",
	["Debris"] = "Mảnh Vỡ",
	["SEASONAL"] = "SỰ KIỆN THEO MÙA",
	["Seasonal"] = "Sự Kiện Theo Mùa",
	["AA"] = "SỰ KIỆN ADMIN (AA)",
	["Admin Abuse"] = "Sự Kiện Admin (AA)",
	["ADMIN ABUSE"] = "SỰ KIỆN ADMIN (AA)",
	["BUTTERFLY EVENT"] = "SỰ KIỆN BƯỚM",
	["Butterfly Event"] = "Sự Kiện Bướm",
	["Butterfly"] = "Sự Kiện Bướm",
	["BUTTERFLY"] = "SỰ KIỆN BƯỚM",
	["BUTTERFLY BLOOM"] = "MÙA BƯỚM NỞ",
	["Butterfly bloom"] = "Mùa bướm nở",
	["ESSENCE"] = "TINH CHẤT",
	["Essence"] = "Tinh Chất",
	["CAUGHT"] = "ĐÃ BẮT",
	["Caught"] = "Đã Bắt",
	["NET"] = "VỢT BẮT",
	["Net"] = "Vợt Bắt",
	["THE HOLLOW"] = "VỰC HOLLOW",
	["The Hollow"] = "Vực Hollow",
	["Hollow"] = "Vực Hollow",
	["STATUS"] = "TRẠNG THÁI",
	["Status"] = "Trạng Thái",
	["WINS"] = "SỐ TRẬN THẮNG",
	["Wins"] = "Số Trận Thắng",
	["TROPHIES"] = "CÚP",
	["SOULS"] = "LINH HỒN",
	["CANDY CORN"] = "KẸO NGÔ",
	["Candy Corn"] = "Kẹo Ngô",
	["KILLS"] = "SỐ LẦN HẠ",
	["Kills"] = "Số Lần Hạ",
	["BOSS"] = "TRÙM (BOSS)",
	["ALIVE"] = "CÒN SỐNG",
	["DEAD"] = "ĐÃ HẠ",
	["SPAWNED"] = "ĐÃ XUẤT HIỆN",
	["NOT SPAWNED"] = "CHƯA XUẤT HIỆN",

	-- Bảng Tác Vụ Nhanh Bên Phải (Quick Steal / Shortcuts)
	["STEAL"] = "CƯỚP NGAY",
	["Guard: OFF"] = "Bảo vệ: TẮT",
	["Guard: ON"] = "Bảo vệ: BẬT",
	["Shortcut 1"] = "Phím Tắt 1",
	["Shortcut 2"] = "Phím Tắt 2",
	["Shortcut 3"] = "Phím Tắt 3",
	["Rare"] = "Hiếm",
	["Rare+"] = "Hiếm+",
	["Common"] = "Phổ Thông",
	["Uncommon"] = "Thường",
	["Epic"] = "Sử Thi",
	["Legendary"] = "Huyền Thoại",
	["Mythic"] = "Thần Thoại",
	["Secret"] = "Bí Ẩn",
	["Cosmic"] = "Vũ Trụ",
	["Eternal"] = "Vĩnh Cửu",
	["Divine"] = "Thánh Thần",
	["Celestial"] = "Thiên Giới",
	["Golden"] = "Hoàng Kim",
	["Silver"] = "Bạc",
	["Rainbow"] = "Cầu Vồng",
	["Diamond"] = "Kim Cương",
	["Radiant"] = "Rực Rỡ",
	["Amethyst"] = "Thạch Anh Tím",
	["Sapphire"] = "Lam Ngọc",
	["Emerald"] = "Ngọc Lục Bảo",
	["Fractured"] = "Rạn Nứt",
	["Scrambled"] = "Hỗn Loạn",
	["Enchanted"] = "Phù Phép",
	["Nitro"] = "Nitro",
	["Spectral"] = "Quang Phổ",

	-- Các mục trong Tab Trang Chủ / Trứng / Sự Kiện / Nhân Vật / Hiển Thị / Cài Đặt
	["Welcome Home"] = "Trang Chủ",
	["Welcome back"] = "Chào mừng trở lại",
	["SESSION"] = "PHIÊN CHƠI",
	["STOLEN"] = "ĐÃ CƯỚP",
	["LAST EGG"] = "TRỨNG CUỐI",
	["PLACED"] = "ĐÃ ĐẶT",
	["HATCHED"] = "ĐÃ ẤP",
	["NIGHT IN"] = "ĐÊM SAU",
	["NEXT NIGHT"] = "ĐÊM SAU",
	["SESSION TIME"] = "THỜI GIAN",
	["TIME"] = "THỜI GIAN",
	["BEST STEAL"] = "CƯỚP TỐT NHẤT",
	["WHAT'S NEW"] = "CÓ GÌ MỚI",
	["MONEY /S"] = "TIỀN /GIÂY",
	["CASH / S"] = "TIỀN / GIÂY",
	["Player Stats"] = "Thống Kê Người Chơi",
	["Money"] = "Tiền",
	["Gems"] = "Đá Quý",
	["Gain"] = "Tăng Tốc Độ",
	["Inventory values"] = "Giá trị túi đồ",
	["Inventory Values"] = "Giá trị túi đồ",
	["Egg Inventory Value"] = "Giá Trị Trứng Trong Túi",

	["Auto Steal"] = "Tự động cướp trứng",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["Auto steal"] = "Tự động cướp trứng",
	["Steal Egg"] = "Cướp Trứng",
	["Steal egg"] = "Cướp trứng",
	["Instant Steal"] = "Cướp trứng tức thì",
	["Instant steal"] = "Cướp trứng tức thì",
	["Steal from other players"] = "Cướp trứng từ người chơi khác",
	["Steal From Player"] = "Cướp Từ Người Chơi",
	["Steal From Players"] = "Cướp Từ Người Chơi",
	["Steal back from players"] = "Cướp lại từ người chơi",
	["Steal Other Script"] = "Cướp Của Script Khác",
	["Drop eggs at safe zone"] = "Thả trứng tại vùng an toàn",
	["Drop for Friend"] = "Nhặt Hộ Bạn Bè",
	["Delivery method"] = "Phương thức giao trứng",
	["Delivery Mode"] = "Chế Độ Giao Trứng",
	["Steal Mode"] = "Chế Độ Cướp",
	["Steal Settings"] = "Cài Đặt Cướp",
	["STEAL SETTINGS"] = "CÀI ĐẶT CƯỚP TRỨNG",
	["STEAL FILTER"] = "BỘ LỌC CƯỚP TRỨNG",
	["Steal Status"] = "Trạng Thái Cướp",
	["Open Steal Panel"] = "Mở Bảng Cướp Trứng",
	["Open Steal History"] = "Mở Lịch Sử Cướp",
	["Egg Predictor"] = "Dự Đoán Trứng",
	["EGG PREDICTOR"] = "DỰ ĐOÁN TRỨNG",
	["Open Egg Predictor"] = "Mở Dự Đoán Trứng",
	["Egg Utilities"] = "Tiện Ích Trứng",
	["EGG SHOWCASE"] = "TRƯNG BÀY TRỨNG",
	["Sort eggs"] = "Sắp xếp trứng",
	["Preview card"] = "Thẻ xem trước",
	["Calculate mutations"] = "Tính thử đột biến",
	["Go to egg"] = "Di chuyển tới trứng",
	["Go to Egg Leap"] = "Nhảy Tới Trứng",
	["Teleport to egg"] = "Dịch chuyển tới trứng",
	["Walk to egg"] = "Đi bộ tới trứng",
	["Tween to egg"] = "Bay mượt tới trứng",
	["Fly to egg"] = "Bay tới trứng",
	["Hold egg"] = "Cầm trứng",
	["Instant steps"] = "Bước dịch chuyển tức thì",
	["Delivery speed"] = "Tốc độ giao trứng",
	["Fast tween speed"] = "Tốc độ bay nhanh",
	["Tween speed"] = "Tốc độ bay (Tween)",
	["Steal speed"] = "Tốc độ cướp",
	["Anti guard"] = "Chống vệ sĩ (Anti-Guard)",
	["Anti Guard"] = "Chống vệ sĩ (Anti-Guard)",
	["Skip friends"] = "Bỏ qua bạn bè",
	["Ignore Friends"] = "Bỏ qua bạn bè",
	["Filtering"] = "Bộ Lọc",
	["FILTER"] = "BỘ LỌC",
	["Strict Filter"] = "Lọc Nghiêm Ngặt",
	["Steal Priority"] = "Ưu Tiên Cướp",
	["Steal first"] = "Ưu tiên cướp trước",
	["Select Area"] = "Chọn Khu Vực",
	["Select Rarity"] = "Chọn Độ Hiếm",
	["Select Pet"] = "Chọn Thú Cưng",
	["Select Mutation"] = "Chọn Đột Biến",
	["Only these eggs"] = "Chỉ những trứng này",
	["Only these pets"] = "Chỉ những thú cưng này",
	["Only below /s"] = "Chỉ lấy dưới mức /giây",
	["Only sell eggs below /s"] = "Chỉ bán trứng dưới mức /giây",
	["Sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
	["Zones"] = "Khu vực",
	["Teleport zones"] = "Khu vực dịch chuyển",
	["Best value"] = "Giá trị cao nhất",
	["Lowest value"] = "Giá trị thấp nhất",
	["Best rarity"] = "Độ hiếm cao nhất",
	["Best mutation"] = "Đột biến tốt nhất",
	["Lowest rarity"] = "Độ hiếm thấp nhất",
	["Highest rarity"] = "Độ hiếm cao nhất",
	["Lowest value first"] = "Giá trị thấp nhất trước",
	["Highest value first"] = "Giá trị cao nhất trước",
	["Rarest"] = "Hiếm nhất",
	["Rarest first"] = "Ưu tiên hiếm nhất",
	["Biggest"] = "Kích thước lớn nhất",
	["Closest"] = "Khoảng cách gần nhất",
	["Nearest"] = "Gần nhất",

	["Indexing"] = "Mục Lục (Index)",
	["Auto Indexing"] = "Tự Động Thu Thập Mục Lục",
	["Steal missing index eggs"] = "Cướp trứng thiếu trong Mục lục",
	["Steal missing index"] = "Cướp trứng thiếu trong Mục lục",
	["Steal missing Halloween index"] = "Cướp trứng Halloween thiếu trong Mục lục",
	["Place eggs in pen and hatch missing in Egg Index"] = "Đặt trứng vào chuồng và ấp trứng thiếu trong Mục lục",

	["Priority"] = "Ưu Tiên",
	["PRIORITY"] = "THỨ TỰ ƯU TIÊN",
	["TASK ORDER"] = "THỨ TỰ TÁC VỤ",
	["Task order"] = "Thứ tự tác vụ",
	["Reset order"] = "Đặt lại thứ tự",
	["DOING"] = "ĐANG LÀM",
	["WAITING"] = "ĐANG CHỜ",

	["Auto butterfly bloom"] = "Tự động sự kiện Hoa Bướm",
	["BUTTERFLY MACHINE"] = "MÁY ĐỔI BƯỚM",
	["Butterfly machine"] = "Máy đổi Bướm",
	["Auto craft essence"] = "Tự động chế tạo Tinh Chất",
	["Smart trade for essence"] = "Đổi thông minh lấy Tinh Chất",
	["Auto trade up"] = "Tự động nâng bậc bướm",
	["Catch mode"] = "Chế độ bắt",
	["Catch priority"] = "Ưu tiên bắt",
	["Catch speed"] = "Tốc độ bắt",
	["Stand"] = "Đứng yên",
	["Chase"] = "Đuổi theo",
	["WISP COMPANION"] = "ĐỒNG HÀNH WISP",
	["Auto wisp quest"] = "Tự làm nhiệm vụ Wisp",
	["Auto banjo cricket"] = "Tự bắt dế Banjo",
	["SHOOTING STAR"] = "SAO BĂNG RƠI",
	["Shooting Star"] = "Sao Băng",
	["Auto catch shooting star"] = "Tự động bắt Sao Băng",
	["LANDS IN"] = "RƠI SAU",
	["EXPIRES IN"] = "BIẾN MẤT SAU",
	["HALLOWEEN DIMENSION"] = "KHÔNG GIAN HALLOWEEN",
	["Halloween Dimension"] = "Không Gian Halloween",
	["Auto steal Halloween eggs"] = "Tự động cướp trứng Halloween",
	["Instant steal Halloween eggs"] = "Cướp tức thì trứng Halloween",
	["Auto Pumpkin Moon"] = "Tự động sự kiện Trăng Bí Ngô",
	["Auto Pumpkin Boss"] = "Tự đánh Boss Bí Ngô",
	["Pumpkin Boss"] = "Boss Bí Ngô",
	["PUMPKIN BOSS"] = "BOSS BÍ NGÔ",
	["Auto dodge attacks"] = "Tự động né đòn đánh",
	["Stub pickup speed"] = "Tốc độ nhặt Cuống Bí Ngô",
	["Auto manor key"] = "Tự lấy chìa khóa dinh thự",
	["Manor key"] = "Chìa khóa dinh thự",
	["PHANTOM EXPRESS"] = "TÀU MA PHANTOM EXPRESS",
	["Auto Phantom Express"] = "Tự động Tàu Ma (Phantom Express)",
	["Auto vacuum Ghouler boss"] = "Tự hút trùm Ghouler",
	["Auto trade souls"] = "Tự động đổi Linh Hồn",
	["MONSTERS"] = "QUÁI VẬT",
	["Auto farm monsters"] = "Tự động đánh quái sự kiện",
	["GHOST DOG AND FISHING"] = "CHÓ MA VÀ CÂU CÁ",
	["Auto fishing"] = "Tự động câu cá",
	["Auto Ghost Dog quest"] = "Tự làm nhiệm vụ Chó Ma",
	["CAPTURE THE EGG"] = "CƯỚP TRỨNG SỰ KIỆN",
	["Auto capture event egg"] = "Tự chiếm trứng sự kiện",
	["Take it from the holder"] = "Giật trứng từ người đang cầm",
	["MINIGAME EGGS"] = "TRỨNG TRÒ CHƠI NHỎ",
	["Auto steal minigame egg"] = "Tự cướp trứng trò chơi nhỏ",
	["CURSED ISLAND WARS"] = "ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",
	["Cursed Island Wars"] = "Đại Chiến Đảo Nguyền Rủa",
	["Auto play Cursed Island Wars"] = "Tự chơi Đại Chiến Đảo Nguyền Rủa",
	["RACING EVENT"] = "SỰ KIỆN ĐUA XE",
	["Auto race"] = "Tự động đua xe",
	["Auto race Hollow"] = "Tự động đua sự kiện Hollow",

	["Move"] = "Di Chuyển",
	["MOVE"] = "DI CHUYỂN",
	["MOVEMENT"] = "TỐC ĐỘ & DI CHUYỂN",
	["Combat"] = "Chiến Đấu",
	["COMBAT"] = "CHIẾN ĐẤU",
	["PROTECTION"] = "BẢO VỆ NHÂN VẬT",
	["HIT AURA"] = "VÒNG SÁNG ĐÁNH TỰ ĐỘNG",
	["Hit aura"] = "Vòng sáng đánh tự động (Hit Aura)",
	["AUTO HIT"] = "TỰ ĐỘNG ĐÁNH",
	["Auto hit"] = "Tự động đánh người chơi",
	["Hit who"] = "Mục tiêu đánh",
	["Nearest player"] = "Người chơi gần nhất",
	["Chosen player"] = "Người chơi chỉ định",
	["Egg carrier"] = "Người đang ôm trứng",
	["Chase speed"] = "Tốc độ truy đuổi",
	["WEAPONS"] = "VŨ KHÍ",
	["Use weapons"] = "Sử dụng vũ khí",
	["Hold each"] = "Thời gian cầm mỗi món",
	["Boost speed"] = "Tốc độ tăng thêm",
	["Speed boost"] = "Bật tăng tốc chạy",
	["Walk speed"] = "Tốc độ di chuyển",
	["Infinite jump"] = "Nhảy vô hạn",
	["God mode"] = "Bất tử (God Mode)",
	["Anti ragdoll"] = "Chống ngã (Anti-Ragdoll)",
	["Anti AFK"] = "Chống treo máy (Anti-AFK)",
	["Ignore traps"] = "Bỏ qua bẫy",
	["Instant prompts"] = "Tương tác nút bấm tức thì",
	["Invisible"] = "Tàng hình",

	["FIELD EGGS"] = "TRỨNG NGOÀI SÂN",
	["OTHERS"] = "MỤC KHÁC",
	["Player ESP"] = "Định vị người chơi (ESP)",
	["Guard ESP"] = "Định vị lính gác (ESP)",
	["Egg ESP"] = "Định vị trứng ngoài bãi (ESP)",
	["Pen egg ESP"] = "Định vị trứng trong chuồng",
	["Other pens ESP"] = "Định vị chuồng người khác",
	["Hide sleeping guards"] = "Ẩn lính gác đang ngủ",
	["ESP size"] = "Kích thước chữ ESP",
	["Fixed size"] = "Cố định kích thước",

	["OPTIMIZER"] = "TỐI ƯU HÓA",
	["Optimizer"] = "Tối Ưu Hóa",
	["GRAPHICS"] = "ĐỒ HỌA",
	["Low graphics"] = "Đồ họa thấp (Giảm lag)",
	["Disable 3D Render"] = "Tắt kết xuất 3D (Treo máy)",
	["Hide my pets and eggs"] = "Ẩn thú cưng & trứng của tôi",
	["Hide other players' pets and eggs"] = "Ẩn thú cưng & trứng người khác",
	["Hide game UI"] = "Ẩn giao diện gốc của game",
	["FRAME RATE"] = "TỐC ĐỘ KHUNG HÌNH (FPS)",
	["Show FPS and ping"] = "Hiện FPS và Ping",
	["FPS cap"] = "Giới hạn FPS",
	["INTERFACE"] = "GIAO DIỆN",
	["Interface"] = "Giao Diện",
	["QUICK BARS"] = "THANH PHÍM TẮT NHANH",
	["Quick bars"] = "Thanh phím tắt nhanh",
	["Show quick bars"] = "Hiện thanh phím tắt nhanh",
	["Keybinds"] = "Phím tắt",
	["Bar size"] = "Kích cỡ thanh nhanh",
	["UI scale"] = "Tỷ lệ thu phóng menu",
	["Show / hide UI"] = "Phím ẩn / hiện Menu",
	["Opacity"] = "Độ trong suốt nền",
	["Tone"] = "Tông màu",
	["Dim the game"] = "Làm tối cảnh nền game",

	["AUTO HOP SERVER"] = "TỰ ĐỔI MÁY CHỦ",
	["SERVER HOP"] = "ĐỔI MÁY CHỦ",
	["Auto hop server"] = "Tự động đổi máy chủ",
	["Auto hop"] = "Tự động đổi máy chủ",
	["Server Hop (No Target)"] = "Đổi Server (Khi Hết Mục Tiêu)",
	["Hop server"] = "Đổi máy chủ",
	["Server hop"] = "Đổi máy chủ",
	["Hop now"] = "Đổi máy chủ ngay",
	["Hop to"] = "Đổi sang máy chủ",
	["Least players"] = "Ít người chơi nhất",
	["Most players"] = "Đông người chơi nhất",
	["Random"] = "Ngẫu nhiên",
	["Rejoin"] = "Vào lại phòng",
	["Rejoin this server"] = "Vào lại máy chủ này",
	["Rejoin on kick"] = "Tự vào lại khi bị văng",
	["Auto load script"] = "Tự nạp lại script khi đổi phòng",
	["Copy Job ID"] = "Chép mã phòng (Job ID)",
	["Unload hub"] = "Tắt Hub",
	["Save config"] = "Lưu cấu hình",
	["Load config"] = "Nạp cấu hình",
	["Reset to defaults"] = "Khôi phục mặc định",
	["Turn off all toggles"] = "Tắt toàn bộ công tắc",
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
	{ pat = "^[Nn]ext%s+UFO%s+in%s+(.+)$", rep = "UFO tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+event%s+in%s+(.+)$", rep = "Sự kiện tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+race%s+in%s+(.+)$", rep = "Cuộc đua tiếp theo sau %1" },
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
	{ pat = "^[Aa]uto%s+play%s+(.+)$", rep = "Tự động chơi %1" },
	{ pat = "^[Aa]uto%s+farm%s+(.+)$", rep = "Tự động cày %1" },
	{ pat = "^[Aa]uto%s+kill%s+(.+)$", rep = "Tự động tiêu diệt %1" },
	{ pat = "^[Aa]uto%s+catch%s+(.+)$", rep = "Tự động bắt %1" },
	{ pat = "^[Aa]uto%s+collect%s+(.+)$", rep = "Tự động thu thập %1" },
	{ pat = "^[Aa]uto%s+buy%s+(.+)$", rep = "Tự động mua %1" },
	{ pat = "^[Aa]uto%s+sell%s+(.+)$", rep = "Tự động bán %1" },
	{ pat = "^[Aa]uto%s+claim%s+(.+)$", rep = "Tự động nhận %1" },
	{ pat = "^[Aa]uto%s+upgrade%s+(.+)$", rep = "Tự động nâng cấp %1" },
	{ pat = "^[Aa]uto%s+craft%s+(.+)$", rep = "Tự động chế tạo %1" },
	{ pat = "^[Aa]uto%s+trade%s+(.+)$", rep = "Tự động đổi %1" },
	{ pat = "^[Aa]uto%s+equip%s+(.+)$", rep = "Tự động trang bị %1" },
	{ pat = "^[Aa]uto%s+steal%s+(.+)$", rep = "Tự động cướp %1" },
	{ pat = "^[Aa]uto%s+place%s+(.+)$", rep = "Tự động đặt %1" },
	{ pat = "^[Aa]uto%s+hatch%s+(.+)$", rep = "Tự động ấp %1" },
	{ pat = "^[Aa]uto%s+fuse%s+(.+)$", rep = "Tự động dung hợp %1" },
	{ pat = "^[Aa]uto%s+mutate%s+(.+)$", rep = "Tự động đột biến %1" },
	{ pat = "^[Ii]nstant%s+steal%s+(.+)$", rep = "Cướp tức thì %1" },
	{ pat = "^[Aa]uto%s+(.+)$", rep = "Tự động %1" },
	{ pat = "^[Cc]arrying%s+(.+)%s+to%s+(.+)$", rep = "Đang mang %1 tới %2" },
	{ pat = "^[Cc]arrying%s+(.+)$", rep = "Đang mang %1" },
	{ pat = "^[Dd]elivering%s+(.+)$", rep = "Đang giao %1" },
	{ pat = "^[Ss]tealing%s+(.+)$", rep = "Đang cướp %1" },
	{ pat = "^[Cc]ollecting%s+(.+)$", rep = "Đang thu thập %1" },
	{ pat = "^[Ff]arming%s+(.+)$", rep = "Đang cày %1" },
	{ pat = "^[Ww]aiting%s+for%s+(.+)$", rep = "Đang chờ %1" },
	{ pat = "^[Ss]earching%s+for%s+(.+)$", rep = "Đang tìm %1" },
	{ pat = "^(%d+)%s+selected$", rep = "Đã chọn %1 mục" },
	{ pat = "^(%d+)%s*/%s*(%d+)%s+selected$", rep = "Đã chọn %1/%2" },
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
	{ "keep mutated pets", "Giữ lại thú cưng đột biến" },
	{ "never sell species", "Không bán các loài này" },
	{ "never sell eggs", "Không bán các trứng này" },
	{ "never sell pets", "Không bán các thú này" },
	{ "no selection", "Chưa chọn" },
	{ "place & hatch", "Đặt & Ấp Trứng" },
	{ "ufo sightings", "Phát Hiện UFO" },
	{ "ufo status", "Trạng Thái UFO" },
	{ "collect ufo debris", "Thu thập mảnh vỡ UFO" },
	{ "farm rare ufo", "Cày UFO hiếm" },
	{ "auto trade debris", "Tự động đổi mảnh vỡ" },
	{ "teleport if far from egg", "Dịch chuyển nếu ở xa trứng" },
	{ "far from egg", "ở xa trứng" },
	{ "butterfly event", "Sự Kiện Bướm" },
	{ "the hollow", "Vực Hollow" },
	{ "cursed island wars", "Đại Chiến Đảo Nguyền Rủa" },
	{ "phantom express", "Tàu Ma Phantom Express" },
	{ "pumpkin moon", "Trăng Bí Ngô" },
	{ "halloween dimension", "Không Gian Halloween" },
	{ "shooting star", "Sao Băng" },
	{ "butterfly bloom", "Mùa Bướm Nở" },
	{ "safe zone", "vùng an toàn" },
	{ "other players", "người chơi khác" },
	{ "offline cash", "tiền ngoại tuyến" },
	{ "index rewards", "thưởng Mục lục" },
	{ "egg index", "Mục lục trứng" },
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
	rules = "quy tắc",
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
	collecting = "đang thu thập",
	trade = "đổi",
	trading = "đang đổi",
	teleport = "dịch chuyển",
	auto = "tự động",
	rare = "hiếm",
	idle = "Đang rảnh",
	running = "Đang chạy",
	waiting = "Đang chờ",
	guard = "bảo vệ",
	guards = "vệ sĩ",
	player = "người chơi",
	players = "người chơi",
	server = "máy chủ",
	speed = "tốc độ",
	value = "giá trị",
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
	-- Tách token có tính cả byte UTF-8 [\128-\255] để không bao giờ làm hỏng chữ Tiếng Việt có dấu
	out = out:gsub("([\128-\255%a']+)", function(w)
		if string.find(w, "[\128-\255]") then
			return w
		end
		local lw = string.lower(w)
		return WORDS_VI[lw] or LOWER_VI[lw] or w
	end)
	return out
end

local function hasTranslateableEnglishWord(str)
	for w in string.gmatch(str, "[%a']+") do
		local lw = string.lower(w)
		if WORDS_VI[lw] or LOWER_VI[lw] then
			return true
		end
	end
	return false
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

		if hasTranslateableEnglishWord(trimmed) then
			local rep = applyPhrasesAndWords(trimmed)
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
		local ufoTime = trimmed:match("^UFO%s+tiếp%s+theo%s+sau%s+(.+)$")
		if ufoTime then
			return lead .. "Next UFO in " .. ufoTime .. trail
		end
		local scNum = trimmed:match("^Phím%s+Tắt%s+(%d+)$") or trimmed:match("^THANH%s+NHANH%s+(%d+)$")
		if scNum then
			return lead .. "Shortcut " .. scNum .. trail
		end
		if trimmed == "Bảo vệ: TẮT" then return lead .. "Guard: OFF" .. trail end
		if trimmed == "Bảo vệ: BẬT" then return lead .. "Guard: ON" .. trail end
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
		return (enStr and enStr ~= "") and enStr or "Running"
	else
		if isIdle then return "Đang rảnh" end
		if low == "running" or low == "working" or low == "active" or low == "đang chạy" then
			return "Đang chạy"
		end
		local viStr = translateRawSegment(clean, "VI")
		if viStr and viStr ~= clean then
			return viStr
		end
		return "Đang chạy: " .. clean
	end
end

-- ============================================================================
-- 4. THIẾT KẾ CHILLI DYNAMIC ISLAND (HIỆU ỨNG LIQUID GLASS TRONG SUỐT MỜ ẢO
--    CẢ BÊN NGOÀI VIÊN THUỐC LẪN BÊN TRONG BẢNG ĐIỀU KHIỂN MỞ RỘNG)
-- ============================================================================
local function applyLiquidGlassSurface(frame, topTint, midTint, botTint, topAlpha, midAlpha, botAlpha, cornerRadius, strokeColor, strokeThickness)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or UDim.new(1, 0)
	corner.Parent = frame

	-- Lớp kính lỏng xuyên thấu (Liquid Glass Refraction Gradient với NumberSequence Transparency)
	local grad = frame:FindFirstChild("LiquidGlassGradient") or Instance.new("UIGradient")
	grad.Name = "LiquidGlassGradient"
	grad.Rotation = 90
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, topTint or Color3.fromRGB(48, 72, 115)),
		ColorSequenceKeypoint.new(0.35, midTint or Color3.fromRGB(18, 25, 44)),
		ColorSequenceKeypoint.new(0.75, midTint or Color3.fromRGB(14, 20, 36)),
		ColorSequenceKeypoint.new(1.00, botTint or Color3.fromRGB(36, 58, 98)),
	})
	grad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, topAlpha or 0.24),
		NumberSequenceKeypoint.new(0.45, midAlpha or 0.36),
		NumberSequenceKeypoint.new(0.80, midAlpha or 0.36),
		NumberSequenceKeypoint.new(1.00, botAlpha or 0.22),
	})
	grad.Parent = frame

	-- Dải phản quang mặt kính cong phía trên (Top Specular Highlight)
	local topShine = frame:FindFirstChild("LiquidGlassTopSpecular") or Instance.new("Frame")
	topShine.Name = "LiquidGlassTopSpecular"
	topShine.AnchorPoint = Vector2.new(0.5, 0)
	topShine.Position = UDim2.new(0.5, 0, 0, 1)
	topShine.Size = UDim2.new(1, -18, 0, 13)
	topShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
		NumberSequenceKeypoint.new(0.00, 0.62),
		NumberSequenceKeypoint.new(0.65, 0.88),
		NumberSequenceKeypoint.new(1.00, 1.00),
	})
	shineGrad.Parent = topShine

	-- Viền kính lỏng phản xạ ánh sáng (Iridescent Liquid Glass Rim Stroke)
	local stroke = frame:FindFirstChild("NeonBlueStroke") or Instance.new("UIStroke")
	stroke.Name = "NeonBlueStroke"
	stroke.Color = strokeColor or Color3.fromRGB(80, 200, 255)
	stroke.Thickness = strokeThickness or 2
	stroke.Transparency = 0.10
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame

	local strokeGrad = stroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
	strokeGrad.Rotation = 35
	strokeGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(220, 248, 255)),
		ColorSequenceKeypoint.new(0.35, strokeColor or Color3.fromRGB(80, 200, 255)),
		ColorSequenceKeypoint.new(0.70, Color3.fromRGB(125, 165, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(190, 242, 255)),
	})
	strokeGrad.Parent = stroke

	return stroke, grad
end

local function createIndependentChilliDynamicIsland()
	for _, root in ipairs(getUiRoots()) do
		local old = root:FindFirstChild("ChilliDynamicIsland")
		if old then
			pcall(function()
				old.Name = "Old_ChilliDynamicIsland"
				old.Enabled = false
				old:Destroy()
			end)
		end
	end

	-- 1. Tách rời GUI (Independent ScreenGui): Đặt tên "ChilliDynamicIsland" và parent vào CoreGui
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

	-- 2. Khối Viên Thuốc Ngoài (DynamicIslandPill - Liquid Glass Trong Suốt Mờ Đẹp)
	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = UDim2.new(0.5, 0, 0, 20)
	pillFrame.Size = UDim2.new(0, 176, 0, 45)
	pillFrame.Active = true
	pillFrame.ZIndex = 20
	pillFrame.Parent = islandGui

	local pillScale = Instance.new("UIScale")
	pillScale.Name = "PillFluidScale"
	pillScale.Scale = 1.0
	pillScale.Parent = pillFrame

	local pillStroke = applyLiquidGlassSurface(
		pillFrame,
		Color3.fromRGB(46, 70, 114),
		Color3.fromRGB(16, 22, 40),
		Color3.fromRGB(34, 56, 96),
		0.22, 0.34, 0.20,
		UDim.new(1, 0),
		Color3.fromRGB(80, 200, 255),
		2
	)

	-- [Bên trái]: Khung cầu kính mờ chứa Logo Quả Ớt + Chấm trạng thái Live
	local leftLogoOrb = Instance.new("Frame")
	leftLogoOrb.Name = "PepperLogoOrb"
	leftLogoOrb.AnchorPoint = Vector2.new(0, 0.5)
	leftLogoOrb.Position = UDim2.new(0, 8, 0.5, 0)
	leftLogoOrb.Size = UDim2.new(0, 31, 0, 31)
	leftLogoOrb.ZIndex = 22
	leftLogoOrb.Parent = pillFrame
	applyLiquidGlassSurface(
		leftLogoOrb,
		Color3.fromRGB(60, 90, 145),
		Color3.fromRGB(20, 28, 50),
		Color3.fromRGB(40, 65, 110),
		0.25, 0.38, 0.25,
		UDim.new(1, 0),
		Color3.fromRGB(120, 220, 255),
		1.3
	)

	local leftLogo = Instance.new("ImageLabel")
	leftLogo.Name = "PepperLogo"
	leftLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	leftLogo.Position = UDim2.fromScale(0.5, 0.5)
	leftLogo.Size = UDim2.fromScale(0.90, 0.90)
	leftLogo.BackgroundTransparency = 1
	leftLogo.Image = CHILLI_PEPPER_LOGO
	leftLogo.ScaleType = Enum.ScaleType.Fit
	leftLogo.ZIndex = 23
	leftLogo.Parent = leftLogoOrb

	local logoCorner = Instance.new("UICorner")
	logoCorner.CornerRadius = UDim.new(1, 0)
	logoCorner.Parent = leftLogo

	-- Chấm ngọc lục bảo báo trạng thái Live
	local liveDot = Instance.new("Frame")
	liveDot.Name = "LivePulseDot"
	liveDot.AnchorPoint = Vector2.new(0, 0.5)
	liveDot.Position = UDim2.new(0, 44, 0.5, 0)
	liveDot.Size = UDim2.new(0, 7, 0, 7)
	liveDot.BackgroundColor3 = Color3.fromRGB(65, 245, 155)
	liveDot.BorderSizePixel = 0
	liveDot.ZIndex = 23
	liveDot.Parent = pillFrame

	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = liveDot

	local dotStroke = Instance.new("UIStroke")
	dotStroke.Color = Color3.fromRGB(65, 245, 155)
	dotStroke.Thickness = 1.6
	dotStroke.Transparency = 0.50
	dotStroke.Parent = liveDot

	-- [Ở giữa]: TextLabel in đậm màu trắng có bóng kính sắc nét
	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0, 0.5)
	centerStatusLabel.Position = UDim2.new(0, 56, 0.5, 0)
	centerStatusLabel.Size = UDim2.new(1, -94, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = Color3.fromRGB(248, 252, 255)
	centerStatusLabel.TextSize = 13
	centerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	centerStatusLabel.Text = formatIslandStatusText(State.CurrentRawStatus)
	centerStatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
	centerStatusLabel.ZIndex = 23
	centerStatusLabel.Parent = pillFrame

	local txtStroke = Instance.new("UIStroke")
	txtStroke.Color = Color3.fromRGB(8, 12, 24)
	txtStroke.Thickness = 1.15
	txtStroke.Transparency = 0.30
	txtStroke.Parent = centerStatusLabel

	-- [Bên phải]: Viên nang kính mờ chứa icon mũi tên trỏ xuống
	local arrowPill = Instance.new("Frame")
	arrowPill.Name = "ArrowGlassBadge"
	arrowPill.AnchorPoint = Vector2.new(1, 0.5)
	arrowPill.Position = UDim2.new(1, -8, 0.5, 0)
	arrowPill.Size = UDim2.new(0, 26, 0, 24)
	arrowPill.ZIndex = 22
	arrowPill.Parent = pillFrame
	applyLiquidGlassSurface(
		arrowPill,
		Color3.fromRGB(65, 105, 170),
		Color3.fromRGB(24, 38, 68),
		Color3.fromRGB(45, 78, 135),
		0.30, 0.45, 0.30,
		UDim.new(1, 0),
		Color3.fromRGB(145, 225, 255),
		1.1
	)

	local rightArrow = Instance.new("ImageLabel")
	rightArrow.Name = "ArrowIcon"
	rightArrow.AnchorPoint = Vector2.new(0.5, 0.5)
	rightArrow.Position = UDim2.fromScale(0.5, 0.5)
	rightArrow.Size = UDim2.new(0, 15, 0, 15)
	rightArrow.BackgroundTransparency = 1
	rightArrow.Image = DOWN_ARROW_ICON
	rightArrow.ImageColor3 = Color3.fromRGB(215, 245, 255)
	rightArrow.ScaleType = Enum.ScaleType.Fit
	rightArrow.ZIndex = 23
	rightArrow.Parent = arrowPill

	local pillClickBtn = Instance.new("TextButton")
	pillClickBtn.Name = "IslandToggleButton"
	pillClickBtn.Size = UDim2.fromScale(1, 1)
	pillClickBtn.BackgroundTransparency = 1
	pillClickBtn.Text = ""
	pillClickBtn.AutoButtonColor = false
	pillClickBtn.ZIndex = 25
	pillClickBtn.Parent = pillFrame

	-- ========================================================================
	-- 3. BẢNG MỞ RỘNG BÊN TRONG (LanguageDrawer / Expanded Liquid Glass Island)
	--    Hiệu ứng kính lỏng trong suốt mờ ảo cả khung ngoài lẫn các thẻ bên trong!
	-- ========================================================================
	local EXP_W = 328
	local COLLAPSED_EXP_H = 182
	local OPEN_NOTE_EXP_H = 278

	local expandPanel = Instance.new("Frame")
	expandPanel.Name = "LanguageDrawer"
	expandPanel.AnchorPoint = Vector2.new(0.5, 0)
	expandPanel.Position = UDim2.new(0.5, 0, 0, 20)
	expandPanel.Size = UDim2.new(0, EXP_W, 0, COLLAPSED_EXP_H)
	expandPanel.Visible = false
	expandPanel.Active = true
	expandPanel.ClipsDescendants = true
	expandPanel.ZIndex = 30
	expandPanel.Parent = islandGui

	local expScale = Instance.new("UIScale")
	expScale.Name = "ExpFluidScale"
	expScale.Scale = 1.0
	expScale.Parent = expandPanel

	local expStroke = applyLiquidGlassSurface(
		expandPanel,
		Color3.fromRGB(44, 68, 112),
		Color3.fromRGB(16, 24, 44),
		Color3.fromRGB(30, 50, 88),
		0.20, 0.32, 0.18,
		UDim.new(0, 24),
		Color3.fromRGB(95, 210, 255),
		1.8
	)

	-- Hàng Header bên trong Bảng Mở Rộng
	local expLogoOrb = Instance.new("Frame")
	expLogoOrb.Position = UDim2.new(0, 12, 0, 10)
	expLogoOrb.Size = UDim2.new(0, 30, 0, 30)
	expLogoOrb.ZIndex = 32
	expLogoOrb.Parent = expandPanel
	applyLiquidGlassSurface(
		expLogoOrb,
		Color3.fromRGB(65, 95, 150),
		Color3.fromRGB(22, 32, 56),
		Color3.fromRGB(45, 70, 120),
		0.24, 0.36, 0.24,
		UDim.new(1, 0),
		Color3.fromRGB(115, 215, 255),
		1.3
	)

	local expLogoImg = Instance.new("ImageLabel")
	expLogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
	expLogoImg.Position = UDim2.fromScale(0.5, 0.5)
	expLogoImg.Size = UDim2.fromScale(0.90, 0.90)
	expLogoImg.BackgroundTransparency = 1
	expLogoImg.Image = CHILLI_PEPPER_LOGO
	expLogoImg.ScaleType = Enum.ScaleType.Fit
	expLogoImg.ZIndex = 33
	expLogoImg.Parent = expLogoOrb

	local expLogoCorner = Instance.new("UICorner")
	expLogoCorner.CornerRadius = UDim.new(1, 0)
	expLogoCorner.Parent = expLogoImg

	local expTitle = Instance.new("TextLabel")
	expTitle.Position = UDim2.new(0, 48, 0, 8)
	expTitle.Size = UDim2.new(0, 175, 0, 16)
	expTitle.BackgroundTransparency = 1
	expTitle.Font = Enum.Font.GothamBlack
	expTitle.TextSize = 12
	expTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	expTitle.TextXAlignment = Enum.TextXAlignment.Left
	expTitle.Text = "CHILLI LIQUID ISLAND"
	expTitle.ZIndex = 33
	expTitle.Parent = expandPanel

	local expTitleGrad = Instance.new("UIGradient")
	expTitleGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(155, 230, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 195, 125)),
	})
	expTitleGrad.Parent = expTitle

	local expSubBadge = Instance.new("TextLabel")
	expSubBadge.Position = UDim2.new(0, 48, 0, 24)
	expSubBadge.Size = UDim2.new(0, 185, 0, 13)
	expSubBadge.BackgroundTransparency = 1
	expSubBadge.Font = Enum.Font.GothamBold
	expSubBadge.TextSize = 9
	expSubBadge.TextColor3 = Color3.fromRGB(110, 245, 185)
	expSubBadge.TextXAlignment = Enum.TextXAlignment.Left
	expSubBadge.Text = "● LIQUID GLASS • ZERO LAG"
	expSubBadge.ZIndex = 33
	expSubBadge.Parent = expandPanel

	local collapseBtn = Instance.new("TextButton")
	collapseBtn.Name = "CollapseIslandBtn"
	collapseBtn.Position = UDim2.new(1, -82, 0, 11)
	collapseBtn.Size = UDim2.new(0, 70, 0, 24)
	collapseBtn.Text = "Thu gọn ▲"
	collapseBtn.Font = Enum.Font.GothamBold
	collapseBtn.TextSize = 9.5
	collapseBtn.TextColor3 = Color3.fromRGB(225, 245, 255)
	collapseBtn.AutoButtonColor = false
	collapseBtn.ZIndex = 34
	collapseBtn.Parent = expandPanel
	applyLiquidGlassSurface(
		collapseBtn,
		Color3.fromRGB(65, 105, 175),
		Color3.fromRGB(26, 40, 72),
		Color3.fromRGB(45, 75, 135),
		0.28, 0.42, 0.28,
		UDim.new(1, 0),
		Color3.fromRGB(135, 215, 255),
		1.1
	)

	-- Thẻ kính lỏng số 1: Thanh Trạng Thái Đa Năng (Task Cycle Glass Card)
	local taskGlassCard = Instance.new("TextButton")
	taskGlassCard.Name = "IslandTaskCycleBtn"
	taskGlassCard.Position = UDim2.new(0, 12, 0, 44)
	taskGlassCard.Size = UDim2.new(1, -24, 0, 28)
	taskGlassCard.Text = ""
	taskGlassCard.AutoButtonColor = false
	taskGlassCard.ZIndex = 32
	taskGlassCard.Parent = expandPanel
	local taskCardStroke = applyLiquidGlassSurface(
		taskGlassCard,
		Color3.fromRGB(58, 115, 205),
		Color3.fromRGB(22, 42, 82),
		Color3.fromRGB(35, 68, 130),
		0.26, 0.40, 0.26,
		UDim.new(1, 0),
		Color3.fromRGB(95, 215, 255),
		1.2
	)

	local expTaskLbl = Instance.new("TextLabel")
	expTaskLbl.Name = "ExpandedStatusText"
	expTaskLbl.Position = UDim2.new(0, 12, 0, 0)
	expTaskLbl.Size = UDim2.new(1, -90, 1, 0)
	expTaskLbl.BackgroundTransparency = 1
	expTaskLbl.Font = Enum.Font.GothamBold
	expTaskLbl.TextSize = 10.8
	expTaskLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	expTaskLbl.TextXAlignment = Enum.TextXAlignment.Left
	expTaskLbl.TextTruncate = Enum.TextTruncate.AtEnd
	expTaskLbl.Text = "⚡ Trạng thái: " .. formatIslandStatusText(State.CurrentRawStatus)
	expTaskLbl.ZIndex = 34
	expTaskLbl.Parent = taskGlassCard

	local touchHintLbl = Instance.new("TextLabel")
	touchHintLbl.AnchorPoint = Vector2.new(1, 0.5)
	touchHintLbl.Position = UDim2.new(1, -12, 0.5, 0)
	touchHintLbl.Size = UDim2.new(0, 72, 0, 16)
	touchHintLbl.BackgroundTransparency = 1
	touchHintLbl.Font = Enum.Font.GothamBold
	touchHintLbl.TextSize = 9.2
	touchHintLbl.TextColor3 = Color3.fromRGB(205, 238, 255)
	touchHintLbl.TextXAlignment = Enum.TextXAlignment.Right
	touchHintLbl.Text = "Chạm đổi •"
	touchHintLbl.ZIndex = 34
	touchHintLbl.Parent = taskGlassCard

	-- Thẻ kính lỏng số 2: Thanh Gạt Ngôn Ngữ Kính Lỏng (Segmented Liquid Glass Switcher)
	local langTrack = Instance.new("Frame")
	langTrack.Name = "LanguageGlassTrack"
	langTrack.Position = UDim2.new(0, 12, 0, 78)
	langTrack.Size = UDim2.new(1, -24, 0, 32)
	langTrack.ZIndex = 32
	langTrack.Parent = expandPanel
	applyLiquidGlassSurface(
		langTrack,
		Color3.fromRGB(38, 56, 95),
		Color3.fromRGB(14, 20, 38),
		Color3.fromRGB(26, 40, 72),
		0.30, 0.44, 0.30,
		UDim.new(1, 0),
		Color3.fromRGB(95, 175, 245),
		1.2
	)

	-- Viên thuốc trượt Liquid Glass bên trong thanh ngôn ngữ
	local langSlider = Instance.new("Frame")
	langSlider.Name = "ActiveLangSlider"
	langSlider.Position = (State.Language == "VI") and UDim2.new(0, 3, 0, 3) or UDim2.new(0.5, 1, 0, 3)
	langSlider.Size = UDim2.new(0.5, -4, 1, -6)
	langSlider.ZIndex = 33
	langSlider.Parent = langTrack
	applyLiquidGlassSurface(
		langSlider,
		Color3.fromRGB(85, 175, 255),
		Color3.fromRGB(45, 115, 235),
		Color3.fromRGB(65, 145, 250),
		0.12, 0.24, 0.14,
		UDim.new(1, 0),
		Color3.fromRGB(185, 238, 255),
		1.2
	)

	local btnVI = Instance.new("TextButton")
	btnVI.Name = "BtnVietnamese"
	btnVI.Position = UDim2.new(0, 0, 0, 0)
	btnVI.Size = UDim2.new(0.5, 0, 1, 0)
	btnVI.BackgroundTransparency = 1
	btnVI.Font = Enum.Font.GothamBold
	btnVI.Text = "🇻🇳 Tiếng Việt"
	btnVI.TextSize = 11
	btnVI.TextColor3 = (State.Language == "VI") and TEXT_WHITE or Color3.fromRGB(175, 198, 228)
	btnVI.AutoButtonColor = false
	btnVI.ZIndex = 35
	btnVI.Parent = langTrack

	local btnEN = Instance.new("TextButton")
	btnEN.Name = "BtnEnglish"
	btnEN.Position = UDim2.new(0.5, 0, 0, 0)
	btnEN.Size = UDim2.new(0.5, 0, 1, 0)
	btnEN.BackgroundTransparency = 1
	btnEN.Font = Enum.Font.GothamBold
	btnEN.Text = "🇺🇸 English"
	btnEN.TextSize = 11
	btnEN.TextColor3 = (State.Language == "EN") and TEXT_WHITE or Color3.fromRGB(175, 198, 228)
	btnEN.AutoButtonColor = false
	btnEN.ZIndex = 35
	btnEN.Parent = langTrack

	-- Thẻ kính lỏng số 3: Cụm nút Bật/Tắt Âm Thanh & Quét Dịch Nhanh
	local actionRow = Instance.new("Frame")
	actionRow.Name = "LiquidActionRow"
	actionRow.Position = UDim2.new(0, 12, 0, 115)
	actionRow.Size = UDim2.new(1, -24, 0, 28)
	actionRow.BackgroundTransparency = 1
	actionRow.ZIndex = 32
	actionRow.Parent = expandPanel

	local soundToggleBtn = Instance.new("TextButton")
	soundToggleBtn.Name = "SoundToggleBtn"
	soundToggleBtn.Position = UDim2.new(0, 0, 0, 0)
	soundToggleBtn.Size = UDim2.new(0.5, -4, 1, 0)
	soundToggleBtn.Font = Enum.Font.GothamBold
	soundToggleBtn.TextSize = 10
	soundToggleBtn.TextColor3 = Color3.fromRGB(235, 248, 255)
	soundToggleBtn.Text = State.SoundEnabled and "🔊 Âm thanh: BẬT" or "🔇 Âm thanh: TẮT"
	soundToggleBtn.AutoButtonColor = false
	soundToggleBtn.ZIndex = 34
	soundToggleBtn.Parent = actionRow
	applyLiquidGlassSurface(
		soundToggleBtn,
		Color3.fromRGB(52, 88, 148),
		Color3.fromRGB(20, 34, 62),
		Color3.fromRGB(36, 62, 110),
		0.26, 0.40, 0.26,
		UDim.new(1, 0),
		Color3.fromRGB(110, 210, 255),
		1.1
	)

	local rescanBtn = Instance.new("TextButton")
	rescanBtn.Name = "RescanTranslateBtn"
	rescanBtn.Position = UDim2.new(0.5, 4, 0, 0)
	rescanBtn.Size = UDim2.new(0.5, -4, 1, 0)
	rescanBtn.Font = Enum.Font.GothamBold
	rescanBtn.TextSize = 10
	rescanBtn.TextColor3 = Color3.fromRGB(255, 236, 145)
	rescanBtn.Text = "⚡ Làm mới dịch thuật"
	rescanBtn.AutoButtonColor = false
	rescanBtn.ZIndex = 34
	rescanBtn.Parent = actionRow
	applyLiquidGlassSurface(
		rescanBtn,
		Color3.fromRGB(72, 68, 125),
		Color3.fromRGB(28, 26, 56),
		Color3.fromRGB(48, 45, 92),
		0.26, 0.40, 0.26,
		UDim.new(1, 0),
		Color3.fromRGB(245, 200, 95),
		1.1
	)

	-- Thẻ kính lỏng số 4: Ngăn Xem Note Hướng Dẫn (Giống Chilli Hub V8)
	local noteToggleBtn = Instance.new("TextButton")
	noteToggleBtn.Name = "SettingNoteToggleBtn"
	noteToggleBtn.Position = UDim2.new(0, 12, 0, 148)
	noteToggleBtn.Size = UDim2.new(1, -24, 0, 26)
	noteToggleBtn.Text = ""
	noteToggleBtn.AutoButtonColor = false
	noteToggleBtn.ZIndex = 33
	noteToggleBtn.Parent = expandPanel
	applyLiquidGlassSurface(
		noteToggleBtn,
		Color3.fromRGB(48, 74, 128),
		Color3.fromRGB(18, 28, 52),
		Color3.fromRGB(32, 52, 92),
		0.28, 0.42, 0.28,
		UDim.new(1, 0),
		Color3.fromRGB(95, 175, 245),
		1.1
	)

	local noteBadge = Instance.new("Frame")
	noteBadge.AnchorPoint = Vector2.new(0, 0.5)
	noteBadge.Position = UDim2.new(0, 6, 0.5, 0)
	noteBadge.Size = UDim2.new(0, 54, 0, 18)
	noteBadge.BackgroundColor3 = Color3.fromRGB(36, 26, 64)
	noteBadge.BackgroundTransparency = 0.25
	noteBadge.BorderSizePixel = 0
	noteBadge.ZIndex = 34
	noteBadge.Parent = noteToggleBtn
	Instance.new("UICorner", noteBadge).CornerRadius = UDim.new(1, 0)
	local nbStroke = Instance.new("UIStroke", noteBadge)
	nbStroke.Color = Color3.fromRGB(245, 195, 75)
	nbStroke.Thickness = 1

	local nbTxt = Instance.new("TextLabel", noteBadge)
	nbTxt.Size = UDim2.fromScale(1, 1)
	nbTxt.BackgroundTransparency = 1
	nbTxt.Font = Enum.Font.GothamBlack
	nbTxt.TextSize = 8.5
	nbTxt.TextColor3 = Color3.fromRGB(255, 230, 95)
	nbTxt.Text = "👑 MỚI"
	nbTxt.ZIndex = 35

	local noteSmallLbl = Instance.new("TextLabel", noteToggleBtn)
	noteSmallLbl.Position = UDim2.new(0, 66, 0, 0)
	noteSmallLbl.Size = UDim2.new(1, -90, 1, 0)
	noteSmallLbl.BackgroundTransparency = 1
	noteSmallLbl.Font = Enum.Font.GothamBold
	noteSmallLbl.TextSize = 9.6
	noteSmallLbl.TextColor3 = Color3.fromRGB(220, 240, 255)
	noteSmallLbl.TextXAlignment = Enum.TextXAlignment.Left
	noteSmallLbl.Text = "Thông tin Liquid Glass (Bấm xem)"
	noteSmallLbl.ZIndex = 34

	local noteArrowLbl = Instance.new("TextLabel", noteToggleBtn)
	noteArrowLbl.Position = UDim2.new(1, -22, 0, 0)
	noteArrowLbl.Size = UDim2.new(0, 18, 1, 0)
	noteArrowLbl.BackgroundTransparency = 1
	noteArrowLbl.Font = Enum.Font.GothamBlack
	noteArrowLbl.TextSize = 10
	noteArrowLbl.TextColor3 = Color3.fromRGB(165, 225, 255)
	noteArrowLbl.Text = "▼"
	noteArrowLbl.ZIndex = 34

	local noteDrawer = Instance.new("Frame")
	noteDrawer.Name = "SettingNoteDrawer"
	noteDrawer.Position = UDim2.new(0, 12, 0, 178)
	noteDrawer.Size = UDim2.new(1, -24, 0, 90)
	noteDrawer.Visible = false
	noteDrawer.ClipsDescendants = true
	noteDrawer.ZIndex = 33
	noteDrawer.Parent = expandPanel
	applyLiquidGlassSurface(
		noteDrawer,
		Color3.fromRGB(36, 56, 98),
		Color3.fromRGB(14, 20, 38),
		Color3.fromRGB(24, 40, 74),
		0.28, 0.42, 0.28,
		UDim.new(0, 14),
		Color3.fromRGB(90, 170, 240),
		1.1
	)

	local ndHeader = Instance.new("TextLabel", noteDrawer)
	ndHeader.Position = UDim2.new(0, 10, 0, 5)
	ndHeader.Size = UDim2.new(1, -20, 0, 16)
	ndHeader.BackgroundTransparency = 1
	ndHeader.Font = Enum.Font.GothamBlack
	ndHeader.TextSize = 9.5
	ndHeader.TextColor3 = Color3.fromRGB(255, 228, 95)
	ndHeader.TextXAlignment = Enum.TextXAlignment.Left
	ndHeader.Text = "✨ CHILLI DYNAMIC ISLAND • FIGGY HUB V1.0.6"
	ndHeader.ZIndex = 35

	local ndLine1 = Instance.new("TextLabel", noteDrawer)
	ndLine1.Position = UDim2.new(0, 10, 0, 24)
	ndLine1.Size = UDim2.new(1, -20, 0, 18)
	ndLine1.BackgroundTransparency = 1
	ndLine1.Font = Enum.Font.GothamBold
	ndLine1.TextSize = 9
	ndLine1.TextColor3 = Color3.fromRGB(235, 246, 255)
	ndLine1.TextXAlignment = Enum.TextXAlignment.Left
	ndLine1.Text = "+ Hiệu ứng kính lỏng (Liquid Glass) xuyên thấu trong & ngoài"
	ndLine1.ZIndex = 35

	local ndLine2 = Instance.new("TextLabel", noteDrawer)
	ndLine2.Position = UDim2.new(0, 10, 0, 44)
	ndLine2.Size = UDim2.new(1, -20, 0, 18)
	ndLine2.BackgroundTransparency = 1
	ndLine2.Font = Enum.Font.GothamBold
	ndLine2.TextSize = 9
	ndLine2.TextColor3 = Color3.fromRGB(185, 235, 255)
	ndLine2.TextXAlignment = Enum.TextXAlignment.Left
	ndLine2.Text = "+ Dịch thuật 100% Menu & Dropdown không gây giật lag"
	ndLine2.ZIndex = 35

	local ndLine3 = Instance.new("TextLabel", noteDrawer)
	ndLine3.Position = UDim2.new(0, 10, 0, 64)
	ndLine3.Size = UDim2.new(1, -20, 0, 18)
	ndLine3.BackgroundTransparency = 1
	ndLine3.Font = Enum.Font.GothamBlack
	ndLine3.TextSize = 9
	ndLine3.TextColor3 = Color3.fromRGB(95, 255, 175)
	ndLine3.TextXAlignment = Enum.TextXAlignment.Left
	ndLine3.Text = "+ Âm thanh iOS Glass cho toàn bộ nút bấm Menu & Island"
	ndLine3.ZIndex = 35

	-- ========================================================================
	-- SỰ KIỆN TƯƠNG TÁC & HIỆU ỨNG CHUYỂN ĐỔI MƯỢT MÀ (MORPHING ANIMATION)
	-- ========================================================================
	local ISLAND_CYCLE_STATES = {
		{ textVI = "Đang rảnh",      textEN = "Idle",       icon = "⚡", dot = Color3.fromRGB(65, 245, 155), stroke = Color3.fromRGB(80, 200, 255) },
		{ textVI = "Đang chạy",      textEN = "Running",    icon = "🔥", dot = Color3.fromRGB(255, 145, 55), stroke = Color3.fromRGB(255, 135, 65) },
		{ textVI = "Tự động cướp",   textEN = "Auto Steal", icon = "💎", dot = Color3.fromRGB(165, 120, 255), stroke = Color3.fromRGB(175, 130, 255) },
	}
	local cycleIdx = 1

	local function updatePillVisuals()
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		centerStatusLabel.Text = displayTxt
		expTaskLbl.Text = (State.Language == "EN") and ("⚡ Status: " .. displayTxt) or ("⚡ Trạng thái: " .. displayTxt)
		expSubBadge.Text = (State.Language == "EN") and "● LIQUID GLASS • ZERO LAG" or "● KÍNH LỎNG MỜ • KHÔNG GIẬT LAG"
		collapseBtn.Text = (State.Language == "EN") and "Collapse ▲" or "Thu gọn ▲"
		touchHintLbl.Text = (State.Language == "EN") and "Tap cycle •" or "Chạm đổi •"
		soundToggleBtn.Text = State.SoundEnabled
			and ((State.Language == "EN") and "🔊 Sound: ON" or "🔊 Âm thanh: BẬT")
			or ((State.Language == "EN") and "🔇 Sound: OFF" or "🔇 Âm thanh: TẮT")
		rescanBtn.Text = (State.Language == "EN") and "⚡ Refresh Translation" or "⚡ Làm mới dịch thuật"

		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(176, math.min(290, 108 + textLen * 7))
		TweenService:Create(
			pillFrame,
			TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, targetWidth, 0, 45) }
		):Play()

		TweenService:Create(
			langSlider,
			TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Position = (State.Language == "VI") and UDim2.new(0, 3, 0, 3) or UDim2.new(0.5, 1, 0, 3) }
		):Play()
		btnVI.TextColor3 = (State.Language == "VI") and TEXT_WHITE or Color3.fromRGB(175, 198, 228)
		btnEN.TextColor3 = (State.Language == "EN") and TEXT_WHITE or Color3.fromRGB(175, 198, 228)
	end

	State.UpdateIslandVisuals = updatePillVisuals
	State.IslandGui = islandGui
	State.IslandPill = pillFrame
	State.IslandStatusLabel = centerStatusLabel

	taskGlassCard.Activated:Connect(function()
		playUiSound("action")
		cycleIdx = (cycleIdx % #ISLAND_CYCLE_STATES) + 1
		local st = ISLAND_CYCLE_STATES[cycleIdx]
		State.CurrentRawStatus = (State.Language == "EN") and st.textEN or st.textVI
		liveDot.BackgroundColor3 = st.dot
		dotStroke.Color = st.dot
		pillStroke.Color = st.stroke
		expStroke.Color = st.stroke
		taskCardStroke.Color = st.stroke
		updatePillVisuals()
	end)

	noteToggleBtn.Activated:Connect(function()
		playUiSound("tap")
		State.NoteOpen = not State.NoteOpen
		if State.NoteOpen then
			noteDrawer.Visible = true
			noteArrowLbl.Text = "▲"
			noteSmallLbl.Text = (State.Language == "EN") and "Liquid Glass Info (Tap to hide)" or "Thông tin Liquid Glass (Bấm thu gọn)"
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, EXP_W, 0, OPEN_NOTE_EXP_H)
			}):Play()
		else
			noteArrowLbl.Text = "▼"
			noteSmallLbl.Text = (State.Language == "EN") and "Liquid Glass Info (Tap to view)" or "Thông tin Liquid Glass (Bấm xem)"
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
			expandPanel.Position = UDim2.new(pillFrame.Position.X.Scale, pillFrame.Position.X.Offset, pillFrame.Position.Y.Scale, pillFrame.Position.Y.Offset + 50)
			local targetH = State.NoteOpen and OPEN_NOTE_EXP_H or COLLAPSED_EXP_H
			expandPanel.Visible = true
			expScale.Scale = 0.92
			TweenService:Create(expScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1.0 }):Play()
			TweenService:Create(expandPanel, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, EXP_W, 0, targetH) }):Play()
			TweenService:Create(rightArrow, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
		else
			TweenService:Create(rightArrow, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
			TweenService:Create(expScale, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Scale = 0.92 }):Play()
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

	-- Hỗ trợ kéo thả viên thuốc Dynamic Island mượt mà
	local dragging, dragStart, startPos = false, nil, nil
	pillClickBtn.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = inp.Position
			startPos = pillFrame.Position
			if inp.Changed then
				inp.Changed:Connect(function()
					if inp.UserInputState == Enum.UserInputState.End or inp.UserInputState == Enum.UserInputState.Cancel then
						dragging = false
					end
				end)
			end
		end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if isAlive() and dragging and dragStart and startPos and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local delta = inp.Position - dragStart
			if delta.Magnitude > 8 then
				pillFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				expandPanel.Position = UDim2.new(pillFrame.Position.X.Scale, pillFrame.Position.X.Offset, pillFrame.Position.Y.Scale, pillFrame.Position.Y.Offset + 50)
			end
		end
	end)

	updatePillVisuals()
	return islandGui
end

-- ============================================================================
-- 5. GẮN ÂM THANH CHO TẤT CẢ NÚT BẤM, TAB, TOGGLE & DROPDOWN TRÊN MENU FIGGY HUB
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
		-- Nhận diện các thanh gạt Toggle (kích thước nhỏ ~34..52 x 16..26 có UICorner) hoặc ô Dropdown/Tab có gắn InputBegan
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
-- 6. ẨN "• Idle" GỐC CỦA FIGGY HUB & ĐỒNG BỘ TRẠNG THÁI LÊN DYNAMIC ISLAND
-- ============================================================================
local function isStatusLabelCandidate(lbl)
	if not lbl or not lbl:IsA("TextLabel") then return false end
	if State.IslandGui and lbl:IsDescendantOf(State.IslandGui) then return false end
	local raw = (lbl:GetAttribute("__FiggyOrigText") or lbl.Text or ""):match("^%s*(.-)%s*$") or ""
	if raw == "" then return false end
	local low = string.lower(raw)

	local afterBullet = raw:match("^•%s*(.+)$") or raw:match("^●%s*(.+)$")
	if afterBullet then
		local abLow = afterBullet:lower():match("^%s*(.-)%s*$") or ""
		if abLow == "idle" or abLow == "đang rảnh" or abLow == "running" or abLow == "đang chạy" or abLow:find("steal", 1, true) or abLow:find("farm", 1, true) or abLow:find("ufo", 1, true) or abLow:find("waiting", 1, true) then
			return true
		end
	end

	if (low == "idle" or low == "đang rảnh") and not lbl:FindFirstAncestorOfClass("ScrollingFrame") then
		return true
	end

	return false
end

local function hideOriginalFiggyStatusAndHook(lbl)
	if not lbl or not lbl.Parent then return end

	local currentTxt = lbl.Text or ""
	if currentTxt ~= "" then
		State.CurrentRawStatus = currentTxt
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals)
		end
	end

	pcall(function()
		lbl.Visible = false
		local p = lbl.Parent
		if p and p:IsA("GuiObject") and not p:IsA("ScrollingFrame") then
			if p:FindFirstChild("IslandLogoBadge") or p:FindFirstChild("IslandExpandHint") or p:FindFirstChild("IslandStroke") then
				p.Visible = false
			else
				local hasHeaderSibling = false
				for _, ch in ipairs(p:GetChildren()) do
					if (ch:IsA("TextLabel") or ch:IsA("TextButton")) and ch ~= lbl then
						local t = (ch.Text or ""):lower()
						if t:find("figgy", 1, true) or t:find("v1.", 1, true) or t:find("search", 1, true) or t:find("tìm kiếm", 1, true) then
							hasHeaderSibling = true
							break
						end
					end
				end
				if not hasHeaderSibling and p.AbsoluteSize.Y < 90 then
					p.Visible = false
				end
			end
		end
	end)

	if lbl:GetAttribute("__FiggyStatusHooked") ~= SID then
		lbl:SetAttribute("__FiggyStatusHooked", SID)
		lbl:GetPropertyChangedSignal("Text"):Connect(function()
			if not isAlive() then return end
			local newTxt = lbl.Text or ""
			if newTxt ~= "" then
				State.CurrentRawStatus = newTxt
				if State.UpdateIslandVisuals then
					pcall(State.UpdateIslandVisuals)
				end
			end
			if lbl.Visible then
				pcall(function() lbl.Visible = false end)
			end
		end)
		lbl:GetPropertyChangedSignal("Visible"):Connect(function()
			if isAlive() and lbl.Visible then
				pcall(function() lbl.Visible = false end)
			end
		end)
	end
end

-- ============================================================================
-- 7. ĐỘNG CƠ QUÉT & DỊCH THUẬT TOÀN BỘ MENU FIGGY HUB (ZERO-LAG)
-- ============================================================================
local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	if obj:IsA("TextButton") or obj:IsA("ImageButton") or obj:IsA("Frame") then
		pcall(hookMenuButtonSound, obj)
	end

	if obj:IsA("TextLabel") and isStatusLabelCandidate(obj) then
		hideOriginalFiggyStatusAndHook(obj)
		return
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

	-- Sửa chữa nếu chuỗi trên màn hình từng bị dịch dở từ phiên cũ
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
			if isStatusLabelCandidate(obj) then
				hideOriginalFiggyStatusAndHook(obj)
			else
				processGuiElement(obj)
			end
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
				if okName and not IGNORED_SCREEN_GUIS[gName] then
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
							-- Chỉ xử lý phần tử mới chưa gắn watcher hoặc khi bấm Làm Mới (tránh lặp lại gây lag!)
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
-- 8. KHỞI CHẠY CHILLI DYNAMIC ISLAND LIQUID GLASS & VÒNG LẶP task.spawn ZERO-LAG
-- ============================================================================
createIndependentChilliDynamicIsland()

task.spawn(function()
	scanAllMenusOnce(true)

	while isAlive() do
		task.wait(1.2)
		if not isAlive() then break end
		scanAllMenusOnce(false)
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals)
		end
	end
end)
