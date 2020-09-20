return {
    name = "Level 1",

    fallSpeed = 30,

    decorationPlanesCount = 50,

    decorations = {
        { texture = "level2/decorative1" },
    },

    distanceBetweenObstacles = 30,
    obstaclesCount = 5,
    obstacles = {
        {
            texture = "level2/obstacle1",
            appearFrom = 1,
            appearTo = 10,

            -- rotationSpeed = 10,
            -- velocity = {5, 0, 0},
        },
        {
            texture = "level2/obstacle2",
            appearFrom = 1,
            appearTo = 10,
        }
    },
}