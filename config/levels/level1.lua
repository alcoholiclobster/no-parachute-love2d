return {
    name = "Level 1",

    fallSpeed = 10,

    decorationPlanesCount = 40,

    decorations = {
        { texture = "level1/decorative1" },
        { texture = "level1/decorative2" },
        { texture = "level1/decorative3" },
    },

    distanceBetweenObstacles = 10,
    obstaclesCount = 1,
    obstacles = {
        {
            texture = "level1/obstacle1",
            -- requiredFreeSpace = 0,
            appearFrom = 1,
            appearTo = 10,
            -- rotationSpeed = 10,
            -- velocity = {5, 0, 0},
        }
    },
}