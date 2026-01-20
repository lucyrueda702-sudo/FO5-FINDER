-- FO5 FINDER | Auto Server Hop
-- Steal A Brainrot

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId

print("🔎 FO5 FINDER iniciado...")

local CHECK_DELAY = 4

local function foundGoodBrainrot()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") then
			local n = string.lower(v.Name)
			if n:find("brainrot") or n:find("mythic") or n:find("legend") then
				return true, v.Name
			end
		end
	end
	return false
end

local function hop()
	local servers = HttpService:JSONDecode(
		game:HttpGet(
			"https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?limit=100"
		)
	)

	for _, s in ipairs(servers.data) do
		if s.playing < s.maxPlayers then
			TeleportService:TeleportToPlaceInstance(PLACE_ID, s.id, player)
			return
		end
	end
end

task.delay(CHECK_DELAY, function()
	local ok, name = foundGoodBrainrot()
	if ok then
		warn("✅ BRAINROT BUENO DETECTADO:", name)
	else
		warn("❌ Nada bueno, cambiando servidor...")
		hop()
	end
end)
