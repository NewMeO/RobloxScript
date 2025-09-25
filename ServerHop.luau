local Modules = {}
local Config = { 
    MaxStore = 3600, 
    CheckInterval = 2500, 
    TeleportInterval = 1000
}

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

if not Player then
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	Player = Players.LocalPlayer
end


function Modules:ServerHop()
    local PlaceId = 126509999114328
	local JobId = game.JobId

	local RootFolder = "ServerHop"
	local StorageFile = `{RootFolder}/{Player.Name}_{tostring(PlaceId)}.json`
	local Data = {
		Start = tick(),
		Jobs = {},
	}

	if not isfolder(RootFolder) then
		makefolder(RootFolder)
	end

	if isfile(StorageFile) then
		local NewData = HttpService:JSONDecode(readfile(StorageFile))

		if tick() - NewData.Start < Config.MaxStore then
			Data = NewData
		end
	end

	if not table.find(Data.Jobs, JobId) then
		table.insert(Data.Jobs, JobId)
	end

	writefile(StorageFile, HttpService:JSONEncode(Data))

	local Servers = {}
	local Cursor = ""

	while Cursor and #Servers <= 0 and task.wait(Config.CheckInterval / 1000) do
		local Request = request or HttpService.RequestAsync
		local RequestSuccess, Response = pcall(Request, {
			Url = `https://api.highspec.shop/servers/{PlaceId}`,
			Method = "GET",
		})
        warn(Response.Body)

		if not RequestSuccess then
			continue
		end

		local DecodeSuccess, Body = pcall(HttpService.JSONDecode, HttpService, Response.Body)

		if not DecodeSuccess or not Body or not Body.servers then
			continue
		end

		task.spawn(function()
			for _, Server in pairs(Body.servers) do
				if
					typeof(Server) ~= "table"
					or not Server.id
					or not tonumber(Server.playing)
					or not tonumber(Server.maxPlayers)
				then
					continue
				end

				if Server.playing < Server.maxPlayers and not table.find(Data.Jobs, Server.id) then
					table.insert(Servers, 1, Server.id)
				end
			end
		end)

		if Body.nextPageCursor then
			Cursor = Body.nextPageCursor
		end
	end

	while #Servers > 0 and task.wait(Config.TeleportInterval / 1000) do
		local Server = Servers[math.random(1, #Servers)]
		TeleportService:TeleportToPlaceInstance(PlaceId, Server, Player)
	end
end

-- Modules:ServerHop()
return Modules
