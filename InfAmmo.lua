pcall(function()
	local executorname, version = identifyexecutor()
	executorname = executorname:upper()
	
	if string.match(executorname, "XENO") or string.match(executorname, "SOLARA") then
		game.Players.LocalPlayer:Kick("GET A BETTER FUCKING EXECUTOR YOU FUCKING MONGOLIAN FUCK.")
		while true do end -- fuck you if you have solara
	end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local DataModule = require(LocalPlayer.DataModule)

local OriginalGetModCharacter = DataModule.GetModCharacter

-- Alr i changed methods, it will no longer fuck up your game.
DataModule.GetModCharacter = function(...)
    local CharacterData = OriginalGetModCharacter(...)

    if CharacterData and CharacterData.EquippedItem then
        local ID = CharacterData.EquippedItem.ID
        local Item = DataModule:GetItemClass(ID)
        local Properties = Item.Properties
        local RealProperties = DataModule.GetItemById(ID).Values
        -- turns out doing metatables lags tf out of your game
        -- since the game repeatedly calls `GetModCharacter` alot
        RealProperties.MA = 99999999
        Properties.MaxAmmo = 99999999 
    end

    return CharacterData
end
