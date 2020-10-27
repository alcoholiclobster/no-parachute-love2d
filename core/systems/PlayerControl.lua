local Concord = require("lib.concord")
local maf = require("lib.maf")
local joystickManager = require("utils.joystickManager")
local mathUtils = require("utils.math")

local PlayerControl = Concord.system({
    pool = {"velocity", "character", "moveDirection", "controlledByPlayer", "alive"},
})

local joystickDeadZone = 0.15

function PlayerControl:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local direction = maf.vec3(0, 0, 0)

        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            direction.x = -1
        elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            direction.x = 1
        else
            direction.x = 0
        end

        if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
            direction.y = -1
        elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
            direction.y = 1
        else
            direction.y = 0
        end

        local joystick = joystickManager.get()

        if love.keyboard.isDown("space") or (joystick and joystick:isDown(1)) then
            e.velocity.value.z = e.velocity.value.z - deltaTime * 32
        end

        if joystick then
            local xAxis = joystick:getGamepadAxis("leftx")
            local yAxis = joystick:getGamepadAxis("lefty")
            direction.x = direction.x + mathUtils.clamp01((math.abs(xAxis) - joystickDeadZone) / (1 - joystickDeadZone)) * mathUtils.sign(xAxis)
            direction.y = direction.y + mathUtils.clamp01((math.abs(yAxis) - joystickDeadZone) / (1 - joystickDeadZone)) * mathUtils.sign(yAxis)
        end

        e.moveDirection.value = direction
    end
end

return PlayerControl