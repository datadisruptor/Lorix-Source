repeat task.wait() until game:IsLoaded() and (game:GetService('Players').LocalPlayer.Character or game:GetService('Players').LocalPlayer.CharacterAdded:Wait())
--
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...)
		return (...)
	end;
	LPH_NO_VIRTUALIZE = function(...)
		return (...)
	end;
end;
-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Stats = game:GetService("Stats")
-- // Variables
local Network = settings():GetService("NetworkSettings")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local Ping = Stats.PerformanceStats.Ping
local CurrentCamera = Workspace.CurrentCamera;
-- // Optimization Variables
local MRandom = math.random
local Floor = math.floor
local Round = math.round
local Clamp = math.clamp
local Acos = math.acos
local Huge = math.huge
local Sqrt = math.sqrt
local Ceil = math.ceil
local Cos = math.cos
local Abs = math.abs
local Sin = math.sin
local Pi = math.pi
local Remove = table.remove
local Find = table.find
local Lower = string.lower
local Split = string.split
local Create = coroutine.create
local Resume = coroutine.resume
local Delay = task.delay
local Spawn = task.spawn
local Wait = task.wait
local Drawingnew = Drawing.new
local Vector2new = Vector2.new
local Vector3new = Vector3.new
-- // Settings Init
if not getgenv().UniversalSettings then
	getgenv().UniversalSettings = {
		Intro = false, -- Script will load with short intro
		Enabled = true,
		VelocityCalculationType = "Lorix", -- Roblox, Lorix ( Automatically will set to 'Lorix' when anti aim is detected. )
		FFAMode = true, -- Turn this to false if the game is not FFA.
		CursorOffset = {
			Enabled = true,
			X = 0,
			Y = 0,
		},
		MemorySpoof = true,
		TargetMode = "FOV", -- "FOV" or "Target"
		AutoPrediction = true, -- If set to true, prediction will be automatically set based on your ping.
	}
	--
	getgenv().SilentAim = {
		Enabled = true,
		Mode = "Safe", -- Safe, Blatant
		Mode2 = true,
		HitPartMode = "Nearest Point", -- "Nearest Part", "Nearest Point" (Nearest Point is more legit)
		PredictMovement = true,
		PredictionAmmount = 0.127271,
		HitChance = 100,
		InAirHitChance = 100,
		HitParts = {
			"Head",
			"HumanoidRootPart"
		},
		ClosestToCursorHitpart = true, --// Will ignore the HitParts table and make the Hitpart the closest to your mouse.
		SilentAimVisualizer = true, -- This will the place where silent aim will hit.
	}
	--
	getgenv().AimAssist = {
		Enabled = true,
		SafeMode = true, -- If true, camlock will not work if you are in thirdperson without shiftlock
		PredictMovement = true,
		PredictionAmmount = 0.13,
		HitParts = {
			"Head",
			"HumanoidRootPart"
		},
		ClosestToCursorHitpart = true, --// Will ignore the HitParts table and make the Hitpart the closest to your mouse.
		AirShot = true,
		Smoothness = 0.0208165, -- How smooth the camera will move
		AirShotSmooth = 0.02465, 
		Jitter = {
			Enabled = true, -- If camera will jitter
			X = 5, -- How much the camera will shake on the X axis
			Y = 5, -- How much the camera will shake on the Y axis
			Z = 5, -- How much the camera will shake on the Z axis
		},
		Deadzone = false, --// Will show a FOV that when targets are inside AimAssist will disable.
		StutterAmmount = 0, --// How much the AimAssist will stutter per tick
		EasingStyle = "Exponential",
		--[[
			Linear, Sine, Back, Quad, Quar, Quint, Bounce, Elastic, Exponential, Circular, Cubic ( https://create.roblox.com/docs/reference/engine/enums/EasingStyle )
		]]--
	}
	--
	getgenv().TriggerBot = {
		Enabled = false,
		Delay = 0.1,
	}
	--
	getgenv().Safety = { 
		PanicBindEnabled = true, --// Turns everything OFF/ON
		UnloadBindEnabled = true, --// UNLOADS the entire script
		KickOnStaffJoin = true, -- // Kicks you if game staff join
		AntiFloorShot = true -- Prevents you from hitting ground shot
	}
	--
	getgenv().Checks = {
		Wall = true,
		Visible = true,
		ForceField = true,
		Team = true,
		Alive = true,
		Friend = false,
		Crew = false
	}
	--
	getgenv().FovSettings = {
		Type = "Static", -- "Static" or "Dynamic"
		Silent = {
			Visible = true,
			Filled = true,
			Radius = 20,
			Color = Color3.fromRGB(0, 0, 0),
		},
		Assist = {
			Visible = false,
			Filled = true,
			Radius = 20,
			Color = Color3.fromRGB(0, 0, 0),
		},
		Deadzone = {
			Visible = false,
			Filled = true,
			Radius = 0,
			Color = Color3.fromRGB(0, 0, 0),
		},
		DynamicRadius = 300,
	}
	--
	getgenv().HoodGameSettings = {
		UnlockOnKnock = true,
		AutoReload = false,
		LayAnimationKeybind = true,
		GunSettings = {
			Enabled = true,
			InAirSettings = true,
			DoubleBarrel = {
				["FOV"] = 20,
				["hitChance"] = 100,
				["inAirHitChance"] = 100,
				["inAirPrediction"] = 0.135
			},
			Rev = {
				["FOV"] = 15,
				["hitChance"] = 100,
				["inAirHitChance"] = 100,
				["inAirPrediction"] = 0.135
			},
			SMG = {
				["FOV"] = 7,
				["hitChance"] = 100,
				["inAirHitChance"] = 100,
				["inAirPrediction"] = 0.135
			},
			ShotGun = {
				["FOV"] = 20,
				["hitChance"] = 100,
				["inAirHitChance"] = 100,
				["inAirPrediction"] = 0.135
			},
			TacticalShotgun = {
				["FOV"] = 20,
				["hitChance"] = 100,
				["inAirHitChance"] = 100,
				["inAirPrediction"] = 0.135
			},
		},
	}
	--
	getgenv().Macro = {
		Enabled = true,
		Type = "First", --// "First", "Third"
		BypassMacroAbuse = true,
		NoClipMacro = true,
		Delay = 0.01
	}
	--
	getgenv().FakeSpike = { 
		Enabled = true,
		RealSpike = true,
		LagAmmount = 1,
		FakeSpikeAmmount = 250,
	}
	--
	getgenv().Keybinds = {
		Panic = "L",
		Unload = "V",
		TargetBind = "C",
		Macro = "X",
		NoClipMacro = "N",
		FakeSpike = "K",
		LayAnimationBind = "Z"
	}
	--
	getgenv().PredefinedPredictions = { 
		p20_30 = 0.11120,
		p30_40 = 0.11614,
		p40_50 = 0.12053,
		p50_60 = 0.12053,
		p60_70 = 0.12790,
		p70_80 = 0.12793,
		p80_90 = 0.129591,
		p90_100 = 0.13070,
		p100_110 = 0.13916,
		p110_120 = 0.14664,
		p120_130 = 0.14745,
		p130_140 = 0.150,
		p140_150 = 0.155,
		p150_160 = 0.1545,
		p160_170 = 0.1567,
		p170_180 = 0.1672,
		p180_190 = 0.1746,
		p190_200 = 0.1746,
	}
	--
	getgenv().ChatCommands = {
		Enabled = false,
		SilentPred = ">pred",
		SilentFovSize = ">fov",
		SilentHitChance = ">chance",
		AssistFOVSize = "<fov",
		ToggleFOVSilent = ">togglefovs",
		ToggleFOVAssist = ">togglefova",
		ToggleAllFov = ">togglefov"
	}
end
--
if getgenv().UniversalSettings.Intro then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/LSUDEV/LSU-Public/main/Utils/heyman'))()
end
--
local CurrentGame, RemoteEvent, SupportedGames, WebSocket;
--
local SupportedGames = {
	[1008451066] = {
		Name = "Da Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				if (Player) and Player.Character:FindFirstChild("BodyEffects") then
					return Player.Character.BodyEffects["K.O"].Value
				end
                --
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[1958807588] = {
		Name = "Hood Modded",
		MouseArguments = "MousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").Bullets
			end
		},
	},
	[3895585994] = {
		Name = "Hood Trainer",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainRemote
			end
		},
	},
	[3634139746] = {
		Name = "Hood Customs",
		MouseArguments = "GetMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[4313782906] = {
		Name = "Dah Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):WaitForChild("Handle")
			end
		},
	},
	[3445639790] = {
		Name = "Untitled-Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):FindFirstChild(".gg/untitledhood")
			end
		},
	},
	[3633740623] = {
		Name = "Da Hood Aim Trainer",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[4204799886] = {
		Name = "Five Duels",
		MouseArguments = "shoot",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MouseUpdater")
			end
		},
	},
	["Universal"] = {
		Name = "Universal",
		MouseArguments = "None",
		HoodGame = false,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return;
			end
		},
	}
}
--
if SupportedGames[game.GameId] then
	CurrentGame = SupportedGames[game.GameId];
