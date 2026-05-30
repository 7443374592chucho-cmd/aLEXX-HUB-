local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local SoundService = game:GetService("SoundService")

-- =========================
-- VARIABLES
-- =========================

_G.AutoShotEnabled = false
_G.SilentAimEnabled = false
_G.HitboxEnabled = false
_G.HitboxVisibleEnabled = false
_G.ChamsEnabled = false
_G.StretchEnabled = false -- Agregado para el botón
_G.FastCam = false
_G.MiSensi = 1.0

-- =========================
-- CLICK SOUND
-- =========================

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://9118828560"
ClickSound.Volume = 1
ClickSound.Parent = SoundService

-- =========================
-- GUI
-- =========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "ALEXX_HUB"

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,420,0,300)
Main.Position = UDim2.new(0.25,0,0.2,0)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = Main
MainCorner.CornerRadius = UDim.new(0,12)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Main
Stroke.Color = Color3.fromRGB(140,0,255)
Stroke.Thickness = 2

-- =========================
-- TITLE
-- =========================

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "ALEXX HUB BETA"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- =========================
-- SIDEBAR
-- =========================

local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Size = UDim2.new(0,110,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)

local SideCorner = Instance.new("UICorner")
SideCorner.Parent = Sidebar

local UIList = Instance.new("UIListLayout")
UIList.Parent = Sidebar
UIList.Padding = UDim.new(0,5)

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = Sidebar
UIPadding.PaddingTop = UDim.new(0,5)

local Pages = {}

local function CreatePage(name)

	local Page = Instance.new("Frame")
	Page.Parent = Main
	Page.Size = UDim2.new(1,-120,1,-50)
	Page.Position = UDim2.new(0,115,0,45)
	Page.BackgroundTransparency = 1
	Page.Visible = false

	Pages[name] = Page

	local Button = Instance.new("TextButton")
	Button.Parent = Sidebar
	Button.Size = UDim2.new(1,-10,0,40)

	Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
	Button.Text = name
	Button.TextColor3 = Color3.new(1,1,1)
	Button.Font = Enum.Font.GothamBold
	Button.TextScaled = true

	local BCorner = Instance.new("UICorner")
	BCorner.Parent = Button

	Button.MouseButton1Click:Connect(function()

		ClickSound:Play()

		for _,v in pairs(Pages) do
			v.Visible = false
		end

		Page.Visible = true

	end)

	return Page

end

local CombatPage = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")
local WorldPage = CreatePage("Settings")
local EmotesPage = CreatePage("Animaciones")

CombatPage.Visible = true

-- =========================
-- TOGGLE SYSTEM
-- =========================

local function CreateToggle(parent,text,y,variable)

	local Enabled = false

	local Button = Instance.new("TextButton")
	Button.Parent = parent

	Button.Size = UDim2.new(0,250,0,40)
	Button.Position = UDim2.new(0,10,0,y)

	Button.BackgroundColor3 = Color3.fromRGB(35,35,35)

	Button.Text = text .. " [OFF]"
	Button.TextColor3 = Color3.new(1,1,1)

	Button.Font = Enum.Font.GothamBold
	Button.TextScaled = true

	local Corner = Instance.new("UICorner")
	Corner.Parent = Button

	Button.MouseButton1Click:Connect(function()

		ClickSound:Play()

		Enabled = not Enabled

		_G[variable] = Enabled

		if Enabled then

			Button.Text = text .. " [ON]"
			Button.BackgroundColor3 = Color3.fromRGB(140,0,255)

		else

			Button.Text = text .. " [OFF]"
			Button.BackgroundColor3 = Color3.fromRGB(35,35,35)

		end

	end)

end

-- =========================
-- BUTTON SYSTEM
-- =========================

local function CreateButton(parent,text,y,callback)

	local Button = Instance.new("TextButton")
	Button.Parent = parent

	Button.Size = UDim2.new(0,250,0,40)
	Button.Position = UDim2.new(0,10,0,y)

	Button.BackgroundColor3 = Color3.fromRGB(35,35,35)

	Button.Text = text
	Button.TextColor3 = Color3.new(1,1,1)

	Button.Font = Enum.Font.GothamBold
	Button.TextScaled = true

	local Corner = Instance.new("UICorner")
	Corner.Parent = Button

	Button.MouseButton1Click:Connect(function()

		ClickSound:Play()
		callback()

	end)

end

-- =========================
-- COMBAT
-- =========================

CreateToggle(CombatPage,"Silent Aim",10,"SilentAimEnabled")

