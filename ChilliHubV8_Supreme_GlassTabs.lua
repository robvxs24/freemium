-- ============================================================================
-- BANANA HUB V1.0.6+ (LUXURY GOLD COIN EDITION) | XOÁ TRẠNG THÁI MÁY CHẠY - HIỆN ĐANG RẢNH
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- Khắc phục triệt để theo đúng yêu cầu:
-- 1. [XOÁ LUÔN TRẠNG THÁI MÁY CHẠY BỘ (TREADMILL) - LUÔN HIỆN "ĐANG RẢNH"]:
--    + Loại bỏ hoàn toàn trạng thái "Treadmill" / "Máy chạy bộ" và icon tia sét (⚡) khi bước
--      lên máy chạy. Khi lên máy chạy bộ, Dynamic Island bỏ qua mọi tín hiệu cập nhật từ máy chạy
--      và giữ nguyên trạng thái tĩnh "Đang rảnh" (0 lệnh cập nhật UI, 0 Tween, 0% CPU!).
-- 2. [NGẮT TOÀN BỘ SỰ KIỆN QUÉT NGẦM SAU KHI KHỞI TẠO (ZERO RUNTIME OVERHEAD)]:
--    + Tắt hoàn toàn `Visible = false` cho thanh trạng thái gốc trên Header để engine C++ của
--      Roblox không tính toán lại bố cục (Layout) khi chạy trên máy chạy.
--    + Tự động ngắt kết nối `DescendantAdded` ngay sau khi dịch xong menu lúc mới mở -> Trong lúc
--      bạn chơi và chạy trên máy chạy bộ, không có bất kỳ sự kiện quét UI nào chạy ngầm!
-- 3. [LOGO KÉO RỘNG HIỂN THỊ TRỌN VẸN 100% CON MÈO]:
--    + Khung đồng xu vàng 2 lớp với ảnh mèo kéo giãn ngang (Offset 85,0 - Size 250,420) lùi vào
--      86% lòng đồng xu giúp thấy hết toàn bộ con mèo từ chóp chuối tới 2 bàn chân.
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
State.SoundEnabled = (State.SoundEnabled ~= false)
State.IsExpanded = false
State.NoteOpen = false
State.StaticLabels = {}
State.CachedSounds = State.CachedSounds or {}
State.LastSyncedRawText = nil
State.LastSyncedRawImg = nil
State.LastDisplayedPillText = nil
State.LastPillTargetWidth = nil

-- ============================================================================
-- 1. KHÔI PHỤC NHÃN ĐỘNG TỪ BẢN CŨ & CHẶN 100% DELTA X
-- ============================================================================
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

local function isDeltaOrExecutorGui(gui)
	if not gui then return false end
	local cached = gui:GetAttribute("__IsExecutorGui")
	if cached ~= nil then return cached == true end

	local gName = string.lower(gui.Name or "")
	for _, kw in ipairs(EXECUTOR_KEYWORDS) do
		if string.find(gName, kw, 1, true) then
			gui:SetAttribute("__IsExecutorGui", true)
			return true
		end
	end

	local hasFiggyHeader = false
	local hasVersionOrQuickBar = false
	local hasExecutorMarker = false

	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if okD and type(desc) == "table" then
		for _, d in ipairs(desc) do
			local dName = string.lower(d.Name or "")
			if string.find(dName, "delta", 1, true) or string.find(dName, "executor", 1, true) then
				hasExecutorMarker = true
			end
			if d:IsA("TextLabel") or d:IsA("TextButton") then
				local t = d.Text or ""
				if t == "Figgy Hub" or t == "Banana Hub" or t == "FrostyFig" then
					hasFiggyHeader = true
				elseif t:find("^v%d+%.%d+") or t:find("^QUICK BAR %d+$") or t:find("^THANH NHANH %d+$") then
					hasVersionOrQuickBar = true
				else
					local lt = string.lower(t)
					if lt == "delta" or lt == "delta x" or lt == "scripthub" or lt == "executor" then
						hasExecutorMarker = true
					end
				end
			elseif d:IsA("TextBox") then
				local bt = d.Text or ""
				if #bt > 120 or string.find(bt, "loadstring", 1, true) then
					hasExecutorMarker = true
				end
			end
		end
	end

	local isExec = (hasExecutorMarker and not (hasFiggyHeader and hasVersionOrQuickBar))
	gui:SetAttribute("__IsExecutorGui", isExec)
	return isExec
