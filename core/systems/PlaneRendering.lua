local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local renderingUtils = require("utils.rendering")
local assets = require("core.assets")
local settings = require "utils.settings"

local PlaneRendering = Concord.system({
    pool = {"position", "size", "rotation", "drawable"},
    cameraPool = {"camera"}
})

local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
local canvas = love.graphics.newCanvas()
local depthPrecision = 4
local minZ = -100
local maxZ = 0

local lastFrameCameraZ = 0

local clearColor = nil
local fogDistance = 100
local isFogPlaneRendered = false

local lodBlendEnabled = true
local lodBlendStart = 0.25
local lodBlendEnd = 0.5
local lodDrawEveryPlane = 2

local function render(e, camera)
    local position = e.position.value:clone()
    local lodAlpha = 1
    local lodDistance = 0
    if e.sidePlane and lodBlendEnabled then
        lodDistance = (camera.position.value.z - position.z) / fogDistance
        if lodDistance > lodBlendStart then
            if e.sidePlane.id % lodDrawEveryPlane ~= 0 then
                if lodDistance < lodBlendEnd then
                    lodAlpha = (lodBlendEnd - lodDistance) / (lodBlendEnd - lodBlendStart)
                else
                    return
                end
            end
        end
    end
    local x, y, scale = renderingUtils.project(position, camera.position.value, camera.camera.fov)
    if not x then
        return
    end

    love.graphics.translate(x, y)
    love.graphics.rotate(e.rotation.value)

    local depth = mathUtils.clamp01((e.position.value.z - camera.position.value.z + 8) / (-fogDistance+8))

    local size = e.size.value * scale
    if e.sidePlane and e.texture then
        local r, g, b, a = e.sidePlane.borderColor[1], e.sidePlane.borderColor[2], e.sidePlane.borderColor[3], e.sidePlane.borderColor[4]

        local border = 1.5
        if depth < 0.1 then
            border = border + (1 - depth / 0.1)
        end
        border = border * a
        size = size * (1 + border)

        if not clearColor then
            if a > 0 then
                clearColor = {r, g, b}
            else
                clearColor = {camera.camera.fogColor[1], camera.camera.fogColor[2], camera.camera.fogColor[3]}
            end
        end

        if not isFogPlaneRendered then
            love.graphics.setColor(camera.camera.fogColor[1], camera.camera.fogColor[2], camera.camera.fogColor[3])
            love.graphics.rectangle("fill", -size.x * 0.5, -size.y * 0.5, size.x, size.y)
            isFogPlaneRendered = true
        end
    end

    if e.color then
        love.graphics.setColor(
            e.color.r,
            e.color.g,
            e.color.b,
            e.color.a * lodAlpha
        )
    else
        love.graphics.setColor(1, 1, 1, lodAlpha)
    end

    if e.fillMode then
        love.graphics.rectangle(e.fillMode.value, -size.x * 0.5, -size.y * 0.5, size.x, size.y)
    end

    if e.texture then
        local w, h = e.texture.width, e.texture.height
        love.graphics.draw(e.texture.value, 0, 0, 0, size.x/w, size.y/h, w * 0.5, h * 0.5)
    end
end

function PlaneRendering:init()
    clearColor = nil

    fogDistance = self:getWorld().gameManager.levelConfig.fogDistance or 100
    minZ = -fogDistance - 5
end

function PlaneRendering:draw()
    local camera = self.cameraPool[1]
    if not camera then
        return
    end

    screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

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

    local fogColor = camera.camera.fogColor

    love.graphics.setCanvas(canvas)
    if clearColor then
        love.graphics.clear(clearColor[1], clearColor[2], clearColor[3], 1)
    else
        love.graphics.clear(fogColor[1], fogColor[2], fogColor[3], 1)
    end
    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.rotate(camera.rotation.value)
    isFogPlaneRendered = false

    for index = -minZ * depthPrecision, 0, -1 do
        local group = sortedGroups[index]
        if group then
            if group.count > 1 then
                table.sort(group, function (a, b) return a.position.value.z < b.position.value.z end)
            end
            for i = 1, group.count do
                love.graphics.push()
                render(group[i], camera)
                love.graphics.pop()
            end
        end
    end

    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.origin(1, 1, 1, 1)
    love.graphics.draw(canvas)
end

function PlaneRendering:resize(w, h)
    canvas = love.graphics.newCanvas()
end

return PlaneRendering