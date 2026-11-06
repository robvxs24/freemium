-- ============================================================================
-- BANANA HUB V1.1.0 (LIQUID GLASS EDITION) | BANANA LOGOS + GOLD THEME + HOME
-- FIX V1.1.0 - NÚT CỦ HÀNH TÍM BÊN PHẢI (cột phải Steal Panel, ảnh chụp 06/11):
--    + Nguyên nhân cũ: (1) decoratePurpleOnionButton() chặn cứng chỉ cho lề trái
--      (cx 2%-20%) nên nút phải dù nhận diện đúng vẫn return sớm; (2) đường
--      global chỉ nhận nút 16-36px, Y 18%-34%, trong khi nút thật ~40-70px;
--      (3) hasPurpleVisualInside() chỉ soi bên TRONG nút, còn màu tím nằm ở
--      khung Frame cha bên ngoài, còn icon bên trong thì trắng/trong suốt;
--      (4) quét global chỉ chạy lúc load +1s/+3.5s, Steal Panel mở muộn là lỡ.
--    + Sửa: thêm mục 7D riêng cho nút phải - nhận diện theo tím ở cả nút,
--      con cháu VÀ khung cha, không bắt buộc trùng asset củ hành gốc, giữ
--      khung vuông tím nguyên, chỉ thay ảnh icon bên trong sang Banana Cat,
--      quét lại bằng DescendantAdded (debounce, không loop) + các mốc muộn.
-- Script gốc: loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/91ad82d753e1318189c4e249d56e7dcf.lua"))()
-- 1. [KHẮC PHỤC TRIỆT ĐỂ LỖI LỘ ẢNH MỜ GỐC LÚC MỚI CHẠY & KHÔNG GHIM NHẦM]:
--    + Đo kích thước thực tế qua cả `AbsoluteSize` lẫn `Size.Offset` để bắt dính nút ngay từ
--      khung hình 0.0s (kể cả khi Figgy Hub đang chạy hiệu ứng phóng to lúc mới mở).
--    + Tuyệt đối không gắn nhầm vào các nút/icon bên trong cửa sổ menu chính hay Delta X.
--    + Xoá sạch ảnh mờ gốc (`Image = ""`, khóa `ImageTransparency = 1`, `BackgroundTransparency = 1`,
--      tắt `UIStroke` gốc và ẩn luôn cả các khung bóng mờ anh em cùng tọa độ).
-- 2. [ĐÚNG KIỂU DÁNG TỪNG LOGO THEO YÊU CẦU]:
--    + Logo Dynamic Island, Logo mở menu chính bên trái (nút củ hành tím) và Logo góc trái tiêu đề: HÌNH TRÒN.
--    + Chỉ đổi nút củ hành vuông bên phải khi asset ảnh gốc trùng khớp; giữ nguyên các nút game khác.
--    + Tự động chọn đúng thẻ theme Vàng Hoàng Gia (Lemon), không đổi màu tím sang vàng toàn menu.
-- 3. [TỐI ƯU HIỆU NĂNG - 0% GIẬT LAG]:
--    + Bỏ qua hoàn toàn trạng thái máy chạy bộ (Treadmill) -> Luôn giữ tĩnh "Đang rảnh" (0 lệnh vẽ lại).
--    + Tự động ngắt toàn bộ sự kiện quét DOM sau khi khởi tạo xong.
-- 4. [DYNAMIC ISLAND LIQUID GLASS - XOÁ NÚT ÂM THANH & XOÁ NÚT LÀM MỚI - CHỮ DỊU MẮT]:
--    + Nâng cấp hiệu ứng kính lỏng Liquid Glass 3D đa tầng chuyên nghiệp.
--    + Xoá bỏ hoàn toàn cả nút tắt/bật âm thanh (âm thanh mặc định luôn MỞ) lẫn nút Làm mới & Đồng bộ.
--    + Khóa `ApplyStrokeMode = Enum.ApplyStrokeMode.Border` và `TextStrokeTransparency = 1` cùng tông
--      màu Kem Sâm-banh dịu nhẹ để chữ sắc nét, tuyệt đối không bị nhòe hay chói mắt.
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
State.SoundEnabled = true -- Mặc định luôn BẬT âm thanh
State.FiggyMainWindow = nil
State.IsExpanded = false
State.NoteOpen = false
State.StaticLabels = {}
State.CachedSounds = State.CachedSounds or {}
State.LastSyncedRawText = nil
State.LastSyncedRawImg = nil
State.LastDisplayedPillText = nil
State.LastDisplayedPillImg = nil
State.LastPillTargetWidth = nil
State.OnionButton = nil -- Nút củ hành tím mở menu thật sự (lề trái)
State.HeaderBadgeFrame = nil -- Logo nhỏ cạnh tiêu đề trong cửa sổ menu
State.OnionAsset = nil -- Asset ảnh củ hành gốc để nhận diện chính xác
State.RightOnionButton = nil -- Nút củ hành tím vuông ở cột phải (ngoài Steal Panel)
State.RightOnionImage = nil -- ImageLabel/ImageButton chứa icon củ hành bên trong nút phải
State.RightOnionScanPending = false -- Debounce cho hook DescendantAdded của nút phải
State.GoldThemeApplied = false -- Đã chọn theme Vàng Hoàng Gia (Lemon)
State.GoldThemeAttempts = 0 -- Số lần thử chọn theme (có giới hạn, không lặp vô hạn)
State.HomeTabReturned = false -- Mỗi lần chạy chỉ quay về Home một lần

-- ============================================================================
-- 1. BẢNG MÀU LIQUID GLASS & CHAMPAGNE CREAM DỊU MẮT (0% CHÓI MẮT)
-- ============================================================================
local SOFT_CHAMPAGNE_GOLD = Color3.fromRGB(234, 218, 180) -- Vàng sâm-banh dịu nhẹ
local SOFT_WARM_CREAM     = Color3.fromRGB(232, 226, 214) -- Kem ấm sắc nét, không chói mắt
local SOFT_MUTED_TAUPE    = Color3.fromRGB(162, 156, 146) -- Xám kem hài hòa
local SOFT_MINT_PASTEL    = Color3.fromRGB(154, 212, 176) -- Xanh bạc hà dịu

local GOLD_PRIMARY_TEXT   = SOFT_CHAMPAGNE_GOLD
local GOLD_BRIGHT_TITLE   = Color3.fromRGB(240, 224, 184)
local GOLD_ACCENT_FILL    = Color3.fromRGB(190, 154, 68)
local GOLD_BORDER_STROKE  = Color3.fromRGB(214, 178, 86)
local GOLD_SOFT_CREAM     = SOFT_WARM_CREAM
local GOLD_MUTED_SUBTEXT  = SOFT_MUTED_TAUPE

-- Bảng màu Kính Lỏng (Liquid Glass)
local LIQUID_GLASS_BASE     = Color3.fromRGB(15, 16, 22)
local LIQUID_GLASS_CARD     = Color3.fromRGB(23, 24, 32)
local LIQUID_GLASS_TRACK    = Color3.fromRGB(18, 19, 26)
local BTN_ACTIVE_BG         = Color3.fromRGB(38, 34, 28)
local BTN_ACTIVE_STROKE     = Color3.fromRGB(182, 152, 86)
local BTN_ACTIVE_TEXT       = SOFT_WARM_CREAM
local BTN_INACTIVE_BG       = Color3.fromRGB(25, 26, 34)
local BTN_INACTIVE_STROKE   = Color3.fromRGB(84, 78, 70)

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
	"delta", "deltax", "deltaicon", "deltalogo", "executor", "rgui", "mobilegui",
	"codex", "arceus", "fluxus", "hydrogen", "vega", "trigon", "evon", "krnl",
	"synapse", "scripthub", "script hub", "autoexecute", "rconsole", "executor",
	"keysystem", "key system", "exec", "executoricon", "executorlogo",
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

local function getViewportHeight()
	local cam = Workspace and Workspace.CurrentCamera
	if cam and cam.ViewportSize and cam.ViewportSize.Y > 0 then
		return cam.ViewportSize.Y
	end
	return 600
end

-- Lấy kích thước chuẩn kể cả ở 0.0s khi AbsoluteSize đang bằng 0 hoặc đang chạy hiệu ứng phóng to
local function getEffectiveBoxSize(guiObj)
	if not guiObj then return 0, 0 end
	local aw, ah = guiObj.AbsoluteSize.X, guiObj.AbsoluteSize.Y
	if aw >= 16 and ah >= 16 then
		return aw, ah
	end
	local okS, sz = pcall(function() return guiObj.Size end)
	if okS and sz and sz.X and sz.Y then
		local ox, oy = sz.X.Offset or 0, sz.Y.Offset or 0
		if ox >= 16 and oy >= 16 then
			return ox, oy
		end
	end
	return aw, ah
end

-- Kiểm tra xem một phần tử có nằm bên trong cửa sổ menu lớn (>= 220x150) hay không
local function isInsideLargeWindowFrame(obj)
	if not obj then return false end
	-- Nút củ hành lề trái (X <= 18% màn hình) KHÔNG BAO GIỜ nằm trong cửa sổ chính (cửa sổ chính nằm ở X >= 190)
	local vpW = getViewportWidth()
	local ox = obj.AbsolutePosition.X
	if ox >= 40 and ox <= vpW * 0.18 then
		return false
	end
	if State.FiggyMainWindow and (obj == State.FiggyMainWindow or obj:IsDescendantOf(State.FiggyMainWindow)) then
		return true
	end
	local p = obj.Parent
	while p and not p:IsA("ScreenGui") do
		if p:IsA("GuiObject") then
			local pw, ph = getEffectiveBoxSize(p)
			if pw >= 320 and ph >= 220 and p.AbsolutePosition.X > vpW * 0.16 then
				local bgT = p.BackgroundTransparency or 0
				if bgT < 0.90 then
					return true
				end
			end
		end
		p = p.Parent
	end
	return false
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
	if not okD or type(desc) ~= "table" then return false end

	local vpW = getViewportWidth()
	for _, d in ipairs(desc) do
		if d:IsA("TextBox") then
			local bt = d.Text or ""
			if #bt > 120 or string.find(bt, "loadstring", 1, true) then
				gui:SetAttribute("__IsExecutorGui", true)
				return true
			end
		elseif (d:IsA("ImageButton") or d:IsA("TextButton")) and not isInsideLargeWindowFrame(d) then
			local dx = d.AbsolutePosition.X
			local dy = d.AbsolutePosition.Y
			local dw, dh = getEffectiveBoxSize(d)
			-- Delta X floating icon typically sits in the central area (20% .. 70% of screen width)
			if dx > vpW * 0.18 and dx < vpW * 0.75 and dy >= 30 and dy <= 320 and dw >= 24 and dw <= 72 and dh >= 24 and dh <= 72 then
				gui:SetAttribute("__IsExecutorGui", true)
				return true
			end
		end
	end

	return false
