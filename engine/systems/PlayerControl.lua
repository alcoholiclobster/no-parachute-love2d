local Concord = require("lib.concord")
local maf = require("lib.maf")

local PlayerControl = Concord.system({
    pool = {"velocity", "character", "moveDirection", "playerControlled"},
})

function PlayerControl:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local speed = 10
        local direction = maf.vec3(0, 0, 0)
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            direction.x = -speed
        elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            direction.x = speed
        else
            direction.x = 0
        end

        if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
            direction.y = -speed
        elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
            direction.y = speed
        else
            direction.y = 0
        end

        e.moveDirection.value = direction
    end
end

return PlayerControl