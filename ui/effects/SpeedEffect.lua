local class = require("lib.middleclass")

local SpeedEffect = class("SpeedEffect")

function SpeedEffect:initialize()
    self.amount = 0

    self.lines = {}
    self.lineDelay = 0

    self.screenSize = math.max(love.graphics.getWidth(), love.graphics.getHeight()) * 1.1
end

function SpeedEffect:update(deltaTime)
    self.lineDelay = self.lineDelay - deltaTime
    if self.lineDelay < 0 then
        self.lineDelay = 0.02

        for i = 1, 5 * self.amount do
            self:addLine()
        end
    end

    for i = #self.lines, 1, -1 do
        local line = self.lines[i]
        line.time = line.time + deltaTime
        if line.time > line.lifeTime then
            table.remove(self.lines, i)
        end
    end
end

function SpeedEffect:draw()
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)

    for i, line in ipairs(self.lines) do
        local progress = line.time / line.lifeTime
        local alpha = line.brigtness * self.amount
        if progress > 0.5 then
            alpha = alpha * (progress - 0.5) / 0.5
        end
        love.graphics.setColor(line.brigtness, line.brigtness, line.brigtness, alpha)
        local x1 = line.x1 - line.width
        local y1 = line.y1 - line.width

        local x2 = line.x1 + line.width
        local y2 = line.y1 + line.width

        local cx = line.x2 + line.dx * self.screenSize * 0.5 * progress
        local cy = line.y2 + line.dy * self.screenSize * 0.5 * progress

        love.graphics.polygon('fill', x1, y1, x2, y2, cx, cy)
    end
    love.graphics.pop()
end

function SpeedEffect:addLine()
    local brigtness = math.random() * 0.3 + 0.4
    local width = self.screenSize * (0.015 + math.random() * 0.015)
    local direction = math.random() * math.pi * 2
    local dx = math.cos(direction)
    local dy = math.sin(direction)
    local lineLength = self.screenSize * (0.1 + math.random() * 0.25)

    table.insert(self.lines, {
        x1 = dx * self.screenSize,
        y1 = dy * self.screenSize,

        x2 = dx * lineLength,
        y2 = dy * lineLength,

        width = width,
        brigtness = brigtness,

        dx = dx,
        dy = dy,

        lifeTime = math.random() * 0.3,
        time = 0,
    })
end

function SpeedEffect:setAmount(amount)
    self.amount = amount
end

return SpeedEffect