end

-- Dọn dẹp nếu trước đó gắn nhầm vào Executor GUI hoặc gắn nhầm vào Delta X, tuyệt đối KHÔNG bật lại ảnh mờ gốc trên Figgy Hub
local function cleanupPreviousOverlaysAndDeduplicate()
	local figgyGuis = {}
	local vpW = getViewportWidth()
	local vpH = getViewportHeight()
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
							local isOverlay = (d.Name == "BananaCatFixedOverlay" or d.Name == "BananaCatCircleAvatar" or d.Name == "GoldBadgeInnerDisc" or d.Name == "BananaCatBadgeImage" or d.Name == "BananaCatInnerSprite")
							if isOverlay then
								local par = d.Parent
								local isWrongCentralAttachment = false
								if par and par:IsA("GuiObject") and not isInsideLargeWindowFrame(par) then
									local pX = par.AbsolutePosition.X
									local pY = par.AbsolutePosition.Y
									local isProtectedOnion = (State.OnionButton ~= nil and par == State.OnionButton)
										or (State.HeaderBadgeFrame ~= nil and par == State.HeaderBadgeFrame)
										or (State.RightOnionButton ~= nil and par == State.RightOnionButton)
										or (State.RightOnionImage ~= nil and par == State.RightOnionImage)
									if not isProtectedOnion then
										local inOnionBand = (pX >= vpW * 0.02 and pX <= vpW * 0.20 and pY >= 70 and pY <= vpH * 0.82)
										if State.OnionButton ~= nil then
											isWrongCentralAttachment = true
										elseif not inOnionBand then
											isWrongCentralAttachment = true
										end
									end
								end

								if isExec or isWrongCentralAttachment then
									d:Destroy()
									if par then
										par:SetAttribute("__RestoredOrig", true)
										if par:IsA("ImageLabel") or par:IsA("ImageButton") then
											par.ImageTransparency = 0
											par.BackgroundTransparency = 0
											local origImg = par:GetAttribute("__OrigImageAsset")
											if origImg and origImg ~= "" then par.Image = origImg end
										elseif par:IsA("Frame") then
											par.BackgroundTransparency = 0
										end
										local forcedCorner = par:FindFirstChild("BananaCatForcedCorner")
										if forcedCorner then
											forcedCorner:Destroy()
										end
										for _, sib in ipairs(par:GetDescendants()) do
											sib:SetAttribute("__RestoredOrig", true)
											if sib:IsA("ImageLabel") or sib:IsA("ImageButton") then
												sib.ImageTransparency = 0
												local origImg = sib:GetAttribute("__OrigImageAsset")
												if origImg and origImg ~= "" then sib.Image = origImg end
											elseif sib:IsA("UIStroke") and sib.Name ~= "LuxuryGoldCircleStroke" then
												sib.Transparency = 0
												sib.Enabled = true
											end
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
-- 3. THIẾT KẾ LOGO BANANA CAT: HÌNH TRÒN (LOGO CHÍNH & DYNAMIC) / HÌNH VUÔNG GÓC ĐẸP (BÊN PHẢI)
-- ============================================================================
local BANANA_CAT_ASSET_ID = "87447945720038"
local BANANA_CAT_LOGO     = "rbxthumb://type=Asset&id=" .. BANANA_CAT_ASSET_ID .. "&w=420&h=420"
local DOWN_ARROW_ICON     = "rbxassetid://6031091004"

local STRETCH_CAT_OFFSET  = Vector2.new(85, 0)
local STRETCH_CAT_SIZE    = Vector2.new(250, 420)

local CIRCLE_CORNER_UDIM  = UDim.new(1, 0)
local SQUARE_CORNER_UDIM  = UDim.new(0.22, 0) -- Bo góc vuông đẹp chuẩn cột nút phải

local function isFiggyPurpleColor(col)
	if not col then return false end
	-- Bắt chuẩn toàn bộ các sắc độ tím/lilac/midnight fig của Figgy Hub (từ tím đậm nền nút đến tím sáng thanh trượt)
	if col.B > 0.24 and col.R > 0.14 and (col.B - col.G) > 0.04 and col.B >= col.R * 0.85 then
		-- Loại trừ màu xám trung tính (khi R, G, B gần bằng nhau)
		if (col.B - col.G) > 0.05 or (col.R - col.G) > 0.04 then
			return true
		end
	end
	return false
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

-- Hàm tạo huy hiệu Banana Cat Vàng Gold:
-- + isRoundedSquare == false/nil: Hình tròn (cho Dynamic Island, nút mở menu chính & logo tiêu đề)
-- + isRoundedSquare == true: Hình vuông bo góc đẹp (cho nút bên tay phải phía trên Trứng & Chân thú)
local function buildFullCatGoldCoin(parentContainer, strokeThickness, zBase, isRoundedSquare)
	local targetCornerRadius = isRoundedSquare and SQUARE_CORNER_UDIM or CIRCLE_CORNER_UDIM
	local innerScale = isRoundedSquare and 0.88 or 0.86
	local innerCornerRadius = isRoundedSquare and UDim.new(0.18, 0) or UDim.new(0.35, 0)

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
		corner.CornerRadius = targetCornerRadius
		corner.Parent = coinDisc

		applyCoinSurfaceGoldGradient(coinDisc)
	else
		local corner = coinDisc:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", coinDisc)
		corner.CornerRadius = targetCornerRadius
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
		catSprite.Size = UDim2.fromScale(innerScale, innerScale)
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
		spCorner.CornerRadius = innerCornerRadius
		spCorner.Parent = catSprite

		applyCoinSurfaceGoldGradient(catSprite)
	else
		catSprite.Image = BANANA_CAT_LOGO
		catSprite.ImageRectOffset = STRETCH_CAT_OFFSET
		catSprite.ImageRectSize = STRETCH_CAT_SIZE
		catSprite.ScaleType = Enum.ScaleType.Stretch
		catSprite.Size = UDim2.fromScale(innerScale, innerScale)
		local spCorner = catSprite:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", catSprite)
		spCorner.CornerRadius = innerCornerRadius
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
				local pw, ph = getEffectiveBoxSize(par)
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

-- Xoá sạch và khóa cứng mọi hình ảnh mờ mờ / khung nền của nút gốc
local function silenceOriginalButtonVisual(inst, coinDisc, targetCornerUdim)
	if not inst or isBananaCoinPart(inst, coinDisc) then return end
	local desiredCorner = targetCornerUdim or CIRCLE_CORNER_UDIM

	if inst:IsA("UICorner") then
		pcall(function() inst.CornerRadius = desiredCorner end)
		if inst:GetAttribute("__LockShapeCorner") ~= SID then
			inst:SetAttribute("__LockShapeCorner", SID)
			trackConn(inst:GetPropertyChangedSignal("CornerRadius"):Connect(function()
				if isAlive() and inst.CornerRadius ~= desiredCorner then
					pcall(function() inst.CornerRadius = desiredCorner end)
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
				if isAlive() and inst:GetAttribute("__RestoredOrig") ~= true and inst.Transparency < 0.99 then
					pcall(function() inst.Transparency = 1; inst.Enabled = false end)
				end
			end))
		end
	elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
		pcall(function()
			if inst.Image ~= "" and not inst:GetAttribute("__OrigImageAsset") then
				inst:SetAttribute("__OrigImageAsset", inst.Image)
			end
			inst.ImageTransparency = 1
			inst.BackgroundTransparency = 1
			inst.Image = ""
		end)
		if inst:GetAttribute("__HideOrigFigConnected") ~= SID then
			inst:SetAttribute("__HideOrigFigConnected", SID)
			trackConn(inst:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
				if isAlive() and inst:GetAttribute("__RestoredOrig") ~= true and inst.ImageTransparency < 0.99 then
					pcall(function() inst.ImageTransparency = 1 end)
				end
			end))
			trackConn(inst:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
				if isAlive() and inst:GetAttribute("__RestoredOrig") ~= true and inst.BackgroundTransparency < 0.99 then
					pcall(function() inst.BackgroundTransparency = 1 end)
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
				if isAlive() and inst:GetAttribute("__RestoredOrig") ~= true and inst.BackgroundTransparency < 0.99 then
					pcall(function() inst.BackgroundTransparency = 1 end)
				end
			end))
		end
	end
end

