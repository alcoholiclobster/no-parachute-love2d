return {
    name = "Level 1",

    fallSpeed = 30,

    decorationPlanesCount = 50,

    decorations = {
        { texture = "level2/decorative1" },
    },

    distanceBetweenObstacles = 30,
    obstaclesCount = 50,
    obstacles = {
        {
            planes = {{ texture = "level2/obstacle1", }},
            appearFrom = 1,
            appearTo = 50,
        },
        {
            planes = {{ texture = "level2/obstacle2", }},
            appearFrom = 1,
            appearTo = 50,
        },
        {
            planes = {{ texture = "level2/obstacle3", }},
            appearFrom = 1,
            appearTo = 50,
        },
        {
            appearFrom = 1,
            appearTo = 50,

            planes = {
                { texture = "level2/obstacle4_1", position = {0, 0, -2} },
                { texture = "level2/obstacle4_2", velocity = {5, 0, 0}, position = {-15, 0, 0} },
                { texture = "level2/obstacle4_3", position = {0, 0, 2} },
            },
        }
    },
}