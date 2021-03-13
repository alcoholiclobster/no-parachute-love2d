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

return { project = project }