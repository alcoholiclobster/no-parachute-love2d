local maf = require("lib.maf")

local function distance(x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt(dx * dx + dy * dy)
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function clamp(a, min, max)
    return math.min(max, math.max(min, a))
end

local function clamp01(a)
    return math.min(1, math.max(0, a))
end

local function rotateVector2D(v, theta)
    local x, y = v.x, v.y

    local cs = math.cos(theta)
    local sn = math.sin(theta)

    local px = x * cs - y * sn
    local py = x * sn + y * cs

    return maf.vec3(px, py, 0)
end

return {
    distance = distance,
    lerp = lerp,
    clamp = clamp,
    clamp01 = clamp01,
    rotateVector2D = rotateVector2D,
}