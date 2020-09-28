local joystickManager = {}

local connectedJoysticks = {}

function joystickManager.get()
    return connectedJoysticks[1]
end

function joystickManager.add(joystick)
    table.insert(connectedJoysticks, joystick)
end

function joystickManager.remove(joystick)
    for i, j in ipairs(connectedJoysticks) do
        if j == joystick then
            table.remove(connectedJoysticks, i)
            return
        end
    end
end

return joystickManager