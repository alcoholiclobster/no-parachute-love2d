local assets = {}

local texturesCache = {}
local imageDataCache = {}
local fontsCache = {
    default_14 = love.graphics.getFont()
}
local soundsCache = {}
local nativefs = require("lib.nativefs")

function assets.preloadModTexture(path, name)
    local imageFileData = nativefs.read(path)
    if not imageFileData then
        error("Failed to load texture "..tostring(path))
    end
    local fileData = love.filesystem.newFileData(imageFileData, "image.png")

    local imageData = love.image.newImageData(fileData)
    local texture = love.graphics.newImage(imageData)

    texture:setFilter("nearest", "nearest")
    texture:setWrap("repeat")

    texturesCache[name] = texture
    imageDataCache[texture] = imageData
end

function assets.texture(name, enableFiltering)
    if texturesCache[name] then
        return texturesCache[name]
    end

    local path = "assets/"..name..".png"
    local imageData = love.image.newImageData(path)

    local texture = love.graphics.newImage(imageData)
    if not enableFiltering then
        texture:setFilter("nearest", "nearest")
        texture:setWrap("repeat")
    end
    texturesCache[name] = texture

    imageDataCache[texture] = imageData

    return texture
end

function assets.font(name, size)
    if not name then
        name = "default"
    end

    if not size then
        size = 14
    end
    local fontName = name.."_"..size
    if fontsCache[fontName] then
        return fontsCache[fontName]
    end

    local path = "assets/fonts/"..name..".ttf"
    local font = love.graphics.newFont(path, size)
    fontsCache[fontName] = font

    return font
end

function assets.textureImageData(texture)
    if not imageDataCache[texture] then
        return
    end
    return imageDataCache[texture]
end

function assets.sound(name)
    if soundsCache[name] then
        return soundsCache[name]
    end
    local source = love.audio.newSource("assets/sounds/"..name, "static")
    soundsCache[name] = source
    return source
end

return assets