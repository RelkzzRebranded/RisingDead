local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local DataModule = require(LocalPlayer.DataModule)

local OriginalGetModCharacter = DataModule.GetModCharacter

-- TerminalVibes the GOAT.
-- blud told me to use metatables instead of doing it by 
-- so i did it and it was hard at first but oh boy it was fun
DataModule.GetModCharacter = function(...)
    -- some executors identity of 8 fucks up the way some of roblox's [C] functions work
    -- so i had to use setthreadidentity here
    setthreadidentity(2) 
    local CharacterData = OriginalGetModCharacter(...)

    if CharacterData and CharacterData.EquippedItem then
        local ID = CharacterData.EquippedItem.ID
        local Item = DataModule:GetItemClass(ID)
        local Properties = Item.Properties
        local RealProperties = DataModule.GetItemById(ID).Values
        local oldProperties = getmetatable(Properties)
        local oldRealProperties = getmetatable(RealProperties)
        -- OMG WOWW!!!
        -- USE CASES OF METATABLES?!!?
        -- IM WET! (pause, wtf bro)
        setmetatable(RealProperties, {
            __index = function(t, k)
                if k == "A" then
                    return t.MA
                end
                -- yes. you can chain it.
                if oldRealProperties and oldRealProperties.__index then
                    if type(oldRealProperties.__index) == "table" then
                        return oldRealProperties.__index[k]
                    else
                        return oldRealProperties.__index(t, k)
                    end
                end
            end
        })

        setmetatable(Properties, {
            __index = function(t, k)
                if k == "Ammo" then
                    return t.MaxAmmo
                end

                if oldProperties and oldProperties.__index then
                    if type(oldProperties.__index) == "table" then
                        return oldProperties.__index[k]
                    else
                        return oldProperties.__index(t, k)
                    end
                end
            end
        })
    end
    setthreadidentity(8)

    return CharacterData
end
