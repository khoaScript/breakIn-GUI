repeat wait() until game:IsLoaded()

local cframes = {
	["House"] = CFrame.new(-36, 3, -200),
	["Basement"] = CFrame.new(71, -15, -163),
	["Store"] = CFrame.new(-422, 3, -121),
	["Sewer Lid"] = CFrame.new(129, 3, -125),
	["Final Boss Room"] = CFrame.new(-39, -287, -1480),
	["Attic"] = CFrame.new(-16, 35, -220)
}

local indexCframes = {}
for i, _ in pairs(cframes) do
	table.insert(indexCframes, tostring(i))
end

local items = {
	["Apple"] = "Apple",
	["Bloxy Cola"] = "BloxyCola",
	["Cookie"] = "Cookie",
	["Plank"] = "Plank",
	["Pizza"] = "Pizza",
	["Fake Pizza"] = "EpicPizza",
	["Basement Key"] = "Key",
	["Chips"] = "Chips",
	["Bat"] = "Bat",
	["Medkit"] = "MedKit",
	["Super Medkit"] = "Cure",
	["Teddy Bear"] = "TeddyBloxpin"
}

local indexItems = {}
for i, _ in pairs(items) do
	table.insert(indexItems, tostring(i))
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local backpack = plr.Backpack
local playerGui = plr.PlayerGui
local holder = playerGui.EnergyBar.EnergyBar.EnergyBar.ImageLabel.NumberHolder.TextLabel

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage.RemoteEvents

local codeNote = workspace.CodeNote

local lib = loadstring(game:HttpGet(('https://pastebin.com/raw/FsJak6AT')))()
local item = lib:CreateWindow("Items")

	local get = item:CreateFolder("Get")
		local itemDropdown = get:Dropdown("Items", indexItems, true, function(value)
			shared.selectedItem = items[value]
		end)
		
		local itemSlider = get:Slider("Amount", 1, 100, false, function(value)
			shared.itemAmount = value
		end)
		
		local itemGet = get:Button("Get", function()
			spawn(function()
				for i = 1, shared.itemAmount do
					remoteEvents.GiveTool:FireServer(shared.selectedItem)
				end
			end)
		end)
		
		local infPlank = get:Toggle("Infinite Plank", function(value)
			shared.infPlank = value
			spawn(function()
				while shared.infPlank do
					wait(0.1)
					if not backpack:FindFirstChild("Plank") then
						remoteEvents.GiveTool:FireServer("Plank")
					end
				end
			end)
		end)
		
	local buy = item:CreateFolder("Buy")
		local pan = buy:Button("Buy Pan (40$)", function()
			remoteEvents.BuyItem:FireServer("Pan", 40)
		end)
		
local player = lib:CreateWindow("Player")
	
	local localPlayer = player:CreateFolder("LocalPlayer")
		local codeNoteLabel = localPlayer:Label("Vault code: ".. codeNote.SurfaceGui.TextLabel.Text)
	
		local walkSpeed = localPlayer:Slider("WalkSpeed (16)", 1, 100, false, function(value)
			chr.Humanoid.WalkSpeed = value
		end)
		
		local jumpPower = localPlayer:Slider("JumpPower (50)", 1, 500, false, function(value)
			chr.Humanoid.JumpPower = value
		end)
		
		local gravity = localPlayer:Slider("Gravity (196.2)", 1, 500, false, function(value)
			workspace.Gravity = value
		end)
		
		local cmdX = localPlayer:Button("CMD-X", function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
		end)
	
		local autoHeal = localPlayer:Toggle("Auto Heal", function(value)
			shared.autoHeal = value
			spawn(function()
				while shared.autoHeal do
					wait(0.1)
					if holder.Text ~= "200/200" then
						remoteEvents.GiveTool:FireServer("Apple")
						remoteEvents.Energy:FireServer(15, "Apple")
					end
				end
			end)
		end)
		
	local teleport = player:CreateFolder("Teleport")
		local location = teleport:Dropdown("Locations", indexCframes, true, function(value)
			shared.selectedLocation = cframes[value]
		end)
		
		local tpButton = teleport:Button("Teleport", function()
			chr.HumanoidRootPart.CFrame = shared.selectedLocation
		end)
