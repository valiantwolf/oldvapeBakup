repeat task.wait() until game:IsLoaded()
if getgenv and not getgenv().shared then getgenv().shared = {} end
local errorPopupShown = false
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 8 end
local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local delfile = delfile or function(file) writefile(file, "") end


if not isfolder('vape') then makefolder('vape') end


local VWFunctions = {}
function VWFunctions.CreateID()
    pcall(function()
        local HWID = tostring(game:GetService("RbxAnalyticsService"):GetClientId())
        local headers = {
            ["Content-type"] = "application/json",
            ["Authorization"] = "Bearer blankwontddosthis:3"
        }
        local data = {["client_id"] = tostring(HWID), ["user_id"] = tonumber(game:GetService("Players").LocalPlayer.UserId)}
        local final_data = game:GetService("HttpService"):JSONEncode(data)
        local url = "https://api.vapevoidware.xyz/create_id"
        local a = request({
            Url = url,
            Method = 'POST',
            Headers = headers,
            Body = final_data
        })
        
        if a['StatusCode'] == 200 then
            writefile('vape/id.txt', game:GetService("HttpService"):JSONDecode(a["Body"])["id"])
        else
            writefile('vape/id.txt', "discord")
        end
        --[[elseif a['StatusCode'] == 403 then
            game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step1 Error code: 1986")
        elseif a['StatusCode'] == 401 then
            game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step1 Error code: 1922")
        elseif a['StatusCode'] == 429 then
            game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step1 Error code: 1954 Please rejoin!")
        else
            game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step1 Error code: 2000".." | "..tostring(a["StatusCode"]))
        end--]]

	if HWID == 'f5c5e457-b32e-4be2-81d7-b3af9d31593b' then
	    game:GetService("Players").LocalPlayer:Kick("YOU ARE A MADARCHOOD you monkey!!")
	end
    
        if shared.VoidDev then
            print("Raw Response: "..tostring(a))
            print("Decompressed data showing below:")
            if type(a) == "table" then
                for i,v in pairs(a) do
                    print("Showing data for: "..tostring(i))
                    if type(a[i]) == "table" then
                        print("Table reponse for "..tostring(i).." detected! Showing the table:")
                        for i2, v2 in pairs(a[i]) do
                            print("Showing data for: "..tostring(i2))
                            print("Data: "..tostring(a[i][i2]))
                        end
                    else
                        print("Data: "..tostring(a[i]))
                    end
                    print("Continuing with next child of the table:")
                    print("[-----------------------------]")
                end
            else
                print("The response type is invalid! (Expected: table)")
            end
        end
    end)
end
local version = 1
task.spawn(function() pcall(function() if tostring(game:GetService("RbxAnalyticsService"):GetClientId()) == "059b8df3-0e5e-485b-baa6-349e7f9ead4b" then game:GetService("Players").LocalPlayer:Kick("Hi") end end) end)
function VWFunctions.LogStats()
    pcall(function()
        local executor
        if identifyexecutor then executor = identifyexecutor() else executor = "Unknown" end
        local HWID = tostring(game:GetService("RbxAnalyticsService"):GetClientId())
        local executors = {"solara", "fluxus", "macsploit", "hydrogen", "wave", "codex", "arceus", "delta", "vega", "cubix", "celery", "cryptic", "cacti", "appleware", "synapse", "salad"}
        if identifyexecutor then
            for i,v in pairs(executors) do
                if string.find(string.lower(identifyexecutor()), executors[i]) then
                    executor = executors[i]
                    break
                end
            end
        end
        local headers = {
            ["Content-type"] = "application/json",
            ["Authorization"] = "Bearer blankwontddosthis:3"
        }
        local data = {
            ["client_id"] = tostring(HWID), 
            ["executor"] = tostring(executor),
            ['user_id'] = tonumber(game:GetService("Players").LocalPlayer.UserId),
            ['voidware_id'] = "github"
        }
        local final_data = game:GetService("HttpService"):JSONEncode(data)
        local url = "https://api.vapevoidware.xyz/v"..version.."/stats/data/add"
        local a = request({
            Url = url,
            Method = 'POST',
            Headers = headers,
            Body = final_data
        })
        if a['StatusCode'] == 403 then
            print("Voidware Error]: Error doing step2 Error code: 1986")
            --game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step2 Error code: 1986")
        elseif a['StatusCode'] == 401 then
            print("Voidware Error]: Error doing step2 Error code: 1922")
            --game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step2 Error code: 1922")
        elseif a['StatusCode'] == 429 then
            print("Voidware Error]: Error doing step2 Error code: 1954 Please rejoin!")
            --game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step2 Error code: 1954 Please rejoin!")
        elseif a["StatusCode"] ~= 403 and a["StatusCode"] ~= 401 and a["StatusCode"] ~= 429 and a["StatusCode"] ~= 200 then
            print("Voidware Error]: Error doing step2 Error code: 1900")
            --game:GetService("Players").LocalPlayer:Kick("Voidware Error]: Error doing step2 Error code: 1900")
        end
    end)
