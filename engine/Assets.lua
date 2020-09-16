local assets = {}

local texturesCache = {}
local imageDataCache = {}

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

function assets.textureImageData(texture)
    if not imageDataCache[texture] then
        return
    end
    return imageDataCache[texture]
end

return assets