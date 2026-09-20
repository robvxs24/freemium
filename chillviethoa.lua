-- ==============================================================================
--  CHILLI HUB - ULTRA ZERO-LAG & NOSTALGIC SUNSET ENGINE V10.0 (EN/VI/PH/ID)
--  Tối ưu hóa:
--    1. Cập nhật 100% tiếng sự kiện mới: Dr Scramble Event, Auto Hunt Drone, Vault.
--    2. Nostalgic Shader: Ánh sáng chiều tà (Golden hour), tone ấm, tương phản nhẹ.
--    3. Recursive Chunking: Quét map đệ quy ngầm, loại bỏ 100% hiện tượng đơ khởi động.
--    4. Vòng xoay 4 ngôn ngữ và Nút bấm Frosted Slate (Top-Center).
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP CHILLI HUB GỐC (ƯU TIÊN SỐ 1) ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg"))()
    end)
end)

-- ==================== 2. MODULE HOÀNG HÔN HOÀI NIỆM & CHỐNG LAG ====================
-- Nhường 3.5s cho UI gốc load, chống đơ main thread
task.delay(3.5, function()
    pcall(function()
        -- Shader Hoàng Hôn Chân Thực (Golden Hour)
        Lighting.GlobalShadows = false
        Lighting.TimeOfDay = "17:15:00" -- Chiều tà vàng ruộm
        Lighting.Ambient = Color3.fromRGB(110, 100, 90) -- Bóng râm xám ấm
        Lighting.OutdoorAmbient = Color3.fromRGB(160, 130, 100) -- Nắng vàng nhẹ nhàng
        Lighting.Brightness = 1.0
        Lighting.ColorShift_Bottom = Color3.fromRGB(130, 110, 90)
        Lighting.ColorShift_Top = Color3.fromRGB(255, 235, 210)
        Lighting.FogEnd = 9e9 -- Xóa sương mù

        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") then
                v:Destroy()
            end
        end

        local cc = Instance.new("ColorCorrectionEffect", Lighting)
        cc.Saturation = 0.15
        cc.Contrast = 0.05
        cc.TintColor = Color3.fromRGB(255, 250, 240)

        local bloom = Instance.new("BloomEffect", Lighting)
        bloom.Intensity = 0.35 
        bloom.Size = 14
        bloom.Threshold = 1.2 

        -- Quét map chuyển SmoothPlastic & Neon (Phân luồng siêu nhẹ)
        local function processGraphics(parent)
            local children = parent:GetChildren()
            for i, obj in ipairs(children) do
                if obj:IsA("BasePart") then
                    obj.CastShadow = false
                    local name = obj.Name:lower()
                    local pName = (obj.Parent and obj.Parent.Name:lower()) or ""
                    
                    if name:find("egg") or pName:find("egg") then
                        obj.Material = Enum.Material.Neon
                    else
                        obj.Material = Enum.Material.SmoothPlastic
                    end
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                end
                
                if i % 50 == 0 then RunService.RenderStepped:Wait() end
                processGraphics(obj)
            end
        end

        task.spawn(function() pcall(function() processGraphics(workspace) end) end)

        workspace.DescendantAdded:Connect(function(obj)
            task.defer(function() 
                if obj:IsA("BasePart") then
                    obj.CastShadow = false
                    local name = obj.Name:lower()
                    local pName = (obj.Parent and obj.Parent.Name:lower()) or ""
                    if name:find("egg") or pName:find("egg") then
                        obj.Material = Enum.Material.Neon
                    else
                        obj.Material = Enum.Material.SmoothPlastic
                    end
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                end
            end)
        end)
    end)
end)

-- ==================== 3. HỆ THỐNG DỊCH THUẬT QUAD-LANGUAGE (V10.0) ====================
local currentLanguage = "VI"
local translationLock = false
local FastCache = {}

