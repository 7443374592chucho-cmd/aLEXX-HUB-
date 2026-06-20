local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- 1. Contenedor Principal
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local borderFrame = Instance.new("Frame", screenGui)
borderFrame.Size = UDim2.new(0, 400, 0, 250)
borderFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
borderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", borderFrame).CornerRadius = UDim.new(0, 15)
borderFrame.Active = true
borderFrame.Draggable = true

local gradient = Instance.new("UIGradient", borderFrame)
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})

local mainFrame = Instance.new("Frame", borderFrame)
mainFrame.Size = UDim2.new(0, 394, 0, 244)
mainFrame.Position = UDim2.new(0, 3, 0, 3)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 13)

-- Botón de Salir (X) y By Yisus
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0.92, 0, 0.05, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local credits = Instance.new("TextLabel", mainFrame)
credits.Size = UDim2.new(0, 100, 0, 30)
credits.Position = UDim2.new(0.65, 0, 0.05, 0)
credits.Text = "By Yisus"
credits.TextColor3 = Color3.fromRGB(150, 150, 150)
credits.BackgroundTransparency = 1

-- 2. Perfil y Nombre
local avatarCircle = Instance.new("ImageLabel", mainFrame)
avatarCircle.Size = UDim2.new(0, 60, 0, 60)
avatarCircle.Position = UDim2.new(0.03, 0, 0.05, 0)
avatarCircle.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
avatarCircle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Instance.new("UICorner", avatarCircle).CornerRadius = UDim.new(1, 0)

local nameLabel = Instance.new("TextLabel", mainFrame)
nameLabel.Size = UDim2.new(0, 200, 0, 60)
nameLabel.Position = UDim2.new(0.20, 0, 0.05, 0)
nameLabel.Text = player.Name
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 20
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.BackgroundTransparency = 1

-- 3. Key System con diseño mejorado
local keyInput = Instance.new("TextBox", mainFrame)
keyInput.Size = UDim2.new(0, 350, 0, 40)
keyInput.Position = UDim2.new(0.5, -175, 0.4, 0)
keyInput.PlaceholderText = "Escribe tu key"
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
keyInput.TextColor3 = Color3.new(1, 1, 1)
keyInput.Font = Enum.Font.Gotham
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

-- Borde brillante para el TextBox
local stroke = Instance.new("UIStroke", keyInput)
stroke.Color = Color3.fromRGB(50, 50, 60)
stroke.Thickness = 2

keyInput.Focused:Connect(function()
    TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 102, 255)}):Play()
end)
keyInput.FocusLost:Connect(function()
    TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(50, 50, 60)}):Play()
end)

-- Función de animación corregida
local function addClickAnimation(btn)
    local originalSize = btn.Size
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = originalSize - UDim2.new(0, 5, 0, 5)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = originalSize}):Play()
    end)
end

local getKeyBtn = Instance.new("TextButton", mainFrame)
getKeyBtn.Size = UDim2.new(0, 170, 0, 40)
getKeyBtn.Position = UDim2.new(0.5, -175, 0.65, 0)
getKeyBtn.Text = "GET KEY"
getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
getKeyBtn.TextColor3 = Color3.new(1, 1, 1)
getKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)
addClickAnimation(getKeyBtn)

local copyDiscordBtn = Instance.new("TextButton", mainFrame)
copyDiscordBtn.Size = UDim2.new(0, 170, 0, 40)
copyDiscordBtn.Position = UDim2.new(0.5, 5, 0.65, 0)
copyDiscordBtn.Text = "COPY DISCORD"
copyDiscordBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
copyDiscordBtn.TextColor3 = Color3.new(1, 1, 1)
copyDiscordBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", copyDiscordBtn).CornerRadius = UDim.new(0, 8)
addClickAnimation(copyDiscordBtn)

-- 4. Barra inferior
local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 14
statusLabel.BackgroundTransparency = 1

-- 5. Lógica de giro y Ping en tiempo real
local speed = 60
local rot = 0
RunService.RenderStepped:Connect(function(dt)
    rot = rot + (speed * dt)
    avatarCircle.Rotation = rot
    gradient.Rotation = rot
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
    statusLabel.Text = "Status: Online | Ping: " .. ping .. "ms"
end)

-- Lógica para los botones
getKeyBtn.MouseButton1Click:Connect(function()
    local input = keyInput.Text
    -- Cambia "TU_KEY_SECRETA_AQUI" por tu clave real
    if input == "ALEXX2006@" then
        statusLabel.Text = "Key correcta. Ejecutando..."
        -- AQUÍ VA TU CÓDIGO DE SCRIPT QUE SE EJECUTA SI LA KEY ES VÁLIDA
    else
        statusLabel.Text = "Key incorrecta, intenta de nuevo"
        task.wait(2)
        statusLabel.Text = "Status: Online | Ping: " .. math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) .. "ms"
    end
end)

copyDiscordBtn.MouseButton1Click:Connect(function()
    -- Sustituye el enlace por tu link de Discord
    setclipboard("https://discord.gg/UseegSKU")
    statusLabel.Text = "Discord copiado al portapapeles"
    task.wait(2)
    statusLabel.Text = "Status: Online | Ping: " .. math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) .. "ms"
end)
