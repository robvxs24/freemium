-- ============================================================================
-- BANANA HUB V1.0.8 (LIQUID GLASS EDITION) | HOÀN THIỆN TRIỆT ĐỂ THEO YÊU CẦU:
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- 1. [KHẮC PHỤC TRIỆT ĐỂ LỖI BỊ LỘ ẢNH MỜ MỜ CỦA SCRIPT GỐC LÚC MỚI CHẠY]:
--    + Sửa lỗi bộ lọc nhận diện nhầm chữ "Executor / Delta" trong tab Home của Figgy Hub v1.06,
--      giúp bắt dính và thay thế toàn bộ 3 logo củ hành tím + dịch tiếng Việt ngay ở 0.0 giây đầu tiên.
--    + Xoá sạch ảnh mờ gốc (`Image = ""`, khóa cứng `ImageTransparency = 1`, `BackgroundTransparency = 1`,
--      tắt `UIStroke` gốc và ép `UICorner = UDim.new(1, 0)`) để khung vuông mờ mờ của nút gốc
--      không bao giờ lộ ra phía sau đồng xu tròn Banana Cat.
-- 2. [TỐI ƯU HIỆU NĂNG - 0% GIẬT LAG]:
--    + Bắt sự kiện tức thời lúc khởi tạo và tự động ngắt toàn bộ kết nối quét DOM sau khi gắn xong.
--    + Xoá hoàn toàn trạng thái máy chạy bộ (Treadmill) -> Luôn giữ tĩnh "Đang rảnh" (0 lệnh vẽ lại UI).
-- 3. [DYNAMIC ISLAND HIỆU ỨNG LIQUID GLASS CHUYÊN NGHIỆP]:
--    + Kính lỏng đa lớp (Translucent Obsidian-Crystal Glass) kết hợp dải khúc xạ 3D, viền trong
--      Inner Glass Rim và thanh bắt sáng đỉnh kính Bevel Specular Glint Bar.
-- 4. [XOÁ NÚT TẮT/BẬT ÂM THANH (MẶC ĐỊNH MỞ) & ĐỒNG BỘ CHỮ KHÔNG BỊ CHÓI MẮT]:
--    + Xoá bỏ hoàn toàn nút tắt/bật âm thanh trong Dynamic Island; âm thanh mặc định luôn BẬT.
--    + Khắc phục triệt để lỗi `UIStroke` trên `TextButton` ăn vào chữ gây nhòe/chói mắt bằng cách
--      ép `ApplyStrokeMode = Enum.ApplyStrokeMode.Border` và `TextStrokeTransparency = 1` cho mọi nút,
--      đồng bộ phông chữ màu Kem Sâm-banh (Champagne Cream) sắc nét, dịu mắt.
-- ============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	pcall(function()
		LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	end)
	LocalPlayer = Players.LocalPlayer
end

-- Ngắt sạch mọi kết nối từ các lần chạy trước
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
	if conn then
		table.insert(State.ActiveConnections, conn)
	end
	return conn
end

local function isAlive()
	return State.SessionId == SID
end

State.Language = State.Language or "VI"
State.CurrentRawStatus = "Idle"
State.CurrentStatusImage = ""
State.CurrentStatusImageColor = Color3.fromRGB(255, 255, 255)
State.CurrentStatusRectOffset = Vector2.new(0, 0)
State.CurrentStatusRectSize = Vector2.new(0, 0)
State.CurrentStatusEmoji = ""
State.SoundEnabled = true -- Mặc định luôn BẬT âm thanh theo đúng yêu cầu
State.IsExpanded = false
State.NoteOpen = false
State.StaticLabels = {}
State.CachedSounds = State.CachedSounds or {}
State.LastSyncedRawText = nil
State.LastSyncedRawImg = nil
State.LastDisplayedPillText = nil
State.LastDisplayedPillImg = nil
State.LastPillTargetWidth = nil

-- ============================================================================
-- 1. BẢNG MÀU LIQUID GLASS & CHAMPAGNE CREAM DỊU MẮT (0% CHÓI MẮT)
-- ============================================================================
local SOFT_CHAMPAGNE_GOLD = Color3.fromRGB(236, 220, 182) -- Vàng sâm-banh dịu nhẹ
local SOFT_WARM_CREAM     = Color3.fromRGB(234, 228, 216) -- Kem ấm sắc nét, không chói
local SOFT_MUTED_TAUPE    = Color3.fromRGB(164, 158, 148) -- Xám kem hài hòa
local SOFT_MINT_PASTEL    = Color3.fromRGB(156, 214, 178) -- Xanh bạc hà dịu

local GOLD_PRIMARY_TEXT   = SOFT_CHAMPAGNE_GOLD
local GOLD_BRIGHT_TITLE   = Color3.fromRGB(242, 226, 186)
local GOLD_ACCENT_FILL    = Color3.fromRGB(190, 154, 68)
local GOLD_BORDER_STROKE  = Color3.fromRGB(214, 178, 86)
local GOLD_SOFT_CREAM     = SOFT_WARM_CREAM
local GOLD_MUTED_SUBTEXT  = SOFT_MUTED_TAUPE

-- Bảng màu Kính Lỏng (Liquid Glass)
local LIQUID_GLASS_BASE     = Color3.fromRGB(16, 16, 22)
local LIQUID_GLASS_CARD     = Color3.fromRGB(24, 24, 32)
local LIQUID_GLASS_TRACK    = Color3.fromRGB(18, 18, 24)
local BTN_ACTIVE_BG         = Color3.fromRGB(40, 36, 28)
local BTN_ACTIVE_STROKE     = Color3.fromRGB(186, 156, 88)
local BTN_ACTIVE_TEXT       = SOFT_WARM_CREAM
local BTN_INACTIVE_BG       = Color3.fromRGB(26, 26, 34)
local BTN_INACTIVE_STROKE   = Color3.fromRGB(86, 80, 72)

-- Hằng số TweenInfo dùng chung (0 cấp phát bộ nhớ thừa)
local TWEEN_FAST_OUT  = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TWEEN_PANEL_OUT = TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TWEEN_PULSE_IN  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_PULSE_OUT = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local FIGGY_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"

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

local EXECUTOR_KEYWORDS = {
	"delta", "codex", "arceus", "fluxus", "hydrogen", "vega", "trigon",
	"evon", "krnl", "synapse", "scripthub", "script hub", "autoexecute",
	"rconsole", "executor", "keysystem", "key system",
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

local function getViewportWidth()
	local cam = Workspace and Workspace.CurrentCamera
	if cam and cam.ViewportSize and cam.ViewportSize.X > 0 then
		return cam.ViewportSize.X
	end
	return 1000
end

local function isFiggyWindowGui(gui)
	if not gui then return false end
	if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then return false end
	local gName = gui.Name or ""
	if IGNORED_SCREEN_GUIS[gName] or gName:find("^Old_") then return false end
	if gui:GetAttribute("__VerifiedFiggyWindowGui") == true then return true end

	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end

	local hasScriptEditor = false
	local hasFiggyMarker = false

	for _, d in ipairs(desc) do
		if d:IsA("TextBox") then
			local bt = d.Text or ""
			if #bt > 120 or string.find(bt, "loadstring", 1, true) then
				hasScriptEditor = true
			end
		elseif d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = (d.Text or ""):match("^%s*(.-)%s*$") or ""
			if t == "Figgy Hub" or t == "Banana Hub" or t == "FrostyFig"
				or t == "Steal an Egg" or t == "Cướp Trứng" or t == "Steal An Egg"
				or t == "WHAT'S NEW" or t == "CÓ GÌ MỚI"
				or t == "AUTO STEAL" or t == "TỰ ĐỘNG CƯỚP TRỨNG"
				or t == "UFO SIGHTINGS" or t == "PHÁT HIỆN UFO"
				or t == "Open automation" or t == "Mở tự động hóa"
				or t == "This session" or t == "Phiên chơi này"
				or t:find("^v%d+%.%d+")
				or t:find("^QUICK BAR %d+$") or t:find("^THANH NHANH %d+$")
			then
				hasFiggyMarker = true
			end
		end
	end

	if hasFiggyMarker and not hasScriptEditor then
		gui:SetAttribute("__VerifiedFiggyWindowGui", true)
		gui:SetAttribute("__IsExecutorGui", false)
		return true
	end
	return false
end

local function isDeltaOrExecutorGui(gui)
	if not gui then return false end
	if gui:GetAttribute("__VerifiedFiggyWindowGui") == true then return false end

	local gName = string.lower(gui.Name or "")
	for _, kw in ipairs(EXECUTOR_KEYWORDS) do
		if string.find(gName, kw, 1, true) then
			gui:SetAttribute("__IsExecutorGui", true)
			return true
		end
	end

	if isFiggyWindowGui(gui) then
		gui:SetAttribute("__IsExecutorGui", false)
		return false
	end

	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" or #desc < 4 then return false end

	for _, d in ipairs(desc) do
		if d:IsA("TextBox") then
			local bt = d.Text or ""
			if #bt > 120 or string.find(bt, "loadstring", 1, true) then
				gui:SetAttribute("__IsExecutorGui", true)
				return true
			end
		end
	end

	return false
end

-- Chỉ dọn dẹp nếu trước đó gắn nhầm vào Executor GUI, tuyệt đối KHÔNG bật lại ảnh mờ gốc trên Figgy Hub!
local function cleanupPreviousOverlaysAndDeduplicate()
	local figgyGuis = {}
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local gName = gui.Name or ""
				if gName ~= "BananaDynamicIsland" and gName ~= "FiggyDynamicIsland" then
					local isExec = isDeltaOrExecutorGui(gui)
					local isFiggy = (not isExec) and isFiggyWindowGui(gui)

					pcall(function()
						for _, d in ipairs(gui:GetDescendants()) do
							if isExec and (d.Name == "BananaCatFixedOverlay" or d.Name == "BananaCatCircleAvatar" or d.Name == "GoldBadgeInnerDisc" or d.Name == "BananaCatBadgeImage" or d.Name == "BananaCatInnerSprite") then
								local par = d.Parent
								d:Destroy()
								if par then
									if par:IsA("ImageLabel") or par:IsA("ImageButton") then
										par.ImageTransparency = 0
									end
									for _, sib in ipairs(par:GetDescendants()) do
										if sib:IsA("ImageLabel") or sib:IsA("ImageButton") then
											sib.ImageTransparency = 0
										end
									end
								end
							elseif not isFiggy and d:IsA("UIStroke") and (d.Name == "LuxuryGoldCircleStroke" or d.Name == "LuxuryGoldStroke") then
								local grad = d:FindFirstChild("LuxuryGoldGradient")
								if grad then grad:Destroy() end
								local isScaled = false
								pcall(function()
									if d.StrokeSizingMode == Enum.StrokeSizingMode.ScaledSize then
										isScaled = true
									end
								end)
								if isScaled then
									d.Name = "UIStroke"
									d.Thickness = 0.06
									d.Color = Color3.fromRGB(42, 30, 38)
									d.Transparency = 0
								end
							end
						end
					end)

					if isFiggy then
						table.insert(figgyGuis, gui)
					end
				end
			end
		end
	end

	if #figgyGuis > 1 then
		for i = 2, #figgyGuis do
			pcall(function()
				figgyGuis[i].Enabled = false
				figgyGuis[i]:Destroy()
			end)
		end
	end

	return figgyGuis[1]
end

-- ============================================================================
-- 2. HỆ THỐNG ÂM THANH TƯƠNG TÁC (MẶC ĐỊNH LUÔN MỞ)
-- ============================================================================
local SOUND_CONFIG = {
	open   = { id = "rbxassetid://6895079853", vol = 0.56, spd = 1.06 },
	close  = { id = "rbxassetid://6895079853", vol = 0.45, spd = 0.88 },
	logo   = { id = "rbxassetid://6895079853", vol = 0.62, spd = 1.14 },
	tap    = { id = "rbxassetid://6026984224", vol = 0.48, spd = 1.14 },
	action = { id = "rbxassetid://4590662766", vol = 0.54, spd = 1.08 },
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
-- 3. ĐỒNG XU VÀNG KÉO RỘNG & XOÁ SẠCH 100% ẢNH MỜ MỜ CỦA NÚT GỐC
-- ============================================================================
local BANANA_CAT_ASSET_ID = "87447945720038"
local BANANA_CAT_LOGO     = "rbxthumb://type=Asset&id=" .. BANANA_CAT_ASSET_ID .. "&w=420&h=420"
local DOWN_ARROW_ICON     = "rbxassetid://6031091004"

local STRETCH_CAT_OFFSET  = Vector2.new(85, 0)
local STRETCH_CAT_SIZE    = Vector2.new(250, 420)

local function isFiggyPurpleColor(col)
	if not col then return false end
	return (col.B > 0.44 and col.R > 0.25 and (col.B - col.G) > 0.12 and col.B >= col.R * 0.85)
end

local function hasPurpleGradient(obj)
	if not obj then return false end
	local grad = obj:FindFirstChildOfClass("UIGradient")
	if grad and grad.Color and grad.Color.Keypoints then
		for _, kp in ipairs(grad.Color.Keypoints) do
			if isFiggyPurpleColor(kp.Value) then
				return true
			end
		end
	end
	return false
end

local GOLD_METALLIC_SEQ = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 242, 175)),
	ColorSequenceKeypoint.new(0.50, Color3.fromRGB(222, 176, 66)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(142, 102, 24)),
})

