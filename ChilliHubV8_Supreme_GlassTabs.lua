-- ============================================================================
-- FIGGY HUB V1.0.5+ | BẢN VIỆT HÓA TOÀN DIỆN & CHILLI DYNAMIC ISLAND ĐỘC LẬP
-- Tách rời 100% ScreenGui "ChilliDynamicIsland" khỏi menu Figgy Hub
-- Hỗ trợ đổi ngôn ngữ Tiếng Việt <-> Tiếng Anh mượt mà (Zero-Lag task.spawn)
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

-- Quản lý trạng thái phiên chạy (tránh trùng lặp khi chạy lại script)
local env = (getgenv and getgenv()) or _G
env.__FiggyChilliIslandState = env.__FiggyChilliIslandState or {}
local State = env.__FiggyChilliIslandState
State.SessionId = (State.SessionId or 0) + 1
local SID = State.SessionId
State.Language = State.Language or "VI" -- "VI" hoặc "EN"
State.CurrentRawStatus = State.CurrentRawStatus or "Idle"
State.IsExpanded = false
State.TrackedLabels = State.TrackedLabels or {}
State.OrigStatusObjects = State.OrigStatusObjects or {}

local function isAlive()
	return State.SessionId == SID
end

-- ============================================================================
-- 1. HẰNG SỐ GIAO DIỆN & ASSET ID CHUẨN CHILLI HUB
-- ============================================================================
local CHILLI_PEPPER_LOGO = "rbxassetid://74441610995894" -- Logo quả ớt chuẩn Chilli Hub
local DOWN_ARROW_ICON    = "rbxassetid://6031091004"     -- Icon mũi tên trỏ xuống gọn đẹp
local PILL_BG_COLOR      = Color3.fromRGB(10, 12, 18)    -- Đen kính trong suốt
local NEON_BLUE_STROKE   = Color3.fromRGB(80, 200, 255)  -- Viền neon xanh dương chuẩn yêu cầu
local TEXT_WHITE         = Color3.fromRGB(255, 255, 255)
local TEXT_MUTED         = Color3.fromRGB(165, 180, 205)
local ACCENT_ACTIVE      = Color3.fromRGB(45, 175, 255)

