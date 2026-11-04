-- ============================================================================
-- FIGGY HUB VIETNAMESE EDITION + CHILLI DYNAMIC ISLAND (STANDALONE V9)
-- Tác giả: Tối ưu, Tách GUI & Thiết kế UI/UX bởi Antigravity AI Studio
-- ============================================================================

-- TỰ ĐỘNG NẠP SCRIPT GỐC FIGGY HUB TRÊN LUỒNG ĐỘC LẬP
task.spawn(function()
	pcall(function()
		loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
	end)
end)

-- 1. IMPORT DỊCH VỤ HỆ THỐNG
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local SID = HttpService:GenerateGUID(false):sub(1, 8)

-- 2. HẰNG SỐ & ASSETS CHUẨN CHILLI HUB
local CHILLI_LOGO_ID = "rbxassetid://74441610995894" -- Logo quả ớt rực lửa Chilli Hub
local ARROW_DOWN_ID = "rbxassetid://6031091004"    -- Icon mũi tên trỏ xuống
local NEON_BLUE = Color3.fromRGB(80, 200, 255)     -- Viền neon xanh dương theo yêu cầu

-- 3. QUẢN LÝ TRẠNG THÁI HỆ THỐNG
local State = {
	CurrentStatus = "Đang rảnh",
	FiggyMainWindow = nil,
	IslandGui = nil,
	IslandFrame = nil,
	StatusLabel = nil,
	ArrowIcon = nil,
	UserPosition = nil,
	IsDragging = false,
	DragStart = nil,
	StartPos = nil,
	IsTranslating = false
}

-- Hàm tiện ích tạo Instance
local function mk(className: string, props: { [string]: any }, parent: Instance?): Instance
	local inst = Instance.new(className)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then
			inst[k] = v
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

local function stripRich(str: string?): string
	if type(str) ~= "string" then return "" end
	return str:gsub("<[^>]+>", "")
end

local function trim(str: string?): string
	if type(str) ~= "string" then return "" end
	return str:match("^%s*(.-)%s*$") or ""
end