local COIN_SURFACE_SEQ = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 242, 185)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(234, 190, 86)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(182, 134, 42)),
})

local TITLE_GOLD_SEQ = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 238, 178)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(236, 198, 96)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(196, 152, 54)),
})

local function applyMetallicGoldGradient(target)
	if not target then return end
	local grad = target:FindFirstChild("LuxuryGoldGradient") or Instance.new("UIGradient")
	grad.Name = "LuxuryGoldGradient"
	grad.Rotation = 45
	grad.Color = GOLD_METALLIC_SEQ
	grad.Parent = target
	return grad
end

local function applyCoinSurfaceGoldGradient(target)
	if not target then return end
	local grad = target:FindFirstChild("CoinSurfaceGoldGrad") or Instance.new("UIGradient")
	grad.Name = "CoinSurfaceGoldGrad"
	grad.Rotation = 65
	grad.Color = COIN_SURFACE_SEQ
	grad.Parent = target
	return grad
end

local function applyGoldGradientToTitle(titleLbl)
	if not titleLbl or titleLbl:FindFirstChild("BananaGoldTitleGrad") then return end
	titleLbl.TextColor3 = GOLD_BRIGHT_TITLE
	titleLbl.TextStrokeTransparency = 1
	local grad = Instance.new("UIGradient")
	grad.Name = "BananaGoldTitleGrad"
	grad.Rotation = 90
	grad.Color = TITLE_GOLD_SEQ
	grad.Parent = titleLbl
end

local function buildFullCatGoldCoin(parentContainer, strokeThickness, zBase)
	local coinDisc = parentContainer:FindFirstChild("BananaCatCircleAvatar")
	if not coinDisc then
		coinDisc = Instance.new("Frame")
		coinDisc.Name = "BananaCatCircleAvatar"
		coinDisc.AnchorPoint = Vector2.new(0.5, 0.5)
		coinDisc.Position = UDim2.fromScale(0.5, 0.5)
		coinDisc.Size = UDim2.new(1, 0, 1, 0)
		coinDisc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		coinDisc.BackgroundTransparency = 0
		coinDisc.BorderSizePixel = 0
		coinDisc.ClipsDescendants = true
		coinDisc.Active = false
		coinDisc.ZIndex = zBase or 25
		coinDisc.Parent = parentContainer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = coinDisc

		applyCoinSurfaceGoldGradient(coinDisc)
	end

	local stroke = coinDisc:FindFirstChild("LuxuryGoldCircleStroke") or Instance.new("UIStroke")
	stroke.Name = "LuxuryGoldCircleStroke"
	stroke.Color = GOLD_BORDER_STROKE
	stroke.Thickness = strokeThickness or 2.0
	stroke.Transparency = 0.05
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	pcall(function()
		stroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	end)
	stroke.Parent = coinDisc
	applyMetallicGoldGradient(stroke)

	local catSprite = coinDisc:FindFirstChild("BananaCatInnerSprite")
	if not catSprite then
		catSprite = Instance.new("ImageLabel")
		catSprite.Name = "BananaCatInnerSprite"
		catSprite.AnchorPoint = Vector2.new(0.5, 0.5)
		catSprite.Position = UDim2.fromScale(0.5, 0.5)
		catSprite.Size = UDim2.fromScale(0.86, 0.86)
		catSprite.BackgroundTransparency = 1
		catSprite.BorderSizePixel = 0
		catSprite.Image = BANANA_CAT_LOGO
		catSprite.ImageColor3 = Color3.fromRGB(255, 255, 255)
		catSprite.ImageRectOffset = STRETCH_CAT_OFFSET
		catSprite.ImageRectSize = STRETCH_CAT_SIZE
		catSprite.ScaleType = Enum.ScaleType.Stretch
		catSprite.Active = false
		catSprite.ZIndex = (coinDisc.ZIndex or 25) + 1
		catSprite.Parent = coinDisc

		local spCorner = Instance.new("UICorner")
		spCorner.CornerRadius = UDim.new(0.35, 0)
		spCorner.Parent = catSprite

		applyCoinSurfaceGoldGradient(catSprite)
	else
		catSprite.Image = BANANA_CAT_LOGO
		catSprite.ImageRectOffset = STRETCH_CAT_OFFSET
		catSprite.ImageRectSize = STRETCH_CAT_SIZE
		catSprite.ScaleType = Enum.ScaleType.Stretch
		catSprite.Size = UDim2.fromScale(0.86, 0.86)
	end

	return coinDisc, stroke
end

local function playCircularLogoPulse(coinDisc, goldStroke, baseThickness)
	playUiSound("logo")
	if not coinDisc or not coinDisc.Parent then return end
	local defaultThick = baseThickness or 2.0
	pcall(function()
		TweenService:Create(coinDisc, TWEEN_PULSE_IN, { Size = UDim2.new(0.82, 0, 0.82, 0) }):Play()
		if goldStroke then
			TweenService:Create(goldStroke, TWEEN_PULSE_IN, { Thickness = defaultThick + 0.8, Transparency = 0 }):Play()
		end
		task.delay(0.085, function()
			if coinDisc and coinDisc.Parent then
				TweenService:Create(coinDisc, TWEEN_PULSE_OUT, { Size = UDim2.new(1, 0, 1, 0) }):Play()
			end
			if goldStroke and goldStroke.Parent then
				TweenService:Create(goldStroke, TWEEN_FAST_OUT, { Thickness = defaultThick, Transparency = 0.05 }):Play()
			end
		end)
	end)
end

local function getOutermostSquareButton(obj)
	local cur = obj
	for _ = 1, 4 do
		local par = cur and cur.Parent
		if par and (par:IsA("Frame") or par:IsA("ImageButton") or par:IsA("TextButton") or par:IsA("CanvasGroup")) then
			if not par:FindFirstChildOfClass("UIListLayout") and not par:FindFirstChildOfClass("UIGridLayout") then
				local pw, ph = par.AbsoluteSize.X, par.AbsoluteSize.Y
				if pw >= 16 and pw <= 92 and ph >= 16 and ph <= 92 and math.abs(pw - ph) <= 14 then
					cur = par
				else
					break
				end
			else
				break
			end
		else
			break
		end
	end
	return cur
end

local function isBananaCoinPart(inst, coinDisc)
	if not inst or not coinDisc then return false end
	return (inst == coinDisc or inst:IsDescendantOf(coinDisc))
end

-- Xoá sạch và khóa cứng mọi hình ảnh mờ mờ / khung vuông mờ mờ của nút gốc!
local function silenceOriginalButtonVisual(inst, coinDisc)
	if not inst or isBananaCoinPart(inst, coinDisc) then return end

	if inst:IsA("UICorner") then
		pcall(function() inst.CornerRadius = UDim.new(1, 0) end)
		if inst:GetAttribute("__LockCircleCorner") ~= SID then
			inst:SetAttribute("__LockCircleCorner", SID)
			trackConn(inst:GetPropertyChangedSignal("CornerRadius"):Connect(function()
				if isAlive() and inst.CornerRadius ~= UDim.new(1, 0) then
					pcall(function() inst.CornerRadius = UDim.new(1, 0) end)
				end
			end))
		end
	elseif inst:IsA("UIStroke") then
		pcall(function()
			inst.Transparency = 1
			inst.Enabled = false
		end)
		if inst:GetAttribute("__LockHideStroke") ~= SID then
			inst:SetAttribute("__LockHideStroke", SID)
			trackConn(inst:GetPropertyChangedSignal("Transparency"):Connect(function()
				if isAlive() and inst.Transparency < 0.99 then
					pcall(function() inst.Transparency = 1; inst.Enabled = false end)
				end
			end))
		end
	elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
		pcall(function()
			inst.ImageTransparency = 1
			inst.BackgroundTransparency = 1
			inst.Image = ""
		end)
		if inst:GetAttribute("__HideOrigFigConnected") ~= SID then
			inst:SetAttribute("__HideOrigFigConnected", SID)
			trackConn(inst:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
				if isAlive() and inst.ImageTransparency < 0.99 then
					pcall(function() inst.ImageTransparency = 1; inst.Image = "" end)
				end
			end))
			trackConn(inst:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
				if isAlive() and inst.BackgroundTransparency < 0.99 then
					pcall(function() inst.BackgroundTransparency = 1 end)
				end
			end))
			trackConn(inst:GetPropertyChangedSignal("Image"):Connect(function()
				if isAlive() and inst.Image ~= "" then
					pcall(function() inst.Image = ""; inst.ImageTransparency = 1 end)
				end
			end))
		end
	elseif inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("CanvasGroup") or inst:IsA("ViewportFrame") then
		pcall(function()
			inst.BackgroundTransparency = 1
			inst.BorderSizePixel = 0
		end)
		if inst:GetAttribute("__LockHideBg") ~= SID then
			inst:SetAttribute("__LockHideBg", SID)
			trackConn(inst:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
				if isAlive() and inst.BackgroundTransparency < 0.99 then
					pcall(function() inst.BackgroundTransparency = 1 end)
				end
			end))
		end
	end