local function safeReplace(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    if startIdx then
        return str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
    end
    return str
end

local MAP_VI = {
    -- Các Tab Chính
    ["Farm"] = "Cày Cuốc", ["Player"] = "Người Chơi", ["Egg Finder"] = "Máy Dò Trứng",
    ["Predictor"] = "Soi Trứng", ["Progress"] = "Tiến Độ", ["Server"] = "Máy Chủ",
    ["Misc"] = "Linh Tinh", ["Creator"] = "Tác Giả", ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt", ["Settings"] = "Cài Đặt", ["Config"] = "Cấu Hình",
    
    -- === DR SCRAMBLE EVENT (SỰ KIỆN MỚI) ===
    ["Dr Scramble Event"] = "Sự Kiện Dr Scramble",
    ["Auto Hunt Drones"] = "Tự Động Săn Drone",
    ["Kill drones during outbreaks for Samples and Drone Parts"] = "Tiêu diệt drone khi bùng phát để lấy Mẫu Vật và Phụ Tùng",
    ["Hunt Priority"] = "Ưu Tiên Săn",
    ["Most HP First"] = "Nhiều Máu Nhất Trước",
    ["Drone Types"] = "Loại Drone",
    ["Hunt Travel Method"] = "Cách Thức Di Chuyển",
    ["Teleport only to drones within 50 studs, farther ones are tweened"] = "Dịch chuyển nếu dưới 50 studs, xa hơn sẽ dùng Tween bay tới",
    ["Hunt Tween Speed"] = "Tốc Độ Bay (Tween) Săn",
    ["Only Until Vault Parts Found"] = "Dừng Khi Đủ Phụ Tùng Hầm",
    ["Auto Collect Lost Parts"] = "Tự Nhặt Phụ Tùng Rơi",
    ["Collect the 2 Lost Parts for the vault"] = "Thu thập đủ 2 Phụ Tùng Rơi để mở hầm",
    ["Auto Open Vault"] = "Tự Động Mở Hầm Chứa",
    ["Open the vault when all 5 parts are found"] = "Tự mở khóa hầm khi đã thu thập đủ 5 phụ tùng",
    ["Auto Buy Scramble Shop"] = "Tự Động Mua Shop Scramble",
    ["Buy the picked items with Samples"] = "Dùng Mẫu Vật để mua các món đồ đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble",
    ["Keep Samples"] = "Giữ Lại Mẫu Vật (Không mua hết)",
    ["Go To Secret Cave"] = "Đi Đến Hang Động Bí Ẩn (Secret)",
    
    -- Các menu điều hướng
    ["Farm Tab > Auto Steal"] = "Tab Cày Cuốc > Tự Động Cướp",
    ["Farm Tab > Auto Place Egg"] = "Tab Cày Cuốc > Tự Đặt Trứng",
    ["Farm Tab > Auto Treadmill"] = "Tab Cày Cuốc > Tự Chạy Máy Tập",
    ["Farm Tab > Auto Hatch & Equip"] = "Tab Cày Cuốc > Tự Ấp & Thay Thú",
    ["Farm Tab > Auto Sell"] = "Tab Cày Cuốc > Tự Động Bán",
    ["Farm Tab > Auto Fuse Machine"] = "Tab Cày Cuốc > Tự Máy Ghép",
    ["Farm Tab > Auto Favorite"] = "Tab Cày Cuốc > Tự Khóa Thú",
    ["Farm Tab > Auto Rift & Boss"] = "Tab Cày Cuốc > Tự Động Rift & Boss",
    ["Player Tab > ESP"] = "Tab Người Chơi > Xuyên Tường (ESP)",
    ["Player Tab > Movement"] = "Tab Người Chơi > Di Chuyển",
    ["Player Tab > Character"] = "Tab Người Chơi > Nhân Vật",
    ["Egg Finder Tab > Egg Finder"] = "Tab Tìm Trứng > Máy Dò Trứng",
    ["Predictor Tab > Discord Webhook"] = "Tab Dự Đoán > Webhook Discord",
    ["Predictor Tab > Egg Predictor"] = "Tab Dự Đoán > Soi Trứng",
    ["Predictor Tab > Fuse Predictor"] = "Tab Dự Đoán > Soi Tỷ Lệ Ghép",
    ["Progress Tab > Auto Progression"] = "Tab Tiến Độ > Tự Động Thăng Tiến",
    ["Server Tab > Server"] = "Tab Máy Chủ > Máy Chủ",
    ["Misc Tab > Performance"] = "Tab Linh Tinh > Hiệu Năng",
    ["Misc Tab > Utility"] = "Tab Linh Tinh > Tiện Ích",
    ["Discord Tab > Creator Event"] = "Tab Discord > Sự Kiện Tác Giả",
    ["Discord Tab > Community"] = "Tab Discord > Cộng Đồng",
    ["Quick & Keys Tab > Quick Access"] = "Tab Phím Tắt > Truy Cập Nhanh",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Tab Phím Tắt > Thanh Nhanh & Gán Phím",
    ["Settings Tab > Interface"] = "Tab Cài Đặt > Giao Diện",
    ["Settings Tab > Defaults"] = "Tab Cài Đặt > Mặc Định",
    ["Config Tab > Config"] = "Tab Cấu Hình > Cấu Hình",
    ["Config Tab > Profiles"] = "Tab Cấu Hình > Hồ Sơ",
    ["Config Tab > Import/Export"] = "Tab Cấu Hình > Nhập/Xuất",
    
    -- Các tính năng
    ["Auto Steal"] = "Tự Động Cướp", ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Rarity"] = "Độ Hiếm Tối Thiểu", ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng từ độ hiếm đã chọn trở lên",
    ["Min Value To Steal"] = "Giá Trị Cướp Tối Thiểu", ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Target Specific Eggs"] = "Nhắm Trứng Cụ Thể", ["Only steal these eggs (empty = all)"] = "Chỉ cướp những trứng này (Trống = Tất cả)",
    ["Prioritize Rift Recipe Eggs"] = "Ưu Tiên Trứng Rift", ["Steal eggs the Rift recipe needs first"] = "Cướp trứng cần cho Rift trước",
    ["Steal Priority"] = "Ưu Tiên Cướp", ["Highest Value"] = "Giá Trị Cao Nhất",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)", ["Anti Guard V1"] = "Chống Vệ Sĩ V1",
    ["Not recommended to use with Auto Steal"] = "Không khuyên dùng cùng Tự Động Cướp",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng", ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Priority"] = "Ưu Tiên Đặt Trứng", ["Biggest Size"] = "Kích Thước Lớn Nhất",
    ["Always"] = "Luôn Luôn", ["Auto Treadmill"] = "Tự Chạy Máy Tập",
    ["Stay On Treadmill"] = "Giữ Trên Máy Tập", ["Re-mount the belt whenever the ride drops"] = "Tự trèo lên lại nếu bị rớt",
    ["Auto Hatch & Equip"] = "Tự Ấp & Thay Thú", ["Auto Hatch"] = "Tự Động Ấp",
    ["Auto Equip Best"] = "Tự Mặc Đồ Xịn Nhất", ["Equip Best when a better pet appears"] = "Tự đổi thú xịn hơn khi có",
    ["Auto Sell"] = "Tự Động Bán", ["Auto Sell Pet"] = "Tự Động Bán Thú",
    ["Sell Pets Now"] = "Bán Thú Ngay", ["Sell Pet Rule"] = "Quy Tắc Bán Thú",
    ["Which checks must pass to sell"] = "Điều kiện cần thỏa mãn để bán", ["Rarity Only"] = "Chỉ Xét Độ Hiếm",
    ["Pet Max Rarity"] = "Độ Hiếm Thú Tối Đa", ["Sell pets at or below this rarity"] = "Bán thú từ độ hiếm này trở xuống",
    ["Pet Value Threshold"] = "Ngưỡng Giá Trị Thú", ["Sell pets worth less than this (0 = off)"] = "Bán thú rẻ hơn mức này (0 = Tắt)",
    ["Keep Mutated Pets"] = "Giữ Thú Đột Biến", ["Never sell mutated pets"] = "Tuyệt đối không bán thú đột biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen (Không Bán)", ["These pets are never sold"] = "Những thú này sẽ không bao giờ bị bán",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng", ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi theo luật dưới đây",
    ["Sell Eggs Now"] = "Bán Trứng Ngay", ["Sell matching eggs once"] = "Bán trứng đúng điều kiện một lần",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng", ["Egg Max Rarity"] = "Độ Hiếm Trứng Tối Đa",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống", ["Egg Value Threshold"] = "Ngưỡng Giá Trị Trứng",
    ["Sell eggs worth less than this (0 = off)"] = "Bán trứng rẻ hơn mức này (0 = Tắt)", ["Keep Mutated Eggs"] = "Giữ Trứng Đột Biến",
    ["Never sell mutated eggs"] = "Tuyệt đối không bán trứng đột biến", ["Blacklist Sell Eggs"] = "Danh Sách Đen Trứng",
    ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Auto Fuse Machine"] = "Tự Động Máy Ghép", ["Fuse 3 same pets into an egg, nonstop"] = "Liên tục ghép 3 thú giống nhau",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Ghép", ["Lowest Rarity First"] = "Độ Hiếm Thấp Trộn Trước",
    ["Pets To Use"] = "Thú Cưng Sử Dụng", ["Lowest To Highest"] = "Từ Thấp Đến Cao",
    ["Max Rarity to Fuse"] = "Độ Hiếm Ghép Tối Đa", ["Specific Species to Fuse"] = "Chỉ Ghép Loài Thú Này",
    ["Only fuse these species (empty = all)"] = "Chỉ ghép những loài này (Trống = Tất cả)", ["Skip Mutated Pets"] = "Bỏ Qua Thú Đột Biến",
    ["Eject Incomplete Slots"] = "Đẩy Ra Ô Chưa Đủ", ["Take out pets that can't make a set"] = "Lấy ra thú không đủ bộ 3 con",
    ["Auto Favorite"] = "Tự Động Khóa Thú", ["Auto Favorite Pet"] = "Tự Động Khóa Thú",
    ["Favorite pets matching the rules below"] = "Khóa thú thỏa mãn luật bên dưới", ["Favorite Pets Now"] = "Khóa Thú Ngay",
    ["Favorite matching pets once"] = "Khóa thú đúng điều kiện 1 lần", ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Pass any check or all checks"] = "Thỏa 1 điều kiện hoặc tất cả", ["Match All"] = "Khớp Tất Cả",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min", ["Favorite pets of the chosen rarity and every rarity above it"] = "Khóa thú từ độ hiếm này trở lên",
    ["Favorite Mutations"] = "Khóa Thú Đột Biến", ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (Trống = Bỏ qua)",
    ["Favorite Min Value"] = "Giá Trị Khóa Min", ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = Bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Loài Này", ["Always favorite these species"] = "Luôn khóa những loài thú này",
    ["Auto Favorite Equipped"] = "Tự Khóa Thú Đang Dùng", ["Keep equipped pets favorited"] = "Giữ thú đang trang bị ở trạng thái khóa",
    ["Auto Unfavorite Equipped"] = "Tự Mở Khóa Thú Đang Dùng", ["Unfavorite equipped pets not in the rules"] = "Mở khóa nếu không đúng luật",
    ["Favorite Equipped Now"] = "Khóa Thú Đang Dùng Ngay", ["Favorite all equipped pets once"] = "Khóa tất cả thú đang dùng",
    ["Unfavorite Equipped Now"] = "Mở Khóa Thú Đang Dùng Ngay", ["Unfavorite all equipped pets once"] = "Mở khóa tất cả thú đang dùng",
    ["Auto Rift & Boss"] = "Tự Động Rift & Boss", ["Auto Rift Sacrifice"] = "Tự Động Hiến Tế Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Tự nạp 3 thú yêu cầu vào máy Rift", ["Auto Reroll Rift Recipe"] = "Tự Động Đổi Công Thức Rift",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Đổi công thức nếu thiếu thú và còn lượt free", ["Auto Claim Boss Mastery"] = "Tự Nhận Thưởng Boss",
    ["Claim milestone rewards as soon as the kill count allows"] = "Nhận mốc thưởng ngay khi đủ điểm hạ gục", ["Auto Fight Boss"] = "Tự Động Đánh Boss",
    ["Auto Progression"] = "Tự Động Thăng Tiến", ["Auto Buy Trail"] = "Tự Động Mua Vệt Sáng",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng khi đủ tiền", ["Auto Upgrade Base"] = "Tự Động Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi có tiền", ["Auto Upgrade Treadmill"] = "Tự Động Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi có tiền", ["Auto Claim"] = "Tự Động Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền offline & thưởng danh mục",
    ["ESP"] = "Xuyên Tường (ESP)", ["ESP Eggs"] = "Hiển Thị Trứng",
    ["ESP Fixed Size"] = "Cố Định Kích Cỡ ESP", ["ESP Own Base Eggs"] = "Hiển Thị Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiện cả trứng đã đặt trong căn cứ của bạn", ["ESP Min Rarity"] = "Độ Hiếm Tối Thiểu ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm này trở lên", ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["ESP Min Value"] = "Giá Trị ESP Tối Thiểu", ["ESP Egg Size"] = "Kích Cỡ Trứng ESP",
    ["ESP Guards"] = "Hiển Thị Vệ Sĩ", ["ESP Guard Size"] = "Kích Cỡ Vệ Sĩ ESP",
    ["ESP Players"] = "Hiển Thị Người Chơi", ["ESP Player Info"] = "Thông Tin Người Chơi ESP",
    ["ESP Player Size"] = "Kích Cỡ Người Chơi ESP", ["Movement"] = "Di Chuyển",
    ["Speed Boost"] = "Tăng Tốc Di Chuyển", ["Boost Speed"] = "Tốc Độ Tăng Cường",
    ["Infinite Jump"] = "Nhảy Vô Hạn", ["Character"] = "Nhân Vật",
    ["Anti Ragdoll"] = "Chống Ngã (Ragdoll)", ["Anti Trap"] = "Chống Bẫy",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không bắt được bạn", ["Instant Steal"] = "Cướp Tức Thì",
    ["IDLE"] = "ĐANG CHỜ LỆNH", ["Turn on Egg Finder to start hunting"] = "Bật Máy Dò Trứng để bắt đầu săn",
    ["Keep hopping servers until a matching egg is found"] = "Đổi server liên tục tới khi thấy trứng đúng luật", ["Link To Auto Steal Filters"] = "Dùng Chung Bộ Lọc Tự Động Cướp",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Đồng bộ hóa bộ lọc với tab Tự Động Cướp", ["Min Value To Find"] = "Giá Trị Trứng Tối Thiểu",
    ["Hop Only When Rarity Appears"] = "Chỉ Đổi Server Khi Thấy Độ Hiếm Này", ["Wait for the chosen rarity to appear, then hop until night"] = "Chờ độ hiếm xuất hiện, sau đó đổi server liên tục",
    ["Rarity That Must Appear"] = "Độ Hiếm Bắt Buộc Xuất Hiện", ["Hop starts when this rarity or higher appears"] = "Đổi server khi độ hiếm này xuất hiện",
    ["Hop Delay"] = "Độ Trễ Đổi Server", ["Egg Predictor"] = "Soi Trứng (Predictor)",
    ["Sort By"] = "Sắp Xếp Theo", ["Value"] = "Giá Trị",
    ["Preview Card"] = "Xem Thẻ Trước", ["Search eggs..."] = "Tìm kiếm trứng...",
    ["Tap an egg below to preview it"] = "Chạm vào trứng bên dưới để xem chi tiết", ["In inventory"] = "Trong túi",
    ["Hold egg"] = "Đang giữ", ["Fuse Predictor"] = "Soi Tỷ Lệ Ghép (Fuse)",
    ["Machine is empty"] = "Máy đang trống", ["Load 3 pets of the same species to see the result odds"] = "Cho 3 thú cùng loài vào để xem tỷ lệ kết quả",
    ["Search"] = "Tìm Kiếm", ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server", ["Least Players"] = "Ít Người Chơi Nhất",
    ["Server Hop"] = "Đổi Server Ngay", ["Job ID"] = "ID Máy Chủ (Job ID)",
    ["Paste a server Job ID..."] = "Dán ID máy chủ vào đây...", ["Join Job ID"] = "Vào Bằng ID",
    ["Copy Current Job ID"] = "Chép ID Máy Chủ Hiện Tại", ["Rejoin Server"] = "Vào Lại Máy Chủ Này",
    ["Join"] = "Vào", ["Copy"] = "Chép", ["Rejoin"] = "Vào Lại", ["Hop"] = "Chuyển",
    ["Performance"] = "Hiệu Năng", ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa Tối Đa", ["Strip shadows, textures and effects for the highest FPS"] = "Tắt bóng, kết cấu và hiệu ứng để đạt FPS cao nhất",
    ["FPS and Ping"] = "Hiện FPS & Ping", ["FPS and Ping Size"] = "Cỡ Chữ FPS & Ping",
    ["Utility"] = "Tiện Ích", ["Anti AFK"] = "Chống Treo Máy (AFK)",
    ["Creator Event"] = "Sự Kiện Của Tác Giả", ["INVITE LINK"] = "LIÊN KẾT MỜI",
    ["Copy Link"] = "Sao Chép Link", ["WHAT YOU GET"] = "BẠN NHẬN ĐƯỢC GÌ",
    ["New Scripts & Updates"] = "Script & Cập Nhật Mới", ["Patch notes and new game scripts are posted there first."] = "Chi tiết cập nhật và script game mới được đăng ở đây đầu tiên.",
    ["Giveaways"] = "Tặng Quà (Giveaways)", ["Member giveaways and events are announced in the server."] = "Sự kiện và phát quà cho thành viên được thông báo trong server.",
    ["Support"] = "Hỗ Trợ", ["Ask for help, report bugs and get answers from the team."] = "Hỏi đáp, báo lỗi và nhận hỗ trợ từ nhóm phát triển.",
    ["Suggestions"] = "Đóng Góp Ý Kiến", ["Request features and vote on what gets added next."] = "Yêu cầu tính năng và bình chọn cập nhật tiếp theo.",
    ["Paste the copied link into your browser or the Discord app to join."] = "Dán link vừa chép vào trình duyệt hoặc app Discord để tham gia.",
    ["Copy Discord Link"] = "Chép Link Discord", ["Click"] = "Bấm",
    ["Quick Access"] = "Truy Cập Nhanh", ["Show Quick Bars"] = "Hiện Thanh Phím Tắt",
    ["Floating quick bars; drag a header to move one"] = "Thanh phím tắt nổi; kéo tiêu đề để di chuyển", ["Visible Quick Bars"] = "Các Thanh Đang Hiện",
    ["Quick Bar Size"] = "Kích Cỡ Thanh Phím Tắt", ["Quick Bar & Keybinds"] = "Thanh Phím Tắt & Gán Nút",
    ["Reset Quick Access"] = "Đặt Lại Truy Cập Nhanh", ["Restore default items, bars and positions"] = "Khôi phục lại vị trí thanh mặc định",
    ["Reset Keybinds"] = "Đặt Lại Nút Gán", ["Restore the defaults set in code"] = "Khôi phục lại nút gán mặc định",
    ["Reset"] = "Đặt Lại", ["Interface"] = "Giao Diện", ["UI Size"] = "Kích Cỡ Giao Diện",
    ["Scales the main window; the corner grip does the same by hand"] = "Đổi cỡ cửa sổ; kéo góc dưới cùng bên phải để đổi thủ công",
    ["Notifications"] = "Bật Thông Báo", ["Show notification cards; turning this off hides every notify"] = "Hiện thẻ thông báo; tắt mục này sẽ ẩn toàn bộ",
    ["Open On Launch"] = "Mở Khi Khởi Chạy", ["Open the UI automatically when the script starts"] = "Tự động hiện bảng menu khi script bắt đầu",
    ["Defaults"] = "Mặc Định", ["Reset to Defaults"] = "Đặt Lại Về Mặc Định",
    ["Reset every feature to its built-in default"] = "Khôi phục mọi tính năng về mặc định gốc", ["Turn Off All Toggles"] = "Tắt Tất Cả Công Tắc",
    ["Switch off every enabled toggle in the feature tabs"] = "Tắt mọi công tắc đang bật trong các tab", ["Turn Off"] = "Tắt Ngay",
    ["Auto Save Config"] = "Tự Động Lưu Cấu Hình", ["Auto Load Config"] = "Tự Động Nạp Cấu Hình",
    ["New Config Name"] = "Tên Cấu Hình Mới", ["Create New Config"] = "Tạo Cấu Hình Mới",
    ["Save Config"] = "Lưu Cấu Hình Hiện Tại", ["Import Config Text"] = "Nhập Mã Văn Bản Cấu Hình",
    ["Destination"] = "Nơi Nhận Thông Báo", ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Notify Egg Finder Match"] = "Báo Khi Máy Dò Khớp Trứng", ["Post the egg Egg Finder stops hopping for"] = "Gửi cảnh báo quả trứng mà Máy Dò vừa tìm được",
    ["Notify Stolen Eggs"] = "Báo Khi Cướp Được Trứng", ["Post every egg you bring home"] = "Gửi thông báo mỗi khi bạn cướp thành công mang về nhà",
    ["None"] = "Không Chọn", ["Off"] = "Tắt", ["Filter features..."] = "Lọc tính năng...",
    ["Favorite"] = "Khóa Lại", ["Unfavorite"] = "Mở Khóa", ["Sell"] = "Bán",
    ["Mythic"] = "Thần Thoại (Mythic)", ["Secret"] = "Bí Ẩn (Secret)", ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)", ["Cosmic"] = "Vũ Trụ (Cosmic)", ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Window Minimized - Click bubble to restore"] = "Cửa sổ đã thu nhỏ - Bấm bong bóng để mở lại",
    ["Let's Chat!"] = "Trò Chuyện Nào!", ["Connecting to Global Script Chat..."] = "Đang kết nối chat thế giới...",
    ["Send"] = "Gửi", ["Live"] = "Trực Tiếp", ["Spoof anti cheat success!"] = "Đã vượt qua Anti-Cheat thành công!",
    ["Fetching..."] = "Đang Tải Dữ Liệu...", ["Loaded"] = "Đã Nạp Xong"
}

