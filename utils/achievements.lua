-- local Steam = require("luasteam")
local storage = require("utils.storage")

local isInitialized = false

local achievements = {}
local syncInterval = 90
local lastSyncAt = 0
local isSyncRequired = false

local cache = {}

function achievements.set(name)
    if not isInitialized then
        return
    end

    if cache[name] then
        return
    end
    cache[name] = true

    -- Steam.userStats.setAchievement(name)

    -- if love.timer.getTime() - lastSyncAt > syncInterval then
    --     Steam.userStats.storeStats()
    --     lastSyncAt = love.timer.getTime()
    --     print("Store Steam stats")
    -- else
    --     isSyncRequired = true
    -- end
end

function achievements.update()
    if not isInitialized then
        return
    end

    if isSyncRequired and love.timer.getTime() - lastSyncAt > syncInterval then
        lastSyncAt = love.timer.getTime()
        isSyncRequired = false
        -- Steam.userStats.storeStats()
        -- print("Store Steam stats")
    end
end

function achievements.init()
    if isInitialized then
        return
    end
    isInitialized = true

    storage.addKeyHandler("level_tutorial_is_completed", function (value)
        if value then
            achievements.set("complete_tutorial")
        end
    end)

    storage.addKeyHandler("level_meat3_is_completed", function (value)
        if value then
            achievements.set("complete_core")
        end
    end)

    storage.addKeyHandler("level_ending2_is_completed", function (value)
        if value then
            achievements.set("complete_game")
        end
    end)

    storage.addKeyHandler("total_deaths", function (value)
        if value > 100 then
            achievements.set("total_deaths_100")
        elseif value > 20 then
            achievements.set("total_deaths_20")
        elseif value > 1 then
            achievements.set("first_blood")
        end
    end)

    storage.addKeyHandler("total_limbs_lost", function (value)
        if value > 120 then
            achievements.set("total_limbs_lost_120")
        elseif value > 40 then
            achievements.set("total_limbs_lost_40")
        elseif value > 1 then
            achievements.set("first_blood")
        end
    end)
end

return achievements