-- ============================================================================
-- 2. TỪ ĐIỂN VIỆT HÓA TOÀN BỘ MENU FIGGY HUB & SỰ KIỆN (UFO / SEASONAL / AA)
-- ============================================================================
local EXACT_VI = {
	-- Tiêu đề & Thanh trạng thái
	["Steal an Egg"] = "Cướp Trứng",
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
	["Server"] = "Máy Chủ",

	-- Mục UFO (Trong ảnh 7901.jpg)
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
	["MUTATIONS"] = "ĐỘT BIẾN",

	-- Mục SEASONAL / BUTTERFLY / THE HOLLOW (Trong ảnh 7901.jpg)
	["SEASONAL"] = "SỰ KIỆN THEO MÙA",
	["Seasonal"] = "Sự Kiện Theo Mùa",
	["AA"] = "SỰ KIỆN ADMIN (AA)",
	["Admin Abuse"] = "Sự Kiện Admin (AA)",
	["BUTTERFLY EVENT"] = "SỰ KIỆN BƯỚM",
	["Butterfly Event"] = "Sự Kiện Bướm",
	["Butterfly"] = "Sự Kiện Bướm",
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

	-- Bảng Tác Vụ Nhanh Bên Phải (Quick Steal / Shortcuts)
	["STEAL"] = "CƯỚP NGAY",
	["Guard: OFF"] = "Bảo vệ: TẮT",
	["Guard: ON"] = "Bảo vệ: BẬT",
	["Shortcut 1"] = "Phím Tắt 1",
	["Shortcut 2"] = "Phím Tắt 2",
	["Rare"] = "Hiếm",
	["Rare+"] = "Hiếm+",
	["Mythic"] = "Thần Thoại",
	["Secret"] = "Bí Ẩn",
	["Cosmic"] = "Vũ Trụ",
	["Eternal"] = "Vĩnh Cửu",
	["Divine"] = "Thánh Thần",
	["Celestial"] = "Thiên Giới",
	["Golden"] = "Hoàng Kim",
	["Rainbow"] = "Cầu Vồng",
	["Diamond"] = "Kim Cương",

	-- Các tính năng phổ biến trong các Tab Trang Chủ / Trứng / Quản Lý / Nhân Vật / Hiển Thị / Cài Đặt
	["Auto Steal"] = "Tự động cướp trứng",
	["Auto steal"] = "Tự động cướp trứng",
	["Instant Steal"] = "Cướp trứng tức thì",
	["Steal from other players"] = "Cướp trứng từ người chơi khác",
	["Drop eggs at safe zone"] = "Thả trứng tại vùng an toàn",
	["Delivery method"] = "Phương thức giao trứng",
	["Instant steps"] = "Bước dịch chuyển tức thì",
	["Delivery speed"] = "Tốc độ giao trứng",
	["Tween speed"] = "Tốc độ lướt (Tween)",
	["Anti guard"] = "Chống bảo vệ (Anti-Guard)",
	["Skip friends"] = "Bỏ qua bạn bè",
	["Only these eggs"] = "Chỉ lọc các trứng này",
	["Min value /s"] = "Giá trị tối thiểu /giây",
	["Only below /s"] = "Chỉ lấy dưới mức /giây",
	["Rarities"] = "Độ hiếm",
	["Mutations"] = "Đột biến",
	["Zones"] = "Khu vực",
	["Teleport zones"] = "Khu vực dịch chuyển",
	["Steal first"] = "Ưu tiên cướp trước",
	["Best value"] = "Giá trị cao nhất",
	["Lowest value"] = "Giá trị thấp nhất",
	["Rarest"] = "Hiếm nhất",
	["Rarest first"] = "Ưu tiên hiếm nhất",
	["Auto hop server"] = "Tự động đổi máy chủ",
	["Auto hop"] = "Tự động đổi máy chủ",
	["Hop server"] = "Đổi máy chủ",
	["Hop to"] = "Đổi sang máy chủ",
	["Least players"] = "Ít người chơi nhất",
	["Rejoin on kick"] = "Tự vào lại khi bị văng",
	["Auto load script"] = "Tự nạp lại script",
	["Auto place"] = "Tự động đặt trứng",
	["Place first"] = "Ưu tiên đặt trước",
	["Place when"] = "Đặt trứng khi",
	["Always"] = "Luôn luôn",
	["Auto hatch"] = "Tự động ấp trứng",
	["Equip best pets"] = "Trang bị thú cưng mạnh nhất",
	["Keep eggs"] = "Giữ lại trứng",
	["Eggs to keep"] = "Danh sách trứng giữ lại",
	["Auto treadmill"] = "Tự động chạy máy tập",
	["Auto upgrade treadmill"] = "Tự nâng cấp máy chạy",
	["Auto upgrade base"] = "Tự nâng cấp căn cứ",
	["Auto claim offline cash"] = "Tự nhận tiền ngoại tuyến",
	["Auto claim index rewards"] = "Tự nhận thưởng Chỉ mục",
	["Auto claim mastery"] = "Tự động nhận thưởng Thông Thạo",
	["Auto buy trails"] = "Tự động mua vệt sáng",
	["Auto fuse"] = "Tự động dung hợp (Fuse)",
	["Fuse machine"] = "Máy dung hợp",
	["Fuse filter"] = "Bộ lọc dung hợp",
	["Skip mutated"] = "Bỏ qua thú đã đột biến",
	["Eject odd pets"] = "Đẩy thú lẻ ra ngoài",
	["Auto mutate"] = "Tự động đột biến",
	["Mutate filter"] = "Bộ lọc đột biến",
	["Use items"] = "Sử dụng vật phẩm",
	["Auto sell eggs"] = "Tự động bán trứng",
	["Auto sell pets"] = "Tự động bán thú cưng",
	["Keep mutated"] = "Giữ lại cá thể đột biến",
	["Auto favorite"] = "Tự động khóa yêu thích",
	["Favorite equipped"] = "Khóa yêu thích thú đang đeo",
	["Auto butterfly bloom"] = "Tự động sự kiện Hoa Bướm",
	["Auto craft essence"] = "Tự động chế tạo Tinh Chất",
	["Smart trade for essence"] = "Đổi thông minh lấy Tinh Chất",
	["Auto trade up"] = "Tự động đổi cấp cao hơn",
	["Auto catch shooting star"] = "Tự động bắt Sao Băng",
	["Shooting Star"] = "Sao Băng",
	["Auto Pumpkin Moon"] = "Tự động sự kiện Trăng Bí Ngô",
	["Auto Phantom Express"] = "Tự động Tàu Ma (Phantom Express)",
	["Auto vacuum Ghouler boss"] = "Tự hút trùm Ghouler",
	["Auto trade souls"] = "Tự động đổi Linh Hồn",
	["Auto farm monsters"] = "Tự động đánh quái sự kiện",
	["Auto fishing"] = "Tự động câu cá",
	["Auto Ghost Dog quest"] = "Tự làm nhiệm vụ Chó Ma",
	["Auto capture event egg"] = "Tự chiếm trứng sự kiện",
	["Auto steal minigame egg"] = "Tự cướp trứng trò chơi nhỏ",
	["Auto play Cursed Island Wars"] = "Tự chơi Chiến Tranh Đảo Nguyền Rủa",
	["Hit aura"] = "Vòng sáng đánh tự động (Hit Aura)",
	["Auto hit"] = "Tự động đánh người chơi",
	["Chase speed"] = "Tốc độ truy đuổi",
	["Boost speed"] = "Tăng tốc độ chạy",
	["Speed boost"] = "Bật tăng tốc",
	["Walk speed"] = "Tốc độ di chuyển",
	["Infinite jump"] = "Nhảy vô hạn",
	["God mode"] = "Bất tử (God Mode)",
	["Anti ragdoll"] = "Chống ngã (Anti-Ragdoll)",
	["Anti AFK"] = "Chống treo máy (Anti-AFK)",
	["Ignore traps"] = "Bỏ qua bẫy",
	["Instant prompts"] = "Tương tác nút bấm tức thì",
	["Invisible"] = "Tàng hình",
	["Player ESP"] = "Định vị người chơi (ESP)",
	["Guard ESP"] = "Định vị lính gác (ESP)",
	["Egg ESP"] = "Định vị trứng ngoài bãi (ESP)",
	["Pen egg ESP"] = "Định vị trứng trong chuồng",
	["Other pens ESP"] = "Định vị chuồng người khác",
	["Hide sleeping guards"] = "Ẩn lính gác đang ngủ",
	["ESP size"] = "Kích thước chữ ESP",
	["Low graphics"] = "Đồ họa thấp (Giảm lag)",
	["Disable 3D Render"] = "Tắt kết xuất 3D (Treo máy)",
	["Hide my pets and eggs"] = "Ẩn thú cưng & trứng của tôi",
	["Hide other players' pets and eggs"] = "Ẩn thú cưng & trứng người khác",
	["Hide game UI"] = "Ẩn giao diện gốc của game",
	["Show FPS and ping"] = "Hiện FPS và Ping",
	["FPS cap"] = "Giới hạn FPS",
	["Show quick bars"] = "Hiện thanh phím tắt nhanh",
	["UI scale"] = "Tỷ lệ thu phóng menu",
	["Opacity"] = "Độ trong suốt nền",
	["Dim the game"] = "Làm tối cảnh nền game",

	-- Tương thích thêm với bảng Dashboard nếu có
	["REFRESH"] = "LÀM MỚI",
	["ALL ITEMS"] = "TẤT CẢ MỤC",
	["MY SERVER"] = "MÁY CHỦ CỦA TÔI",
	["MIN VALUE"] = "GIÁ TỐI THIỂU",
	["JOIN RANDOM SERVER"] = "VÀO MÁY CHỦ NGẪU NHIÊN",
	["OPEN"] = "CÒN TRỐNG",
	["FULL"] = "ĐÃ ĐẦY",
	["TAKEN"] = "ĐÃ BỊ LẤY",
}