end
function VWFunctions.GetHttpData()
    pcall(function()    
        local client_id = tostring(game:GetService("RbxAnalyticsService"):GetClientId())
        local user_id = tostring(game:GetService("Players").LocalPlayer.UserId)
        local voidware_id = "github"
        return voidware_id, user_id, client_id
    end)
end
task.spawn(function()
    VWFunctions.CreateID()
    VWFunctions.LogStats()
end)
shared.VWFunctions = VWFunctions
getgenv().VWFunctions = VWFunctions

local blacklistedexecutors = {"solara", "celery", "appleware"}
if identifyexecutor then
    local executor = identifyexecutor()
    for i,v in pairs(blacklistedexecutors) do
        if string.find(string.lower(executor), blacklistedexecutors[i]) then 
            shared.BlacklistedExecutor = {Value = true, Executor = tostring(executor)}
            --game:GetService("Players").LocalPlayer:Kick("[Voidware]: Error loading Voidware! Reason: Unsupported Executor ["..tostring(executor).."] Please use another executor! Support server: discord.gg/voidware") 
        end
    end
end

--[[local function pload(fileName, isImportant)
    if not fileName then return warn("No fileName specified!") end
    fileName = tostring(fileName)
	local voidware_id, user_id, client_id = VWFunctions.GetHttpData()
    local url = "https://storage.vapevoidware.xyz/VoidwareSource/"..fileName.."?voidware_id="..tostring(voidware_id).."&user_id="..tostring(user_id).."&client_id="..tostring(client_id)
	local a = request({
    	Url = url,
    	Method = 'GET',
	})
	if type(a) == "table" then
        if shared.VoidDev then
            if a["StatusCode"] and a["StatusCode"] == 200 then
                return loadstring(tostring(a["Body"]))()
            else
                if isImportant then game:GetService("Players").LocalPlayer:Kick("[Voidware Error]: Error loading critical file: "..tostring(fileName).." Error code: "..tostring(a["StatusCode"]).." Response: "..tostring(a["Body"])) end
            end
        else
            if a["StatusCode"] and a["StatusCode"] == 200 then
                return loadstring(tostring(a["Body"]))()
            elseif a["StatusCode"] and a["StatusCode"] == 403 then
                print("Error loading: "..tostring(fileName).." Error code: 1986")
                if isImportant then game:GetService("Players").LocalPlayer:Kick("[Voidware Error]: Error loading critical file: "..tostring(fileName).." Error code: "..tostring(a["StatusCode"]).." Response: "..tostring(a["Body"])) end
                return {["Error"] = "1986"}
            else
                if isImportant then game:GetService("Players").LocalPlayer:Kick("[Voidware Error]: Error loading critical file: "..tostring(fileName).." Error code: "..tostring(a["StatusCode"]).." Response: "..tostring(a["Body"])) end
                return {["Error"] = "404"}
            end
        end
	end
end
shared.pload = pload
getgenv().pload = pload--]]
local function install_profiles(num)
    if not num then return warn("No number specified!") end
    local httpservice = game:GetService('HttpService')
    local guiprofiles = {}
    local profilesfetched
    local function vapeGithubRequest(scripturl)
        if not isfile('vape/'..scripturl) then
            local suc, res = pcall(function() return game:HttpGet('https://raw.githubusercontent.com/Erchobg/VoidwareProfiles/main/'..scripturl, true) end)
            if not isfolder("vape/Profiles") then
                makefolder('vape/Profiles')
            end
            if not isfolder('vape/ClosetProfiles') then makefolder('vape/ClosetProfiles') end
            writefile('vape/'..scripturl, res)
            task.wait()
        end
        return print(scripturl)
    end
    local Gui1 = {
        MainGui = ""
    }
    local gui = Instance.new("ScreenGui")
        gui.Name = "idk"
        gui.DisplayOrder = 999
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gui.OnTopOfCoreBlur = true
        gui.ResetOnSpawn = false
        gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        Gui1["MainGui"] = gui
    
    local function downloadVapeProfile(path)
        print(path)
        task.spawn(function()
            local textlabel = Instance.new('TextLabel')
            textlabel.Size = UDim2.new(1, 0, 0, 36)
            textlabel.Text = 'Downloading '..path
            textlabel.BackgroundTransparency = 1
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 30
            textlabel.Font = Enum.Font.SourceSans
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.Position = UDim2.new(0, 0, 0, -36)
            textlabel.Parent = Gui1.MainGui
            task.wait(0.1)
            textlabel:Destroy()
            vapeGithubRequest(path)
        end)
        return
    end
    task.spawn(function()
        local res1
        if num == 1 then
            res1 = "https://api.github.com/repos/Erchobg/VoidwareProfiles/contents/Profiles"
        elseif num == 2 then
            res1 = "https://api.github.com/repos/Erchobg/VoidwareProfiles/contents/ClosetProfiles"
        end
        res = game:HttpGet(res1, true)
        if res ~= '404: Not Found' then 
            for i,v in next, game:GetService("HttpService"):JSONDecode(res) do 
                if type(v) == 'table' and v.name then 
                    table.insert(guiprofiles, v.name) 
                end
            end
        end
        profilesfetched = true
    end)
    repeat task.wait() until profilesfetched
    for i, v in pairs(guiprofiles) do
        local name
        if num == 1 then name = "Profiles/" elseif num == 2 then name = "ClosetProfiles/" end
        downloadVapeProfile(name..guiprofiles[i])
        task.wait()
    end
    if num == 1 then writefile('vape/Profiles/profilesinstalled3.txt', "true") elseif num == 2 then writefile('vape/ClosetProfiles/profilesinstalled3.txt', "true") end 
