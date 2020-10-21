return {
    name = "Forest 1",
    nextLevel = "level1_2",
    enableTutorial = true,

    fallSpeed = 25,
    fogColor = {0, 20, 31},
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    sidePlanesCount = 40,
    sidePlanes = {
        {
            textures = {
                "levels/level1_1/side_plane1",
                "levels/level1_1/side_plane2",
                "levels/level1_1/side_plane3",
                "levels/level1_1/side_plane4",
            },
        }
    },

    planeTypes = {
        obstacle1 = {
            planes = { { texture = "levels/level1_1/obstacle_plane1", }},
        },
        obstacle2 = {
            planes = { { texture = "levels/level1_1/obstacle_plane2", }},
        },
        obstacle3 = {
            planes = { { texture = "levels/level1_1/obstacle_plane3", }},
        },
        obstacle4 = {
            planes = { { texture = "levels/level1_1/obstacle_plane4", }},
        },
        obstacle5 = {
            planes = { { texture = "levels/level1_1/obstacle_plane5", }},
        },
    },

    planes = {
        { name = "obstacle1", distance = 200, rotation = 0 },
        { name = "obstacle1", distance = 40, rotation = 180 },

        { name = "obstacle2", distance = 300, rotation = 0 },
        { name = "obstacle1", distance = 40, rotation = 90 },
        { name = "obstacle1", distance = 40, rotation = 270 },

        { name = "obstacle2", distance = 150, rotation = 90 },
        { name = "obstacle3", distance = 30, rotation = 0 },
        { name = "obstacle4", distance = 40, rotation = 0 },
        { name = "obstacle3", distance = 30, rotation = 270 },
        { name = "obstacle3", distance = 50, rotation = 180 },
        { name = "obstacle4", distance = 30, rotation = 90 },
        { name = "obstacle1", distance = 30, rotation = 270 },

        { name = "obstacle1", distance = 60, rotation = 270 },
        { name = "obstacle1", distance = 25, rotation = 180 },
        { name = "obstacle2", distance = 30, rotation = 90 },
        { name = "obstacle1", distance = 20, rotation = 0 },
        { name = "obstacle1", distance = 30, rotation = 180 },
        { name = "obstacle5", distance = 20, rotation = 0 },
        { name = "obstacle4", distance = 20, rotation = 270 },
        { name = "obstacle1", distance = 20, rotation = 90 },
        { name = "obstacle5", distance = 20, rotation = 90 },

        { name = "obstacle3", distance = 60, rotation = 90 },
        { name = "obstacle4", distance = 40, rotation = 0 },
        { name = "obstacle4", distance = 30, rotation = 90 },
    },
}