local LOWER_VI = {}
local VI_TO_EN = {}
for enKey, viVal in pairs(EXACT_VI) do
	LOWER_VI[string.lower(enKey)] = viVal
	if not VI_TO_EN[viVal] then
		VI_TO_EN[viVal] = enKey
	end
end

-- Các mẫu câu động (Dynamic Patterns) như "Next UFO in 1:31", "Shortcut 1", v.v.
local function translateDynamicPattern(str, toLang)
	if type(str) ~= "string" or str == "" then return nil end
	local trimmed = str:match("^%s*(.-)%s*$") or str

	if toLang == "VI" then
		-- "Next UFO in 1:31" -> "UFO tiếp theo sau 1:31"
		local ufoTime = trimmed:match("^[Nn]ext%s+UFO%s+in%s+(.+)$")
		if ufoTime then
			return "UFO tiếp theo sau " .. ufoTime
		end
		-- "Next event in 2:00" -> "Sự kiện tiếp theo sau 2:00"
		local evtTime = trimmed:match("^[Nn]ext%s+event%s+in%s+(.+)$")
		if evtTime then
			return "Sự kiện tiếp theo sau " .. evtTime
		end
		-- "Shortcut 1" -> "Phím Tắt 1"
		local scNum = trimmed:match("^[Ss]hortcut%s+(%d+)$")
		if scNum then
			return "Phím Tắt " .. scNum
		end
		-- "Guard: OFF" / "Guard: ON"
		local guardState = trimmed:match("^[Gg]uard:%s*(.+)$")
		if guardState then
			local stLow = guardState:lower()
			if stLow == "off" then return "Bảo vệ: TẮT" end
			if stLow == "on" then return "Bảo vệ: BẬT" end
		end
		-- "• Idle" / "• Running"
		local bulletRest = trimmed:match("^[•●]%s*(.+)$")
		if bulletRest then
			local mapped = EXACT_VI[bulletRest] or LOWER_VI[bulletRest:lower()]
			if mapped then
				return "• " .. mapped
			end
		end
	else
		-- Chiều ngược lại VI -> EN
		local ufoTime = trimmed:match("^UFO%s+tiếp%s+theo%s+sau%s+(.+)$")
		if ufoTime then
			return "Next UFO in " .. ufoTime
		end
		local evtTime = trimmed:match("^Sự%s+kiện%s+tiếp%s+theo%s+sau%s+(.+)$")
		if evtTime then
			return "Next event in " .. evtTime
		end
		local scNum = trimmed:match("^Phím%s+Tắt%s+(%d+)$")
		if scNum then
			return "Shortcut " .. scNum
		end
		if trimmed == "Bảo vệ: TẮT" then return "Guard: OFF" end
		if trimmed == "Bảo vệ: BẬT" then return "Guard: ON" end
		local bulletRest = trimmed:match("^[•●]%s*(.+)$")
		if bulletRest and VI_TO_EN[bulletRest] then
			return "• " .. VI_TO_EN[bulletRest]
		end
	end

	return nil