local MAP_PH = {
    -- Tabs
    ["Farm"] = "Farm", ["Player"] = "Manlalaro", ["Egg Finder"] = "Tagahanap ng Itlog",
    ["Predictor"] = "Tagahula", ["Progress"] = "Pag-unlad", ["Server"] = "Server",
    ["Misc"] = "Iba pa", ["Creator"] = "Lumikha", ["Discord"] = "Discord",
    ["Quick & Keys"] = "Mabilisang Susi", ["Settings"] = "Mga Setting", ["Config"] = "Config",
    
    -- === DR SCRAMBLE EVENT ===
    ["Dr Scramble Event"] = "Kaganapan ni Dr Scramble",
    ["Auto Hunt Drones"] = "Auto Hunt Drones",
    ["Kill drones during outbreaks for Samples and Drone Parts"] = "Patayin ang drones pag may outbreak para sa Samples at Parts",
    ["Hunt Priority"] = "Prayoridad sa Pag-hunt",
    ["Most HP First"] = "Pinakamaraming HP Muna",
    ["Drone Types"] = "Mga Uri ng Drone",
    ["Hunt Travel Method"] = "Paraan ng Paggalaw sa Pag-hunt",
    ["Teleport only to drones within 50 studs, farther ones are tweened"] = "Mag-teleport lang sa 50 studs, pag malayo ay mag-tween",
    ["Hunt Tween Speed"] = "Bilis ng Tween sa Pag-hunt",
    ["Only Until Vault Parts Found"] = "Hanggang Makuha ang Vault Parts Lang",
    ["Auto Collect Lost Parts"] = "Auto Kolekta ng Nawawalang Parts",
    ["Collect the 2 Lost Parts for the vault"] = "Kolektahin ang 2 Nawawalang Parts para sa vault",
    ["Auto Open Vault"] = "Auto Bukas ng Vault",
    ["Open the vault when all 5 parts are found"] = "Buksan ang vault pag nakuha na ang 5 parts",
    ["Auto Buy Scramble Shop"] = "Auto Bili sa Scramble Shop",
    ["Buy the picked items with Samples"] = "Bilhin ang napiling items gamit ang Samples",
    ["Scramble Shop Items"] = "Mga Items sa Scramble Shop",
    ["Keep Samples"] = "Itago ang Samples",
    ["Go To Secret Cave"] = "Pumunta sa Sikretong Kuweba",
    
    -- Breadcrumbs
    ["Farm Tab > Auto Steal"] = "Farm Tab > Auto Nakaw",
    ["Farm Tab > Auto Place Egg"] = "Farm Tab > Auto Lagay ng Itlog",
    ["Farm Tab > Auto Treadmill"] = "Farm Tab > Auto Treadmill",
    ["Farm Tab > Auto Hatch & Equip"] = "Farm Tab > Auto Pusa at Suot",
    ["Farm Tab > Auto Sell"] = "Farm Tab > Auto Benta",
    ["Farm Tab > Auto Fuse Machine"] = "Farm Tab > Auto Fuse Machine",
    ["Farm Tab > Auto Favorite"] = "Farm Tab > Auto Paborito",
    ["Farm Tab > Auto Rift & Boss"] = "Farm Tab > Auto Rift & Boss",
    ["Player Tab > ESP"] = "Player Tab > ESP (X-Ray)",
    ["Player Tab > Movement"] = "Player Tab > Paggalaw",
    ["Player Tab > Character"] = "Player Tab > Karakter",
    ["Egg Finder Tab > Egg Finder"] = "Egg Finder Tab > Tagahanap ng Itlog",
    ["Predictor Tab > Discord Webhook"] = "Predictor Tab > Discord Webhook",
    ["Predictor Tab > Egg Predictor"] = "Predictor Tab > Tagahula ng Itlog",
    ["Predictor Tab > Fuse Predictor"] = "Predictor Tab > Tagahula ng Pag-fuse",
    ["Progress Tab > Auto Progression"] = "Progress Tab > Awtomatikong Pag-unlad",
    ["Server Tab > Server"] = "Server Tab > Server",
    ["Misc Tab > Performance"] = "Misc Tab > Pagganap",
    ["Misc Tab > Utility"] = "Misc Tab > Kagamitan",
    ["Discord Tab > Creator Event"] = "Discord Tab > Kaganapan ng Lumikha",
    ["Discord Tab > Community"] = "Discord Tab > Komunidad",
    ["Quick & Keys Tab > Quick Access"] = "Keys Tab > Mabilisang Access",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Keys Tab > Quick Bar at Keybinds",
    ["Settings Tab > Interface"] = "Settings Tab > Interface",
    ["Settings Tab > Defaults"] = "Settings Tab > Mga Default",
    ["Config Tab > Config"] = "Config Tab > Config",
    ["Config Tab > Profiles"] = "Config Tab > Mga Profile",
    ["Config Tab > Import/Export"] = "Config Tab > Import/Export",
    ["Auto Steal"] = "Auto Nakaw", ["Target Areas"] = "Mga Target na Lugar",
    ["Min Rarity"] = "Pinakamababang Rarity", ["Steal eggs of the chosen rarity and every rarity above it"] = "Nakawin ang itlog ng napiling rarity pataas",
    ["Min Value To Steal"] = "Min na Halaga para Nakawin", ["Skip eggs worth less than this (0 = off)"] = "Laktawan kung mas mababa ang halaga (0 = off)",
    ["Target Specific Eggs"] = "I-target ang Tukoy na Itlog", ["Only steal these eggs (empty = all)"] = "Nakawin lang ang mga itlog na ito (walang laman = lahat)",
    ["Prioritize Rift Recipe Eggs"] = "Unahin ang Itlog para sa Rift", ["Steal eggs the Rift recipe needs first"] = "Unahing nakawin ang kailangan sa Rift",
    ["Steal Priority"] = "Prayoridad sa Pagnanakaw", ["Highest Value"] = "Pinakamataas na Halaga",
    ["Tween Speed"] = "Bilis ng Tween", ["Anti Guard V1"] = "Laban sa Guwardiya V1",
    ["Not recommended to use with Auto Steal"] = "Hindi inirerekomenda kasama ang Auto Nakaw",
    ["Auto Place Egg"] = "Auto Lagay ng Itlog", ["Place Egg Rule"] = "Panuntunan sa Paglagay",
    ["Place Egg Priority"] = "Prayoridad sa Paglagay", ["Biggest Size"] = "Pinakamalaki",
    ["Always"] = "Palagi", ["Auto Treadmill"] = "Auto Treadmill",
    ["Stay On Treadmill"] = "Manatili sa Treadmill", ["Re-mount the belt whenever the ride drops"] = "Sumakay muli kapag nahulog",
    ["Auto Hatch & Equip"] = "Auto Pusa & Suot", ["Auto Hatch"] = "Auto Pusa",
    ["Auto Equip Best"] = "Auto Isuot ang Pinakamaganda", ["Equip Best when a better pet appears"] = "Isuot ang pinakamaganda pag may bagong pet",
    ["Auto Sell"] = "Auto Benta", ["Auto Sell Pet"] = "Auto Benta ng Pet",
    ["Sell Pets Now"] = "Ibenta na ang Pets", ["Sell Pet Rule"] = "Panuntunan sa Pagbenta ng Pet",
    ["Which checks must pass to sell"] = "Mga kondisyon para makapagbenta", ["Rarity Only"] = "Rarity Lang",
    ["Pet Max Rarity"] = "Max Rarity ng Pet", ["Sell pets at or below this rarity"] = "Ibenta ang pets sa rarity na ito pababa",
    ["Pet Value Threshold"] = "Limitasyon ng Halaga ng Pet", ["Sell pets worth less than this (0 = off)"] = "Ibenta ang pets na mas mababa dito (0 = off)",
    ["Keep Mutated Pets"] = "Itago ang Mutated Pets", ["Never sell mutated pets"] = "Huwag ibenta ang mutated pets",
    ["Blacklist Sell Pets"] = "Blacklist sa Pagbenta ng Pet", ["These pets are never sold"] = "Hindi ibebenta ang mga pet na ito",
    ["Auto Sell Egg"] = "Auto Benta ng Itlog", ["Sell bag eggs matching the rules below"] = "Ibenta ang mga itlog sa bag ayon sa rules",
    ["Sell Eggs Now"] = "Ibenta na ang mga Itlog", ["Sell matching eggs once"] = "Ibenta ng isang beses ang tumutugmang itlog",
    ["Sell Egg Rule"] = "Panuntunan sa Pagbenta ng Itlog", ["Egg Max Rarity"] = "Max Rarity ng Itlog",
    ["Sell eggs at or below this rarity"] = "Ibenta ang itlog sa rarity na ito pababa", ["Egg Value Threshold"] = "Limitasyon ng Halaga ng Itlog",
    ["Sell eggs worth less than this (0 = off)"] = "Ibenta ang itlog na mas mababa dito (0 = off)", ["Keep Mutated Eggs"] = "Itago ang Mutated na Itlog",
    ["Never sell mutated eggs"] = "Huwag ibenta ang mutated na itlog", ["Blacklist Sell Eggs"] = "Blacklist sa Pagbenta ng Itlog",
    ["These eggs are never sold"] = "Hindi ibebenta ang mga itlog na ito",
    ["Auto Fuse Machine"] = "Auto Fuse Machine", ["Fuse 3 same pets into an egg, nonstop"] = "Pagsamahin ang 3 parehong pets, tuloy-tuloy",
    ["Fuse Priority Mode"] = "Prayoridad sa Pag-fuse", ["Lowest Rarity First"] = "Pinakamababang Rarity Muna",
    ["Pets To Use"] = "Gagamiting Pets", ["Lowest To Highest"] = "Mababa Hanggang Mataas",
    ["Max Rarity to Fuse"] = "Max Rarity na I-fuse", ["Specific Species to Fuse"] = "Tukoy na Uri na I-fuse",
    ["Only fuse these species (empty = all)"] = "I-fuse lang ang mga uri na ito (walang laman = lahat)", ["Skip Mutated Pets"] = "Laktawan ang Mutated Pets",
    ["Eject Incomplete Slots"] = "I-eject ang Hindi Kumpleto", ["Take out pets that can't make a set"] = "Kunin ang mga pets na hindi makabuo ng set",
    ["Auto Favorite"] = "Auto Paborito", ["Auto Favorite Pet"] = "Auto Paborito ng Pet",
    ["Favorite pets matching the rules below"] = "Paborito ang mga pet ayon sa rules sa ibaba", ["Favorite Pets Now"] = "Paborito na ang Pets",
    ["Favorite matching pets once"] = "Paborito ang tumutugmang pets minsan", ["Favorite Rule"] = "Panuntunan sa Paborito",
    ["Pass any check or all checks"] = "Pumasa sa isa o lahat ng kondisyon", ["Match All"] = "Itugma Lahat",
    ["Favorite Min Rarity"] = "Min Rarity ng Paborito", ["Favorite pets of the chosen rarity and every rarity above it"] = "Paboritong pets mula sa rarity na ito pataas",
    ["Favorite Mutations"] = "Paboritong Mutations", ["Mutation check (empty = skip)"] = "Pagsusuri sa mutation (walang laman = laktawan)",
    ["Favorite Min Value"] = "Min Value ng Paborito", ["Value check (0 = skip)"] = "Pagsusuri sa halaga (0 = laktawan)",
    ["Always Favorite Species"] = "Palaging Paboritong Uri", ["Always favorite these species"] = "Palaging paborito ang mga uring ito",
    ["Auto Favorite Equipped"] = "Auto Paborito ang Nakasuot", ["Keep equipped pets favorited"] = "Panatilihing paborito ang mga nakasuot na pets",
    ["Auto Unfavorite Equipped"] = "Auto Alisin Paborito sa Nakasuot", ["Unfavorite equipped pets not in the rules"] = "Alisin sa paborito kung wala sa rules",
    ["Favorite Equipped Now"] = "Paborito ang Nakasuot Ngayon", ["Favorite all equipped pets once"] = "Paborito ang lahat ng nakasuot minsan",
    ["Unfavorite Equipped Now"] = "Alisin Paborito sa Nakasuot Ngayon", ["Unfavorite all equipped pets once"] = "Alisin sa paborito ang lahat ng nakasuot minsan",
    ["Auto Rift & Boss"] = "Auto Rift at Boss", ["Auto Rift Sacrifice"] = "Auto Sakripisyo sa Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Ipasok ang 3 kinakailangang pets sa Rift", ["Auto Reroll Rift Recipe"] = "Auto Reroll sa Rift Recipe",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Mag-reroll kapag may kulang na pet at may free rerolls pa", ["Auto Claim Boss Mastery"] = "Auto Kunin ang Boss Mastery",
    ["Claim milestone rewards as soon as the kill count allows"] = "Kunin agad ang rewards pag sapat na ang kills", ["Auto Fight Boss"] = "Auto Labanan ang Boss",
    ["Auto Progression"] = "Awtomatikong Pag-unlad", ["Auto Buy Trail"] = "Awtomatikong Bumili ng Trail",
    ["Automatically buy available trails when affordable"] = "Awtomatikong bilhin ang trails kapag kaya na", ["Auto Upgrade Base"] = "Auto I-upgrade ang Base",
    ["Automatically upgrade base when money is available"] = "Awtomatikong i-upgrade ang base pag may pera", ["Auto Upgrade Treadmill"] = "Auto I-upgrade ang Treadmill",
    ["Automatically upgrade treadmill when money is available"] = "Awtomatikong i-upgrade ang treadmill pag may pera", ["Auto Claim"] = "Awtomatikong Kunin",
    ["Claim offline money & index rewards"] = "Kunin ang offline money at index rewards",
    ["ESP"] = "ESP (Tingnan sa Pader)", ["ESP Eggs"] = "ESP Itlog",
    ["ESP Fixed Size"] = "Nakapirming Laki ng ESP", ["ESP Own Base Eggs"] = "ESP Sariling Base na Itlog",
    ["Also show the eggs placed in your own base"] = "Ipakita rin ang mga itlog sa sariling base", ["ESP Min Rarity"] = "Min Rarity ng ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Ipakita ang itlog ng napiling rarity pataas", ["ESP Show Info"] = "Ipakita ang Info ng ESP",
    ["ESP Min Value"] = "Min na Halaga ng ESP", ["ESP Egg Size"] = "Laki ng ESP Itlog",
    ["ESP Guards"] = "ESP Guwardiya", ["ESP Guard Size"] = "Laki ng ESP Guwardiya",
    ["ESP Players"] = "ESP Manlalaro", ["ESP Player Info"] = "Info ng ESP Manlalaro",
    ["ESP Player Size"] = "Laki ng ESP Manlalaro", ["Movement"] = "Paggalaw",
    ["Speed Boost"] = "Pagpalakas ng Bilis", ["Boost Speed"] = "Bilis ng Boost",
    ["Infinite Jump"] = "Walang Hanggang Talon", ["Character"] = "Karakter",
    ["Anti Ragdoll"] = "Anti Ragdoll (Walang Tumba)", ["Anti Trap"] = "Anti Trap (Laban sa Bitag)",
    ["Traps from other players cannot catch you"] = "Hindi ka mahuhuli sa bitag ng ibang manlalaro", ["Instant Steal"] = "Mabilisang Nakaw (Instant Steal)",
    ["IDLE"] = "BAKANTE", ["Turn on Egg Finder to start hunting"] = "I-on ang Tagahanap ng Itlog para mag-hunt",
    ["Keep hopping servers until a matching egg is found"] = "Patuloy na lumipat ng server hanggang makahanap", ["Link To Auto Steal Filters"] = "I-link sa Auto Steal Filters",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Ibahagi ang isang set ng filter sa Auto Steal", ["Min Value To Find"] = "Min na Halaga na Hahanapin",
    ["Hop Only When Rarity Appears"] = "Lumipat Lang Kapag Lumabas ang Rarity", ["Wait for the chosen rarity to appear, then hop until night"] = "Hintaying lumabas ang rarity, bago lumipat",
    ["Rarity That Must Appear"] = "Rarity na Dapat Lumabas", ["Hop starts when this rarity or higher appears"] = "Magsisimula ang paglipat kapag lumabas ang rarity na ito",
    ["Hop Delay"] = "Pagkaantala sa Paglipat", ["Egg Predictor"] = "Tagahula ng Itlog",
    ["Sort By"] = "Ayusin Ayon Sa", ["Value"] = "Halaga",
    ["Preview Card"] = "Silipin ang Card", ["Search eggs..."] = "Maghanap ng itlog...",
    ["Tap an egg below to preview it"] = "I-tap ang itlog sa ibaba para silipin", ["In inventory"] = "Nasa inventory",
    ["Hold egg"] = "Hawak na itlog", ["Fuse Predictor"] = "Tagahula ng Fuse",
    ["Machine is empty"] = "Walang laman ang makina", ["Load 3 pets of the same species to see the result odds"] = "Maglagay ng 3 parehong pets para makita ang tsansa",
    ["Search"] = "Maghanap", ["Auto Load Script"] = "Auto I-load ang Script",
    ["Server Hop Mode"] = "Mode ng Paglipat ng Server", ["Least Players"] = "Pinakakaunting Manlalaro",
    ["Server Hop"] = "Lumipat ng Server", ["Job ID"] = "Job ID",
    ["Paste a server Job ID..."] = "I-paste ang Job ID ng server...", ["Join Job ID"] = "Sumali sa Job ID",
    ["Copy Current Job ID"] = "Kopyahin ang Job ID", ["Rejoin Server"] = "Muling Sumali sa Server",
    ["Join"] = "Sumali", ["Copy"] = "Kopyahin", ["Rejoin"] = "Muling Sumali", ["Hop"] = "Lumipat",
    ["Performance"] = "Pagganap", ["FPS Cap"] = "Limitasyon ng FPS",
    ["Optimizer"] = "Optimizer", ["Strip shadows, textures and effects for the highest FPS"] = "Tanggalin ang anino, textures, at effects",
    ["FPS and Ping"] = "FPS at Ping", ["FPS and Ping Size"] = "Laki ng FPS at Ping",
    ["Utility"] = "Kagamitan", ["Anti AFK"] = "Laban sa AFK",
    ["Creator Event"] = "Kaganapan ng Lumikha", ["INVITE LINK"] = "LINK NG IMBITASYON",
    ["Copy Link"] = "Kopyahin ang Link", ["WHAT YOU GET"] = "ANO ANG MAKUHA MO",
    ["New Scripts & Updates"] = "Mga Bagong Script at Updates", ["Patch notes and new game scripts are posted there first."] = "Mga patch notes at bagong script ay naka-post doon una.",
    ["Giveaways"] = "Mga Giveaway", ["Member giveaways and events are announced in the server."] = "Mga giveaway para sa miyembro ay ina-announce sa server.",
    ["Support"] = "Suporta", ["Ask for help, report bugs and get answers from the team."] = "Humingi ng tulong, mag-report ng bugs at kumuha ng sagot.",
    ["Suggestions"] = "Mga Mungkahi", ["Request features and vote on what gets added next."] = "Humiling ng features at bumoto sa susunod na idadagdag.",
    ["Paste the copied link into your browser or the Discord app to join."] = "I-paste ang link sa browser o Discord app para sumali.",
    ["Copy Discord Link"] = "Kopyahin ang Discord Link", ["Click"] = "I-click",
    ["Quick Access"] = "Mabilisang Pag-access", ["Show Quick Bars"] = "Ipakita ang Mabilisang Bars",
    ["Floating quick bars; drag a header to move one"] = "Lumulutang na quick bars; i-drag ang header para ilipat", ["Visible Quick Bars"] = "Mga Nakikitang Quick Bars",
    ["Quick Bar Size"] = "Laki ng Quick Bar", ["Quick Bar & Keybinds"] = "Mabilisang Bar at Keybinds",
    ["Reset Quick Access"] = "I-reset ang Mabilisang Pag-access", ["Restore default items, bars and positions"] = "Ibalik sa default ang mga items, bars, at posisyon",
    ["Reset Keybinds"] = "I-reset ang Keybinds", ["Restore the defaults set in code"] = "Ibalik sa default ang naka-set sa code",
    ["Reset"] = "I-reset", ["Interface"] = "Interface", ["UI Size"] = "Laki ng UI",
    ["Scales the main window; the corner grip does the same by hand"] = "Papalakihin ang main window; pwedeng gawin gamit ang grip",
    ["Notifications"] = "Mga Notipikasyon", ["Show notification cards; turning this off hides every notify"] = "Ipakita ang notipikasyon; itatago ang lahat kapag naka-off",
    ["Open On Launch"] = "Buksan Kapag Nagsimula", ["Open the UI automatically when the script starts"] = "Awtomatikong buksan ang UI pag-start ng script",
    ["Defaults"] = "Mga Default", ["Reset to Defaults"] = "I-reset sa Mga Default",
    ["Reset every feature to its built-in default"] = "I-reset ang lahat ng feature sa orihinal na default nito", ["Turn Off All Toggles"] = "I-off Lahat ng Toggles",
    ["Switch off every enabled toggle in the feature tabs"] = "I-off lahat ng nakabukas na toggle sa mga tab", ["Turn Off"] = "I-off Ngayon",
    ["Auto Save Config"] = "Auto I-save ang Config", ["Auto Load Config"] = "Auto I-load ang Config",
    ["New Config Name"] = "Pangalan ng Bagong Config", ["Create New Config"] = "Gumawa ng Bagong Config",
    ["Save Config"] = "I-save ang Config", ["Import Config Text"] = "I-import ang Teksto ng Config",
    ["Destination"] = "Destinasyon", ["Webhook URL"] = "Webhook URL",
    ["Notify Egg Finder Match"] = "I-notify ang Tugma ng Tagahanap ng Itlog", ["Post the egg Egg Finder stops hopping for"] = "I-post ang itlog na dahilan ng paghinto sa paglipat",
    ["Notify Stolen Eggs"] = "I-notify ang Nakaw na Itlog", ["Post every egg you bring home"] = "I-post ang bawat itlog na naiuwi mo",
    ["None"] = "Wala", ["Off"] = "Naka-off", ["Filter features..."] = "I-filter ang mga features...",
    ["Favorite"] = "Paborito", ["Unfavorite"] = "Alisin sa Paborito", ["Sell"] = "Ibenta",
    ["Mythic"] = "Mythic", ["Secret"] = "Secret", ["Divine"] = "Divine",
    ["Eternal"] = "Eternal", ["Cosmic"] = "Cosmic", ["Legendary"] = "Legendary",
    ["Match All"] = "Itugma Lahat", ["Rarity Only"] = "Rarity Lang",
    ["Window Minimized - Click bubble to restore"] = "Na-minimize ang window - I-click ang bubble para ibalik",
    ["Let's Chat!"] = "Mag-chat na tayo!", ["Connecting to Global Script Chat..."] = "Kumokonekta sa Global Script Chat...",
    ["Send"] = "Ipadala", ["Live"] = "Live", ["Spoof anti cheat success!"] = "Matagumpay na na-spoof ang anti cheat!",
    ["Fetching..."] = "Kinukuha ang data...", ["Loaded"] = "Na-load Na"
}