CreateButton(CombatPage,"Auto Shot [Mantenimiento]",60,function()

	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "ALEXX HUB",
		Text = "Auto Shot está en mantenimiento",
		Duration = 5
	})

end)

CreateButton(CombatPage,"Aimbot",110,function()

	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/nexuscripts/DUELS-Murders-vs-Sheriffs/refs/heads/main/Aimbot.lua"
	))()

end)

-- =========================
-- VISUALS ORIGINAL REAL
-- =========================

local S = {
	eP = false,
	espColor = Color3.fromRGB(255,0,0)
}

local Highlights = {}

CreateToggle(
	VisualsPage,
	"Highlight Brillo",
	10,
	"ChamsEnabled"
)

CreateButton(VisualsPage,"Rojo",60,function()

	S.espColor = Color3.fromRGB(255,0,0)

end)

CreateButton(VisualsPage,"Morado",110,function()

	S.espColor = Color3.fromRGB(140,0,255)

end)

CreateButton(VisualsPage,"Verde",160,function()

	S.espColor = Color3.fromRGB(0,255,0)

end)

local function IsPlayerInMatch(player)

	local RunningGames = workspace:FindFirstChild("RunningGames")

	if not RunningGames then
		return false
	end

	for _,gameFolder in pairs(RunningGames:GetChildren()) do

		local AlivePlayers = gameFolder:FindFirstChild("AlivePlayers")

		if AlivePlayers then

			local TeamBlue = AlivePlayers:FindFirstChild("TeamBlue")
			local TeamRed = AlivePlayers:FindFirstChild("TeamRed")

			local myBlue = TeamBlue and TeamBlue:FindFirstChild(LocalPlayer.Name)
			local myRed = TeamRed and TeamRed:FindFirstChild(LocalPlayer.Name)

			-- YO SOY BLUE
			if myBlue then

				if TeamRed and TeamRed:FindFirstChild(player.Name) then
					return true
				end

			-- YO SOY RED
			elseif myRed then

				if TeamBlue and TeamBlue:FindFirstChild(player.Name) then
					return true
				end

			end

		end

	end

	return false

end

task.spawn(function()

	while task.wait(0.1) do

		if not _G.ChamsEnabled then

			for _,hl in pairs(Highlights) do

				if hl then
					hl:Destroy()
				end

			end

			table.clear(Highlights)

		else

			for _,p in pairs(Players:GetPlayers()) do

				if p ~= LocalPlayer
				and p.Character
				and p.Character:FindFirstChild("HumanoidRootPart")
				and IsPlayerInMatch(p) then

					local char = p.Character

					if not Highlights[p] then

						local hl = Instance.new("Highlight")

						hl.Name = "ALEXX_Highlight"
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Adornee = char
						hl.Parent = game.CoreGui

						Highlights[p] = hl

					end

					Highlights[p].FillColor = S.espColor
					Highlights[p].OutlineColor = S.espColor
					Highlights[p].Adornee = char

				else

					if Highlights[p] then

						Highlights[p]:Destroy()
						Highlights[p] = nil

					end

				end

			end

		end

	end

end)

-- =========================
-- WORLD
-- =========================

getgenv().Resolution = { [".gg/scripters"] = 0.65 }
game:GetService("RunService").RenderStepped:Connect(function()
    if Camera and _G.StretchEnabled then
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution[".gg/scripters"], 0, 0, 0, 1)
    end
end)

CreateToggle(WorldPage,"Hitbox 7x7x7",10,"HitboxEnabled")
CreateToggle(WorldPage,"Hitbox Invisible (Pro)",60,"HitboxVisibleEnabled")
CreateToggle(WorldPage,"Pantalla Estirada",110,"StretchEnabled")

