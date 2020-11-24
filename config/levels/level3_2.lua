return {
    name = "Gears",

    fallSpeed = 32,
    fogColor = {0, 20, 10},
    fogDistance = 70,
    playerRotationMode = "constant",
    playerRotationSpeed = -2.5,

    -- sidePlanesRandomBrightness = true,
    -- sidePlanesBrightness = 0.95,
    sidePlanesCount = 60,
    sidePlanes = {
        {
            textures = {
                "levels/level3_2/decorative1",
                "levels/level3_2/decorative3",
            },
            pattern = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2 },
        },
        {
            textures = {
                "levels/level3_2/decorative2",
                "levels/level3_2/decorative3",
            },
            pattern = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2 },
        },
        {
            textures = {
                "levels/level3_2/decorative1",
                "levels/level3_2/decorative2",
                "levels/level3_2/decorative3",
            },
            pattern = { 1, 1, 1, 1, 1, 3, 2, 2, 2, 2, 2, 3 },
        },
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
        { name = "middle_door", distance = 200, rotation = 0, switchSidePlanes = true, },
        { name = "middle_door", distance = 200, rotation = 0, switchSidePlanes = true, },
        { name = "middle_door", distance = 1000, rotation = 0 },
    }
}