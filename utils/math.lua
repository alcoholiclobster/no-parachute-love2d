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

    return maf.vec3(px, py, v.z or 0)
end

local function sign(x)
    if x < 0 then
        return -1
    elseif x > 0 then
        return 1
    else
        return 0
    end
end

local function lerpRGBA(r1, g1, b1, a1, r2, g2, b2, a2, t)
    return r1 + (r2 - r1) * t,
           g1 + (g2 - g1) * t,
           b1 + (b2 - b1) * t,
           a1 + (a2 - a1) * t
end

return {
    distance = distance,
    lerp = lerp,
    clamp = clamp,
    clamp01 = clamp01,
    rotateVector2D = rotateVector2D,
    sign = sign,
    lerpRGBA = lerpRGBA,
}