else
	CurrentGame = SupportedGames["Universal"];
end;
-- // Preload tables
local Visuals = {}
local Utility = {}
local State = {
	Utils = {},
	Connections = {},
	Objects = {},
	Velocities = {},
	Tracked = {},
	Connect = {},
	Previous = {}
}
local Lorix = {
	Locals = {
		LastStutter = tick(),
		SelectedTargetSilent = nil,
		SelectedTargetAssist = nil,
		Macro = false,
		NoClipMacro = false,
		CurrentRange = 1,
		AntiGroundValue = 0.165,
	},
	Safe = true
}
--
do -- // Renders
	SilentAimCircle = Drawingnew("Circle")
	SilentAimOutline = Drawingnew("Circle")
    --
	AimAssistCircle = Drawingnew("Circle")
    --
	DeadzoneCircle = Drawingnew("Circle")
	DeadzoneOutline = Drawingnew("Circle")
    --
	TargetDot = Drawingnew("Circle")
    --
	SilentAimCircle.Filled = getgenv().FovSettings.Silent.Filled
	SilentAimCircle.ZIndex = 59
    --
	SilentAimOutline.Thickness = 1.5
	SilentAimOutline.Filled = false
	SilentAimOutline.ZIndex = 60
    --
	AimAssistCircle.Filled = getgenv().FovSettings.Assist.Filled
	AimAssistCircle.ZIndex = 59
    --
	DeadzoneCircle.Filled = getgenv().FovSettings.Deadzone.Filled
	DeadzoneOutline.Filled = false
	DeadzoneCircle.ZIndex = 58
	DeadzoneOutline.ZIndex = 58
    --
	TargetDot.Transparency = 1
	TargetDot.Thickness = 1
	TargetDot.NumSides = 100
	TargetDot.Radius = 10
	TargetDot.Color = Color3.fromRGB(255, 20, 147)
	TargetDot.Filled = true
