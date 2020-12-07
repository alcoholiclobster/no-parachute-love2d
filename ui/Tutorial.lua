local class = require("lib.middleclass")
local assets = require("core.assets")
local mathUtils = require("utils.math")
local scheduler = require("utils.scheduler")

local Tutorial = class("Tutorial")

local lastLineIndex = 0

function Tutorial:initialize()
    self.lines = {
        {
            text = "Use WASD or ARROWS to move",

            delay = 3,
            duration = 5,
        },
        {
            text = "Hold SPACE to break fragile walls",
            additionalText = "and fall faster",

            delay = 3,
            duration = 5,
        },
        {
            text = "Avoid obstacles to survive",

            delay = 6,
            duration = 5,
        },
    }

    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.lineAppearedAt = 0
    self.currentLineIndex = 0
end

function Tutorial:process()
    for i, line in ipairs(self.lines) do
        scheduler.wait(line.delay)
        if lastLineIndex < i then
            self.currentLineIndex = i
            lastLineIndex = i
        else
            self.currentLineIndex = 0
        end
        self.lineAppearedAt = love.timer.getTime()
        scheduler.wait(line.duration)

        self.currentLineIndex = 0
    end
end

function Tutorial:destroy()
    scheduler.killThread(self.thread)
end

function Tutorial:drawShadowText(text, x, y, width, align)
    local w = 2
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, a)
    love.graphics.printf(text, x-w, y-w, width, align)
    love.graphics.printf(text, x+w, y-w, width, align)
    love.graphics.printf(text, x-w, y+w, width, align)
    love.graphics.printf(text, x+w, y+w, width, align)
    love.graphics.setColor(r, g, b, a)
    love.graphics.printf(text, x, y, width, align)
end

function Tutorial:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    local line = self.lines[self.currentLineIndex]
    if not line then
        return
    end

    local p = mathUtils.clamp01((love.timer.getTime() - self.lineAppearedAt) / 0.3)
    love.graphics.setColor(1, 1, 1, p)
    love.graphics.setFont(assets.font("Roboto-Bold", 44))
    self:drawShadowText(line.text, 0, screenHeight * 0.15, screenWidth, "center")

    if line.additionalText then
        love.graphics.setFont(assets.font("Roboto-Bold", 24))
        self:drawShadowText(line.additionalText, 0, screenHeight * 0.15 + 50, screenWidth, "center")
    end
end

return Tutorial