-- ============================================================================
-- TỪ ĐIỂN DỊCH THUẬT TIẾNG VIỆT TOÀN DIỆN CHO FIGGY HUB & CƯỚP TRỨNG
-- ============================================================================
local VIETNAMESE_DICTIONARY = {
	-- Tabs Điều Hướng Chính (Sidebar)
	["home"] = "Trang Chủ",
	["eggs"] = "Trứng",
	["manage"] = "Quản Lý",
	["events"] = "Sự Kiện",
	["system"] = "Hệ Thống",
	["player"] = "Nhân Vật",
	["visuals"] = "Hiển Thị",
	["settings"] = "Cài Đặt",
	["misc"] = "Khác",
	["farm"] = "Nông Trại",
	["steal"] = "Cướp",
	["combat"] = "Chiến Đấu",
	["movement"] = "Di Chuyển",
	["move"] = "Di Chuyển",
	["esp"] = "Định Vị (ESP)",
	["optimizer"] = "Tối Ưu Hóa",
	["webhook"] = "Discord Webhook",

	-- Tiêu Đề & Header
	["figgy hub"] = "Figgy Hub",
	["steal an egg"] = "Cướp Trứng",
	["current game"] = "Game hiện tại",
	["executor"] = "Trình thực thi",
	["search"] = "Tìm kiếm...",
	["search..."] = "Tìm kiếm...",
	["what's new"] = "CÓ GÌ MỚI",
	["quick bar"] = "Phím Tắt",
	["quick bar 1"] = "Phím Tắt 1",
	["quick bar 2"] = "Phím Tắt 2",
	["keybinds"] = "Gán phím",
	["slow mode"] = "Chế độ chậm",
	["shop"] = "Cửa Hàng",

	-- Trạng Thái Nút Guard
	["guard: off"] = "Bảo vệ: TẮT",
	["guard: on"] = "Bảo vệ: BẬT",
	["guard:off"] = "Bảo vệ: TẮT",
	["guard:on"] = "Bảo vệ: BẬT",
	["guard"] = "Bảo vệ",

	-- Sự Kiện UFO (UFO Events)
	["ufo sightings"] = "PHÁT HIỆN UFO",
	["ufo sighting"] = "Phát Hiện UFO",
	["ufo status"] = "TRẠNG THÁI UFO",
	["auto ufo"] = "Tự động UFO",
	["collect ufo debris"] = "Thu gom mảnh vỡ UFO",
	["farm rare ufo"] = "Cày UFO hiếm",
	["auto trade debris"] = "Tự động đổi mảnh vỡ",
	["teleport if far from egg"] = "Dịch chuyển nếu xa trứng",
	["next ufo in"] = "UFO tiếp theo sau",
	["debris"] = "Mảnh vỡ",
	["mutations"] = "Đột biến",

	-- Sự Kiện Theo Mùa (Seasonal Events)
	["seasonal"] = "THEO MÙA",
	["butterfly event"] = "SỰ KIỆN BƯỚM",
	["butterfly bloom"] = "Mùa Bướm Nở",
	["auto butterfly bloom"] = "Tự động bắt bướm",
	["catch mode"] = "Chế độ bắt",
	["catch priority"] = "Ưu tiên bắt",
	["auto craft essence"] = "Tự chế tạo tinh hoa",
	["wisp companion"] = "Bạn đồng hành Wisp",
	["auto wisp quest"] = "Tự làm nhiệm vụ Wisp",
	["auto banjo cricket"] = "Tự động dế Banjo",
	["the hollow"] = "VÙNG RỖNG (HOLLOW)",
	["hollow"] = "Vực Hollow",
	["essence"] = "Tinh hoa",
	["caught"] = "Đã bắt",
	["net"] = "Vợt bắt",
	["status"] = "Trạng thái",
	["wins"] = "Chiến thắng",

	-- Cướp Trứng & Tự Động Hóa (Steal & Farming)
	["auto steal"] = "Tự động cướp",
	["drop eggs at safe zone"] = "Thả trứng ở khu an toàn",
	["safe zone"] = "Khu an toàn",
	["instant steps"] = "Bước chân thần tốc",
	["delivery method"] = "Phương thức giao trứng",
	["go to egg"] = "Đi tới trứng",
	["teleport to egg"] = "Dịch chuyển tới trứng",
	["tween to egg"] = "Bay lướt tới trứng",
	["steal from other players"] = "Cướp từ người khác",
	["sell cheapest egg when bag is full"] = "Bán trứng rẻ nhất khi đầy túi",
	["min value /s"] = "Giá trị tối thiểu /g",
	["only below /s"] = "Chỉ nhận dưới /g",
	["filter"] = "Bộ lọc",
	["rarities"] = "Độ hiếm",
	["zones"] = "Khu vực",
	["teleport zones"] = "Khu vực dịch chuyển",

	-- Nông Trại & Chuồng (Farm & Pen)
	["auto place"] = "Tự động đặt",
	["place first"] = "Ưu tiên đặt",
	["place when"] = "Đặt khi",
	["always"] = "Luôn luôn",
	["best value"] = "Giá trị cao nhất",
	["auto hatch"] = "Tự động ấp",
	["equip best pets"] = "Trang bị pet mạnh nhất",
	["keep eggs"] = "Giữ lại trứng",
	["auto mutate"] = "Tự động đột biến",
	["mutate filter"] = "Bộ lọc đột biến",
	["only these eggs"] = "Chỉ những trứng này",
	["auto sell"] = "Tự động bán",
	["auto sell pets"] = "Tự động bán thú cưng",
	["sell rarities"] = "Độ hiếm cần bán",
	["keep mutated"] = "Giữ lại pet đột biến",
	["only mutations"] = "Chỉ đột biến",
	["favorite"] = "Yêu thích",
	["auto favorite"] = "Tự động gắn sao",
	["auto fuse"] = "Tự động hợp nhất",
	["fuse filter"] = "Bộ lọc hợp nhất",
	["never fuse"] = "Không bao giờ hợp nhất",

	-- Máy Chạy Bộ (Treadmill)
	["treadmill"] = "Máy Chạy Bộ",
	["auto treadmill"] = "Tự động chạy máy",
	["auto upgrade treadmill"] = "Tự nâng cấp máy chạy",
	["auto upgrade base"] = "Tự nâng cấp căn cứ",
	["auto buy trails"] = "Tự động mua vệt sáng",
	["auto claim index rewards"] = "Tự nhận thưởng danh mục",
	["auto claim offline cash"] = "Tự nhận tiền offline",

	-- Nhân Vật (Player) & Chiến Đấu (Combat)
	["hit aura"] = "Aura đánh",
	["auto hit"] = "Tự động đánh",
	["chase speed"] = "Tốc độ truy đuổi",
	["skip friends"] = "Bỏ qua bạn bè",
	["god mode"] = "Bất tử",
	["infinite jump"] = "Nhảy vô hạn",
	["speed boost"] = "Tăng tốc chạy",
	["boost speed"] = "Tăng tốc chạy",
	["walk speed"] = "Tốc độ đi bộ",
	["ignore traps"] = "Bỏ qua bẫy",
	["anti afk"] = "Chống AFK",
	["anti guard"] = "Bỏ qua bảo vệ",

	-- Hiển Thị (Visuals & ESP)
	["egg esp"] = "Định vị trứng",
	["player esp"] = "Định vị người chơi",
	["pen egg esp"] = "Định vị trứng chuồng",
	["other pens esp"] = "Định vị chuồng khác",
	["field eggs"] = "Trứng trên sân",
	["fixed size"] = "Kích thước cố định",
	["hide my pets and eggs"] = "Ẩn pet & trứng của tôi",
	["hide other players' pets and eggs"] = "Ẩn pet & trứng người khác",
	["hide sleeping guards"] = "Ẩn bảo vệ đang ngủ",
	["show fps and ping"] = "Hiện FPS và Ping",
	["disable 3d render"] = "Tắt dựng hình 3D (Siêu mượt)",
	["low graphics"] = "Đồ họa thấp",
	["dim the game"] = "Làm tối màn hình",
	["hide game ui"] = "Ẩn giao diện game",

	-- Thẻ Thống Kê & Chỉ Số (Stats)
	["stolen"] = "ĐÃ CƯỚP",
	["placed"] = "ĐÃ ĐẶT",
	["income /s"] = "THU NHẬP /G",
	["income/s"] = "THU NHẬP /G",
	["last egg"] = "TRỨNG VỪA CƯỚP",
	["best steal"] = "CƯỚP TỐT NHẤT",
	["this session"] = "Phiên Chơi Này",
	["session time"] = "THỜI GIAN CHƠI",
	["night in"] = "TRỜI TỐI SAU",
	["inventory"] = "Túi Đồ",
	["egg bag"] = "Túi Trứng",
	["pet bag"] = "Túi Pet",
	["open"] = "Mở",
	["open >"] = "Mở >",

	-- Thao Tác Nhanh (Actions)
	["rejoin"] = "Vào lại",
	["find server"] = "Đổi server",
	["server hop"] = "Đổi server",
	["hop server"] = "Đổi server",
	["copy job id"] = "Chép Job ID",
	["copy jobid"] = "Chép Job ID",
	["unload"] = "Tắt Hub",
	["close"] = "Đóng",

	-- Độ Hiếm (Rarities)
	["common"] = "Thường",
	["uncommon"] = "Không phổ biến",
	["rare"] = "Hiếm",
	["epic"] = "Sử Thi",
	["legendary"] = "Huyền Thoại",
	["mythic"] = "Thần Thoại",
	["cosmic"] = "Vũ Trụ",
	["secret"] = "Bí Mật",
	["eternal"] = "Vĩnh Cửu",
	["divine"] = "Thần Thánh",

	-- Khu Vực (Zones)
	["enchanted forest"] = "Rừng Phép Thuật",
	["light dark"] = "Sáng & Tối",
	["titan temple"] = "Đền Titan",
	["cherry blossom"] = "Hoa Anh Đào"
}

