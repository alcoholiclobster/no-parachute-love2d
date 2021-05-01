local json = require("lib.json")

local filename = "user_settings.json"
local settings = {}

local settingsConfig = require("config.settings")
local settingsState = {}
local settingsHandlers = {}

local function deserialize(str)
    -- bitser.loads
    return json.decode(str)
end

local function serialize(t)
    -- bitser.dumps
    return json.encode(t)
end

function settings.save()
    love.filesystem.write(filename, serialize(settingsState))
end

function settings.get(name)
    return settingsState[name]
end

function settings.set(name, value, omitSave, omitHandler)
    local oldValue = settingsState[name]
    settingsState[name] = value

    if settingsHandlers[name] and not omitHandler then
        settingsHandlers[name](value, oldValue)
    end

    if not omitSave then
        settings.save()
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
        settings.save()
    end
end

function settings.conf(path)
    filename = path

    local state = {}
    local settingsFileData = love.filesystem.read(filename)
    if settingsFileData then
        state = deserialize(settingsFileData)
    end

    -- Initialize with default settings
    settings.restoreDefaults(true)

    -- Replace default settings by settings from file
    for k, v in pairs(state) do
        settings.set(k, v, true, true)
    end
end

function settings.load()
    -- If settings file does not exist, create it
    if not love.filesystem.getInfo(filename) then
        settings.save()
    end

    -- Execute settings handlers
    for name, handler in pairs(settingsHandlers) do
        handler(settings.get(name))
    end
end

return settings