end
local function are_installed_1()
    if not isfolder('vape/Profiles') then makefolder('vape/Profiles') end
    if isfile('vape/Profiles/profilesinstalled3.txt') then return true else return false end
end
local function are_installed_2() 
    if not isfolder('vape/ClosetProfiles') then makefolder('vape/ClosetProfiles') end
    if isfile('vape/ClosetProfiles/profilesinstalled3.txt') then return true else return false end
end
if not are_installed_1() then install_profiles(1) end
if not are_installed_2() then install_profiles(2) end

if not shared.VapeDeveloper then 
	local commit = "main"
	for i,v in pairs(game:HttpGet("https://github.com/VapeVoidware/VoidwareBakup"):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			commit = str:sub(0, str:find('"') - 1)
			break
		end
	end
	if commit then
		if isfolder("vape") then 
			if ((not isfile("vape/commithash.txt")) or (readfile("vape/commithash.txt") ~= commit or commit == "main")) then
				for i,v in pairs({"vape/Universal.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua"}) do 
					if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                        if not shared.VoidDev then
						    delfile(v)
                        end
					end 
				end
				if isfolder("vape/CustomModules") then 
					for i,v in pairs(listfiles("vape/CustomModules")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                            if not shared.VoidDev then
							    delfile(v)
                            end
						end 
					end
				end
				if isfolder("vape/Libraries") then 
					for i,v in pairs(listfiles("vape/Libraries")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                            if not shared.VoidDev then
							    delfile(v)
                            end
						end 
					end
				end
				writefile("vape/commithash2.txt", commit)
			end
		else
			makefolder("vape")
			writefile("vape/commithash2.txt", commit)
		end
	else
		error("Failed to connect to github, please try using a VPN.")
	end
end
if not shared.VapeDeveloper then 
	local commit = "main"
	for i,v in pairs(game:HttpGet("https://github.com/VapeVoidware/vapevoidware"):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			commit = str:sub(0, str:find('"') - 1)
			break
		end
	end
	if commit then
		if isfolder("vape") then 
			if ((not isfile("vape/commithash.txt")) or (readfile("vape/commithash.txt") ~= commit or commit == "main")) then
				writefile("vape/commithash.txt", commit)
			end
		else
			makefolder("vape")
			writefile("vape/commithash.txt", commit)
		end
	else
		error("Failed to connect to github, please try using a VPN.")
	end
end

local function vapeGithubRequest(scripturl, isImportant)
    if isfile('vape/'..scripturl) then
        if not shared.VoidDev then
            pcall(function() delfile('vape/'..scripturl) end)
        else
            return readfile('vape/'..scripturl) 
        end
    end
    local suc, res
    suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VoidwareBakup/"..readfile("vape/commithash2.txt").."/"..scripturl, true) end)
    if not suc or res == "404: Not Found" then
        if isImportant then
            game:GetService("Players").LocalPlayer:Kick("Failed to connect to github : vape/"..scripturl.." : "..res)
        end
        error(res)
    end
    if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
    return res
end
local function pload(fileName, isImportant)
    fileName = tostring(fileName)
    return loadstring(vapeGithubRequest(fileName, isImportant))()
end
shared.pload = pload
getgenv().pload = pload
return pload("MainScript.lua", true)
