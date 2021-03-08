local function fixDpiAwareness()
    local ffi = require("ffi")

    ffi.cdef([[
        int SetProcessDpiAwareness(int);
    ]])

    local shcore = ffi.load("shcore")
    shcore.SetProcessDpiAwareness(2)
end

function love.conf(t)
    pcall(fixDpiAwareness)

    t.window.title = "No Parachute"
    t.window.width = 1920
    t.window.height = 1080
    t.window.resizable = true
    t.console = true
    t.window.vsync = false
    t.window.usedpiscale = false
end