-- Hàm dịch chuỗi thông minh
local function translateTextString(raw: string?): string?
	if not raw or raw == "" then return raw end
	local clean = trim(stripRich(raw))
	local low = clean:lower()

	-- Bỏ qua nhãn số liệu, giá trị tiền bạc, thời gian, FPS
	if raw:match("^[%$%+%-%d%.%,%/%%sxhm%s:%(%)kKmMbBtTQaQq]+$") or (low:find("%d") and (low:find("%$") or low:find("/s") or low:find(":") or low:find("fps") or low:find("ms"))) then
		return nil
	end

	-- 1. Khớp chính xác từ điển
	local exact = VIETNAMESE_DICTIONARY[low]
	if exact then
		return exact
	end

	-- 2. Khớp cụm từ đặc biệt
	if low:find("guard:", 1, true) then
		if low:find("off") then return "Bảo vệ: TẮT" end
		if low:find("on") then return "Bảo vệ: BẬT" end
	end
	if low:find("next ufo in", 1, true) then
		return raw:gsub("Next UFO in", "UFO tiếp theo sau"):gsub("next ufo in", "UFO tiếp theo sau")
	end
	if low:find("steal an egg", 1, true) then
		return raw:gsub("Steal [aA]n Egg", "Cướp Trứng"):gsub("steal an egg", "cướp trứng")
	end

	return nil
