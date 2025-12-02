local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local DataModule = require(LocalPlayer:WaitForChild("DataModule", 30))

-- why even check the ammo in the client in the first place lmaoo
-- i know the dev can just paste the ammo check on the server
-- and BOOM! patched.
game:GetService("RunService").Heartbeat:Connect(function()
    setthreadidentity(2)
    local CharacterData = DataModule:GetModCharacter()
    if CharacterData then
        local EquippedItem = CharacterData.EquippedItem
        if EquippedItem then
            local ID = EquippedItem.ID
            local Item = DataModule:GetItemClass(ID)
            local Properties = Item.Properties
            local RealProperties = DataModule.GetItemById(ID).Values

            RealProperties.A = RealProperties.MA
            Properties.Ammo = Properties.MaxAmmo
        end
    end
    setthreadidentity(8)
end) 
