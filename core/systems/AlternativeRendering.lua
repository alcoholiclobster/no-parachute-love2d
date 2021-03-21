local Concord = require("lib.concord")

local AlternativeRendering = Concord.system({
    pool = {"position", "size", "rotation", "drawable"},
    cameraPool = {"camera"}
})

local minZ = -100
local maxZ = 0
local depthPrecision = 2
local scale = 50
local screenWidth, screenHeight = 0, 0
local clearColor = false

local function draw(e, camera)
    if not e.texture then
        return
    end
    local z = ((camera.position.value.z - e.position.value.z) / 100) * screenHeight * 2
    love.graphics.setColor(1, 1, 1)

    local w, h = e.texture.width, e.texture.height
    love.graphics.translate(0, z + screenHeight * 0.15)
    love.graphics.translate(e.position.value.x*scale, e.position.value.y*scale)
    -- love.graphics.rotate(e.rotation.value)
    love.graphics.rotate(math.pi * 0.25 + e.rotation.value)
    -- love.graphics.shear(0, -0.2)
    -- love.graphics.scale(1, 1)
    if e.sidePlane then
        love.graphics.setScissor(0, 0, screenWidth, z + screenHeight * 0.15)
        love.graphics.setColor(0.5, 0.5, 0.5)

        local r, g, b = e.sidePlane.borderColor[1], e.sidePlane.borderColor[2], e.sidePlane.borderColor[3]
        if not clearColor then
            clearColor = {r, g, b}
        end
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.draw(e.texture.value, 0, 0, 0, e.size.value.x/w*scale, e.size.value.y/h*scale, w * 0.5, h * 0.5)
    if e.sidePlane then
        love.graphics.setScissor()
        love.graphics.setColor(1, 1, 1, 0.05)
        love.graphics.rectangle("line", -e.size.value.x*scale*0.5, -e.size.value.y*scale*0.5, e.size.value.x*scale, e.size.value.y*scale)
    end
end

function AlternativeRendering:init()
    clearColor = nil
end

function AlternativeRendering:draw()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end
    screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setScissor()
    love.graphics.origin()
    love.graphics.clear(0, 0, 0)
    if clearColor then
        love.graphics.setColor(clearColor[1] * 0.5, clearColor[2] * 0.5, clearColor[3] * 0.5)
        local w = scale * 14.1
        love.graphics.rectangle("fill", screenWidth * 0.5 - w * 0.5, 0, w, screenHeight)
    end
    love.graphics.translate(screenWidth * 0.5, 0)

    local sortedGroups = {}
    for _, e in ipairs(self.pool) do
        local z = e.position.value.z - camera.position.value.z
        if z < maxZ and z > minZ then
            local index = math.floor(-z * depthPrecision)
            if not sortedGroups[index] then
                sortedGroups[index] = {
                    count = 0
                }
            end
            table.insert(sortedGroups[index], e)
            sortedGroups[index].count = sortedGroups[index].count + 1
        end
    end

    for index = -minZ * depthPrecision, 0, -1 do
        local group = sortedGroups[index]
        if group then
            if group.count > 1 then
                table.sort(group, function (a, b) return a.position.value.z < b.position.value.z end)
            end

            for i = 1, group.count do
                love.graphics.push()

                local e = group[i]
                draw(e, camera)

                love.graphics.pop()
            end
        end
    end

    love.graphics.setScissor()
end

return AlternativeRendering