local function decoratePurpleOnionButton(rawTarget, strokeThickness, forceRoundedSquare, isHeaderBadge)
	local container = getOutermostSquareButton(rawTarget)
	if not container or not container:IsA("GuiObject") then return end

	local insideWindow = isInsideLargeWindowFrame(container) or isHeaderBadge == true
	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local cx = container.AbsolutePosition.X
	local cy = container.AbsolutePosition.Y

	-- Ngoài cửa sổ menu: chỉ trang trí logo chính ở vùng lề trái.
	-- Nút củ hành vuông bên phải được thay ảnh riêng, không bo góc.
	if not insideWindow then
		if State.FiggyMainWindow and (container == State.FiggyMainWindow or container:IsDescendantOf(State.FiggyMainWindow)) then
			return
		end
		local inOnionBand = (cx >= vpW * 0.02 and cx <= vpW * 0.20 and cy >= 70 and cy <= vpH * 0.82)
		if not inOnionBand then
			return
		end
	end

	local cw, ch = getEffectiveBoxSize(container)
	if cw > 96 or ch > 96 or cw < 14 or ch < 14 then return end

	-- Ghi nhận vai trò để bước dọn dẹp không xoá nhầm logo đúng.
	if insideWindow then
		State.HeaderBadgeFrame = container
	else
		State.OnionButton = container
		if not State.OnionAsset then
			for _, chd in ipairs(container:GetDescendants()) do
				if chd:IsA("ImageLabel") or chd:IsA("ImageButton") then
					local asset = chd:GetAttribute("__OrigImageAsset") or chd.Image
					if asset and asset ~= "" then
						State.OnionAsset = asset
						break
					end
				end
			end
			if not State.OnionAsset and (container:IsA("ImageLabel") or container:IsA("ImageButton")) then
				local asset = container:GetAttribute("__OrigImageAsset") or container.Image
				if asset and asset ~= "" then State.OnionAsset = asset end
			end
		end
	end

	-- Logo chính/header tròn; nút củ hành nhỏ bên phải chỉ thay ảnh và giữ khung vuông.
	local targetCornerUdim = CIRCLE_CORNER_UDIM

	local thick = strokeThickness or 2.0
	local coinDisc, stroke = buildFullCatGoldCoin(container, thick, (container.ZIndex or 5) + 8, false)

	local cCorner = container:FindFirstChild("BananaCatForcedCorner") or container:FindFirstChildOfClass("UICorner")
	if not cCorner then
		cCorner = Instance.new("UICorner")
		cCorner.Name = "BananaCatForcedCorner"
		cCorner.Parent = container
	end
	cCorner.CornerRadius = targetCornerUdim

	silenceOriginalButtonVisual(container, coinDisc, targetCornerUdim)
	for _, desc in ipairs(container:GetDescendants()) do
		silenceOriginalButtonVisual(desc, coinDisc, targetCornerUdim)
	end

	-- Nếu nút có một khung bóng mờ / nền mờ anh em (sibling) nằm chồng cùng tọa độ thì ẩn sạch luôn
	local par = container.Parent
	if par and (par:IsA("ScreenGui") or (par:IsA("GuiObject") and not par:FindFirstChildOfClass("UIListLayout") and not par:FindFirstChildOfClass("UIGridLayout"))) then
		for _, sib in ipairs(par:GetChildren()) do
			if sib ~= container and sib:IsA("GuiObject") and sib.Name ~= "BananaCatCircleAvatar" then
				local sw, sh = getEffectiveBoxSize(sib)
				if sw >= 16 and sw <= 96 and sh >= 16 and sh <= 96 then
					local dx = math.abs(sib.AbsolutePosition.X - container.AbsolutePosition.X)
					local dy = math.abs(sib.AbsolutePosition.Y - container.AbsolutePosition.Y)
					if dx <= 12 and dy <= 12 then
						silenceOriginalButtonVisual(sib, coinDisc, targetCornerUdim)
						for _, sDesc in ipairs(sib:GetDescendants()) do
							silenceOriginalButtonVisual(sDesc, coinDisc, targetCornerUdim)
						end
					end
				end
			end
		end
	end

	if container:GetAttribute("__SilenceNewChildren") ~= SID then
		container:SetAttribute("__SilenceNewChildren", SID)
		trackConn(container.DescendantAdded:Connect(function(newChild)
			if isAlive() and not isBananaCoinPart(newChild, coinDisc) then
				silenceOriginalButtonVisual(newChild, coinDisc, targetCornerUdim)
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
	["• Lemon"] = "• Vàng Hoàng Gia (Gold)",
	["Midnight Fig"] = "Midnight Fig",
	["• Midnight Fig"] = "• Midnight Fig",

	-- Nút HUD & Nút chức năng ngoài màn hình (7994.jpg)
	["Finder"] = "Tìm Kiếm",
	["finder"] = "Tìm kiếm",
	["FINDER"] = "TÌM KIẾM",
	["Shop"] = "Cửa Hàng",
	["shop"] = "Cửa hàng",
	["SHOP"] = "CỬA HÀNG",
	["Slow Mode"] = "Chế Độ Chậm",
	["slow mode"] = "Chế độ chậm",
	["SLOW MODE"] = "CHẾ ĐỘ CHẬM",
	["Index"] = "Mục Lục",
	["index"] = "Mục lục",
	["INDEX"] = "MỤC LỤC",
	["Fast Mode"] = "Chế Độ Nhanh",
	["fast mode"] = "Chế độ nhanh",
	["FAST MODE"] = "CHẾ ĐỘ NHANH",
	["Trade"] = "Giao Dịch",
	["trade"] = "Giao dịch",
	["TRADE"] = "GIAO DỊCH",
	["Teleport"] = "Dịch Chuyển",
	["teleport"] = "Dịch chuyển",
	["TELEPORT"] = "DỊCH CHUYỂN",
	["Stats"] = "Chỉ Số",
	["stats"] = "Chỉ số",
	["STATS"] = "CHỈ SỐ",
	["Pets"] = "Thú Cưng",
	["pets"] = "Thú cưng",
	["PETS"] = "THÚ CƯNG",
	["Auto Farm"] = "Tự Động Cày",
	["auto farm"] = "Tự động cày",
	["AUTO FARM"] = "TỰ ĐỘNG CÀY",
	["Anti AFK"] = "Chống AFK",
	["anti afk"] = "Chống AFK",
	["ANTI AFK"] = "CHỐNG AFK",

	-- Trạng thái (Treadmill được quy thẳng về Đang rảnh)
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
-- 5. THIẾT KẾ LIQUID GLASS DYNAMIC ISLAND (XOÁ NÚT ÂM THANH & XOÁ LÀM MỚI, CHỮ DỊU MẮT)
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
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(48, 46, 58)), -- Ánh sương mặt kính trên
	ColorSequenceKeypoint.new(0.42, Color3.fromRGB(22, 23, 31)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 12, 18)), -- Nền kính sâu
})

local GLINT_TRANS_SEQ = NumberSequence.new({
	NumberSequenceKeypoint.new(0.00, 1.00),
	NumberSequenceKeypoint.new(0.22, 0.66),
	NumberSequenceKeypoint.new(0.50, 0.50),
	NumberSequenceKeypoint.new(0.78, 0.66),
	NumberSequenceKeypoint.new(1.00, 1.00),
})