local MAP_ID = {
    -- Tabs
    ["Farm"] = "Farming", ["Player"] = "Pemain", ["Egg Finder"] = "Pencari Telur",
    ["Predictor"] = "Prediktor", ["Progress"] = "Kemajuan", ["Server"] = "Server",
    ["Misc"] = "Lainnya", ["Creator"] = "Pembuat", ["Discord"] = "Discord",
    ["Quick & Keys"] = "Akses Cepat", ["Settings"] = "Pengaturan", ["Config"] = "Konfigurasi",
    
    -- === DR SCRAMBLE EVENT ===
    ["Dr Scramble Event"] = "Event Dr Scramble",
    ["Auto Hunt Drones"] = "Auto Hunt Drone",
    ["Kill drones during outbreaks for Samples and Drone Parts"] = "Bunuh drone saat wabah untuk Sampel dan Suku Cadang",
    ["Hunt Priority"] = "Prioritas Berburu",
    ["Most HP First"] = "HP Terbanyak Dulu",
    ["Drone Types"] = "Jenis Drone",
    ["Hunt Travel Method"] = "Metode Gerak Berburu",
    ["Teleport only to drones within 50 studs, farther ones are tweened"] = "Teleport hanya dalam 50 stud, yang jauh pakai tween",
    ["Hunt Tween Speed"] = "Kecepatan Tween Berburu",
    ["Only Until Vault Parts Found"] = "Hanya Sampai Bagian Brankas Ketemu",
    ["Auto Collect Lost Parts"] = "Auto Kumpul Suku Cadang Hilang",
    ["Collect the 2 Lost Parts for the vault"] = "Kumpulkan 2 Suku Cadang Hilang untuk brankas",
    ["Auto Open Vault"] = "Auto Buka Brankas",
    ["Open the vault when all 5 parts are found"] = "Buka brankas saat 5 bagian ketemu",
    ["Auto Buy Scramble Shop"] = "Auto Beli di Scramble Shop",
    ["Buy the picked items with Samples"] = "Beli item yang dipilih pakai Sampel",
    ["Scramble Shop Items"] = "Item Scramble Shop",
    ["Keep Samples"] = "Simpan Sampel",
    ["Go To Secret Cave"] = "Pergi ke Gua Rahasia",
    
    -- Breadcrumbs
    ["Farm Tab > Auto Steal"] = "Tab Farm > Auto Curi",
    ["Farm Tab > Auto Place Egg"] = "Tab Farm > Auto Taruh Telur",
    ["Farm Tab > Auto Treadmill"] = "Tab Farm > Auto Treadmill",
    ["Farm Tab > Auto Hatch & Equip"] = "Tab Farm > Auto Tetas & Pakai",
    ["Farm Tab > Auto Sell"] = "Tab Farm > Auto Jual",
    ["Farm Tab > Auto Fuse Machine"] = "Tab Farm > Auto Mesin Fuse",
    ["Farm Tab > Auto Favorite"] = "Tab Farm > Auto Favorit",
    ["Farm Tab > Auto Rift & Boss"] = "Tab Farm > Auto Rift & Boss",
    ["Player Tab > ESP"] = "Tab Pemain > ESP (Tembus Pandang)",
    ["Player Tab > Movement"] = "Tab Pemain > Gerakan",
    ["Player Tab > Character"] = "Tab Pemain > Karakter",
    ["Egg Finder Tab > Egg Finder"] = "Tab Cari Telur > Pencari Telur",
    ["Predictor Tab > Discord Webhook"] = "Tab Prediksi > Webhook Discord",
    ["Predictor Tab > Egg Predictor"] = "Tab Prediksi > Prediksi Telur",
    ["Predictor Tab > Fuse Predictor"] = "Tab Prediksi > Prediksi Fuse",
    ["Progress Tab > Auto Progression"] = "Tab Kemajuan > Progres Otomatis",
    ["Server Tab > Server"] = "Tab Server > Server",
    ["Misc Tab > Performance"] = "Tab Lain > Performa",
    ["Misc Tab > Utility"] = "Tab Lain > Utilitas",
    ["Discord Tab > Creator Event"] = "Tab Discord > Event Kreator",
    ["Discord Tab > Community"] = "Tab Discord > Komunitas",
    ["Quick & Keys Tab > Quick Access"] = "Tab Shortcut > Akses Cepat",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Tab Shortcut > Bar Cepat & Tombol",
    ["Settings Tab > Interface"] = "Tab Setting > Antarmuka",
    ["Settings Tab > Defaults"] = "Tab Setting > Bawaan",
    ["Config Tab > Config"] = "Tab Config > Konfigurasi",
    ["Config Tab > Profiles"] = "Tab Config > Profil",
    ["Config Tab > Import/Export"] = "Tab Config > Impor/Ekspor",
    ["Auto Steal"] = "Auto Curi", ["Target Areas"] = "Area Target",
    ["Min Rarity"] = "Rarity Minimum", ["Steal eggs of the chosen rarity and every rarity above it"] = "Curi telur dari rarity yang dipilih ke atas",
    ["Min Value To Steal"] = "Nilai Minimum Curi", ["Skip eggs worth less than this (0 = off)"] = "Lewati telur yang lebih murah dari ini (0 = Mati)",
    ["Target Specific Eggs"] = "Target Telur Spesifik", ["Only steal these eggs (empty = all)"] = "Hanya curi telur ini (kosong = semua)",
    ["Prioritize Rift Recipe Eggs"] = "Prioritas Telur Resep Rift", ["Steal eggs the Rift recipe needs first"] = "Curi telur yang dibutuhkan resep Rift dulu",
    ["Steal Priority"] = "Prioritas Mencuri", ["Highest Value"] = "Nilai Tertinggi",
    ["Tween Speed"] = "Kecepatan Tween", ["Anti Guard V1"] = "Anti Penjaga V1",
    ["Not recommended to use with Auto Steal"] = "Tidak disarankan dipakai dengan Auto Curi",
    ["Auto Place Egg"] = "Auto Taruh Telur", ["Place Egg Rule"] = "Aturan Taruh Telur",
    ["Place Egg Priority"] = "Prioritas Taruh Telur", ["Biggest Size"] = "Ukuran Terbesar",
    ["Always"] = "Selalu", ["Auto Treadmill"] = "Auto Treadmill",
    ["Stay On Treadmill"] = "Tetap di Treadmill", ["Re-mount the belt whenever the ride drops"] = "Naik lagi jika terjatuh",
    ["Auto Hatch & Equip"] = "Auto Tetas & Pakai", ["Auto Hatch"] = "Auto Tetas",
    ["Auto Equip Best"] = "Auto Pakai Terbaik", ["Equip Best when a better pet appears"] = "Otomatis pakai jika ada pet lebih baik",
    ["Auto Sell"] = "Auto Jual", ["Auto Sell Pet"] = "Auto Jual Pet",
    ["Sell Pets Now"] = "Jual Pet Sekarang", ["Sell Pet Rule"] = "Aturan Jual Pet",
    ["Which checks must pass to sell"] = "Syarat yang harus dipenuhi untuk jual", ["Rarity Only"] = "Hanya Rarity",
    ["Pet Max Rarity"] = "Rarity Maks Pet", ["Sell pets at or below this rarity"] = "Jual pet dari rarity ini ke bawah",
    ["Pet Value Threshold"] = "Batas Nilai Pet", ["Sell pets worth less than this (0 = off)"] = "Jual pet yang lebih murah dari ini (0 = Mati)",
    ["Keep Mutated Pets"] = "Simpan Pet Mutasi", ["Never sell mutated pets"] = "Jangan pernah jual pet mutasi",
    ["Blacklist Sell Pets"] = "Daftar Hitam Jual Pet", ["These pets are never sold"] = "Pet ini tidak akan pernah dijual",
    ["Auto Sell Egg"] = "Auto Jual Telur", ["Sell bag eggs matching the rules below"] = "Jual telur di tas sesuai aturan di bawah",
    ["Sell Eggs Now"] = "Jual Telur Sekarang", ["Sell matching eggs once"] = "Jual telur yang cocok sekali saja",
    ["Sell Egg Rule"] = "Aturan Jual Telur", ["Egg Max Rarity"] = "Rarity Maks Telur",
    ["Sell eggs at or below this rarity"] = "Jual telur dari rarity ini ke bawah", ["Egg Value Threshold"] = "Batas Nilai Telur",
    ["Sell eggs worth less than this (0 = off)"] = "Jual telur yang lebih murah dari ini (0 = Mati)", ["Keep Mutated Eggs"] = "Simpan Telur Mutasi",
    ["Never sell mutated eggs"] = "Jangan pernah jual telur mutasi", ["Blacklist Sell Eggs"] = "Daftar Hitam Jual Telur",
    ["These eggs are never sold"] = "Telur ini tidak akan pernah dijual",
    ["Auto Fuse Machine"] = "Auto Mesin Fuse", ["Fuse 3 same pets into an egg, nonstop"] = "Gabungkan 3 pet sama jadi telur, nonstop",
    ["Fuse Priority Mode"] = "Prioritas Fuse", ["Lowest Rarity First"] = "Rarity Terendah Dulu",
    ["Pets To Use"] = "Pet yang Dipakai", ["Lowest To Highest"] = "Terendah ke Tertinggi",
    ["Max Rarity to Fuse"] = "Rarity Maks untuk Fuse", ["Specific Species to Fuse"] = "Spesies Khusus untuk Fuse",
    ["Only fuse these species (empty = all)"] = "Hanya fuse spesies ini (kosong = semua)", ["Skip Mutated Pets"] = "Lewati Pet Mutasi",
    ["Eject Incomplete Slots"] = "Keluarkan Slot Tidak Lengkap", ["Take out pets that can't make a set"] = "Keluarkan pet yang tidak bisa jadi 1 set",
    ["Auto Favorite"] = "Auto Favorit", ["Auto Favorite Pet"] = "Auto Favorit Pet",
    ["Favorite pets matching the rules below"] = "Favoritkan pet sesuai aturan di bawah", ["Favorite Pets Now"] = "Favoritkan Pet Sekarang",
    ["Favorite matching pets once"] = "Favoritkan pet yang cocok sekali saja", ["Favorite Rule"] = "Aturan Favorit",
    ["Pass any check or all checks"] = "Penuhi salah satu atau semua syarat", ["Match All"] = "Cocok Semua",
    ["Favorite Min Rarity"] = "Rarity Min Favorit", ["Favorite pets of the chosen rarity and every rarity above it"] = "Favoritkan pet dari rarity ini ke atas",
    ["Favorite Mutations"] = "Favorit Mutasi", ["Mutation check (empty = skip)"] = "Cek mutasi (kosong = lewati)",
    ["Favorite Min Value"] = "Nilai Min Favorit", ["Value check (0 = skip)"] = "Cek nilai (0 = lewati)",
    ["Always Favorite Species"] = "Selalu Favoritkan Spesies", ["Always favorite these species"] = "Selalu favoritkan spesies ini",
    ["Auto Favorite Equipped"] = "Auto Favorit yang Dipakai", ["Keep equipped pets favorited"] = "Tetap favoritkan pet yang sedang dipakai",
    ["Auto Unfavorite Equipped"] = "Auto Hapus Favorit yang Dipakai", ["Unfavorite equipped pets not in the rules"] = "Hapus favorit jika tidak ada di aturan",
    ["Favorite Equipped Now"] = "Favoritkan yang Dipakai Sekarang", ["Favorite all equipped pets once"] = "Favoritkan semua pet yang dipakai sekali saja",
    ["Unfavorite Equipped Now"] = "Hapus Favorit yang Dipakai Sekarang", ["Unfavorite all equipped pets once"] = "Hapus favorit semua pet yang dipakai sekali",
    ["Auto Rift & Boss"] = "Auto Rift & Boss", ["Auto Rift Sacrifice"] = "Auto Pengorbanan Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Masukkan 3 pet yang diminta ke mesin Rift", ["Auto Reroll Rift Recipe"] = "Auto Reroll Resep Rift",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Ganti resep jika pet kurang dan masih ada reroll gratis", ["Auto Claim Boss Mastery"] = "Auto Ambil Mastery Boss",
    ["Claim milestone rewards as soon as the kill count allows"] = "Ambil hadiah pencapaian setelah jumlah kill cukup", ["Auto Fight Boss"] = "Auto Lawan Boss",
    ["Auto Progression"] = "Kemajuan Otomatis", ["Auto Buy Trail"] = "Auto Beli Efek Jejak",
    ["Automatically buy available trails when affordable"] = "Otomatis beli efek jejak jika uang cukup", ["Auto Upgrade Base"] = "Auto Upgrade Markas",
    ["Automatically upgrade markas when money is available"] = "Otomatis upgrade markas jika uang cukup", ["Auto Upgrade Treadmill"] = "Auto Upgrade Treadmill",
    ["Automatically upgrade treadmill when money is available"] = "Otomatis upgrade treadmill jika uang cukup", ["Auto Claim"] = "Auto Ambil Hadiah",
    ["Claim offline money & index rewards"] = "Ambil uang offline & hadiah indeks",
    ["ESP"] = "ESP (Tembus Pandang)", ["ESP Eggs"] = "ESP Telur",
    ["ESP Fixed Size"] = "Ukuran ESP Tetap", ["ESP Own Base Eggs"] = "ESP Telur di Markas Sendiri",
    ["Also show the eggs placed in your own base"] = "Tampilkan juga telur di markasmu", ["ESP Min Rarity"] = "Rarity Min ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Tampilkan telur dari rarity ini ke atas", ["ESP Show Info"] = "Tampilkan Info ESP",
    ["ESP Min Value"] = "Nilai Min ESP", ["ESP Egg Size"] = "Ukuran ESP Telur",
    ["ESP Guards"] = "ESP Penjaga", ["ESP Guard Size"] = "Ukuran ESP Penjaga",
    ["ESP Players"] = "ESP Pemain", ["ESP Player Info"] = "Info ESP Pemain",
    ["ESP Player Size"] = "Ukuran ESP Pemain", ["Movement"] = "Gerakan",
    ["Speed Boost"] = "Peningkatan Kecepatan", ["Boost Speed"] = "Kecepatan Tambahan",
    ["Infinite Jump"] = "Lompat Tak Terbatas", ["Character"] = "Karakter",
    ["Anti Ragdoll"] = "Anti Jatuh (Ragdoll)", ["Anti Trap"] = "Anti Perangkap",
    ["Traps from other players cannot catch you"] = "Perangkap pemain lain tidak bisa menangkapmu", ["Instant Steal"] = "Curi Instan",
    ["IDLE"] = "DIAM", ["Turn on Egg Finder to start hunting"] = "Nyalakan Pencari Telur untuk mulai berburu",
    ["Keep hopping servers until a matching egg is found"] = "Pindah server terus sampai nemu telur yang cocok", ["Link To Auto Steal Filters"] = "Hubungkan ke Filter Auto Curi",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Pakai filter yang sama dengan Auto Curi", ["Min Value To Find"] = "Nilai Min Pencarian",
    ["Hop Only When Rarity Appears"] = "Pindah Hanya Jika Rarity Muncul", ["Wait for the chosen rarity to appear, then hop until night"] = "Tunggu rarity muncul, lalu pindah server sampai malam",
    ["Rarity That Must Appear"] = "Rarity Wajib Muncul", ["Hop starts when this rarity or higher appears"] = "Mulai pindah saat rarity ini muncul",
    ["Hop Delay"] = "Jeda Pindah Server", ["Egg Predictor"] = "Prediktor Telur",
    ["Sort By"] = "Urutkan Berdasarkan", ["Value"] = "Nilai",
    ["Preview Card"] = "Pratinjau Kartu", ["Search eggs..."] = "Cari telur...",
    ["Tap an egg below to preview it"] = "Sentuh telur di bawah untuk melihat detail", ["In inventory"] = "Di inventaris",
    ["Hold egg"] = "Sedang dipegang", ["Fuse Predictor"] = "Prediktor Fuse",
    ["Machine is empty"] = "Mesin kosong", ["Load 3 pets of the same species to see the result odds"] = "Masukkan 3 pet spesies sama untuk lihat peluang hasil",
    ["Search"] = "Cari", ["Auto Load Script"] = "Auto Jalankan Script",
    ["Server Hop Mode"] = "Mode Pindah Server", ["Least Players"] = "Pemain Paling Sedikit",
    ["Server Hop"] = "Pindah Server", ["Job ID"] = "ID Server",
    ["Paste a server Job ID..."] = "Tempel ID server di sini...", ["Join Job ID"] = "Masuk via ID",
    ["Copy Current Job ID"] = "Salin ID Server Saat Ini", ["Rejoin Server"] = "Masuk Ulang Server",
    ["Join"] = "Masuk", ["Copy"] = "Salin", ["Rejoin"] = "Masuk Ulang", ["Hop"] = "Pindah",
    ["Performance"] = "Performa", ["FPS Cap"] = "Batas FPS",
    ["Optimizer"] = "Pengoptimal Maksimal", ["Strip shadows, textures and effects for the highest FPS"] = "Hapus bayangan, tekstur, dan efek demi FPS tinggi",
    ["FPS and Ping"] = "FPS dan Ping", ["FPS and Ping Size"] = "Ukuran Teks FPS & Ping",
    ["Utility"] = "Utilitas", ["Anti AFK"] = "Anti AFK",
    ["Creator Event"] = "Event Kreator", ["INVITE LINK"] = "LINK UNDANGAN",
    ["Copy Link"] = "Salin Link", ["WHAT YOU GET"] = "APA YANG ANDA DAPATKAN",
    ["New Scripts & Updates"] = "Script & Update Baru", ["Patch notes and new game scripts are posted there first."] = "Catatan update & script baru diposting di sana duluan.",
    ["Giveaways"] = "Bagi-Bagi Hadiah (Giveaway)", ["Member giveaways and events are announced in the server."] = "Giveaway member & event diumumkan di server.",
    ["Support"] = "Dukungan", ["Ask for help, report bugs and get answers from the team."] = "Minta bantuan, lapor bug, dan dapatkan jawaban.",
    ["Suggestions"] = "Saran", ["Request features and vote on what gets added next."] = "Minta fitur & voting update selanjutnya.",
    ["Paste the copied link into your browser or the Discord app to join."] = "Tempel link di browser atau Discord untuk bergabung.",
    ["Copy Discord Link"] = "Salin Link Discord", ["Click"] = "Klik",
    ["Quick Access"] = "Akses Cepat", ["Show Quick Bars"] = "Tampilkan Bar Cepat",
    ["Floating quick bars; drag a header to move one"] = "Bar melayang; geser judul untuk memindahkan", ["Visible Quick Bars"] = "Bar Cepat Aktif",
    ["Quick Bar Size"] = "Ukuran Bar Cepat", ["Quick Bar & Keybinds"] = "Bar Cepat & Tombol Shortcut",
    ["Reset Quick Access"] = "Reset Akses Cepat", ["Restore default items, bars and positions"] = "Kembalikan posisi & item bawaan",
    ["Reset Keybinds"] = "Reset Shortcut", ["Restore the defaults set in code"] = "Kembalikan tombol bawaan script",
    ["Reset"] = "Reset", ["Interface"] = "Antarmuka", ["UI Size"] = "Ukuran UI",
    ["Scales the main window; the corner grip does the same by hand"] = "Ubah ukuran jendela; geser pojok untuk manual",
    ["Notifications"] = "Notifikasi", ["Show notification cards; turning this off hides every notify"] = "Tampilkan notifikasi; matikan untuk sembunyikan semua",
    ["Open On Launch"] = "Buka Saat Dijalankan", ["Open the UI automatically when the script starts"] = "Buka menu otomatis saat script aktif",
    ["Defaults"] = "Bawaan", ["Reset to Defaults"] = "Kembalikan ke Bawaan",
    ["Reset every feature to its built-in default"] = "Reset semua fitur ke pengaturan asli", ["Turn Off All Toggles"] = "Matikan Semua Tombol",
    ["Switch off every enabled toggle in the feature tabs"] = "Matikan semua fitur yang sedang aktif", ["Turn Off"] = "Matikan",
    ["Auto Save Config"] = "Auto Simpan Config", ["Auto Load Config"] = "Auto Muat Config",
    ["New Config Name"] = "Nama Config Baru", ["Create New Config"] = "Buat Config Baru",
    ["Save Config"] = "Simpan Config", ["Import Config Text"] = "Impor Teks Config",
    ["Destination"] = "Tujuan", ["Webhook URL"] = "URL Webhook",
    ["Notify Egg Finder Match"] = "Notif Pencari Telur Cocok", ["Post the egg Egg Finder stops hopping for"] = "Kirim info telur yang baru ditemukan",
    ["Notify Stolen Eggs"] = "Notif Telur Berhasil Dicuri", ["Post every egg you bring home"] = "Kirim info tiap telur yang dibawa pulang",
    ["None"] = "Tidak Ada", ["Off"] = "Mati", ["Filter features..."] = "Filter fitur...",
    ["Favorite"] = "Favorit", ["Unfavorite"] = "Hapus Favorit", ["Sell"] = "Jual",
    ["Mythic"] = "Mythic", ["Secret"] = "Secret", ["Divine"] = "Divine",
    ["Eternal"] = "Eternal", ["Cosmic"] = "Cosmic", ["Legendary"] = "Legendary",
    ["Match All"] = "Cocok Semua", ["Rarity Only"] = "Hanya Rarity",
    ["Window Minimized - Click bubble to restore"] = "Jendela diminimalkan - Klik gelembung untuk membuka",
    ["Let's Chat!"] = "Ayo Chat!", ["Connecting to Global Script Chat..."] = "Menghubungkan ke Chat Global...",
    ["Send"] = "Kirim", ["Live"] = "Langsung", ["Spoof anti cheat success!"] = "Bypass Anti-Cheat sukses!",
    ["Fetching..."] = "Mengambil data...", ["Loaded"] = "Selesai Dimuat"
}