end

-- ============================================================================
-- BƯỚC 1: TÁCH RỜI GUI (INDEPENDENT SCREENGUI TRONG COREGUI)
-- ============================================================================
local function getHostGui(): Instance
	local target = nil
	if gethui then
		pcall(function() target = gethui() end)
	end
	if not target then
		pcall(function() target = CoreGui end)
	end
	if not target and LocalPlayer then
		target = LocalPlayer:FindFirstChildOfClass("PlayerGui")
	end
	return target or CoreGui
end

local function getOrCreateIslandScreenGui(): ScreenGui
	local host = getHostGui()
	local existing = host:FindFirstChild("ChilliDynamicIsland")
	if existing and existing:IsA("ScreenGui") then
		return existing
	end

	local screenGui = mk("ScreenGui", {
		Name = "ChilliDynamicIsland",
		ResetOnSpawn = false,
		DisplayOrder = 999999,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	})

	local ok = pcall(function()
		screenGui.Parent = host
	end)
	if not ok and LocalPlayer then
		pcall(function()
			screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
		end)
	end

	State.IslandGui = screenGui
	return screenGui
end

-- ============================================================================
-- BƯỚC 2 & 3: THIẾT KẾ KHỐI DYNAMIC ISLAND HÌNH "VIÊN THUỐC" (PILL-SHAPE)
-- ============================================================================
local function updateDynamicIslandStatus(rawStatus: string?)
	local clean = trim(stripRich(rawStatus or "")):lower()
	clean = clean:gsub("^[●•%*]%s*", ""):gsub("%s*%.%.%.$", "")

	local newStatus = "Đang rảnh"
	if clean == "idle" or clean == "đang rảnh" or clean == "waiting" or clean == "none" or clean == "" then
		newStatus = "Đang rảnh"
	else
		newStatus = "Đang chạy"
	end

	State.CurrentStatus = newStatus
	if State.StatusLabel and State.StatusLabel.Parent then
		State.StatusLabel.Text = newStatus
	end
end

