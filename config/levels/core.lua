return {
    name = "Core",
    nextLevel = nil,
    -- music = "meat_theme",
    -- ambient = "worm",

    fallSpeed = 80,
    fogColor = {53, 83, 255},
    fogDistance = 50,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/core/side_planes/1",
                "levels/core/side_planes/2",
            },
        },
    },

    planeTypes = {

    },

    planes = {
        { distance = 100, tunnelShape = { direction = {0, 0}, rotationSpeed = 1 }, },
        { distance = 200, tunnelShape = { direction = {10, 0}, rotationSpeed = -1 }, },
        { distance = 300, tunnelShape = { direction = {0, 10}, rotationSpeed = 0.5 }, },
        { distance = 400, tunnelShape = { direction = {-5, 0}, rotationSpeed = 4 }, },
        { distance = 500, tunnelShape = { direction = {0, 0}, rotationSpeed = -2 }, },
        { distance = 1000 },
    },
}