-- Mẫu Regex xử lý chuỗi động đa ngôn ngữ
local DYNAMIC_PATTERNS = {
    -- Regex đếm số lượng Mẫu Vật & Phụ Tùng sự kiện Dr Scramble
    {
        pattern = "^Samples (%d+) %- Lost (%d+)/(%d+) Drone (.-) %- Outbreak in (.-)$",
        format  = function(lang, s, l1, l2, d, t) 
            if lang == "VI" then return "Mẫu vật " .. s .. " - Đã rơi " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Bùng phát sau " .. t
            elseif lang == "PH" then return "Samples " .. s .. " - Nawala " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Outbreak sa " .. t
            elseif lang == "ID" then return "Sampel " .. s .. " - Hilang " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Wabah dlm " .. t
            end return "Samples " .. s .. " - Lost " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Outbreak in " .. t
        end
    },
    {
        pattern = "^Lost Parts on map (%d+)/(%d+) %- Collected (%d+)/(%d+)$",
        format  = function(lang, m1, m2, c1, c2) 
            if lang == "VI" then return "Phụ Tùng Rơi trên map " .. m1 .. "/" .. m2 .. " - Đã nhặt " .. c1 .. "/" .. c2
            elseif lang == "PH" then return "Nawawalang Parts sa map " .. m1 .. "/" .. m2 .. " - Nakolekta " .. c1 .. "/" .. c2
            elseif lang == "ID" then return "Suku Cadang Hilang di map " .. m1 .. "/" .. m2 .. " - Terkumpul " .. c1 .. "/" .. c2
            end return "Lost Parts on map " .. m1 .. "/" .. m2 .. " - Collected " .. c1 .. "/" .. c2
        end
    },
    {
        pattern = "^(%d+) selected$",
        format  = function(lang, count) 
            if lang == "VI" then return "Đã chọn " .. count 
            elseif lang == "PH" then return "Napili " .. count 
            elseif lang == "ID" then return "Terpilih " .. count 
            end return count .. " selected" 
        end
    },
    {
        pattern = "^IN INVENTORY %((%d+)%)$",
        format  = function(lang, count) 
            if lang == "VI" then return "TRONG TÚI ĐỒ (" .. count .. ")"
            elseif lang == "PH" then return "NASA INVENTORY (" .. count .. ")"
            elseif lang == "ID" then return "DI INVENTARIS (" .. count .. ")"
            end return "IN INVENTORY (" .. count .. ")"
        end
    },
    {
        pattern = "^Eggs placed (%d+)%/(%d+) %- (%d+)%/(%d+) pets equipped, (%d+) in bag$",
        format  = function(lang, e1, e2, p1, p2, b1) 
            if lang == "VI" then return "Đã đặt " .. e1 .. "/" .. e2 .. " trứng - " .. p1 .. "/" .. p2 .. " thú trang bị, " .. b1 .. " trong túi"
            elseif lang == "PH" then return "Nailagay na itlog " .. e1 .. "/" .. e2 .. " - " .. p1 .. "/" .. p2 .. " pets ang gamit, " .. b1 .. " sa bag"
            elseif lang == "ID" then return "Ditaruh " .. e1 .. "/" .. e2 .. " telur - " .. p1 .. "/" .. p2 .. " pet dipakai, " .. b1 .. " di tas"
            end return "Eggs placed " .. e1 .. "/" .. e2 .. " - " .. p1 .. "/" .. p2 .. " pets equipped, " .. b1 .. " in bag"
        end
    },
    {
        pattern = "^Pet matches %- (%d+) pets for %$(.-)$",
        format  = function(lang, count, val) 
            if lang == "VI" then return "Thú khớp lệnh - " .. count .. " thú, tổng giá $" .. val
            elseif lang == "PH" then return "Tumugma ang pet - " .. count .. " pets sa halagang $" .. val
            elseif lang == "ID" then return "Pet cocok - " .. count .. " pet harga $" .. val
            end return "Pet matches - " .. count .. " pets for $" .. val
        end
    },
    {
        pattern = "^Egg matches %- (%d+) eggs for %$(.-)$",
        format  = function(lang, count, val) 
            if lang == "VI" then return "Trứng khớp lệnh - " .. count .. " trứng, tổng giá $" .. val
            elseif lang == "PH" then return "Tumugma ang itlog - " .. count .. " itlog sa halagang $" .. val
            elseif lang == "ID" then return "Telur cocok - " .. count .. " telur harga $" .. val
            end return "Egg matches - " .. count .. " eggs for $" .. val
        end
    },
    {
        pattern = "^Next fuse %- (%d+) (.-) for %$(.-)$",
        format  = function(lang, count, name, val) 
            if lang == "VI" then return "Ghép tiếp theo - " .. count .. " " .. name .. " tốn $" .. val
            elseif lang == "PH" then return "Susunod na fuse - " .. count .. " " .. name .. " halaga $" .. val
            elseif lang == "ID" then return "Fuse selanjutnya - " .. count .. " " .. name .. " biaya $" .. val
            end return "Next fuse - " .. count .. " " .. name .. " for $" .. val
        end
    },
    {
        pattern = "^Favorite matches %- (%d+) pets, (%d+) to mark %| (%d+) favorited$",
        format  = function(lang, mCount, mark, fav) 
            if lang == "VI" then return "Khớp khóa thú - " .. mCount .. " con, " .. mark .. " cần khóa | " .. fav .. " đã khóa"
            elseif lang == "PH" then return "Tumugma ang paborito - " .. mCount .. " pets, " .. mark .. " i-mark | " .. fav .. " paborito na"
            elseif lang == "ID" then return "Favorit cocok - " .. mCount .. " pet, " .. mark .. " ditandai | " .. fav .. " favorit"
            end return "Favorite matches - " .. mCount .. " pets, " .. mark .. " to mark | " .. fav .. " favorited"
        end
    },
    {
        pattern = "^Riftborn %- needs (.-) %- pity (%d+)%/(%d+) %- free rerolls (%d+) %- rotates in (.-) %- boss portal (.-)$",
        format  = function(lang, needs, pity1, pity2, reroll, timeStr, status) 
            if lang == "VI" then return "Riftborn - Cần: " .. needs .. " - Bảo hiểm: " .. pity1 .. "/" .. pity2 .. " - Quay free: " .. reroll .. " - Đổi sau " .. timeStr .. " - Cổng Boss: " .. (status == "closed" and "Đóng" or "Mở")
            elseif lang == "PH" then return "Riftborn - Kailangan: " .. needs .. " - Awa: " .. pity1 .. "/" .. pity2 .. " - Libreng reroll: " .. reroll .. " - Iikot sa " .. timeStr .. " - Portal ng boss: " .. (status == "closed" and "Sarado" or "Bukas")
            elseif lang == "ID" then return "Riftborn - Butuh: " .. needs .. " - Awa: " .. pity1 .. "/" .. pity2 .. " - Reroll gratis: " .. reroll .. " - Ganti dlm " .. timeStr .. " - Portal Boss: " .. (status == "closed" and "Tutup" or "Buka")
            end return "Riftborn - needs " .. needs .. " - pity " .. pity1 .. "/" .. pity2 .. " - free rerolls " .. reroll .. " - rotates in " .. timeStr .. " - boss portal " .. status
        end
    },
    {
        pattern = "^(%d+) eggs %- (%d+) ready %- (%d+) growing %- (%d+) in bag %- Total (.-)$",
        format  = function(lang, e1, r1, g1, b1, t1) 
            if lang == "VI" then return e1 .. " trứng - " .. r1 .. " xong - " .. g1 .. " đang lớn - " .. b1 .. " trong túi - Tổng " .. t1
            elseif lang == "PH" then return e1 .. " itlog - " .. r1 .. " handa - " .. g1 .. " lumalaki - " .. b1 .. " sa bag - Kabuuan " .. t1
            elseif lang == "ID" then return e1 .. " telur - " .. r1 .. " siap - " .. g1 .. " tumbuh - " .. b1 .. " di tas - Total " .. t1
            end return e1 .. " eggs - " .. r1 .. " ready - " .. g1 .. " growing - " .. b1 .. " in bag - Total " .. t1
        end
    },
    {
        pattern = "^Players (%d+)%/(%d+)$",
        format  = function(lang, p1, p2) 
            if lang == "VI" then return "Người chơi: " .. p1 .. "/" .. p2
            elseif lang == "PH" then return "Mga Manlalaro: " .. p1 .. "/" .. p2
            elseif lang == "ID" then return "Pemain: " .. p1 .. "/" .. p2
            end return "Players " .. p1 .. "/" .. p2
        end
    }
}

