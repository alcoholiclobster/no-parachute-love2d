return {
    name = "64x64 test",
    nextLevel = nil,

    fallSpeed = 35,
    fogColor = {0, 5, 10},
    fogDistance = 50,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.65,
    sidePlanes = {
        {
            textures = {
                "levels/level_64/side_plane1",
                "levels/level_64/side_plane1",
                "levels/level_64/side_plane1",
            },
        },

    },

    planeTypes = {
        obstacle1 = {
            planes = {
                { texture = "levels/level_64/obstacle_plane1", },
            },
        },
    },

    planes = {
        { name = "obstacle1", distance = 60, rotation = 0 },
        { name = "obstacle1", distance = 60, rotation = 0 },
        { name = "obstacle1", distance = 60, rotation = 0 },
        { name = "obstacle1", distance = 60, rotation = 0 },
    },
}