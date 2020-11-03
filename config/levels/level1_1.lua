return {
    name = "Forest 1",
    nextLevel = "level1_2",
    enableTutorial = true,

    fallSpeed = 25,
    fogColor = {0, 20, 31},
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.75,
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
            planes = {
                { texture = "levels/level1_1/obstacle_plane1", },
                { texture = "levels/level1_1/decorative_plane2", decorative = true, position = {0, 0, 5 }}
            },
        },
        obstacle2 = {
            planes = {
                { texture = "levels/level1_1/obstacle_plane2", },
                { texture = "levels/level1_1/decorative_plane2", decorative = true, position = {0, 0, 5 }},
                { texture = "levels/level1_1/decorative_plane2", decorative = true, position = {0, 0, 7 }, rotation = 90},
            },
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
        obstacle6 = {
            planes = { { texture = "levels/level1_1/obstacle_plane6", }},
        },
        obstacle6_broken = {
            planes = { { texture = "levels/level1_1/obstacle_plane6_2", }},
        },
        decorative1 = {
            planes = { { texture = "levels/level1_1/decorative_plane1", decorative = true }},
        },
        decorative2 = {
            planes = { { texture = "levels/level1_1/decorative_plane2", decorative = true }},
        },
    },

    planes = {
        { name = "decorative1", distance = 50, rotation = 0 },
        { name = "decorative2", distance = 50, rotation = 90 },
        { name = "decorative1", distance = 50, rotation = 180 },
        { name = "decorative2", distance = 30, rotation = 0 },
        { name = "decorative1", distance = 10, rotation = 180 },
        { name = "obstacle1", distance = 10, rotation = 0 },
        { name = "decorative2", distance = 30, rotation = 0 },
        { name = "obstacle1", distance = 10, rotation = 180 },

        { name = "decorative1", distance = 150, rotation = 0 },
        { name = "obstacle6", distance = 50, rotation = 180 },
        { name = "decorative2", distance = 45, rotation = 0 },
        { name = "obstacle6", distance = 5, rotation = 0 },

        { name = "obstacle2", distance = 50, rotation = 0 },
        { name = "obstacle6", distance = 15, rotation = 270 },
        { name = "decorative1", distance = 15, rotation = 0 },
        { name = "obstacle1", distance = 10, rotation = 90 },
        { name = "obstacle6", distance = 20, rotation = 90 },
        { name = "obstacle1", distance = 20, rotation = 270 },

        { name = "obstacle6_broken", distance = 75, rotation = 0 },
        { name = "obstacle2", distance = 75, rotation = 90 },

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