local bitser = require("lib.bitser")

local settings = {}

local settingsConfig = require("config.settings")
local settingsState = {}
local settingsHandlers = {}

function settings.get(name)
    return settingsState[name]
end

function settings.set(name, value, omitSave)
    local oldValue = settingsState[name]
    settingsState[name] = value

    if settingsHandlers[name] then
        settingsHandlers[name](value, oldValue)
    end

    if not omitSave then
        love.filesystem.write("settings", bitser.dumps(settingsState))
    end
end

function settings.addHandler(name, handler)
    settingsHandlers[name] = handler
end

function settings.restoreDefaults(omitSave)
    for _, s in ipairs(settingsConfig) do
        local value = nil
        for _, v in ipairs(s.values) do
            if v.default then
                value = v.value
            end
        end

        settings.set(s.name, value, true)
    end

    if not omitSave then
        love.filesystem.write("settings", bitser.dumps(settingsState))
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
        settings.set(k, v, true)
    end

    if not love.filesystem.getInfo("settings") then
        love.filesystem.write("settings", bitser.dumps(settingsState))
    end
end

return settings