end
--// Functions
do -- // Utility
	function Utility:Connection(connectionType, connectionCallback)
		local connection = connectionType:Connect(connectionCallback)
		State.Connections[# State.Connections + 1] = connection
        --
		return connection
	end
    --
	function Utility:ThreadFunction(Func, Name, ...)
		local Func = Name and function()
			local Passed, Statement = pcall(Func)
            --
			if not Passed and not Lorix.Safe then
				warn("Lorix:\n", "              " .. Name .. ":", Statement)
			end
		end or Func
		local Thread = Create(Func)
        --
		Resume(Thread, ...)
		return Thread
	end
    --
	function Utility:MousePosition(Offset)
		if Offset then
			return UserInputService:GetMouseLocation() + Lorix:CursorOffset()
		else
			return UserInputService:GetMouseLocation()
		end
	end
    --
	function Utility:Console(Action, ...)
		if not Lorix.Safe then
			Action(...)
		end
	end
    --
	function Utility:ClampString(String, Length, Font)
		local Font = (Font or 2)
		local Split = String:split("\n")
        --
		local Clamped = ""
        --
		for Index, Value2 in pairs(Split) do
			if (Index * 13) <= Length then
				Clamped = Clamped .. Value2 .. (Index == # Split and "" or "\n")
			end
		end
        --
		return (Clamped ~= String and (Clamped == "" and "" or Clamped:sub(0, # Clamped - 1) .. " ...") or Clamped)
	end
end
--
do -- // Lorix
	LPH_JIT_MAX(function()
		function Lorix:UnloadCheat()
			do -- Unload Connections
				for Index, Value in pairs(State.Connections) do
					Value:Disconnect()
				end
			end
            --
			Visuals:Unload()
			Lorix.Locals.Macro = false
			Lorix.Locals.NoClipMacro = false
			getgenv().UniversalSettings.MemorySpoof = false
			getgenv().UniversalSettings = nil
			getgenv().SilentAim = nil
			getgenv().AimAssist = nil
			getgenv().TriggerBot = nil
			getgenv().Safety = nil
			getgenv().Checks = nil
			getgenv().FovSettings = nil
			getgenv().HoodGameSettings = nil
			getgenv().Macro = nil
			getgenv().FakeSpike = nil
			getgenv().Keybinds = nil
			getgenv().PredefinedPredictions = nil
			getgenv().ChatCommands = nil
		end
        --
		function Lorix:PlayerValid(Player, Function)
			if Player:IsA("Player") then
				if Function then
					return Function(Player)
				else
					return true
				end
			else
				return false
			end
		end
        --
		function Lorix:CheckTeam(Player1, Player2)
			if not getgenv().UniversalSettings.FFAMode then
				local eq = Player1.Team == Player2.Team
				return eq
			else
				return getgenv().UniversalSettings.FFAMode
			end
		end
        --
		function Lorix:CheckFriend(Player)
			if Player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
				return false;
			else
				return true;
			end
		end
        --
		function Lorix:CheckCrew(Player)
		    local a = Client:WaitForChild("DataFolder"):FindFirstChild("Crew", true)
		    local b = Player:WaitForChild("DataFolder"):FindFirstChild("Crew", true)
			if a and b then
				if (a.Value ~= "" and b.Value ~= "") and (a.Value == b.Value) then
					return false;
				end
			else
				return true
			end
		end
        --
		function Lorix:GetIgnore(Unpacked)
			return
		end
        --
		function Lorix:GetOrigin(Origin)
			if Origin == "Head" then
				local Object, Humanoid, RootPart = Lorix:ValidateClient(Client)
				local Head = Object:FindFirstChild("Head")
                --
				if Head and Head:IsA("RootPart") then
					return Head.CFrame.Position
				end
			elseif Origin == "Torso" then
				local Object, Humanoid, RootPart = Lorix:ValidateClient(Client)
                --
				if RootPart then
					return RootPart.CFrame.Position
				end
			end
            --
			return Workspace.CurrentCamera.CFrame.Position
		end
        --
		function Lorix:CursorOffset()
			if getgenv().UniversalSettings.CursorOffset.Enabled then
				local CursorOffsetX = tonumber(getgenv().UniversalSettings.CursorOffset.X)
				local CursorOffsetY = tonumber(getgenv().UniversalSettings.CursorOffset.Y)
                --
				return Vector2.new(CursorOffsetX, CursorOffsetY)
			else
				return Vector2.new(0, 0)
			end
		end
        --
		function Lorix:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
			local Parts = {}
			local Hitboxes = Hitboxes or {
				"Head",
				"Torso",
				"Arms",
				"Legs"
			}
            --
			for Index, Part in pairs(Character:GetChildren()) do
				if Part:IsA("BasePart") and Part ~= RootPart then
					if Find(Hitboxes, "Head") and Part.Name:lower():find("head") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif (Find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif (Find(Hitboxes, "Legs") and Part.Name:lower():find("foot")) then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, Part.Name) then
						Parts[Indexes and Part.Name or #Parts + 1] = Part
					end
				end
			end
            --
			return Parts
		end
        --
		function Lorix:ClientAlive(Humanoid)
			local Health = Humanoid.Health
            --
			return (Health > 0)
		end
		--
		function Lorix:GetCharacter(Player)
			return Player.Character
		end
        --
		function Lorix:ValidateClient(Player)
			local Object = Lorix:GetCharacter(Player)
			local Humanoid = (Object and Object:FindFirstChildWhichIsA("Humanoid"))
			local RootPart = (Humanoid and Humanoid.RootPart)
            --
			return Object, Humanoid, RootPart
		end
        --
		function Lorix:RayCast(Part, Origin, Ignore, Distance)
			local Ignore = Ignore or {}
			local Distance = Distance or 2000
            --
			local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
			local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
			if Hit and Hit:IsDescendantOf(Part.Parent) then
				return true, Hit
			else
				return false, Hit
			end
			return false, nil
		end
        --
		function Lorix:GetEquippedWeaponName(Player)
			local ch = Player.Character
			local tool = ch and ch:FindFirstChildWhichIsA("Tool") or false
			if tool then
				if string.find(tool.Name, "%[") and string.find(tool.Name, "%]") and not string.find(tool.name, "Wallet") and not string.find(tool.Name, "Phone") then
					local tname = string.split(string.split(tool.Name, "[")[2], "]")[1]
					return tname
				end
			else
				return nil
			end
		end
        --
		function Lorix:CalculateHitChance(Percent)
			Percent = math.floor(Percent)
			local Chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
			return Chance <= Percent / 100
		end
        --
		function Lorix:IsUsingAntiAim(Player)
			if getgenv().UniversalSettings.VelocityCalculationType == "Lorix" then
				return true
			else
				if (Player) and (Player.Character) then
					local part = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character:FindFirstChild("Torso")
					if part and State.Velocities[Player.Name] then
						local Difference = (- State.Velocities[Player.Name] - part.Velocity).Magnitude
						if Difference > 50 or Difference < - 50 then
							return true
						else
							return false
						end
                        --
					end
				end
			end
		end
        --
		function Lorix:CharacterEvent(Character)
			task.wait()
			if (Character) and Character:FindFirstChild("HumanoidRootPart") then
				local deltaTimeElapsed, deltaTime, previousTick, addingDeltaTime = 0, 0, 0, 0
				if State.Connect[Character.Name] ~= nil then
					State.Previous[Character.Name] = nil
					State.Velocities[Character.Name] = Vector3.new(0, 0, 0)
					State.Connect[Character.Name]:Disconnect()
					State.Connect[Character.Name] = nil
				end
				State.Connect[Character.Name] = Utility:Connection(game:GetService("RunService").RenderStepped, function()
					addingDeltaTime = game:GetService("RunService").Heartbeat:Wait()
					deltaTimeElapsed = deltaTimeElapsed + addingDeltaTime
					if deltaTimeElapsed >= 0.03 then
						deltaTimeElapsed = 0
						deltaTime = tick() - previousTick
						previousTick = tick()
						if Character:FindFirstChild("HumanoidRootPart") then
							local arguments = {
								Character.HumanoidRootPart.Position,
								Character.HumanoidRootPart.Position,
								deltaTime
							}
							if State.Previous[Character.Name] ~= nil then
								arguments[2] = State.Previous[Character.Name]
							end
							State.Velocities[Character.Name] = (arguments[1] - arguments[2]) / arguments[3]
							State.Previous[Character.Name] = Character.HumanoidRootPart.Position
						end
					end
				end)
			end
		end
        --
		function Lorix:GetVelocity(Player)
			if Player and Player.Character and Lorix:IsUsingAntiAim(Player) then
				if State.Velocities[Player.Name] then
					return State.Velocities[Player.Name]
				end
			elseif (Player.Character) and not Lorix:IsUsingAntiAim(Player) then
				local part = Player.Character.HumanoidRootPart or Player.Character:FindFirstChildWhichIsA("BasePart")
				return part.Velocity
			end
            --
			return Vector3.new(0, 0, 0)
		end
        --
		function Lorix:GetHitPosition(Mode)
			local Target = nil;
			local Hit = nil;
			local Hitpart = nil;
            --
			if Mode == "Redirect" then
				local Object, Humanoid, RootPart = Lorix:ValidateClient(PriorityRelationSilent)
				if (Object and Humanoid and RootPart) then
					Target = PriorityRelationSilent
                    --
					if getgenv().SilentAim.HitPartMode == "Nearest Point" then
						local Point = Lorix:GetNearestPointOnCharacter(Object, "Redirect")
						Hit = Point
					elseif getgenv().SilentAim.HitPartMode == "Nearest Part" then
						local Part = Lorix:GetClosestPartOnCharacter(Object, "Redirect")
						Hit = Part.Position
					else
						Hit = Object["Head"].Position
					end
                    --
					if not getgenv().SilentAim.PredictMovement then
						return Hit, Target
					else
						local Velocity = Lorix:GetVelocity(Target)
                        --
						if Velocity and Hit then
							return Vector3.new(Hit.X + (Velocity.X * getgenv().SilentAim.PredictionAmmount), getgenv().Safety.AntiFloorShot and Hit.Y or Hit.Y + (Velocity.Y * getgenv().SilentAim.PredictionAmmount), Hit.Z + (Velocity.Z * getgenv().SilentAim.PredictionAmmount)), Target
						end
					end
				end
			elseif Mode == "AssistCamera" then
				local Object, Humanoid, RootPart = Lorix:ValidateClient(PriorityRelationAssist)
				if (Object and Humanoid and RootPart) then
					Target = PriorityRelationAssist
                    --
					local Part = Lorix:GetClosestPartOnCharacter(Object, "Assist")
					Hit = Part.Position
					HitPart2 = Part
				end
                --
				if not getgenv().AimAssist.PredictMovement then
					return Hit, Target
				else
					local Velocity = Lorix:GetVelocity(Target)
                    --
					return Vector3.new(Hit.X + (Velocity.X * getgenv().AimAssist.PredictionAmmount), true and Hit.Y or Hit.Y + (Velocity.Y * getgenv().AimAssist.PredictionAmmount), Hit.Z + (Velocity.Z * getgenv().AimAssist.PredictionAmmount)), Target, HitPart2
				end
			elseif Mode == "AssistMouse" then
			end
            --
			return;
		end
		--
		function Lorix:LagServer(Increase)
			local Main, Spammed = {}, {}
			local function getmax(value)
				local eachTable = 499999
				if type(value) ~= "number" then
					return nil
				else
					local increasedValue = (eachTable / (value + 2))
					return increasedValue
				end
				return nil
			end
			table.insert(Spammed, {})
			other_table = Spammed[1]
			local maxValue, Limit = getmax(Increase), nil
			for i = 1, Increase do
				local empty = {}
				table.insert(other_table, empty)
				other_table = empty
			end
			if maxValue ~= nil then
				Limit = maxValue
			else
				Limit = 999999
			end
			for i = 1, Limit do
				table.insert(Main, Spammed)
			end
			game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(Main)
		end
        --
		function Lorix:IsInRange(range, model)
			local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
			local Distance, Part = math.huge, nil
			range = range * 10
			local Range = range / ((model.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) * 0.8
			local Position, Visible = game.Workspace.CurrentCamera:WorldToScreenPoint(model.HumanoidRootPart.Position)
			if Visible then
				local CurrentDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
				if CurrentDistance < Distance and CurrentDistance <= Range then
					Distance = CurrentDistance
					Lorix.Locals.CurrentRange = Range
					return true
				end
			end
			return false
		end
	end)()
    --
	LPH_NO_VIRTUALIZE(function()
		function Lorix:GetPlayers()
			return Players:GetPlayers()
		end
        --
		function Lorix:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, Target, PossibleTarget)
			local WallCheck = getgenv().Checks.Wall
			local VisibleCheck = getgenv().Checks.Visible
			local ForceFieldCheck = getgenv().Checks.ForceField
			local TeamCheck = getgenv().Checks.Team
			local AliveCheck = getgenv().Checks.Alive
			local CrewCheck = getgenv().Checks.Crew
            --
			if (TeamCheck and not Lorix:CheckTeam(Client, Player)) then
				return
			end
            --
			if (CrewCheck and Lorix:CheckCrew(Client, Player)) then
				return
			end
			--
			local Object, Humanoid, RootPart = Lorix:ValidateClient(Player)
            --
			if (Object and Humanoid and RootPart) then
				if (ForceFieldCheck and Object:FindFirstChildOfClass("ForceField")) or (AliveCheck and not Lorix:ClientAlive(Humanoid)) then
					return
				end
                --
				local RootPosition = (RootPart.CFrame.Position)
				local Position, Visible = Workspace.CurrentCamera:WorldToScreenPoint(RootPosition)
				local Position2 = Vector2.new(Position.X, Position.Y)
				local Magnitude = (MouseLocation - Position2).Magnitude
				local Distance = (Workspace.CurrentCamera.CFrame.Position - RootPosition).Magnitude
				local FOV = FieldOfView
				local DeadzoneFOV = Deadzone

				if (WallCheck and not (Lorix:RayCast(RootPart, Lorix:GetOrigin(Origin), {Lorix:GetCharacter(Client)}))) then return end
				--
				if (VisibleCheck and (Object.Head.Transparency == 1)) then return end
                --
				if Visible and Magnitude <= PossibleTarget.Magnitude then
					PossibleTarget = {
						Player = Player,
						Object = Object,
						Distance = Distance,
						Magnitude = Magnitude
					}
				end
                --
				if Visible then
					if ((not FOVCheckDisabled) and not (Magnitude <= FOV)) or not (Magnitude <= Target.Magnitude) then
						return
					end
					return {
						Player = Player,
						Object = Object,
						Distance = Distance,
						Magnitude = Magnitude
						}
				end
			end
		end
        --
		function Lorix:CheckFOV(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes)
			local Object, Humanoid, RootPart = Lorix:ValidateClient(Player)
            --
			if (Object and Humanoid and RootPart) then
				local RootPosition = (RootPart.CFrame.Position)
				local Position, Visible = Workspace.CurrentCamera:WorldToScreenPoint(RootPosition)
				local Position2 = Vector2.new(Position.X, Position.Y)
				local Magnitude = (MouseLocation - Position2).Magnitude
				local Distance = (Workspace.CurrentCamera.CFrame.Position - RootPosition).Magnitude
				local SelfAimAssistFOV = FieldOfView
				local SelfDeadzoneFOV = Deadzone
				local SelfMultiplier = 1
                --
				SelfAimAssistFOV = (SelfAimAssistFOV * SelfMultiplier)
				SelfDeadzoneFOV = (SelfDeadzoneFOV * SelfMultiplier)
                --
				if Visible then
					for Index2, Part in pairs(Lorix:GetBodyParts(Object, RootPart, false, Hitboxes)) do
						local HitboxPosition = Part.CFrame.p
                        --
						local Position3, Visible2 = Workspace.CurrentCamera:WorldToScreenPoint(HitboxPosition)
						local Position4 = Vector2.new(Position3.X, Position3.Y)
						local Magnitude2 = (MouseLocation - Position4).Magnitude
                        --
						if Position4 and Visible2 then
							if ((not FOVCheckDisabled) and (Magnitude2 <= SelfAimAssistFOV)) then
								return true
							end
						end
					end
				else
					return false
				end
			end
		end
        --
		function Lorix:UpdateFieldOfView()
			local ScreenSize = Workspace.CurrentCamera.ViewportSize
            --
			local FieldOfViewSilent = getgenv().FovSettings.Silent.Radius
			local FieldOfViewAssist = getgenv().FovSettings.Assist.Radius
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
            --
			Lorix.Locals.SilentAimFOV = ((FieldOfViewSilent / 100) * ScreenSize.Y)
			Lorix.Locals.AimAssistFOV = ((FieldOfViewAssist / 100) * ScreenSize.Y)
			Lorix.Locals.DeadzoneFOV = (Lorix.Locals.AimAssistFOV * 0.9) * (Deadzone / 100)
            --
			Lorix.Locals.VisualSilentAimFOV = (Lorix.Locals.SilentAimFOV)
			Lorix.Locals.VisualAimAssistFOV = (Lorix.Locals.AimAssistFOV)
			Lorix.Locals.VisualDeadzoneFOV = (Lorix.Locals.DeadzoneFOV)
		end
        --
		function Lorix:GetClosestPartOnCharacter(character, mode)
			local distance, part = 9e99, nil
			local parts;
			if mode == "Redirect" then
				parts = Lorix:GetBodyParts(character, character.Humanoid.RootPart, false, getgenv().SilentAim.HitParts)
			elseif mode == "Assist" then
				parts = Lorix:GetBodyParts(character, character.Humanoid.RootPart, false, getgenv().AimAssist.HitParts)
			end
			if mode == "Redirect" then
				if getgenv().SilentAim.ClosestToCursorHitpart then
					for i, v in pairs(character:GetChildren()) do
						if v:IsA("BasePart") then
							local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
							if onscreen then
								local pos = Vector2.new(_.X, _.Y)
								local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
								if mag < distance then
									part = v
									distance = mag
								end
							end
						end
					end
				else
					for i, v in pairs(parts) do
						local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
						if onscreen then
							local pos = Vector2.new(_.X, _.Y)
							local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
							if mag < distance then
								part = v
								distance = mag
							end
						end
					end
				end
			elseif mode == "Assist" then
				if getgenv().AimAssist.ClosestToCursorHitpart then
					for i, v in pairs(character:GetChildren()) do
						if v:IsA("BasePart") then
							local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
							if onscreen then
								local pos = Vector2.new(_.X, _.Y)
								local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
								if mag < distance then
									part = v
									distance = mag
								end
							end
						end
					end
				else
					for i, v in pairs(parts) do
						local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
						if onscreen then
							local pos = Vector2.new(_.X, _.Y)
							local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
							if mag < distance then
								part = v
								distance = mag
							end
						end
					end
				end
			end
			return part
		end
        --
		function Lorix:GetNearestPointOnCharacter(Character, Mode)
			local NearestPart = Lorix:GetClosestPartOnCharacter(Character, Mode)
            --
			if NearestPart ~= nil then
                --
				local Hit, Half = Mouse.Hit.p, NearestPart.Size * 0.5
                --
				local Transform = NearestPart.CFrame:PointToObjectSpace(Hit)
                --
				local NearestPosition = NearestPart.CFrame * Vector3.new(math.clamp(Transform.X, - Half.X, Half.X), math.clamp(Transform.Y, - Half.Y, Half.Y), math.clamp(Transform.Z, - Half.Z, Half.Z))
                --
				return NearestPosition
			end
		end
        --
		function Lorix:GetSilentAimTarget()
			local TargetSilent = {
				Player = nil,
				Object = nil,
				Part = nil,
				Vector = nil,
				Magnitude = 9e99
			}
            --
			local MouseLocation = Utility:MousePosition(true)
            --
			local UsePredicton = getgenv().SilentAim.PredictMovement
			local PredictionAmmoumt = getgenv().SilentAim.PredictionAmmount
			local FieldOfView = getgenv().FovSettings.Silent.Radius
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
			local FOVType = getgenv().FovSettings.Type
			local Dynamic = getgenv().FovSettings.DynamicRadius
			local Origin = "Camera"
            --
			local FOVCheckDisabled = getgenv().FovSettings.Silent.Radius == 0
			local DeadzoneCheckDisabled = getgenv().FovSettings.Deadzone.Radius == 0
			local FieldOfView = (Lorix.Locals.SilentAimFOV / 2)
			local Deadzone = (Lorix.Locals.DeadzoneFOV / 2)
			local Hitboxes = getgenv().SilentAim.HitParts
            --
			local PossibleTargetSilent = {
				Player = nil,
				Object = nil,
				Magnitude = 9e99
			}
            --
			local Objects = Lorix:GetPlayers()
            --
			for Index, Player in pairs(Objects) do
				if Player ~= Client then
					local Validated = Lorix:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, TargetSilent, PossibleTargetSilent)
                    --
					if Validated then
						TargetSilent = Validated
					end
				end
			end
            --
			if TargetSilent.Player and TargetSilent.Object then
				PossibleTargetSilent = {
					Player = TargetSilent.Player,
					Object = TargetSilent.Object,
					Distance = TargetSilent.Distance
				}
                --
				Lorix.Locals.TargetSilent = TargetSilent
			else
				Lorix.Locals.TargetSilent = nil
			end
            --
			if PossibleTargetSilent and PossibleTargetSilent.Distance then
				Lorix.Locals.PossibleTargetSilent = PossibleTargetSilent
			else
				Lorix.Locals.PossibleTargetSilent = nil
			end
		end
        --
		function Lorix:GetAimAssistTarget(Priority)
			local TargetAssist = {
				Player = nil,
				Object = nil,
				Part = nil,
				Vector = nil,
				Magnitude = 9e99
			}
            --
			local MouseLocation = Utility:MousePosition(true)
            --
			local UsePredicton = getgenv().AimAssist.PredictMovement
			local PredictionAmmoumt = getgenv().AimAssist.PredictionAmmount
			local FieldOfView = getgenv().FovSettings.Assist.Radius
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
			local FOVType = getgenv().FovSettings.Type
			local Dynamic = getgenv().FovSettings.DynamicRadius
			local Origin = "Camera"
            --
			local FOVCheckDisabled = getgenv().FovSettings.Assist.Radius == 0
			local DeadzoneCheckDisabled = getgenv().FovSettings.Deadzone.Radius == 0
			local FieldOfView = (Lorix.Locals.AimAssistFOV / 2)
			local Deadzone = (Lorix.Locals.DeadzoneFOV / 2)
			local Hitboxes = getgenv().AimAssist.HitParts
            --
			local PossibleTargetAssist = {
				Player = nil,
				Object = nil,
				Magnitude = 9e99
			}
            --
			local Objects = Priority and {
				Priority
			} or Lorix:GetPlayers()
            --
			for Index, Player in pairs(Objects) do
				if Player ~= Client then
					local Validated = Lorix:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, TargetAssist, PossibleTargetAssist)
                    --
					if Validated then
						TargetAssist = Validated
					end
				end
			end
            --
			if TargetAssist.Player and TargetAssist.Object then
				PossibleTargetAssist = {
					Player = TargetAssist.Player,
					Object = TargetAssist.Object,
					Distance = TargetAssist.Distance
				}
                --
				Lorix.Locals.TargetAssist = TargetAssist
			else
				Lorix.Locals.TargetAssist = nil
			end
            --
			if PossibleTargetAssist and PossibleTargetAssist.Distance then
				Lorix.Locals.PossibleTargetAssist = PossibleTargetAssist
			else
				Lorix.Locals.PossibleTargetAssist = nil
			end
		end
        --
		function Lorix:ActivateAimAssist()
			if getgenv().UniversalSettings.Enabled and getgenv().AimAssist.Enabled then
				if PriorityRelationAssist and PriorityRelationAssist.Character then
					local Object, Humanoid, RootPart = Lorix:ValidateClient(PriorityRelationAssist)
                    --
					if (Object and Humanoid and RootPart) then
						if not CurrentGame.Functions.CheckKnocked(PriorityRelationAssist) then
							local Stutter = getgenv().AimAssist.StutterAmmount
							local Deadzone = getgenv().FovSettings.Deadzone.Radius
							if not ((not Stutter == 0) and not ((tick() - Lorix.Locals.LastStutter) >= (Stutter / 1000))) then
								Lorix.Locals.LastStutter = tick()
                                --
								if getgenv().AimAssist.SafeMode and UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end
								--
								local MouseLocation = Utility:MousePosition(true)
								local HitPosition, CurrentTarget, HitPart;
								HitPosition, CurrentTarget, HitPart = Lorix:GetHitPosition("AssistCamera")
                                --
								if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then
									return
								end
								if (getgenv().Checks.Alive and not Lorix:ClientAlive(Humanoid)) then
									return
								end
								if (getgenv().Checks.Friend and not Lorix:CheckFriend(PriorityRelationAssist)) then
									return
								end
								if (getgenv().Checks.Crew and not Lorix:CheckCrew(PriorityRelationAssist)) then
									return
								end
                                --
								local ClosestPartToCharThing = Lorix:GetClosestPartOnCharacter(CurrentTarget.Character, "Assist")
                                --
								if (getgenv().Checks.Wall and not Lorix:RayCast(ClosestPartToCharThing, Lorix:GetOrigin("Camera"), {
									Lorix:GetCharacter(Client),
									Lorix:GetIgnore(true)
								})) then
									return
								end
                                --
								if getgenv().AimAssist.Jitter.Enabled then
									local MainJitter = CFrame.new(CurrentCamera.CFrame.p, HitPosition + Vector3.new(
										math.random(-getgenv().AimAssist.Jitter.X, getgenv().AimAssist.Jitter.X), math.random(- getgenv().AimAssist.Jitter.Y, getgenv().AimAssist.Jitter.Y), math.random(- getgenv().AimAssist.Jitter.Z, getgenv().AimAssist.Jitter.Z)) * 0.1)
									CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(MainJitter, getgenv().AimAssist.Smoothness, Enum.EasingStyle[getgenv().AimAssist.EasingStyle], Enum.EasingDirection.InOut, Enum.EasingStyle[getgenv().AimAssist.EasingStyle], Enum.EasingDirection.Out)
								else
									local Main = CFrame.new(CurrentCamera.CFrame.p, HitPosition)
									CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(Main, getgenv().AimAssist.Smoothness, Enum.EasingStyle[getgenv().AimAssist.EasingStyle], Enum.EasingDirection.InOut, Enum.EasingStyle[getgenv().AimAssist.EasingStyle], Enum.EasingDirection.Out)
								end
							end
						end
					end
				end
			end
		end
	end)()
    --
	do -- // Game LUAs
		local HoodGames = {
			"Da Hood",
			"Hood Customs",
			"Hood Trainer",
			"Dah Hood",
			"Untitled-Hood",
			"Da Hood Aim Trainer"
		}
		local HoodGamesEditedSys = {
			"Hood Modded"
		}
		local Games = {
			[{2788229376, 7213786345, 9825515356, 9824221333, 10773759206, 9183932460, 10355218822, 5602055394, 12243533824}] = {Name = "HoodGames", Func = function()
				RemoteEvent = CurrentGame.Functions.GetRemote();
                --
				function Lorix:DisconnectPreviousToolConnections()
					if State.Connections["Tool"] then
						State.Connections["Tool"]:Disconnect()
					end
					State.Connections["Tool"] = nil
				end
                --
				function Lorix:CreateConnectionTool(Tool)
					wait(0.1)
					Lorix:DisconnectPreviousToolConnections()
					State.Connections["Tool"] = Utility:Connection(Tool.Activated, function()
						if getgenv().UniversalSettings.Enabled and getgenv().SilentAim.Enabled and getgenv().SilentAim.Mode == "Safe" then
							if PriorityRelationSilent and PriorityRelationSilent.Character then
								local Object, Humanoid, RootPart = Lorix:ValidateClient(PriorityRelationSilent)
								--
								if (Object and Humanoid and RootPart) then
									if not CurrentGame.Functions.CheckKnocked(PriorityRelationSilent) then
										local HitPosition, CurrentTarget = Lorix:GetHitPosition("Redirect")
										--
										if (not Lorix:CalculateHitChance(getgenv().SilentAim.HitChance)) then
											return
										end
										--
										local RemoteArgs = {}
										if (table.find(HoodGames, CurrentGame.Name)) then
											RemoteArgs = {
												CurrentGame.MouseArguments,
												HitPosition
											}
										elseif (table.find(HoodGamesEditedSys, CurrentGame.Name)) then
											RemoteArgs = {
												CurrentGame.MouseArguments,
												HitPosition,
												"P"
											}
										end
										--
										if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then
											return
										end
										if (getgenv().Checks.Alive and not Lorix:ClientAlive(Humanoid)) then
											return
										end
										if (getgenv().Checks.Friend and not Lorix:CheckFriend(PriorityRelationSilent)) then
											return
										end
										if (getgenv().Checks.Crew and not Lorix:CheckCrew(PriorityRelationSilent)) then
											return
										end
										--
										local ClosestPartToCharThing = Lorix:GetClosestPartOnCharacter(CurrentTarget.Character, "Redirect")
										--
										if (getgenv().Checks.Wall and not Lorix:RayCast(ClosestPartToCharThing, Lorix:GetOrigin("Camera"), {
											Lorix:GetCharacter(Client),
											Lorix:GetIgnore(true)
										})) then
											return
										end
										--
										if PriorityRelationSilent and PriorityRelationSilent.Character then
											if getgenv().FovSettings.Type == "Static" and Lorix:CheckFOV(PriorityRelationSilent, Utility:MousePosition(true), (Lorix.Locals.SilentAimFOV), (Lorix.Locals.DeadzoneFOV / 2), getgenv().FovSettings.Silent.Radius == 0, getgenv().SilentAim.HitParts) then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											elseif getgenv().FovSettings.Type == "Dynamic" and Lorix:IsInRange(getgenv().FovSettings.DynamicRadius, CurrentTarget.Character) and HitPosition ~= nil then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											end
										end
									end
								end
							end
						end
					end)
				end
                --
				function Lorix:CharacterAddedEvent(Character)
					Utility:Connection(Character.DescendantAdded, function(Descendant)
						if Descendant:IsA("Tool") and Descendant:FindFirstChildWhichIsA("Script") then
							if CurrentGame.HoodGame and Lorix:GetEquippedWeaponName(Client) ~= nil and getgenv().HoodGameSettings.GunSettings.Enabled then
								if CurrentGame.Name == "Da Hood" or CurrentGame.Name == "Hood Customs" or CurrentGame.Name == "Untitled-Hood" or CurrentGame.Name == "Hood Trainer" then
									local EquippedWeapon = Lorix:GetEquippedWeaponName(Client)
									if EquippedWeapon == "Double-Barrel SG" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.hitChance
									elseif EquippedWeapon == "Revolver" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.Rev.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.Rev.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.Rev.hitChance
									elseif EquippedWeapon == "SMG" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.SMG.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.SMG.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.SMG.hitChance
									elseif EquippedWeapon == "Shotgun" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.ShotGun.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.ShotGun.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.ShotGun.hitChance
									elseif EquippedWeapon == "TacticalShotgun" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.hitChance
									end
								end
							end
							Lorix:CreateConnectionTool(Descendant)
						end
					end)
				end
                --
				Utility:Connection(Client.CharacterAdded, function(Character)
					Lorix:CharacterAddedEvent(Character)
				end)
                --
				if Client.Character then
					Lorix:CharacterAddedEvent(Client.Character)
				end
                --
				if getgenv().Safety.KickOnStaffJoin then
					local ModPowers = { a = 'Hearing', b = 'HeroArc', c = 'ReverseFlashOutfit', d = 'Dash Punch', e = 'Speed Force', f = 'Claws', g = 'WolverineOutfit', h = 'FirePower', i = 'Super Punch', j = 'Timeskip', k = 'InvisibleHit', l = 'SpiritOrb', m = 'Fly', n = 'AdminBan', o = 'Glide', p = 'InvisibleHit', q = 'SpiritOrb', r = 'SuperPunch' }
                    --
					for i, v in pairs(game.Players:GetChildren()) do
						for i, p in pairs(v.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if p.Name == d then
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end
                    --
					Utility:Connection(Players.PlayerAdded, function(Player)
						repeat wait() until Player.Character
                        --
						for i, v in pairs(Player.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if v.Name == d then
								-- Client:Kick(Player.Name.. 'is a mod')
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end)
				end
			end},
			[{11228173542, 10876054559, 4790960806, 5296589146, 5973754207, 6580968658, 5961745093, 9582807828, 9483937523, 9682207432, 11401909704}] = {Name = "Prime", Func = function()
			end},
			[{292439477}] = {Name = "Phantom Forces", Func = function()
			end},
			[{11127650206}] = {Name = "Vanity", Func = function()
				local Characters = Workspace:FindFirstChild("Players")
				--
				function Lorix:GetCharacter(Player)
					return Characters:FindFirstChild(Player.Name)
				end
			end},
			[{11883610532, 12128125888, 12543953865}] = {Name = "Five Duels", Func = function()
				RemoteEvent = CurrentGame.Functions.GetRemote();
                --
				function Lorix:DisconnectPreviousToolConnections()
					if State.Connections["Tool"] then
						State.Connections["Tool"]:Disconnect()
					end
					State.Connections["Tool"] = nil
				end
                --
				function Lorix:CreateConnectionTool(Tool)
					wait(0.1)
					Lorix:DisconnectPreviousToolConnections()
					State.Connections["Tool"] = Utility:Connection(Tool.Activated, function()
						if getgenv().UniversalSettings.Enabled and getgenv().SilentAim.Enabled and getgenv().SilentAim.Mode == "Safe" then
							if PriorityRelationSilent and PriorityRelationSilent.Character then
								local Object, Humanoid, RootPart = Lorix:ValidateClient(PriorityRelationSilent)
								--
								if (Object and Humanoid and RootPart) then
									if not CurrentGame.Functions.CheckKnocked(PriorityRelationSilent) then
										local HitPosition, CurrentTarget = Lorix:GetHitPosition("Redirect")
										--
										if (not Lorix:CalculateHitChance(getgenv().SilentAim.HitChance)) then return end
										--
										local RemoteArgs = {HitPosition}
										local RemoteArgs2 = {
											[1] = "shoot",
											[2] = {
												[1] = HitPosition
											}
										}
										--
										if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then return end
										if (getgenv().Checks.Alive and not Lorix:ClientAlive(Humanoid)) then return end
										if (getgenv().Checks.Friend and not Lorix:CheckFriend(PriorityRelationSilent)) then return end
										--
										local ClosestPartToCharThing = Lorix:GetClosestPartOnCharacter(CurrentTarget.Character, "Redirect")
										--
										if (getgenv().Checks.Wall and not Lorix:RayCast(ClosestPartToCharThing, Lorix:GetOrigin("Camera"), {
											Lorix:GetCharacter(Client),
											Lorix:GetIgnore(true)
										})) then return end
										--
										if PriorityRelationSilent and PriorityRelationSilent.Character then
											if getgenv().FovSettings.Type == "Static" and Lorix:CheckFOV(PriorityRelationSilent, Utility:MousePosition(true), (Lorix.Locals.SilentAimFOV), (Lorix.Locals.DeadzoneFOV / 2), getgenv().FovSettings.Silent.Radius == 0, getgenv().SilentAim.HitParts) then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
												game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteEvent"):FireServer(table.unpack(RemoteArgs2))
											elseif getgenv().FovSettings.Type == "Dynamic" and Lorix:IsInRange(getgenv().FovSettings.DynamicRadius, CurrentTarget.Character) and HitPosition ~= nil then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											end
										end
									end
								end
							end
						end
					end)
				end
                --
				function Lorix:CharacterAddedEvent(Character)
					Utility:Connection(Character.DescendantAdded, function(Descendant)
						if Descendant:IsA("Tool") and Descendant:FindFirstChildWhichIsA("Script") then
							if CurrentGame.HoodGame and Lorix:GetEquippedWeaponName(Client) ~= nil and getgenv().HoodGameSettings.GunSettings.Enabled then
								if CurrentGame.Name == "Da Hood" or CurrentGame.Name == "Hood Customs" or CurrentGame.Name == "Untitled-Hood" or CurrentGame.Name == "Hood Trainer" then
									local EquippedWeapon = Lorix:GetEquippedWeaponName(Client)
									if EquippedWeapon == "Double-Barrel SG" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.DoubleBarrel.hitChance
									elseif EquippedWeapon == "Revolver" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.Rev.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.Rev.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.Rev.hitChance
									elseif EquippedWeapon == "SMG" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.SMG.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.SMG.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.SMG.hitChance
									elseif EquippedWeapon == "Shotgun" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.ShotGun.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.ShotGun.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.ShotGun.hitChance
									elseif EquippedWeapon == "TacticalShotgun" then
										getgenv().FovSettings.Silent.Radius = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.FOV
										getgenv().FovSettings.Assist.Radius = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.FOV
										--
										getgenv().SilentAim.HitChance = getgenv().HoodGameSettings.GunSettings.TacticalShotgun.hitChance
									end
								end
							end
							Lorix:CreateConnectionTool(Descendant)
						end
					end)
				end
                --
				Utility:Connection(Client.CharacterAdded, function(Character)
					Lorix:CharacterAddedEvent(Character)
				end)
                --
				if Client.Character then
					Lorix:CharacterAddedEvent(Client.Character)
				end
                --
				if getgenv().Safety.KickOnStaffJoin then
					local ModPowers = { a = 'Hearing', b = 'HeroArc', c = 'ReverseFlashOutfit', d = 'Dash Punch', e = 'Speed Force', f = 'Claws', g = 'WolverineOutfit', h = 'FirePower', i = 'Super Punch', j = 'Timeskip', k = 'InvisibleHit', l = 'SpiritOrb', m = 'Fly', n = 'AdminBan', o = 'Glide', p = 'InvisibleHit', q = 'SpiritOrb', r = 'SuperPunch' }
                    --
					for i, v in pairs(game.Players:GetChildren()) do
						for i, p in pairs(v.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if p.Name == d then
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end
                    --
					Utility:Connection(Players.PlayerAdded, function(Player)
						repeat wait() until Player.Character
                        --
						for i, v in pairs(Player.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if v.Name == d then
								-- Client:Kick(Player.Name.. 'is a mod')
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end)
				end
			end},
		}
        --
		local PlaceId = game.PlaceId
        --
		function Lorix:LoadLuas()
			for Index, Value in pairs(Games) do
				if Find(Index, PlaceId) then
					Utility:ThreadFunction(Value.Func, "Lx01")
				end
			end
		end
	end
end
--
do -- // Visuals
	function Visuals:Update()
		local MouseLocation = Utility:MousePosition(true)
        --
		if getgenv().FovSettings.Silent.Visible and getgenv().SilentAim.Enabled and getgenv().UniversalSettings.Enabled then
			local SilentAimColor1, SilentAimTransparency1 = Color3.fromRGB(93, 62, 152), 0.6
			local SilentAimColor2, SilentAimTransparency2 = Color3.fromRGB(93, 62, 152), 0.6
			local SilentAimSides = 50
			local FieldOfViewSilent = Lorix.Locals.VisualSilentAimFOV / 2
            --
			if not PriorityRelationSilent then
				SilentAimCircle.Position = MouseLocation
			end
			SilentAimCircle.Color = SilentAimColor1
			SilentAimCircle.Transparency = 1 - SilentAimTransparency1
			SilentAimCircle.Radius = FieldOfViewSilent
			SilentAimCircle.NumSides = SilentAimSides
			SilentAimCircle.Filled = getgenv().FovSettings.Silent.Filled
			SilentAimCircle.Visible = true
            --
			if not PriorityRelationSilent then
				SilentAimOutline.Position = MouseLocation
			end
			SilentAimOutline.Color = SilentAimColor2
			SilentAimOutline.Transparency = 1 - SilentAimTransparency2
			SilentAimOutline.Radius = FieldOfViewSilent
			SilentAimOutline.NumSides = SilentAimSides
			SilentAimOutline.Visible = true
			if getgenv().FovSettings.Silent.Filled then
				SilentAimCircle.Thickness = 0.9
				SilentAimOutline.Thickness = 0.9
			else
				SilentAimCircle.Thickness = 1
				SilentAimOutline.Thickness = 1.5
			end
		else
			SilentAimCircle.Visible = false
			SilentAimOutline.Visible = false
		end
        --
		if getgenv().FovSettings.Assist.Visible and getgenv().AimAssist.Enabled and getgenv().UniversalSettings.Enabled then
			local AimAssistColor1, AimAssistTransparency1 = Color3.fromRGB(0, 191, 255), 0.6
			local AimAssistColor2, AimAssistTransparency2 = Color3.fromRGB(0, 191, 255), 0.6
			local AimAssistSides = 50
			local FieldOfViewAssist = Lorix.Locals.VisualAimAssistFOV / 2
            --
			if not PriorityRelationAssist then
				AimAssistCircle.Position = MouseLocation
			end
			AimAssistCircle.Color = AimAssistColor1
			AimAssistCircle.Transparency = 1 - AimAssistTransparency1
			AimAssistCircle.Radius = FieldOfViewAssist
			AimAssistCircle.NumSides = AimAssistSides
			AimAssistCircle.Filled = getgenv().FovSettings.Assist.Filled
			AimAssistCircle.Visible = true
		else
			AimAssistCircle.Visible = false
		end
        --
		if getgenv().AimAssist.Deadzone and getgenv().FovSettings.Deadzone.Visible and getgenv().UniversalSettings.Enabled then
			local DeadzoneColor1, DeadzoneTransparency1 = Color3.fromRGB(25, 25, 25), 0.6
			local DeadzoneColor2, DeadzoneTransparency2 = Color3.fromRGB(25, 25, 25), 0.6
			local AimAssistSides = 50
			local FieldOfView = Lorix.Locals.VisualDeadzoneFOV / 2
            --
			DeadzoneCircle.Position = MouseLocation
			DeadzoneCircle.Color = DeadzoneColor1
			DeadzoneCircle.Transparency = 1 - DeadzoneTransparency1
			DeadzoneCircle.Radius = FieldOfView
			DeadzoneCircle.NumSides = AimAssistSides
			DeadzoneCircle.Visible = true
            --
			DeadzoneOutline.Position = MouseLocation
			DeadzoneOutline.Color = DeadzoneColor2
			DeadzoneOutline.Transparency = 1 - DeadzoneTransparency2
			DeadzoneOutline.Radius = FieldOfView
			DeadzoneOutline.NumSides = AimAssistSides
			DeadzoneOutline.Visible = getgenv().FovSettings.Deadzone.Visible
		else
			DeadzoneCircle.Visible = false
			DeadzoneOutline.Visible = false
		end
        --
		if getgenv().UniversalSettings.Enabled and getgenv().SilentAim.SilentAimVisualizer and getgenv().SilentAim.Enabled then
			if PriorityRelationSilent and PriorityRelationSilent.Character then
				local HitPosition, CurrentTarget = Lorix:GetHitPosition("Redirect")
				local Velocity = Lorix:GetVelocity(CurrentTarget)
				local Vector;
                --
				if getgenv().SilentAim.PredictMovement then
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition) + (Velocity * getgenv().SilentAim.PredictionAmmount)
				else
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition)
				end
                --
				TargetDot.Visible = true
				TargetDot.Position = Vector2.new(Vector.X, Vector.Y)
			else
				TargetDot.Visible = false
			end
		else
			TargetDot.Visible = false
		end
        --
		if getgenv().UniversalSettings.Enabled and getgenv().SilentAim.Mode2 and getgenv().SilentAim.Enabled then
			local MouseLocation = Utility:MousePosition(true)
			if PriorityRelationSilent and PriorityRelationSilent.Character then
				local HitPosition, CurrentTarget = Lorix:GetHitPosition("Redirect")
				local Velocity = Lorix:GetVelocity(CurrentTarget)
				local Vector;
                --
				if getgenv().SilentAim.PredictMovement then
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition) + (Velocity * getgenv().SilentAim.PredictionAmmount)
				else
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition)
				end
                --
				SilentAimCircle.Position = Vector2.new(Vector.X, Vector.Y)
				SilentAimOutline.Position = Vector2.new(Vector.X, Vector.Y)
				AimAssistCircle.Position = Vector2.new(Vector.X, Vector.Y)
			else
				SilentAimCircle.Position = MouseLocation
				SilentAimOutline.Position = MouseLocation
				AimAssistCircle.Position = MouseLocation
			end
		else
			SilentAimCircle.Position = MouseLocation
			SilentAimOutline.Position = MouseLocation
			AimAssistCircle.Position = MouseLocation
		end
	end
    --
	function Visuals:Unload()
		SilentAimCircle:Remove()
		SilentAimOutline:Remove()
        --
		AimAssistCircle:Remove()
        --
		DeadzoneCircle:Remove()
		DeadzoneOutline:Remove()
        --
		TargetDot:Remove()
	end
end
--
do -- // Main
	Lorix:LoadLuas()
    --
	do -- Connections
		Utility:Connection(UserInputService.InputBegan, function(Input, Processed)
			if not Processed then
				if getgenv().Safety.PanicBindEnabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Panic:upper()] then
					Lorix.Locals.PanicMode = not Lorix.Locals.PanicMode
					getgenv().UniversalSettings.Enabled = not getgenv().UniversalSettings.Enabled
				elseif getgenv().Safety.UnloadBindEnabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Unload:upper()] then
					Lorix:UnloadCheat()
				elseif getgenv().UniversalSettings.Enabled and getgenv().FakeSpike.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.FakeSpike:upper()] then
					if getgenv().FakeSpike.RealSpike then
						Lorix:LagServer(getgenv().FakeSpike.FakeSpikeAmmount)
					else
						Network.IncomingReplicationLag = getgenv().FakeSpike.LagAmmount
						task.wait(1.5)
						Network.IncomingReplicationLag = 0
					end
				elseif getgenv().UniversalSettings.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.TargetBind:upper()] then
					if getgenv().SilentAim.Enabled and getgenv().UniversalSettings.TargetMode ~= "FOV" then
						if PriorityRelationSilent then
							PriorityRelationSilent = nil
							Lorix.Locals.TargetSilent = nil
						else
							Lorix:GetSilentAimTarget()
                            --
							if Lorix.Locals.TargetSilent then
								PriorityRelationSilent = Lorix.Locals.TargetSilent.Player
							else
								PriorityRelationSilent = nil
							end
						end
					end
                    --
					if getgenv().AimAssist.Enabled and getgenv().UniversalSettings.TargetMode ~= "FOV" then
						if PriorityRelationAssist then
							PriorityRelationAssist = nil
							Lorix.Locals.TargetAssist = nil
						else
							Lorix:GetAimAssistTarget()
                            --
							if Lorix.Locals.TargetAssist then
								PriorityRelationAssist = Lorix.Locals.TargetAssist.Player
							else
								PriorityRelationAssist = nil
							end
						end
					end
				end
			end
		end)
        --
		if CurrentGame.HoodGame then
			local Cameras = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule):GetCameras()
			local Controller = Cameras.activeCameraController
            --
			Utility:Connection(UserInputService.InputBegan, function(Input, Processed)
				if not Processed then
					if getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and getgenv().Macro.BypassMacroAbuse and getgenv().Macro.Type ~= "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["I"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance - 5);
					elseif getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and getgenv().Macro.BypassMacroAbuse and getgenv().Macro.Type ~= "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["O"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance + 5);
					elseif getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and getgenv().Macro.Type == "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["I"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance - 0.6);
					elseif getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and getgenv().Macro.Type == "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["O"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance + 0.6);
					elseif getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Macro:upper()] then
						Lorix.Locals.Macro = not Lorix.Locals.Macro
                        --
						repeat
							game:GetService("RunService").Heartbeat:wait()
							keypress(73)
							game:GetService("RunService").Heartbeat:wait()
							keypress(79)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(73)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(79)
							game:GetService("RunService").Heartbeat:wait()
						until not Lorix.Locals.Macro
					elseif getgenv().UniversalSettings.Enabled and getgenv().Macro.Enabled and getgenv().Macro.NoClipMacro and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.NoClipMacro:upper()] then
						Lorix.Locals.NoClipMacro = not Lorix.Locals.NoClipMacro
						--
						repeat
							game:GetService("RunService").Heartbeat:wait()
							keypress(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keypress(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(0x33)
							game:GetService("RunService").Heartbeat:wait()
						until not Lorix.Locals.NoClipMacro
					end
				end
			end)
		end
        --
		Utility:Connection(Client.Chatted, function(Chat)
			local ChatSent = Split(Lower(Chat), " ")
			if getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.SilentPred and tonumber(ChatSent[2]) ~= nil then
				getgenv().SilentAim.PredictionAmmount = tonumber(ChatSent[2])
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.SilentFovSize and tonumber(ChatSent[2]) ~= nil then
				getgenv().FovSettings.Silent.Radius = tonumber(ChatSent[2])
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.SilentHitChance and tonumber(ChatSent[2]) ~= nil then
				getgenv().SilentAim.HitChance = tonumber(ChatSent[2])
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.AssistFOVSize and tonumber(ChatSent[2]) ~= nil then
				getgenv().FovSettings.Assist.Radius = tonumber(ChatSent[2])
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.ToggleFOVSilent then
				getgenv().FovSettings.Silent.Visible = not getgenv().FovSettings.Silent.Visible
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.ToggleFOVAssist then
				getgenv().FovSettings.Assist.Visible = not getgenv().FovSettings.Assist.Visible
			elseif getgenv().ChatCommands.Enabled and ChatSent[1] == getgenv().ChatCommands.ToggleAllFov then
				getgenv().FovSettings.Assist.Visible = not getgenv().FovSettings.Assist.Visible
				getgenv().FovSettings.Silent.Visible = not getgenv().FovSettings.Silent.Visible
			end
		end)
        --
		task.spawn(function()
			LPH_JIT_MAX(function()
				local Memory = {
					Current = tonumber(math.random(700, 900) .. "." .. tostring(math.random(10, 99))),
					Base = math.random(700, 900),
					History = {},
					Display = tonumber(math.random(700, 900) .. "." .. tostring(math.random(10, 99)))
				}
				local function decimalRandom(minimum, maximum)
					return math.random() * (maximum - minimum) + minimum
				end
                --
				local getAverageMemory = function()
					local Average = 0
					for i, v in pairs(Memory.History) do
						Average += v
					end
					return Average / # Memory.History
				end
                --
				local getNewMemory = function()
					local random, random_chance = math.random(1, 3), math.random(1, 3)
					if random == 1 or random == 2 then
						if random_chance == 3 and tonumber(Memory.Current) ~= nil then
							Memory.Current = tostring(math.floor(tonumber(Memory.Current)) .. "." .. math.random(10, 99))
						else
							Memory.Current = tostring(math.random(Memory.Base - 4, Memory.Base + 3)) .. "." .. tostring(math.random(10, 99))
						end
						if # Memory.History == 10 then
							table.remove(Memory.History, 10)
						end
						table.insert(Memory.History, tonumber(Memory.Current))
					end
					return Memory.Current
				end
                --
				local MemoryViewer = nil
                --
				repeat
					wait()
				until game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("PerformanceStats")
                --
				for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
					if v.Name == "PS_Button" then
						if v.StatsMiniTextPanelClass.TitleLabel.Text == "Mem" then
							Utility:Connection(RunService.RenderStepped, function()
								LPH_JIT_MAX(function()
									if getgenv().UniversalSettings.MemorySpoof then
										v.StatsMiniTextPanelClass.ValueLabel.Text = Memory.Display .. " MB"
									end
								end)()
							end)
							MemoryViewer = v.StatsMiniTextPanelClass.ValueLabel
						end
                        --
						if v.StatsMiniTextPanelClass.TitleLabel.Text == "Ping" then
							Utility:Connection(v.StatsMiniTextPanelClass.ValueLabel:GetPropertyChangedSignal("Text"), function()
								if getgenv().UniversalSettings.MemorySpoof then
									if MemoryViewer ~= nil then
										local New = getNewMemory()
										Memory.Display = tostring(New)
										MemoryViewer.Text = New .. " MB"
									end
								end
							end)
						end
					end
				end
                --
				Utility:Connection(RunService.RenderStepped, function()
					LPH_JIT_MAX(function()
						if getgenv().UniversalSettings.MemorySpoof then
							local s, e = pcall(function()
								if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Memory" then
									for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
										if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
											v.Label.Text = "Current: " .. Memory.Current .. " MB"
										end
										if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
											v.Label.Text = "Average: " .. string.sub(getAverageMemory(), 1, 6) .. " MB"
										end
									end
								end
							end)
							pcall(function()
								game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.TopBar.LiveStatsModule["MemoryUsage_MB"].Text = math.round(tonumber(Memory.Current)) .. " MB"
							end)
						end
					end)()
				end)
			end)()
		end)
        --
		Utility:Connection(RunService.RenderStepped, function()
			LPH_JIT_MAX(function()
				if getgenv().UniversalSettings.Enabled then
					if getgenv().SilentAim.Enabled or getgenv().AimAssist.Enabled then
						Utility:ThreadFunction(Lorix.UpdateFieldOfView, "2x01")
					end --// Update FOV
                    --
					if getgenv().SilentAim.Enabled and getgenv().UniversalSettings.TargetMode == "FOV" then
						Lorix:GetSilentAimTarget()
                        --
						if Lorix.Locals.TargetSilent then
							PriorityRelationSilent = Lorix.Locals.TargetSilent.Player
						else
							PriorityRelationSilent = nil
						end
					end --// Update TARGET FOV MODE ( SILENT )
                    --
					if getgenv().AimAssist.Enabled and getgenv().UniversalSettings.TargetMode == "FOV" then
						Lorix:GetAimAssistTarget()
                        --
						if Lorix.Locals.TargetAssist then
							PriorityRelationAssist = Lorix.Locals.TargetAssist.Player
						else
							PriorityRelationAssist = nil
						end
					end --// Update TARGET FOV MODE ( ASSIST )
                    --
					if getgenv().AimAssist.Enabled and PriorityRelationAssist and Lorix.Locals.TargetAssist then
						Lorix:ActivateAimAssist()
					end
                    --
					if getgenv().UniversalSettings.AutoPrediction then
						local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
						local split = Split(pingvalue, '(')
						local ping = tonumber(split[1])
						if ping < 190 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p190_200
						elseif ping < 180 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p180_190
						elseif ping < 170 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p170_180
						elseif ping < 160 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p160_170
						elseif ping < 150 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p150_160
						elseif ping < 140 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p140_150
						elseif ping < 130 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p130_140
						elseif ping < 120 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p120_130
						elseif ping < 110 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p110_120
						elseif ping < 100 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p100_110
						elseif ping < 90 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p90_100
						elseif ping < 80 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p80_90
						elseif ping < 70 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p70_80
						elseif ping < 60 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p60_70
						elseif ping < 50 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p50_60
						elseif ping < 40 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p40_50
						elseif ping < 30 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p30_40
						elseif ping < 20 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p30_40
						elseif ping < 10 then
							getgenv().SilentAim.PredictionAmmount = getgenv().PredefinedPredictions.p20_30
						end
					end
                    --
					if CurrentGame.HoodGame then
						if getgenv().HoodGameSettings.UnlockOnKnock then
							if getgenv().SilentAim.Enabled and PriorityRelationSilent and PriorityRelationSilent.Character then
								if PriorityRelationSilent.Character.Humanoid.Health < 1 then
									PriorityRelationSilent = nil
									Lorix.Locals.TargetSilent = nil
								end
							end
                            --
							if getgenv().AimAssist.Enabled and PriorityRelationAssist and PriorityRelationAssist.Character then
								if PriorityRelationAssist.Character.Humanoid.Health < 1 then
									PriorityRelationAssist = nil
									Lorix.Locals.TargetAssist = nil
								end
							end
						end
                        --
						if getgenv().HoodGameSettings.AutoReload then
							if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") and game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
								game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"))
							end
						end
					end
				end
				Visuals:Update()
			end)()
		end)
        --
		for index, player in pairs(Lorix:GetPlayers()) do
			if (player.Character) then
				Lorix:CharacterEvent(player.Character)
			end
			Utility:Connection(player.CharacterAdded, function()
				task.wait()
				Lorix:CharacterEvent(player.Character)
			end)
		end
        --
		Utility:Connection(Players.PlayerAdded, function(Player)
			if (Player.Character) then
				Lorix:CharacterEvent(Player.Character)
			end
            --
			Utility:Connection(Player.CharacterAdded, function(Character)
				task.wait()
				Lorix:CharacterEvent(Character)
			end)
            --
		end)
	end
    --
	do -- Hooks
	end
    --
	do -- Websockets
	end
end