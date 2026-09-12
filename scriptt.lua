-- ==============================================================================
--  RONNEI HUB - FULL BRANDING HOOK (TEXT + LOGO HIJACK & FAST STEAL 0.12S)
--  Tự động thay thế: Tiêu đề, Logo menu, Logo nút bấm tròn & Nhặt nhanh 0.12s
-- ==============================================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGuiService = game:GetService("CoreGui")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    LogoAssetID       = "rbxassetid://124285855971647",
    StealHoldDuration = 0.12
}

-- ==================== 1. CƠ CHẾ NHẶT NHANH 0.12S ====================
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

-- ==================== 2. CHÈN TEXT & LOGO RONNEI HUB TRỰC TIẾP ====================
task.spawn(function()
    local function hijackElement(inst)
        pcall(function()
            -- Thay thế chữ (Tiêu đề, thông tin liên kết)
            if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                local function applyBranding()
                    local raw = inst.Text:upper()
                    if raw:find("EQUINOZ") then
                        inst.Text = "RONNEI HUB"
                    elseif raw:find("VEUURTUMWE") or raw:find("DISCORD.GG") then
                        inst.Text = "TIKTOK: @RONNEI7.HTK"
                    end
                end

                applyBranding()
                inst:GetPropertyChangedSignal("Text"):Connect(applyBranding)

            -- Thay thế hình ảnh logo (Header & Nút tròn mở menu)
            elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                local p = inst.Parent
                local pName = p and p.Name:lower() or ""
                local iName = inst.Name:lower()

                -- Kiểm tra xem đối tượng có nằm trong menu hoặc nút toggle của script gốc không
                local ownerSg = inst:FindFirstAncestorOfClass("ScreenGui")
                local isTarget = false

                if ownerSg then
                    for _, sibling in ipairs(ownerSg:GetDescendants()) do
                        if (sibling:IsA("TextLabel") or sibling:IsA("TextButton")) and sibling.Text:upper():find("ANTI HIT") then
                            isTarget = true
                            break
                        end
                    end
                end

                if isTarget and (pName:find("logo") or pName:find("icon") or pName:find("toggle") or pName:find("btn") or iName:find("logo") or iName:find("icon") or inst:IsA("ImageButton")) then
                    local function applyLogo()
                        if inst.Image ~= CONFIG.LogoAssetID then
                            inst.Image = CONFIG.LogoAssetID
                        end
                    end

                    applyLogo()
                    inst:GetPropertyChangedSignal("Image"):Connect(applyLogo)
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
            for _, desc in ipairs(root:GetDescendants()) do
                hijackElement(desc)
            end
            root.DescendantAdded:Connect(hijackElement)
        end
    end
end)

-- ==================== 3. KHỞI CHẠY SCRIPT GỐC ====================
task.spawn(function()
    pcall(function()
        script_key = "Trial"
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()
    end)
end)