end

local function isFiggyWindowGui(gui)
	if not gui then return false end
	if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then return false end
	local gName = gui.Name or ""
	if IGNORED_SCREEN_GUIS[gName] or gName:find("^Old_") then return false end
	if isDeltaOrExecutorGui(gui) then return false end
	if gui:GetAttribute("__VerifiedFiggyWindowGui") == true then return true end

	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end

	for _, d in ipairs(desc) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = d.Text or ""
			if t == "Figgy Hub" or t == "Banana Hub" or t == "FrostyFig"
				or t == "WHAT'S NEW" or t == "CÓ GÌ MỚI"
				or t == "AUTO STEAL" or t == "TỰ ĐỘNG CƯỚP TRỨNG"
				or t == "UFO SIGHTINGS" or t == "PHÁT HIỆN UFO"
				or t:find("^QUICK BAR %d+$") or t:find("^THANH NHANH %d+$")
			then
				gui:SetAttribute("__VerifiedFiggyWindowGui", true)
				return true
			end
		end
	end
	return false
end

local function cleanupPreviousOverlaysAndDeduplicate()
	local figgyGuis = {}
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local gName = gui.Name or ""
				if gName ~= "BananaDynamicIsland" and gName ~= "FiggyDynamicIsland" then
					pcall(function()
						for _, d in ipairs(gui:GetDescendants()) do
							if d.Name == "BananaCatFixedOverlay" or d.Name == "BananaCatCircleAvatar" or d.Name == "GoldBadgeInnerDisc" or d.Name == "BananaCatBadgeImage" or d.Name == "BananaCatInnerSprite" then
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
									local cor = par:FindFirstChildOfClass("UICorner")
									if cor and cor.CornerRadius == UDim.new(1, 0) then
										cor.CornerRadius = UDim.new(0, 8)
									end
								end
							elseif d:IsA("UIStroke") and (d.Name == "LuxuryGoldCircleStroke" or d.Name == "LuxuryGoldStroke") then
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
								else
									d:Destroy()
								end
							elseif d:IsA("TextLabel") then
								local orig = d:GetAttribute("__FiggyOrigText")
								if orig and (d.Text == "Máy chạy bộ" or d.Text == "Đang rảnh" or d.Text:find("bước/giây") or d.Text:find("^Phiên:")) then
									d.Text = orig
								end
							end
						end
					end)

					if isFiggyWindowGui(gui) then
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

local existingFiggyGui = cleanupPreviousOverlaysAndDeduplicate()
if not existingFiggyGui then
	task.spawn(function()
		loadstring(game:HttpGet(FIGGY_LOADER_URL))()
	end)
end

-- ============================================================================
-- 2. HỆ THỐNG ÂM THANH TƯƠNG TÁC (ZERO LATENCY)
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
-- 3. ĐỒNG XU VÀNG KÉO RỘNG & HIỂN THỊ TRỌN VẸN 100% CON MÈO BANANA CAT
-- ============================================================================
local BANANA_CAT_ASSET_ID = "87447945720038"
local BANANA_CAT_LOGO     = "rbxthumb://type=Asset&id=" .. BANANA_CAT_ASSET_ID .. "&w=420&h=420"
local DOWN_ARROW_ICON     = "rbxassetid://6031091004"

-- Cắt bỏ lề trắng thừa 2 bên (x = 85..335 -> rộng 250) nhưng giữ 100% chiều dọc từ chóp chuối
-- tới 2 bàn chân (y = 0..420 -> cao 420), rồi kéo giãn ngang (Stretch) trong khung 86%
local STRETCH_CAT_OFFSET  = Vector2.new(85, 0)
local STRETCH_CAT_SIZE    = Vector2.new(250, 420)

