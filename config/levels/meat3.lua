return {
    name = "Meat 3",
    nextLevel = nil,
    music = "meat_theme",
    ambient = "worm",

    fallSpeed = 55,
    fogColor = {25, 10, 0},
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
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/core/side_planes/1",
                "levels/core/side_planes/2",
            },
        },
    },

    planeTypes = {
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },
    },

    planes = {
        { distance = 200, name = "stone_breakable_wall", switchSidePlanes = true},
        { distance = 94, fogColor = {255, 200, 100}, fallSpeed = 80},

        { distance = 100, tunnelShape = { direction = {0, 0}, rotationSpeed = 1 }, },
        { distance = 200, tunnelShape = { direction = {10, 0}, rotationSpeed = -1 }, },
        { distance = 300, tunnelShape = { direction = {0, 10}, rotationSpeed = 0.5 }, },
        { distance = 400, tunnelShape = { direction = {-5, 0}, rotationSpeed = 4 }, },
        { distance = 500, tunnelShape = { direction = {0, 0}, rotationSpeed = -2 }, },
        { distance = 1000 },
    },
}