-- Gắn UIStroke chuẩn cho cả Frame lẫn TextButton (BẮT BUỘC ApplyStrokeMode.Border để không ăn vào chữ gây chói mắt!)
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
	local alpha = bgAlpha or 0.15
	frame.BackgroundColor3 = LIQUID_GLASS_BASE
	frame.BackgroundTransparency = alpha
	frame.BorderSizePixel = 0

	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = cornerRadius or CIRCLE_CORNER_UDIM
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
		irCorner.CornerRadius = cornerRadius or CIRCLE_CORNER_UDIM
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

	applyLiquidGlass(pillFrame, CIRCLE_CORNER_UDIM, 0.15, 1.25)

	local logoOrbHolder = Instance.new("Frame")
	logoOrbHolder.Name = "BananaCatLogoOrb"
	logoOrbHolder.AnchorPoint = Vector2.new(0, 0.5)
	logoOrbHolder.Position = UDim2.new(0, 6, 0.5, 0)
	logoOrbHolder.Size = UDim2.new(0, 28, 0, 28)
	logoOrbHolder.BackgroundTransparency = 1
	logoOrbHolder.BorderSizePixel = 0
	logoOrbHolder.ZIndex = 22
	logoOrbHolder.Parent = pillFrame

	-- Logo Dynamic Island: HÌNH TRÒN (isRoundedSquare = false)
	local pillCoinDisc, pillOrbStroke = buildFullCatGoldCoin(logoOrbHolder, 1.8, 23, false)

	local statusBadgeContainer = Instance.new("Frame")
	statusBadgeContainer.Name = "TransplantedStatusBadge"
	statusBadgeContainer.AnchorPoint = Vector2.new(0, 0.5)
	statusBadgeContainer.Position = UDim2.new(0, 40, 0.5, 0)
	statusBadgeContainer.Size = UDim2.new(1, -66, 0, 26)
	statusBadgeContainer.BackgroundColor3 = LIQUID_GLASS_CARD
	statusBadgeContainer.BackgroundTransparency = 0.30
	statusBadgeContainer.BorderSizePixel = 0
	statusBadgeContainer.ZIndex = 22
	statusBadgeContainer.Parent = pillFrame
	Instance.new("UICorner", statusBadgeContainer).CornerRadius = CIRCLE_CORNER_UDIM
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

	-- Đã xoá cả nút Tắt/Bật Âm Thanh lẫn nút Làm Mới & Đồng Bộ -> Bảng mở rộng gọn đẹp, tinh tế
	local EXP_W = 316
	local COLLAPSED_EXP_H = 142
	local OPEN_NOTE_EXP_H = 228

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
	buildFullCatGoldCoin(expLogoHolder, 1.6, 33, false)

	local expTitle = Instance.new("TextLabel")
	expTitle.Position = UDim2.new(0, 48, 0, 9)
	expTitle.Size = UDim2.new(0, 180, 0, 15)
	expTitle.BackgroundTransparency = 1
	expTitle.Font = Enum.Font.GothamBold
	expTitle.TextSize = 11.5
	expTitle.TextColor3 = GOLD_BRIGHT_TITLE
	expTitle.TextStrokeTransparency = 1
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
	expSubBadge.TextColor3 = SOFT_MUTED_TAUPE
	expSubBadge.TextStrokeTransparency = 1
	expSubBadge.TextXAlignment = Enum.TextXAlignment.Left
	expSubBadge.Text = "● LIQUID GLASS • TỰ ĐỘNG ĐỒNG BỘ"
	expSubBadge.ZIndex = 33
	expSubBadge.Parent = expandPanel

	local collapseBtn = Instance.new("TextButton")
	collapseBtn.Name = "CollapseIslandBtn"
	collapseBtn.Position = UDim2.new(1, -78, 0, 11)
	collapseBtn.Size = UDim2.new(0, 66, 0, 22)
	collapseBtn.BackgroundColor3 = LIQUID_GLASS_CARD
	collapseBtn.BackgroundTransparency = 0.26
	collapseBtn.BorderSizePixel = 0
	collapseBtn.Text = "Thu gọn ▲"
	collapseBtn.Font = Enum.Font.GothamMedium
	collapseBtn.TextSize = 9.5
	collapseBtn.TextColor3 = SOFT_WARM_CREAM
	collapseBtn.TextStrokeTransparency = 1
	collapseBtn.AutoButtonColor = false
	collapseBtn.ZIndex = 34
	collapseBtn.Parent = expandPanel
	Instance.new("UICorner", collapseBtn).CornerRadius = CIRCLE_CORNER_UDIM
	createCleanBorderStroke(collapseBtn, Color3.fromRGB(130, 112, 68), 1, 0.45)

	local liveStatusCard = Instance.new("Frame")
	liveStatusCard.Name = "LiveStatusCard"
	liveStatusCard.Position = UDim2.new(0, 12, 0, 44)
	liveStatusCard.Size = UDim2.new(1, -24, 0, 28)
	liveStatusCard.BackgroundColor3 = LIQUID_GLASS_CARD
	liveStatusCard.BackgroundTransparency = 0.28
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
	langTrack.BackgroundTransparency = 0.32
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
	btnVI.BackgroundTransparency = (State.Language == "VI") and 0.16 or 0.36
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
	btnEN.BackgroundTransparency = (State.Language == "EN") and 0.16 or 0.36
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

	local noteToggleBtn = Instance.new("TextButton")
	noteToggleBtn.Name = "SettingNoteToggleBtn"
	noteToggleBtn.Position = UDim2.new(0, 12, 0, 114)
	noteToggleBtn.Size = UDim2.new(1, -24, 0, 22)
	noteToggleBtn.BackgroundColor3 = LIQUID_GLASS_TRACK
	noteToggleBtn.BackgroundTransparency = 0.32
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
	noteDrawer.Position = UDim2.new(0, 12, 0, 140)
	noteDrawer.Size = UDim2.new(1, -24, 0, 78)
	noteDrawer.BackgroundColor3 = LIQUID_GLASS_CARD
	noteDrawer.BackgroundTransparency = 0.28
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
	ndLine1.Text = "+ Logo chính & Dynamic hình tròn, nút bên phải vuông bo góc đẹp"
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
	ndLine2.Text = "+ Xoá ảnh mờ gốc từ 0.0s, âm thanh mở sẵn, chữ sắc nét dịu mắt"
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
			expSubBadge.Text = (State.Language == "EN") and "● LIQUID GLASS • AUTO SYNC" or "● LIQUID GLASS • TỰ ĐỘNG ĐỒNG BỘ"
			collapseBtn.Text = (State.Language == "EN") and "Collapse ▲" or "Thu gọn ▲"
			if State.NoteOpen then
				noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Gold Premium Info (Collapse) ▲" or "Thông tin Banana Hub Gold Premium (Thu gọn) ▲"
			else
				noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Gold Premium Info (Click) ▼" or "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
			end

			btnVI.BackgroundColor3 = (State.Language == "VI") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
			btnVI.BackgroundTransparency = (State.Language == "VI") and 0.16 or 0.36
			btnVI.TextColor3 = (State.Language == "VI") and SOFT_WARM_CREAM or SOFT_MUTED_TAUPE
			btnVIStroke.Color = (State.Language == "VI") and BTN_ACTIVE_STROKE or BTN_INACTIVE_STROKE
			btnVIStroke.Transparency = (State.Language == "VI") and 0.28 or 0.60

			btnEN.BackgroundColor3 = (State.Language == "EN") and BTN_ACTIVE_BG or BTN_INACTIVE_BG
			btnEN.BackgroundTransparency = (State.Language == "EN") and 0.16 or 0.36
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
			noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Gold Premium Info (Collapse) ▲" or "Thông tin Banana Hub Gold Premium (Thu gọn) ▲"
			TweenService:Create(expandPanel, TWEEN_PANEL_OUT, {
				Size = UDim2.new(0, EXP_W, 0, OPEN_NOTE_EXP_H)
			}):Play()
		else
			noteToggleBtn.Text = (State.Language == "EN") and "Banana Hub Gold Premium Info (Click) ▼" or "Thông tin Banana Hub Gold Premium (Bấm xem) ▼"
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
-- 7. NHẬN DIỆN LOGO CỦ HÀNH THEO ASSET GỐC (FAIL-CLOSED)
-- ============================================================================
local function hasPurpleVisualInside(btn)
	if btn:GetAttribute("__WasFiggyPurple") == true then return true end
	if btn.BackgroundTransparency < 0.95 and isFiggyPurpleColor(btn.BackgroundColor3) then
		return true
	end
	if hasPurpleGradient(btn) then
		return true
	end
	for _, d in ipairs(btn:GetDescendants()) do
		if d:GetAttribute("__WasFiggyPurple") == true then return true end
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
	if btn:FindFirstChild("BananaCatCircleAvatar") or (btn.Parent and btn.Parent:FindFirstChild("BananaCatCircleAvatar")) then return false end
	if isInsideLargeWindowFrame(btn) then return false end
	if State.FiggyMainWindow and (btn == State.FiggyMainWindow or btn:IsDescendantOf(State.FiggyMainWindow)) then return false end

	local bw, bh = getEffectiveBoxSize(btn)
	if bw < 22 or bw > 86 or bh < 22 or bh > 86 or math.abs(bw - bh) > 16 then return false end
	for _, d in ipairs(btn:GetDescendants()) do
		if d:IsA("TextLabel") and d.Visible and d.TextTransparency < 0.95 then
			local t = (d.Text or ""):match("^%s*(.-)%s*$") or ""
			if #t > 0 then return false end
		end
	end

	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local absX, absY = btn.AbsolutePosition.X, btn.AbsolutePosition.Y
	if absX == 0 and absY == 0 then return false end
	local inLeftLogoBand = absX >= vpW * 0.02 and absX <= vpW * 0.20
	local inRightOnionBand = absX >= vpW * 0.78 and absX <= vpW * 0.98
	if (not inLeftLogoBand and not inRightOnionBand) or absY < 70 or absY > vpH * 0.82 then return false end

	-- Không khóa theo nút trái đã ghim: nút phải vẫn được nhận nếu ảnh gốc trùng tuyệt đối.
	if not State.OnionAsset or State.OnionAsset == "" then return false end

	local function matchesOriginalOnionImage(obj)
		if not State.OnionAsset or State.OnionAsset == "" then return false end
		if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
			local asset = obj:GetAttribute("__OrigImageAsset") or obj:GetAttribute("__OrigOnionImage") or obj.Image
			if asset == State.OnionAsset then return true end
		end
		for _, d in ipairs(obj:GetDescendants()) do
			if d:IsA("ImageLabel") or d:IsA("ImageButton") then
				local asset = d:GetAttribute("__OrigImageAsset") or d:GetAttribute("__OrigOnionImage") or d.Image
				if asset == State.OnionAsset then return true end
			end
		end
		return false
	end
	return matchesOriginalOnionImage(btn)
end

-- Khôi phục nguyên trạng nút bị gắn nhầm (đặc biệt các nút game bên phải).
local function restoreWronglyDecoratedButton(par)
	if not par or not par.Parent then return end
	par:SetAttribute("__RestoredOrig", true)
	if par:IsA("ImageLabel") or par:IsA("ImageButton") then
		par.ImageTransparency = 0
		par.BackgroundTransparency = 0
		local origImg = par:GetAttribute("__OrigImageAsset")
		if origImg and origImg ~= "" then par.Image = origImg end
	elseif par:IsA("Frame") or par:IsA("TextButton") or par:IsA("CanvasGroup") then
		par.BackgroundTransparency = 0
	end
	local forcedCorner = par:FindFirstChild("BananaCatForcedCorner")
	if forcedCorner then forcedCorner:Destroy() end
	for _, sib in ipairs(par:GetDescendants()) do
		sib:SetAttribute("__RestoredOrig", true)
		if sib:IsA("ImageLabel") or sib:IsA("ImageButton") then
			sib.ImageTransparency = 0
			local origImg = sib:GetAttribute("__OrigImageAsset")
			if origImg and origImg ~= "" then sib.Image = origImg end
		elseif sib:IsA("UIStroke") and sib.Name ~= "LuxuryGoldCircleStroke" then
			sib.Transparency = 0
			sib.Enabled = true
		end
	end
end