task.spawn(function()

	while task.wait(0.15) do

		for _,p in pairs(Players:GetPlayers()) do

			if p ~= LocalPlayer
			and p.Character
			and p.Character:FindFirstChild("HumanoidRootPart") then

				local HRP = p.Character.HumanoidRootPart

				-- =========================
				-- HITBOX NORMAL
				-- =========================

				if _G.HitboxEnabled then

					HRP.Size = Vector3.new(7,7,7)
					HRP.Transparency = 0.8
					HRP.CanCollide = false

				-- =========================
				-- HITBOX PRO
				-- =========================

				elseif _G.HitboxVisibleEnabled then

					local origin = Camera.CFrame.Position
					local direction = (HRP.Position - origin)

					local params = RaycastParams.new()
					params.FilterType = Enum.RaycastFilterType.Blacklist
					params.FilterDescendantsInstances = {
						LocalPlayer.Character,
						p.Character
					}

					local result = workspace:Raycast(
						origin,
						direction,
						params
					)

					-- SIN PARED
					if not result then

						HRP.Size = Vector3.new(7,7,7)
						HRP.Transparency = 1
						HRP.CanCollide = false

					-- DETRÁS PARED
					else

						HRP.Size = Vector3.new(2,2,1)
						HRP.Transparency = 1
						HRP.CanCollide = false

					end

				-- =========================
				-- RESET
				-- =========================

				else

					HRP.Size = Vector3.new(2,2,1)
					HRP.Transparency = 1
					HRP.CanCollide = false

				end

			end

		end

	end

end)
-- =========================
-- EMOTES
-- =========================

local EmotesLoaded = false
local EmotesVisible = false

CreateButton(EmotesPage,"Animaciones",10,function()

	if not EmotesLoaded then

		EmotesLoaded = true

		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua",
			true
		))()

		task.wait(2)

		EmotesVisible = true

		return
	end

	pcall(function()

		local CoreGui = game:GetService("CoreGui")

		local UI = CoreGui:FindFirstChild("7yd7")

		if UI then

			EmotesVisible = not EmotesVisible
			UI.Enabled = EmotesVisible

		end

	end)

end)

-- =========================
-- SILENT AIM
-- =========================

local function getBestTarget()

	local target = nil
	local shortestDistance = math.huge

	for _,v in ipairs(Players:GetPlayers()) do

		if v ~= LocalPlayer
		and v.Character
		and v.Character:FindFirstChild("HumanoidRootPart")
		and v.Character:FindFirstChild("Humanoid")
		and v.Character.Humanoid.Health > 0 then

			local hrp = v.Character.HumanoidRootPart

			local pos,visible = Camera:WorldToViewportPoint(hrp.Position)

			if visible then

				local distance = (
					Vector2.new(pos.X,pos.Y) -
					Vector2.new(Mouse.X,Mouse.Y)
				).Magnitude

				if distance < shortestDistance then

					shortestDistance = distance
					target = hrp

				end

			end

		end

	end

	return target

end

local mt = getrawmetatable(game)
local oldIndex = mt.__index

setreadonly(mt,false)

mt.__index = newcclosure(function(self,index)

	if self == Mouse
	and _G.SilentAimEnabled
	and (index == "Hit" or index == "Target") then

		local target = getBestTarget()

		if target then

			if index == "Hit" then
				return target.CFrame
			elseif index == "Target" then
				return target
			end

		end

	end

	return oldIndex(self,index)

end)

setreadonly(mt,true)

-- =========================
-- MOBILE BUTTON
-- =========================

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui

ToggleButton.Size = UDim2.new(0,50,0,50)
ToggleButton.Position = UDim2.new(0.88,0,0.2,0)

ToggleButton.BackgroundColor3 = Color3.fromRGB(25,25,25)

ToggleButton.Text = "≡"
ToggleButton.TextColor3 = Color3.new(1,1,1)

ToggleButton.TextScaled = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.Parent = ToggleButton
ToggleCorner.CornerRadius = UDim.new(1,0)

local Visible = true

ToggleButton.MouseButton1Click:Connect(function()

	ClickSound:Play()

	Visible = not Visible

	Main.Visible = Visible

end)

-- =========================
-- LOGICA NUEVA (Cámara y Sensibilidad)
-- =========================

-- Lógica para Cámara Rápida
game:GetService("RunService").RenderStepped:Connect(function()
    if Camera then
        local targetFOV = _G.FastCam and 110 or 70
        Camera.FieldOfView = Camera.FieldOfView + (targetFOV - Camera.FieldOfView) * 0.1
    end
end)

-- Botón para Cámara Rápida (En la pestaña WorldPage, posición 160)
CreateToggle(WorldPage, "Cámara Rápida", 160, "FastCam")

-- Botón para Sensibilidad (En la pestaña WorldPage, posición 210)
CreateButton(WorldPage, "Sensibilidad +0.2", 210, function()
    _G.MiSensi = _G.MiSensi + 0.2
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "ALEXX HUB",
        Text = "Sensi Multiplier: " .. string.format("%.1f", _G.MiSensi),
        Duration = 2
    })
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "ALEXX HUB",
	Text = "Version Beta v1.0 Cargada",
	Duration = 5
})
