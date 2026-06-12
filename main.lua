local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Krynex", 
   LoadingTitle = "Krynex", 
   LoadingSubtitle = " ", 
   Theme = "Light", 
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Krynex"
   }
})

local CombatTab = Window:CreateTab("Combat", nil)
local VisualsTab = Window:CreateTab("Visuals", nil)
CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Callback = function(Value)
      _G.SilentAimEnabled = Value -- Aquí activas/desactivas tu lógica
   end,
})
CombatTab:CreateToggle({
   Name = "Hitbox Normal",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxEnabled = Value
   end,
})
CombatTab:CreateToggle({
   Name = "Hitbox (Pro)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxVisibleEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Highlight Brillo",
   CurrentValue = false,
   Callback = function(Value)
      _G.ChamsEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Auto Jump",
   CurrentValue = _G.AutoJumpEnabled or false,
   Callback = function(Value)
      _G.AutoJumpEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Hitbox Disimulada",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxDisimuladaEnabled = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Cámara Rápida (FastCam)",
   CurrentValue = false,
   Callback = function(Value)
      _G.FastCam = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Speed Disimulado",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpeedEnabled = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Anti Contador",
   CurrentValue = false,
   Callback = function(Value)
      _G.ActiveMode = Value
      
      if not Value then
         local Humanoid = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
         if Humanoid then Humanoid.WalkSpeed = 16 end
      end
   end,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- =========================
-- VARIABLES (MANTENIDAS)
-- =========================
_G.SilentAimEnabled = false
_G.HitboxEnabled = false
_G.HitboxVisibleEnabled = false
_G.ChamsEnabled = false

-- =========================
-- IS PLAYER IN MATCH (ORIGINAL)
-- =========================
local function IsPlayerInMatch(player)
	local RunningGames = workspace:FindFirstChild("RunningGames")
	if not RunningGames then return false end
	for _,gameFolder in pairs(RunningGames:GetChildren()) do
		local AlivePlayers = gameFolder:FindFirstChild("AlivePlayers")
		if AlivePlayers then
			local TeamBlue = AlivePlayers:FindFirstChild("TeamBlue")
			local TeamRed = AlivePlayers:FindFirstChild("TeamRed")
			local myBlue = TeamBlue and TeamBlue:FindFirstChild(LocalPlayer.Name)
			local myRed = TeamRed and TeamRed:FindFirstChild(LocalPlayer.Name)
			if myBlue then if TeamRed and TeamRed:FindFirstChild(player.Name) then return true end
			elseif myRed then if TeamBlue and TeamBlue:FindFirstChild(player.Name) then return true end
			end
		end
	end
	return false
end

-- =========================
-- VISUALS ORIGINAL REAL
-- =========================
local S = { espColor = Color3.fromRGB(255,0,0) }
local Highlights = {}

task.spawn(function()
	while task.wait(0.1) do
		if not _G.ChamsEnabled then
			for _,hl in pairs(Highlights) do if hl then hl:Destroy() end end
			table.clear(Highlights)
		else
			for _,p in pairs(Players:GetPlayers()) do
				if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and IsPlayerInMatch(p) then
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
					if Highlights[p] then Highlights[p]:Destroy() Highlights[p] = nil end
				end
			end
		end
	end
end)

task.spawn(function()
    while task.wait(0.2) do
        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        
        if humanoid then
            if _G.SpeedEnabled then
                
                if humanoid.WalkSpeed ~= 23 then
                    humanoid.WalkSpeed = 23
                end
            else
                
                if humanoid.WalkSpeed == 23 then
                    humanoid.WalkSpeed = 16
                end
            end
        end
    end
end)


-- =========================
-- HITBOX LOGIC ORIGINAL
-- =========================
task.spawn(function()
	while task.wait(0.15) do
		for _,p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local HRP = p.Character.HumanoidRootPart
				if not IsPlayerInMatch(p) then
					HRP.Size = Vector3.new(2,2,1)
					HRP.Transparency = 1
					HRP.CanCollide = false
					continue
				end
				if _G.HitboxEnabled then
					HRP.Size = Vector3.new(7,7,7)
					HRP.Transparency = 0.8
					HRP.CanCollide = false
				elseif _G.HitboxVisibleEnabled then
					local origin = Camera.CFrame.Position
					local direction = (HRP.Position - origin)
					local params = RaycastParams.new()
					params.FilterType = Enum.RaycastFilterType.Blacklist
					params.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
					local result = workspace:Raycast(origin, direction, params)
					if not result then
						HRP.Size = Vector3.new(7.5,7.5,7.5)
						HRP.Transparency = 0.8
						HRP.CanCollide = false
					else
						HRP.Size = Vector3.new(2,2,1)
						HRP.Transparency = 1
						HRP.CanCollide = false
					end
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
-- SILENT AIM ORIGINAL (CORREGIDO Y OPTIMIZADO)
-- =========================

-- Función independiente de Wall Check
local function IsVisible(targetPart)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local ray = workspace:Raycast(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position), raycastParams)
    
    -- Si no hay nada en medio (ray es nil), es visible. 
    -- Si hay algo, validamos que sea el modelo del objetivo.
    if not ray then return true end
    return ray.Instance:IsDescendantOf(targetPart.Parent)
end

local function getBestTarget()
	local target = nil
	local shortestDistance = math.huge
	local Center = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)
	for _,v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and IsPlayerInMatch(v) then
			local hrp = v.Character.HumanoidRootPart
			local pos,visible = Camera:WorldToViewportPoint(hrp.Position)
			
			-- Validación: en pantalla Y sin obstáculos (Wall Check)
			if visible and IsVisible(hrp) then
				local distance = (Vector2.new(pos.X,pos.Y) - Center).Magnitude
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
setreadonly(mt, false)
mt.__index = newcclosure(function(self, index)
    if _G.SilentAimEnabled and self == Mouse and (index == "Hit" or index == "Target") then
        local target = getBestTarget()
        if target then
            if index == "Hit" then return target.CFrame
            elseif index == "Target" then return target.Parent end
        end
    end
    return oldIndex(self, index)
end)
setreadonly(mt, true)

-- =========================
-- HITBOX DISIMULADA (SISTEMA POR EVENTO)
-- =========================
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if not _G.HitboxDisimuladaEnabled then return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and IsPlayerInMatch(p) then
            local HRP = p.Character.HumanoidRootPart
            
            
            local origin = Camera.CFrame.Position
            local direction = (HRP.Position - origin)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {LocalPlayer.Character}
            
            local result = workspace:Raycast(origin, direction, params)
            
            
            local targetSize = (result and result.Instance:IsDescendantOf(p.Character)) and Vector3.new(4, 4, 4) or Vector3.new(2, 2, 1)
            local targetTransparency = (result and result.Instance:IsDescendantOf(p.Character)) and 0.8 or 1
            
            
            if HRP.Size ~= targetSize then
                HRP.Size = targetSize
                HRP.Transparency = targetTransparency
                HRP.CanCollide = false
            end
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AutoJumpEnabled then
        local Character = game.Players.LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChild("Humanoid")
        if Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then
            Humanoid.Jump = true
        end
    end
end)