-- Dọn lớp phủ sai, không đụng các nút game không khớp asset logo củ hành.
local function removeWrongOnionOverlays(gui)
	local okD, desc = pcall(function() return gui:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return end
	for _, d in ipairs(desc) do
		if d.Name == "BananaCatFixedOverlay" or d.Name == "BananaCatCircleAvatar" or d.Name == "GoldBadgeInnerDisc" or d.Name == "BananaCatBadgeImage" then
			local par = d.Parent
			if par and par:IsA("GuiObject") and not isInsideLargeWindowFrame(par) then
				local isProtected = (State.OnionButton ~= nil and par == State.OnionButton)
					or (State.HeaderBadgeFrame ~= nil and par == State.HeaderBadgeFrame)
					or (State.RightOnionButton ~= nil and par == State.RightOnionButton)
					or (State.RightOnionImage ~= nil and par == State.RightOnionImage)
				if not isProtected then
					d:Destroy()
					restoreWronglyDecoratedButton(par)
				end
			end
		end
	end
end

local function scanPurpleOnionButtonsOnce()
	local vpW, vpH = getViewportWidth(), getViewportHeight()
	-- Nếu lớp phủ đã có sẵn từ lần chạy trước, ghim lại đúng nút củ hành theo vị trí.
	if not State.OnionButton then
		for _, root in ipairs(getUiRoots()) do
			local okCh, children = pcall(function() return root:GetChildren() end)
			if okCh and type(children) == "table" then
				for _, gui in ipairs(children) do
					local okD, desc = pcall(function() return gui:GetDescendants() end)
					if okD and type(desc) == "table" then
						for _, d in ipairs(desc) do
							if d.Name == "BananaCatCircleAvatar" and d.Parent and d.Parent:IsA("GuiObject") then
								local par = d.Parent
								local ax, ay = par.AbsolutePosition.X, par.AbsolutePosition.Y
								if ax >= vpW * 0.02 and ax <= vpW * 0.20 and ay >= 70 and ay <= vpH * 0.82 and not isInsideLargeWindowFrame(par) then
									State.OnionButton = par
									break
								end
							end
						end
					end
					if State.OnionButton then break end
				end
			end
			if State.OnionButton then break end
		end
	end
	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for _, gui in ipairs(children) do
				local gName = gui.Name or ""
				if gName ~= "BananaDynamicIsland" and gName ~= "FiggyDynamicIsland"
					and not IGNORED_SCREEN_GUIS[gName] and not gName:find("^Old_")
					and not gui:IsA("BillboardGui") and not gui:IsA("SurfaceGui")
					and not isDeltaOrExecutorGui(gui) then
					local isVerifiedFiggy = isFiggyWindowGui(gui)
					local okD, desc = pcall(function() return gui:GetDescendants() end)
					if okD and type(desc) == "table" then
						for _, d in ipairs(desc) do
							if isPurpleOnionSquareButton(d, isVerifiedFiggy) then
								decoratePurpleOnionButton(d, 2.0, false)
							elseif d:IsA("ImageLabel") and d.Parent and isPurpleOnionSquareButton(d.Parent, isVerifiedFiggy) then
								decoratePurpleOnionButton(d.Parent, 2.0, false)
							end
						end
						removeWrongOnionOverlays(gui)
					end
				end
			end
		end
	end
end

-- ============================================================================
-- 7C. QUÉT DIỆN RỘNG TOÀN CẦU (CoreGui + PlayerGui): ĐÈ ẢNH BANANA CAT
--     LÊN MỌI NÚT CỦ HÀNH TÍM Ở LỀ TRÁI, BỎ QUA GUI DELTA EXECUTOR.
--     Phần này chỉ thêm mới, không sửa bất kỳ đoạn mã cũ nào.
-- ============================================================================
local BANANA_CAT_CUSTOM_FILE = "figgy_banana_cat.png"

-- Tải đúng ảnh Banana Cat (asset gốc của Dynamic Island) về máy để getcustomasset dùng.
local function downloadBananaCatThumbPng()
	if type(game.HttpGet) ~= "function" then return nil end
	local okJson, json = pcall(function()
		return game:HttpGet("https://thumbnails.roblox.com/v1/assets?assetIds=" .. BANANA_CAT_ASSET_ID .. "&size=420x420&format=Png")
	end)
	if not okJson or type(json) ~= "string" or #json < 32 then return nil end
	local url = json:match('"imageUrl"%s*:%s*"([^"]+)"')
	if not url or url == "" then return nil end
	url = url:gsub("\\/", "/")
	local okPng, png = pcall(function() return game:HttpGet(url) end)
	if not okPng or type(png) ~= "string" or #png < 64 then return nil end
	return png
end

local function resolveBananaCatOverrideAsset()
	if State.BananaCatOverrideAsset then return State.BananaCatOverrideAsset end
	-- Chống tải trùng khi nhiều mốc quét chạy song song lúc khởi động.
	if State.BananaCatAssetResolving then return BANANA_CAT_LOGO end
	State.BananaCatAssetResolving = true
	local resolved = nil
	pcall(function()
		if type(getcustomasset) ~= "function" then return end
		local file = BANANA_CAT_CUSTOM_FILE
		local hasFile = (type(isfile) == "function") and (isfile(file) == true)
		if not hasFile and type(writefile) == "function" then
			local png = downloadBananaCatThumbPng()
			if png then
				writefile(file, png)
				hasFile = (type(isfile) ~= "function") or (isfile(file) == true)
			end
		end
		if hasFile then
			local okA, a = pcall(getcustomasset, file)
			if okA and type(a) == "string" and a ~= "" then resolved = a end
		end
	end)
	State.BananaCatAssetResolving = false
	if not resolved then resolved = BANANA_CAT_LOGO end
	State.BananaCatOverrideAsset = resolved
	return resolved
end

-- GUI của Delta / executor và các GUI hệ thống Roblox: tuyệt đối không đụng vào.
local function isExecutorOrIgnoredScreenGui(gui)
	if not gui or not gui:IsA("ScreenGui") then return true end
	local gName = gui.Name or ""
	if IGNORED_SCREEN_GUIS[gName] or gName:find("^Old_") then return true end
	local low = string.lower(gName)
	for _, kw in ipairs(EXECUTOR_KEYWORDS) do
		if string.find(low, kw, 1, true) then return true end
	end
	if gui:GetAttribute("__IsExecutorGui") == true then return true end
	if gui:GetAttribute("__VerifiedFiggyWindowGui") == true then return false end
	if isDeltaOrExecutorGui(gui) then return true end
	return false
end

-- Kiểm tra phần tử có handler click thật sự (dùng getconnections nếu executor hỗ trợ).
local function guiHasClickConnection(obj)
	if not obj or type(getconnections) ~= "function" then return false end
	local ok, has = pcall(function()
		local signals = {}
		if obj.InputBegan then table.insert(signals, obj.InputBegan) end
		if obj.Activated then table.insert(signals, obj.Activated) end
		if obj.MouseButton1Click then table.insert(signals, obj.MouseButton1Click) end
		for _, sig in ipairs(signals) do
			local conns = getconnections(sig)
			if conns and #conns > 0 then return true end
		end
		return false
	end)
	return ok and has == true
end

-- Ứng viên: ImageButton (hoặc ImageLabel click được), nằm nửa trái màn hình,
-- không có chữ, không nằm trong cửa sổ menu lớn.
local function isGlobalLeftOnionImageButton(btn)
	if not btn or not btn.Parent then return false end
	local isImageButton = btn:IsA("ImageButton")
	local isImageLabel = btn:IsA("ImageLabel")
	if not (isImageButton or isImageLabel) then return false end
	if btn.Name == "BananaCatInnerSprite" or btn.Name == "BananaCatBadgeImage" or btn.Name == "GoldBadgeInnerDisc" then return false end
	if btn:FindFirstChild("BananaCatCircleAvatar") then return false end
	if btn.Parent and btn.Parent:FindFirstChild("BananaCatCircleAvatar") then return false end

	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local ax, ay = btn.AbsolutePosition.X, btn.AbsolutePosition.Y
	local bw, bh = getEffectiveBoxSize(btn)
	if bw < 14 or bh < 14 or bw > 110 or bh > 110 or math.abs(bw - bh) > 18 then return false end
	local inLeftLogoBand = ax >= vpW * 0.02 and ax <= vpW * 0.20
	local inRightTopOnionBand = ax >= vpW * 0.86 and ax <= vpW * 0.98
	-- FIX V1.1.0: nút phải thật ~40-70px (ảnh chụp: ~35px/512px chiều rộng),
	-- không phải 16-36px như cũ; Y cũng rộng hơn vì Steal Panel có thể lệch.
	local isSmallRightSquare = bw >= 16 and bw <= 72 and bh >= 16 and bh <= 72 and math.abs(bw - bh) <= 12
	local isTopRightOnionRow = ay >= vpH * 0.12 and ay <= vpH * 0.40
	if (not inLeftLogoBand and not (inRightTopOnionBand and isSmallRightSquare and isTopRightOnionRow))
		or ay < 0 or ay > vpH * 0.95 then return false end
	if isInsideLargeWindowFrame(btn) then return false end

	for _, d in ipairs(btn:GetDescendants()) do
		if d:IsA("TextLabel") and d.Visible and d.TextTransparency < 0.95 then
			local t = (d.Text or ""):match("^%s*(.-)%s*$") or ""
			if #t > 0 then return false end
		end
	end

	local function matchesOriginalOnionImage(obj)
		if not State.OnionAsset or State.OnionAsset == "" then return false end
		if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
			local asset = obj:GetAttribute("__OrigOnionImage") or obj:GetAttribute("__OrigImageAsset") or obj.Image
			if asset == State.OnionAsset then return true end
		end
		for _, d in ipairs(obj:GetDescendants()) do
			if d:IsA("ImageLabel") or d:IsA("ImageButton") then
				local asset = d:GetAttribute("__OrigOnionImage") or d:GetAttribute("__OrigImageAsset") or d.Image
				if asset == State.OnionAsset then return true end
			end
		end
		return false
	end
	if matchesOriginalOnionImage(btn) then return true end
	-- Fallback only for the small purple onion icon at the top of the right column.
	-- Egg and paw buttons sit lower and are deliberately excluded by the Y band.
	-- FIX V1.1.0: màu tím nằm ở khung Frame CHA (nền vuông tím), không nằm
	-- bên trong icon (icon trắng/trong suốt) nên phải soi cả khung cha.
	local function hasPurpleInChain(o)
		local cur = o
		for _ = 1, 3 do
			if cur and cur:IsA("GuiObject") and hasPurpleVisualInside(cur) then return true end
			cur = cur and cur.Parent or nil
		end
		return false
	end
	return inRightTopOnionBand and isSmallRightSquare and isTopRightOnionRow and hasPurpleInChain(btn)
end

local function applyBananaCatImageOverride(btn)
	if not btn or not btn.Parent then return end
	if btn:GetAttribute("__BananaCatImageOverride") == SID then return end
	local asset = resolveBananaCatOverrideAsset()

	local ok = pcall(function()
		btn:SetAttribute("__BananaCatImageOverride", SID)
		if not btn:GetAttribute("__OrigOnionImage") then
			btn:SetAttribute("__OrigOnionImage", btn.Image or "")
		end
		btn.Image = asset
		btn.ImageColor3 = Color3.fromRGB(255, 255, 255)
		btn.ImageTransparency = 0
		btn.ScaleType = Enum.ScaleType.Stretch
		btn.ImageRectOffset = STRETCH_CAT_OFFSET
		btn.ImageRectSize = STRETCH_CAT_SIZE
		btn.BackgroundTransparency = 1
		btn.BorderSizePixel = 0
	end)
	if not ok then return end

	-- Viền vàng kim loại mảnh, tĩnh (không loop, không jitter).
	pcall(function()
		local ring = btn:FindFirstChild("GlobalOnionGoldStroke")
		if not ring then
			ring = Instance.new("UIStroke")
			ring.Name = "GlobalOnionGoldStroke"
			ring.Thickness = 2
			ring.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			ring.Color = Color3.fromRGB(238, 210, 118)
			ring.Transparency = 0.05
			ring.Parent = btn
			applyMetallicGoldGradient(ring)
		end
	end)

	-- Âm thanh logo một lần mỗi cú chạm (chống bắn đúp).
	if btn:GetAttribute("__GlobalOnionSoundHooked") ~= SID then
		btn:SetAttribute("__GlobalOnionSoundHooked", SID)
		local lastPing = 0
		local function pingLogo()
			local now = os.clock()
			if now - lastPing < 0.18 then return end
			lastPing = now
			playUiSound("logo")
		end
		pcall(function()
			if btn.Activated then
				trackConn(btn.Activated:Connect(function()
					if isAlive() then pingLogo() end
				end))
			end
			if btn.MouseButton1Click then
				trackConn(btn.MouseButton1Click:Connect(function()
					if isAlive() then pingLogo() end
				end))
			end
		end)
	end
	-- Chặn hook âm thanh chung gắn thêm tiếng tap.
	btn:SetAttribute("__BananaGoldPulseHooked", SID)

	-- Khoá ảnh: nếu menu tự vẽ lại ảnh củ hành thì trả về Banana Cat ngay.
	if btn:GetAttribute("__BananaCatImageLocked") ~= SID then
		btn:SetAttribute("__BananaCatImageLocked", SID)
		pcall(function()
			trackConn(btn:GetPropertyChangedSignal("Image"):Connect(function()
				if not isAlive() then return end
				if btn:GetAttribute("__BananaCatImageOverride") ~= SID then return end
				local want = State.BananaCatOverrideAsset
				if want and btn.Image ~= want then
					pcall(function()
						btn.Image = want
						btn.ImageColor3 = Color3.fromRGB(255, 255, 255)
						btn.ImageTransparency = 0
					end)
				end
			end))
		end)
	end
end

local function scanGlobalLeftOnionButtonsOnce()
	local executorCache = {}
	local roots, seenRoots = {}, {}
	local function addRoot(r)
		if r and not seenRoots[r] then
			seenRoots[r] = true
			table.insert(roots, r)
		end
	end
	pcall(function() addRoot(game:GetService("CoreGui")) end)
	if LocalPlayer then
		local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if pg then addRoot(pg) end
	end
	if gethui then pcall(function() addRoot(gethui()) end) end

	for _, root in ipairs(roots) do
		local okD, desc = pcall(function() return root:GetDescendants() end)
		if okD and type(desc) == "table" then
			for _, d in ipairs(desc) do
				if isGlobalLeftOnionImageButton(d) then
					local gui = d:FindFirstAncestorOfClass("ScreenGui")
					if gui then
						local ignored = executorCache[gui]
						if ignored == nil then
							ignored = isExecutorOrIgnoredScreenGui(gui)
							executorCache[gui] = ignored
						end
						if not ignored then
							local target = d
							local p = d.Parent
							while p and p:IsA("GuiObject") do
								if p:IsA("ImageButton") then target = p; break end
								p = p.Parent
							end
							applyBananaCatImageOverride(target)
						end
					end
				end
			end
		end
	end
end

task.defer(function()
	if isAlive() then pcall(scanGlobalLeftOnionButtonsOnce) end
end)

-- Các mốc một lần (không phải vòng lặp) để bắt ScreenGui độc lập dựng muộn.
for _, delaySec in ipairs({ 1.00, 3.50 }) do
	task.delay(delaySec, function()
		if isAlive() then pcall(scanGlobalLeftOnionButtonsOnce) end
	end)
end

-- ============================================================================
-- 7D. NÚT CỦ HÀNH TÍM BÊN PHẢI - CỘT PHẢI NGOÀI STEAL PANEL (FIX V1.1.0)
--     Nút này KHÔNG đi qua decoratePurpleOnionButton() (hàm đó chặn cứng lề
--     trái) và KHÔNG bắt buộc trùng asset củ hành gốc: asset của nó có thể
--     khác asset logo trái/header, hoặc icon đã bị cắt bằng ImageRect.
--     Nhận diện bằng: vị trí cột phải + hàng trên + khung vuông + màu tím
--     (ở nút, con cháu, hoặc khung Frame cha) + không có chữ. Nút Trứng (đỏ)
--     và nút Chân thú (cam) nằm thấp hơn và không tím nên tự loại.
--     Chỉ thay ẢNH icon bên trong sang Banana Cat, GIỮ NGUYÊN khung vuông
--     tím bên ngoài - đúng yêu cầu "chỉ đổi logo, giữ khung vuông".
-- ============================================================================
local function hasPurpleVisualInChain(obj)
	if not obj then return false end
	local cur = obj
	for _ = 1, 3 do
		if cur and cur:IsA("GuiObject") then
			local ok, res = pcall(hasPurpleVisualInside, cur)
			if ok and res then return true end
		end
		cur = cur and cur.Parent or nil
	end
	return false
end

local function isRightTopPurpleOnionCandidate(obj)
	if not obj or not obj.Parent or not obj:IsA("GuiObject") then return false end
	if obj:IsA("ImageLabel") and obj.Name == "BananaCatInnerSprite" then return false end
	if obj:FindFirstChild("BananaCatCircleAvatar") then return false end
	if isInsideLargeWindowFrame(obj) then return false end
	if State.FiggyMainWindow and (obj == State.FiggyMainWindow or obj:IsDescendantOf(State.FiggyMainWindow)) then return false end

	local bw, bh = getEffectiveBoxSize(obj)
	if bw < 20 or bw > 80 or bh < 20 or bh > 80 or math.abs(bw - bh) > 14 then return false end

	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local ax, ay = obj.AbsolutePosition.X, obj.AbsolutePosition.Y
	if ax == 0 and ay == 0 then return false end
	-- Cột phải: X 84%-99%, hàng trên: Y 12%-40% chiều cao màn hình.
	if ax < vpW * 0.84 or ax > vpW * 0.99 then return false end
	if ay < vpH * 0.12 or ay > vpH * 0.40 then return false end

	for _, d in ipairs(obj:GetDescendants()) do
		if d:IsA("TextLabel") and d.Visible and d.TextTransparency < 0.95 then
			local t = (d.Text or ""):match("^%s*(.-)%s*$") or ""
			if #t > 0 then return false end
		end
	end

	return hasPurpleVisualInChain(obj)
end

local function findRightOnionImageElement(container)
	if not container then return nil end
	if container:IsA("ImageButton") or container:IsA("ImageLabel") then
		return container
	end
	-- Ưu tiên icon lớn nhất / rõ nhất bên trong khung vuông tím.
	local best, bestArea = nil, 0
	for _, d in ipairs(container:GetDescendants()) do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Name ~= "BananaCatInnerSprite" then
			local img = d.Image or ""
			if img ~= "" then
				local w, h = getEffectiveBoxSize(d)
				if w >= 12 and h >= 12 then
					local area = w * h
					if area > bestArea then best, bestArea = d, area end
				end
			end
		end
	end
	return best
end

local function applyRightOnionBanana(container)
	if not container or not container.Parent then return false end
	local imgEl = findRightOnionImageElement(container)
	if not imgEl then return false end
	if imgEl:GetAttribute("__RightOnionBanana") == SID then return true end
	-- Đã là Banana Cat rồi thì chỉ ghim lại state, không vẽ lại.
	local curImg = imgEl.Image or ""
	if curImg == BANANA_CAT_LOGO or (State.BananaCatOverrideAsset and curImg == State.BananaCatOverrideAsset) then
		imgEl:SetAttribute("__RightOnionBanana", SID)
		State.RightOnionButton = container
		State.RightOnionImage = imgEl
		return true
	end

	State.RightOnionButton = container
	State.RightOnionImage = imgEl
	-- Dùng đúng hàm override toàn cục: tự tải getcustomasset nếu có, khóa
	-- Image để menu vẽ lại cũng trả về Banana Cat, thêm viền vàng + âm thanh.
	pcall(applyBananaCatImageOverride, imgEl)
	imgEl:SetAttribute("__RightOnionBanana", SID)
	-- Khung vuông tím bên ngoài giữ nguyên: không bo tròn, không tạo coin disc.
	return true
end

local function scanRightOnionButtonOnce()
	-- Fast path: nút phải đã đổi xong và vẫn còn trên màn hình thì không quét lại.
	if State.RightOnionImage and State.RightOnionImage.Parent then
		local curImg = State.RightOnionImage.Image or ""
		if curImg == BANANA_CAT_LOGO or (State.BananaCatOverrideAsset and curImg == State.BananaCatOverrideAsset) then
			return true
		end
	end
	local found = false
	for _, root in ipairs(getUiRoots()) do
		local okD, desc = pcall(function() return root:GetDescendants() end)
		if okD and type(desc) == "table" then
			for _, d in ipairs(desc) do
				if isRightTopPurpleOnionCandidate(d) then
					if applyRightOnionBanana(d) then found = true end
				elseif d:IsA("ImageLabel") and d.Parent and isRightTopPurpleOnionCandidate(d.Parent) then
					if applyRightOnionBanana(d.Parent) then found = true end
				end
			end
		end
		if found then break end
	end
	return found
end
State.ScanRightOnionButtonOnce = scanRightOnionButtonOnce

local function scheduleRightOnionScan()
	if State.RightOnionScanPending then return end
	State.RightOnionScanPending = true
	task.defer(function()
		State.RightOnionScanPending = false
		if isAlive() then pcall(scanRightOnionButtonOnce) end
	end)
end

local function hookRightOnionScan()
	for _, root in ipairs(getUiRoots()) do
		if root and root:GetAttribute("__RightOnionHooked") ~= SID then
			root:SetAttribute("__RightOnionHooked", SID)
			-- Event-driven, không loop: Steal Panel / nút phải dựng muộn
			-- (mở panel sau nhiều phút) vẫn bắt được ngay khi xuất hiện.
			pcall(function()
				trackConn(root.DescendantAdded:Connect(function(desc)
					if not isAlive() or not desc or not desc.Parent then return end
					if desc:IsA("GuiObject") then
						scheduleRightOnionScan()
					end
				end))
			end)
		end
	end
end

task.defer(function()
	if isAlive() then
		pcall(hookRightOnionScan)
		pcall(scanRightOnionButtonOnce)
		pcall(scanGlobalLeftOnionButtonsOnce)
	end
end)

-- Các mốc muộn: bắt nút phải khi Steal Panel được mở / dựng lại sau khi load.
for _, delaySec in ipairs({ 1.00, 3.50, 8.00, 15.00 }) do
	task.delay(delaySec, function()
		if isAlive() then
			pcall(scanRightOnionButtonOnce)
			pcall(scanGlobalLeftOnionButtonsOnce)
		end
	end)
end

-- ============================================================================
-- 8. TIÊU ĐỀ HEADER, BIND LOGO VÀ VIỆT HÓA TỨC THỜI (0% LAG)
-- ============================================================================
local function bindHeaderAndLogosFromTitle(titleLbl)
	if not titleLbl or not titleLbl.Parent then return end
	local _, th = getEffectiveBoxSize(titleLbl)
	if th > 0 and th < 13 then return end

	-- Lưu lại khung cửa sổ chính để ngăn gắn nhầm logo vào các nút bên trong cửa sổ
	local curWin = titleLbl
	for _ = 1, 5 do
		if curWin and curWin.Parent and curWin.Parent:IsA("GuiObject") then
			curWin = curWin.Parent
			local sw, sh = getEffectiveBoxSize(curWin)
			if sw >= 220 and sh >= 150 then
				State.FiggyMainWindow = curWin
				break
			end
		else
			break
		end
	end

	local headerContainer = titleLbl.Parent
	for _ = 1, 3 do
		if headerContainer and headerContainer.Parent and headerContainer.Parent:IsA("GuiObject") then
			local _, hh = getEffectiveBoxSize(headerContainer.Parent)
			if hh > 0 and hh <= 78 then
				headerContainer = headerContainer.Parent
			else
				break
			end
		end
	end

	if not headerContainer then return end

	-- Logo góc trái trên thanh tiêu đề cửa sổ: HÌNH TRÒN (forceRoundedSquare = false)
	for _, d in ipairs(headerContainer:GetDescendants()) do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Name ~= "BananaCatInnerSprite" and d.Parent ~= State.LiveFiggyBadgeFrame then
			local pBox = d.Parent
			local pw, ph = getEffectiveBoxSize(pBox)
			local box = (pBox and pBox:IsA("GuiObject") and pw >= 16 and pw <= 46 and ph >= 16 and ph <= 46) and pBox or d
			local bw, bh = getEffectiveBoxSize(box)
			local isSmallSquare = (bw >= 16 and bw <= 46 and bh >= 16 and bh <= 46 and math.abs(bw - bh) <= 8)
			local isLeftOfTitle = (box.AbsolutePosition.X <= titleLbl.AbsolutePosition.X + 12)
			local isSameRow = (math.abs(box.AbsolutePosition.Y - titleLbl.AbsolutePosition.Y) <= 26)
			if isSmallSquare and isLeftOfTitle and isSameRow then
				-- Chụp asset ảnh củ hành gốc trước khi trang trí để nhận diện nút mở menu ngoài màn hình.
				if not State.OnionAsset then
					local function grabOnionAsset(o)
						if o:IsA("ImageLabel") or o:IsA("ImageButton") then
							local a = o:GetAttribute("__OrigImageAsset") or o.Image
							if a and a ~= "" then return a end
						end
						for _, chd in ipairs(o:GetDescendants()) do
							if chd:IsA("ImageLabel") or chd:IsA("ImageButton") then
								local a = chd:GetAttribute("__OrigImageAsset") or chd.Image
								if a and a ~= "" then return a end
							end
						end
						return nil
					end
					local capturedAsset = grabOnionAsset(box)
					if capturedAsset then State.OnionAsset = capturedAsset end
				end
				decoratePurpleOnionButton(box, 1.6, false, true)
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

local ROYAL_GOLD_BRIGHT = Color3.fromRGB(238, 210, 118) -- Màu vàng sáng của Toggle ON & Tab General (Lemon Theme)
local ROYAL_GOLD_MEDIUM = Color3.fromRGB(196, 168, 92)  -- Màu vàng vừa cho nút bấm & viền sáng
local ROYAL_GOLD_DARK   = Color3.fromRGB(64, 54, 34)    -- Màu nền vàng trầm sang trọng cho nút Join/Copy/Tab đang chọn

local function mapPurpleToRoyalGold(col)
	if not col then return SOFT_CHAMPAGNE_GOLD end
	-- Nếu là màu tím sáng (như thanh trượt Tone, nút Toggle ON, Tab General đang chọn: B > 0.70)
	if col.B > 0.70 then
		return ROYAL_GOLD_BRIGHT
	elseif col.B > 0.48 then
		return ROYAL_GOLD_MEDIUM
	else
		return ROYAL_GOLD_DARK
	end
end

local function styleElementGoldOnce(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end
	if obj.Name == "BananaCatCircleAvatar" or obj.Name == "BananaCatInnerSprite" or obj.Name == "LuxuryGoldCircleStroke" then return end
	if State.LiveFiggyBadgeFrame and (obj == State.LiveFiggyBadgeFrame or obj:IsDescendantOf(State.LiveFiggyBadgeFrame)) then
		return
	end

	pcall(function()
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			if isFiggyPurpleColor(obj.TextColor3) then
				obj:SetAttribute("__WasFiggyPurple", true)
				obj.TextColor3 = ROYAL_GOLD_BRIGHT
			end
			if isFiggyPurpleColor(obj.BackgroundColor3) then
				obj:SetAttribute("__WasFiggyPurple", true)
				obj.BackgroundColor3 = mapPurpleToRoyalGold(obj.BackgroundColor3)
			end
			if obj:GetAttribute("__GoldColorLocked") ~= SID then
				obj:SetAttribute("__GoldColorLocked", SID)
				trackConn(obj:GetPropertyChangedSignal("TextColor3"):Connect(function()
					if isAlive() and isFiggyPurpleColor(obj.TextColor3) then
						obj.TextColor3 = ROYAL_GOLD_BRIGHT
					end
				end))
				trackConn(obj:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
					if isAlive() and isFiggyPurpleColor(obj.BackgroundColor3) then
						obj.BackgroundColor3 = mapPurpleToRoyalGold(obj.BackgroundColor3)
					end
				end))
			end
		elseif obj:IsA("Frame") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") or obj:IsA("CanvasGroup") or obj:IsA("ScrollingFrame") then
			if isFiggyPurpleColor(obj.BackgroundColor3) then
				obj:SetAttribute("__WasFiggyPurple", true)
				obj.BackgroundColor3 = mapPurpleToRoyalGold(obj.BackgroundColor3)
			end
			if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and isFiggyPurpleColor(obj.ImageColor3) then
				obj:SetAttribute("__WasFiggyPurple", true)
				obj.ImageColor3 = ROYAL_GOLD_BRIGHT
			end
			if obj:GetAttribute("__GoldColorLocked") ~= SID then
				obj:SetAttribute("__GoldColorLocked", SID)
				trackConn(obj:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
					if isAlive() and isFiggyPurpleColor(obj.BackgroundColor3) then
						obj.BackgroundColor3 = mapPurpleToRoyalGold(obj.BackgroundColor3)
					end
				end))
				if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
					trackConn(obj:GetPropertyChangedSignal("ImageColor3"):Connect(function()
						if isAlive() and isFiggyPurpleColor(obj.ImageColor3) then
							obj.ImageColor3 = ROYAL_GOLD_BRIGHT
						end
					end))
				end
			end
		elseif obj:IsA("UIStroke") then
			if isFiggyPurpleColor(obj.Color) then
				obj:SetAttribute("__WasFiggyPurple", true)
				obj.Color = mapPurpleToRoyalGold(obj.Color)
			end
			if obj:GetAttribute("__GoldColorLocked") ~= SID then
				obj:SetAttribute("__GoldColorLocked", SID)
				trackConn(obj:GetPropertyChangedSignal("Color"):Connect(function()
					if isAlive() and isFiggyPurpleColor(obj.Color) then
						obj.Color = mapPurpleToRoyalGold(obj.Color)
					end
				end))
			end
		elseif obj:IsA("UIGradient") then
			if obj.Name ~= "LuxuryGoldGradient" and obj.Name ~= "LiquidGlassStrokeGrad" and obj.Name ~= "LiquidGlassBgGrad" and obj.Name ~= "CoinSurfaceGoldGrad" and obj.Name ~= "BananaGoldTitleGrad" then
				if obj.Parent and hasPurpleGradient(obj.Parent) then
					obj.Parent:SetAttribute("__WasFiggyPurple", true)
					applyMetallicGoldGradient(obj.Parent)
				end
			end
		end

		local grad = obj:FindFirstChildOfClass("UIGradient")
		if grad and grad.Name ~= "LuxuryGoldGradient" and grad.Name ~= "LiquidGlassStrokeGrad" and grad.Name ~= "LiquidGlassBgGrad" and grad.Name ~= "CoinSurfaceGoldGrad" and grad.Name ~= "BananaGoldTitleGrad" then
			if hasPurpleGradient(obj) then
				obj:SetAttribute("__WasFiggyPurple", true)
				applyMetallicGoldGradient(obj)
			end
		end
	end)
