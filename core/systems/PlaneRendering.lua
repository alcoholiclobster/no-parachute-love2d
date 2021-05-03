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
local planeShader = love.graphics.newShader[[
uniform vec4 fogcolor;
uniform float depth;
uniform float border;
uniform vec4 bgcolor;

vec4 effect(vec4 vcolor, Image texture, vec2 texcoord, vec2 pixcoord)
{
    vec2 coord = texcoord * (1.0+border)-border * 0.5;

    vec2 borderStep = step(vec2(0.0, 0.0), coord) - step(vec2(1.0, 1.0), coord);
    float borderMul = 1.0 - borderStep.x * borderStep.y;

    vec4 texcolor = Texel(texture, coord);
    texcolor.a = texcolor.a * vcolor.a;

    if (borderMul > 0.0) {
        texcolor.rgb = mix(texcolor.rgb, bgcolor.rgb, (1.0 - texcolor.a) * bgcolor.a);
        texcolor.a += 1.0;
    }

    texcolor.rgb = mix(texcolor.rgb * vcolor.rgb, fogcolor.rgb, depth);
    return vec4(texcolor.rgb, texcolor.a);
}
]]

local blurShader = love.graphics.newShader[[
uniform float aspect_ratio;
uniform float blur_level;
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
        float i_float = float(i);
        color += Texel(texture, texcoord - i_float * dir);
        count += 1.0;
    }
    return color / count;
}]]

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
    planeShader:send("depth", depth)

    local size = e.size.value * scale
    if e.sidePlane and e.texture then
        local r, g, b, a = e.sidePlane.borderColor[1], e.sidePlane.borderColor[2], e.sidePlane.borderColor[3], e.sidePlane.borderColor[4]
        planeShader:send("bgcolor", {r, g, b, a})

        local border = 1.5
        if depth < 0.1 then
            border = border + (1 - depth / 0.1)
        end
        border = border * a
        planeShader:send("border", border)
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
    else
        planeShader:send("bgcolor", {0, 0, 0, 0})
        planeShader:send("border", 0)
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

    local fogColor = camera.camera.fogColor
    planeShader:send("fogcolor", camera.camera.fogColor)

    love.graphics.setCanvas(canvas)
    if clearColor then
        love.graphics.clear(clearColor[1], clearColor[2], clearColor[3], 1)
    else
        love.graphics.clear(fogColor[1], fogColor[2], fogColor[3], 1)
    end
    love.graphics.setShader(planeShader)
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

function PlaneRendering:resize(w, h)
    blurShader:send("aspect_ratio", w / h)
    canvas = love.graphics.newCanvas()
end

return PlaneRendering