end

local function decoratePurpleOnionButton(rawTarget, strokeThickness)
	local container = getOutermostSquareButton(rawTarget)
	if not container or not container:IsA("GuiObject") then return end
	local cw, ch = container.AbsoluteSize.X, container.AbsoluteSize.Y
	if cw > 92 or ch > 92 or cw < 14 or ch < 14 then return end

	local thick = strokeThickness or 2.0
	local coinDisc, stroke = buildFullCatGoldCoin(container, thick, (container.ZIndex or 5) + 8)

	-- Đảm bảo chính container cũng bo tròn 100% để 4 góc vuông mờ không bao giờ thò ra
	local cCorner = container:FindFirstChildOfClass("UICorner")
	if not cCorner then
		cCorner = Instance.new("UICorner")
		cCorner.CornerRadius = UDim.new(1, 0)
		cCorner.Parent = container
	end

	silenceOriginalButtonVisual(container, coinDisc)
	for _, desc in ipairs(container:GetDescendants()) do
		silenceOriginalButtonVisual(desc, coinDisc)
	end

	-- Nếu Figgy Hub sinh thêm hiệu ứng bóng mờ / ảnh mờ bên trong nút về sau thì ẩn ngay lập tức
	if container:GetAttribute("__SilenceNewChildren") ~= SID then
		container:SetAttribute("__SilenceNewChildren", SID)
		trackConn(container.DescendantAdded:Connect(function(newChild)
			if isAlive() and not isBananaCoinPart(newChild, coinDisc) then
				silenceOriginalButtonVisual(newChild, coinDisc)
			end
		end))
	end

	if container:GetAttribute("__BananaGoldPulseHooked") ~= SID then
		container:SetAttribute("__BananaGoldPulseHooked", SID)
		if container:IsA("TextButton") or container:IsA("ImageButton") then
			trackConn(container.Activated:Connect(function()
				if isAlive() then
					playCircularLogoPulse(coinDisc, stroke, thick)
				end
			end))
		else
			trackConn(container.InputBegan:Connect(function(inp)
				if not isAlive() then return end
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					playCircularLogoPulse(coinDisc, stroke, thick)
				end
			end))
		end
	end
end

-- ============================================================================
-- 4. BỘ TỪ ĐIỂN & ĐỘNG CƠ VIỆT HÓA TĨNH (XOÁ BỎ TRẠNG THÁI TREADMILL)
-- ============================================================================
local EXACT_VI = {
	-- Thương hiệu & Header
	["Figgy Hub"] = "Banana Hub",
	["figgy hub"] = "Banana Hub",
	["FIGGY HUB"] = "BANANA HUB",
	["Figgy"] = "Banana Hub",
	["Banana Hub"] = "Banana Hub",
	["Frosted Fig"] = "Banana Gold",
	["• Frosted Fig"] = "• Banana Gold",
	["Steal an Egg"] = "Cướp Trứng",
	["Steal An Egg"] = "Cướp Trứng",
	["steal an egg"] = "Cướp Trứng",
	["Lemon"] = "Vàng Hoàng Gia (Gold)",

	-- Trạng thái (Treadmill được quy thẳng về Đang rảnh theo đúng yêu cầu)
	["Treadmill"] = "Đang rảnh",
	["treadmill"] = "Đang rảnh",
	["TREADMILL"] = "Đang rảnh",
	["Idle"] = "Đang rảnh",
	["• Idle"] = "• Đang rảnh",
	["Running"] = "Đang rảnh",
	["• Running"] = "• Đang rảnh",
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
	["System"] = "Hệ Thống",
	["Player"] = "Người Chơi",
	["Visuals"] = "Hiển Thị",
	["Visual"] = "Hiển Thị",
	["Settings"] = "Cài Đặt",
	["Setting"] = "Cài Đặt",

	-- Thẻ Trang chủ & Tiện ích
	["CURRENT GAME"] = "TRÒ CHƠI HIỆN TẠI",
	["Executor"] = "Trình Thực Thi",
	["Open automation"] = "Mở tự động hóa",
	["This session"] = "Phiên chơi này",
	["SESSION TIME"] = "THỜI GIAN PHIÊN",
	["NIGHT IN"] = "ĐÊM TRONG",
	["DAY IN"] = "NGÀY TRONG",
	["Inventory"] = "Túi đồ",
	["Egg bag"] = "Túi trứng",
	["Pet bag"] = "Túi thú cưng",
	["STOLEN"] = "ĐÃ CƯỚP",
	["IN PEN"] = "TRONG CHUỒNG",
	["INCOME /S"] = "THU NHẬP /GIÂY",
	["LAST EGG"] = "TRỨNG VỪA RỒI",
	["BEST STEAL"] = "CƯỚP KHỦNG NHẤT",
	["Rejoin"] = "Vào lại game",
	["Find server"] = "Tìm máy chủ",
	["Copy Job ID"] = "Sao chép Job ID",
	["Unload"] = "Tắt script",
	["WHAT'S NEW"] = "CÓ GÌ MỚI",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["UFO SIGHTINGS"] = "PHÁT HIỆN UFO",
	["Auto Steal"] = "Tự Động Cướp",
	["Speed"] = "Tốc Độ",
	["Jump"] = "Nhảy Cao",
	["Fly"] = "Bay",
	["Noclip"] = "Đi Xuyên Tường",
	["Infinite Jump"] = "Nhảy Vô Hạn",
	["ESP"] = "Định Vị (ESP)",
	["Enabled"] = "Đã Bật",
	["Disabled"] = "Đã Tắt",
	["Enable"] = "Bật",
	["Disable"] = "Tắt",
	["On"] = "Bật",
	["Off"] = "Tắt",
	["Open"] = "Mở",
	["Close"] = "Đóng",
}

local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
	LOWER_VI[string.lower(k)] = v
end

local VI_TO_EN = {
	["Banana Hub"] = "Figgy Hub",
	["Cướp Trứng"] = "Steal an Egg",
	["Trang Chủ"] = "Home",
	["Trứng"] = "Eggs",
	["Quản Lý"] = "Manage",
	["Sự Kiện"] = "Events",
	["Hệ Thống"] = "System",
	["Người Chơi"] = "Player",
	["Hiển Thị"] = "Visuals",
	["Cài Đặt"] = "Settings",
	["Đang rảnh"] = "Idle",
	["• Đang rảnh"] = "• Idle",
	["Đang chạy"] = "Working",
	["Đang bật"] = "Active",
	["Đang tắt"] = "Inactive",
	["Đang cày"] = "Farming",
	["Đang cướp trứng"] = "Stealing",
	["Tìm kiếm..."] = "Search...",
	["Tìm tùy chọn..."] = "Find option",
	["TRÒ CHƠI HIỆN TẠI"] = "CURRENT GAME",
	["Trình Thực Thi"] = "Executor",
	["Mở tự động hóa"] = "Open automation",
	["Phiên chơi này"] = "This session",
	["THỜI GIAN PHIÊN"] = "SESSION TIME",
	["ĐÊM TRONG"] = "NIGHT IN",
	["NGÀY TRONG"] = "DAY IN",
	["Túi đồ"] = "Inventory",
	["Túi trứng"] = "Egg bag",
	["Túi thú cưng"] = "Pet bag",
	["ĐÃ CƯỚP"] = "STOLEN",
	["TRONG CHUỒNG"] = "IN PEN",
	["THU NHẬP /GIÂY"] = "INCOME /S",
	["TRỨNG VỪA RỒI"] = "LAST EGG",
	["CƯỚP KHỦNG NHẤT"] = "BEST STEAL",
	["Vào lại game"] = "Rejoin",
	["Tìm máy chủ"] = "Find server",
	["Sao chép Job ID"] = "Copy Job ID",
	["Tắt script"] = "Unload",
	["CÓ GÌ MỚI"] = "WHAT'S NEW",
}

local STATIC_GRAMMAR_VI = {
	{ pat = "^QUICK BAR (%d+)$", rep = "THANH NHANH %1" },
	{ pat = "^THANH NHANH (%d+)$", rep = "THANH NHANH %1" },
	{ pat = "^Session%s+([%d:]+)$", rep = "Phiên %1" },
}

local function isTreadmillOrIdleStatus(txt)
	if not txt or txt == "" then return true end
	local clean = tostring(txt):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or ""
	local low = string.lower(clean)
	if low == "idle" or low == "đang rảnh" or low == "running" then
		return true
	end
	if low == "treadmill" or low == "máy chạy bộ" or low == "may chay bo" then
		return true
	end
	if low:find("treadmill", 1, true) or low:find("máy chạy", 1, true) then
		return true
	end
	return false
end

local function isDynamicHeartbeatLabelText(txt)
	if not txt or txt == "" then return false end
	local t = tostring(txt)
	if t:find("^%d+m%s+%d+s$") or t:find("^%d+s$") or t:find("^%d+m$") or t:find("^%d+h%s+%d+m$") then
		return true
	end
	if t:find("^%$[%d%.,]+[KkMmBbTtQq]?/s$") or t:find("^%$[%d%.,]+[KkMmBbTtQq]?$") then
		return true
	end
	if t:find("^%d+/%d+$") or t:find("^%d+%%$") then
		return true
	end
	if t:find("bước/giây", 1, true) or t:find("st/s", 1, true) then
		return true
	end
	if t:find("Carrying ", 1, true) or t:find("Đang mang ", 1, true) then
		return true
	end
	return false
end

