-- ============================================================================
-- BANANA HUB V1.0.13 (LIQUID GLASS EDITION) | FIX ĐƠ: cleanup async + cache isFiggyWindowGui + chunk defer thay task.wait + early-exit isDeltaOrExecutorGui
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
-- [FIX-ĐƠ V2] Nguyên nhân chính gây đứng máy khi mở script:
--   (1) hookUiContainerForExactOnions nghe DescendantAdded trên TOÀN BỘ CoreGui/PlayerGui và mỗi
--       khi có 1 GuiObject mới ở vùng nút là quét lại TOÀN BỘ UI (kể cả RobloxGui) -> hub tạo vài trăm
--       phần tử = vài trăm lần quét đồng bộ = FPS về 0.
--   (2) task.defer KHÔNG nhường frame (chạy lại ngay trong cùng frame) nên chia lô bằng defer vô nghĩa.
--       Đã đổi sang task.wait()/task.delay trong luồng riêng để thật sự trải việc qua nhiều frame.
--   (3) Các hàm quét giờ: bỏ qua RobloxGui..., lọc kích thước trước, có khoá chống chạy chồng, tự nhường frame.
-- ============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

-- [FIX-ĐƠ] Bỏ :Wait() blocking - trên mobile LocalPlayer luôn có sẵn khi chạy script
local LocalPlayer = Players.LocalPlayer

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
State.RightOnionButton = nil -- Nút củ hành tím duy nhất ở lề phải (không gắn nhầm icon vật phẩm khác)
State.HeaderBadgeFrame = nil -- Logo nhỏ cạnh tiêu đề trong cửa sổ menu
State.OnionAsset = nil -- Asset ảnh củ hành gốc để nhận diện chính xác
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


-- ============================================================================
-- [FIX-ĐƠ V2] TIỆN ÍCH QUÉT AN TOÀN: bỏ GUI hệ thống, nhường frame, lọc nhanh
-- ============================================================================
local SCAN_YIELD_EVERY = 120
local function makeYielder()
	local n = 0
	return function()
		n = n + 1
		if n >= SCAN_YIELD_EVERY then
			n = 0
			task.wait()
		end
	end
end

