local console = {}

local lines = {}
local linesCount = 0

local lineHeight = 20
local visibleLines = 10
local font = love.graphics.newFont(14)

local isVisible = false

function console.overridePrint()
    local _print = print
    print = function (...)
        console.log(...)
        return _print(...)
    end
end

function console.log(...)
    local t = {...}

    local line = ""
    for _, v in ipairs(t) do
        line = line .. " " .. tostring(v)
    end

    local time = os.date("%X")
    if linesCount > 0 and lines[linesCount].text == line then
        lines[linesCount].time = time
        lines[linesCount].count = lines[linesCount].count + 1
        return
    end
    table.insert(lines, {time = time, text = line, count = 1})
    linesCount = linesCount + 1
end

function console.draw()
    if not isVisible then
        return
    end

    local y = visibleLines * lineHeight + 20
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0, 0.9)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), visibleLines * lineHeight + 40)

    for i = linesCount, math.max(1, linesCount - visibleLines + 1), -1 do
        local line = lines[i]
        local x = 20
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
        love.graphics.print(line.time, x, y)
        x = x + 70

        if line.count > 1 then
            love.graphics.setColor(0.75, 0, 0, 1)
            love.graphics.print("(x"..line.count..")", x+7, y)
            x = x + 65
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(line.text, x, y)

        y = y - lineHeight
    end
end

function console.toggle()
    isVisible = not isVisible
end

return console