local function translateStaticLabelText(rawText, targetLang)
	if not rawText or rawText == "" then return rawText end
	local lead, trimmed, trail = rawText:match("^(%s*)(.-)(%s*)$")
	if not trimmed or trimmed == "" then return rawText end

	if isDynamicHeartbeatLabelText(trimmed) then
		return rawText
	end

	if trimmed == "Figgy Hub" or trimmed == "figgy hub" or trimmed == "Banana Hub" or trimmed == "Figgy" then
		return lead .. "Banana Hub" .. trail
	end

	if targetLang == "VI" then
		local exact = EXACT_VI[trimmed] or LOWER_VI[string.lower(trimmed)]
		if exact then
			return lead .. exact .. trail
		end

		for i = 1, #STATIC_GRAMMAR_VI do
			local g = STATIC_GRAMMAR_VI[i]
			if string.find(trimmed, g.pat) then
				return lead .. string.gsub(trimmed, g.pat, g.rep) .. trail
			end
		end

		return rawText
	else
		local rev = VI_TO_EN[trimmed] or VI_TO_EN[string.lower(trimmed)]
		if rev then
			return lead .. rev .. trail
		end
		return rawText
	end
end

local function formatIslandStatusText(rawStatus)
	local clean = tostring(rawStatus or "Idle"):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or "Idle"
	if isTreadmillOrIdleStatus(clean) then
		return (State.Language == "EN") and "Idle" or "Đang rảnh"
	end

	local low = string.lower(clean)
	if State.Language == "EN" then
		return clean
	else
		if low:find("carrying ", 1, true) then
			return (clean:gsub("[Cc]arrying%s+", "Đang mang "))
		end
		if low:find("holding ", 1, true) then
			return (clean:gsub("[Hh]olding%s+", "Đang giữ "))
		end
		if low:find("stealing", 1, true) then
			return (clean:gsub("[Ss]tealing", "Đang cướp"))
		end
		if low:find("farming", 1, true) then
			return (clean:gsub("[Ff]arming", "Đang cày"))
		end
		if low:find("waiting", 1, true) then
			return (clean:gsub("[Ww]aiting", "Đang chờ"))
		end
		if low:find("night ", 1, true) then
			return (clean:gsub("[Nn]ight%s+", "Đêm "))
		end
		if low:find("day ", 1, true) then
			return (clean:gsub("[Dd]ay%s+", "Ngày "))
		end
		local exact = EXACT_VI[clean] or LOWER_VI[low]
		return exact or clean
	end
end

-- ============================================================================
-- 5. THIẾT KẾ LIQUID GLASS DYNAMIC ISLAND CHUYÊN NGHIỆP (CHỮ SẮC NÉT, 0% CHÓI MẮT)
-- ============================================================================
local PINNED_PILL_POS   = UDim2.new(0.5, 0, 0, 6)
local PINNED_DRAWER_POS = UDim2.new(0.5, 0, 0, 48)

local LIQUID_RIM_COLOR_SEQ = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 240, 195)), -- Đỉnh bắt sáng Specular
	ColorSequenceKeypoint.new(0.35, Color3.fromRGB(214, 182, 112)),
	ColorSequenceKeypoint.new(0.70, Color3.fromRGB(145, 118, 66)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(82, 66, 38)),    -- Bóng sâu đáy kính
})

local LIQUID_RIM_TRANS_SEQ = NumberSequence.new({
	NumberSequenceKeypoint.new(0.00, 0.10),
	NumberSequenceKeypoint.new(0.50, 0.24),
	NumberSequenceKeypoint.new(1.00, 0.48),
})

local LIQUID_BG_COLOR_SEQ = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 44, 56)), -- Ánh sương mặt kính trên
	ColorSequenceKeypoint.new(0.42, Color3.fromRGB(22, 22, 30)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 12, 18)), -- Nền kính sâu
})

local GLINT_TRANS_SEQ = NumberSequence.new({
	NumberSequenceKeypoint.new(0.00, 1.00),
	NumberSequenceKeypoint.new(0.22, 0.68),
	NumberSequenceKeypoint.new(0.50, 0.52),
	NumberSequenceKeypoint.new(0.78, 0.68),
	NumberSequenceKeypoint.new(1.00, 1.00),
})

