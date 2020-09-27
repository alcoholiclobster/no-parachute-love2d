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
    }
}