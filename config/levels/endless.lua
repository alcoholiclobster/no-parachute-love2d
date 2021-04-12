local levelConfig = {
    name = "Endless",

    fogColor = {0, 0, 0},
    fogDistance =  90,

    playerRotationMode = "constant",
    playerRotationSpeed = -12,

    sidePlanesRandomBrightness = true,
    sidePlanesCount = 70,
    sidePlanes = {
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
        },
    },

    planeTypes = {
        middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                -- { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1.5, },
            },
        },
    },
}

local function randomize()
    levelConfig.fallSpeed = math.random() * 100
    levelConfig.totalHeight = 999999999
    levelConfig.endless = true

    -- Random planes
    local planes = {}
    local mt = {
        __index  = function ()
            if math.random() > 0.5 then
                return { name = "middle_door", distance = 20 }
            else
                return { distance = 20 }
            end
        end,
    }
    setmetatable(planes, mt)
    levelConfig.planes = planes
end

levelConfig.randomize = randomize

return levelConfig