end

local function hookMenuButtonSound(inst)
	if not inst or not inst.Parent then return end
	if State.IslandGui and inst:IsDescendantOf(State.IslandGui) then return end
	-- Nút củ hành đã có âm thanh logo riêng trong playCircularLogoPulse.
	if State.OnionButton and (inst == State.OnionButton or inst:IsDescendantOf(State.OnionButton)) then return end
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

-- ============================================================================
-- 8B. TỰ ĐỘNG CHỌN THEME VÀNG HOÀNG GIA (LEMON) - ĐÚNG THẺ, MỘT LẦN, 0% LAG
-- ============================================================================
local function looksLikeGoldThemeText(t)
	local low = string.lower((t or ""):match("^%s*(.-)%s*$") or "")
	if low == "" then return false end
	if low:find("banana gold", 1, true) or low:find("frosted fig", 1, true) then return false end
	return low:find("lemon", 1, true) ~= nil
		or low:find("vàng hoàng gia", 1, true) ~= nil
		or low:find("vang hoang gia", 1, true) ~= nil
end

local function findThemeClickTarget(obj)
	local cur = obj
	for _ = 1, 6 do
		if not cur or not cur.Parent then break end
		if cur:IsA("GuiButton") then return cur end
		cur = cur.Parent
	end
	return nil
