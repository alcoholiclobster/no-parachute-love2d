local Concord = require("lib.concord")
local debugGraph = require("lib.debugGraph")

local DebugFrameRateGraph = Concord.system({})

local isVisible = false
local fpsGraph
local memGraph

function DebugFrameRateGraph:init()
    local y = love.graphics.getHeight() - 110
    fpsGraph = debugGraph:new('fps', 10, y, 200, 100)
    y = y - 110
    memGraph = debugGraph:new('mem', 10, y, 200, 100)
end

function DebugFrameRateGraph:draw()
    if isVisible then
        fpsGraph:draw()
        memGraph:draw()
    end
end

function DebugFrameRateGraph:update(deltaTime)
    fpsGraph:update(deltaTime)
    memGraph:update(deltaTime)
end

function DebugFrameRateGraph:keyPress(key)
    if key == "f4" then
        isVisible = not isVisible
    end
end

return DebugFrameRateGraph