-- Hàm gắn UIStroke chuẩn cho cả Frame lẫn TextButton (BẮT BUỘC ApplyStrokeMode.Border để không ăn vào chữ gây chói mắt!)
local function createCleanBorderStroke(parent, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or BTN_INACTIVE_STROKE
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0.45
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	pcall(function()
		stroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	end)
	stroke.Parent = parent
	return stroke
end

local function applyLiquidGlassRim(stroke, thickness)
	stroke.Thickness = thickness or 1.25
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	pcall(function() stroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize end)
	local grad = stroke:FindFirstChild("LiquidGlassStrokeGrad") or Instance.new("UIGradient")
	grad.Name = "LiquidGlassStrokeGrad"
	grad.Rotation = 90
	grad.Color = LIQUID_RIM_COLOR_SEQ
	grad.Transparency = LIQUID_RIM_TRANS_SEQ
	grad.Parent = stroke
	return stroke
end

local function applyLiquidGlass(frame, cornerRadius, bgAlpha, strokeThickness)
	local alpha = bgAlpha or 0.16
	frame.BackgroundColor3 = LIQUID_GLASS_BASE
	frame.BackgroundTransparency = alpha
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or UDim.new(1, 0)
	corner.Parent = frame

	local bgGrad = frame:FindFirstChild("LiquidGlassBgGrad") or Instance.new("UIGradient")
	bgGrad.Name = "LiquidGlassBgGrad"
	bgGrad.Rotation = 100
	bgGrad.Color = LIQUID_BG_COLOR_SEQ
	bgGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, math.max(0, alpha - 0.06)),
		NumberSequenceKeypoint.new(0.50, alpha),
		NumberSequenceKeypoint.new(1.00, math.min(1, alpha + 0.06)),
	})
	bgGrad.Parent = frame

	local stroke = frame:FindFirstChild("LiquidGlassRimStroke") or Instance.new("UIStroke")
	stroke.Name = "LiquidGlassRimStroke"
	stroke.Parent = frame
	applyLiquidGlassRim(stroke, strokeThickness or 1.25)

	-- Lớp viền khúc xạ bên trong mặt kính (Inner Glass Rim)
	local innerRim = frame:FindFirstChild("LiquidGlassInnerRim")
	if not innerRim then
		innerRim = Instance.new("Frame")
		innerRim.Name = "LiquidGlassInnerRim"
		innerRim.AnchorPoint = Vector2.new(0.5, 0.5)
		innerRim.Position = UDim2.fromScale(0.5, 0.5)
		innerRim.Size = UDim2.new(1, -2, 1, -2)
		innerRim.BackgroundTransparency = 1
		innerRim.BorderSizePixel = 0
		innerRim.Active = false
		innerRim.ZIndex = (frame.ZIndex or 20) + 1
		innerRim.Parent = frame

		local irCorner = Instance.new("UICorner")
		irCorner.CornerRadius = cornerRadius or UDim.new(1, 0)
		irCorner.Parent = innerRim

		createCleanBorderStroke(innerRim, Color3.fromRGB(255, 248, 225), 1, 0.84)
	end

	-- Thanh Bevel Specular Glint Bar phản xạ ánh sáng đỉnh kính
	local glintBar = frame:FindFirstChild("LiquidGlassGlintBar")
	if not glintBar then
		glintBar = Instance.new("Frame")
		glintBar.Name = "LiquidGlassGlintBar"
		glintBar.AnchorPoint = Vector2.new(0.5, 0)
		glintBar.Position = UDim2.new(0.5, 0, 0, 1.5)
		glintBar.Size = UDim2.new(1, -28, 0, 1.2)
		glintBar.BackgroundColor3 = Color3.fromRGB(255, 250, 235)
		glintBar.BorderSizePixel = 0
		glintBar.Active = false
		glintBar.ZIndex = (frame.ZIndex or 20) + 1
		glintBar.Parent = frame

		local glintGrad = Instance.new("UIGradient")
		glintGrad.Name = "GlintHorizontalGrad"
		glintGrad.Rotation = 0
		glintGrad.Transparency = GLINT_TRANS_SEQ
		glintGrad.Parent = glintBar
	end

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

	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "DynamicIslandPill"
	pillFrame.AnchorPoint = Vector2.new(0.5, 0)
	pillFrame.Position = PINNED_PILL_POS
	pillFrame.Size = UDim2.new(0, 196, 0, 38)
	pillFrame.Active = true
	pillFrame.ZIndex = 20
	pillFrame.Parent = islandGui

	trackConn(pillFrame:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and pillFrame.Position ~= PINNED_PILL_POS then
			pillFrame.Position = PINNED_PILL_POS
		end
	end))

	applyLiquidGlass(pillFrame, UDim.new(1, 0), 0.16, 1.25)

	local logoOrbHolder = Instance.new("Frame")
	logoOrbHolder.Name = "BananaCatLogoOrb"
	logoOrbHolder.AnchorPoint = Vector2.new(0, 0.5)
	logoOrbHolder.Position = UDim2.new(0, 6, 0.5, 0)
	logoOrbHolder.Size = UDim2.new(0, 28, 0, 28)
	logoOrbHolder.BackgroundTransparency = 1
	logoOrbHolder.BorderSizePixel = 0
	logoOrbHolder.ZIndex = 22
	logoOrbHolder.Parent = pillFrame

	local pillCoinDisc, pillOrbStroke = buildFullCatGoldCoin(logoOrbHolder, 1.8, 23)

	local statusBadgeContainer = Instance.new("Frame")
	statusBadgeContainer.Name = "TransplantedStatusBadge"
	statusBadgeContainer.AnchorPoint = Vector2.new(0, 0.5)
	statusBadgeContainer.Position = UDim2.new(0, 40, 0.5, 0)
	statusBadgeContainer.Size = UDim2.new(1, -66, 0, 26)
	statusBadgeContainer.BackgroundColor3 = LIQUID_GLASS_CARD
	statusBadgeContainer.BackgroundTransparency = 0.32
	statusBadgeContainer.BorderSizePixel = 0
	statusBadgeContainer.ZIndex = 22
	statusBadgeContainer.Parent = pillFrame
	Instance.new("UICorner", statusBadgeContainer).CornerRadius = UDim.new(1, 0)
	createCleanBorderStroke(statusBadgeContainer, Color3.fromRGB(142, 118, 64), 1, 0.48)

	local statusIconImg = Instance.new("ImageLabel")
	statusIconImg.Name = "TransplantedStatusIcon"
	statusIconImg.AnchorPoint = Vector2.new(0, 0.5)
	statusIconImg.Position = UDim2.new(0, 7, 0.5, 0)
	statusIconImg.Size = UDim2.new(0, 15, 0, 15)
	statusIconImg.BackgroundTransparency = 1
	statusIconImg.Image = ""
	statusIconImg.Visible = false
	statusIconImg.ScaleType = Enum.ScaleType.Fit
	statusIconImg.ZIndex = 23
	statusIconImg.Parent = statusBadgeContainer

	local centerStatusLabel = Instance.new("TextLabel")
	centerStatusLabel.Name = "StatusText"
	centerStatusLabel.AnchorPoint = Vector2.new(0, 0.5)
	centerStatusLabel.Position = UDim2.new(0, 12, 0.5, 0)
	centerStatusLabel.Size = UDim2.new(1, -18, 1, 0)
	centerStatusLabel.BackgroundTransparency = 1
	centerStatusLabel.Font = Enum.Font.GothamBold
	centerStatusLabel.TextColor3 = SOFT_WARM_CREAM
	centerStatusLabel.TextStrokeTransparency = 1
	centerStatusLabel.TextSize = 11.5
	centerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	centerStatusLabel.Text = "Đang rảnh"
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
	rightArrow.ImageColor3 = SOFT_MUTED_TAUPE
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

	trackConn(expandPanel:GetPropertyChangedSignal("Position"):Connect(function()
		if isAlive() and expandPanel.Position ~= PINNED_DRAWER_POS then
			expandPanel.Position = PINNED_DRAWER_POS
		end
	end))

	applyLiquidGlass(expandPanel, UDim.new(0, 18), 0.14, 1.25)

	local expLogoHolder = Instance.new("Frame")
	expLogoHolder.Position = UDim2.new(0, 12, 0, 10)
	expLogoHolder.Size = UDim2.new(0, 28, 0, 28)
	expLogoHolder.BackgroundTransparency = 1
	expLogoHolder.BorderSizePixel = 0
	expLogoHolder.ZIndex = 32
	expLogoHolder.Parent = expandPanel
	buildFullCatGoldCoin(expLogoHolder, 1.6, 33)

	local expTitle = Instance.new("TextLabel")
	expTitle.Position = UDim2.new(0, 48, 0, 9)
	expTitle.Size = UDim2.new(0, 180, 0, 15)
	expTitle.BackgroundTransparency = 1
	expTitle.Font = Enum.Font.GothamBold
	expTitle.TextSize = 11.5
	expTitle.TextColor3 = GOLD_BRIGHT_TITLE
	expTitle.TextStrokeTransparency = 1
	expTitle.TextXAlignment = Enum.TextXAlignment.Left
	expTitle.Text = "BANANA HUB • LIQUID GLASS"
	expTitle.ZIndex = 33
	expTitle.Parent = expandPanel
	applyGoldGradientToTitle(expTitle)

	local expSubBadge = Instance.new("TextLabel")
	expSubBadge.Position = UDim2.new(0, 48, 0, 24)
	expSubBadge.Size = UDim2.new(0, 180, 0, 12)
	expSubBadge.BackgroundTransparency = 1
	expSubBadge.Font = Enum.Font.GothamMedium
	expSubBadge.TextSize = 8.5
	expSubBadge.TextColor3 = SOFT_MUTED_TAUPE
	expSubBadge.TextStrokeTransparency = 1
	expSubBadge.TextXAlignment = Enum.TextXAlignment.Left
	expSubBadge.Text = "● ÂM THANH MỞ SẴN • CHỐNG LAG 100%"
	expSubBadge.ZIndex = 33
	expSubBadge.Parent = expandPanel

	local collapseBtn = Instance.new("TextButton")
	collapseBtn.Name = "CollapseIslandBtn"
	collapseBtn.Position = UDim2.new(1, -78, 0, 11)
	collapseBtn.Size = UDim2.new(0, 66, 0, 22)
	collapseBtn.BackgroundColor3 = LIQUID_GLASS_CARD
	collapseBtn.BackgroundTransparency = 0.28
	collapseBtn.BorderSizePixel = 0
	collapseBtn.Text = "Thu gọn ▲"
	collapseBtn.Font = Enum.Font.GothamMedium
	collapseBtn.TextSize = 9.5
	collapseBtn.TextColor3 = SOFT_WARM_CREAM
	collapseBtn.TextStrokeTransparency = 1
	collapseBtn.AutoButtonColor = false
	collapseBtn.ZIndex = 34
	collapseBtn.Parent = expandPanel
	Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(1, 0)
	createCleanBorderStroke(collapseBtn, Color3.fromRGB(130, 112, 68), 1, 0.45)

	local liveStatusCard = Instance.new("Frame")
	liveStatusCard.Name = "LiveStatusCard"
	liveStatusCard.Position = UDim2.new(0, 12, 0, 44)
	liveStatusCard.Size = UDim2.new(1, -24, 0, 28)
	liveStatusCard.BackgroundColor3 = LIQUID_GLASS_CARD
	liveStatusCard.BackgroundTransparency = 0.30
	liveStatusCard.BorderSizePixel = 0
	liveStatusCard.ZIndex = 32
	liveStatusCard.Parent = expandPanel
	Instance.new("UICorner", liveStatusCard).CornerRadius = UDim.new(0, 8)
	createCleanBorderStroke(liveStatusCard, Color3.fromRGB(135, 112, 62), 1, 0.48)

	local cardStatusLbl = Instance.new("TextLabel")
	cardStatusLbl.Name = "CardStatusText"
	cardStatusLbl.Position = UDim2.new(0, 12, 0, 0)
	cardStatusLbl.Size = UDim2.new(1, -20, 1, 0)
	cardStatusLbl.BackgroundTransparency = 1
	cardStatusLbl.Font = Enum.Font.GothamBold
	cardStatusLbl.TextSize = 11
	cardStatusLbl.TextColor3 = SOFT_WARM_CREAM
	cardStatusLbl.TextStrokeTransparency = 1
	cardStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
	cardStatusLbl.TextTruncate = Enum.TextTruncate.AtEnd
	cardStatusLbl.Text = "Đang rảnh"
	cardStatusLbl.ZIndex = 33
	cardStatusLbl.Parent = liveStatusCard

	local langTrack = Instance.new("Frame")
	langTrack.Name = "LanguageGlassTrack"
	langTrack.Position = UDim2.new(0, 12, 0, 78)
	langTrack.Size = UDim2.new(1, -24, 0, 30)
	langTrack.BackgroundColor3 = LIQUID_GLASS_TRACK
	langTrack.BackgroundTransparency = 0.35
	langTrack.BorderSizePixel = 0
	langTrack.ZIndex = 32
	langTrack.Parent = expandPanel
	Instance.new("UICorner", langTrack).CornerRadius = UDim.new(0, 8)
	createCleanBorderStroke(langTrack, Color3.fromRGB(115, 96, 56), 1, 0.52)

	local btnVI = Instance.new("TextButton")
	btnVI.Name = "BtnVietnamese"
	btnVI.Position = UDim2.new(0, 3, 0, 3)
	btnVI.Size = UDim2.new(0.5, -5, 1, -6)
	btnVI.BorderSizePixel = 0
	btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
	btnVI.BackgroundTransparency = (State.Language == "VI") and 0.15 or 0.35
	btnVI.Font = Enum.Font.GothamBold
	btnVI.Text = "🇻🇳 Tiếng Việt"
	btnVI.TextSize = 10.5
	btnVI.TextColor3 = (State.Language == "VI") and SOFT_WARM_CREAM or SOFT_MUTED_TAUPE
	btnVI.TextStrokeTransparency = 1
	btnVI.AutoButtonColor = false
	btnVI.ZIndex = 34
	btnVI.Parent = langTrack
	Instance.new("UICorner", btnVI).CornerRadius = UDim.new(0, 6)
	local btnVIStroke = createCleanBorderStroke(
		btnVI,
		(State.Language == "VI") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE,
		1,
		(State.Language == "VI") and 0.28 or 0.60
	)

	local btnEN = Instance.new("TextButton")
	btnEN.Name = "BtnEnglish"
	btnEN.Position = UDim2.new(0.5, 2, 0, 3)
	btnEN.Size = UDim2.new(0.5, -5, 1, -6)
	btnEN.BorderSizePixel = 0
	btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
	btnEN.BackgroundTransparency = (State.Language == "EN") and 0.15 or 0.35
	btnEN.Font = Enum.Font.GothamBold
	btnEN.Text = "🇺🇸 English"
	btnEN.TextSize = 10.5
	btnEN.TextColor3 = (State.Language == "EN") and SOFT_WARM_CREAM or SOFT_MUTED_TAUPE
	btnEN.TextStrokeTransparency = 1
	btnEN.AutoButtonColor = false
	btnEN.ZIndex = 34
	btnEN.Parent = langTrack
	Instance.new("UICorner", btnEN).CornerRadius = UDim.new(0, 6)
	local btnENStroke = createCleanBorderStroke(
		btnEN,
		(State.Language == "EN") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE,
		1,
		(State.Language == "EN") and 0.28 or 0.60
	)

	-- Hàng nút chức năng: ĐÃ XOÁ NÚT TẮT/BẬT ÂM THANH (MẶC ĐỊNH MỞ),
	-- nút "Làm mới & Đồng bộ" trải rộng toàn hàng với nền Liquid Glass & chữ sắc nét không chói mắt!
	local actionRow = Instance.new("Frame")
	actionRow.Name = "ActionRow"
	actionRow.Position = UDim2.new(0, 12, 0, 114)
	actionRow.Size = UDim2.new(1, -24, 0, 26)
	actionRow.BackgroundTransparency = 1
	actionRow.ZIndex = 32
	actionRow.Parent = expandPanel

	local rescanBtn = Instance.new("TextButton")
	rescanBtn.Name = "RescanTranslateBtn"
	rescanBtn.Position = UDim2.new(0, 0, 0, 0)
	rescanBtn.Size = UDim2.new(1, 0, 1, 0)
	rescanBtn.BackgroundColor3 = LIQUID_GLASS_CARD
	rescanBtn.BackgroundTransparency = 0.22
	rescanBtn.BorderSizePixel = 0
	rescanBtn.Font = Enum.Font.GothamMedium
	rescanBtn.TextSize = 10
	rescanBtn.TextColor3 = SOFT_WARM_CREAM
	rescanBtn.TextStrokeTransparency = 1
	rescanBtn.Text = "⚡ Làm mới & Đồng bộ"
	rescanBtn.AutoButtonColor = false
	rescanBtn.ZIndex = 34
	rescanBtn.Parent = actionRow
	Instance.new("UICorner", rescanBtn).CornerRadius = UDim.new(0, 7)
	createCleanBorderStroke(rescanBtn, Color3.fromRGB(168, 142, 82), 1, 0.35)

	local noteToggleBtn = Instance.new("TextButton")
	noteToggleBtn.Name = "SettingNoteToggleBtn"
	noteToggleBtn.Position = UDim2.new(0, 12, 0, 144)
	noteToggleBtn.Size = UDim2.new(1, -24, 0, 22)
	noteToggleBtn.BackgroundColor3 = LIQUID_GLASS_TRACK
	noteToggleBtn.BackgroundTransparency = 0.35
	noteToggleBtn.BorderSizePixel = 0
	noteToggleBtn.Text = "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
	noteToggleBtn.Font = Enum.Font.GothamMedium
	noteToggleBtn.TextSize = 9
	noteToggleBtn.TextColor3 = SOFT_MUTED_TAUPE
	noteToggleBtn.TextStrokeTransparency = 1
	noteToggleBtn.AutoButtonColor = false
	noteToggleBtn.ZIndex = 33
	noteToggleBtn.Parent = expandPanel
	Instance.new("UICorner", noteToggleBtn).CornerRadius = UDim.new(0, 6)
	createCleanBorderStroke(noteToggleBtn, Color3.fromRGB(115, 96, 56), 1, 0.55)

	local noteDrawer = Instance.new("Frame")
	noteDrawer.Name = "SettingNoteDrawer"
	noteDrawer.Position = UDim2.new(0, 12, 0, 170)
	noteDrawer.Size = UDim2.new(1, -24, 0, 80)
	noteDrawer.BackgroundColor3 = LIQUID_GLASS_CARD
	noteDrawer.BackgroundTransparency = 0.30
	noteDrawer.BorderSizePixel = 0
	noteDrawer.Visible = false
	noteDrawer.ClipsDescendants = true
	noteDrawer.ZIndex = 33
	noteDrawer.Parent = expandPanel
	Instance.new("UICorner", noteDrawer).CornerRadius = UDim.new(0, 8)
	createCleanBorderStroke(noteDrawer, Color3.fromRGB(125, 102, 54), 1, 0.48)

	local ndHeader = Instance.new("TextLabel", noteDrawer)
	ndHeader.Position = UDim2.new(0, 8, 0, 4)
	ndHeader.Size = UDim2.new(1, -16, 0, 14)
	ndHeader.BackgroundTransparency = 1
	ndHeader.Font = Enum.Font.GothamBold
	ndHeader.TextSize = 9
	ndHeader.TextColor3 = SOFT_CHAMPAGNE_GOLD
	ndHeader.TextStrokeTransparency = 1
	ndHeader.TextXAlignment = Enum.TextXAlignment.Left
	ndHeader.Text = "🍌 BANANA HUB • LIQUID GLASS PREMIUM"
	ndHeader.ZIndex = 35

	local ndLine1 = Instance.new("TextLabel", noteDrawer)
	ndLine1.Position = UDim2.new(0, 8, 0, 20)
	ndLine1.Size = UDim2.new(1, -16, 0, 16)
	ndLine1.BackgroundTransparency = 1
	ndLine1.Font = Enum.Font.GothamMedium
	ndLine1.TextSize = 8.5
	ndLine1.TextColor3 = SOFT_WARM_CREAM
	ndLine1.TextStrokeTransparency = 1
	ndLine1.TextXAlignment = Enum.TextXAlignment.Left
	ndLine1.Text = "+ Xoá sạch ảnh mờ gốc lúc mới chạy & chống lộ viền vuông"
	ndLine1.ZIndex = 35

	local ndLine2 = Instance.new("TextLabel", noteDrawer)
	ndLine2.Position = UDim2.new(0, 8, 0, 38)
	ndLine2.Size = UDim2.new(1, -16, 0, 16)
	ndLine2.BackgroundTransparency = 1
	ndLine2.Font = Enum.Font.GothamMedium
	ndLine2.TextSize = 8.5
	ndLine2.TextColor3 = SOFT_MUTED_TAUPE
	ndLine2.TextStrokeTransparency = 1
	ndLine2.TextXAlignment = Enum.TextXAlignment.Left
	ndLine2.Text = "+ Liquid Glass đa lớp, âm thanh mặc định mở, chữ dịu mắt"
	ndLine2.ZIndex = 35

	local ndLine3 = Instance.new("TextLabel", noteDrawer)
	ndLine3.Position = UDim2.new(0, 8, 0, 56)
	ndLine3.Size = UDim2.new(1, -16, 0, 16)
	ndLine3.BackgroundTransparency = 1
	ndLine3.Font = Enum.Font.GothamMedium
	ndLine3.TextSize = 8.5
	ndLine3.TextColor3 = SOFT_MINT_PASTEL
	ndLine3.TextStrokeTransparency = 1
	ndLine3.TextXAlignment = Enum.TextXAlignment.Left
	ndLine3.Text = "+ Xoá trạng thái máy chạy -> Luôn giữ Đang rảnh (0% lag)"
	ndLine3.ZIndex = 35

	local function updatePillVisuals(forceUpdate)
		local displayTxt = formatIslandStatusText(State.CurrentRawStatus)
		local isIdleNow = isTreadmillOrIdleStatus(State.CurrentRawStatus)
		local curImg = (not isIdleNow) and (State.CurrentStatusImage or "") or ""

		if not forceUpdate and displayTxt == State.LastDisplayedPillText and curImg == State.LastDisplayedPillImg then
			return
		end
		State.LastDisplayedPillText = displayTxt
		State.LastDisplayedPillImg = curImg

		centerStatusLabel.Text = displayTxt
		cardStatusLbl.Text = displayTxt

		local hasCustomImg = (curImg ~= "")
		statusIconImg.Visible = hasCustomImg
		if hasCustomImg then
			statusIconImg.Image = curImg
			statusIconImg.ImageColor3 = State.CurrentStatusImageColor or Color3.fromRGB(255, 255, 255)
			statusIconImg.ImageRectOffset = State.CurrentStatusRectOffset or Vector2.new(0, 0)
			statusIconImg.ImageRectSize = State.CurrentStatusRectSize or Vector2.new(0, 0)
			centerStatusLabel.Position = UDim2.new(0, 26, 0.5, 0)
			centerStatusLabel.Size = UDim2.new(1, -32, 1, 0)
		else
			centerStatusLabel.Position = UDim2.new(0, 12, 0.5, 0)
			centerStatusLabel.Size = UDim2.new(1, -18, 1, 0)
		end

		if forceUpdate then
			expSubBadge.Text = (State.Language == "EN") and "● SOUND ON BY DEFAULT • 0% LAG" or "● ÂM THANH MỞ SẴN • CHỐNG LAG 100%"
			collapseBtn.Text = (State.Language == "EN") and "Collapse ▲" or "Thu gọn ▲"
			rescanBtn.Text = (State.Language == "EN") and "⚡ Refresh & Sync" or "⚡ Làm mới & Đồng bộ"
			if State.NoteOpen then
				noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Liquid Glass Info (Collapse) ▲" or "Thông tin Banana Hub Gold Premium (Thu gọn) ▲"
			else
				noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Liquid Glass Info (Click) ▼" or "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
			end

			btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
			btnVI.BackgroundTransparency = (State.Language == "VI") and 0.15 or 0.35
			btnVI.TextColor3 = (State.Language == "VI") and SOFT_WARM_CREAM or SOFT_MUTED_TAUPE
			btnVIStroke.Color = (State.Language == "VI") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
			btnVIStroke.Transparency = (State.Language == "VI") and 0.28 or 0.60

			btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
			btnEN.BackgroundTransparency = (State.Language == "EN") and 0.15 or 0.35
			btnEN.TextColor3 = (State.Language == "EN") and SOFT_WARM_CREAM or SOFT_MUTED_TAUPE
			btnENStroke.Color = (State.Language == "EN") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
			btnENStroke.Transparency = (State.Language == "EN") and 0.28 or 0.60
		end

		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(186, math.min(310, 92 + textLen * 7))
		if targetWidth ~= State.LastPillTargetWidth then
			State.LastPillTargetWidth = targetWidth
			TweenService:Create(
				pillFrame,
				TWEEN_FAST_OUT,
				{ Size = UDim2.new(0, targetWidth, 0, 38) }
			):Play()
		end
	end

	State.UpdateIslandVisuals = updatePillVisuals
	State.IslandGui = islandGui
	State.IslandPill = pillFrame
	State.IslandStatusLabel = centerStatusLabel
	State.IslandStatusIcon = statusIconImg

	trackConn(noteToggleBtn.Activated:Connect(function()
		playUiSound("tap")
		State.NoteOpen = not State.NoteOpen
		if State.NoteOpen then
			noteDrawer.Visible = true
			noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Liquid Glass Info (Collapse) ▲" or "Thông tin Banana Hub Gold Premium (Thu gọn) ▲"
			TweenService:Create(expandPanel, TWEEN_PANEL_OUT, {
				Size = UDim2.new(0, EXP_W, 0, OPEN_NOTE_EXP_H)
			}):Play()
		else
			noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Liquid Glass Info (Click) ▼" or "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
			local tw = TweenService:Create(expandPanel, TWEEN_FAST_OUT, {
				Size = UDim2.new(0, EXP_W, 0, COLLAPSED_EXP_H)
			})
			tw:Play()
			if tw.Completed then
				tw.Completed:Connect(function()
					if not State.NoteOpen then noteDrawer.Visible = false end
				end)
			end
		end
	end))

	trackConn(rescanBtn.Activated:Connect(function()
		playUiSound("action")
		if State.RefreshAllMenus then
			task.spawn(State.RefreshAllMenus)
		end
		updatePillVisuals(true)
	end))

	local lastToggleClock = -10
	local function toggleIslandExpand()
		if os.clock() - lastToggleClock < 0.14 then return end
		lastToggleClock = os.clock()
		State.IsExpanded = not State.IsExpanded
		playCircularLogoPulse(pillCoinDisc, pillOrbStroke, 1.8)

		if State.IsExpanded then
			expandPanel.Position = PINNED_DRAWER_POS
			local targetH = State.NoteOpen and OPEN_NOTE_EXP_H or COLLAPSED_EXP_H
			expandPanel.Visible = true
			TweenService:Create(expandPanel, TWEEN_PANEL_OUT, { Size = UDim2.new(0, EXP_W, 0, targetH) }):Play()
			TweenService:Create(rightArrow, TWEEN_FAST_OUT, { Rotation = 180 }):Play()
		else
			TweenService:Create(rightArrow, TWEEN_FAST_OUT, { Rotation = 0 }):Play()
			expandPanel.Visible = false
		end
	end

	trackConn(pillClickBtn.Activated:Connect(toggleIslandExpand))
	trackConn(collapseBtn.Activated:Connect(toggleIslandExpand))

	trackConn(btnVI.Activated:Connect(function()
		playUiSound("action")
		if State.Language ~= "VI" then
			State.Language = "VI"
			updatePillVisuals(true)
			if State.RefreshAllMenus then
				task.spawn(State.RefreshAllMenus)
			end
		end
	end))

	trackConn(btnEN.Activated:Connect(function()
		playUiSound("action")
		if State.Language ~= "EN" then
			State.Language = "EN"
			updatePillVisuals(true)
			if State.RefreshAllMenus then
				task.spawn(State.RefreshAllMenus)
			end
		end
	end))

	updatePillVisuals(true)
	return islandGui