local GOLD_PRIMARY_TEXT   = Color3.fromRGB(240, 210, 124)
local GOLD_BRIGHT_TITLE   = Color3.fromRGB(248, 218, 108)
local GOLD_ACCENT_FILL    = Color3.fromRGB(198, 154, 52)
local GOLD_BORDER_STROKE  = Color3.fromRGB(224, 178, 68)
local GOLD_SOFT_CREAM     = Color3.fromRGB(226, 218, 202)
local GOLD_MUTED_SUBTEXT  = Color3.fromRGB(156, 148, 130)

local ISLAND_BG_DARK      = Color3.fromRGB(16, 16, 20)
local ISLAND_CARD_BG      = Color3.fromRGB(24, 23, 20)
local BTN_ACTIVE_BG       = Color3.fromRGB(52, 42, 22)
local BTN_ACTIVE_STROKE   = Color3.fromRGB(196, 156, 62)
local BTN_ACTIVE_TEXT     = Color3.fromRGB(240, 208, 120)
local BTN_INACTIVE_BG     = Color3.fromRGB(24, 24, 28)
local BTN_INACTIVE_STROKE = Color3.fromRGB(52, 48, 42)

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

local function applyMetallicGoldGradient(target)
	if not target then return end
	local grad = target:FindFirstChild("LuxuryGoldGradient") or Instance.new("UIGradient")
	grad.Name = "LuxuryGoldGradient"
	grad.Rotation = 45
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 242, 175)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(222, 176, 66)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(142, 102, 24)),
	})
	grad.Parent = target
	return grad
end

local function applyCoinSurfaceGoldGradient(target)
	if not target then return end
	local grad = target:FindFirstChild("CoinSurfaceGoldGrad") or Instance.new("UIGradient")
	grad.Name = "CoinSurfaceGoldGrad"
	grad.Rotation = 65
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 242, 185)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(234, 190, 86)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(182, 134, 42)),
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
		TweenService:Create(
			coinDisc,
			TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0.82, 0, 0.82, 0) }
		):Play()
		if goldStroke then
			TweenService:Create(
				goldStroke,
				TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Thickness = defaultThick + 0.8, Transparency = 0 }
			):Play()
		end
		task.delay(0.085, function()
			if coinDisc and coinDisc.Parent then
				TweenService:Create(
					coinDisc,
					TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
					{ Size = UDim2.new(1, 0, 1, 0) }
				):Play()
			end
			if goldStroke and goldStroke.Parent then
				TweenService:Create(
					goldStroke,
					TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Thickness = defaultThick, Transparency = 0.05 }
				):Play()
			end
		end)
	end)
end

local function getOutermostSquareButton(obj)
	local cur = obj
	for _ = 1, 2 do
		local par = cur and cur.Parent
		if par and (par:IsA("Frame") or par:IsA("ImageButton") or par:IsA("TextButton")) then
			if not par:FindFirstChildOfClass("UIListLayout") and not par:FindFirstChildOfClass("UIGridLayout") then
				local pw, ph = par.AbsoluteSize.X, par.AbsoluteSize.Y
				if pw >= 28 and pw <= 84 and ph >= 28 and ph <= 84 and math.abs(pw - ph) <= 10 then
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

