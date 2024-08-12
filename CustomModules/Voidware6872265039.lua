repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary

local GuiLibrary = shared.GuiLibrary
local lplr = game:GetService("Players").LocalPlayer

run(function()
	local QueueCardMods = {}
	local QueueCardGradientToggle = {}
	local QueueCardGradient = {Hue = 0, Sat = 0, Value = 0}
	local QueueCardGradient2 = {Hue = 0, Sat = 0, Value = 0}
	local queuemodsgradients = {}
	local function patchQueueCard()
		if lplr.PlayerGui:FindFirstChild('QueueApp') then 
			if lplr.PlayerGui.QueueApp:WaitForChild('1'):IsA('Frame') then 
				lplr.PlayerGui.QueueApp['1'].BackgroundColor3 = Color3.fromHSV(QueueCardGradient.Hue, QueueCardGradient.Sat, QueueCardGradient.Value)
			end
			if QueueCardGradientToggle.Enabled then 
				lplr.PlayerGui.QueueApp['1'].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				local gradient = (lplr.PlayerGui.QueueApp['1']:FindFirstChildWhichIsA('UIGradient') or Instance.new('UIGradient', lplr.PlayerGui.QueueApp['1']))
				gradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHSV(QueueCardGradient.Hue, QueueCardGradient.Sat, QueueCardGradient.Value)), 
					ColorSequenceKeypoint.new(1, Color3.fromHSV(QueueCardGradient2.Hue, QueueCardGradient2.Sat, QueueCardGradient2.Value))
				})
				table.insert(queuemodsgradients, gradient)
			end
		end
	end
	QueueCardMods = GuiLibrary.ObjectsThatCanBeSaved.CustomisationWindow.Api.CreateOptionsButton({
		Name = 'QueueCardMods',
		HoverText = 'Mods the QueueApp at the end of the game.',
		Function = function(calling) 
			if calling then 
				patchQueueCard()
				table.insert(QueueCardMods.Connections, lplr.PlayerGui.ChildAdded:Connect(patchQueueCard))
			end
		end
	})
	QueueCardGradientToggle = QueueCardMods.CreateToggle({
		Name = 'Gradient',
		Function = function(calling)
			pcall(function() QueueCardGradient2.Object.Visible = calling end) 
		end
	})
	QueueCardGradient = QueueCardMods.CreateColorSlider({
		Name = 'Color',
		Function = function()
			pcall(patchQueueCard)
		end
	})
	QueueCardGradient2 = QueueCardMods.CreateColorSlider({
		Name = 'Color 2',
		Function = function()
			pcall(patchQueueCard)
		end
	})
	Credits = QueueCardMods.CreateCredits({
		Name = 'CreditsButtonInstance',
        Credits = 'Render'
	})
end)

run(function()
	local AutoCrate = {Enabled = false}
	local aut = 0
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local rbxts_include = replicatedStorage:WaitForChild("rbxts_include")
	local net = rbxts_include:WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged")

	local function openCrate(crateType, altarId, crateName)
		local spawnArgs = {
			[1] = {
				["crateType"] = crateType,
				["altarId"] = altarId
			}
		}
		net:WaitForChild("RewardCrate/SpawnRewardCrate"):FireServer(unpack(spawnArgs))

		local crateAltar = game.Workspace:FindFirstChild("CrateAltar_" .. altarId)
		if crateAltar and crateAltar:FindFirstChild(crateName) then
			local openArgs = {
				[1] = {
					["crateId"] = tostring(crateAltar:FindFirstChild(crateName):GetAttribute("crateId"))
				}
			}
			net:WaitForChild("RewardCrate/OpenRewardCrate"):FireServer(unpack(openArgs))
		end
	end

	AutoCrate = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = "AutoCrate",
		HoverText = "Automatically open crates if you have any.",
		Function = function(callback)
			if callback then
			    task.spawn(function()
			        repeat task.wait()
			        aut = aut + 1
					if aut >= 45 then
						openCrate("level_up_crate", 0, "RewardCrate")
						openCrate("level_up_crate", 1, "RewardCrate")
						openCrate("diamond_lucky_crate", 0, "DiamondLuckyCrate")
						openCrate("diamond_lucky_crate", 1, "DiamondLuckyCrate")
						aut = 0
					end
			        until not AutoCrate.Enabled
			    end)
				--RunLoops:BindToStepped("crate", 1, function()
				--end)
			else
				--RunLoops:UnbindFromStepped("crate")
			end
		end
	})
end)