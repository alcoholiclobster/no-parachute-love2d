local assets = {}

local texturesCache = {}
local imageDataCache = {}
local fontsCache = {
    default_14 = love.graphics.getFont()
}

function assets.texture(name)
    if texturesCache[name] then
        return texturesCache[name]
    end

    local path = "assets/"..name..".png"
    local imageData = love.image.newImageData(path)

    local texture = love.graphics.newImage(imageData)
    texture:setFilter("nearest", "nearest")
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

return assets