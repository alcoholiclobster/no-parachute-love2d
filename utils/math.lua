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

return {
    distance = distance,
    lerp = lerp,
    clamp = clamp,
    clamp01 = clamp01
}