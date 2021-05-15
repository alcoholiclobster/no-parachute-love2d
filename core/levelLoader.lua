local json = require("lib.json")
local Steam = require("luasteam")

local levelLoader = {}

function levelLoader.loadFromPath(path)
    local levelConfigFile = assert(io.open(path .. "/levelConfig.json", "rb"))
    local levelConfigJSON = levelConfigFile:read("*all")
    levelConfigFile:close()

    local levelConfig = json.decode(levelConfigJSON)

    return levelConfig
end

function levelLoader.load(levelName)
    assert(type(levelName) == "string", "Level not specified")
    local levelType = "builtin"
    if levelName:sub(1, 5) == "mods/" then
        levelType = "mods_local"
        levelName = levelName:sub(6, -1)
    elseif levelName:sub(1, 9) == "workshop/" then
        levelType = "mods_downloaded"
        levelName = levelName:sub(10, -1)
    end

    if levelType == "builtin" then
        return require("config.levels."..levelName)
    end

    local path = ""
    if levelType == "mods_local" then
        path = love.filesystem.getSaveDirectory().."/mods/"..levelName
    elseif levelType == "mods_downloaded" then
        local id = Steam.extra.parseUint64(levelName)
        local isInstalled = false
        isInstalled, _, path = Steam.UGC.getItemInstallInfo(id)
        if not isInstalled then
            assert("level not installed")
        end
    end

    return levelLoader.loadFromPath(path)
end

return levelLoader