local function decoratePurpleOnionButton(rawTarget, strokeThickness)
	local container = getOutermostSquareButton(rawTarget)
	if not container or not container:IsA("GuiObject") then return end
	local cw, ch = container.AbsoluteSize.X, container.AbsoluteSize.Y
	if cw > 84 or ch > 84 or cw < 14 or ch < 14 then return end
	if container:FindFirstChild("BananaCatCircleAvatar") then return end

	for _, desc in ipairs(container:GetDescendants()) do
		if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) and desc.Name ~= "BananaCatInnerSprite" then
			pcall(function() desc.ImageTransparency = 1; desc.BackgroundTransparency = 1 end)
			if desc:GetAttribute("__HideOrigFigConnected") ~= SID then
				desc:SetAttribute("__HideOrigFigConnected", SID)
				trackConn(desc:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
					if isAlive() and desc.ImageTransparency < 0.99 then
						pcall(function() desc.ImageTransparency = 1 end)
					end
				end))
			end
		elseif desc:IsA("UIStroke") then
			pcall(function() desc.Transparency = 1 end)
		elseif desc:IsA("Frame") and desc.Name ~= "BananaCatCircleAvatar" then
			pcall(function() desc.BackgroundTransparency = 1 end)
		end
	end

	pcall(function()
		container.BackgroundTransparency = 1
		if container:IsA("ImageLabel") or container:IsA("ImageButton") then
			container.ImageTransparency = 1
		end
	end)

	local thick = strokeThickness or 2.0
	local coinDisc, stroke = buildFullCatGoldCoin(container, thick, (container.ZIndex or 5) + 8)

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
	["Steal an Egg"] = "Cướp Trứng",
	["Steal An Egg"] = "Cướp Trứng",
	["steal an egg"] = "Cướp Trứng",
	["Lemon"] = "Vàng Hoàng Gia (Gold)",

	-- Trạng thái (Treadmill được quy thẳng về Đang rảnh theo đúng yêu cầu!)
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

	-- Tab Trang Chủ (Home)
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

	-- Nội dung What's New
	["v1.05: New Pet Finder above Shop with live logs, Min Value, Min Rarity, Auto Join, Force Join and a settings page with Sort By, age limits, new log alerts and an option to hide the server full popup. Pets and buttons have a springy hover, and the fig logo uses it too and plays its animation when you hover or click it. Fixed UFO eggs not being delivered, and debris is now collected inside the Rare UFO instead of on its roof."] = "v1.05: Thêm tính năng Tìm Thú Cưng (Pet Finder) phía trên Cửa Hàng với nhật ký trực tiếp, Giá trị tối thiểu, Độ hiếm tối thiểu, Tự động vào, Ép vào server và trang cài đặt Sắp xếp, giới hạn thời gian, âm báo mới cùng tùy chọn ẩn thông báo đầy máy chủ. Thú cưng, nút bấm và logo Banana Hub có hiệu ứng chuyển động đàn hồi mượt mà khi chạm. Đã sửa lỗi không giao trứng UFO và tự thu thập mảnh vỡ bên trong UFO Hiếm.",
	["v1.04: Language setting in Settings > Interface: the hub in 18 languages, using Roblox's own translations first. The fig logo plays its animation on click or tap, and dragging it moves the window. Fixed a hidden error that could make the menu stutter after some actions."] = "v1.04: Hỗ trợ đa ngôn ngữ trong Cài Đặt > Giao Diện và tích hợp trình dịch tự động Banana Hub. Logo phát hoạt ảnh khi chạm và hỗ trợ kéo để di chuyển cửa sổ. Đã khắc phục lỗi ẩn gây khựng menu sau một số thao tác.",

	-- Tính năng Finder (Pet Finder)
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

	-- Tab Trứng
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
	if enKey ~= "Figgy Hub" and enKey ~= "figgy hub" and enKey ~= "FIGGY HUB" and enKey ~= "Figgy" and lk ~= "treadmill" then
		if not VI_TO_EN[viVal] then
			VI_TO_EN[viVal] = enKey
		end
		local lv = string.lower(viVal)
		if not VI_TO_EN[lv] then
			VI_TO_EN[lv] = enKey
		end
	end
end

local STATIC_GRAMMAR_VI = {
	{ pat = "^Figgy%s+SAE%s*%-%s*[Uu]pdate%s+(.+)$", rep = "Banana Hub - Bản cập nhật %1" },
	{ pat = "^(%d+)%s+hours?%s+ago$", rep = "%1 giờ trước" },
	{ pat = "^(%d+)%s+minutes?%s+ago$", rep = "%1 phút trước" },
	{ pat = "^(%d+)%s+days?%s+ago$", rep = "%1 ngày trước" },
	{ pat = "^[Tt]his%s+session$", rep = "trong phiên này" },
	{ pat = "^[Tt]his%s+PHIÊN%s+CHƠI$", rep = "trong phiên này" },
	{ pat = "^[Mm]ove%s+[Tt]o%s+[Ee]gg$", rep = "Di chuyển tới trứng" },
	{ pat = "^[Gg]o%s+[Tt]o%s+[Ee]gg$", rep = "Di chuyển tới trứng" },
	{ pat = "^[Ss]ell%s+[Cc]heapest%s+[Ee]gg$", rep = "Bán trứng rẻ nhất khi đầy túi" },
	{ pat = "^[Mm]akes%s+room%s+when%s+the%s+.-%s+is%s+full$", rep = "Tự bán dọn chỗ khi túi trứng đầy" },
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
}