end

local function fireThemeClick(btn)
	if not btn then return false end
	local fired = false
	pcall(function()
		if firesignal then
			if btn.Activated then firesignal(btn.Activated); fired = true end
			if btn.MouseButton1Click then firesignal(btn.MouseButton1Click); fired = true end
			if btn.MouseButton1Down then firesignal(btn.MouseButton1Down); fired = true end
			if btn.MouseButton1Up then firesignal(btn.MouseButton1Up); fired = true end
		end
	end)
	pcall(function()
		if getconnections then
			for _, sig in ipairs({ btn.Activated, btn.MouseButton1Click, btn.MouseButton1Down, btn.MouseButton1Up }) do
				if sig then
					for _, c in ipairs(getconnections(sig)) do
						if c.Function then
							pcall(c.Function, { UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin })
							fired = true
						elseif c.Fire then
							pcall(c.Fire, c)
							fired = true
						end
					end
				end
			end
		end
	end)
	if fired then return true end
	-- Fallback: bấm đúng tâm thẻ theme nếu executor không đọc được connection.
	pcall(function()
		local VIM = game:GetService("VirtualInputManager")
		local pos, size = btn.AbsolutePosition, btn.AbsoluteSize
		local px, py = math.floor(pos.X + size.X * 0.5), math.floor(pos.Y + size.Y * 0.5)
		VIM:SendMouseButtonEvent(px, py, 0, true, game, 0)
		VIM:SendMouseButtonEvent(px, py, 0, false, game, 0)
		fired = true
	end)
	return fired
