-- ============================================================================
-- FIGGY HUB V1.0.5+ | BẢN VIỆT HÓA TOÀN DIỆN & CHILLI DYNAMIC ISLAND ĐỘC LẬP
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- Tách rời 100% ScreenGui "ChilliDynamicIsland" khỏi menu Figgy Hub (Zero-Lag task.spawn)
-- ============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	pcall(function()
		LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	end)
	LocalPlayer = Players.LocalPlayer
end

-- Quản lý trạng thái phiên chạy (chống chồng chéo khi chạy lại script nhiều lần)
local env = (getgenv and getgenv()) or _G
env.__FiggyChilliIslandState = env.__FiggyChilliIslandState or {}
local State = env.__FiggyChilliIslandState
State.SessionId = (State.SessionId or 0) + 1
local SID = State.SessionId
State.Language = State.Language or "VI" -- "VI" (Tiếng Việt) hoặc "EN" (English)
State.CurrentRawStatus = State.CurrentRawStatus or "Idle"
State.IsExpanded = false
State.TrackedLabels = State.TrackedLabels or {}
State.FastCache = {}

local function isAlive()
	return State.SessionId == SID
end

-- ============================================================================
-- 1. HẰNG SỐ GIAO DIỆN & URL SCRIPT GỐC FIGGY HUB
-- ============================================================================
local FIGGY_LOADER_URL   = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"
local CHILLI_PEPPER_LOGO = "rbxassetid://74441610995894" -- Logo quả ớt chuẩn Chilli Hub
local DOWN_ARROW_ICON    = "rbxassetid://6031091004"     -- Icon mũi tên trỏ xuống nhỏ gọn
local PILL_BG_COLOR      = Color3.fromRGB(10, 12, 18)    -- Màu đen kính trong suốt
local NEON_BLUE_STROKE   = Color3.fromRGB(80, 200, 255)  -- Viền neon xanh dương chuẩn yêu cầu
local TEXT_WHITE         = Color3.fromRGB(255, 255, 255)
local ACCENT_ACTIVE      = Color3.fromRGB(45, 175, 255)

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

-- Kiểm tra xem menu Figgy Hub đã có sẵn trên màn hình chưa để tránh nạp trùng
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
								if t:find("figgy hub", 1, true) or t:find("frostyfig", 1, true) or t:find("ufo sightings", 1, true) then
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

-- Tự động khởi chạy script gốc Figgy Hub nếu chưa mở
task.spawn(function()
	if not isFiggyHubAlreadyLoaded() then
		pcall(function()
			loadstring(game:HttpGet(FIGGY_LOADER_URL))()
		end)
	end
end)