-- =============================================
-- LÓGICA ANTI CONTADOR (CÓDIGO PARA LIBRERÍA)
-- =============================================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local AntiContadorConnection = nil

local function ToggleAntiContador(Value)
    if Value then
        -- Iniciar el bucle de mantenimiento
        AntiContadorConnection = RunService.Heartbeat:Connect(function()
            local Character = Players.LocalPlayer.Character
            if Character then
                local Humanoid = Character:FindFirstChild("Humanoid")
                if Humanoid then
                    -- Asegurar que el humanoide no esté en modo plataforma
                    Humanoid.PlatformStand = false
                    -- Forzar estado de pie si entra en física
                    if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
                        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                    -- Mantener velocidad
                    Humanoid.WalkSpeed = 30
                end
            end
        end)
    else
        -- Detener el bucle y resetear velocidad
        if AntiContadorConnection then
            AntiContadorConnection:Disconnect()
            AntiContadorConnection = nil
        end
        local Humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if Humanoid then 
            Humanoid.WalkSpeed = 16 
        end
    end
end
-- Este bloque va fuera de los toggles, al final de tu archivo
task.spawn(function()
    while true do
        task.wait(0.01)
        if _G.ActiveMode then
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character
            if Character and Character:FindFirstChild("Humanoid") then
                local Humanoid = Character.Humanoid
                Humanoid.PlatformStand = false
                if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
                    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
                Humanoid.WalkSpeed = 30 -- Velocidad disimulada
            end
        end
    end
end)


Rayfield:LoadConfiguration()