end

local function returnToHomeTab(root)
	if State.HomeTabReturned then return true end
	if not root or not root.Parent then return false end
	local okD, desc = pcall(function() return root:GetDescendants() end)
	if not okD or type(desc) ~= "table" then return false end
	for _, d in ipairs(desc) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local raw = d:GetAttribute("__FiggyOrigText") or d.Text or ""
			local label = string.lower((raw:match("^%s*(.-)%s*$") or ""))
			if label == "home" or label == "dashboard" or label == "trang chủ" then
				local button = findThemeClickTarget(d)
				if button and fireThemeClick(button) then
					State.HomeTabReturned = true
					return true
				end
			end
		end
	end
	return false
end

local function trySelectGoldThemeOnce()
	if State.GoldThemeApplied then return true end

	local targets = {}
	if State.ActiveFiggyGui and State.ActiveFiggyGui.Parent then
		table.insert(targets, State.ActiveFiggyGui)
	else
		for _, root in ipairs(getUiRoots()) do
			local okCh, children = pcall(function() return root:GetChildren() end)
			if okCh and type(children) == "table" then
				for _, gui in ipairs(children) do
					local gName = gui.Name or ""
					if gName ~= "BananaDynamicIsland" and gName ~= "FiggyDynamicIsland" and isFiggyWindowGui(gui) then
						table.insert(targets, gui)
					end
				end
			end
		end
	end

	for _, root in ipairs(targets) do
		local okD, desc = pcall(function() return root:GetDescendants() end)
		if okD and type(desc) == "table" then
			local candidate = nil
			local alreadySelected = false
			for _, d in ipairs(desc) do
				if d:IsA("TextLabel") or d:IsA("TextButton") then
					local orig = d:GetAttribute("__FiggyOrigText")
					local raw = orig or d.Text or ""
					local low = string.lower((raw or ""):match("^%s*(.-)%s*$") or "")
					local isGoldTheme = low:find("lemon", 1, true) ~= nil or looksLikeGoldThemeText(raw)
					if isGoldTheme then
						if low:find("•", 1, true) then
							alreadySelected = true
							break
						end
						if not candidate then candidate = d end
					end
				end
			end

			if alreadySelected then
				State.GoldThemeApplied = true
				task.defer(function()
					if isAlive() then pcall(returnToHomeTab, root) end
				end)
				return true
			end

			if candidate then
				local clickTarget = findThemeClickTarget(candidate) or candidate
				if fireThemeClick(clickTarget) then
					State.GoldThemeApplied = true
					State.GoldThemeAttempts = (State.GoldThemeAttempts or 0) + 1
					local attemptNo = State.GoldThemeAttempts
					if attemptNo <= 2 then
						task.delay(0.4, function()
							if not isAlive() or State.GoldThemeApplied == false then return end
							local verified = false
							local okD2, desc2 = pcall(function() return root:GetDescendants() end)
							if okD2 and type(desc2) == "table" then
								for _, dd in ipairs(desc2) do
									if dd:IsA("TextLabel") or dd:IsA("TextButton") then
										local o2 = dd:GetAttribute("__FiggyOrigText") or dd.Text or ""
										if string.lower(o2):find("lemon", 1, true) and o2:find("•", 1, true) then
											verified = true
											break
										end
									end
								end
							end
							if verified then
								task.defer(function()
									if isAlive() then pcall(returnToHomeTab, root) end
								end)
							else
								State.GoldThemeApplied = false
								pcall(trySelectGoldThemeOnce)
							end
						end)
					end
					return true
				end
			end
		end
	end
	return false
end

local function processGuiElement(obj)
	if not obj or not obj.Parent then return end
	if State.IslandGui and obj:IsDescendantOf(State.IslandGui) then return end

	-- FIX V1.1.0: nút củ hành tím bên phải - không qua decoratePurpleOnionButton
	-- (hàm đó chỉ cho lề trái), đi thẳng vào handler riêng ở mục 7D.
	if obj:IsA("GuiObject") and isRightTopPurpleOnionCandidate(obj) then
		pcall(applyRightOnionBanana, obj)
	end

	-- Kiểm tra và gắn logo Banana Cat vào đúng nút củ hành tím ở lề trái.
	if obj:IsA("Frame") or obj:IsA("ImageButton") or obj:IsA("TextButton") or obj:IsA("CanvasGroup") then
		local rootGui = obj:FindFirstAncestorOfClass("ScreenGui")
		local isVerified = rootGui and (rootGui:GetAttribute("__VerifiedFiggyWindowGui") == true) or false
		if isPurpleOnionSquareButton(obj, isVerified) then
			pcall(decoratePurpleOnionButton, obj, 2.0, false)
		end
	elseif obj:IsA("ImageLabel") and obj.Parent and (obj.Parent:IsA("Frame") or obj.Parent:IsA("ImageButton") or obj.Parent:IsA("CanvasGroup")) then
		local rootGui = obj:FindFirstAncestorOfClass("ScreenGui")
		local isVerified = rootGui and (rootGui:GetAttribute("__VerifiedFiggyWindowGui") == true) or false
		if isPurpleOnionSquareButton(obj.Parent, isVerified) then
			pcall(decoratePurpleOnionButton, obj.Parent, 2.0, false)
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

	local themeRaw = obj:GetAttribute("__FiggyOrigText") or obj.Text or ""
	if looksLikeGoldThemeText(themeRaw) then
		task.defer(function()
			if isAlive() then pcall(trySelectGoldThemeOnce) end
		end)
	end
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
	if State.ScanRightOnionButtonOnce then pcall(State.ScanRightOnionButtonOnce) end
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

	-- Bắt liên tục từng phần tử để đảm bảo khi chuyển Tab hoặc mở Menu luôn 100% tiếng Việt!
	local liveDescConn = gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		task.defer(function()
			if isAlive() and desc and desc.Parent then
				pcall(processGuiElement, desc)
			end
		end)
	end)
	trackConn(liveDescConn)

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

-- Bắt nóng ScreenGui mới tạo ngay ở 0.0 giây (kể cả khi đang chạy hiệu ứng mở menu)
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
	end

	-- Chọn theme Vàng Hoàng Gia (Lemon) đúng thẻ, một lần, không đổi màu toàn menu.
	pcall(trySelectGoldThemeOnce)

	-- Thực thi dứt khoát 1 lần sau khi giao diện khởi tạo xong (Zero-Lag, không dùng while loop)
	pcall(cleanupPreviousOverlaysAndDeduplicate)
	pcall(scanPurpleOnionButtonsOnce)
	pcall(scanRightOnionButtonOnce)
	pcall(refreshAllTranslatedMenus)
	pcall(trySelectGoldThemeOnce)

	-- Vài mốc một lần (không phải vòng lặp) để bắt kịp lúc menu dựng xong theme grid.
	for _, delaySec in ipairs({ 0.80, 3.20 }) do
		task.delay(delaySec, function()
			if not isAlive() then return end
			pcall(cleanupPreviousOverlaysAndDeduplicate)
			pcall(scanPurpleOnionButtonsOnce)
			pcall(scanRightOnionButtonOnce)
			pcall(refreshAllTranslatedMenus)
			pcall(trySelectGoldThemeOnce)
		end)
	end
end)