local function buildChilliDynamicIsland()
	local screenGui = getOrCreateIslandScreenGui()
	if not screenGui then return end

	local existingPill = screenGui:FindFirstChild("ChilliIslandFrame")
	if existingPill then
		existingPill.Visible = true
		return existingPill
	end

	-- 1. KHUNG CHÍNH (FRAME VIÊN THUỐC LƠ LỬNG)
	local pillFrame = mk("Frame", {
		Name = "ChilliIslandFrame",
		AnchorPoint = Vector2.new(0.5, 0),
		Position = State.UserPosition or UDim2.new(0.5, 0, 0, 20),
		Size = UDim2.new(0, 160, 0, 45),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Active = true,
		Visible = true,
		ClipsDescendants = false,
		ZIndex = 10000
	}, screenGui)

	-- Bo góc tròn 100%
	mk("UICorner", {
		CornerRadius = UDim.new(1, 0)
	}, pillFrame)

	-- Viền neon xanh dương phát sáng
	mk("UIStroke", {
		Name = "NeonBlueStroke",
		Color = NEON_BLUE,
		Thickness = 2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Transparency = 0
	}, pillFrame)

	-- 2. BÊN TRÁI: ImageLabel chứa logo quả ớt bo tròn
	local logoContainer = mk("Frame", {
		Name = "LogoBadge",
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 8, 0.5, 0),
		Size = UDim2.new(0, 32, 0, 32),
		BackgroundColor3 = Color3.fromRGB(15, 20, 32),
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		ZIndex = 10001
	}, pillFrame)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, logoContainer)
	mk("UIStroke", {
		Color = Color3.fromRGB(120, 215, 255),
		Thickness = 1.2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}, logoContainer)

	local chilliLogo = mk("ImageLabel", {
		Name = "ChilliPepperLogo",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.95, 0.95),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = CHILLI_LOGO_ID,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 10002
	}, logoContainer)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, chilliLogo)

	-- 3. Ở GIỮA: TextLabel in đậm màu trắng, background trong suốt, text linh hoạt
	local statusLabel = mk("TextLabel", {
		Name = "StatusText",
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 46, 0.5, 0),
		Size = UDim2.new(0, 82, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 13.5,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = State.CurrentStatus,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 10002
	}, pillFrame)

	mk("UIStroke", {
		Thickness = 1,
		Color = Color3.fromRGB(8, 12, 20),
		Transparency = 0.35
	}, statusLabel)

	-- 4. BÊN PHẢI: Icon mũi tên trỏ xuống nhỏ gọn
	local arrow = mk("ImageLabel", {
		Name = "DropdownArrowIcon",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(0, 14, 0, 14),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = ARROW_DOWN_ID,
		ImageColor3 = NEON_BLUE,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 10002
	}, pillFrame)

	-- 5. NÚT TƯƠNG TÁC (CLICK & KÉO THẢ)
	local hitbox = mk("TextButton", {
		Name = "IslandHitbox",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 10005
	}, pillFrame)

	-- Click: Ẩn / Hiện menu Figgy Hub
	hitbox.MouseButton1Click:Connect(function()
		if State.FiggyMainWindow and State.FiggyMainWindow.Parent then
			State.FiggyMainWindow.Visible = not State.FiggyMainWindow.Visible
			TweenService:Create(pillFrame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 152, 0, 42)
			}):Play()
			task.delay(0.08, function()
				TweenService:Create(pillFrame, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 160, 0, 45)
				}):Play()
			end)
		end
	end)

	-- Kéo thả tự do trên màn hình
	hitbox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			State.IsDragging = true
			State.DragStart = input.Position
			State.StartPos = pillFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					State.IsDragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if State.IsDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - State.DragStart
			local newPos = UDim2.new(
				State.StartPos.X.Scale,
				State.StartPos.X.Offset + delta.X,
				State.StartPos.Y.Scale,
				State.StartPos.Y.Offset + delta.Y
			)
			pillFrame.Position = newPos
			State.UserPosition = newPos
		end
	end)

	State.IslandFrame = pillFrame
	State.StatusLabel = statusLabel
	State.ArrowIcon = arrow
	return pillFrame
end

