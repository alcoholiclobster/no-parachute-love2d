local storage = require("utils.storage")

local isInitialized = false

local achievements = {}
local cache = {}

function achievements.set(name)
    if not isInitialized then
        return
    end

    if cache[name] then
        return
    end
    cache[name] = true
end

function achievements.update()
end

function achievements.init()
    if isInitialized then
        return
    end
    isInitialized = true
end

return achievements