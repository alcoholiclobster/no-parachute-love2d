local lastMouseState = false

local isJustPressed = false
local isJustReleased = false

local mx, my = 0, 0

local function isMouseJustPressed()
    return isJustPressed
end

local function cancelClickEvent()
    isJustPressed = false
end

local function getPreviousMousePosition()
    return mx, my
end

local function update()
    if isJustPressed then
        isJustPressed = false
    end
    if isJustReleased then
        isJustReleased = false
    end

    local mouseState = love.mouse.isDown(1)
    if mouseState ~= lastMouseState then
        lastMouseState = mouseState

        if mouseState then
            isJustPressed = true
        else
            isJustReleased = true
        end
    end

    mx, my = love.mouse.getPosition()
end

return {
    isMouseJustPressed = isMouseJustPressed,
    update = update,
    cancelClickEvent = cancelClickEvent,
    getPreviousMousePosition = getPreviousMousePosition,
}