end

-- ============================================================================
-- 6. ĐỒNG BỘ TRẠNG THÁI (BỎ QUA 100% TREADMILL -> LUÔN GIỮ "ĐANG RẢNH")
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

local function hideOriginalStatusBadgeCompletely(badgeFrame)
	if not badgeFrame or not badgeFrame:IsA("GuiObject") then return end
	if badgeFrame:GetAttribute("__HiddenByBanana") == SID then return end
	badgeFrame:SetAttribute("__HiddenByBanana", SID)
	pcall(function()
		badgeFrame.Visible = false
	end)
	trackConn(badgeFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if isAlive() and badgeFrame.Visible then
			pcall(function() badgeFrame.Visible = false end)
		end
	end))
end

local function syncStatusFromLiveWidgets()
	if not isAlive() then return end
	local txtObj = State.LiveFiggyTextLabel
	local imgObj = State.LiveFiggyImageLabel

	local rawText = (txtObj and txtObj.Parent and txtObj.Text) or "Idle"

	if isTreadmillOrIdleStatus(rawText) then
		if State.LastSyncedRawText == "Idle" then
			return
		end
		State.LastSyncedRawText = "Idle"
		State.CurrentRawStatus = "Idle"
		State.CurrentStatusImage = ""
		if State.UpdateIslandVisuals then
			pcall(State.UpdateIslandVisuals, false)
		end
		return
	end

	local rawImg = (imgObj and imgObj.Parent and imgObj.Image) or ""
	if rawText == State.LastSyncedRawText and rawImg == State.LastSyncedRawImg then
		return
	end
	State.LastSyncedRawText = rawText
	State.LastSyncedRawImg = rawImg

	State.CurrentRawStatus = rawText
	if rawImg ~= "" and imgObj then
		State.CurrentStatusImage = rawImg
		State.CurrentStatusImageColor = imgObj.ImageColor3 or Color3.fromRGB(255, 255, 255)
		State.CurrentStatusRectOffset = imgObj.ImageRectOffset or Vector2.new(0, 0)
		State.CurrentStatusRectSize = imgObj.ImageRectSize or Vector2.new(0, 0)
	end

	if State.UpdateIslandVisuals then
		pcall(State.UpdateIslandVisuals, false)
	end
