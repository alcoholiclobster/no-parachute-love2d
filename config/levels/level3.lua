return {
    name = "Level 1",

    fallSpeed = 32,
    fogColor = {15, 0, 0},
    playerRotationMode = "constant",
    playerRotationSpeed = -0.5,

    decorationPlanesCount = 60,

    decorations = {
        { texture = "level3/decorative1" },
        { texture = "level3/decorative2" },
        { texture = "level3/decorative3" },
    },

    distanceBetweenObstacles = 30,
    obstaclesCount = 30,
    obstacles = {
        {
            planes = {
                { texture = "level3/obstacle1_1", rotationSpeed = 4, },
                { texture = "level3/obstacle1_2", position = {0, 0, -1}, },
                { texture = "level3/obstacle1_3", position = {0, 0, 2}, },
            },
            appearFrom = 1,
            appearTo = 999,
        },

        {
            planes = {
                { texture = "level3/obstacle2_1"},
                { texture = "level3/obstacle2_2", position = {0, 0, -0.5}, rotationSpeed = -16, },
                { texture = "level3/obstacle2_3", position = {0, 0, -1}, },
            },
            appearFrom = 1,
            appearTo = 999,
        },

        {
            planes = {
                { texture = "level3/obstacle3_1", position = {0, 0, 0} },
                { texture = "level3/obstacle3_2", position = {0, 0, -10} },
                { texture = "level3/obstacle3_3", position = {0, 0, -9.5} },
            },
            appearFrom = 1,
            appearTo = 999,
        },

        {
            planes = {
                { texture = "level3/obstacle4_1" },
                { texture = "level3/obstacle4_2", position = {7, 0, -0.5}, velocity = {-4, 0, 0} },
            },
            appearFrom = 1,
            appearTo = 999,
        },
    }
}