end

-- Hàm dịch chuỗi chuẩn theo ngôn ngữ hiện tại (VI / EN)
local function translateString(rawText, targetLang)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
	local trimmed = rawText:match("^%s*(.-)%s*$") or rawText
	if trimmed == "" then return rawText end

	if targetLang == "VI" then
		local exact = EXACT_VI[trimmed] or LOWER_VI[string.lower(trimmed)]
		if exact then return exact end
		local dyn = translateDynamicPattern(trimmed, "VI")
		if dyn then return dyn end
		return rawText
	else
		local rev = VI_TO_EN[trimmed]
		if rev then return rev end
		local dyn = translateDynamicPattern(trimmed, "EN")
		if dyn then return dyn end
		return rawText
	end
end

-- Chuẩn hóa văn bản hiển thị trên giữa viên thuốc Dynamic Island ("Đang rảnh" / "Đang chạy" hoặc "Idle" / "Running")
local function formatIslandStatusText(rawStatus)
	local clean = tostring(rawStatus or "Idle"):gsub("^[•●%s]+", ""):match("^%s*(.-)%s*$") or "Idle"
	local low = string.lower(clean)
	local isIdle = (low == "" or low == "idle" or low == "đang rảnh" or low:find("rảnh", 1, true) ~= nil or low:find("idle", 1, true) ~= nil)

	if State.Language == "EN" then
		if isIdle then
			return "Idle"
		end
		local enMapped = VI_TO_EN[clean] or translateDynamicPattern(clean, "EN")
		if enMapped then
			return enMapped:gsub("^[•●%s]+", "")
		end
		if low == "đang chạy" then return "Running" end
		return clean
	else
		if isIdle then
			return "Đang rảnh"
		end
		local viMapped = EXACT_VI[clean] or LOWER_VI[low] or translateDynamicPattern(clean, "VI")
		if viMapped then
			return viMapped:gsub("^[•●%s]+", "")
		end
		return "Đang chạy: " .. clean
	end