-- Kiểm tra xem một trạng thái có phải là Máy Chạy Bộ (Treadmill) hoặc Đang Rảnh (Idle) không
local function isTreadmillOrIdleStatus(s)
	if not s or s == "" then return true end
	local low = string.lower(s)
	if low == "idle" or low == "đang rảnh" or low == "treadmill" or low == "máy chạy bộ" or low == "running" then
		return true
	end
	if string.find(low, "treadmill", 1, true) or string.find(low, "máy chạy", 1, true) or string.find(low, "idle", 1, true) or string.find(low, "đang rảnh", 1, true) then
		return true
	end
	return false
end

local function isDynamicHeartbeatLabelText(s)
	if not s or s == "" then return true end
	if not string.find(s, "%a%a") then return true end
	if isTreadmillOrIdleStatus(s) then return true end
	local low = string.lower(s)
	if string.find(low, "st/s", 1, true)
		or string.find(low, "bước/giây", 1, true)
		or string.find(low, "carrying ", 1, true)
		or string.find(low, "đang mang ", 1, true)
		or string.find(low, "holding ", 1, true)
		or string.find(low, "^session%s+%d")
		or string.find(low, "^phiên:%s+%d")
		or string.find(low, "^%d+%s+free$")
		or string.find(low, "^in%s+%d+m")
		or string.find(low, "^next%s+ufo")
	then
		return true
	end
	return false
end

local function translateStaticLabelText(rawText, targetLang)
	if type(rawText) ~= "string" or rawText == "" then return rawText end
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

		if trimmed:find("^v1%.05:%s+New Pet Finder") then
			return lead .. EXACT_VI["v1.05: New Pet Finder above Shop with live logs, Min Value, Min Rarity, Auto Join, Force Join and a settings page with Sort By, age limits, new log alerts and an option to hide the server full popup. Pets and buttons have a springy hover, and the fig logo uses it too and plays its animation when you hover or click it. Fixed UFO eggs not being delivered, and debris is now collected inside the Rare UFO instead of on its roof."] .. trail
		elseif trimmed:find("^v1%.04:%s+Language setting") then
			return lead .. EXACT_VI["v1.04: Language setting in Settings > Interface: the hub in 18 languages, using Roblox's own translations first. The fig logo plays its animation on click or tap, and dragging it moves the window. Fixed a hidden error that could make the menu stutter after some actions."] .. trail
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

-- Hàm định dạng trạng thái trên Dynamic Island:
-- Mọi trạng thái "Treadmill" / "Máy chạy bộ" đều bị XOÁ BỎ và hiển thị là "Đang rảnh"!
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
		local exact = EXACT_VI[clean] or LOWER_VI[low]
		return exact or clean
	end
end

