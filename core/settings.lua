local bitser = require("lib.bitser")

local settings = {}

local settingsConfig = require("config.settings")
local settingsState = {}

function settings.get(name)
    return settingsState[name]
end

function settings.set(name, value)
    settingsState[name] = value
end

function settings.restoreDefaults()
    for _, s in ipairs(settingsConfig) do
        local value = nil
        for _, v in ipairs(s.values) do
            if v.default then
                value = v.value
            end
        end

        settingsState[s.name] = value
    end
end

function settings.load()
    local state = {}
    local settingsFileData = love.filesystem.read("settings")
    if settingsFileData then
        state = bitser.loads(settingsFileData)
    end

    settings.restoreDefaults()
    for k, v in pairs(state) do
        settingsState[k] = v
    end

    if not love.filesystem.getInfo("settings") then
        love.filesystem.write("settings", bitser.dumps(settingsState))
    end
end

return settings