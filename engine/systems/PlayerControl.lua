local Concord = require("lib.concord")
local maf = require("lib.maf")

local PlayerControl = Concord.system({
    pool = {"velocity", "playerControlled"},
    cameraPool = { "camera" }
})

local function rotateVector2D(v, theta)
    local x, y = v.x, v.y

    local cs = math.cos(theta)
    local sn = math.sin(theta)

    local px = x * cs - y * sn
    local py = x * sn + y * cs

    return maf.vec3(px, py, 0)
end

function PlayerControl:update(deltaTime)
    local camera = self.cameraPool[1]

    for _, e in ipairs(self.pool) do
        local acceleration = 15
        local friction = 7
        local speed = 10
        local direction = maf.vec3(0, 0, 0)
        if love.keyboard.isDown("left") then
            direction.x = -speed
        elseif love.keyboard.isDown("right") then
            direction.x = speed
        else
            direction.x = 0
        end

        if love.keyboard.isDown("up") then
            direction.y = -speed
        elseif love.keyboard.isDown("down") then
            direction.y = speed
        else
            direction.y = 0
        end

        direction = rotateVector2D(direction, e.rotation.value)
        e.velocity.value = e.velocity.value + direction * acceleration * deltaTime
        e.velocity.value = e.velocity.value - e.velocity.value * friction * deltaTime

        e.rotation.value = e.rotation.value + deltaTime * 0.1
    end
end

return PlayerControl