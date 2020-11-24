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
        two_red_gears_big = {
            planes = {
                { texture = "levels/level3_2/gear_red_big", rotationSpeed = 1, position = {2.5, 2.5, 0} },
                { texture = "levels/level3_2/gear_holder", position = {2.5, 2.5, 0.5} },
                { texture = "levels/level3_2/gear_red_medium", rotationSpeed = -1, position = {-3, -3, 0} },
                { texture = "levels/level3_2/gear_holder", position = {3, 3, 0.5}, rotation = 180, },
            },
        },
    },

    planes = {
        { name = "two_red_gears_big", distance = 100, rotation = 0 },
        { name = "two_red_gears_big", distance = 40, rotation = 90 },
        { name = "two_red_gears_big", distance = 40, rotation = 180 },
        { name = "two_red_gears_big", distance = 40, rotation = 270 },
        { name = "two_red_gears_big", distance = 200, rotation = 0, switchSidePlanes = true, },
        { name = "two_red_gears_big", distance = 200, rotation = 0, switchSidePlanes = true, },
        { name = "two_red_gears_big", distance = 1000, rotation = 0 },
    }
}