local SortedVI, SortedPH, SortedID = {}, {}, {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
for en, ph in pairs(MAP_PH) do table.insert(SortedPH, {en = en, out = ph, len = #en}) end
for en, id in pairs(MAP_ID) do table.insert(SortedID, {en = en, out = id, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)
table.sort(SortedPH, function(a, b) return a.len > b.len end)
table.sort(SortedID, function(a, b) return a.len > b.len end)

local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    local trimmed = raw:gsub("^%s*(.-)%s*$", "%1")
    local exactMatch = nil
    if currentLanguage == "VI" then exactMatch = MAP_VI[trimmed]
    elseif currentLanguage == "PH" then exactMatch = MAP_PH[trimmed]
    elseif currentLanguage == "ID" then exactMatch = MAP_ID[trimmed] end

    if exactMatch then
        local res = safeReplace(raw, trimmed, exactMatch)
        FastCache[cacheKey] = res
        return res
    end

    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local matches = {trimmed:match(item.pattern)}
        if #matches > 0 then
            local res = item.format(currentLanguage, unpack(matches))
            FastCache[cacheKey] = res
            return res
        end
    end

    local result = raw
    local matched = false
    local sortedMap = SortedVI
    if currentLanguage == "PH" then sortedMap = SortedPH
    elseif currentLanguage == "ID" then sortedMap = SortedID end

    for _, item in ipairs(sortedMap) do
        if result:find(item.en, 1, true) then
            result = safeReplace(result, item.en, item.out)
            matched = true
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("Chilli_LangToggle_Slate") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    if currentLanguage == "EN" then
        if inst.Text ~= original then
            translationLock = true
            inst.Text = original
            translationLock = false
        end
    else
        local mappedText = translateText(original)
        if inst.Text ~= mappedText then
            translationLock = true
            inst.Text = mappedText
            translationLock = false
        end
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(TrackedElements, inst)
    
    task.defer(function() applyTranslation(inst) end)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if not translationLock then
            local current = inst.Text
            local isKnown = false
            
            if currentLanguage ~= "EN" then
                local sortedMap = SortedVI
                if currentLanguage == "PH" then sortedMap = SortedPH
                elseif currentLanguage == "ID" then sortedMap = SortedID end

                for _, item in ipairs(sortedMap) do
                    if current:find(item.out, 1, true) then
                        isKnown = true
                        break
                    end
                end
            else
                isKnown = (current == inst:GetAttribute("OriginalRawText"))
            end

            if not isKnown then
                inst:SetAttribute("OriginalRawText", current)
            end
            applyTranslation(inst)
        end
    end)
end

local function updateAllActive()
    for i = #TrackedElements, 1, -1 do
        local el = TrackedElements[i]
        if el and el.Parent then
            applyTranslation(el)
        else
            table.remove(TrackedElements, i)
        end
    end
end

-- ==================== 4. NÚT ĐỔI NGÔN NGỮ (TOP-CENTER) ====================
local function createLangToggleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("Chilli_LangToggle_Slate")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Chilli_LangToggle_Slate"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Container = Instance.new("Frame", ScreenGui)
    Container.Size = UDim2.new(0, 136, 0, 28)
    Container.AnchorPoint = Vector2.new(0.5, 0)
    Container.Position = UDim2.new(0.5, 0, 0, 15)
    Container.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
    Container.BackgroundTransparency = 0.2
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke", Container)
    Stroke.Color = Color3.fromRGB(160, 45, 45) 
    Stroke.Thickness = 1.0

    local Icon = Instance.new("TextLabel", Container)
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "🌐"
    Icon.TextSize = 14

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -36, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Tiếng Việt"
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(240, 130, 130)
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ClickBtn = Instance.new("TextButton", Container)
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""

    local dragging, dragStart, startPos = false, nil, nil
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Container.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Container.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    ClickBtn.MouseButton1Click:Connect(function()
        if currentLanguage == "VI" then
            currentLanguage = "PH"
            Label.Text = "Filipino"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(245, 205, 110)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 135, 60)}):Play()
        elseif currentLanguage == "PH" then
            currentLanguage = "ID"
            Label.Text = "Indonesia"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 220, 240)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 140, 160)}):Play()
        elseif currentLanguage == "ID" then
            currentLanguage = "EN"
            Label.Text = "English"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(215, 180, 180)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 45, 45)}):Play()
        else
            currentLanguage = "VI"
            Label.Text = "Tiếng Việt"
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 130, 130)}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(160, 45, 45)}):Play()
        end
        updateAllActive()
    end)
end

-- ==================== 5. BỘ QUÉT ZERO-LAG ĐƯỢC DEFER SAU CÙNG ====================
task.delay(4.5, function()
    createLangToggleUI()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
            end
            if i % 20 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then pcall(function() scanUIChunked(root) end) end
    end

    for _, root in ipairs(searchRoots) do
        if root then
            root.DescendantAdded:Connect(function(desc)
                task.defer(function()
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        hookElement(desc)
                    end
                end)
            end)
        end
    end
end)