end

-- ============================================================================
-- 7. NHẬN DIỆN NÚT CỦ HÀNH TÍM TỨC THỜI (0% LỘ ẢNH MỜ GỐC LÚC MỚI CHẠY)
-- ============================================================================
local function hasPurpleVisualInside(btn)
	if btn.BackgroundTransparency < 0.95 and isFiggyPurpleColor(btn.BackgroundColor3) then
		return true
	end
	if hasPurpleGradient(btn) then
		return true
	end
	for _, d in ipairs(btn:GetDescendants()) do
		if d:IsA("Frame") or d:IsA("ImageLabel") or d:IsA("ImageButton") then
			if d.BackgroundTransparency < 0.95 and isFiggyPurpleColor(d.BackgroundColor3) then
				return true
			end
			if hasPurpleGradient(d) then
				return true
			end
			if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.ImageTransparency < 0.95 and isFiggyPurpleColor(d.ImageColor3) then
				return true
			end
		elseif d:IsA("UIStroke") and isFiggyPurpleColor(d.Color) then
			return true
		end
	end
	return false
end

local function isPurpleOnionSquareButton(btn, isInsideVerifiedFiggyGui)
	if not btn or not btn.Parent then return false end
	if not (btn:IsA("Frame") or btn:IsA("ImageButton") or btn:IsA("TextButton") or btn:IsA("CanvasGroup")) then return false end

	if btn:FindFirstChild("BananaCatCircleAvatar") or (btn.Parent and btn.Parent:FindFirstChild("BananaCatCircleAvatar")) then
		return false
	end

	local bw, bh = btn.AbsoluteSize.X, btn.AbsoluteSize.Y
	if bw < 28 or bw > 82 or bh < 28 or bh > 82 or math.abs(bw - bh) > 10 then
		return false
	end

	for _, d in ipairs(btn:GetDescendants()) do
		if d:IsA("TextLabel") and (d.Text or ""):match("%S") ~= nil then
			return false
		end
	end

	local par = btn.Parent
	local isTopLevel = par:IsA("ScreenGui") or (par:IsA("Frame") and par.Parent and par.Parent:IsA("ScreenGui") and par.BackgroundTransparency >= 0.99)

	if isInsideVerifiedFiggyGui and isTopLevel then
		local hasImg = (btn:IsA("ImageButton") or btn:FindFirstChildWhichIsA("ImageLabel", true) ~= nil or btn:FindFirstChildWhichIsA("ImageButton", true) ~= nil)
		if hasImg then
			return true
		end
	end

	-- Nếu nút nổi ở cấp cao nhất có màu tím đặc trưng của Figgy Hub (dù ở bên trái hay bên phải màn hình)
	if isTopLevel and hasPurpleVisualInside(btn) then
		return true
	end

	local vpW = getViewportWidth()
	if btn.AbsolutePosition.X >= vpW * 0.75 then
		if hasPurpleVisualInside(btn) then
			return true
		end

		if btn.AbsolutePosition.X >= vpW * 0.82 and btn.AbsolutePosition.Y >= 60 and btn.AbsolutePosition.Y <= 220 then
			local rootGui = btn:FindFirstAncestorOfClass("ScreenGui")
			if rootGui then
				local alignedBelowCount = 0
				local alignedAboveCount = 0
				for _, other in ipairs(rootGui:GetDescendants()) do
					if other ~= btn and not other:IsDescendantOf(btn) and not btn:IsDescendantOf(other) then
						if other:IsA("ImageButton") or other:IsA("TextButton") or other:IsA("Frame") then
							local ow, oh = other.AbsoluteSize.X, other.AbsoluteSize.Y
							if math.abs(ow - bw) <= 8 and math.abs(oh - bh) <= 8 and math.abs(other.AbsolutePosition.X - btn.AbsolutePosition.X) <= 10 then
								local dy = other.AbsolutePosition.Y - btn.AbsolutePosition.Y
								if dy > 24 and dy < 200 then
									alignedBelowCount = alignedBelowCount + 1
								elseif dy < -24 and dy > -200 then
									alignedAboveCount = alignedAboveCount + 1
								end
							end
						end
					end
				end
				if alignedAboveCount == 0 and alignedBelowCount >= 2 then
					return true
				end
			end
		end
	end

	return false
end

local function scanPurpleOnionButtonsOnce()
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local gName = gui.Name or ""
				if not IGNORED_SCREEN_GUIS[gName] and not gName:find("^Old_") and not gui:IsA("BillboardGui") and not gui:IsA("SurfaceGui") and not isDeltaOrExecutorGui(gui) then
					local isVerifiedFiggy = isFiggyWindowGui(gui)
					local okD, desc = pcall(function() return gui:GetDescendants() end)
					if okD and type(desc) == "table" then
						for _, d in ipairs(desc) do
							if isPurpleOnionSquareButton(d, isVerifiedFiggy) then
								decoratePurpleOnionButton(d, 2.0)
							end
						end
					end
				end
			end
		end
	end
end

