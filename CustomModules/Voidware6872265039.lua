repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary

local GuiLibrary = shared.GuiLibrary
local lplr = game:GetService("Players").LocalPlayer

local function queue()
	local args = {
		[1] = {
			["queueType"] = "bedwars_duels"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"):WaitForChild("joinQueue"):FireServer(unpack(args))
end

if shared.TeleportExploitAutowinEnabled then
	local interactable_buttons_table = {
		[1] = {
			["Name"] = "Yes",
			["Function"] = function()
				shared.MadeChoice = true
				shared.TeleportExploitAutowinEnabled = nil
				queue()
			end
		},
		[2] = {
			["Name"] = "No",
			["Function"] = function()
				shared.TeleportExploitAutowinEnabled = nil
				shared.MadeChoice = true 
			end
		}
	}
	local function InfoNotification2(title, text, delay, button_table)
		local suc, res = pcall(function()
			local frame = GuiLibrary.CreateInteractableNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/InfoNotification.png", button_table)
			return frame
		end)
		return (suc and res)
	end
	InfoNotification2("EmptyGameTP - AutowinMode", "An error might have happened while auto-queueing. Would you like to \n join back to the queue?", 10000000, interactable_buttons_table)
	task.wait(3)
	if (not shared.MadeChoice) then queue() end
end

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

task.spawn(function()
    pcall(function()
        local lplr = game:GetService("Players").LocalPlayer
        local char = lplr.Character or lplr.CharacterAdded:wait()
        local displayName = char:WaitForChild("Head"):WaitForChild("Nametag"):WaitForChild("DisplayNameContainer"):WaitForChild("DisplayName")
        repeat task.wait() until shared.vapewhitelist
        repeat task.wait() until shared.vapewhitelist.loaded
        local tag = shared.vapewhitelist:tag(lplr, "", true)
        if displayName.ClassName == "TextLabel" then
            if not displayName.RichText then displayName.RichText = true end
            displayName.Text = tag..lplr.Name
        end
        displayName:GetPropertyChangedSignal("Text"):Connect(function()
            if displayName.Text ~= tag..lplr.Name then
                displayName.Text = tag..lplr.Name
            end
        end)
    end)
end)

local GuiLibrary = shared.GuiLibrary
shared.slowmode = 0
run(function() 
    local function resetSlowmode()
        task.spawn(function()
            repeat shared.slowmode = shared.slowmode - 1 task.wait(1) until shared.slowmode < 1
            shared.slowmode = 0
        end)
    end
    local HS = game:GetService("HttpService")
    local StaffDetector = {}
    local StaffDetector_Games = {Value = "Bedwars"}
    local Custom_Group = {Enabled = false}
	local IgnoreOnlineStaff = {Enabled = false}
	local AutoCheck = {Enabled = false}
    local Roles_List = {ObjectList = {}}
    local Custom_GroupId = {Value = ""}
    local Staff_Members_Limit = {Value = 50}
    local Games_StaffTable = {
        ["Bedwars"] = {
            ["groupid"] = 5774246,
            ["roles"] = {
                79029254,
                86172137,
                43926962,
                37929139,
                87049509,
                37929138
            }
        },
		["PS99"] = {
			["groupid"] = 5060810,
			["roles"] = {
				33738740,
				33738765
			}
		}
    }
    local function getUsersInRole(groupId, roleId, cursor)
        local limit = Staff_Members_Limit.Value or 100
        local url = "https://groups.roblox.com/v1/groups/"..groupId.."/roles/"..roleId.."/users?limit="..limit
        if cursor then
            url = url .. "&cursor=" .. cursor
        end
    
        local response = request({
            Url = url,
            Method = "GET"
        })
    
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    local function getUserPresence(userIds)
        local url = "https://presence.roblox.com/v1/presence/users"
        local requestBody = game:GetService("HttpService"):JSONEncode({userIds = userIds})
    
        local response = request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = requestBody
        })
        return game:GetService("HttpService"):JSONDecode(response.Body)
    end
    local function getUsersInRoleWithPresence(groupId, roleId)
        local users = {}
        local cursor = nil
        local userIds = {}
        repeat
            local data = getUsersInRole(groupId, roleId, cursor)
            for _, user in pairs(data.data) do
                table.insert(users, user)
                table.insert(userIds, user.userId)
            end
            cursor = data.nextPageCursor
        until not cursor
        local presenceData = getUserPresence(userIds)
        for _, user in pairs(users) do
            for _, presence in pairs(presenceData.userPresences) do
                if user.userId == presence.userId then
                    user.presenceType = presence.userPresenceType
                    user.lastLocation = presence.lastLocation
                    break
                end
            end
        end
        return users
    end
    local function getGroupRoles(groupId)
        local url = "https://groups.roblox.com/v1/groups/"..groupId.."/roles"
        local res = request({
            Url = url,
            Method = "GET"
        })
        if res.StatusCode == 200 then
            local roles = {}
            for i,v in pairs(HS:JSONDecode(res.Body).roles) do
                table.insert(roles, v.id)
            end
            return true, roles, nil
        else
            return false, nil, "Status Code isnt 200! "..res.StatusCode
        end
    end
    local function getData()
        if Custom_Group.Enabled then
            local suc1, custom_group_id, err1 = false, "", nil
            if Custom_GroupId.Value ~= "" then
                suc1 = true
                custom_group_id = tonumber(Custom_GroupId.Value)
            else 
                suc1 = false
                custom_group_id = nil
                err1 = "Custom GroupID not specified!" 
            end
            local suc2, roles, err2 = false, {}, nil
            if #Roles_List.ObjectList < 1 then
                suc2 = false
                roles = nil
                err2 = "Roles not specified!"
            else
                if suc1 then
                    local suc3, res, err3 = getGroupRoles(custom_group_id)
                    if suc3 then
                        suc2 = true
                        roles = res
                    else
                        err2 = err3
                    end
                end
            end
            return {suc1, custom_group_id, err1}, {suc2, roles, err2}, "Custom"
        else
            if StaffDetector_Games.Value ~= "" then
                local roles = Games_StaffTable[StaffDetector_Games.Value]["roles"]
                local groupid = Games_StaffTable[StaffDetector_Games.Value]["groupid"]
                return {true, groupid, nil}, {true, roles, nil}, "Normal"
            else
                return {false, nil, nil}, {false, nil, nil}, "Normal"
            end
        end
    end
    local core_table = {}
    local function handle_checks(groupid, roleid)
        local res = getUsersInRoleWithPresence(groupid, roleid)
        for _, user in pairs(res) do
            local presenceStatus = "Offline"
            if user.presenceType == 1 then
                presenceStatus = "Online"
            elseif user.presenceType == 2 then
                presenceStatus = "In Game"
            elseif user.presenceType == 3 then
                presenceStatus = "In Studio"
            end
			local function online()
				if IgnoreOnlineStaff.Enabled then
					if presenceStatus == "Online" then
						return true
					else
						return false
					end
				else
					return false
				end
			end
            if (presenceStatus == "In Game" or online()) then
                table.insert(core_table, {["UserID"] = user.userId, ["Username"] = user.username, ["Status"] = presenceStatus})
            end
            print("Username: " .. user.username .. " - UserID: " .. user.userId .. " - Status: " .. presenceStatus)
        end
    end
	local checked_data = {}
	StaffDetector = GuiLibrary.ObjectsThatCanBeSaved.VoidwareWindow.Api.CreateOptionsButton({
		Name = 'StaffDetector',
		Function = function(calling)
			if calling then 
				if (not AutoCheck.Enabled) then
					StaffDetector["ToggleButton"](false) 
				end
				if AutoCheck.Enabled then errorNotification("StaffDetector-AutoCheck", "Please disable auto check to manually use this module!", 5) end
                if shared.slowmode > 0 then if (not AutoCheck.Enabled) then return errorNotification("StaffDetector-Slowmode", "You are currently on slowmode! Wait "..tostring(shared.slowmode).."seconds!", shared.slowmode) end end
				shared.slowmode = 5
                resetSlowmode()
				InfoNotification("StaffDetector", "Sent request! Please wait...", 5)
				local function dostuff()
					local limit = Staff_Members_Limit.Value
					local tbl1, tbl2, Type = getData()
					local suc1 = tbl1[1]
					local suc2 = tbl2[1]
					local res1 = tbl1[2]
					local res2 = tbl2[2]
					local err1 = tbl1[3]
					local err2 = tbl2[3]     
					local handle_table = {}    
					local number = 0      
					if (suc1 and suc2) then
						for i,v in pairs(res2) do handle_checks(res1, v) end
						for i,v in pairs(core_table) do
							if (not table.find(handle_table, tostring(v["UserID"]))) then
								table.insert(handle_table, tostring(v["UserID"]))
								number = number + 1
								local a = tostring(v["UserID"])
								local b = tostring(v["Username"])
								local c = tostring(v["Status"])
								local function checked()
									for i,v in pairs(checked_data) do
										if v["UserID"] == a then
											if v["Status"] == c then
												return true
											end
										end
									end
									return false
								end
								if checked() then return end
								table.insert(checked_data, {["UserID"] = a, ["Status"] = c})
								if tostring(v["Status"]) == "Online" then
									if (not IgnoreOnlineStaff.Enabled) then
										errorNotification("StaffDetector", "@"..b.."("..a..") is currently "..c, 7)
									end
								else
									errorNotification("StaffDetector", "@"..b.."("..a..") is currently "..c, 7)
								end
							end
						end
						InfoNotification("StaffDetector", tostring(number).." total staffs were detected as online/ingame!", 7)
					else
						shared.slowmode = 0
						if (not suc1) then
							errorNotification("StaffDetector-GroupID Error", tostring(err1), 5)
						end
						if (not suc2) then
							errorNotification("StaffDetector-Roles Error", tostring(err2), 5)
						end
					end
				end
				if (not AutoCheck.Enabled) then
					dostuff()
				else
					task.spawn(function()
						repeat 
							dostuff()
							task.wait(30)
						until (not StaffDetector.Enabled) or (not AutoCheck.Enabled)
						StaffDetector["ToggleButton"](false) 
					end)
				end
			end
		end
	}) 
    local list = {}
    for i,v in pairs(Games_StaffTable) do table.insert(list, i) end
    StaffDetector_Games = StaffDetector.CreateDropdown({
		Name = "GameChoice",
		Function = function() end,
		List = list
	})
    Roles_List = StaffDetector.CreateTextList({
		Name = "CustomRoles",
		TempText = "RoleId (number)"
	})
    Custom_GroupId = StaffDetector.CreateTextBox({
        Name = "CustomGroupId",
        TempText = "Type here a groupid",
        TempText = "GroupId (number)",
        Function = function() end
    })
    Custom_GroupId.Object.Visible = false
    Roles_List.Object.Visible = false
    Custom_Group = StaffDetector.CreateToggle({
		Name = "CustomGroup",
		Function = function(calling)
            if calling then
                Custom_GroupId.Object.Visible = true
                Roles_List.Object.Visible = true
                StaffDetector_Games.Object.Visible = false
            else
                Custom_GroupId.Object.Visible = false
                Roles_List.Object.Visible = false
                StaffDetector_Games.Object.Visible = true
            end
        end,
		HoverText = "Choose another staff group",
		Default = false
	})
	IgnoreOnlineStaff = StaffDetector.CreateToggle({
		Name = "IgnoreOnlineStaff",
		Function = function() end,
		HoverText = "Make the module ignore online staff and only \n show ingame staff",
		Default = false
	})
    Staff_Members_Limit = StaffDetector.CreateSlider({
		Name = "StaffMembersLimit",
		Min = 1,
		Max = 100,
		Function = function() end,
		Default = 100
	})
	AutoCheck = StaffDetector.CreateToggle({
		Name = "AutoCheck",
		Function = function() end,
		HoverText = "Checks for new staffs every 30 seconds",
		Default = false
	}) --- work in progress
	task.spawn(function()
		repeat task.wait() until shared.vapewhitelist.loaded
		if shared.vapewhitelist:get(game:GetService("Players").LocalPlayer) ~= 2 then AutoCheck.Object.Visible = false end
	end)
end)

run(function() 
	local ScytheFunny = {}
	ScytheFunny = GuiLibrary.ObjectsThatCanBeSaved.HotWindow.Api.CreateOptionsButton({
		Name = 'ScytheFunny',
		Function = function(calling)
			if calling then 
				repeat 
					task.wait()
					game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SkyScytheSpin"):FireServer()
				until (not ScytheFunny.Enabled)
			end
		end
	}) 
end)