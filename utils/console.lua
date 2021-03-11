local console = {}

local lines = {}
local linesCount = 0

local lineHeight = 20
local visibleLines = 10

local isVisible = false

local font = love.graphics.newFont("assets/fonts/Roboto-Regular.ttf", 14)

function console.log(...)
    local t = {...}

    local line = ""
    for _, v in ipairs(t) do
        line = line .. " " .. tostring(v)
    end

    table.insert(lines, {time = os.date("%X"), text = line})
    linesCount = linesCount + 1
end

function console.draw()
    if not isVisible then
        return
    end

    local x = 20
    local y = visibleLines * lineHeight + 20
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0, 0.9)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), visibleLines * lineHeight + 40)

    for i = linesCount, math.max(1, linesCount - visibleLines + 1), -1 do
        local line = lines[i]
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
        love.graphics.print(line.time, x, y)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(line.text, x + 70, y)

        y = y - lineHeight
    end
end

function console.toggle()
    isVisible = not isVisible
end

return console