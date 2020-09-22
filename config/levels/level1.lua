return {
    name = "Level 1",

    fallSpeed = 25,

    decorationPlanesCount = 40,

    decorations = {
        { texture = "level1/decorative1" },
        { texture = "level1/decorative2" },
        { texture = "level1/decorative3" },
    },

    distanceBetweenObstacles = 30,
    obstaclesCount = 30,
    obstacles = {
        {
            planes = { { texture = "level1/obstacle1", }},
            appearFrom = 1,
            appearTo = 10,
        },
        {
            planes = { { texture = "level1/obstacle2" }},
            appearFrom = 1,
            appearTo = 10,
        },
        {
            planes = { { texture = "level1/obstacle3",}},
            appearFrom = 7,
            appearTo = 20,
        },
        {
            planes = { { texture = "level1/obstacle4",}},
            appearFrom = 15,
            appearTo = 30,
            requiredFreeSpace = 1,
        },
        {
            planes = { { texture = "level1/obstacle5",}},
            appearFrom = 20,
            appearTo = 30,
            requiredFreeSpace = 1,
        },
        {
            planes = { { texture = "level1/obstacle6",}},
            appearFrom = 20,
            appearTo = 30,
        },
        {
            planes = { { texture = "level1/obstacle7",}},
            appearFrom = 15,
            appearTo = 25,
        }
    },
}