-- ============================================================================
-- BƯỚC 1B: TÌM VÀ ẨN CHỮ "• IDLE" GỐC CỦA FIGGY HUB
-- ============================================================================
local function hideAndHookFiggyIdleText(obj: Instance)
	if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then return end
	if obj:FindFirstAncestor("ChilliDynamicIsland") then return end

	local raw = obj.Text or ""
	local clean = trim(stripRich(raw)):lower()
	clean = clean:gsub("^[●•%*]%s*", ""):gsub("%s*%.%.%.$", "")

	if clean == "idle" or clean == "đang rảnh" or clean == "waiting" or (clean:find("idle") and not clean:find("antispam")) then
		-- Ẩn chữ Idle gốc
		obj.Visible = false

		-- Ẩn luôn Frame bọc nếu có
		local p = obj.Parent
		if p and p:IsA("Frame") and #p:GetChildren() <= 4 and not p.Name:lower():find("header") and not p.Name:lower():find("main") then
			p.Visible = false
		end

		-- Đồng bộ trạng thái sang Dynamic Island
		if obj:GetAttribute("__ChilliSynced") ~= SID then
			obj:SetAttribute("__ChilliSynced", SID)

			local function onHostStatusChange()
				local currentRaw = obj.Text or ""
				updateDynamicIslandStatus(currentRaw)
				obj.Visible = false
				if p and p:IsA("Frame") and #p:GetChildren() <= 4 and not p.Name:lower():find("header") and not p.Name:lower():find("main") then
					p.Visible = false
				end
			end

			obj:GetPropertyChangedSignal("Text"):Connect(onHostStatusChange)
			obj:GetPropertyChangedSignal("Visible"):Connect(function()
				if obj.Visible then
					obj.Visible = false
				end
			end)

			onHostStatusChange()
		end
	end
end

-- ============================================================================
-- BƯỚC 4: ĐỘNG CƠ DỊCH TOÀN BỘ MENU FIGGY HUB SANG TIẾNG VIỆT
-- ============================================================================
local function translateGuiElement(d: Instance)
	if not (d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox")) then return end
	if d:FindFirstAncestor("ChilliDynamicIsland") then return end
	if d:GetAttribute("__IsTranslating") then return end

	hideAndHookFiggyIdleText(d)

	local raw = d.Text or ""
	if raw == "" then return end

	local targetVi = translateTextString(raw)
	if targetVi and targetVi ~= raw then
		d:SetAttribute("__IsTranslating", true)
		pcall(function()
			d.Text = targetVi
		end)
		d:SetAttribute("__IsTranslating", false)
	end
end

local function getScanRoots(): { Instance }
	local roots, seen = {}, {}
	local function add(inst: Instance?)
		if inst and not seen[inst] then
			seen[inst] = true
			table.insert(roots, inst)
		end
	end

	if gethui then
		pcall(function() add(gethui()) end)
	end
	add(CoreGui)
	if LocalPlayer then
		add(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	return roots
end

local function translateAllMenu()
	if State.IsTranslating then return end
	State.IsTranslating = true

	local roots = getScanRoots()
	for _, root in ipairs(roots) do
		for _, gui in ipairs(root:GetChildren()) do
			if gui.Name ~= "ChilliDynamicIsland" and gui.Name ~= "Chat" and gui.Name ~= "TouchGui" and gui.Name ~= "PlayerList" then
				local descs = gui:GetDescendants()
				for i = 1, #descs do
					pcall(translateGuiElement, descs[i])
					if i % 35 == 0 then
						task.wait(0.01)
					end
				end
			end
		end
	end

	State.IsTranslating = false
end

-- ============================================================================
-- VÒNG LẶP KHỞI TẠO & DUY TRÌ LIÊN TỤC
-- ============================================================================

task.defer(function()
	pcall(buildChilliDynamicIsland)
	pcall(translateAllMenu)
end)

for _, root in ipairs(getScanRoots()) do
	root.DescendantAdded:Connect(function(d)
		if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
			task.delay(0.05, function()
				pcall(translateGuiElement, d)
			end)
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(1.5)
		pcall(buildChilliDynamicIsland)

		if not State.FiggyMainWindow or not State.FiggyMainWindow.Parent then
			for _, root in ipairs(getScanRoots()) do
				for _, d in ipairs(root:GetDescendants()) do
					if (d:IsA("TextLabel") or d:IsA("TextButton")) and stripRich(d.Text or ""):lower():find("figgy hub") then
						local p = d.Parent
						while p and p.Parent and not p.Parent:IsA("ScreenGui") do
							p = p.Parent
						end
						if p and p:IsA("GuiObject") then
							State.FiggyMainWindow = p
							break
						end
					end
				end
				if State.FiggyMainWindow then break end
			end
		end

		pcall(translateAllMenu)
	end
end)

print("[Chilli Dynamic Island] Kích hoạt thành công: Tách GUI độc lập, Pill-Shape chuẩn Studio & Việt hóa 100%!")
