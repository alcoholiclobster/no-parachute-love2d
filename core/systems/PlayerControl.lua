local Concord = require("lib.concord")
local maf = require("lib.maf")
local joystickManager = require("utils.joystickManager")
local mathUtils = require("utils.math")

local PlayerControl = Concord.system({
    pool = {"velocity", "character", "moveDirection", "controlledByPlayer", "alive"},
})

local joystickDeadZone = 0.15

local touchStartX, touchStartY = nil, nil
local touchLength = 0.2

function PlayerControl:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local joystick = joystickManager.get()
        local direction = maf.vec3(0, 0, 0)

        if e.controlledByPlayer.isInputMovementEnabled then
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

            if joystick then
                local xAxis = joystick:getGamepadAxis("leftx")
                local yAxis = joystick:getGamepadAxis("lefty")
                direction.x = direction.x + mathUtils.clamp01((math.abs(xAxis) - joystickDeadZone) / (1 - joystickDeadZone)) * mathUtils.sign(xAxis)
                direction.y = direction.y + mathUtils.clamp01((math.abs(yAxis) - joystickDeadZone) / (1 - joystickDeadZone)) * mathUtils.sign(yAxis)
            end

            -- Touch input
            local isTouching = love.mouse.isDown(1)
            if isTouching and not touchStartX then
                touchStartX, touchStartY = love.mouse.getPosition()
            elseif not isTouching and touchStartX then
                touchStartX, touchStartY = nil, nil
            end

            if touchStartX and isTouching then
                local touchX, touchY = love.mouse.getPosition()
                local touchLengthAbsolute = love.graphics.getWidth() * touchLength
                direction.x = -(touchStartX - touchX) / touchLengthAbsolute
                direction.y = -(touchStartY - touchY) / touchLengthAbsolute
            end
        end

        e.moveDirection.value = direction

        if e.controlledByPlayer.isInputSpeedUpEnabled then
            if love.keyboard.isDown("space") or (joystick and joystick:isDown(1)) then
                e.velocity.value.z = e.velocity.value.z - deltaTime * 64
            end
        end
    end
end

return PlayerControl