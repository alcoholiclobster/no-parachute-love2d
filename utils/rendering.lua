local function project(pos, cam, fov)
    local z = pos.z - cam.z
    if z > -1 then
        return
    end

    local f = math.abs(pos.z - cam.z + love.graphics.getHeight() * 0.7 / fov)
    local px = ((pos.x - cam.x) * (f / z)) + cam.x
    local py = ((pos.y - cam.y) * (f / z)) + cam.y

    return -px, -py, -f / z
end

-- https://love2d.org/forums/viewtopic.php?t=79756
local function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

return { project = project, getImageScaleForNewDimensions = getImageScaleForNewDimensions }