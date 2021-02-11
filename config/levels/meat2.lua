return {
    name = "Flesh Hell 2",
    nextLevel = nil,

    fallSpeed = 47,
    fogColor = {25, 10, 0},
    fogDistance = 90,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 60,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/flesh",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_small",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_wide",
            },
        },
    },

    planeTypes = {
        meat_long_middle_thing = {
            planes = {
                { texture = "levels/meat/obstacles/long_meat_middle_thing" },
            },
        },
        meat_half_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_obstacle_half" },
            },
        },
        meat_small_transition_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_small_transition_wall" },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -2}, rotation = 90 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -4}, rotation = 0 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -6}, rotation = 180 },
                { texture = "levels/meat/side_planes/flesh_small", position = {0, 0, -8}, rotation = 270 },
            }
        }
    },

    planes = {
        { distance = 100, tunnelShape = { direction = {0, 2}, rotationSpeed = 0.3 },},
        { distance = 100, name = "meat_small_transition_wall", },
        { distance = 10, switchSidePlanes = true, tunnelShape = { direction = {0, 8}, rotationSpeed = 0.6 }, },
        { distance = 100, switchSidePlanes = true, tunnelShape = { direction = {0, 1}, rotationSpeed = 0.2 }, },
        { distance = 5000 },
    },
}