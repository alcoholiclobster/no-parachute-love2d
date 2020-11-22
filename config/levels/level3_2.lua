return {
    name = "Gears",

    fallSpeed = 32,
    fogColor = {15, 0, 0},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -2.5,

    sidePlanesRandomBrightness = true,
    -- sidePlanesBrightness = 0.95,
    sidePlanesCount = 40,
    sidePlanes = {
        {
            textures = {
                "levels/level3_2/decorative1",
                "levels/level3_2/decorative2",
            }
        }
    },

    planeTypes = {
        middle_door = {
            planes = {
                { texture = "levels/level3_1/obstacle4_1" },
                { texture = "levels/level3_1/obstacle4_2", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 2, },
            },
        },
    },

    planes = {
        { name = "middle_door", distance = 1000, rotation = 0 },
    }
}