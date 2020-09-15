local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local renderingUtils = require("utils.rendering")
local Assets = require("engine.Assets")

local PlaneRendering = Concord.system({
    pool = {"position", "size", "rotation", "drawable"},
    cameraPool = {"camera"}
})

local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
local depthPrecision = 4
local minZ = -100
local maxZ = 0

local function render(e, camera)
    local x, y, scale = renderingUtils.project(e.position.value, camera.position.value)
    if not x then
        return
    end

    love.graphics.translate(x, y)
    love.graphics.rotate(e.rotation.value)

    local depth = 1 - mathUtils.clamp01((e.position.value.z - camera.position.value.z) / -100)
    local depthFade = depth * depth

    local size = e.size.value * scale
    if e.decorativePlane and e.texture then
        local imageData = Assets.textureImageData(e.texture.value)
        local r, g, b = imageData:getPixel(0, 0)
        love.graphics.setColor(
            r * depthFade,
            g * depthFade,
            b * depthFade,
            1
        )

        local mul = 1/2*scale*10
        love.graphics.draw(Assets.texture("plane_border"), 0, 0, 0, mul, mul, 2, 2)
    end

    if e.color then
        love.graphics.setColor(
            e.color.r * depthFade,
            e.color.g * depthFade,
            e.color.b * depthFade,
            e.color.a
        )
    end

    if e.fillMode then
        love.graphics.rectangle(e.fillMode.value, -size.x * 0.5, -size.y * 0.5, size.x, size.y)
    end

    if e.texture then
        local w, h = e.texture.width, e.texture.height
        love.graphics.draw(e.texture.value, 0, 0, 0, size.x/w, size.y/h, w * 0.5, h * 0.5)
    end
end

function PlaneRendering:draw()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local sortedEntities = {}

    for _, e in ipairs(self.pool) do
        local z = e.position.value.z - camera.position.value.z
        if z < maxZ and z > minZ then
            local index = math.floor(-z * depthPrecision)
            if not sortedEntities[index] then
                sortedEntities[index] = {}
            end
            table.insert(sortedEntities[index], e)
        end
    end

    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.rotate(camera.rotation.value)
    for index = -minZ * depthPrecision, 0, -1 do
        local entitites = sortedEntities[index]
        if entitites then
            for _, e in ipairs(entitites) do
                love.graphics.push()
                render(e, camera)
                love.graphics.pop()
            end
        end
    end
end

return PlaneRendering