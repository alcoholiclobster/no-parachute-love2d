local json = require("lib.json")

local storage = {}
local keyHandlers = {}
local saveFileName = "user_progress.bin"
local isKeyHashingEnabled = false
local saveData = false

local function deserialize(str)
    return {}
end

local function serialize(t)
    return ""
end

local function save()
    -- Save needs to be loaded first
    if not saveData then
        print("WARNING: Failed to save game. Save data needs to be loaded first.")
        return
    end

    love.filesystem.write(saveFileName, serialize(saveData))
end

function storage.addKeyHandler(key, handler)
    if not keyHandlers[key] then
        keyHandlers[key] = {}
    end

    table.insert(keyHandlers[key], handler)
end

function storage.set(key, value)
    if type(key) ~= "string" then
        error("key must be string")
    end
    if not saveData then
        print("WARNING: Failed to update game save data. Save data needs to be loaded first.")
        return
    end
    local origKey = key
    if isKeyHashingEnabled then
    end
    local oldValue = saveData[key]
    saveData[key] = value
    save()

    if keyHandlers[origKey] then
        for _, handler in ipairs(keyHandlers[origKey]) do
            handler(value, oldValue)
        end
    end
end

function storage.get(key, defaultValue)
    if type(key) ~= "string" then
        error("key must be string")
    end
    if isKeyHashingEnabled then
    end
    if not saveData then
        print("WARNING: Failed to update game save data. Save data needs to be loaded first.")
        return
    end
    if saveData[key] == nil then
        return defaultValue
    end
    return saveData[key]
end

function storage.setLevelData(levelId, key, value)
    if type(levelId) ~= "string" or type(key) ~= "string" then
        error("levelId and key must be string")
    end
    storage.set("level_"..levelId.."_"..key, value)
end

function storage.getLevelData(levelId, key, defaultValue)
    if type(levelId) ~= "string" or type(key) ~= "string" then
        error("levelId and key must be string")
    end
    return storage.get("level_"..levelId.."_"..key, defaultValue)
end

function storage.load(path)
    saveFileName = path

    local saveFileData = love.filesystem.read(saveFileName)
    if saveFileData then
        saveData = deserialize(saveFileData)
    else
        saveData = {}
    end
    storage.set("last_loaded_at", os.time(os.date("!*t")))
end

return storage