-- ============================================================================
-- 5. THIẾT KẾ BANANA HUB DYNAMIC ISLAND (HIỂN THỊ TRỌN VẸN 100% CON MÈO)
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
	stroke.Thickness = strokeThickness or 1.3
	stroke.Transparency = 0.22
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	pcall(function() stroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize end)
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

	applyGoldMatteGlass(pillFrame, UDim.new(1, 0), 0.12, GOLD_BORDER_STROKE, 1.3)

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
	pcall(function() badgeInnerStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize end)
	badgeInnerStroke.Parent = statusBadgeContainer

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
	centerStatusLabel.TextColor3 = GOLD_PRIMARY_TEXT
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

	applyGoldMatteGlass(expandPanel, UDim.new(0, 18), 0.10, GOLD_BORDER_STROKE, 1.3)

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
	expSubBadge.Text = "● ĐÃ XOÁ TRẠNG THÁI MÁY CHẠY • 0% LAG"
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

	local cardStatusLbl = Instance.new("TextLabel")
	cardStatusLbl.Name = "CardStatusText"
	cardStatusLbl.Position = UDim2.new(0, 12, 0, 0)
	cardStatusLbl.Size = UDim2.new(1, -20, 1, 0)
	cardStatusLbl.BackgroundTransparency = 1
	cardStatusLbl.Font = Enum.Font.GothamBold
	cardStatusLbl.TextSize = 11
	cardStatusLbl.TextColor3 = GOLD_PRIMARY_TEXT
	cardStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
	cardStatusLbl.TextTruncate = Enum.TextTruncate.AtEnd
	cardStatusLbl.Text = "Đang rảnh"
	cardStatusLbl.ZIndex = 33
	cardStatusLbl.Parent = liveStatusCard

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
	ndHeader.Text = "🍌 BANANA HUB • LUXURY GOLD COIN"
	ndHeader.ZIndex = 35

	local ndLine1 = Instance.new("TextLabel", noteDrawer)
	ndLine1.Position = UDim2.new(0, 8, 0, 20)
	ndLine1.Size = UDim2.new(1, -16, 0, 16)
	ndLine1.BackgroundTransparency = 1
	ndLine1.Font = Enum.Font.GothamMedium
	ndLine1.TextSize = 8.5
	ndLine1.TextColor3 = GOLD_SOFT_CREAM
	ndLine1.TextXAlignment = Enum.TextXAlignment.Left
	ndLine1.Text = "+ Đã xoá trạng thái Máy chạy bộ -> Luôn hiện Đang rảnh"
	ndLine1.ZIndex = 35

	local ndLine2 = Instance.new("TextLabel", noteDrawer)
	ndLine2.Position = UDim2.new(0, 8, 0, 38)
	ndLine2.Size = UDim2.new(1, -16, 0, 16)
	ndLine2.BackgroundTransparency = 1
	ndLine2.Font = Enum.Font.GothamMedium
	ndLine2.TextSize = 8.5
	ndLine2.TextColor3 = GOLD_MUTED_SUBTEXT
	ndLine2.TextXAlignment = Enum.TextXAlignment.Left
	ndLine2.Text = "+ Kéo rộng ngang & thu lề 86% hiển thị trọn vẹn con mèo"
	ndLine2.ZIndex = 35

	local ndLine3 = Instance.new("TextLabel", noteDrawer)
	ndLine3.Position = UDim2.new(0, 8, 0, 56)
	ndLine3.Size = UDim2.new(1, -16, 0, 16)
	ndLine3.BackgroundTransparency = 1
	ndLine3.Font = Enum.Font.GothamMedium
	ndLine3.TextSize = 8.5
	ndLine3.TextColor3 = Color3.fromRGB(145, 210, 165)
	ndLine3.TextXAlignment = Enum.TextXAlignment.Left
	ndLine3.Text = "+ Ngắt toàn bộ sự kiện quét ngầm sau khi mở menu (0% lag)"
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
			expSubBadge.Text = (State.Language == "EN") and "● NO TREADMILL STATUS • 0% LAG" or "● ĐÃ XOÁ TRẠNG THÁI MÁY CHẠY • 0% LAG"
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
		end

		local textLen = utf8.len(displayTxt) or #displayTxt
		local targetWidth = math.max(186, math.min(310, 92 + textLen * 7))
		if targetWidth ~= State.LastPillTargetWidth then
			State.LastPillTargetWidth = targetWidth
			TweenService:Create(
				pillFrame,
				TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
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
	end))

	trackConn(soundToggleBtn.Activated:Connect(function()
		State.SoundEnabled = not State.SoundEnabled
		if State.SoundEnabled then
			playUiSound("action")
		end
		updatePillVisuals(true)
	end))

	trackConn(rescanBtn.Activated:Connect(function()
		playUiSound("action")
		if State.RefreshAllMenus then
			task.spawn(State.RefreshAllMenus)
		end
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
			TweenService:Create(expandPanel, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, EXP_W, 0, targetH) }):Play()
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
		else
			TweenService:Create(rightArrow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
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

-- Tắt hoàn toàn Visible = false trên thanh trạng thái gốc của Header để Roblox C++ không tính toán lại
-- layout mỗi frame khi Figgy Hub chạy hiệu ứng Treadmill!
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

	-- NẾU LÀ TRẠNG THÁI MÁY CHẠY BỘ (TREADMILL) HOẶC IDLE:
	-- Quy thẳng về "Idle" ("Đang rảnh") và xoá bỏ icon tia sét của máy chạy!
	if isTreadmillOrIdleStatus(rawText) then
		if State.LastSyncedRawText == "Idle" then
			-- Đã ở trạng thái Đang rảnh rồi -> Thoát ngay lập tức ở dòng 1 (0% CPU, không làm bất cứ gì!)
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
-- 7. NHẬN DIỆN NÚT CỦ HÀNH TÍM (CHỈ QUÉT 1 LẦN LÚC KHỞI ĐỘNG)
-- ============================================================================
local function isPurpleOnionSquareButton(btn, isInsideVerifiedFiggyGui)
	if not btn or not btn.Parent then return false end
	if not (btn:IsA("Frame") or btn:IsA("ImageButton") or btn:IsA("TextButton")) then return false end

	if btn:FindFirstChild("BananaCatCircleAvatar") or btn.Parent:FindFirstChild("BananaCatCircleAvatar") then
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

	if isInsideVerifiedFiggyGui then
		local par = btn.Parent
		local isTopLevel = par:IsA("ScreenGui") or (par:IsA("Frame") and par.Parent and par.Parent:IsA("ScreenGui") and par.BackgroundTransparency >= 0.99)
		if isTopLevel then
			local hasImg = (btn:IsA("ImageButton") or btn:FindFirstChildWhichIsA("ImageLabel", true) ~= nil or btn:FindFirstChildWhichIsA("ImageButton", true) ~= nil)
			if hasImg then
				return true
			end
		end
	end

	local vpW = getViewportWidth()
	if btn.AbsolutePosition.X >= vpW * 0.75 then
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

	if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
		if isFiggyPurpleColor(obj.ImageColor3) then
			pcall(function() obj.ImageColor3 = GOLD_PRIMARY_TEXT end)
		end
	end

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
-- 8. DỊCH MENU TĨNH 1 LẦN & TỰ NGẮT SỰ KIỆN QUÉT NGẦM (0% LAG KHI CHƠI)
-- ============================================================================
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

	-- Chỉ mở DescendantAdded trong 2.5 giây đầu khi menu đang tạo, sau đó NGẮT HẲN để khi chơi 0% lag!
	local tempDescConn
	tempDescConn = gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") or desc:IsA("ImageButton") then
			task.defer(function()
				if isAlive() and desc and desc.Parent then
					pcall(processGuiElement, desc)
				end
			end)
		end
	end)
	trackConn(tempDescConn)
	task.delay(2.5, function()
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
				if i % 300 == 0 then
					task.wait()
				end
			end
		end
		pcall(scanPurpleOnionButtonsOnce)
	end)
end

-- ============================================================================
-- 9. KHỞI CHẠY DYNAMIC ISLAND & ĐĂNG KÝ SỰ KIỆN (0% CPU KHI CHƠI)
-- ============================================================================
createIndependentFiggyDynamicIsland()

task.spawn(function()
	if existingFiggyGui and existingFiggyGui.Parent then
		pcall(hookTargetScreenGui, existingFiggyGui)
	end

	pcall(scanPurpleOnionButtonsOnce)

	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				pcall(hookTargetScreenGui, gui)
			end
		end

		local rootAddConn
		rootAddConn = root.ChildAdded:Connect(function(newGui)
			if not isAlive() then return end
			task.delay(0.3, function()
				if isAlive() and newGui and newGui.Parent then
					pcall(hookTargetScreenGui, newGui)
					pcall(scanPurpleOnionButtonsOnce)
				end
			end)
		end)
		trackConn(rootAddConn)
		task.delay(5.0, function()
			if rootAddConn then
				pcall(function() rootAddConn:Disconnect() end)
			end
		end)
	end
end)