-- ============================================================================
-- 8. TIÊU ĐỀ HEADER, BIND LOGO VÀ VIỆT HÓA TỨC THỜI (0% LAG)
-- ============================================================================
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

	for _, d in ipairs(headerContainer:GetDescendants()) do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Name ~= "BananaCatInnerSprite" and d.Parent ~= State.LiveFiggyBadgeFrame then
			local box = (d.Parent and d.Parent:IsA("GuiObject") and d.Parent.AbsoluteSize.X <= 46 and d.Parent.AbsoluteSize.Y <= 46) and d.Parent or d
			local bw, bh = box.AbsoluteSize.X, box.AbsoluteSize.Y
			local isSmallSquare = (bw >= 16 and bw <= 46 and bh >= 16 and bh <= 46 and math.abs(bw - bh) <= 8)
			local isLeftOfTitle = (box.AbsolutePosition.X <= titleLbl.AbsolutePosition.X + 10)
			local isSameRow = (math.abs(box.AbsolutePosition.Y - titleLbl.AbsolutePosition.Y) <= 24)
			if isSmallSquare and isLeftOfTitle and isSameRow then
				decoratePurpleOnionButton(box, 1.6)
				break
			end
		end
	end

	for _, desc in ipairs(headerContainer:GetDescendants()) do
		if desc:IsA("Frame") and not desc:FindFirstChildWhichIsA("TextBox") and not desc:FindFirstChild("BananaCatCircleAvatar") then
			if not desc:IsAncestorOf(titleLbl) and desc ~= titleLbl.Parent then
				local candidateTxt = nil
				local candidateImg = nil

				for _, ch in ipairs(desc:GetDescendants()) do
					if (ch:IsA("ImageLabel") or ch:IsA("ImageButton")) and ch.Name ~= "BananaCatInnerSprite" then
						candidateImg = ch
					elseif ch:IsA("TextLabel") then
						local t = (ch.Text or ""):match("^%s*(.-)%s*$") or ""
						if t ~= "" and not isIgnoredHeaderLabel(t) and (#t > 4 or t:find("%w")) then
							candidateTxt = ch
						end
					end
				end

				if candidateTxt then
					if State.LiveFiggyTextLabel ~= candidateTxt then
						State.LiveFiggyTextLabel = candidateTxt
						State.LiveFiggyImageLabel = candidateImg
						State.LiveFiggyBadgeFrame = desc

						local orig = candidateTxt:GetAttribute("__FiggyOrigText")
						if orig and orig ~= "" then
							pcall(function() candidateTxt.Text = orig end)
						end

						trackConn(candidateTxt:GetPropertyChangedSignal("Text"):Connect(syncStatusFromLiveWidgets))
					end
					hideOriginalStatusBadgeCompletely(desc)
					syncStatusFromLiveWidgets()
					return true
				end
			end
		end
	end
	return false
end

local function styleElementGoldOnce(obj)
	if not obj or not obj.Parent then return end
	if obj:GetAttribute("__StyledGoldOnce") == SID then return end
	obj:SetAttribute("__StyledGoldOnce", SID)

	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end
	if obj.Name == "BananaCatCircleAvatar" or obj.Name == "BananaCatInnerSprite" or obj.Name == "LuxuryGoldCircleStroke" then return end

	if State.LiveFiggyBadgeFrame and (obj == State.LiveFiggyBadgeFrame or obj:IsDescendantOf(State.LiveFiggyBadgeFrame)) then
		return
	end

	pcall(function()
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			local curCol = obj.TextColor3
			if isFiggyPurpleColor(curCol) then
				obj.TextColor3 = SOFT_CHAMPAGNE_GOLD
			end
		elseif obj:IsA("Frame") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
			local curBg = obj.BackgroundColor3
			if isFiggyPurpleColor(curBg) then
				obj.BackgroundColor3 = Color3.fromRGB(44, 38, 28)
			end
			if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and isFiggyPurpleColor(obj.ImageColor3) then
				obj.ImageColor3 = SOFT_CHAMPAGNE_GOLD
			end
		elseif obj:IsA("UIStroke") then
			if isFiggyPurpleColor(obj.Color) then
				obj.Color = Color3.fromRGB(150, 120, 65)
			end
		end

		local grad = obj:FindFirstChildOfClass("UIGradient")
		if grad and grad.Name ~= "LuxuryGoldGradient" and grad.Name ~= "LiquidGlassStrokeGrad" and grad.Name ~= "LiquidGlassBgGrad" and grad.Name ~= "CoinSurfaceGoldGrad" and grad.Name ~= "BananaGoldTitleGrad" then
			if hasPurpleGradient(obj) then
				applyMetallicGoldGradient(grad)
			end
		end
	end)
end

local function hookMenuButtonSound(inst)
	if not inst or not inst.Parent then return end
	if State.IslandGui and inst:IsDescendantOf(State.IslandGui) then return end
	if inst:GetAttribute("__FiggySfxHooked") == SID then return end
	if inst:GetAttribute("__BananaGoldPulseHooked") == SID then return end

	if inst:IsA("TextButton") or inst:IsA("ImageButton") then
		inst:SetAttribute("__FiggySfxHooked", SID)
		trackConn(inst.Activated:Connect(function()
			if isAlive() then
				playUiSound("tap")
			end
		end))
	end
end

local function translateMenuElementOnce(obj)
	if not obj or not obj.Parent then return end
	if obj == State.LiveFiggyTextLabel then return end
	if State.LiveFiggyBadgeFrame and obj:IsDescendantOf(State.LiveFiggyBadgeFrame) then return end

	local curText = obj.Text or ""
	if curText == "" then return end

	if obj:IsA("TextLabel") and (curText == "Figgy Hub" or curText == "Banana Hub" or curText == "FrostyFig") then
		if curText == "Figgy Hub" then
			obj:SetAttribute("__FiggyOrigText", "Figgy Hub")
		end
		pcall(applyGoldGradientToTitle, obj)
		pcall(bindHeaderAndLogosFromTitle, obj)
	end

	if isDynamicHeartbeatLabelText(curText) then
		return
	end

	if EXACT_VI[curText] and State.Language == "VI" and curText ~= "Figgy Hub" and curText ~= "Figgy" then
		obj:SetAttribute("__FiggyOrigText", VI_TO_EN[EXACT_VI[curText]] or curText)
	end

	if not obj:GetAttribute("__FiggyOrigText") then
		obj:SetAttribute("__FiggyOrigText", curText)
	end

	local origText = obj:GetAttribute("__FiggyOrigText") or curText
	local translated = translateStaticLabelText(origText, State.Language)

	if translated and translated ~= curText then
		pcall(function()
			obj.Text = translated
		end)
	end

	if obj:GetAttribute("__StaticTracked") ~= SID then
		obj:SetAttribute("__StaticTracked", SID)
		table.insert(State.StaticLabels, obj)
	end
end

local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	pcall(styleElementGoldOnce, obj)

	if obj:IsA("Frame") or obj:IsA("ImageButton") or obj:IsA("TextButton") then
		local rootGui = obj:FindFirstAncestorOfClass("ScreenGui")
		local isVerified = rootGui and (rootGui:GetAttribute("__VerifiedFiggyWindowGui") == true) or false
		if isPurpleOnionSquareButton(obj, isVerified) then
			pcall(decoratePurpleOnionButton, obj, 2.0)
		end
	elseif obj:IsA("ImageLabel") and obj.Parent and (obj.Parent:IsA("Frame") or obj.Parent:IsA("ImageButton")) then
		local rootGui = obj:FindFirstAncestorOfClass("ScreenGui")
		local isVerified = rootGui and (rootGui:GetAttribute("__VerifiedFiggyWindowGui") == true) or false
		if isPurpleOnionSquareButton(obj.Parent, isVerified) then
			pcall(decoratePurpleOnionButton, obj.Parent, 2.0)
		end
	end

	if obj:IsA("TextButton") or obj:IsA("ImageButton") then
		pcall(hookMenuButtonSound, obj)
	end

	if obj:IsA("TextBox") then
		local ph = obj.PlaceholderText or ""
		if ph ~= "" then
			if not obj:GetAttribute("__FiggyOrigPlaceholder") then
				obj:SetAttribute("__FiggyOrigPlaceholder", ph)
			end
			local basePh = obj:GetAttribute("__FiggyOrigPlaceholder") or ph
			local targetPh = translateStaticLabelText(basePh, State.Language)
			if targetPh and targetPh ~= ph then
				pcall(function() obj.PlaceholderText = targetPh end)
			end
		end
		return
	end

	if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then return end
	translateMenuElementOnce(obj)
end

local function refreshAllTranslatedMenus()
	for i = #State.StaticLabels, 1, -1 do
		local lbl = State.StaticLabels[i]
		if lbl and lbl.Parent then
			pcall(translateMenuElementOnce, lbl)
		else
			table.remove(State.StaticLabels, i)
		end
	end
	pcall(scanPurpleOnionButtonsOnce)
	State.LastSyncedRawText = nil
	pcall(syncStatusFromLiveWidgets)
end
State.RefreshAllMenus = refreshAllTranslatedMenus

local function hookTargetScreenGui(gui)
	if not gui or gui:GetAttribute("__FiggyGuiHooked") == SID then return end
	local okName, gName = pcall(function() return gui.Name end)
	if not okName or IGNORED_SCREEN_GUIS[gName] or gName:find("^Old_") then return end
	if not isFiggyWindowGui(gui) then return end

	if State.ActiveFiggyGui and State.ActiveFiggyGui.Parent and State.ActiveFiggyGui ~= gui then
		pcall(function()
			gui.Enabled = false
			gui:Destroy()
		end)
		return
	end
	State.ActiveFiggyGui = gui
	gui:SetAttribute("__FiggyGuiHooked", SID)

	-- Bắt tức thời từng phần tử ngay khi tạo trong 3.5 giây đầu, sau đó NGẮT HẲN để khi chơi 0% lag!
	local tempDescConn
	tempDescConn = gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		task.defer(function()
			if isAlive() and desc and desc.Parent then
				pcall(processGuiElement, desc)
			end
		end)
	end)
	trackConn(tempDescConn)
	task.delay(3.5, function()
		if tempDescConn then
			pcall(function() tempDescConn:Disconnect() end)
		end
	end)

	task.spawn(function()
		local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
		if okDesc and type(descendants) == "table" then
			for _, d in ipairs(descendants) do
				if d:IsA("TextLabel") and (d.Text == "Figgy Hub" or d.Text == "Banana Hub" or d.Text == "FrostyFig") then
					pcall(bindHeaderAndLogosFromTitle, d)
					break
				end
			end

			for i, d in ipairs(descendants) do
				if not isAlive() then break end
				pcall(processGuiElement, d)
				if i % 350 == 0 then
					task.wait()
				end
			end
		end
		pcall(scanPurpleOnionButtonsOnce)
	end)
end

-- Bắt nóng ScreenGui mới tạo ngay ở 0.0 giây (kể cả khi ScreenGui vừa gắn vào CoreGui và đang tạo các con bên trong)
local function watchCandidateGuiAtStartup(gui)
	if not gui or not gui:IsA("ScreenGui") then return end
	local gName = gui.Name or ""
	if IGNORED_SCREEN_GUIS[gName] or gName:find("^Old_") then return end
	if gui:GetAttribute("__StartupWatched") == SID then return end
	if isDeltaOrExecutorGui(gui) then return end
	gui:SetAttribute("__StartupWatched", SID)

	if isFiggyWindowGui(gui) then
		pcall(hookTargetScreenGui, gui)
		return
	end

	local earlyConn
	earlyConn = gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		task.defer(function()
			if not isAlive() or not desc or not desc.Parent then return end
			pcall(processGuiElement, desc)
			if gui:GetAttribute("__FiggyGuiHooked") ~= SID and isFiggyWindowGui(gui) then
				if earlyConn then pcall(function() earlyConn:Disconnect() end) end
				pcall(hookTargetScreenGui, gui)
			end
		end)
	end)
	trackConn(earlyConn)
	task.delay(8.0, function()
		if earlyConn then
			pcall(function() earlyConn:Disconnect() end)
		end
	end)
end

-- ============================================================================
-- 9. KHỞI CHẠY DYNAMIC ISLAND TRƯỚC & CHẶN 0.0 GIÂY LÚC TẢI SCRIPT GỐC
-- ============================================================================
createIndependentFiggyDynamicIsland()

local existingFiggyGui = cleanupPreviousOverlaysAndDeduplicate()

task.spawn(function()
	if existingFiggyGui and existingFiggyGui.Parent then
		pcall(hookTargetScreenGui, existingFiggyGui)
	end

	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				pcall(watchCandidateGuiAtStartup, gui)
			end
		end

		local rootAddConn
		rootAddConn = root.ChildAdded:Connect(function(newGui)
			if not isAlive() then return end
			pcall(watchCandidateGuiAtStartup, newGui)
		end)
		trackConn(rootAddConn)
		task.delay(12.0, function()
			if rootAddConn then
				pcall(function() rootAddConn:Disconnect() end)
			end
		end)
	end

	pcall(scanPurpleOnionButtonsOnce)

	-- Tải Figgy Hub SAU KHI toàn bộ bộ chặn 0.0s đã sẵn sàng -> Không bao giờ lộ ảnh mờ gốc!
	if not existingFiggyGui then
		pcall(function()
			loadstring(game:HttpGet(FIGGY_LOADER_URL))()
		end)
		task.wait(0.15)
		pcall(scanPurpleOnionButtonsOnce)
	end
end)