end

-- ============================================================================
-- 3. BƯỚC 1, 2 & 3: XÂY DỰNG SCREENGUI ĐỘC LẬP "ChilliDynamicIsland"
-- ============================================================================
local function createIndependentChilliDynamicIsland()
	-- Xóa phiên bản cũ nếu chạy lại script
	for _, root in ipairs({ CoreGui, (gethui and gethui()) or nil, LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui") or nil }) do
		if root then
			local old = root:FindFirstChild("ChilliDynamicIsland")
			if old then
				pcall(function()
					old.Name = "Old_ChilliDynamicIsland"
					old.Enabled = false
					old:Destroy()
				end)
			end
		end
	end

	-- 1. Tách rời GUI (Independent ScreenGui): Đặt tên "ChilliDynamicIsland" và parent vào CoreGui
	local islandGui = Instance.new("ScreenGui")
	islandGui.Name = "ChilliDynamicIsland"
	islandGui.ResetOnSpawn = false
	islandGui.IgnoreGuiInset = true
	islandGui.DisplayOrder = 999999
	islandGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local parentedOk = pcall(function()
		islandGui.Parent = CoreGui
	end)
	if not parentedOk or not islandGui.Parent then
		if gethui then
			pcall(function() islandGui.Parent = gethui() end)
		end
	end
	if not islandGui.Parent and LocalPlayer then
		islandGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
	end

	-- 2. Thiết kế khối Dynamic Island (Khung chính - Hình viên thuốc Pill-shape)
	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = UDim2.new(0.5, 0, 0, 20)
	pillFrame.Size = UDim2.new(0, 160, 0, 45)
	pillFrame.BackgroundColor3 = PILL_BG_COLOR
	pillFrame.BackgroundTransparency = 0.3 -- Màu đen kính trong suốt chuẩn yêu cầu
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

	-- 3. Bố trí thành phần bên trong (Nội dung)
	-- [Bên trái]: ImageLabel chứa logo quả ớt (bo tròn)
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

	-- [Ở giữa]: TextLabel in đậm màu trắng, background trong suốt, text linh hoạt "Đang rảnh" hoặc "Đang chạy"
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

	-- [Bên phải]: ImageLabel icon mũi tên trỏ xuống nhỏ gọn
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

	-- Nút cảm ứng trong suốt phủ lên viên thuốc để bấm mở bảng đổi ngôn ngữ VI / EN
	local pillClickBtn = Instance.new("TextButton")
	pillClickBtn.Name = "IslandToggleButton"
	pillClickBtn.Size = UDim2.fromScale(1, 1)
	pillClickBtn.BackgroundTransparency = 1
	pillClickBtn.Text = ""
	pillClickBtn.AutoButtonColor = false
	pillClickBtn.ZIndex = 15
	pillClickBtn.Parent = pillFrame

	-- Khung mở rộng (Expanded Drawer) ngay dưới viên thuốc để đổi Tiếng Việt <-> Tiếng Anh như Chilli Hub
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
		-- Giữ kích thước chuẩn 160x45 khi ngắn và tự giãn mượt nếu chữ dài hơn
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

	-- Hỗ trợ kéo thả nhẹ nhàng viên thuốc nếu người dùng muốn dịch chuyển
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
-- 4. TÌM & ẨN "• Idle" GỐC CỦA FIGGY HUB + DỌN SẠCH DẢI ĐEN BỊ KÉO DÃN
-- ============================================================================
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
	if LocalPlayer then
		add(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	return roots
end

local function isStatusLabelCandidate(lbl)
	if not lbl or not lbl:IsA("TextLabel") then return false end
	if State.IslandGui and lbl:IsDescendantOf(State.IslandGui) then return false end
	local raw = (lbl:GetAttribute("__FiggyOrigText") or lbl.Text or ""):match("^%s*(.-)%s*$") or ""
	if raw == "" then return false end
	local low = string.lower(raw)

	-- Nhận diện chính xác chữ "• Idle" / "• Đang rảnh" / "• Running" của Figgy Hub
	if raw:match("^[•●]%s*") then
		local afterBullet = raw:gsub("^[•●]%s*", ""):lower()
		if afterBullet == "idle" or afterBullet == "đang rảnh" or afterBullet == "running" or afterBullet == "đang chạy" or afterBullet:find("steal", 1, true) or afterBullet:find("farm", 1, true) or afterBullet:find("ufo", 1, true) then
			return true
		end
	end

	-- Hoặc nhãn "Idle" / "Đang rảnh" nằm trên thanh tiêu đề của Figgy Hub (không nằm trong ScrollingFrame)
	if (low == "idle" or low == "đang rảnh") and not lbl:FindFirstAncestorOfClass("ScrollingFrame") then
		return true
	end

	return false
end

local function hideOriginalFiggyStatusAndHook(lbl)
	if not lbl or not lbl.Parent then return end

	-- Lưu văn bản trạng thái hiện tại để đẩy lên ChilliDynamicIsland
	local currentTxt = lbl.Text or ""
	if currentTxt ~= "" then
		State.CurrentRawStatus = currentTxt
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals)
		end
	end

	-- 1. Ẩn chữ "• Idle" gốc (Visible = false) theo đúng yêu cầu
	pcall(function()
		lbl.Visible = false
	end)

	-- Nếu chữ "• Idle" nằm trong một khung badge nhỏ trên Header hoặc một dải đen bị kéo dãn cũ, ẩn luôn khung con đó (nhưng tuyệt đối không ẩn Header hay MainFrame!)
	local parentFrame = lbl.Parent
	if parentFrame and parentFrame:IsA("GuiObject") and not parentFrame:IsA("ScrollingFrame") then
		local hasTitleSibling = false
		for _, ch in ipairs(parentFrame:GetChildren()) do
			if (ch:IsA("TextLabel") or ch:IsA("TextButton")) and ch ~= lbl then
				local t = (ch.Text or ""):lower()
				if t:find("figgy", 1, true) or t:find("v1.", 1, true) or t:find("search", 1, true) or t:find("tìm kiếm", 1, true) then
					hasTitleSibling = true
					break
				end
			end
		end
		if not hasTitleSibling and parentFrame.AbsoluteSize.Y < 90 then
			pcall(function()
				parentFrame.Visible = false
			end)
		end
	end

	-- Lắng nghe khi Figgy Hub cập nhật trạng thái (ví dụ từ "• Idle" sang "• Farming UFO") để đồng bộ lên ChilliDynamicIsland
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
-- 5. ĐỘNG CƠ DỊCH THUẬT TOÀN BỘ MENU FIGGY HUB (ZERO-LAG)
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

	-- Lưu lại văn bản gốc lần đầu hoặc khi script gốc tự thay đổi nội dung (như bộ đếm Next UFO in 1:31)
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
					-- Bắt sự kiện DescendantAdded cho mọi thành phần mới mở ra trong menu
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
							-- Nhường CPU mỗi 250 phần tử để tuyệt đối không gây giật lag khung hình
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
	-- Quét ngay lập tức khi vừa chạy script
	pcall(scanAllMenusOnce)

	-- Vòng lặp kiểm tra ngôn ngữ & trạng thái mượt mà bằng task.spawn (Zero-Lag)
	while isAlive() do
		task.wait(1.0)
		if not isAlive() then break end
		pcall(scanAllMenusOnce)
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals)
		end
	end
end)