-- ============================================================================
-- 2. HỆ THỐNG TỪ ĐIỂN & NGỮ PHÁP VIỆT HÓA TOÀN BỘ MENU FIGGY HUB (4 TẦNG)
-- ============================================================================
local EXACT_VI = {
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
	["Active"] = "Đang chạy",
	["Farming"] = "Đang chạy",
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
	["ESP"] = "Hiển Thị (ESP)",
	["Settings"] = "Cài Đặt",
	["Setting"] = "Cài Đặt",
	["Config"] = "Cấu Hình",
	["Configs"] = "Cấu Hình",
	["Server"] = "Máy Chủ",

	-- Mục UFO (Chuẩn theo ảnh 7901.jpg)
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
	["MUTATIONS"] = "ĐỘT BIẾN",

	-- Mục SEASONAL / BUTTERFLY EVENT / THE HOLLOW / AA (Chuẩn theo ảnh 7901.jpg)
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
	["Spectral"] = " Quang Phổ",

	-- Các mục trong Tab Trang Chủ / Trứng / Quản Lý / Sự Kiện / Nhân Vật / Hiển Thị / Cài Đặt
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
	["EGG BAG"] = "TÚI TRỨNG",
	["PET BAG"] = "TÚI PET",
	["WHAT'S NEW"] = "CÓ GÌ MỚI",
	["MONEY /S"] = "TIỀN /GIÂY",
	["CASH / S"] = "TIỀN / GIÂY",
	["Player Stats"] = "Thống Kê Người Chơi",
	["Money"] = "Tiền",
	["Gems"] = "Đá Quý",
	["Equipped"] = "Đang Trang Bị",
	["Gain"] = "Tăng Tốc Độ",
	["Inventory"] = "Túi Đồ",
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
	["Steal back from players"] = "Cướp lại từ người chơi",
	["Steal Other Script"] = "Cướp Của Script Khác",
	["Drop eggs at safe zone"] = "Thả trứng tại vùng an toàn",
	["Drop for Friend"] = "Nhặt Hộ Bạn Bè",
	["Delivery method"] = "Phương thức giao trứng",
	["Delivery Mode"] = "Chế Độ Giao Trứng",
	["Steal Mode"] = "Chế Độ Cướp",
	["Steal Settings"] = "Cài Đặt Cướp",
	["Steal Status"] = "Trạng Thái Cướp",
	["Open Steal Panel"] = "Mở Bảng Cướp Trứng",
	["Open Steal History"] = "Mở Lịch Sử Cướp",
	["Egg Predictor"] = "Dự Đoán Trứng",
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
	["Skip friends"] = "Bỏ qua bạn bè",
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
	["Min Value"] = "Giá Trị Tối Thiểu",
	["Min value /s"] = "Giá trị tối thiểu /giây",
	["Max value /s"] = "Giá trị tối đa /giây",
	["Only below /s"] = "Chỉ lấy dưới mức /giây",
	["Only sell eggs below /s"] = "Chỉ bán trứng dưới mức /giây",
	["Sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
	["Rarities"] = "Độ hiếm",
	["Mutations"] = "Đột biến",
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

	["Indexing"] = "Chỉ Mục (Index)",
	["Auto Indexing"] = "Tự Động Thu Thập Chỉ Mục",
	["Auto Claim Index"] = "Tự Nhận Thưởng Chỉ Mục",
	["Auto claim index rewards"] = "Tự nhận thưởng Chỉ mục",
	["Steal missing index eggs"] = "Cướp trứng thiếu trong Chỉ mục",
	["Steal missing index"] = "Cướp trứng thiếu trong Chỉ mục",
	["Steal missing Halloween index"] = "Cướp trứng Halloween thiếu trong Chỉ mục",
	["Place eggs in pen and hatch missing in Egg Index"] = "Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",

	["Place Egg"] = "Đặt Trứng Vào Chuồng",
	["AUTO PLACE"] = "TỰ ĐỘNG ĐẶT TRỨNG",
	["Auto Place Egg"] = "Tự Động Đặt Trứng",
	["Auto Place Indexing"] = "Tự Động Đặt Lấy Chỉ Mục",
	["Auto place"] = "Tự động đặt trứng",
	["Place first"] = "Ưu tiên đặt trước",
	["Place when"] = "Đặt trứng khi",
	["Always"] = "Luôn luôn",
	["Stop At Rarity"] = "Dừng Lại Ở Độ Hiếm",
	["Whitelist"] = "Danh Sách Trắng (Ưu Tiên)",
	["Blacklist"] = "Danh Sách Đen (Bỏ Qua)",
	["Whitelist Rarity"] = "Ưu Tiên Độ Hiếm",
	["Whitelist Pet"] = "Ưu Tiên Thú Cưng",
	["Whitelist Mutation"] = "Ưu Tiên Đột Biến",
	["Blacklist Rarity"] = "Bỏ Qua Độ Hiếm",
	["Blacklist Pet"] = "Bỏ Qua Thú Cưng",
	["Blacklist Mutation"] = "Bỏ Qua Đột Biến",
	["Keep eggs"] = "Giữ lại trứng",
	["KEEP EGGS"] = "GIỮ LẠI TRỨNG",
	["Eggs to keep"] = "Danh sách trứng giữ lại",
	["Keep Above"] = "Giữ Lại Trên Mức",

	["Hatch Egg"] = "Ấp Trứng",
	["AUTO HATCH"] = "TỰ ĐỘNG ẤP TRỨNG",
	["Auto Hatch"] = "Tự Động Ấp Trứng",
	["Auto Hatch Indexing"] = "Tự Động Ấp Lấy Chỉ Mục",
	["Auto hatch"] = "Tự động ấp trứng",
	["Hatch now"] = "Ấp ngay",
	["READY NOW"] = "SẴN SÀNG ẤP",
	["Equip best pets"] = "Trang bị thú cưng mạnh nhất",

	["Pen"] = "Chuồng Ấp",
	["PEN"] = "CHUỒNG ẤP",
	["Treadmill"] = "Máy Tập Chạy",
	["TREADMILL"] = "MÁY TẬP CHẠY",
	["Auto treadmill"] = "Tự động chạy máy tập",
	["Auto upgrade treadmill"] = "Tự nâng cấp máy tập",
	["PROGRESS"] = "TIẾN TRÌNH",
	["Auto upgrade base"] = "Tự nâng cấp căn cứ",
	["Auto claim offline cash"] = "Tự nhận tiền ngoại tuyến",
	["Auto claim mastery"] = "Tự động nhận thưởng Thông Thạo",
	["Claim mastery"] = "Nhận thưởng Thông Thạo",
	["Mastery"] = "Thông Thạo",
	["MASTERY"] = "THÔNG THẠO",
	["Auto buy trails"] = "Tự động mua vệt sáng",

	["Fuse"] = "Dung Hợp",
	["FUSE"] = "DUNG HỢP",
	["FUSE MACHINE"] = "MÁY DUNG HỢP",
	["Fuse machine"] = "Máy dung hợp",
	["FUSE FILTER"] = "BỘ LỌC DUNG HỢP",
	["Fuse filter"] = "Bộ lọc dung hợp",
	["FUSE PREDICTOR"] = "DỰ ĐOÁN DUNG HỢP",
	["Auto fuse"] = "Tự động dung hợp (Fuse)",
	["Fuse first"] = "Ưu tiên dung hợp",
	["Use pets"] = "Sử dụng thú cưng",
	["Never fuse"] = "Không bao giờ dung hợp",
	["Skip mutated"] = "Bỏ qua cá thể đột biến",
	["Eject odd pets"] = "Đẩy thú lẻ ra ngoài",

	["Mutate"] = "Đột Biến",
	["AUTO MUTATE"] = "TỰ ĐỘNG ĐỘT BIẾN",
	["Auto mutate"] = "Tự động đột biến",
	["MUTATE FILTER"] = "BỘ LỌC ĐỘT BIẾN",
	["Mutate filter"] = "Bộ lọc đột biến",
	["Mutate first"] = "Ưu tiên đột biến",
	["Use items"] = "Sử dụng vật phẩm",
	["Skip eggs with"] = "Bỏ qua trứng đã có",
	["Auto buy Nitro"] = "Tự động mua Nitro",

	["Sell"] = "Bán",
	["SELL"] = "BÁN TỰ ĐỘNG",
	["Sell Egg"] = "Bán Trứng",
	["Auto sell eggs"] = "Tự động bán trứng",
	["Auto sell pets"] = "Tự động bán thú cưng",
	["Sell all eggs now"] = "Bán hết trứng ngay",
	["Sell all pets now"] = "Bán hết thú cưng ngay",
	["Sell On Inventory Full"] = "Chỉ Bán Khi Đầy Túi",
	["Sell rarities"] = "Độ hiếm bán",
	["Never sell"] = "Không bao giờ bán",
	["Only mutations"] = "Chỉ bán đột biến",
	["Keep mutated"] = "Giữ lại cá thể đột biến",
	["FAVORITE"] = "YÊU THÍCH (KHÓA)",
	["Auto favorite"] = "Tự động khóa yêu thích",
	["Favorite matching now"] = "Khóa mục khớp lọc ngay",
	["Unfavorite pets not matching"] = "Bỏ khóa thú không khớp",
	["Always favorite"] = "Luôn khóa yêu thích",
	["Favorite equipped"] = "Khóa thú cưng đang đeo",

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

-- Ngữ pháp mẫu câu tự động (Grammar Patterns)
local GRAMMAR_VI = {
	{ pat = "^[Nn]ext%s+UFO%s+in%s+(.+)$", rep = "UFO tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+event%s+in%s+(.+)$", rep = "Sự kiện tiếp theo sau %1" },
	{ pat = "^[Nn]ext%s+race%s+in%s+(.+)$", rep = "Cuộc đua tiếp theo sau %1" },
	{ pat = "^[Ss]hortcut%s+(%d+)$", rep = "Phím Tắt %1" },
	{ pat = "^QUICK BAR (%d+)$", rep = "THANH NHANH %1" },
	{ pat = "^[Gg]uard:%s*[Oo][Ff][Ff]$", rep = "Bảo vệ: TẮT" },
	{ pat = "^[Gg]uard:%s*[Oo][Nn]$", rep = "Bảo vệ: BẬT" },
	{ pat = "^[Cc]ollect%s+UFO%s+(.+)$", rep = "Thu thập %1 UFO" },
	{ pat = "^[Ff]arm%s+[Rr]are%s+(.+)$", rep = "Cày %1 hiếm" },
	{ pat = "^[Tt]eleport%s+[Ii]f%s+[Ff]ar%s+[Ff]rom%s+(.+)$", rep = "Dịch chuyển nếu ở xa %1" },
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
	{ "index rewards", "thưởng Chỉ mục" },
	{ "egg index", "Chỉ mục trứng" },
}

local WORDS_VI = {
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
}

local function applyPhrasesAndWords(str)
	local out = str
	for i = 1, #PHRASES_VI do
		local pair = PHRASES_VI[i]
		local sIdx, eIdx = string.find(string.lower(out), pair[1], 1, true)
		if sIdx then
			out = string.sub(out, 1, sIdx - 1) .. pair[2] .. string.sub(out, eIdx + 1)
		end
	end
	out = out:gsub("([%a']+)", function(w)
		local lw = string.lower(w)
		return WORDS_VI[lw] or LOWER_VI[lw] or w
	end)
	return out
end

local function translateRawSegment(rawText, targetLang)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
	local lead, trimmed, trail = rawText:match("^(%s*)(.-)(%s*)$")
	if not trimmed or trimmed == "" then return rawText end

	-- Tách ký hiệu đầu dòng nếu có (ví dụ "• Idle", "● Running")
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

		-- Nếu có từ tiếng Anh nằm trong từ điển cụm từ/từ đơn thì dịch tự động
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
		-- Chế độ Tiếng Anh (EN): khôi phục từ bản gốc hoặc bảng đối chiếu ngược
		local rev = VI_TO_EN[trimmed] or VI_TO_EN[string.lower(trimmed)]
		if rev then
			State.FastCache[cacheKey] = rev
			return lead .. rev .. trail
		end
		local ufoTime = trimmed:match("^UFO%s+tiếp%s+theo%s+sau%s+(.+)$")
		if ufoTime then
			return lead .. "Next UFO in " .. ufoTime .. trail
		end
		local scNum = trimmed:match("^Phím%s+Tắt%s+(%d+)$")
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
	-- Hỗ trợ cả chuỗi chứa thẻ RichText <font ...>...</font>
	if string.find(rawText, "<[^>]+>") then
		return (string.gsub(rawText, "([^<>]+)", function(seg)
			return translateRawSegment(seg, targetLang)
		end))
	end
	return translateRawSegment(rawText, targetLang)
end

-- Chuẩn hóa văn bản hiển thị ở giữa Dynamic Island ("Đang rảnh" / "Đang chạy" hoặc "Idle" / "Running")
local function formatIslandStatusText(rawStatus)
	local clean = tostring(rawStatus or "Idle"):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or "Idle"
	local low = string.lower(clean)
	local isIdle = (low == "" or low == "idle" or low == "đang rảnh" or string.find(low, "rảnh", 1, true) ~= nil or string.find(low, "idle", 1, true) ~= nil)

	if State.Language == "EN" then
		if isIdle then
			return "Idle"
		end
		if low == "đang chạy" then
			return "Running"
		end
		local enStr = translateRawSegment(clean, "EN")
		return (enStr and enStr ~= "") and enStr or "Running"
	else
		if isIdle then
			return "Đang rảnh"
		end
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
-- 3. XÂY DỰNG SCREENGUI ĐỘC LẬP "ChilliDynamicIsland" TRÊN COREGUI
-- ============================================================================
local function createIndependentChilliDynamicIsland()
	-- Dọn dẹp phiên bản cũ nếu người dùng chạy lại script
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

	-- Bước 1: Tạo ScreenGui hoàn toàn mới tên "ChilliDynamicIsland" và parent vào CoreGui
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

	-- Bước 2: Thiết kế khối Dynamic Island (Khung chính hình viên thuốc Pill-shape)
	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = UDim2.new(0.5, 0, 0, 20)
	pillFrame.Size = UDim2.new(0, 160, 0, 45)
	pillFrame.BackgroundColor3 = PILL_BG_COLOR
	pillFrame.BackgroundTransparency = 0.3
	pillFrame.BorderSizePixel = 0
	pillFrame.Active = true
	pillFrame.ZIndex = 10
	pillFrame.Parent = islandGui

	-- Bo góc tròn 100%
	local pillCorner = Instance.new("UICorner")
	pillCorner.CornerRadius = UDim.new(1, 0)
	pillCorner.Parent = pillFrame

	-- Viền neon xanh dương: Color = Color3.fromRGB(80, 200, 255), Thickness = 2
	local pillStroke = Instance.new("UIStroke")
	pillStroke.Name = "NeonBlueStroke"
	pillStroke.Color = NEON_BLUE_STROKE
	pillStroke.Thickness = 2
	pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	pillStroke.Parent = pillFrame

	-- Bước 3: Bố trí thành phần bên trong (Trái: Logo Ớt | Giữa: Trạng Thái | Phải: Mũi Tên)
	local leftLogo = Instance.new("ImageLabel")
	leftLogo.Name = "PepperLogo"
	leftLogo.AnchorPoint = Vector2.new(0, 0.5)
	leftLogo.Position = UDim2.new(0, 8, 0.5, 0)
	leftLogo.Size = UDim2.new(0, 31, 0, 31)
	leftLogo.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
	leftLogo.BackgroundTransparency = 0.15
	leftLogo.Image = CHILLI_PEPPER_LOGO
	leftLogo.ScaleType = Enum.ScaleType.Fit
	leftLogo.BorderSizePixel = 0
	leftLogo.ZIndex = 12
	leftLogo.Parent = pillFrame

	local logoCorner = Instance.new("UICorner")
	logoCorner.CornerRadius = UDim.new(1, 0)
	logoCorner.Parent = leftLogo

	local logoStroke = Instance.new("UIStroke")
	logoStroke.Color = NEON_BLUE_STROKE
	logoStroke.Thickness = 1.2
	logoStroke.Transparency = 0.25
	logoStroke.Parent = leftLogo

	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	centerStatusLabel.Position = UDim2.new(0.5, 4, 0.5, 0)
	centerStatusLabel.Size = UDim2.new(1, -74, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = TEXT_WHITE
	centerStatusLabel.TextSize = 13
	centerStatusLabel.Text = formatIslandStatusText(State.CurrentRawStatus)
	centerStatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
	centerStatusLabel.ZIndex = 12
	centerStatusLabel.Parent = pillFrame

	local rightArrow = Instance.new("ImageLabel")
	rightArrow.Name = "ArrowIcon"
	rightArrow.AnchorPoint = Vector2.new(1, 0.5)
	rightArrow.Position = UDim2.new(1, -12, 0.5, 0)
	rightArrow.Size = UDim2.new(0, 16, 0, 16)
	rightArrow.BackgroundTransparency = 1
	rightArrow.Image = DOWN_ARROW_ICON
	rightArrow.ImageColor3 = NEON_BLUE_STROKE
	rightArrow.ScaleType = Enum.ScaleType.Fit
	rightArrow.ZIndex = 12
	rightArrow.Parent = pillFrame

	local pillClickBtn = Instance.new("TextButton")
	pillClickBtn.Name = "IslandToggleButton"
	pillClickBtn.Size = UDim2.fromScale(1, 1)
	pillClickBtn.BackgroundTransparency = 1
	pillClickBtn.Text = ""
	pillClickBtn.AutoButtonColor = false
	pillClickBtn.ZIndex = 15
	pillClickBtn.Parent = pillFrame

	-- Khay mở rộng đổi ngôn ngữ Tiếng Việt <-> Tiếng Anh y hệt Chilli Hub
	local expandPanel = Instance.new("Frame")
	expandPanel.Name = "LanguageDrawer"
	expandPanel.AnchorPoint = Vector2.new(0.5, 0)
	expandPanel.Position = UDim2.new(0.5, 0, 0, 72)
	expandPanel.Size = UDim2.new(0, 230, 0, 52)
	expandPanel.BackgroundColor3 = PILL_BG_COLOR
	expandPanel.BackgroundTransparency = 0.18
	expandPanel.BorderSizePixel = 0
	expandPanel.Visible = false
	expandPanel.Active = true
	expandPanel.ZIndex = 14
	expandPanel.Parent = islandGui

	local expCorner = Instance.new("UICorner")
	expCorner.CornerRadius = UDim.new(0, 22)
	expCorner.Parent = expandPanel

	local expStroke = Instance.new("UIStroke")
	expStroke.Color = NEON_BLUE_STROKE
	expStroke.Thickness = 1.6
	expStroke.Transparency = 0.2
	expStroke.Parent = expandPanel

	local btnVI = Instance.new("TextButton")
	btnVI.Name = "BtnVietnamese"
	btnVI.AnchorPoint = Vector2.new(0, 0.5)
	btnVI.Position = UDim2.new(0, 8, 0.5, 0)
	btnVI.Size = UDim2.new(0.5, -12, 0, 34)
	btnVI.BackgroundColor3 = (State.Language == "VI") and ACCENT_ACTIVE or Color3.fromRGB(24, 30, 44)
	btnVI.Font = Enum.Font.GothamBold
	btnVI.Text = "🇻🇳 Tiếng Việt"
	btnVI.TextSize = 12
	btnVI.TextColor3 = TEXT_WHITE
	btnVI.AutoButtonColor = false
	btnVI.ZIndex = 16
	btnVI.Parent = expandPanel

	local viCorner = Instance.new("UICorner")
	viCorner.CornerRadius = UDim.new(1, 0)
	viCorner.Parent = btnVI

	local btnEN = Instance.new("TextButton")
	btnEN.Name = "BtnEnglish"
	btnEN.AnchorPoint = Vector2.new(1, 0.5)
	btnEN.Position = UDim2.new(1, -8, 0.5, 0)
	btnEN.Size = UDim2.new(0.5, -12, 0, 34)
	btnEN.BackgroundColor3 = (State.Language == "EN") and ACCENT_ACTIVE or Color3.fromRGB(24, 30, 44)
	btnEN.Font = Enum.Font.GothamBold
	btnEN.Text = "🇺🇸 English"
	btnEN.TextSize = 12
	btnEN.TextColor3 = TEXT_WHITE
	btnEN.AutoButtonColor = false
	btnEN.ZIndex = 16
	btnEN.Parent = expandPanel

	local enCorner = Instance.new("UICorner")
	enCorner.CornerRadius = UDim.new(1, 0)
	enCorner.Parent = btnEN

	local function updatePillVisuals()
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		centerStatusLabel.Text = displayTxt
		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(160, math.min(280, 96 + textLen * 7))
		TweenService:Create(
			pillFrame,
			TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, targetWidth, 0, 45) }
		):Play()

		btnVI.BackgroundColor3 = (State.Language == "VI") and ACCENT_ACTIVE or Color3.fromRGB(24, 30, 44)
		btnEN.BackgroundColor3 = (State.Language == "EN") and ACCENT_ACTIVE or Color3.fromRGB(24, 30, 44)
	end

	State.UpdateIslandVisuals = updatePillVisuals
	State.IslandGui = islandGui
	State.IslandPill = pillFrame
	State.IslandStatusLabel = centerStatusLabel

	pillClickBtn.Activated:Connect(function()
		State.IsExpanded = not State.IsExpanded
		expandPanel.Visible = State.IsExpanded
		TweenService:Create(
			rightArrow,
			TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{ Rotation = State.IsExpanded and 180 or 0 }
		):Play()
	end)

	btnVI.Activated:Connect(function()
		if State.Language ~= "VI" then
			State.Language = "VI"
			updatePillVisuals()
			if State.RefreshAllMenus then
				task.spawn(State.RefreshAllMenus)
			end
		end
	end)

	btnEN.Activated:Connect(function()
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
				expandPanel.Position = UDim2.new(pillFrame.Position.X.Scale, pillFrame.Position.X.Offset, pillFrame.Position.Y.Scale, pillFrame.Position.Y.Offset + 52)
			end
		end
	end)

	updatePillVisuals()
	return islandGui
end

-- ============================================================================
-- 4. ẨN "• Idle" GỐC CỦA FIGGY HUB & DỌN SẠCH DẢI ĐEN KÉO DÃN CŨ
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

	-- Ẩn chữ "• Idle" gốc (Visible = false) và ẩn mọi dải đen bị kéo dãn cũ trong menu Figgy Hub
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
-- 5. ĐỘNG CƠ QUÉT & DỊCH THUẬT TOÀN BỘ MENU FIGGY HUB (ZERO-LAG)
-- ============================================================================
local function processTextObject(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

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
				processTextObject(obj)
			end
		end)
	end
end

local function refreshAllTranslatedMenus()
	for i = #State.TrackedLabels, 1, -1 do
		local lbl = State.TrackedLabels[i]
		if lbl and lbl.Parent then
			pcall(processTextObject, lbl)
		else
			table.remove(State.TrackedLabels, i)
		end
	end
end
State.RefreshAllMenus = refreshAllTranslatedMenus

local function scanAllMenusOnce()
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
							if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
								task.defer(function()
									if isAlive() and desc and desc.Parent then
										pcall(processTextObject, desc)
									end
								end)
							end
						end)
					end

					local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
					if okDesc and type(descendants) == "table" then
						for idx, d in ipairs(descendants) do
							if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
								pcall(processTextObject, d)
							end
							if idx % 250 == 0 then
								task.wait()
							end
						end
					end
				end
			end
		end
	end
end

-- ============================================================================
-- 6. KHỞI CHẠY CHILLI DYNAMIC ISLAND & VÒNG LẶP KIỂM TRA BẰNG task.spawn
-- ============================================================================
createIndependentChilliDynamicIsland()

task.spawn(function()
	scanAllMenusOnce()

	while isAlive() do
		task.wait(1.0)
		if not isAlive() then break end
		scanAllMenusOnce()
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals)
		end
	end
end)