-- Danh sách phần tử cần quét, bỏ qua RobloxGui/Chat/TopBar... (hàng nghìn phần tử không liên quan)
local function getScanList(root)
	local list = {}
	local okCh, children = pcall(function() return root:GetChildren() end)
	if not okCh or type(children) ~= "table" then return list end
	for _, ch in ipairs(children) do
		local n = ch.Name or ""
		if not IGNORED_SCREEN_GUIS[n] and not n:find("^Old_")
			and not ch:IsA("BillboardGui") and not ch:IsA("SurfaceGui") then
			list[#list + 1] = ch
			local okD, d = pcall(function() return ch:GetDescendants() end)
			if okD and type(d) == "table" then
				for i = 1, #d do list[#list + 1] = d[i] end
			end
		end
	end
	return list
end

-- Lọc nhanh theo kích thước nút vuông nhỏ (22..92) trước khi gọi các hàm đắt tiền
local function passesSquarePrefilter(obj)
	local a = obj.AbsoluteSize
	if a.X > 0 or a.Y > 0 then
		return a.X >= 22 and a.X <= 92 and a.Y >= 22 and a.Y <= 92
	end
	return true
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
	-- [FIX-ĐƠ] Nếu đã kiểm tra và xác định không phải Figgy → trả về false ngay, không quét lại
	if gui:GetAttribute("__IsExecutorGui") == true then return false end
	if gui:GetAttribute("__NotFiggyGui") == true then return false end

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
	-- [FIX-ĐƠ] Đánh dấu không phải Figgy để bỏ qua ngay ở lần sau, không quét GetDescendants lại
	gui:SetAttribute("__NotFiggyGui", true)
	return false
end

local function isDeltaOrExecutorGui(gui)
	if not gui then return false end
	if gui:GetAttribute("__VerifiedFiggyWindowGui") == true then return false end
	-- [FIX-ĐƠ] Nếu đã xác nhận là executor trước đó → trả về ngay
	if gui:GetAttribute("__IsExecutorGui") == true then return true end

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
		-- [FIX-GẮN-NHẦM] Chỉ khoá đúng 1 nút mỗi bên: 1 logo chính (trái) + 1 củ hành tím (phải).
		-- Nếu đã khoá rồi mà gặp container khác -> bỏ qua, không trang trí chồng lên nút khác của game.
		local isRightSide_ = container.AbsolutePosition.X >= vpW * 0.75
		if isRightSide_ then
			if State.RightOnionButton and State.RightOnionButton ~= container and State.RightOnionButton.Parent then
				return
			end
			State.RightOnionButton = container
		else
			if State.OnionButton and State.OnionButton ~= container and State.OnionButton.Parent then
				return
			end
			State.OnionButton = container
		end
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

	-- Logo chính/header tròn; nút củ hành bên phải là hình vuông bo góc đẹp (SQUARE_CORNER_UDIM)
	local isRightSquare = (forceRoundedSquare == true) or (container.AbsolutePosition.X >= vpW * 0.75)
	local targetCornerUdim = isRightSquare and SQUARE_CORNER_UDIM or CIRCLE_CORNER_UDIM

	local thick = strokeThickness or 2.0
	local coinDisc, stroke = buildFullCatGoldCoin(container, thick, (container.ZIndex or 5) + 8, isRightSquare)

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
-- 4. BỘ TỪ ĐIỂN & ĐỘNG CƠ VIỆT HÓA TOÀN DIỆN (SIÊU TỐC O(1) CACHE - 0% LAG)
-- ============================================================================
local FastCache = {}
local EXACT_VI
local LOWER_VI
local VI_TO_EN = {}

EXACT_VI={
["Home"]="Trang Chủ",["Dashboard"]="Trang Chủ",["Steal"]="Săn Trứng",["Farm"]="Tự Cày",["Event"]="Sự Kiện",["Events"]="Sự Kiện",["Player"]="Nhân Vật",["System"]="Cài Đặt",["Settings"]="Cài Đặt",["Halloween & Shooting Star"]="Halloween & Sao Băng",["Halloween & sao băng"]="Halloween & Sao Băng",["HALLOWEEN & SHOOTING STAR"]="HALLOWEEN & SAO BĂNG",["HALLOWEEN & SAO BĂNG"]="HALLOWEEN & SAO BĂNG",["The Hollow"]="Vực Hollow",["Hollow"]="Vực Hollow",
["Steal missing Halloween index"]="Cướp trứng Halloween thiếu trong Chỉ mục",["Steal missing Halloween index eggs"]="Cướp trứng Halloween thiếu trong Chỉ mục",["cướp missing Halloween index"]="Cướp trứng Halloween thiếu trong Chỉ mục",["Place eggs in pen and hatch missing in Egg Index"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",["Place and hatch eggs missing from your Egg Index"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",
["Đặt trứng vào chuồng và hatch thiếu trong Chỉ mục trứng"]="Đặt trứng vào chuồng và ấp trứng thiếu trong Chỉ mục",["PUMPKIN BOSS"]="BOSS BÍ NGÔ",["Pumpkin Boss"]="Boss Bí Ngô",["Auto Pumpkin Boss"]="Tự đánh Boss Bí Ngô",["Auto dodge attacks"]="Tự động né đòn đánh",["Dodge attacks"]="Tự động né đòn đánh",["Auto claim mastery"]="Tự động nhận thưởng Thông Thạo",["Tự động nhận mastery"]="Tự động nhận thưởng Thông Thạo",["Claim mastery"]="Nhận thưởng Thông Thạo",
["Mastery"]="Thông Thạo",["MASTERY"]="THÔNG THẠO",["Stub pickup speed"]="Tốc độ nhặt Cuống Bí Ngô",["Pickup speed"]="Tốc độ nhặt vật phẩm",["Tốc độ cuống pickup"]="Tốc độ nhặt Cuống Bí Ngô",["Auto manor key"]="Tự lấy chìa khóa dinh thự",["Manor key"]="Chìa khóa dinh thự",["MANOR KEY"]="CHÌA KHÓA DINH THỰ",["KILLS"]="SỐ LẦN HẠ",["Kills"]="Số lần hạ",["BOSS"]="TRÙM (BOSS)",["ALIVE"]="CÒN SỐNG",["Alive"]="Còn sống",["DEAD"]="ĐÃ HẠ",["Dead"]="Đã hạ",["SPAWNED"]="ĐÃ XUẤT HIỆN",
["Spawned"]="Đã xuất hiện",["NOT SPAWNED"]="CHƯA XUẤT HIỆN",["Not spawned"]="Chưa xuất hiện",["Cooldown"]="Đang hồi",["COOLDOWN"]="ĐANG HỒI",["Active"]="Đang bật",["ACTIVE"]="ĐANG BẬT",["Inactive"]="Đang tắt",["INACTIVE"]="ĐANG TẮT",["Sign In"]="Miễn phí",["Sign in"]="Miễn phí",["SIGN IN"]="MIỄN PHÍ",["Sign trong"]="Miễn phí",["Sign Up"]="Đăng ký",["Sign up"]="Đăng ký",["No plan"]="Miễn phí",["No Plan"]="Miễn phí",["FORCE JOIN"]="TỰ VÀO SAU",["Force Join"]="Tự vào sau",
["MIN VALUE"]="GIÁ TỐI THIỂU",["RARITY"]="ĐỘ HIẾM",["ACCOUNT"]="TÀI KHOẢN",["Account"]="Tài khoản",["Chilli Finder"]="Chilli Finder Free",["Chill Finder Free"]="Chilli Finder Free",["Chilli Finder Free"]="Chilli Finder Free",["Top 5 recent eggs | Book at chillihub.pro"]="Top 5 trứng mới nhất | Chilli Finder Free",["Sign in with your chillihub.pro account to join"]="Top 5 trứng mới nhất | Chilli Finder Free",
["Sign in with your chillihub.pro account"]="Top 5 trứng mới nhất | Chilli Finder Free",["No active booking. Book hours at chillihub.pro"]="Top 5 trứng mới nhất | Chilli Finder Free",["Finder"]="Tìm Trứng",["FINDER"]="TÌM TRỨNG",["finder"]="tìm trứng",["Scanning..."]="Đang quét...",["Scanning"]="Đang quét...",["Searching..."]="Đang tìm...",["Searching"]="Đang tìm...",["Checking..."]="Đang kiểm tra...",["Checking"]="Đang kiểm tra...",["Found!"]="Đã thấy!",["Found"]="Đã thấy",
["Egg Found!"]="Có trứng mới!",["Egg Found"]="Có trứng mới",["Waiting..."]="Đang chờ...",["Waiting"]="Đang chờ...",["No Eggs"]="Hết trứng",["No eggs"]="Hết trứng",["None"]="Không có",["Auto On"]="Tự động: BẬT",["Auto Off"]="Tự động: TẮT",["AUTO ON"]="TỰ ĐỘNG: BẬT",["AUTO OFF"]="TỰ ĐỘNG: TẮT",["Cooldown"]="Đang hồi...",["Ready"]="Sẵn sàng",["Chilli Finder"]="Chill Finder Free",["Top 5 recent eggs | Book at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",
["Sign in with your chillihub.pro account to join"]="Top 5 recent eggs | Chill Finder Free",["Sign in with your chillihub.pro account"]="Top 5 recent eggs | Chill Finder Free",["No active booking. Book hours at chillihub.pro"]="Top 5 recent eggs | Chill Finder Free",["Venyx"]="Banana Hub",["VENYX"]="Chilli Hub V8 Supreme",["Media"]="Mạng Xã Hội",["Chat"]="Trò Chuyện",["Features"]="Tính Năng",["Egg"]="Trứng (Egg)",["Pet"]="Thú Cưng (Pet)",["Activities"]="Hoạt Động",
["Barn"]="Chuồng Trại",["Others"]="Khác",["Keyless"]="Không cần Key",["Anime"]="Chế độ Anime",["Search..."]="Tìm kiếm...",["Steal Egg"]="Cướp Trứng",["Filtering"]="Bộ Lọc",["Strict Filter"]="Lọc Nghiêm Ngặt",["Only target eggs that match every filter you set."]="Chỉ cướp trứng khớp với mọi bộ lọc bạn đã cài.",["Steal Priority"]="Ưu Tiên Cướp",["Select Area"]="Chọn Khu Vực",["Select Rarity"]="Chọn Độ Hiếm",
["Select Pet"]="Chọn Thú Cưng",["Select Mutation"]="Chọn Đột Biến",["Min Value"]="Giá Trị Tối Thiểu",["Target eggs earning at least this much per second, mutations included (e.g. 500k, 1.5m). 0 or empty to disable."]="Chỉ cướp trứng kiếm được ít nhất mức này mỗi giây (VD: 500k, 1.5m). Nhập 0 để tắt.",["Indexing"]="Chỉ Mục (Index)",["Auto Claim Index"]="Tự Nhận Thưởng Chỉ Mục",["Redeems unlocked index rewards."]="Tự động nhận phần thưởng từ danh mục đã mở khóa.",
["Auto Indexing"]="Tự Động Thu Thập Chỉ Mục",["Auto Steal only targets eggs you haven't indexed or owned yet. Other filters are ignored."]="Chỉ cướp các trứng bạn chưa có trong chỉ mục. Các bộ lọc khác sẽ bị bỏ qua.",["Steal Settings"]="Cài Đặt Cướp",["Steal Mode"]="Chế Độ Cướp",["Normal flies to the egg, Instant Steal works in every area."]="Bình thường sẽ bay tới trứng. Cướp Tức Thì hoạt động ở mọi khu vực.",["Normal"]="Bình Thường",["Delivery Mode"]="Chế Độ Giao Trứng",
["Recommended Delivery Mode: Speed Match or Steady"]="Khuyên dùng: Tốc độ khớp hoặc Ổn định",["Speed Match"]="Tốc độ khớp",["Steady"]="Ổn định",["Steal From Player"]="Cướp Từ Người Chơi",["Steals eggs from other players."]="Cướp trứng từ tay người chơi khác.",["Server Hop (No Target)"]="Đổi Server (Khi Hết Mục Tiêu)",["Hops server when no target is found."]="Tự động đổi máy chủ khi không tìm thấy trứng mục tiêu.",["Drop for Friend"]="Nhặt Hộ Bạn Bè",
["Drops the egg at the drop point and leaves it for a friend to pick up, then looks for another egg."]="Mang trứng đến điểm hẹn, thả xuống cho bạn bè nhặt và đi tìm trứng khác.",["Flies to field eggs, grabs them and brings them home."]="Bay tới bãi, nhặt trứng và mang về nhà.",["Steal Other Script"]="Cướp Của Script Khác",["Grabs eggs other players drop near safezone."]="Nhặt trứng mà các người chơi dùng script khác làm rớt gần vùng an toàn.",
["Steal Status"]="Trạng Thái Cướp",["Shows the Auto Steal status panel."]="Hiển thị bảng trạng thái tự động cướp.",["Open Steal Panel"]="Mở Bảng Cướp Trứng",["Find and steal World and Halloween eggs by hand."]="Tìm và cướp trứng Thế Giới / Halloween bằng tay.",["Open Steal History"]="Mở Lịch Sử Cướp",["Open the last 10 steal results in a separate window."]="Mở 10 kết quả cướp gần nhất ở cửa sổ riêng.",
["Egg Utilities"]="Tiện Ích Trứng",["Open Egg Predictor"]="Mở Dự Đoán Trứng",["Open standalone egg cycle predictor window."]="Mở cửa sổ dự đoán chu kỳ trứng riêng biệt.",["Egg Inventory Value"]="Giá Trị Trứng Trong Túi",["Show generation rate (/s) and sell price on backpack egg slots."]="Hiển thị tốc độ sinh tiền (/s) và giá bán trên từng ô trứng trong ba lô.",["Place Egg"]="Đặt Trứng Vào Chuồng",["Hatch Egg"]="Ấp Trứng",["Stop At Rarity"]="Dừng Lại Ở Độ Hiếm",
["Eggs of this rarity or higher won't be placed."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi đặt.",["Eggs of this rarity or higher won't be hatched."]="Trứng đạt độ hiếm này hoặc cao hơn sẽ không bị mang đi ấp.",["Whitelist"]="Danh Sách Trắng (Ưu Tiên)",["Blacklist"]="Danh Sách Đen (Bỏ Qua)",["Whitelist Rarity"]="Ưu Tiên Độ Hiếm",["Whitelist Pet"]="Ưu Tiên Thú Cưng",["Whitelist Mutation"]="Ưu Tiên Đột Biến",
["Blacklist Rarity"]="Bỏ Qua Độ Hiếm",["Blacklist Pet"]="Bỏ Qua Thú Cưng",["Blacklist Mutation"]="Bỏ Qua Đột Biến",["Auto Place Egg"]="Tự Động Đặt Trứng",["Places matching eggs from your bag into the pen. Whitelist picks which eggs, blacklist always blocks."]="Đặt trứng phù hợp từ túi vào chuồng. Ưu tiên các mục trong Whitelist, luôn chặn mục trong Blacklist.",["Auto Place Indexing"]="Tự Động Đặt Lấy Chỉ Mục",
["Auto Place Egg only places eggs you haven't indexed yet. Whitelist and blacklist are ignored."]="Chỉ tự động đặt các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist và Blacklist.",["Automatically hatch ready eggs matching the selected filters."]="Tự động ấp các trứng đã sẵn sàng và khớp với bộ lọc.",["Auto Hatch Indexing"]="Tự Động Ấp Lấy Chỉ Mục",
["Auto Hatch only hatches eggs you haven't indexed yet. Whitelist is ignored, blacklist still applies."]="Chỉ ấp các trứng bạn chưa có trong danh mục. Bỏ qua Whitelist, vẫn áp dụng Blacklist.",["Sell Egg"]="Bán Trứng",["Keep Above"]="Giữ Lại Trên Mức",["Never sell eggs earning at least this much per second (e.g. 100m). 0 or empty to disable."]="Không bao giờ bán trứng kiếm được trên mức này mỗi giây (VD: 100m). Nhập 0 để tắt.",
["Sells eggs that pass your filters. Placed eggs are never sold."]="Bán trứng lọt qua bộ lọc. Trứng đã đặt trong chuồng sẽ không bao giờ bị bán.",["Sell On Inventory Full"]="Chỉ Bán Khi Đầy Túi",["Only sell when your egg backpack is full."]="Chỉ kích hoạt bán khi ba lô chứa trứng đã đầy.",["Player Stats"]="Thống Kê Người Chơi",["Money"]="Tiền",["Gems"]="Đá Quý",["Equipped"]="Đang Trang Bị",["Gain"]="Tăng Tốc Độ",["Inventory"]="Túi Đồ",["Map"]="Bản Đồ",["World"]="Thế Giới",
["Discord webhook URL for sending notifications."]="Đường dẫn Webhook Discord để gửi thông báo.",["Ping @everyone"]="Tag @everyone",["Mention @everyone in Discord when a new egg is claimed."]="Gắn thẻ @everyone trên Discord khi nhận được trứng mới.",["Egg Webhook"]="Webhook Trứng",["Select Egg Rarity"]="Chọn Độ Hiếm Của Trứng",
["Enable New Egg Claimed"]="Bật Thông Báo Trứng Mới",["Send webhook notification when stealing/claiming a new egg."]="Gửi thông báo Webhook khi cướp/nhận được trứng mới.",["Player Webhook"]="Webhook Người Chơi",["Stats Interval (Min)"]="Khoảng Thời Gian Báo Thống Kê (Phút)",["Enable Player Stats"]="Bật Thông Báo Thống Kê",["Periodically send player stats to Discord."]="Định kỳ gửi thông số người chơi qua Discord.",
["Test Webhook"]="Thử Nghiệm Webhook",["Send Stats Now"]="Gửi Thống Kê Ngay Lúc Này",["Immediately send stats to Discord."]="Gửi ngay thông số người chơi vào Discord.",["Test Egg Webhook"]="Gửi Thử Webhook Trứng",["Simulate claiming an egg."]="Mô phỏng thao tác nhận trứng để kiểm tra.",["Admin Abuse Boost (BETA)"]="Nhận Buff Quyền Admin (BETA)",["Halloween Dimension"]="Không Gian Halloween",["Ghost Dog Quest"]="Nhiệm Vụ Chó Ma",["Abandoned Manor"]="Dinh Thự Bỏ Hoang",
["Pumpkin King"]="Vua Bí Ngô",["The Hollow"]="Vực Hollow",["just now"]="vừa xong",["Just now"]="Vừa xong",["Inventory values"]="Giá trị túi đồ",["Inventory Values"]="Giá trị túi đồ",["Find option"]="Tìm tùy chọn",["🔍 Find option"]="🔍 Tìm tùy chọn",["Tip: you can also hold any feature to pin it or set a key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",
["Tip: you can also hold any feature to pin it or set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",["Tip: you can also hold any feature to pin it hoặc set key."]="Mẹo: Nhấn giữ tính năng bất kỳ để ghim lên Thanh Nhanh hoặc gán phím tắt.",["v1.4.2: Fixed some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",["v1.4.2: fixed some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",["v1.4.2: đã sửa some bugs"]="v1.4.2: Đã sửa một số lỗi vặt",
["v1.4.1: Movement speed up to 110%, improved Fast Tween"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",["v1.4.1: Di Chuyển tốc độ up tới 110%, improved Fast Bay (Tween)"]="v1.4.1: Tăng tốc độ di chuyển lên tới 110%, cải thiện Bay Nhanh (Fast Tween)",
["v1.4.0: Auto Pumpkin Boss (dodges attacks, fires cannons, collects Pumpkin Stubs), auto manor key, and Go to Egg Leap (replaces old Go to Egg)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",
["v1.4.0: tự động bí ngô Boss (dodges attacks, fires cannons, collects bí ngô Stubs), tự động manor key, và Di Chuyển tới trứng Leap (replaces old Di Chuyển tới trứng)"]="v1.4.0: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng (thay thế Đi Tới Trứng cũ)",["v1.3.0: Anti guard fires again, and finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",
["v1.3.0: Anti vệ sĩ fires again, và finishes about twice as fast"]="v1.3.0: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi",["Go to Egg Leap"]="Nhảy Tới Trứng",["Go to egg leap"]="Nhảy tới trứng",["Manor key"]="Chìa khóa dinh thự",["Auto manor key"]="Tự lấy chìa khóa dinh thự",["Auto Pumpkin Boss"]="Tự đánh Boss Bí Ngô",["Pumpkin Boss"]="Boss Bí Ngô",["Pumpkin Stubs"]="Cuống Bí Ngô",
["Going into the Halloween Dimension"]="Đang vào Không gian Halloween",["Going into Halloween Dimension"]="Đang vào Không gian Halloween",["Leaving Halloween Dimension"]="Đang rời Không gian Halloween",["Entering Halloween Dimension"]="Đang vào Không gian Halloween",
["v1.2.9: New optimizer modes: Balanced, Strong (way much higher FPS, ultra-low GPU), no lag spike when you turn it on"]="v1.2.9: Chế độ tối ưu mới: Cân bằng, Mạnh (tăng FPS cực cao, siêu nhẹ GPU), không bị khựng lag khi bật",["v1.2.8: Inventory values, see how much every pet and every egg in your backpack is worth"]="v1.2.8: Giá trị túi đồ, xem giá trị của từng pet và từng quả trứng trong ba lô",["v1.2.7: Auto race The Hollow"]="v1.2.7: Tự động đua sự kiện The Hollow",
["v1.2.7: Auto race Hollow"]="v1.2.7: Tự động đua sự kiện Hollow",["Auto race Hollow"]="Tự động đua sự kiện Hollow",["Balanced"]="Cân bằng",["Strong"]="Mạnh",["v1.2.6: Mutate eggs you choose with multiple mutations, much shorter delay between tasks and instant take back when someone grabs your egg"]="v1.2.6: Đột biến trứng tự chọn với nhiều đột biến, giảm độ trễ giữa các tác vụ và giật lại tức thì khi bị cướp",["v1.2.5: Teleport to egg"]="v1.2.5: Dịch chuyển tới trứng",
["Riding the Phantom Express"]="Đang đi Tàu Bóng Ma",["Fighting Small monster"]="Đang đánh quái vật nhỏ",["Fighting Medium monster"]="Đang đánh quái vật vừa",["Fighting Large monster"]="Đang đánh quái vật lớn",["UI scale"]="Kích cỡ Menu",["Show / hide UI"]="Phím ẩn / hiện Menu",["Opacity"]="Độ trong suốt",["Tone"]="Tông màu",["Dim the game"]="Làm tối nền game",
["QUICK BARS"]="THANH PHÍM TẮT NHANH",["Quick bars"]="Thanh phím tắt nhanh",["Show quick bars"]="Hiện thanh phím tắt nhanh",["Keybinds"]="Phím tắt",["Bar size"]="Kích cỡ thanh nhanh",["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT",["Find option"]="Tìm tùy chọn",["All"]="Tất cả",["Pinned"]="Đã ghim",["Clear all quick bars"]="Xóa hết thanh nhanh",["Clear all keybinds"]="Xóa hết phím tắt",
["DEFAULTS"]="MẶC ĐỊNH",["Reset to defaults"]="Khôi phục mặc định",["Reset"]="Đặt lại",["Turn off all toggles"]="Tắt toàn bộ công tắc",["Turn off"]="Tắt hết",["Steal An Egg"]="Cướp Trứng",["CANDY CORN"]="KẸO NGÔ",["Candy Corn"]="Kẹo Ngô",["Calculate mutations"]="Tính thử đột biến",["Cards show the value with these mutations added"]="Thẻ trứng sẽ hiển thị giá trị sau khi cộng thêm các đột biến này",
["Delivery speed"]="Tốc độ mang trứng về",["Change if steal fails"]="Hãy chỉnh giảm xuống nếu cướp trứng bị lỗi",["Auto farm monsters"]="Tự động cày quái vật",["Auto kill monsters"]="Tự động đánh quái vật",["Bat"]="Gậy Dơi (Bat)",["Instant steal"]="Cướp tức thì",["Admin treadmill"]="Máy tập Admin",["CURSED ISLAND WARS"]="ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",["Cursed Island Wars"]="Đại Chiến Đảo Nguyền Rủa",["Waiting for Cursed Island Wars"]="Đang chờ Đại Chiến Đảo Nguyền Rủa",
["Auto play Cursed Island Wars"]="Tự động chơi Đại Chiến Đảo Nguyền Rủa",["Island Wars target"]="Mục tiêu Đảo Nguyền Rủa",["Enemies and base"]="Kẻ địch và Căn cứ",["Walls and crystal"]="Tường chắn và Pha lê",["Catching a pumpkin"]="Đang nhặt bí ngô",["Carrying a pumpkin to the altar"]="Đang mang bí ngô tới bệ thờ",["Delivering a pumpkin to the altar"]="Đang giao bí ngô tới bệ thờ",["FIX"]="SỬA LỖI",["Most tokens"]="Nhiều kẹo/xu nhất",
["Admin abuse works like Chilli: admin treadmill, Capture the egg, minigame eggs and Instant steal"]="Lạm dụng Admin hoạt động chuẩn: Máy tập Admin, Cướp trứng sự kiện, trứng Minigame và Cướp tức thì",["Fixed lag back with the Tween delivery method"]="Đã sửa lỗi giật lùi (lag back) khi mang trứng về bằng chế độ Bay (Tween)",["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",
["v1.1.0: Halloween tasks follow Task order, Walk speed for monsters, pumpkins and ghosts, Use weapons picks every weapon, Lab and Race shop removed"]="v1.1.0: Nhiệm vụ Halloween tuân theo Thứ tự tác vụ, thêm Tốc độ chạy khi săn quái, bí ngô và ma, Sử dụng vũ khí tự chọn mọi loại vũ khí, đã gỡ bỏ Phòng Lab và Shop Đua Xe",
["Halloween: Dimension eggs, monsters, Ghost Dog quest, fishing, Phantom Express and Cursed Island Wars"]="Sự kiện Halloween: Trứng Không gian Halloween, đánh quái, nhiệm vụ Chó Ma, câu cá, Tàu Ma Phantom Express và Đại Chiến Đảo Nguyền Rủa",["Idle"]="Đang rảnh",["Waiting"]="Đang chờ",["Nothing"]="Không có gì",["None"]="Không có",["Off"]="Tắt",["OFF"]="TẮT",["On"]="Bật",["ON"]="BẬT",
["No egg matches your targets"]="Không có trứng nào khớp mục tiêu",["No eggs match your targets"]="Không có trứng nào khớp mục tiêu",["No egg matches filter"]="Không có trứng khớp bộ lọc",["No eggs match filter"]="Không có trứng khớp bộ lọc",["No target egg found"]="Không tìm thấy trứng mục tiêu",["No matching eggs"]="Không có trứng nào khớp",["No valid targets"]="Không có mục tiêu hợp lệ",
["Bag is full"]="Túi đã đầy",["Egg bag is full"]="Túi trứng đã đầy",["Pet bag is full"]="Túi pet đã đầy",["Pen is full"]="Chuồng ấp đã đầy",["Field is closed"]="Sân trứng đang đóng",["Waiting for field to open"]="Đang chờ sân trứng mở",["Waiting for eggs to spawn"]="Đang chờ trứng xuất hiện",["Waiting in safe zone"]="Đợi ở vùng an toàn",["Returning to safe zone"]="Đang về vùng an toàn",["Returning home"]="Đang quay về nhà",
["Delivering egg"]="Đang giao trứng về chuồng",["Dropping egg"]="Đang thả trứng",["Selling eggs"]="Đang bán trứng",["Selling pets"]="Đang bán pet",["Hatching eggs"]="Đang ấp trứng",["Placing eggs"]="Đang đặt trứng",["Mutating eggs"]="Đang đột biến trứng",["Fusing pets"]="Đang dung hợp pet",["Hopping server"]="Đang đổi máy chủ",["Rejoining"]="Đang vào lại phòng",["Avoiding guard"]="Đang né vệ sĩ",
["Using treadmill"]="Đang chạy máy tập",["Upgrading treadmill"]="Đang nâng cấp máy tập",["Upgrading base"]="Đang nâng cấp căn cứ",["Claiming rewards"]="Đang nhận thưởng",["Claiming offline cash"]="Đang nhận tiền ngoại tuyến",["Joining race"]="Đang vào đường đua",["Racing"]="Đang đua xe",["Welcome Home"]="Trang Chủ",["Welcome back"]="Chào mừng trở lại",["Venyx Discord"]="Chilli Hub Discord",
["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ",["Copy Invite"]="Chép Link Mời",["Copy invite"]="Chép Link Mời",["Copy link"]="Chép Link Mời",["Discord"]="Banana Hub",["MONEY /S"]="TIỀN /GIÂY",["CASH / S"]="TIỀN / GIÂY",["OPEN"]="MỞ",["Open"]="Mở",["Close"]="Đóng",["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V8! Tham gia Discord để cập nhật và nhận hỗ trợ",
["Beta version"]="Phiên bản Beta",["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",["Rejoin"]="Vào lại",["Server hop"]="Đổi server",["Copy Job ID"]="Chép Job ID",["Unload hub"]="Tắt Hub",["Unload"]="Tắt Hub",["Save config"]="Lưu cấu hình",["Hide UI"]="Ẩn Menu",
["SESSION"]="PHIÊN CHƠI",["STOLEN"]="ĐÃ CƯỚP",["LAST EGG"]="TRỨNG CUỐI",["PLACED"]="ĐÃ ĐẶT",["HATCHED"]="ĐÃ ẤP",["NIGHT IN"]="ĐÊM SAU",["NEXT NIGHT"]="ĐÊM SAU",["SESSION TIME"]="THỜI GIAN",["TIME"]="THỜI GIAN",["BEST STEAL"]="CƯỚP TỐT NHẤT",["EGG BAG"]="TÚI TRỨNG",["PET BAG"]="TÚI PET",["WHAT'S NEW"]="CÓ GÌ MỚI",["NEW"]="MỚI",["Search"]="Tìm kiếm",["Filter"]="Lọc tìm",["Auto Steal"]="Tự Động Cướp",["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
["Auto steal"]="Tự động cướp",["Egg Predictor"]="Dự Đoán Trứng",["Go to egg"]="Di chuyển tới trứng",["Teleport to egg"]="Dịch chuyển tới trứng",["Walk to egg"]="Đi bộ tới trứng",["Tween to egg"]="Bay mượt tới trứng",["Teleport zones"]="Khu vực dịch chuyển",["Tween"]="Bay (Tween)",["Walk"]="Đi bộ",["Delivery method"]="Cách mang về",["Instant steps"]="Tức thì từng bước",["Instant"]="Tức thì",["Teleport"]="Dịch chuyển",
["Fast tween speed"]="Tốc độ bay nhanh",["Tween speed"]="Tốc độ bay",["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục",["Steal back from players"]="Cướp lại từ người chơi",["Steal from other players"]="Cướp từ người chơi khác",["Anti guard"]="Chống vệ sĩ",["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn",["FILTER"]="BỘ LỌC",
["Zones"]="Khu vực",["Steal first"]="Ưu tiên cướp",["Best value"]="Giá trị cao nhất",["Lowest value"]="Giá trị thấp nhất",["Best rarity"]="Độ hiếm cao nhất",["Best mutation"]="Đột biến tốt nhất",["Biggest"]="Kích thước to nhất",["Closest"]="Khoảng cách gần nhất",["Nearest"]="Gần nhất",["Mutations"]="Đột biến",["Rarities"]="Độ hiếm",["Only these eggs"]="Chỉ những trứng này",["Min value /s"]="Giá trị tối thiểu /s",["Max value /s"]="Giá trị tối đa /s",
["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi",["Keep lab eggs"]="Giữ lại trứng Lab",["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ",["Auto hop server"]="Tự đổi máy chủ",["Auto hop"]="Tự động đổi server",["Hop now"]="Đổi server ngay",["First hop after"]="Đổi lần đầu sau",["Hop when"]="Đổi khi",["After stealing a match"]="Sau khi cướp đủ trứng lọc",["No matching egg"]="Không có trứng phù hợp",["Rare from"]="Độ hiếm từ",
["Hop delay"]="Độ trễ đổi server",["Only sell eggs below /s"]="Chỉ bán trứng dưới mức /s",["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG",["Sort eggs"]="Sắp xếp trứng",["Preview card"]="Thẻ xem trước",["Pick one"]="Chọn một mục",["Pick any"]="Chọn bất kỳ",["Value"]="Giá trị",["Rarity"]="Độ hiếm",["Time left"]="Thời gian còn lại",["Default"]="Mặc định",["Clear"]="Xóa chọn",["Select all"]="Chọn tất cả",
["SIZE"]="KÍCH CỠ",["WEIGHT"]="CÂN NẶNG",["READY"]="SẴN SÀNG",["IN BAG"]="TRONG TÚI",["GROWING"]="ĐANG LỚN",["Hatch now"]="Ấp ngay",["Hold egg"]="Cầm trứng",["Fly to egg"]="Bay tới trứng",["Steal egg"]="Cướp trứng",["Enchanted Forest"]="Rừng Phù Phép",["Light Dark"]="Sáng Tối",["Titan Temple"]="Đền Titan",["Cherry Blossom"]="Hoa Anh Đào",["Prehistoric"]="Tiền Sử",["Abyss Ocean"]="Đáy Đại Dương",["Volcano"]="Núi Lửa",["Snow"]="Tuyết",["Jungle"]="Rừng Rậm",
["Desert"]="Sa Mạc",["Lake"]="Hồ Nước",["Forest"]="Khu Rừng",["Silver"]="Bạc",["Rainbow"]="Cầu Vồng",["Golden"]="Vàng",["Fractured"]="Rạn Nứt",["Scrambled"]="Hỗn Loạn",["Enchanted"]="Phù Phép",["Nitro"]="Nitro",["SCRAMBLED"]="HỖN LOẠN",["NITRO"]="NITRO",["FRACTURED"]="RẠN NỨT",["ENCHANTED"]="PHÙ PHÉP",["Pen"]="Chuồng Ấp",["PEN"]="CHUỒNG ẤP",["Treadmill"]="Máy Tập",["TREADMILL"]="MÁY TẬP CHẠY",["Mutate"]="Đột Biến",
["Sell"]="Bán",["SELL"]="BÁN TỰ ĐỘNG",["Fuse"]="Dung Hợp",["FUSE"]="DUNG HỢP",["Priority"]="Ưu Tiên",["PRIORITY"]="THỨ TỰ ƯU TIÊN",["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG",["Auto place"]="Tự động đặt trứng",["Place when"]="Đặt khi",["Always"]="Luôn luôn",["Place first"]="Ưu tiên đặt",["KEEP EGGS"]="GIỮ LẠI TRỨNG",["Eggs to keep"]="Trứng cần giữ",
["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG",["Auto hatch"]="Tự động ấp trứng",["Equip best pets"]="Trang bị pet mạnh nhất",["READY NOW"]="SẴN SÀNG ẤP",["Auto treadmill"]="Tự chạy máy tập",["Auto upgrade treadmill"]="Tự nâng cấp máy tập",["PROGRESS"]="TIẾN TRÌNH",["Auto upgrade base"]="Tự nâng cấp căn cứ",["Auto buy trails"]="Tự mua vệt sáng",["Auto claim offline cash"]="Tự nhận tiền ngoại tuyến",["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục",
["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN",["Auto mutate"]="Tự động đột biến",["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN",["Use items"]="Dùng vật phẩm",["Mutate first"]="Ưu tiên đột biến",["Skip eggs with"]="Bỏ qua trứng đã có",["Auto buy Nitro"]="Tự mua Nitro",["PETS"]="THÚ CƯNG (PETS)",["EGGS"]="TRỨNG (EGGS)",["Auto sell pets"]="Tự động bán pet",["Auto sell eggs"]="Tự động bán trứng",["Sell all eggs now"]="Bán hết trứng ngay",["Sell all pets now"]="Bán hết Pet ngay",
["Sell rarities"]="Độ hiếm bán",["Never sell"]="Không bao giờ bán",["Only mutations"]="Chỉ bán đột biến",["Only below /s"]="Chỉ dưới mức /s",["Keep mutated"]="Giữ lại đồ đột biến",["LAB EGGS"]="TRỨNG PHÒNG LAB",["FAVORITE"]="YÊU THÍCH (KHÓA)",["Auto favorite"]="Tự động khóa bảo vệ",["Favorite matching now"]="Khóa đồ khớp lọc ngay",["Unfavorite pets not matching"]="Bỏ thích Pet không khớp",["Always favorite"]="Luôn khóa Yêu thích",
["Auto sell lab eggs"]="Tự động bán trứng Lab",["Match"]="Điều kiện khớp",["All picked rules"]="Khớp tất cả quy tắc",["Any picked rule"]="Khớp bất kỳ quy tắc",["Favorite equipped"]="Khóa pet đang trang bị",["FUSE MACHINE"]="MÁY DUNG HỢP",["No 3 matching pets"]="Chưa đủ 3 pet cùng loại",["Auto fuse"]="Tự động dung hợp",["Fuse first"]="Ưu tiên dung hợp",["Lowest rarity"]="Độ hiếm thấp nhất",
["Highest rarity"]="Độ hiếm cao nhất",["Use pets"]="Sử dụng pet",["Lowest value first"]="Giá trị thấp nhất trước",["Highest value first"]="Giá trị cao nhất trước",["Skip mutated"]="Bỏ qua pet đột biến",["Eject odd pets"]="Đẩy pet lẻ ra ngoài",["FUSE FILTER"]="BỘ LỌC DUNG HỢP",["Only these pets"]="Chỉ những pet này",["Never fuse"]="Không bao giờ dung hợp",["FUSE PREDICTOR"]="DỰ ĐOÁN DUNG HỢP",["SLOTS"]="Ô CHỨA",["STATUS"]="TRẠNG THÁI",["LIKELY SIZE"]="KÍCH CỠ DỰ KIẾN",
["CHANCE"]="TỶ LỆ",["VALUE"]="GIÁ TRỊ",["BEST CASE"]="TỐT NHẤT CÓ THỂ",["TASK ORDER"]="THỨ TỰ TÁC VỤ",["Task order"]="Thứ tự tác vụ",["Reset order"]="Đặt lại thứ tự",["DOING"]="ĐANG LÀM",["WAITING"]="ĐANG CHỜ",["Steal filter eggs"]="Cướp trứng theo bộ lọc",["Shooting Star"]="Bắt Sao Băng",["Racing Event"]="Sự Kiện Đua Xe",["Butterfly"]="Bắt Bướm",
["Steal wisp eggs"]="Cướp trứng Wisp",["Wisp"]="Nhặt Wisp",["Steal missing index"]="Cướp trứng thiếu trong Chỉ mục",["Steal lab eggs"]="Cướp trứng phòng Lab",["Place"]="Đặt trứng vào chuồng",["Butterfly machine"]="Máy đổi Bướm",["Race"]="Đua Xe",["RACE"]="ĐUA XE",["Star"]="Sao Băng",["STAR"]="SAO BĂNG",["BUTTERFLY"]="BẮT BƯỚM",["Lab"]="Phòng Lab",["LAB"]="PHÒNG LAB",["AA"]="Admin (AA)",["Halloween"]="Halloween",["HALLOWEEN"]="HALLOWEEN",
["HALLOWEEN DIMENSION"]="KHÔNG GIAN HALLOWEEN",["Auto steal Halloween eggs"]="Tự động cướp trứng Halloween",["Instant steal Halloween eggs"]="Cướp tức thì trứng Halloween",["Steal speed"]="Tốc độ cướp",["Halloween eggs"]="Trứng Halloween",["Halloween rarities"]="Độ hiếm Halloween",["Auto Pumpkin Moon"]="Tự làm sự kiện Trăng Bí Ngô",
["Auto buy Halloween Dimension Egg"]="Tự mua trứng Không gian Halloween",["Walk speed"]="Tốc độ chạy bộ",["GHOST DOG AND FISHING"]="CHÓ MA VÀ CÂU CÁ",["QUEST"]="NHIỆM VỤ",["Done"]="Đã xong",["FISH CAUGHT"]="CÁ ĐÃ CÂU",["Auto Ghost Dog quest"]="Tự làm nhiệm vụ Chó Ma",["Auto fishing"]="Tự động câu cá",["Cast luck"]="Tỷ lệ câu may mắn",["Perfect"]="Hoàn hảo (Perfect)",["MONSTERS"]="QUÁI VẬT",["Monsters"]="Tên quái vật",["Monster order"]="Thứ tự đánh quái",
["Rarest first"]="Hiếm nhất trước",["PHANTOM EXPRESS"]="TÀU MA PHANTOM EXPRESS",["TRAIN"]="CHUYẾN TÀU",["Not here"]="Chưa đến",["SOULS"]="LINH HỒN",["Auto Phantom Express"]="Tự động cướp Tàu Ma",["Auto vacuum Ghouler boss"]="Tự hút linh hồn Boss Ghouler",["Ghost target"]="Mục tiêu ma",["Auto trade souls"]="Tự động đổi linh hồn",["RACING EVENT"]="SỰ KIỆN ĐUA XE",["NEXT RACE"]="ĐUA TIẾP THEO",["WINS"]="THẮNG",["TROPHIES"]="CÚP",
["Auto race"]="Tự động đua xe",["Race speed"]="Tốc độ đua",["Use power-ups"]="Tự dùng vật phẩm tăng tốc",["REWARDS"]="PHẦN THƯỞNG",["Auto claim rewards"]="Tự nhận phần thưởng",["Auto equip racer"]="Tự trang bị xe đua",["Racer"]="Xe đua",["Best owned"]="Tốt nhất đang có",["Auto buy shop"]="Tự mua vật phẩm Shop",["Shop items"]="Vật phẩm Shop",["SHOOTING STAR"]="SAO BĂNG RƠI",["LANDS IN"]="RƠI SAU",["CATCH"]="BẮT SAO BĂNG",
["CAUGHT"]="ĐÃ BẮT",["EXPIRES IN"]="BIẾN MẤT SAU",["SLIPPED"]="TUỘT MẤT",["TRIES"]="SỐ LẦN THỬ",["DISTANCE"]="KHOẢNG CÁCH",["Auto catch shooting star"]="Tự động bắt sao băng",["BUTTERFLY BLOOM"]="MÙA BƯỚM NỞ",["Auto butterfly bloom"]="Tự động bắt bướm",["EMERALD"]="LỤC BẢO",["SAPPHIRE"]="LAM NGỌC",["AMETHYST"]="THẠCH ANH TÍM",["RADIANT"]="RỰC RỠ",["ESSENCE"]="TINH CHẤT",["Catch mode"]="Chế độ bắt",["Stand"]="Đứng yên",
["Chase"]="Đuổi theo",["BUTTERFLY MACHINE"]="MÁY ĐỔI BƯỚM",["Auto trade up"]="Tự nâng cấp bậc bướm",["Trade"]="Giao dịch đổi",["Smart trade for essence"]="Đổi bướm lấy tinh chất thông minh",["Auto craft essence"]="Tự chế tạo tinh chất",["WISP COMPANION"]="ĐỒNG HÀNH WISP",["Catch priority"]="Ưu tiên bắt",["Rarest"]="Hiếm nhất",["Catch"]="Loại bướm bắt",["Catch speed"]="Tốc độ bắt",["Auto wisp quest"]="Tự làm nhiệm vụ Wisp",
["Auto banjo cricket"]="Tự bắt dế Banjo",["STAGE"]="GIAI ĐOẠN",["LAB ODDS"]="TỶ LỆ PHÒNG LAB",["BANNER"]="BĂNG RÔN",["ENDS IN"]="KẾT THÚC SAU",["BANNER CHANCE"]="TỶ LỆ BĂNG RÔN",["NEXT"]="TIẾP THEO",["Experimental Pets"]="Pet Thí Nghiệm",["Biohazard Pets"]="Pet Sinh Học",["Lab banners"]="Băng rôn phòng Lab",["Auto trade in"]="Tự động đổi trứng Lab",["Auto reroll recipe"]="Tự đổi lại công thức",
["Place lab reward eggs"]="Đặt trứng thưởng từ Lab",["ADMIN ABUSE"]="LẠM DỤNG ADMIN (ABUSE)",["No admin boost right now"]="Hiện không có buff Admin nào",["Instant steal (Admin Treadmill)"]="Cướp tức thì (Máy tập Admin)",["Use admin treadmill"]="Tự dùng máy tập Admin",["CAPTURE THE EGG"]="CƯỚP TRỨNG SỰ KIỆN",["Auto capture event egg"]="Tự bắt trứng sự kiện",["Take it from the holder"]="Giật trứng từ người đang cầm",["Hold height"]="Độ cao giữ trứng",
["Keep away"]="Khoảng cách né tránh",["MINIGAME EGGS"]="TRỨNG MINIGAME",["Auto steal minigame egg"]="Tự cướp trứng Minigame",["ESP"]="Định Vị (ESP)",["Move"]="Di Chuyển",["MOVE"]="DI CHUYỂN",["Combat"]="Chiến Đấu",["COMBAT"]="CHIẾN ĐẤU",["FIELD EGGS"]="TRỨNG NGOÀI SÂN",["Egg ESP"]="ESP Trứng",["Show"]="Hiển thị",["Name"]="Tên",["Fixed size"]="Cố định kích cỡ",["OTHERS"]="MỤC KHÁC",["Pen egg ESP"]="ESP trứng trong chuồng",
["Other pens ESP"]="ESP chuồng người khác",["Guard ESP"]="ESP Vệ sĩ",["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ",["Player ESP"]="ESP Người chơi",["ESP size"]="Kích cỡ ESP",["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN",["Speed boost"]="Tăng tốc chạy",["Boost speed"]="Tốc độ tăng thêm",["Infinite jump"]="Nhảy vô hạn",["God mode"]="Bất tử (God mode)",["PROTECTION"]="BẢO VỆ NHÂN VẬT",["Anti ragdoll"]="Chống ngã (Anti Ragdoll)",["Ignore traps"]="Bỏ qua bẫy",
["Instant prompts"]="Tương tác nhấn giữ tức thì",["Anti AFK"]="Chống treo máy (Anti AFK)",["Invisible"]="Tàng hình",["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",["Auto hit"]="Tự động đánh",["Hit who"]="Mục tiêu đánh",["Nearest player"]="Người chơi gần nhất",["Chosen player"]="Người chơi chỉ định",["Egg carrier"]="Người đang ôm trứng",["Chase speed"]="Tốc độ đuổi theo",["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG",["Hit aura"]="Vòng đánh tự động (Hit Aura)",["Skip friends"]="Bỏ qua bạn bè",
["WEAPONS"]="VŨ KHÍ",["Use weapons"]="Sử dụng vũ khí",["Hold each"]="Thời gian cầm mỗi món",["Server"]="Máy Chủ",["SERVER"]="MÁY CHỦ",["Webhook"]="Webhook",["WEBHOOK"]="WEBHOOK",["Optimizer"]="Tối Ưu Hóa",["OPTIMIZER"]="TỐI ƯU HÓA",["Interface"]="Giao Diện",["INTERFACE"]="GIAO DIỆN",["GAME HUD"]="TRÊN MÀN HÌNH GAME",["Steal panel button on game HUD"]="Hiện nút Bảng Cướp trên màn hình",
["Config"]="Cấu Hình",["CONFIG"]="CẤU HÌNH",["CONFIGS"]="QUẢN LÝ CẤU HÌNH",["Configs"]="Danh sách cấu hình",["ACTIVE"]="ĐANG DÙNG",["SAVED CONFIGS"]="ĐÃ LƯU",["Set as active config"]="Đặt làm cấu hình chính",["Set active"]="Kích hoạt",["Save changes"]="Lưu thay đổi",["Save"]="Lưu",["Overwrite"]="Lưu đè",["PROFILES"]="HỒ SƠ CẤU HÌNH",["New config name"]="Tên cấu hình mới",["Config name"]="Tên cấu hình",["Auto if empty"]="Tự đặt nếu trống",
["Create config"]="Tạo cấu hình mới",["Create"]="Tạo mới",["Pick to delete"]="Chọn mục cần xóa",["Delete picked"]="Xóa mục đã chọn",["Delete"]="Xóa",["Restore deleted"]="Khôi phục mục đã xóa",["Export config"]="Xuất mã cấu hình",["Export to clipboard"]="Chép mã cấu hình",["Import text"]="Dán mã cấu hình",["Paste config text"]="Dán mã JSON vào đây",["Paste config JSON here"]="Dán mã JSON vào đây",["Import config"]="Nhập cấu hình",["Import"]="Nhập",
["Config imported"]="Đã nhập cấu hình",["Config loaded"]="Đã nạp cấu hình",["Later"]="Để sau",["Apply now"]="Áp dụng ngay",["Hop to"]="Chuyển tới server",["Least players"]="Ít người chơi nhất",["Most players"]="Đông người chơi nhất",["Random"]="Ngẫu nhiên",["Hop server"]="Đổi máy chủ",["Hop"]="Đổi ngay",["Rejoin this server"]="Vào lại máy chủ này",["Copy"]="Sao chép",["JOIN AND STAY"]="VÀO PHÒNG & DUY TRÌ",["Job ID"]="Mã phòng (Job ID)",
["Paste a Job ID"]="Dán mã Job ID vào đây",["Join that server"]="Vào máy chủ đó",["Join"]="Vào ngay",["Rejoin on kick"]="Tự vào lại khi bị văng/kick",["Auto load script"]="Tự chạy lại script khi chuyển server",["DISCORD WEBHOOK"]="WEBHOOK DISCORD",["Webhook URL"]="Đường dẫn Webhook",["Ping role ID"]="ID Vai trò (Role ID)",["Ping user ID"]="ID Người dùng (User ID)",
["Ping everyone"]="Tag @everyone",["WHAT TO POST"]="NỘI DUNG GỬI BÁO CÁO",["Post stolen eggs"]="Báo cáo trứng cướp được",["Post fused eggs"]="Báo cáo trứng dung hợp",["POSTED"]="ĐÃ GỬI",["Send a test post"]="Gửi tin nhắn thử nghiệm",["Test"]="Thử nghiệm",["Post when bag is full"]="Gửi thông báo khi đầy túi",["GRAPHICS"]="ĐỒ HỌA",["Low graphics"]="Đồ họa thấp (Tăng FPS)",
["Disable 3D Render"]="Tắt kết xuất 3D (Treo máy)",["Background color"]="Màu nền màn hình",["Black"]="Màu Đen",["White"]="Màu Trắng",["Hide game UI"]="Ẩn giao diện gốc của Game",["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)",["FPS cap"]="Giới hạn FPS",["FPS position"]="Vị trí thanh FPS",["Show FPS and ping"]="Hiện chỉ số FPS và Ping",["BASES"]="CĂN CỨ (BASES)",["Hide other players' pets and eggs"]="Ẩn pet và trứng của người chơi khác",
["Hide my pets and eggs"]="Ẩn pet và trứng của bản thân",["Theme"]="Chủ đề màu",["Toggle key"]="Phím đóng/mở Menu",["Quick bar"]="Thanh phím tắt nhanh",["QUICK BAR"]="THANH PHÍM TẮT NHANH",["Auto save"]="Tự động lưu cấu hình",["Auto load"]="Tự động nạp cấu hình",["Auto load on join"]="Tự động nạp khi vào game",["Load config"]="Nạp cấu hình",["Load"]="Nạp cấu hình",
["Reset config"]="Đặt lại mặc định",["Delete config"]="Xóa cấu hình",["Common"]="Phổ Thông",["Uncommon"]="Thường",["Rare"]="Hiếm",["Epic"]="Sử Thi",["Legendary"]="Huyền Thoại",["Mythic"]="Thần Thoại",["Cosmic"]="Vũ Trụ",["Secret"]="Bí Ẩn",["Divine"]="Thánh Thần",["Eternal"]="Vĩnh Cửu",["COMMON"]="PHỔ THÔNG",["UNCOMMON"]="THƯỜNG",["RARE"]="HIẾM",["EPIC"]="SỬ THI",["LEGENDARY"]="HUYỀN THOẠI",["MYTHIC"]="THẦN THOẠI",
["COSMIC"]="VŨ TRỤ",["SECRET"]="BÍ ẨN",["DIVINE"]="THÁNH THẦN",["ETERNAL"]="VĨNH CỬU",
["Radiant"]="Rực Rỡ",["Amethyst"]="Thạch Anh Tím",["Sapphire"]="Lam Ngọc",["Emerald"]="Ngọc Lục Bảo"
}
local LOWER_VI={}
for k,v in pairs(EXACT_VI)do
local lk=k:lower()
if not LOWER_VI[lk] or k:upper()~=k then
LOWER_VI[lk]=v
end
end
local GRAMMAR_VI={
{pat="^[Gg]oing%s+into%s+(.+)$",rep="Đang vào %1"},{pat="^[Ll]eaving%s+(.+)$",rep="Đang rời %1"},{pat="^[Ee]ntering%s+(.+)$",rep="Đang vào %1"},{pat="^[Vv]acuuming%s+ghosts%s*(.*)$",rep="Đang hút bóng ma %1"},{pat="^[Rr]iding%s+(.+)$",rep="Đang đi %1"},{pat="^[Ff]ighting%s+[Ss]mall%s+monster$",rep="Đang đánh quái vật nhỏ"},{pat="^[Ff]ighting%s+[Mm]edium%s+monster$",rep="Đang đánh quái vật vừa"},{pat="^[Ff]ighting%s+[Ll]arge%s+monster$",rep="Đang đánh quái vật lớn"},
{pat="^[Aa]uto play (.+)$",rep="Tự động chơi %1"},{pat="^[Aa]uto farm (.+)$",rep="Tự động cày %1"},{pat="^[Aa]uto kill (.+)$",rep="Tự động tiêu diệt %1"},{pat="^[Aa]uto catch (.+)$",rep="Tự động bắt %1"},{pat="^[Aa]uto collect (.+)$",rep="Tự động thu thập %1"},{pat="^[Aa]uto buy (.+)$",rep="Tự động mua %1"},{pat="^[Aa]uto sell (.+)$",rep="Tự động bán %1"},{pat="^[Aa]uto claim (.+)$",rep="Tự động nhận %1"},
{pat="^[Aa]uto upgrade (.+)$",rep="Tự động nâng cấp %1"},{pat="^[Aa]uto craft (.+)$",rep="Tự động chế tạo %1"},{pat="^[Aa]uto trade (.+)$",rep="Tự động trao đổi %1"},{pat="^[Aa]uto equip (.+)$",rep="Tự động trang bị %1"},{pat="^[Aa]uto steal (.+)$",rep="Tự động cướp %1"},{pat="^[Ii]nstant steal (.+)$",rep="Cướp tức thì %1"},{pat="^[Aa]uto (.+) quest$",rep="Tự làm nhiệm vụ %1"},{pat="^[Aa]uto (.+)$",rep="Tự động %1"},
{pat="^[Cc]alculate (.+)$",rep="Tính thử %1"},{pat="^[Cc]hange if (.+) fails$",rep="Chỉnh lại nếu %1 bị lỗi"},{pat="^(.+) speed$",rep="Tốc độ %1"},{pat="^(.+) target$",rep="Mục tiêu %1"},{pat="^(.+) order$",rep="Thứ tự %1"},{pat="^(.+) priority$",rep="Ưu tiên %1"},{pat="^(.+) mode$",rep="Chế độ %1"},{pat="^(.+) filter$",rep="Bộ lọc %1"},{pat="^[Hh]alloween: carrying (.+) to safety$",rep="Halloween: đang mang %1 đến nơi an toàn"},
{pat="^[Hh]alloween: (.+)$",rep="Halloween: %1"},{pat="^[Nn]o eggs? match%w* your (.+)$",rep="Không có trứng nào khớp %1"},{pat="^[Nn]o eggs? match%w* (.+)$",rep="Không có trứng nào khớp %1"},{pat="^[Nn]o pets? match%w* (.+)$",rep="Không có pet nào khớp %1"},{pat="^[Nn]o (.+) found(.*)$",rep="Không tìm thấy %1%2"},{pat="^[Cc]arrying (.+) to safe zone(.*)$",rep="Đang mang %1 về vùng an toàn%2"},{pat="^[Cc]arrying (.+) to base(.*)$",rep="Đang mang %1 về căn cứ%2"},
{pat="^[Cc]arrying (.+) to pen(.*)$",rep="Đang mang %1 về chuồng%2"},{pat="^[Cc]arrying (.+) to (.+)$",rep="Đang mang %1 tới %2"},{pat="^[Cc]arrying (.+) home(.*)$",rep="Đang mang %1 về nhà%2"},{pat="^[Cc]arrying (.+)$",rep="Đang mang %1"},{pat="^[Dd]elivering (.+) to (.+)$",rep="Đang giao %1 tới %2"},{pat="^[Dd]elivering (.+) home(.*)$",rep="Đang giao %1 về nhà%2"},{pat="^[Dd]elivering (.+)$",rep="Đang giao %1"},{pat="^[Bb]ringing (.+) to (.+)$",rep="Đang đem %1 tới %2"},
{pat="^[Tt]aking (.+) from (.+)$",rep="Đang giật %1 từ %2"},{pat="^[Ss]tealing (.+) from (.+)$",rep="Đang cướp %1 từ %2"},{pat="^[Ss]tealing (.+)$",rep="Đang cướp %1"},{pat="^[Gg]rabbing (.+)$",rep="Đang nhặt %1"},{pat="^[Pp]icking up (.+)$",rep="Đang nhặt %1"},{pat="^[Cc]ollecting (.+)$",rep="Đang thu thập %1"},{pat="^[Dd]ropping (.+) at (.+)$",rep="Đang thả %1 tại %2"},
{pat="^[Tt]weening to (.+)$",rep="Đang bay tới %1"},{pat="^[Tt]eleporting to (.+)$",rep="Đang dịch chuyển tới %1"},{pat="^[Gg]oing to (.+)$",rep="Đang đi tới %1"},{pat="^[Mm]oving to (.+)$",rep="Đang di chuyển tới %1"},{pat="^[Ww]alking to (.+)$",rep="Đang chạy tới %1"},{pat="^[Rr]unning to (.+)$",rep="Đang chạy tới %1"},{pat="^[Ff]lying to (.+)$",rep="Đang bay tới %1"},{pat="^[Rr]eturning to (.+)$",rep="Đang quay về %1"},
{pat="^[Pp]lacing (.+)$",rep="Đang đặt %1"},{pat="^[Hh]atching (.+)$",rep="Đang ấp %1"},{pat="^[Mm]utating (.+)$",rep="Đang đột biến %1"},{pat="^[Ss]elling (.+)$",rep="Đang bán %1"},{pat="^[Ff]using (.+)$",rep="Đang dung hợp %1"},{pat="^[Uu]pgrading (.+)$",rep="Đang nâng cấp %1"},{pat="^[Bb]uying (.+)$",rep="Đang mua %1"},{pat="^[Cc]laiming (.+)$",rep="Đang nhận %1"},{pat="^[Ee]quipping (.+)$",rep="Đang trang bị %1"},{pat="^[Cc]atching (.+)$",rep="Đang bắt %1"},
{pat="^[Cc]hasing (.+)$",rep="Đang đuổi theo %1"},{pat="^[Aa]ttacking (.+)$",rep="Đang tấn công %1"},{pat="^[Hh]itting (.+)$",rep="Đang đánh %1"},{pat="^[Kk]illing (.+)$",rep="Đang tiêu diệt %1"},{pat="^[Tt]rading in (.+)$",rep="Đang đổi %1"},{pat="^[Cc]rafting (.+)$",rep="Đang chế tạo %1"},{pat="^[Aa]voiding (.+)$",rep="Đang né %1"},{pat="^[Ww]aiting for (.+)$",rep="Đang chờ %1"},
{pat="^[Ww]aiting in (.+)$",rep="Đang đợi ở %1"},{pat="^[Ww]aiting %((.+)%)$",rep="Đang chờ (%1)"},{pat="^[Ss]earching for (.+)$",rep="Đang tìm %1"},{pat="^[Ff]arming (.+)$",rep="Đang cày %1"},{pat="^[Uu]sing (.+)$",rep="Đang dùng %1"},{pat="^[Jj]oining (.+)$",rep="Đang tham gia %1"},
{pat="^[Hh]opping (.+)$",rep="Đang đổi %1"}
}
local PHRASES_VI={
{"steal missing halloween index","Cướp trứng Halloween thiếu trong Chỉ mục"},{"missing halloween index","Halloween thiếu trong Chỉ mục"},{"hatch missing in egg index","ấp trứng thiếu trong Chỉ mục"},{"in egg index","trong Chỉ mục trứng"},{"egg index","Chỉ mục trứng"},{"auto claim mastery","Tự động nhận thưởng Thông Thạo"},{"claim mastery","nhận thưởng Thông Thạo"},{"stub pickup speed","Tốc độ nhặt Cuống Bí Ngô"},{"pickup speed","Tốc độ nhặt vật phẩm"},
{"cuống pickup","nhặt Cuống Bí Ngô"},{"cursed island wars","Đại Chiến Đảo Nguyền Rủa"},{"island wars","Đảo Nguyền Rủa"},{"phantom express","Tàu Ma Phantom Express"},{"pumpkin moon","Trăng Bí Ngô"},{"halloween dimension","Không gian Halloween"},{"ghost dog","Chó Ma"},{"enemies and base","Kẻ địch và Căn cứ"},{"walls and crystal","Tường chắn và Pha lê"},{"candy corn","Kẹo Ngô"},
{"admin treadmill","máy tập Admin"},{"instant steal","cướp tức thì"},{"capture the egg","Cướp trứng sự kiện"},{"no egg matches your targets","Không có trứng nào khớp mục tiêu"},{"no eggs match filter","Không có trứng khớp bộ lọc"},{"waiting for field to open","Đang chờ sân trứng mở"},{"waiting for eggs to spawn","Đang chờ trứng xuất hiện"},{"waiting in safe zone","Đợi ở vùng an toàn"},{"returning to safe zone","Đang về vùng an toàn"},
{"to the altar","tới bệ thờ"},{"to altar","tới bệ thờ"},{"the altar","bệ thờ"},{"a pumpkin","bí ngô"},{"egg bag is full","Túi trứng đã đầy"},{"pet bag is full","Túi pet đã đầy"},{"bag is full","Túi đã đầy"},{"pen is full","Chuồng đã đầy"},{"field is closed","Sân trứng đang đóng"},{"safe zone","vùng an toàn"},{"other players","người chơi khác"},{"missing index","thiếu trong Chỉ mục"},{"shooting star","sao băng"},
{"butterfly bloom","mùa bướm nở"},{"racing event","sự kiện đua xe"},{"offline cash","tiền ngoại tuyến"},{"index rewards","thưởng Chỉ mục"},{"lab eggs","trứng Lab"},{"event egg","trứng sự kiện"},{"minigame eggs","trứng Minigame"},{"minigame egg","trứng Minigame"},{"wisp eggs","trứng Wisp"},{"to safe zone","về vùng an toàn"},{"to safety","đến nơi an toàn"},{"to base","về căn cứ"},{"to pen","vào chuồng"},{"was added to your configs","đã được thêm vào danh sách cấu hình"},
{"fixed some bugs","đã sửa một số lỗi vặt"},{"some bugs","một số lỗi vặt"},{"movement speed up to","tốc độ di chuyển lên tới"},{"di chuyển tốc độ up tới","tốc độ di chuyển lên tới"},{"improved fast bay (tween)","cải thiện Bay Nhanh (Fast Tween)"},{"improved fast tween","cải thiện Bay Nhanh (Fast Tween)"},{"fast tween","Bay Nhanh (Fast Tween)"},{"auto pumpkin boss","tự đánh Boss Bí Ngô"},{"tự động bí ngô boss","tự đánh Boss Bí Ngô"},
{"dodges attacks","né đòn tấn công"},{"fires cannons","bắn đại bác"},{"collects pumpkin stubs","nhặt Cuống Bí Ngô"},{"collects bí ngô stubs","nhặt Cuống Bí Ngô"},{"pumpkin stubs","Cuống Bí Ngô"},{"auto manor key","tự lấy chìa khóa dinh thự"},{"tự động manor key","tự lấy chìa khóa dinh thự"},{"manor key","chìa khóa dinh thự"},{"go to egg leap","Nhảy Tới Trứng"},{"di chuyển tới trứng leap","Nhảy Tới Trứng"},
{"replaces old go to egg","thay thế Đi Tới Trứng cũ"},{"replaces old di chuyển tới trứng","thay thế Đi Tới Trứng cũ"},{"replaces old","thay thế bản cũ"},{"anti guard fires again","Chống vệ sĩ hoạt động trở lại"},{"anti vệ sĩ fires again","Chống vệ sĩ hoạt động trở lại"},{"fires again","hoạt động trở lại"},{"finishes about twice as fast","hoàn tất nhanh gấp đôi"},{"twice as fast","nhanh gấp đôi"},
{"you can also hold any feature to pin it","bạn có thể nhấn giữ tính năng bất kỳ để ghim"},{"set a key","gán phím tắt"},{"set key","gán phím tắt"},
{"inventory values","Giá trị túi đồ"},{"find option","Tìm tùy chọn"},{"just now","vừa xong"}
}
local VI_TO_EN={
["trang chủ"]="Home",["săn trứng"]="Steal",["tự cày"]="Farm",["sự kiện"]="Events",["nhân vật"]="Player",["cài đặt"]="Settings",["tự động cướp"]="Auto steal",["tự động"]="Auto",["dịch chuyển tới trứng"]="Go to egg",["di chuyển tới trứng"]="Go to egg",["cách mang về"]="Delivery method",["khu vực dịch chuyển"]="Teleport zones",["cướp trứng thiếu trong chỉ mục"]="Steal missing index eggs",["cướp từ người chơi khác"]="Steal from other players",["chống vệ sĩ"]="Anti guard",
["thả trứng ở vùng an toàn"]="Drop eggs at safe zone",["chỉ những trứng này"]="Only these eggs",["giá tối thiểu /s"]="Min value /s",["giá tối thiểu"]="Min value",["bán trứng rẻ nhất khi đầy túi"]="Sell cheapest egg when bag is full",["chỉ dưới mức /s"]="Only below /s",["không có"]="None",["không"]="None",["giá trị cao nhất"]="Best value",["thánh thần"]="Divine",["vĩnh cửu"]="Eternal",["bí ẩn"]="Secret",["vũ trụ"]="Cosmic",["thần thoại"]="Mythic",
["huyền thoại"]="Legendary",["sử thi"]="Epic",["hiếm"]="Rare",["thường"]="Common",["tắt"]="Off",["bật"]="On",["tất cả"]="All",["tìm trứng"]="Finder",["đang rảnh"]="Idle",["vào ngay"]="Join",["tự vào sau"]="Force join",["độ hiếm"]="Rarity",["tài khoản"]="Account",["miễn phí"]="Free",["ẩn"]="Hide",["hiện"]="Show",["tự động: tắt"]="AUTO OFF",["tự động: bật"]="AUTO ON",
["đang tìm..."]="Searching...",["đang quét..."]="Scanning...",["đã thấy!"]="Found!"
}
for k,v in pairs(EXACT_VI)do
if type(v)=="string" and type(k)=="string" then
local lk=v:lower()
if not VI_TO_EN[lk] then VI_TO_EN[lk]=k end
end
end
local WORDS_VI={
hatch="ấp",hatches="ấp",hatched="đã ấp",
mastery="Thông Thạo",pickup="nhặt",missing="còn thiếu",
index="Chỉ mục",indexed="đã mở Chỉ mục",
kills="số lần hạ",kill="hạ",alive="còn sống",dead="đã hạ",
spawned="đã xuất hiện",hollow="Vực Hollow",abyss="Vực Thẳm",
wisp="Wisp",banjo="Banjo",cricket="dế",
leaving="Đang rời",entering="Đang vào",vacuuming="Đang hút",riding="Đang đi",choose="chọn",multiple="nhiều",shorter="ngắn hơn",delay="độ trễ",between="giữa",tasks="tác vụ",grabs="cướp",
idle="Đang rảnh",carrying="Đang mang",delivering="Đang giao",stealing="Đang cướp",grabbing="Đang nhặt",
picking="Đang nhặt",collecting="Đang thu thập",holding="Đang giữ",capturing="Đang bắt giữ",dropping="Đang thả",
tweening="Đang bay",teleporting="Đang dịch chuyển",going="Đang đi",moving="Đang di chuyển",walking="Đang đi bộ",
running="Đang chạy",flying="Đang bay",returning="Đang quay về",placing="Đang đặt",hatching="Đang ấp",
mutating="Đang đột biến",selling="Đang bán",fusing="Đang dung hợp",upgrading="Đang nâng cấp",buying="Đang mua",
claiming="Đang nhận",equipping="Đang trang bị",catching="Đang nhặt",chasing="Đang đuổi theo",attacking="Đang tấn công",
hitting="Đang đánh",killing="Đang tiêu diệt",trading="Đang đổi",crafting="Đang chế tạo",avoiding="Đang né",
waiting="Đang chờ",searching="Đang tìm",scanning="Đang quét",farming="Đang cày",using="Đang dùng",
joining="Đang vào",hopping="Đang đổi",rejoining="Đang vào lại",finding="Đang tìm",racing="Đang đua",
ready="Sẵn sàng",nothing="Không có gì",none="Không có",no="Không có",pumpkin="bí ngô",pumpkins="bí ngô",
altar="bệ thờ",monster="quái vật",monsters="quái vật",ghost="ma",ghosts="ma",soul="linh hồn",souls="linh hồn",
train="chuyến tàu",boss="Boss",cursed="nguyền rủa",island="đảo",wars="đại chiến",enemies="kẻ địch",
walls="tường chắn",crystal="pha lê",candy="kẹo",corn="ngô",fishing="câu cá",fish="cá",quest="nhiệm vụ",
dimension="không gian",delivery="mang về",calculate="tính thử",mutation="đột biến",mutations="đột biến",
weapon="vũ khí",weapons="vũ khí",removed="đã gỡ bỏ",added="đã thêm",fixed="đã sửa",egg="trứng",eggs="trứng",
pet="pet",pets="pet",matches="khớp",match="khớp",matching="khớp",your="của bạn",target="mục tiêu",
targets="mục tiêu",filter="bộ lọc",home="về nhà",base="căn cứ",pen="chuồng",pens="chuồng",field="sân trứng",
zone="khu vực",zones="khu vực",bag="túi",full="đầy",empty="trống",closed="đóng",open="mở",guard="vệ sĩ",
guards="vệ sĩ",player="người chơi",players="người chơi",server="máy chủ",treadmill="máy tập",race="đua xe",
star="sao băng",butterfly="bướm",portal="cổng",rewards="thưởng",reward="thưởng",cash="tiền",found="tìm thấy",
speed="tốc độ",instant="tức thì",steal="cướp",auto="tự động",to="tới",from="từ",["in"]="trong",at="tại",
["for"]="cho",with="với",["and"]="và",["or"]="hoặc",
some="một số",bug="lỗi",bugs="lỗi",improved="cải thiện",fast="nhanh",up="lên",
dodges="né",dodge="né",attacks="đòn đánh",attack="tấn công",fires="bắn",fire="bắn",
cannons="đại bác",cannon="đại bác",collects="nhặt",collect="nhặt",stubs="cuống",stub="cuống",
manor="dinh thự",key="chìa khóa",keys="chìa khóa",leap="nhảy vọt",replaces="thay thế",replace="thay thế",
old="cũ",new="mới",anti="chống",again="lại",finishes="hoàn tất",finish="hoàn tất",
about="khoảng",twice="gấp đôi",as="như",tip="Mẹo",also="cũng",can="có thể",
hold="nhấn giữ",any="bất kỳ",feature="tính năng",features="tính năng",pin="ghim",
it="nó",set="gán",option="tùy chọn",options="tùy chọn",find="tìm",
inventory="túi đồ",values="giá trị",value="giá trị",now="ngay",just="vừa"
}
local DYN_VI={
{pat="^(v[%d%.]+):%s*[Ff]ixed some bugs%.?$",rep="%1: Đã sửa một số lỗi vặt"},{pat="^(v[%d%.]+):%s*đã sửa some bugs%.?$",rep="%1: Đã sửa một số lỗi vặt"},{pat="^(v[%d%.]+):%s*[Mm]ovement speed up to (%d+%%),%s*improved [Ff]ast [Tt]ween.*$",rep="%1: Tăng tốc độ di chuyển lên tới %2, cải thiện Bay Nhanh (Fast Tween)"},
{pat="^(v[%d%.]+):%s*[Aa]uto [Pp]umpkin [Bb]oss.*$",rep="%1: Tự đánh Boss Bí Ngô (né đòn, bắn đại bác, nhặt Cuống Bí Ngô), tự lấy chìa khóa dinh thự và Nhảy Tới Trứng"},{pat="^(v[%d%.]+):%s*[Aa]nti guard fires again.*$",rep="%1: Chống vệ sĩ hoạt động trở lại và hoàn tất nhanh gấp đôi"},{pat="^QUICK BAR (%d+)$",rep="THANH NHANH %1"},{pat="^[Ee]%.g%. (.+)$",rep="VD: %1"},{pat="^(.+) Egg$",rep="Trứng %1"},{pat="^(%d+) seconds? ago$",rep="%1 giây trước"},
{pat="^(%d+) hours? ago$",rep="%1 giờ trước"},{pat="^(%d+) days? ago$",rep="%1 ngày trước"},{pat="^(%d+) minutes? ago$",rep="%1 phút trước"},{pat="Venyx(.-)just now",rep="Chilli Hub%1vừa xong"},{pat="Venyx(.-)(%d+) seconds? ago",rep="Chilli Hub%1%2 giây trước"},{pat="^(.+) was added to your configs%. Apply it now%??$",rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?"},{pat="^(.+) was added to your configs$",rep="Đã thêm '%1' vào danh sách cấu hình"},
{pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support",rep="Chào mừng tới Chilli Hub V8 (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ"},{pat="Venyx(.-)(%d+) hours? ago",rep="Chilli Hub%1%2 giờ trước"},{pat="Venyx(.-)(%d+) minutes? ago",rep="Chilli Hub%1%2 phút trước"},{pat="Venyx(.-)(%d+) days? ago",rep="Chilli Hub%1%2 ngày trước"},{pat="^ALL (%d+)$",rep="TẤT CẢ %1"},{pat="^READY (%d+)$",rep="SẴN SÀNG %1"},
{pat="^GROWING (%d+)$",rep="ĐANG LỚN %1"},{pat="^IN BAG (%d+)$",rep="TRONG TÚI %1"},{pat="Pen (%d+/%d+).-(%d+) egg%(s%) ready to place",rep="Chuồng %1 · %2 trứng sẵn sàng đặt"},{pat="(%d+) egg%(s%) can be mutated",rep="%1 trứng có thể đột biến"},{pat="(%d+) pet%(s%) match",rep="%1 pet khớp bộ lọc"},{pat="(%d+) egg%(s%) match",rep="%1 trứng khớp bộ lọc"},{pat="(%d+) lab egg%(s%) match",rep="%1 trứng Lab khớp bộ lọc"},{pat="^(%d+) pets$",rep="%1 thú cưng"},
{pat="(%d+ / %d+) players · (.+)",rep="%1 người chơi · %2"},{pat="Experimental Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="Pet Thí Nghiệm · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},{pat="Biohazard Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="Pet Sinh Học · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},{pat="Unstable DNA · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)",rep="DNA Bất Ổn · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4"},
{pat="^Mythic · 1 in ([%d%.]+)$",rep="Thần Thoại · 1 trên %1"},{pat="^Cosmic · 1 in ([%d%.]+)$",rep="Vũ Trụ · 1 trên %1"},{pat="^Secret · 1 in ([%d%.]+)$",rep="Bí Ẩn · 1 trên %1"},{pat="^Divine · 1 in ([%d%.]+)$",rep="Thánh Thần · 1 trên %1"},{pat="^Eternal · 1 in ([%d%.]+)$",rep="Vĩnh Cửu · 1 trên %1"},{pat="^First hop after (%d+)s$",rep="Đổi lần đầu sau %1 giây"},{pat="^Hold each ([%d%.]+)s$",rep="Cầm mỗi món %1 giây"},{pat="^(%d+) selected$",rep="Đã chọn %1 mục"},
{pat="^(%d+)%s*/%s*(%d+) selected$",rep="Đã chọn %1/%2"}
}


-- ============================================================================
-- BỔ SUNG TỪ ĐIỂN VIỆT HÓA 100% TOÀN BỘ GIAO DIỆN FIGGY HUB / BANANA HUB (8037-8045)
-- ============================================================================
local EXTRA_EXACT_VI = {
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
	["Midnight Fig"] = "Quả Vả Đêm (Midnight Fig)",
	["• Midnight Fig"] = "• Quả Vả Đêm (Midnight Fig)",

	-- Nút HUD ngoài màn hình
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

	-- Dynamic Island & Trạng thái trực tiếp (8037, 8038, 8039, 8044)
	["Delivering UFO eggs"] = "Đang giao trứng UFO",
	["delivering ufo eggs"] = "Đang giao trứng UFO",
	["Collecting UFO rewards"] = "Đang nhận thưởng UFO",
	["collecting ufo rewards"] = "Đang nhận thưởng UFO",
	["Trading Space Rocks"] = "Đang đổi Đá Vũ Trụ",
	["trading space rocks"] = "Đang đổi Đá Vũ Trụ",
	["Collecting Space Rocks"] = "Đang nhặt Đá Vũ Trụ",
	["Delivering Space Rocks"] = "Đang giao Đá Vũ Trụ",
	["Waiting for UFO"] = "Đang chờ UFO",
	["Entering UFO"] = "Đang vào UFO",
	["Leaving UFO"] = "Đang rời UFO",
	["Stealing UFO eggs"] = "Đang cướp trứng UFO",
	["Auto Steal off"] = "Tự động cướp: Tắt",
	["Auto Steal on"] = "Tự động cướp: Bật",
	["Auto steal off"] = "Tự động cướp: Tắt",
	["Auto steal on"] = "Tự động cướp: Bật",

	-- Tab Trang Chủ (8037.jpg)
	["Home"] = "Trang Chủ",
	["Dashboard"] = "Trang Chủ",
	["Eggs"] = "Trứng",
	["Egg"] = "Trứng",
	["Manage"] = "Quản Lý",
	["Management"] = "Quản Lý",
	["Events"] = "Sự Kiện",
	["Event"] = "Sự Kiện",
	["System"] = "Hệ Thống",
	["Player"] = "Người Chơi",
	["Visuals"] = "Hiển Thị",
	["Visual"] = "Hiển Thị",
	["Settings"] = "Cài Đặt",
	["Setting"] = "Cài Đặt",
	["Inventory"] = "Túi đồ",
	["Egg bag"] = "Túi trứng",
	["Pet bag"] = "Túi thú cưng",
	["Pet"] = "Thú cưng",
	["Pets"] = "Thú cưng",
	["THÚ CƯNG"] = "THÚ CƯNG",
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
	["NEW"] = "MỚI",
	["FIX"] = "SỬA LỖI",
	["Figgy SAE - Update v1.06"] = "Banana Hub - Bản cập nhật v1.06",
	["v1.06: Fixed and improved script loading."] = "v1.06: Đã sửa lỗi và tối ưu tốc độ tải script.",
	["v1.05: New Pet Finder above Shop with live logs, Min Value, Min Rarity, Auto Join, Force Join and a settings page with Sort By, age limits, new log alerts and an option to hide the server full popup. Pets and buttons have a springy hover, and the fig logo uses it too and plays its animation when you hover or click it. Fixed UFO eggs not being delivered, and debris is now collected inside the Rare UFO instead of on its roof."] = "v1.05: Thêm Tìm Thú Cưng phía trên Cửa Hàng với nhật ký trực tiếp, Giá Tối Thiểu, Độ Hiếm Tối Thiểu, Tự Vào, Ép Vào và trang cài đặt Sắp Xếp, giới hạn tuổi server, chuông báo mới và tùy chọn ẩn thông báo đầy phòng. Đã sửa lỗi không giao trứng UFO và tự nhặt mảnh vỡ bên trong UFO Hiếm.",

	-- Tab Trứng: Automation & Predictor (8038.jpg, 8039.jpg)
	["Automation"] = "Tự Động Hóa",
	["AUTOMATION"] = "TỰ ĐỘNG HÓA",
	["Predictor"] = "Dự Đoán",
	["PREDICTOR"] = "DỰ ĐOÁN",
	["EGG PREDICTOR"] = "DỰ ĐOÁN TRỨNG",
	["TỰ ĐỘNG CƯỚP TRỨNG"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["AUTO STEAL"] = "TỰ ĐỘNG CƯỚP TRỨNG",
	["STATUS"] = "TRẠNG THÁI",
	["Speed"] = "Tốc Độ",
	["Auto Steal"] = "Tự Động Cướp",
	["Move To Egg"] = "Di Chuyển Tới Trứng",
	["Move to Egg"] = "Di Chuyển Tới Trứng",
	["Delivery Method"] = "Phương Thức Giao Trứng",
	["Fast Tween"] = "Bay Nhanh (Fast Tween)",
	["Teleport Zones"] = "Khu Vực Dịch Chuyển",
	["Titan Temple"] = "Đền Titan",
	["Steal Missing Index Eggs"] = "Cướp Trứng Thiếu Trong Mục Lục",
	["Steal From Other Players"] = "Cướp Từ Người Chơi Khác",
	["Anti Guard"] = "Chống Vệ Sĩ (Anti Guard)",
	["Drop Eggs At Safe Zone"] = "Thả Trứng Tại Vùng An Toàn",
	["FILTER"] = "BỘ LỌC",
	["Zones"] = "Khu Vực",
	["None"] = "Không có",
	["Steal First"] = "Ưu Tiên Cướp",
	["Highest Earnings"] = "Thu Nhập Cao Nhất",
	["Lowest Earnings"] = "Thu Nhập Thấp Nhất",
	["Highest Rarity"] = "Độ Hiếm Cao Nhất",
	["Lowest Rarity"] = "Độ Hiếm Thấp Nhất",
	["Highest Value"] = "Giá Trị Cao Nhất",
	["Lowest Value"] = "Giá Trị Thấp Nhất",
	["Mutations"] = "Đột Biến",
	["No selection"] = "Chưa chọn",
	["No Selection"] = "Chưa chọn",
	["Rarities"] = "Độ Hiếm",
	["Only These Eggs"] = "Chỉ Những Trứng Này",
	["Min $/s"] = "Thu Nhập Tối Thiểu ($/s)",
	["Min KG"] = "Cân Nặng Tối Thiểu (KG)",
	["Sell Cheapest Egg"] = "Bán Trứng Rẻ Nhất",
	["Makes room when the egg bag is full"] = "Tự bán bớt để dọn chỗ khi túi trứng bị đầy",
	["Only Below /s"] = "Chỉ Bán Dưới Mức (/s)",
	["Sell Below $/s"] = "Bán Dưới Mức ($/s)",
	["Any"] = "Bất kỳ",
	["AUTO HOP SERVER"] = "TỰ ĐỘNG ĐỔI MÁY CHỦ",
	["Calculate Mutations"] = "Tính Thử Đột Biến",
	["Mutation calculation is a preview; your eggs are unchanged."] = "Tính toán đột biến chỉ là bản xem trước; trứng của bạn không bị thay đổi.",
	["Search pet, rarity, mutation..."] = "Tìm thú cưng, độ hiếm, đột biến...",
	["Sort: Rarity"] = "Xếp: Độ Hiếm",
	["Sort: Value"] = "Xếp: Giá Trị",
	["Sort: Weight"] = "Xếp: Cân Nặng",
	["Card: On"] = "Thẻ: Bật",
	["Card: Off"] = "Thẻ: Tắt",

	-- Tab Quản Lý: Túi đồ, Place & Hatch, Upgrades, Crafting (8040, 8041, 8042, 8043, 8044, 8045)
	["Place & Hatch"] = "Đặt & Ấp Trứng",
	["PLACE & HATCH"] = "ĐẶT & ẤP TRỨNG",
	["Upgrades"] = "Nâng Cấp",
	["UPGRADES"] = "NÂNG CẤP",
	["Crafting"] = "Chế Tạo",
	["CRAFTING"] = "CHẾ TẠO",
	["EQUIP BEST"] = "TRANG BỊ TỐT NHẤT",
	["EQUIPPED"] = "ĐANG TRANG BỊ",
	["Auto Equip Best Pet"] = "Tự Trang Bị Thú Cưng Mạnh Nhất",
	["Open Pet Bag"] = "Mở Túi Thú Cưng",
	["AUTO FAVORITE"] = "TỰ ĐỘNG YÊU THÍCH (KHÓA)",
	["FAVORITED"] = "ĐÃ KHÓA",
	["UNFAVORITED"] = "CHƯA KHÓA",
	["Categories"] = "Danh Mục",
	["Auto Favorite Pets"] = "Tự Động Khóa Thú Cưng",
	["Auto Favorite Equipped"] = "Tự Động Khóa Thú Đang Trang Bị",
	["Unfavorite All"] = "Bỏ Khóa Tất Cả",
	["Run"] = "Chạy",
	["Favorite Rule"] = "Quy Tắc Khóa",
	["Match All"] = "Khớp Tất Cả",
	["Match Any"] = "Khớp Bất Kỳ",
	["Minimum Rarity"] = "Độ Hiếm Tối Thiểu",
	["Maximum Rarity"] = "Độ Hiếm Tối Đa",
	["Always Favorite Species"] = "Luôn Khóa Loài Này",
	["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Thú Đang Trang Bị",
	["Favorite Matching Now"] = "Khóa Mục Khớp Bộ Lọc Ngay",
	["Favorite"] = "Khóa Ngay",
	["Favorite Equipped Now"] = "Khóa Thú Đang Trang Bị Ngay",
	["Unfavorite Equipped Now"] = "Bỏ Khóa Thú Đang Trang Bị Ngay",
	["Unfavorite Pets Not Matching"] = "Bỏ Khóa Thú Không Khớp Lọc",
	["SELL EGGS"] = "BÁN TRỨNG",
	["SPACE LEFT"] = "CHỖ TRỐNG",
	["Egg Names"] = "Tên Trứng",
	["Egg Rarities"] = "Độ Hiếm Trứng",
	["Auto Sell Eggs"] = "Tự Động Bán Trứng",
	["Sell Rule"] = "Quy Tắc Bán",
	["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến",
	["Never Sell Species"] = "Không Bao Giờ Bán Loài Này",
	["Sell Matching Eggs Now"] = "Bán Trứng Khớp Lọc Ngay",
	["Sell"] = "Bán",
	["SELL PETS"] = "BÁN THÚ CƯNG",
	["Auto Sell Pets"] = "Tự Động Bán Thú Cưng",
	["Keep Mutated Pets"] = "Giữ Lại Thú Đột Biến",
	["Sell Matching Pets Now"] = "Bán Thú Khớp Lọc Ngay",
	["AUTO PLACE"] = "TỰ ĐỘNG ĐẶT TRỨNG",
	["IN BAG"] = "TRONG TÚI",
	["PLACED"] = "ĐÃ ĐẶT",
	["AUTO HATCH"] = "TỰ ĐỘNG ẤP TRỨNG",
	["READY NOW"] = "SẴN SÀNG ẤP",
	["HATCHED"] = "ĐÃ ẤP",
	["Priority"] = "Ưu Tiên",
	["Auto Place Selected"] = "Tự Đặt Trứng Đã Chọn",
	["Place And Hatch Missing Index Eggs"] = "Đặt & Ấp Trứng Thiếu Trong Mục Lục",
	["Auto Place All"] = "Tự Động Đặt Tất Cả",
	["Place When"] = "Đặt Khi",
	["Always"] = "Luôn luôn",
	["Auto Hatch Selected"] = "Tự Ấp Trứng Đã Chọn",
	["Auto Hatch All"] = "Tự Động Ấp Tất Cả",
	["KEEP EGGS"] = "GIỮ LẠI TRỨNG",
	["Kept eggs are never placed, hatched or sold, in your bag or your pen."] = "Trứng được giữ sẽ không bao giờ bị đặt, ấp hay bán dù ở trong túi hay trong chuồng.",
	["Eggs To Keep"] = "Trứng Cần Giữ Lại",
	["Your eggs, best first"] = "Trứng của bạn, ưu tiên tốt nhất trước",
	["Keep Matching Eggs"] = "Giữ Lại Trứng Khớp Bộ Lọc",
	["Also keeps eggs that pass the two filters below"] = "Đồng thời giữ lại các trứng thỏa mãn hai bộ lọc bên dưới",
	["Rarities To Keep"] = "Độ Hiếm Cần Giữ Lại",
	["TASK ORDER"] = "THỨ TỰ ƯU TIÊN TÁC VỤ",
	["Top goes first. A task never stops halfway: the next one waits until it finishes. A carried egg is always delivered first."] = "Mục ở trên chạy trước. Tác vụ không dừng giữa chừng: mục tiếp theo sẽ đợi đến khi hoàn tất. Trứng đang bế luôn được ưu tiên giao trước.",
	["DOING NOW"] = "ĐANG THỰC HIỆN",
	["NEXT 1"] = "TIẾP THEO 1",
	["NEXT 2"] = "TIẾP THEO 2",
	["NEXT 3"] = "TIẾP THEO 3",
	["Steal Eggs"] = "Cướp Trứng",
	["Shooting Stars"] = "Săn Sao Băng",
	["The Hollow"] = "Vực Hollow",
	["Butterflies"] = "Bắt Bướm",
	["Hit Players"] = "Đánh Người Chơi",
	["UFO Sightings"] = "Phát Hiện UFO",
	["Trade Debris"] = "Đổi Mảnh Vỡ UFO",
	["Place Eggs"] = "Đặt Trứng",
	["Mutate Eggs"] = "Đột Biến Trứng",
	["Reset Order"] = "Đặt Lại Thứ Tự",
	["Reset"] = "Đặt lại",
	["UPGRADES & REWARDS"] = "NÂNG CẤP & PHẦN THƯỞNG",
	["BASE LEVEL"] = "CẤP CĂN CỨ",
	["TREADMILL LEVEL"] = "CẤP MÁY TẬP",
	["MONEY"] = "TIỀN HIỆN CÓ",
	["OFFLINE CASH"] = "TIỀN NGOẠI TUYẾN",
	["Auto Base Upgrade"] = "Tự Động Nâng Cấp Căn Cứ",
	["Auto Treadmill Upgrade"] = "Tự Động Nâng Cấp Máy Tập",
	["Auto Claim Offline Cash"] = "Tự Nhận Tiền Ngoại Tuyến",
	["TRAILS"] = "VỆT SÁNG (TRAILS)",
	["Auto Buy Best Trail"] = "Tự Mua Vệt Sáng Tốt Nhất",
	["Auto Buy Trail"] = "Tự Động Mua Vệt Sáng",
	["Trail Wanted"] = "Vệt Sáng Muốn Mua",
	["Grey Trail"] = "Vệt Sáng Xám (Grey Trail)",

	-- Tab Cài Đặt (8006, 8009)
	["General"] = "Cài Đặt Chung",
	["GENERAL"] = "CÀI ĐẶT CHUNG",
	["Profiles"] = "Hồ Sơ",
	["PROFILES"] = "HỒ SƠ CẤU HÌNH",
	["Webhook"] = "Báo Cáo Webhook",
	["WEBHOOK"] = "BÁO CÁO WEBHOOK",
	["Quick Bars"] = "Thanh Nhanh",
	["QUICK BARS"] = "THANH PHÍM TẮT NHANH",
	["JOIN & STAY"] = "VÀO PHÒNG & DUY TRÌ",
	["Auto Execute"] = "Tự Chạy Lại Script",
	["Auto Reconnect"] = "Tự Kết Nối Lại Khi Văng",
	["INTERFACE"] = "GIAO DIỆN",
	["UI Scale"] = "Kích Cỡ Menu",
	["Show / Hide UI"] = "Phím Ẩn / Hiện Menu",
	["Transparent Background"] = "Nền Trong Suốt",
	["Tone"] = "Tông Màu Sáng/Tối",
	["Dim The Game"] = "Làm Tối Cảnh Game",
	["SERVER"] = "MÁY CHỦ (SERVER)",
	["PLAYERS"] = "NGƯỜI CHƠI",
	["PING"] = "ĐỘ TRỄ (PING)",
	["SERVER AGE"] = "TUỔI SERVER",
	["1 Player Server"] = "Vào Server 1 Người",
	["Join"] = "Vào",
	["Job ID"] = "Mã Phòng (Job ID)",
	["Paste a server Job ID..."] = "Dán mã Job ID máy chủ vào đây...",
	["Join Job ID"] = "Vào Theo Job ID",
	["Copy Current Job ID"] = "Sao Chép Job ID Hiện Tại",
	["Copy"] = "Chép",
	["Rejoin Server"] = "Vào Lại Máy Chủ Này",
	["Vào lại game"] = "Vào Lại Game",
	["Hop To"] = "Chuyển Tới Server",
	["Least Players"] = "Ít Người Nhất",
	["Most Players"] = "Đông Người Nhất",
	["Server Hop"] = "Đổi Máy Chủ Khác",
	["Hop"] = "Đổi",
	["Language"] = "Ngôn Ngữ Gốc",
	["Off (English)"] = "Tắt (Tiếng Việt Banana)",
	["FPS & Ping"] = "Hiện FPS & Ping",
	["Reset Interface"] = "Đặt Lại Giao Diện",
	["Reset All Settings"] = "Đặt Lại Toàn Bộ Cài Đặt",
	["STEAL PANEL"] = "BẢNG CƯỚP NHANH",
	["Steal Panel"] = "Hiện Bảng Cướp Nhanh",
	["Open Steal Panel"] = "Mở Bảng Cướp Nhanh",
	["THEME"] = "CHỦ ĐỀ GIAO DIỆN",

	-- ============================================================================
	-- BỔ SUNG TỪ ĐIỂN ĐỢT 3 CHO TAB CÀI ĐẶT (PROFILES, WEBHOOK, QUICK BARS, THEMES - 8058-8065)
	-- ============================================================================
	-- 8058, 8059: Cài Đặt Chung & Danh Sách Theme
	["Steal Notifications"] = "Thông Báo Cướp Trứng",
	["Banana Gold"] = "Chuối Vàng (Banana Gold)",
	["Blackberry"] = "Dâu Đen (Blackberry)",
	["Blueberry"] = "Việt Quất (Blueberry)",
	["Ocean Fig"] = "Đại Dương (Ocean Fig)",
	["Matcha"] = "Trà Xanh (Matcha)",
	["Vàng Hoàng Gia(Gold)"] = "Vàng Hoàng Gia (Gold)",
	["Peach"] = "Quả Đào (Peach)",
	["Dragonfruit"] = "Thanh Long (Dragonfruit)",
	["Mono"] = "Đơn Sắc (Mono)",
	["Obsidian"] = "Hắc Diện Thạch (Obsidian)",
	["Aurora"] = "Cực Quang (Aurora)",

	-- 8060, 8061: Hồ Sơ Cấu Hình (Profiles)
	["Profile Name"] = "Tên Hồ Sơ",
	["My profile"] = "Hồ sơ của tôi",
	["Saved Profiles"] = "Hồ Sơ Đã Lưu",
	["Create Profile"] = "Tạo Hồ Sơ Mới",
	["Save Profile"] = "Lưu Hồ Sơ",
	["Load Profile"] = "Nạp Hồ Sơ",
	["Night"] = "Đêm",
	["Set Startup Profile"] = "Đặt Hồ Sơ Mặc Định Khi Khởi Động",
	["Set"] = "Đặt",
	["Refresh Profiles"] = "Làm Mới Danh Sách",
	["Refresh"] = "Làm Mới",
	["Delete Profile"] = "Xóa Hồ Sơ",
	["Export Config"] = "Xuất Mã Cấu Hình",
	["Import Config Text"] = "Dán Mã Cấu Hình",
	["Paste exported config..."] = "Dán mã cấu hình đã sao chép vào đây...",
	["Import Name"] = "Tên Cấu Hình Mới",
	["Name for the new config"] = "Nhập tên cho cấu hình mới",
	["Import Config"] = "Nhập Cấu Hình",
	["Auto Load"] = "Tự Nạp Khi Vào Game",
	["Auto Save"] = "Tự Động Lưu",
	["Reset to Defaults"] = "Khôi Phục Mặc Định",

	-- 8062, 8063: Webhook Discord & Trạng Thái Báo Cáo
	["Turn Off All Toggles"] = "Tắt Toàn Bộ Công Tắc",
	["Enable Webhook"] = "Bật Webhook Discord",
	["Discord User ID (ping)"] = "ID Người Dùng Discord (Ping)",
	["Mention @everyone"] = "Tag @everyone",
	["Log Disconnect / Reconnect"] = "Ghi Nhật Ký Mất / Kết Nối Lại",
	["Send Test Post"] = "Gửi Thử Tin Nhắn",
	["Send"] = "Gửi",
	["WEBHOOK FILTER"] = "BỘ LỌC WEBHOOK",
	["QUEUED"] = "ĐANG CHỜ GỬI",
	["LAST POST"] = "LẦN GỬI CUỐI",
	["Status:"] = "Trạng thái:",
	["No filter set — every egg posts."] = "Không đặt bộ lọc — mọi trứng đều gửi báo cáo.",
	["Last post failed: nil"] = "Lần gửi cuối: Thành công",
	["Post Stolen Eggs"] = "Gửi Báo Cáo Trứng Cướp",
	["Post Fused Eggs"] = "Gửi Báo Cáo Trứng Dung Hợp",
	["Post When Bag Is Full"] = "Gửi Thông Báo Khi Túi Đầy",

	-- 8064, 8065: Thanh Phím Tắt Nhanh (Quick Bars & Ghim)
	["Floating bars with your pinned controls"] = "Thanh nổi trên màn hình chứa các nút bạn đã ghim",
	["Keybinds"] = "Phím Tắt",
	["Keys you give to switches and buttons"] = "Gán phím tắt nhanh cho các công tắc và nút bấm",
	["Visible bars"] = "Số Thanh Hiển Thị",
	["Quick Bar 1"] = "Thanh Nhanh 1",
	["Quick Bar 2"] = "Thanh Nhanh 2",
	["Quick Bar 3"] = "Thanh Nhanh 3",
	["Bar size"] = "Kích Cỡ Thanh Nhanh",
	["Reset positions"] = "Đặt Lại Vị Trí Thanh",
	["Reset pins and keys"] = "Xóa Hết Ghim & Phím Tắt",
	["PINS AND KEYBINDS"] = "GHIM TÍNH NĂNG & PHÍM TẮT",
	["Tip: you can also hold any feature, or right-click it on PC, to pin it or set a key."] = "Mẹo: Bạn có thể nhấn giữ tính năng bất kỳ (hoặc chuột phải trên PC) để ghim hoặc gán phím tắt.",
	["Find an option"] = "Tìm tùy chọn...",
	["EGGS / AUTO STEAL"] = "TRỨNG / TỰ ĐỘNG CƯỚP",
	["+ PIN"] = "+ GHIM",
	["+ KEY"] = "+ PHÍM",
	["EGGS / FILTER"] = "TRỨNG / BỘ LỌC",
	["slider"] = "Thanh trượt",
	["Pins & keybinds"] = "Ghim & Phím tắt",

	-- ============================================================================
	-- BỔ SUNG TỪ ĐIỂN ĐỢT 2 CHO CÁC TAB NÂNG CAO (8046 - 8057)
	-- ============================================================================
	-- 8046.jpg: Quản Lý -> Nâng Cấp & Chế Tạo
	["Auto Equip Best Trail"] = "Tự Trang Bị Vệt Sáng Tốt Nhất",
	["Cash Reserve"] = "Số Tiền Dự Trữ",
	["Auto Claim Index Rewards"] = "Tự Nhận Thưởng Mục Lục",
	["Auto Claim Group Reward"] = "Tự Nhận Thưởng Nhóm",
	["Auto Claim Offline Earnings"] = "Tự Nhận Tiền Ngoại Tuyến",
	["Auto Watch Ads"] = "Tự Xem Quảng Cáo",
	["Auto Treadmill Training"] = "Tự Luyện Tập Máy Chạy",
	["Auto Treadmill Upgrade"] = "Tự Nâng Cấp Máy Chạy",
	["SPEED POWER"] = "SỨC MẠNH TỐC ĐỘ",
	["GAINED"] = "ĐÃ NHẬN",
	["FUSE"] = "DUNG HỢP",
	["MUTATE A CHOSEN EGG"] = "ĐỘT BIẾN TRỨNG ĐÃ CHỌN",
	["Mutations To Add"] = "Đột Biến Cần Thêm",
	["Pick an egg in your pen to mutate it"] = "Chọn một quả trứng trong chuồng để đột biến",
	["Species to Fuse"] = "Loài Cần Dung Hợp",

	-- 8047.jpg: Quản Lý -> Chế Tạo (Chi tiết)
	["Eject Incomplete Slots"] = "Đẩy Ô Chưa Đủ Ra",
	["Auto Fuse Pets"] = "Tự Động Dung Hợp Thú Cưng",
	["Fuse Rarities"] = "Độ Hiếm Dung Hợp",
	["Fuse Mutations"] = "Đột Biến Dung Hợp",
	["Fuse First"] = "Ưu Tiên Dung Hợp",
	["Never Fuse Mutated"] = "Không Bao Giờ Dung Hợp Thú Đột Biến",
	["Never Fuse Equipped"] = "Không Bao Giờ Dung Hợp Thú Đang Dùng",
	["Auto Complete Reveal"] = "Tự Động Mở Nhanh Kết Quả",
	["MUTATION"] = "ĐỘT BIẾN",
	["Mutation Items"] = "Vật Phẩm Đột Biến",

	-- 8048.jpg: Quản Lý -> Chế Tạo (Dự đoán)
	["Fuse Now"] = "Dung Hợp Ngay",
	["Target Priority"] = "Ưu Tiên Mục Tiêu",
	["Auto Mutate Egg"] = "Tự Động Đột Biến Trứng",
	["Skip Eggs With"] = "Bỏ Qua Trứng Đã Có",
	["FUSE PREDICTOR"] = "DỰ ĐOÁN DUNG HỢP",
	["EMPTY"] = "TRỐNG",
	["Load 3 pets of one species to see the odds"] = "Đặt 3 thú cưng cùng một loài để xem tỷ lệ",
	["EMPTY SLOT 1"] = "Ô TRỐNG 1",
	["EMPTY SLOT 2"] = "Ô TRỐNG 2",
	["EMPTY SLOT 3"] = "Ô TRỐNG 3",

	-- 8049.jpg: Sự Kiện -> UFO & Mùa
	["UFO"] = "Sự Kiện UFO",
	["Seasonal"] = "Sự Kiện Mùa",
	["AA"] = "Quyền Admin (AA)",
	["Auto UFO"] = "Tự Động Chơi UFO",
	["Collect UFO Debris"] = "Tự Nhặt Mảnh Vỡ UFO",
	["Farm Rare UFO"] = "Săn UFO Hiếm",
	["Auto Trade Debris"] = "Tự Động Đổi Mảnh Vỡ",
	["Teleport If Far From Egg"] = "Dịch Chuyển Nếu Xa Trứng",
	["UFO STATUS"] = "TRẠNG THÁI UFO",
	["DEBRIS"] = "MẢNH VỠ",
	["BUTTERFLY EVENT"] = "SỰ KIỆN BẮT BƯỚM",
	["THE HOLLOW"] = "VỰC HOLLOW",
	["ESSENCE"] = "TINH CHẤT",
	["CAUGHT"] = "ĐÃ BẮT",
	["NET"] = "VỢT BẮT",
	["WINS"] = "SỐ TRẬN THẮNG",

	-- 8050.jpg: Sự Kiện -> Mùa (Bướm, Đua xe, Nhiệm vụ Wisp)
	["Auto Claim Butterfly Net"] = "Tự Nhận Vợt Bắt Bướm",
	["Auto Catch Butterflies"] = "Tự Động Bắt Bướm",
	["Catch Mode"] = "Chế Độ Bắt",
	["Catch Priority"] = "Ưu Tiên Bắt",
	["Strict Rarity"] = "Đúng Độ Hiếm",
	["Auto Essence"] = "Tự Động Đổi Tinh Chất",
	["Catch Speed"] = "Tốc Độ Bắt",
	["Catch"] = "Loại Cần Bắt",
	["Auto Race The Hollow"] = "Tự Đua Xe Vực Hollow",
	["Race Speed"] = "Tốc Độ Đua",
	["Use Power-Ups"] = "Dùng Vật Phẩm Tăng Tốc",
	["WISP QUEST"] = "NHIỆM VỤ ĐỒNG HÀNH WISP",
	["STAGE"] = "GIAI ĐOẠN",
	["QUEST"] = "NHIỆM VỤ",
	["Accepted"] = "Đã Nhận",
	["Wisp: Done (Enchanted Tree unlocked)"] = "Nhiệm vụ Wisp: Hoàn Thành (Đã mở Cây Phù Phép)",
	["Done (Enchanted Tree unlocked)"] = "Hoàn Thành (Đã mở Cây Phù Phép)",
	["Enchanted Tree unlocked"] = "Đã mở Cây Phù Phép",
	["Auto Wisp Quests"] = "Tự Làm Nhiệm Vụ Wisp",
	["Auto Fuse For Quest"] = "Tự Dung Hợp Theo Nhiệm Vụ",
	["Automate Eggs For Fuse"] = "Tự Động Chuẩn Bị Trứng",
	["SHOOTING STARS"] = "SỰ KIỆN SAO BĂNG",
	["State: Off"] = "Trạng thái: Tắt",
	["State: On"] = "Trạng thái: Bật",

	-- 8051.jpg: Sự Kiện -> Mùa (Đổi tinh chất bướm)
	["Auto Catch Shooting Stars"] = "Tự Động Bắt Sao Băng",
	["Open Wisp Window"] = "Mở Cửa Sổ Wisp",
	["AUTO TRADE ESSENCE"] = "TỰ ĐỘNG ĐỔI TINH CHẤT",
	["GREEN"] = "LỤC (GREEN)",
	["BLUE"] = "LAM (BLUE)",
	["PURPLE"] = "TÍM (PURPLE)",
	["GOLDEN"] = "VÀNG (GOLDEN)",
	["Auto Trade Up"] = "Tự Nâng Cấp Bậc Bướm",
	["Trade Up Tiers"] = "Bậc Cần Nâng",
	["Smart Trade For Essence"] = "Đổi Tinh Chất Thông Minh",

	-- 8052.jpg: Sự Kiện -> Quyền Admin (AA)
	["ADMIN ABUSE"] = "LẠM DỤNG ADMIN (AA)",
	["No admin boost right now"] = "Hiện không có hiệu ứng tăng cường Admin nào",
	["Instant Steal (AA)"] = "Cướp Tức Thì (Admin)",
	["Use Admin Treadmill"] = "Tự Dùng Máy Chạy Admin",
	["MINIGAME EGGS"] = "TRỨNG TỪ TRÒ CHƠI NHỎ",
	["Waiting for Red Light Green Light or T-Rex Run"] = "Đang chờ Đèn Xanh Đèn Đỏ hoặc Cuộc Đua T-Rex",
	["Auto Steal Minigame Egg"] = "Tự Cướp Trứng Minigame",
	["CAPTURE THE EGG"] = "CƯỚP TRỨNG SỰ KIỆN",
	["Auto Capture Event Egg"] = "Tự Động Bắt Trứng Sự Kiện",
	["Take It From The Holder"] = "Cướp Trực Tiếp Từ Người Cầm",
	["Capture Egg"] = "Bắt Trứng",
	["Keep Away"] = "Khoảng Cách Giữ An Toàn",
	["CURSED ISLAND WARS"] = "ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",
	["Auto Play Cursed Island Wars"] = "Tự Chơi Đại Chiến Đảo Nguyền Rủa",
	["Island Wars Target"] = "Mục Tiêu Đảo Nguyền Rủa",
	["Enemies and base"] = "Kẻ địch và Căn cứ",

	-- 8053.jpg: Người Chơi -> Di Chuyển & Bảo Vệ
	["Người Chơi"] = "Nhân Vật",
	["Move"] = "Di Chuyển",
	["Combat"] = "Chiến Đấu",
	["MOVEMENT"] = "TỐC ĐỘ & DI CHUYỂN",
	["Speed Boost"] = "Tăng Tốc Độ Chạy",
	["Boost Speed"] = "Tốc Độ Tăng Thêm",
	["Nhảy Vô Hạn"] = "Nhảy Vô Hạn",
	["FREECAM"] = "GÓC NHÌN TỰ DO (FREECAM)",
	["Freecam"] = "Bật Góc Nhìn Tự Do",
	["Freecam Speed"] = "Tốc Độ Di Chuyển Cam",
	["PROTECTION"] = "BẢO VỆ NHÂN VẬT",
	["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)",
	["Ignore Traps"] = "Bỏ Qua Mọi Bẫy",
	["Instant Prompts"] = "Nhấn Giữ Tương Tác Tức Thì",
	["Chống AFK"] = "Chống Văng Game (Anti AFK)",
	["Invisible"] = "Tàng Hình",
	["God Mode"] = "Bất Tử (God Mode)",

	-- 8054.jpg: Người Chơi -> Chiến Đấu
	["COMBAT"] = "CHIẾN ĐẤU",
	["HIT AURA"] = "VÒNG ĐÁNH XUNG QUANH",
	["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
	["Skip Friends"] = "Bỏ Qua Bạn Bè",
	["AUTO HIT"] = "TỰ ĐỘNG TẤN CÔNG",
	["Auto Hit"] = "Tự Động Tấn Công",
	["Hit Who"] = "Đối Tượng Tấn Công",
	["Nearest player"] = "Người chơi gần nhất",
	["Chosen Player"] = "Người chơi chỉ định",
	["Chase Speed"] = "Tốc Độ Đuổi Theo",
	["WEAPONS"] = "VŨ KHÍ",
	["Use Weapons"] = "Sử Dụng Vũ Khí",
	["Hold Each"] = "Thời Gian Cầm Mỗi Món (Giây)",

	-- 8057.jpg: Hiển Thị -> Cài Đặt Hiển Thị & Tối Ưu
	["Hiển Thị"] = "Hiển Thị",
	["Định Vị (ESP)"] = "Định Vị (ESP)",
	["Display"] = "Hiển Thị & FPS",
	["Hide Pets"] = "Ẩn Thú Cưng",
	["FPS Boost"] = "Tăng Tốc Khung Hình (FPS Boost)",
	["Disable 3D Render"] = "Tắt Đồ Họa 3D (Treo Máy Siêu Nhẹ)",
	["Background"] = "Màu Nền Khi Tắt 3D",
	["Black"] = "Đen",
	["White"] = "Trắng",
	["FPS Cap"] = "Giới Hạn FPS",
	["Hide Other Players' Pets And Eggs"] = "Ẩn Thú Cưng & Trứng Của Người Khác",
	["Hide My Pets And Eggs"] = "Ẩn Thú Cưng & Trứng Của Bản Thân",
	["Hide Game UI"] = "Ẩn Toàn Bộ Giao Diện Game",
	["Low Graphics"] = "Đồ Họa Cực Thấp (Low Graphics)",
	["Optimizer Mode"] = "Chế Độ Tối Ưu Hóa",
	["Balanced"] = "Cân Bằng",
	["Strong"] = "Tối Đa (Strong)",
}


for k, v in pairs(EXTRA_EXACT_VI) do
	EXACT_VI[k] = v
	LOWER_VI[string.lower(k)] = v
end

for k, v in pairs(EXACT_VI) do
	if type(k) == "string" and type(v) == "string" and not VI_TO_EN[v] then
		VI_TO_EN[v] = k
		VI_TO_EN[string.lower(v)] = k
	end
end

local EXTRA_DYN_VI = {
	{ pat = "^Posted:%s*(%d+)$", rep = "Đã gửi: %1" },
	{ pat = "^Queued:%s*(%d+)$", rep = "Đang chờ: %1" },
	{ pat = "^Pinned%s+(%d+)$", rep = "Đã ghim: %1" },
	{ pat = "^Keys%s+(%d+)$", rep = "Phím tắt: %1" },
	{ pat = "^Đêm%s+([%d:]+)$", rep = "Đêm: %1" },
	{ pat = "^Last post failed:%s*(.+)$", rep = "Gửi thất bại: %1" },

	{ pat = "^UFO live,%s*([%d:]+)%s+left,%s*eggs%s+(%d+/%d+)$", rep = "UFO đang có, còn %1, trứng %2" },
	{ pat = "^Butterfly Bloom in:%s*([%d:]+)$", rep = "Mùa bướm sau: %1" },
	{ pat = "^Emerald%s+(%d+)%s+Sapphire%s+(%d+)%s+Amethyst%s+(%d+)%s+Radiant%s+(%d+)$", rep = "Lục Bảo %1 · Lam Ngọc %2 · Thạch Anh %3 · Rực Rỡ %4" },
	{ pat = "^Essence:%s*(%d+)$", rep = "Tinh chất: %1" },
	{ pat = "^Speed:%s*([%d%.]+[KkMmBbTtQq]?)%s*/%s*([%d%.]+[KkMmBbTtQq]?)$", rep = "Tốc độ: %1 / %2" },
	{ pat = "^Wisp:%s*(.-)%s*%%%s*%((.-)%%%s*%)$", rep = "Wisp: %1 (%2)" },
	{ pat = "^Wisp:%s*(.+)$", rep = "Nhiệm vụ Wisp: %1" },

	{ pat = "^Session%s+([%d:]+)$", rep = "Phiên %1" },
	{ pat = "^(%d+)%s+free$", rep = "Còn trống %1" },
	{ pat = "^([%d%.]+[KkMmBbTtQq]?)%s+st/s%s+now$", rep = "%1 bước/giây" },
	{ pat = "^Matches:%s*(%d+)%s*·%s*To mark:%s*(%d+)%s*·%s*Favorited:%s*(%d+)$", rep = "Khớp: %1 · Cần khóa: %2 · Đã khóa: %3" },
	{ pat = "^Sell matches:%s*(%d+)%s*eggs?$", rep = "Khớp bán: %1 trứng" },
	{ pat = "^Sell matches:%s*(%d+)%s*pets?$", rep = "Khớp bán: %1 thú cưng" },
	{ pat = "^(%d+)%s+selected$", rep = "Đã chọn %1" },
	{ pat = "^ALL%s+(%d+)$", rep = "TẤT CẢ %1" },
	{ pat = "^READY%s+(%d+)$", rep = "SẴN SÀNG %1" },
	{ pat = "^GROWING%s+(%d+)$", rep = "ĐANG LỚN %1" },
	{ pat = "^IN BAG%s+(%d+)$", rep = "TRONG TÚI %1" },
	{ pat = "^(%d+)%s+days?%s+ago$", rep = "%1 ngày trước" },
	{ pat = "^(%d+)%s+hours?%s+ago$", rep = "%1 giờ trước" },
	{ pat = "^(%d+)%s+minutes?%s+ago$", rep = "%1 phút trước" },
	{ pat = "^(%d+)%s+seconds?%s+ago$", rep = "%1 giây trước" },
	{ pat = "^(%d+m%s+%d+s)$", rep = "%1" },
}
for _, item in ipairs(EXTRA_DYN_VI) do
	table.insert(DYN_VI, 1, item)
end

local function stripArt(s)
	return ((" " .. s .. " "):gsub("%s+[Aa]%s+", " "):gsub("%s+[Aa]n%s+", " "):gsub("%s+[Tt]he%s+", " "):match("^%s*(.-)%s*$") or s)
end

local function applyPhrases(s)
	local out = s
	for i = 1, #PHRASES_VI do
		local p = PHRASES_VI[i]
		local guard = 0
		while guard < 4 do
			local a, b = out:lower():find(p[1], 1, true)
			if not a then break end
			out = out:sub(1, a - 1) .. p[2] .. out:sub(b + 1)
			guard = guard + 1
		end
	end
	return out
end

local function applyWords(s)
	return (stripArt(s):gsub("([\128-\255%a']+)", function(w)
		if w:find("[\128-\255]") then return w end
		local l = w:lower()
		return WORDS_VI[l] or LOWER_VI[l] or w
	end))
end

local function isTreadmillOrIdleStatus(txt)
	if not txt or txt == "" then return true end
	local clean = tostring(txt):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or ""
	local low = string.lower(clean)
	if low == "idle" or low == "đang rảnh" or low == "running" then
		return true
	end
	if low == "treadmill" or low == "máy chạy bộ" or low == "may chay bo" or low == "máy tập" then
		return true
	end
	if low:find("treadmill", 1, true) or low:find("máy chạy", 1, true) or low:find("máy tập", 1, true) then
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
	if t:find("^%d+%s*/%s*%d+$") or t:find("^%d+%%$") or t:find("^%d+%s*ms$") then
		return true
	end
	return false
end

local function translateStaticLabelText(rawText, targetLang)
	if not rawText or rawText == "" then return rawText end
	local ck = (targetLang or "VI") .. "|" .. rawText
	if FastCache[ck] then return FastCache[ck] end

	local lead, trimmed, trail = rawText:match("^(%s*)(.-)(%s*)$")
	if not trimmed or trimmed == "" then
		FastCache[ck] = rawText
		return rawText
	end

	if isDynamicHeartbeatLabelText(trimmed) then
		FastCache[ck] = rawText
		return rawText
	end

	if trimmed == "Figgy Hub" or trimmed == "figgy hub" or trimmed == "Banana Hub" or trimmed == "Figgy" then
		local res = lead .. "Banana Hub" .. trail
		FastCache[ck] = res
		return res
	end

	if targetLang == "EN" then
		local rev = VI_TO_EN[trimmed] or VI_TO_EN[string.lower(trimmed)]
		local res = rev and (lead .. rev .. trail) or rawText
		FastCache[ck] = res
		return res
	end

	local norm = trimmed:gsub("%s+", " ")
	if norm:match("^[%$%+%-%d%.%,%/%%sxhm:]+$") or (norm:match("^v%d+%.%d+") and #norm < 10) then
		FastCache[ck] = rawText
		return rawText
	end

	local exact = EXACT_VI[norm] or LOWER_VI[string.lower(norm)]
	if exact then
		local res = lead .. exact .. trail
		FastCache[ck] = res
		return res
	end

	local pfx, wp = norm:match("^([^%w%s]+%s*)(.+)$")
	if pfx and wp and (EXACT_VI[wp] or LOWER_VI[wp:lower()]) then
		local res = lead .. pfx .. (EXACT_VI[wp] or LOWER_VI[wp:lower()]) .. trail
		FastCache[ck] = res
		return res
	end

	for i = 1, #DYN_VI do
		if norm:find(DYN_VI[i].pat) then
			local res = lead .. norm:gsub(DYN_VI[i].pat, DYN_VI[i].rep) .. trail
			FastCache[ck] = res
			return res
		end
	end

	local res, hit = norm, false
	local caps = (norm:upper() == norm and norm:find("%a") ~= nil)
	for i = 1, #GRAMMAR_VI do
		if res:find(GRAMMAR_VI[i].pat) then
			res = res:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep)
			hit = true
			break
		end
	end

	local phr = applyPhrases(res)
	if hit or phr ~= res or res:find("%s") then
		local fin = applyWords(phr):gsub("Figgy Hub", "Banana Hub"):gsub("Venyx", "Banana Hub"):gsub("%s+", " "):match("^%s*(.-)%s*$") or res
		if caps and fin ~= norm then fin = fin:upper() end
		local finalOut = lead .. fin .. trail
		FastCache[ck] = finalOut
		return finalOut
	end

	FastCache[ck] = rawText
	return rawText
end

local function formatIslandStatusText(rawStatus)
	local clean = tostring(rawStatus or "Idle"):gsub("^•%s*", ""):gsub("^●%s*", ""):match("^%s*(.-)%s*$") or "Idle"
	if isTreadmillOrIdleStatus(clean) then
		return (State.Language == "EN") and "Idle" or "Đang rảnh"
	end
	if State.Language == "EN" then
		return clean
	end
	return translateStaticLabelText(clean, "VI")
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

	-- Nhận diện nút củ hành tím:
	-- [FIX-GẮN-NHẦM] Vị trí thôi là chưa đủ -> BẮT BUỘC có màu/gradient tím Figgy thật sự bên trong,
	-- nếu không các nút của game (Finder/Shop/Index, icon rương vật phẩm…) nằm cùng khu vực cũng bị gắn nhầm.
	local hasPurple = hasPurpleVisualInside(btn)
	if inLeftLogoBand and (absY >= 100 and absY <= 420) then
		if hasPurple then return true end
	end
	if inRightOnionBand and (absY >= 40 and absY <= 220) then
		if hasPurple then return true end
	end
	if State.OnionAsset and State.OnionAsset ~= "" then
		local function matchesOriginalOnionImage(obj)
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
		if matchesOriginalOnionImage(btn) then return true end
	end
	return false
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
				if not isProtected then
					d:Destroy()
					restoreWronglyDecoratedButton(par)
				end
			end
		end
	end
end

local function scanPurpleOnionButtonsOnceImpl()
	local yieldTick = makeYielder()
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
							yieldTick()
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
							yieldTick()
							if isPurpleOnionSquareButton(d, isVerifiedFiggy) then
								local isRight = (d.AbsolutePosition.X >= vpW * 0.75)
								decoratePurpleOnionButton(d, 2.0, isRight)
							elseif d:IsA("ImageLabel") and d.Parent and isPurpleOnionSquareButton(d.Parent, isVerifiedFiggy) then
								local isRight = (d.Parent.AbsolutePosition.X >= vpW * 0.75)
								decoratePurpleOnionButton(d.Parent, 2.0, isRight)
							end
						end
						removeWrongOnionOverlays(gui)
					end
				end
			end
		end
	end
end

local scanPurpleRunning = false
local function scanPurpleOnionButtonsOnce()
	if scanPurpleRunning then return end
	scanPurpleRunning = true
	pcall(scanPurpleOnionButtonsOnceImpl)
	scanPurpleRunning = false
end

-- ============================================================================
-- 7B2. QUÉT & ĐÈ RIÊNG NÚT CỦ HÀNH LỀ PHẢI (hàm còn thiếu — bổ sung tại đây)
-- ============================================================================
local function scanRightOnionButtonOnceImpl()
	local roots = getUiRoots()
	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local yieldTick = makeYielder()
	for _, root in ipairs(roots) do
		local descList = getScanList(root)
		do
			for _, obj in ipairs(descList) do
				yieldTick()
				if obj:IsA("GuiObject")
					and passesSquarePrefilter(obj)
					and not (State.IslandGui and obj:IsDescendantOf(State.IslandGui))
					and not isInsideLargeWindowFrame(obj) then
					local pos = obj.AbsolutePosition
					local sz  = obj.AbsoluteSize
					local px, py = pos.X, pos.Y
					local sx, sy = sz.X, sz.Y
					if sx == 0 and sy == 0 then
						local s = obj.Size
						if s and s.X and s.Y then
							sx, sy = s.X.Offset or 0, s.Y.Offset or 0
						end
					end
					-- Nút lề phải: X >= 78% màn hình, Y trong 40..220 (rộng hơn để bắt chắc)
					if sx >= 22 and sx <= 92 and sy >= 22 and sy <= 92
						and math.abs(sx - sy) <= 20
						and px >= (vpW * 0.76) and py >= 40 and py <= 220 then
						local hasText = false
						for _, sub in ipairs(obj:GetDescendants()) do
							if sub:IsA("TextLabel") and sub.Visible and sub.TextTransparency < 0.95 then
								local t = (sub.Text or ""):match("^%s*(.-)%s*$") or ""
								if #t > 0 then hasText = true break end
							end
						end
						if not hasText then
							local btn = (obj:IsA("ImageButton") or obj:IsA("ImageLabel")
								or obj:IsA("Frame") or obj:IsA("CanvasGroup")) and obj or obj.Parent
							if btn and btn:IsA("GuiObject") and not btn:FindFirstChild("BananaCatExactOverlay") then
								pcall(applyBananaCatExactOverlay, btn, true)
							end
						end
					end
				end
			end
		end
	end
end

-- ============================================================================
-- 7C. ĐÈ LOGO BANANA CAT VÀNG CHÍNH XÁC VÀO ĐÚNG 2 NÚT CỦ HÀNH TÍM (LỀ TRÁI & PHẢI)
--     1. Nút lề trái (dưới Shop): Nút hình tròn viền vàng mạ kim
--     2. Nút lề phải (trên icon trứng đỏ 8): Nút hình vuông bo góc đẹp viền vàng mạ kim
--     3. Tự động che sạch ảnh củ hành cũ và khóa cứng vĩnh viễn (Anti-Revert)
-- ============================================================================
local function getCustomOrThumbBananaCat()
	if State.BananaCatCustomAsset then return State.BananaCatCustomAsset end
	local asset = BANANA_CAT_LOGO
	pcall(function()
		if type(isfile) == "function" and type(getcustomasset) == "function" then
			if isfile("figgy_banana_cat.png") then
				local okA, a = pcall(getcustomasset, "figgy_banana_cat.png")
				if okA and type(a) == "string" and a ~= "" then asset = a end
			elseif isfile("BananaCat.png") then
				local okA, a = pcall(getcustomasset, "BananaCat.png")
				if okA and type(a) == "string" and a ~= "" then asset = a end
			end
		end
	end)
	State.BananaCatCustomAsset = asset
	return asset
end

local function applyBananaCatExactOverlay(targetBtn, isRightSide)
	if not targetBtn or not targetBtn.Parent then return end
	if targetBtn:FindFirstChild("BananaCatExactOverlay") then return end

	local asset = getCustomOrThumbBananaCat()
	local targetCorner = isRightSide and SQUARE_CORNER_UDIM or CIRCLE_CORNER_UDIM

	-- 1. Làm trong suốt hình ảnh và màu nền gốc của nút củ hành
	pcall(function()
		if targetBtn:IsA("ImageButton") or targetBtn:IsA("ImageLabel") then
			targetBtn.ImageTransparency = 1
		end
		targetBtn.BackgroundTransparency = 1
		for _, ch in ipairs(targetBtn:GetDescendants()) do
			if ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
				ch.ImageTransparency = 1
			end
			if ch:IsA("UIStroke") and ch.Name ~= "BananaCatGoldStroke" then
				ch.Transparency = 1
			end
		end
	end)

	-- 2. Tạo Frame chứa đè kín 100% lên nút
	local overlayFrame = Instance.new("Frame")
	overlayFrame.Name = "BananaCatExactOverlay"
	overlayFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	overlayFrame.Position = UDim2.fromScale(0.5, 0.5)
	overlayFrame.Size = UDim2.fromScale(1, 1)
	overlayFrame.BackgroundColor3 = Color3.fromRGB(24, 20, 28)
	overlayFrame.BackgroundTransparency = 0
	overlayFrame.BorderSizePixel = 0
	overlayFrame.ClipsDescendants = true
	overlayFrame.ZIndex = (targetBtn.ZIndex or 5) + 12
	overlayFrame.Parent = targetBtn

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = targetCorner
	frameCorner.Parent = overlayFrame

	-- Ánh kim vàng nền đĩa
	applyCoinSurfaceGoldGradient(overlayFrame)

	-- 3. Tạo Sprite Banana Cat căng tràn sắc nét
	local catSprite = Instance.new("ImageLabel")
	catSprite.Name = "BananaCatSprite"
	catSprite.AnchorPoint = Vector2.new(0.5, 0.5)
	catSprite.Position = UDim2.fromScale(0.5, 0.5)
	catSprite.Size = UDim2.fromScale(0.88, 0.88)
	catSprite.BackgroundTransparency = 1
	catSprite.BorderSizePixel = 0
	catSprite.Image = asset
	catSprite.ImageColor3 = Color3.fromRGB(255, 255, 255)
	catSprite.ImageRectOffset = STRETCH_CAT_OFFSET
	catSprite.ImageRectSize = STRETCH_CAT_SIZE
	catSprite.ScaleType = Enum.ScaleType.Stretch
	catSprite.ZIndex = overlayFrame.ZIndex + 1
	catSprite.Parent = overlayFrame

	local spriteCorner = Instance.new("UICorner")
	spriteCorner.CornerRadius = isRightSide and UDim.new(0.18, 0) or UDim.new(0.35, 0)
	spriteCorner.Parent = catSprite

	applyCoinSurfaceGoldGradient(catSprite)

	-- 4. Viền vàng mạ kim loại sắc nét
	local goldStroke = Instance.new("UIStroke")
	goldStroke.Name = "BananaCatGoldStroke"
	goldStroke.Thickness = 2.0
	goldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	goldStroke.Color = Color3.fromRGB(238, 210, 118)
	goldStroke.Transparency = 0.05
	pcall(function() goldStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize end)
	goldStroke.Parent = overlayFrame
	applyMetallicGoldGradient(goldStroke)

	-- 5. Khóa vĩnh viễn (Anti-Revert): giữ ảnh củ hành cũ luôn ẩn và ảnh mèo luôn nổi
	if targetBtn:IsA("ImageButton") or targetBtn:IsA("ImageLabel") then
		trackConn(targetBtn:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
			if isAlive() and targetBtn.ImageTransparency < 0.99 then
				pcall(function() targetBtn.ImageTransparency = 1 end)
			end
		end))
	end
	trackConn(catSprite:GetPropertyChangedSignal("Image"):Connect(function()
		if not isAlive() then return end
		local want = getCustomOrThumbBananaCat()
		if catSprite.Image ~= want then
			pcall(function() catSprite.Image = want end)
		end
	end))
end

local function scanAndApplyExactTwoOnionsImpl()
	local roots = getUiRoots()
	local vpW, vpH = getViewportWidth(), getViewportHeight()
	local yieldTick = makeYielder()

	for _, root in ipairs(roots) do
		local descList = getScanList(root)
		do
			for _, obj in ipairs(descList) do
				yieldTick()
				if obj:IsA("GuiObject") and passesSquarePrefilter(obj) and not (State.IslandGui and obj:IsDescendantOf(State.IslandGui)) and not isInsideLargeWindowFrame(obj) then
					local pos = obj.AbsolutePosition
					local sz = obj.AbsoluteSize
					local px, py = pos.X, pos.Y
					local sx, sy = sz.X, sz.Y

					if sx == 0 and sy == 0 then
						local s = obj.Size
						if s and s.X and s.Y then
							sx, sy = s.X.Offset or 0, s.Y.Offset or 0
						end
					end

					-- Bỏ qua nếu kích thước không phải dạng nút vuông nhỏ (24..90px)
					if sx >= 24 and sx <= 90 and sy >= 24 and sy <= 90 and math.abs(sx - sy) <= 18 then
						-- Bỏ qua nếu có chữ hiển thị như "Shop", "Tìm Kiếm", hoặc số "8"
						local hasText = false
						for _, sub in ipairs(obj:GetDescendants()) do
							if sub:IsA("TextLabel") and sub.Visible and sub.TextTransparency < 0.95 then
								local t = (sub.Text or ""):match("^%s*(.-)%s*$") or ""
								if #t > 0 then hasText = true break end
							end
						end

						if not hasText then
							-- Kiểm tra nút lề trái: X trong khoảng 20..210, Y trong khoảng 100..420 (mở rộng để bắt chắc hơn)
							if px >= 20 and px <= 210 and py >= 100 and py <= 420 then
								local btn = (obj:IsA("ImageButton") or obj:IsA("ImageLabel") or obj:IsA("Frame") or obj:IsA("CanvasGroup")) and obj or obj.Parent
								-- [FIX-GẮN-NHẦM] Bắt buộc có màu/gradient tím Figgy gốc + chỉ khoá đúng 1 nút logo chính bên trái.
								-- Thiếu điều kiện này thì icon Finder/Shop/Index của game (cùng khu vực, không phải màu tím) cũng bị gắn nhầm.
								if btn and btn:IsA("GuiObject") and not btn:FindFirstChild("BananaCatExactOverlay")
									and (State.OnionButton == nil or State.OnionButton == btn or not State.OnionButton.Parent)
									and hasPurpleVisualInside(btn) then
									State.OnionButton = btn
									applyBananaCatExactOverlay(btn, false)
								end
							-- Kiểm tra nút lề phải: X >= vpW*0.75, Y trong khoảng 40..220 (mở rộng để bắt chắc hơn)
							elseif px >= (vpW * 0.75) and py >= 40 and py <= 220 then
								local btn = (obj:IsA("ImageButton") or obj:IsA("ImageLabel") or obj:IsA("Frame") or obj:IsA("CanvasGroup")) and obj or obj.Parent
								-- [FIX-GẮN-NHẦM] Tương tự bên phải: cần đúng màu tím gốc + chỉ khoá đúng 1 nút,
								-- để không đè lên các icon vật phẩm/rương của game nằm cùng góc màn hình.
								if btn and btn:IsA("GuiObject") and not btn:FindFirstChild("BananaCatExactOverlay")
									and (State.RightOnionButton == nil or State.RightOnionButton == btn or not State.RightOnionButton.Parent)
									and hasPurpleVisualInside(btn) then
									State.RightOnionButton = btn
									applyBananaCatExactOverlay(btn, true)
								end
							end
						end
					end
				end
			end
		end
	end
end

local scanExactRunning = false
local function scanAndApplyExactTwoOnions()
	if scanExactRunning then return end
	scanExactRunning = true
	pcall(scanAndApplyExactTwoOnionsImpl)
	scanExactRunning = false
end

local scanRightRunning = false
local function scanRightOnionButtonOnce()
	if scanRightRunning then return end
	scanRightRunning = true
	pcall(scanRightOnionButtonOnceImpl)
	scanRightRunning = false
end

-- [FIX-ĐƠ V2] Gộp (debounce) mọi yêu cầu quét lại thành 1 lần, tối đa 1 lần / 0.8s (3s sau 20s đầu)
local START_CLOCK = os.clock()
local rescanPending = false
local function requestOnionRescan()
	if rescanPending or not isAlive() then return end
	rescanPending = true
	local wait_s = (os.clock() - START_CLOCK < 20) and 0.8 or 3
	task.delay(wait_s, function()
		rescanPending = false
		if not isAlive() then return end
		pcall(scanAndApplyExactTwoOnions)
		pcall(scanRightOnionButtonOnce)
	end)
end

-- Giăng lưới DescendantAdded trực tiếp (chỉ đánh dấu cần quét, KHÔNG quét ngay)
local function hookUiContainerForExactOnions(container)
	if not container then return end
	local conn = container.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		if desc:IsA("GuiObject") then
			local okP, pos = pcall(function() return desc.AbsolutePosition end)
			if not okP then return end
			local vpW = getViewportWidth()
			local px, py = pos.X, pos.Y
			if (px >= 20 and px <= 210 and py >= 100 and py <= 420) or (px >= (vpW * 0.75) and py >= 40 and py <= 220) then
				requestOnionRescan()
			end
		end
	end)
	trackConn(conn)
end

-- [FIX-ĐƠ] Chuyển toàn bộ hookUiContainer vào task.spawn để không block main thread
-- WaitForChild("PlayerGui", 5) trước đây có thể gây đơ 5 giây trên mobile!
task.spawn(function()
	pcall(function() hookUiContainerForExactOnions(game:GetService("CoreGui")) end)
	if gethui then pcall(function() hookUiContainerForExactOnions(gethui()) end) end
	if LocalPlayer then
		-- Dùng FindFirstChildOfClass trước, chỉ WaitForChild nếu chưa có (timeout 3s thay vì 5s)
		local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if not pg then
			local ok2, pg2 = pcall(function() return LocalPlayer:WaitForChild("PlayerGui", 3) end)
			if ok2 then pg = pg2 end
		end
		if pg then pcall(hookUiContainerForExactOnions, pg) end
	end
	task.delay(0.3, function()
		if isAlive() then pcall(scanAndApplyExactTwoOnions) end
	end)
end)

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
				pcall(function()
					if bindMenuVisibilityListener then
						bindMenuVisibilityListener(curWin)
					end
				end)
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
		local updatingText = false
		trackConn(obj:GetPropertyChangedSignal("Text"):Connect(function()
			if updatingText or not isAlive() then return end
			local newT = obj.Text or ""
			if newT == "" or isDynamicHeartbeatLabelText(newT) then return end
			local tr = translateStaticLabelText(newT, State.Language)
			if tr and tr ~= newT then
				updatingText = true
				obj:SetAttribute("__FiggyOrigText", newT)
				pcall(function() obj.Text = tr end)
				updatingText = false
			end
		end))
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

	-- Hàng đợi xử lý theo lô (Batch Queue) siêu mượt: khi chuyển Tab có hàng trăm phần tử mới,
	-- gom lại xử lý nhẹ nhàng, không tạo hàng trăm luồng task.defer gây khựng/đơ game!
	local pendingQueue = {}
	local queueScheduled = false
	local function flushPendingQueue()
		queueScheduled = false
		if not isAlive() then return end
		local count = #pendingQueue
		-- [FIX-ĐƠ] Xử lý tối đa 60 phần tử mỗi frame thay vì 140, tránh đơ 1 frame quá lâu
		local limit = math.min(count, 60)
		for i = 1, limit do
			local item = pendingQueue[i]
			pendingQueue[i] = nil
			if item and item.Parent then
				pcall(processGuiElement, item)
			end
		end
		-- Nếu còn phần tử chưa xử lý thì defer sang frame tiếp theo
		if count > limit then
			-- Dồn phần còn lại về đầu mảng
			for i = limit + 1, count do
				pendingQueue[i - limit] = pendingQueue[i]
				pendingQueue[i] = nil
			end
			queueScheduled = true
			task.delay(0.03, flushPendingQueue)
		end
	end

	-- Tối ưu cực hạn theo yêu cầu:
	-- KHÔNG TẠO VÒNG LẶP. Khi mở menu ra thì dịch tức thời các phần tử nhìn thấy,
	-- khi tắt/đóng menu đi thì DỪNG HOÀN TOÀN (0% CPU, không tốn tài nguyên khi chơi)!
	local menuActive = true
	local liveDescConn = nil

	local function startMenuListener()
		if liveDescConn then return end
		liveDescConn = gui.DescendantAdded:Connect(function(desc)
			if not isAlive() or not menuActive then return end
			if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
				table.insert(pendingQueue, desc)
				if not queueScheduled then
					queueScheduled = true
					task.delay(0.03, flushPendingQueue)
				end
			end
		end)
		trackConn(liveDescConn)
	end

	local function stopMenuListener()
		if liveDescConn then
			pcall(function() liveDescConn:Disconnect() end)
			liveDescConn = nil
		end
	end

	startMenuListener()

	-- Tự động lắng nghe trạng thái Ẩn/Hiện của cửa sổ Menu chính để Dừng/Chạy dịch tức thì
	local function bindMenuVisibilityListener(winObj)
		if not winObj or winObj:GetAttribute("__VisListenerBound") == SID then return end
		winObj:SetAttribute("__VisListenerBound", SID)
		trackConn(winObj:GetPropertyChangedSignal("Visible"):Connect(function()
			if not isAlive() then return end
			menuActive = winObj.Visible
			if menuActive then
				startMenuListener()
				-- Dịch nhanh các phần tử trong tab vừa mở (chỉ 1 lần duy nhất qua FastCache)
				task.spawn(function()
					if not isAlive() or not menuActive then return end
					local okD, desc = pcall(function() return winObj:GetDescendants() end)
					if okD and type(desc) == "table" then
						local cnt = 0
						for _, d in ipairs(desc) do
							if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
								pcall(processGuiElement, d)
								cnt = cnt + 1
								if cnt % 60 == 0 then
									task.wait()
									if not isAlive() or not menuActive then return end
								end
							end
						end
					end
				end)
			else
				-- Menu đã đóng/tắt -> Dừng toàn bộ xử lý dịch, nhường 100% CPU cho game mượt mà!
				stopMenuListener()
			end
		end))
	end

	task.spawn(function()
		local okDesc, descendants = pcall(function() return gui:GetDescendants() end)
		if okDesc and type(descendants) == "table" then
			-- Tìm title trước (nhẹ)
			for _, d in ipairs(descendants) do
				if d:IsA("TextLabel") and (d.Text == "Figgy Hub" or d.Text == "Banana Hub" or d.Text == "FrostyFig") then
					pcall(bindHeaderAndLogosFromTitle, d)
					break
				end
			end
			if State.FiggyMainWindow and bindMenuVisibilityListener then
				pcall(bindMenuVisibilityListener, State.FiggyMainWindow)
			end

			-- [FIX-ĐƠ V2] task.defer KHÔNG nhường frame -> dùng task.wait() trong luồng riêng (không chặn game)
			local CHUNK = 50
			local total = #descendants
			for i = 1, total do
				if not isAlive() then return end
				pcall(processGuiElement, descendants[i])
				if i % CHUNK == 0 then task.wait() end
			end
			pcall(scanPurpleOnionButtonsOnce)
		end
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
	local q, qHead, qTail, qScheduled = {}, 1, 0, false
	local lastCheck = 0
	local function flushEarlyQueue()
		qScheduled = false
		if not isAlive() then q, qHead, qTail = {}, 1, 0 return end
		local processed = 0
		while qHead <= qTail and processed < 40 do
			local d = q[qHead]
			q[qHead] = nil
			qHead = qHead + 1
			processed = processed + 1
			if d and d.Parent then pcall(processGuiElement, d) end
		end
		-- Kiểm tra "có phải cửa sổ Figgy chưa" tối đa 2 lần/giây (GetDescendants khá đắt)
		local now = os.clock()
		if gui:GetAttribute("__FiggyGuiHooked") ~= SID and now - lastCheck > 0.5 then
			lastCheck = now
			-- GUI còn đang được dựng dở nên lần kiểm tra trước có thể sai -> cho phép kiểm tra lại
			pcall(function() gui:SetAttribute("__NotFiggyGui", nil) end)
			if isFiggyWindowGui(gui) then
				if earlyConn then pcall(function() earlyConn:Disconnect() end) end
				pcall(hookTargetScreenGui, gui)
				return
			end
		end
		if qHead <= qTail then
			qScheduled = true
			task.delay(0.03, flushEarlyQueue)
		else
			q, qHead, qTail = {}, 1, 0
		end
	end
	earlyConn = gui.DescendantAdded:Connect(function(desc)
		if not isAlive() then return end
		qTail = qTail + 1
		q[qTail] = desc
		if not qScheduled then
			qScheduled = true
			task.delay(0.03, flushEarlyQueue)
		end
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
-- [FIX-ĐƠ] Chuyển createIndependentFiggyDynamicIsland + cleanup vào task.spawn
-- Trên mobile yếu, tạo hàng chục Instance đồng bộ = đơ ngay lúc load
local existingFiggyGui = nil

task.spawn(function()
	-- Tạo Dynamic Island trong luồng riêng
	pcall(createIndependentFiggyDynamicIsland)

	-- Dọn dẹp trong luồng riêng, không đơ main thread
	local ok, result = pcall(cleanupPreviousOverlaysAndDeduplicate)
	if ok and result then existingFiggyGui = result end

	if existingFiggyGui and existingFiggyGui.Parent then
		pcall(hookTargetScreenGui, existingFiggyGui)
	end

	for _, root in ipairs(getUiRoots()) do
		local okCh, children = pcall(function() return root:GetChildren() end)
		if okCh and type(children) == "table" then
			for gi, gui in ipairs(children) do
				pcall(watchCandidateGuiAtStartup, gui)
				if gi % 3 == 0 then task.wait() end -- [FIX-ĐƠ V2] mỗi GUI có thể phải GetDescendants
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

	-- Thực thi phân tầng theo nhịp mượt mà (tránh dồn 5 lệnh quét DOM cùng 1 khung hình gây đơ game)
	-- [FIX-ĐƠ V2] Mỗi mốc 1 luồng riêng, các hàm quét tự nhường frame + có khoá chống chạy chồng
	task.delay(0.6, function()
		if not isAlive() then return end
		pcall(scanAndApplyExactTwoOnions)
		pcall(trySelectGoldThemeOnce)
	end)

	task.delay(2.0, function()
		if not isAlive() then return end
		pcall(scanPurpleOnionButtonsOnce)
		pcall(scanRightOnionButtonOnce)
		task.wait()
		pcall(refreshAllTranslatedMenus)
		pcall(trySelectGoldThemeOnce)
	end)

	task.delay(4.5, function()
		if not isAlive() then return end
		pcall(cleanupPreviousOverlaysAndDeduplicate)
		pcall(trySelectGoldThemeOnce)
	end)
end)
