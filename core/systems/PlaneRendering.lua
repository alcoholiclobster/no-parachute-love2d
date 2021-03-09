local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local renderingUtils = require("utils.rendering")
local assets = require("core.assets")
local settings = require "core.settings"

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

local fogColor = {0, 0, 0}
local fogDistance = 100
local planeShader = love.graphics.newShader[[
uniform vec4 fogcolor = vec4(1, 0, 0, 1);
uniform float depth = 1;

vec4 effect(vec4 vcolor, Image texture, vec2 texcoord, vec2 pixcoord)
{
    vec4 texcolor = Texel(texture, texcoord);
    texcolor.rgb = mix(texcolor.rgb * vcolor.rgb, fogcolor.rgb, depth);
    return vec4(texcolor.rgb, texcolor.a * vcolor.a);
}
]]

local blurShader = love.graphics.newShader[[
uniform float aspect_ratio = 0.0;
uniform float blur_level = 0.0;
float blur_radius = 1.0;
int blur_steps = 12;

vec4 effect(vec4 vcolor, Image texture, vec2 texcoord, vec2 pixcoord)
{
    vec2 pos = texcoord;
    pos.x *= aspect_ratio;

    vec2 dir = pos - vec2(0.5 * aspect_ratio, 0.5);
    float blur_amount = clamp(pow(length(dir) + 0.1, 3.5), 0.0, 1.0);

    vec4 color = vec4(0.0);

    dir = normalize(dir) * blur_amount / 128.0 * blur_radius * blur_level;
    float count = 0.0;
    for (int i = 0; i < blur_steps; i++)
    {
        color += Texel(texture, texcoord - i * dir);
        count += 1.0;
    }
    return color / count;
}]]

local lodBlendEnabled = true
local lodBlendStart = 0.25
local lodBlendEnd = 0.5
local lodDrawEveryPlane = 2
local lodOmitSideDistance = 0.6

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

    local depth = mathUtils.clamp01((e.position.value.z - camera.position.value.z + 8) / -fogDistance)
    planeShader:send("depth", depth)

    local size = e.size.value * scale
    if e.sidePlane and e.texture then
        if not lodBlendEnabled or lodDistance < lodOmitSideDistance or e.sidePlane.id % 3 ~= 0 then
            local imageData = assets.textureImageData(e.texture.value)
            local r, g, b = imageData:getPixel(0, 0)
            if e.color then
                r = r * e.color.r
                g = g * e.color.g
                b = b * e.color.b
            end
            love.graphics.setColor(
                r, g, b, lodAlpha
            )

            local mul = (1/2*scale*10)*(e.size.value.x/10)
            love.graphics.draw(assets.texture("plane_border"), 0, 0, 0, mul, mul, 4, 4)
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
    fogColor = self:getWorld().gameManager.levelConfig.fogColor or {0, 0, 0}
    fogColor = {fogColor[1] / 255, fogColor[2] / 255, fogColor[3] / 255, 1}

    fogDistance = self:getWorld().gameManager.levelConfig.fogDistance or 100
    minZ = -fogDistance - 5
    planeShader:sendColor("fogcolor", fogColor)

    blurShader:send("aspect_ratio", screenWidth / screenHeight)
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

    love.graphics.setCanvas(canvas)
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
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.origin(1, 1, 1, 1)
    if not self.overrideBlurLevel then
        local cameraSpeed = mathUtils.clamp01((lastFrameCameraZ - camera.position.value.z) / 0.1)
        lastFrameCameraZ = camera.position.value.z
        blurShader:send("blur_level", cameraSpeed)
    else
        blurShader:send("blur_level", self.overrideBlurLevel)
    end
    if settings.get("motion_blur") then
        love.graphics.setShader(blurShader)
    end
    love.graphics.draw(canvas)
    love.graphics.setShader()
end

-- TODO: Move to main.lua
function love.resize(w, h)
    blurShader:send("aspect_ratio", w / h)
    canvas = love.graphics.newCanvas()
end

return PlaneRendering