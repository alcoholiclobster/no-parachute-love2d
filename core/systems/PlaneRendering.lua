local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local renderingUtils = require("utils.rendering")
local assets = require("core.assets")

local PlaneRendering = Concord.system({
    pool = {"position", "size", "rotation", "drawable"},
    cameraPool = {"camera"}
})

local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
local depthPrecision = 4
local minZ = -100
local maxZ = 0

local fogColor = {0, 0, 0}
local planeShader = love.graphics.newShader[[
uniform vec4 fogcolor = vec4(1, 0, 0, 1);
uniform float depth = 1;

vec4 effect(vec4 vcolor, Image texture, vec2 texcoord, vec2 pixcoord)
{
    vec4 texcolor = Texel(texture, texcoord);
    vec3 color = (texcolor.rgb * vcolor.rgb) + (fogcolor.rgb - (texcolor.rgb * vcolor.rgb)) * depth;
    return vec4(color, texcolor.a * vcolor.a);
}
]]

local function render(e, camera)
    local x, y, scale = renderingUtils.project(e.position.value, camera.position.value)
    if not x then
        return
    end

    love.graphics.translate(x, y)
    love.graphics.rotate(e.rotation.value)

    local depth = mathUtils.clamp01((e.position.value.z - camera.position.value.z) / -100)
    planeShader:send("depth", depth)

    local size = e.size.value * scale
    if e.decorativePlane and e.texture then
        local imageData = assets.textureImageData(e.texture.value)
        local r, g, b = imageData:getPixel(0, 0)
        love.graphics.setColor(
            r, g, b, 1
        )

        local mul = 1/2*scale*10
        love.graphics.draw(assets.texture("plane_border"), 0, 0, 0, mul, mul, 2, 2)
    end

    if e.color then
        love.graphics.setColor(
            e.color.r,
            e.color.g,
            e.color.b,
            1
        )
    else
        love.graphics.setColor(1, 1, 1, 1)
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
    fogColor = self:getWorld().gameManager.levelConfig.fogColor or {0, 0, 0}
    fogColor = {fogColor[1] / 255, fogColor[2] / 255, fogColor[3] / 255, 1}
    planeShader:sendColor("fogcolor", fogColor)
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

    love.graphics.clear(fogColor[1], fogColor[2], fogColor[3], 1)
    love.graphics.setShader(planeShader)
    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.rotate(camera.rotation.value)

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

    love.graphics.setShader()
end

return PlaneRendering