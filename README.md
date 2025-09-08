local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AplyHub"
gui.ResetOnSpawn = false

-- === КРУГЛАЯ СИНЯЯ ИКОНКА ===
local icon = Instance.new("ImageButton", gui)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 20, 0.5, -30)
icon.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
icon.Image = "" -- можно вставить ID изображения, если есть
icon.Parent = gui

local iconCorner = Instance.new("UICorner", icon)
iconCorner.CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke", icon)
iconStroke.Thickness = 2
iconStroke.Color = Color3.fromRGB(255, 255, 255)
iconStroke.Transparency = 0.3

-- === ГЛАВНОЕ МЕНЮ ===
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Visible = false

local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 12)

local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Thickness = 2
frameStroke.Color = Color3.fromRGB(255, 70, 70)
frameStroke.Transparency = 0.4

-- Заголовок
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Aply Hub - tween v1.0"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- === ФУНКЦИЯ СОЗДАНИЯ КНОПОК ===
local function createButton(name, yPos)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = name .. ": OFF"
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16

    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 8)

    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Thickness = 1.5
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Transparency = 0.5

    -- Анимация при наведении
    btn.MouseEnter:Connect(function()
        btn:TweenSize(UDim2.new(1, -16, 0, 32), "Out", "Quad", 0.1, true)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
    end)
    btn.MouseLeave:Connect(function()
        btn:TweenSize(UDim2.new(1, -20, 0, 30), "Out", "Quad", 0.1, true)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    return btn
end

-- === КНОПКИ ===
local invisBtn = createButton("INVISIBILITY", 40)
local kickBtn = createButton("Auto kick", 80)
local espPlayerBtn = createButton("Esp player", 120)
local espBaseBtn = createButton("Esp base", 160)

-- === ЛОГИКА КНОПОК ===
local invisOn = false
invisBtn.MouseButton1Click:Connect(function()
    invisOn = not invisOn
    invisBtn.Text = "INVISIBILITY: " .. (invisOn and "ON" or "OFF")
    local char = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = invisOn and 1 or 0
        end
    end
end)

local kickOn = false
kickBtn.MouseButton1Click:Connect(function()
    kickOn = not kickOn
    kickBtn.Text = "Auto kick: " .. (kickOn and "ON" or "OFF")
    if kickOn then
        local backpack = player:FindFirstChild("Backpack")
        if backpack and backpack:FindFirstChild("StolenItem") then
            player:Kick("Вы были кикнуты за кражу.")
        end
    end
end)

local espOn = false
espPlayerBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    espPlayerBtn.Text = "Esp player: " .. (espOn and "ON" or "OFF")
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local highlight = plr.Character:FindFirstChild("Highlight")
            if espOn and not highlight then
                local hl = Instance.new("Highlight", plr.Character)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.new(1, 1, 1)
            elseif not espOn and highlight then
                highlight:Destroy()
            end
        end
    end
end)

espBaseBtn.MouseButton1Click:Connect(function()
    local baseTime = os.date("%H:%M:%S")
    espBaseBtn.Text = "Esp base: " .. baseTime
end)

-- === ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ ===
icon.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)
