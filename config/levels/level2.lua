return {
    name = "Level 2",

    fallSpeed = 30,
    fogColor = {27, 54, 61},
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.7,
    playerRotationChangeSpeed = 0.3,
    playerRotationSpeedDependsOnProgress = true,

    decorationPlanesCount = 50,

    decorations = {
        { texture = "level2/decorative1" },
    },

    distanceBetweenObstacles = 30,
    obstaclesCount = 80,
    obstacles = {
        {
            planes = {{ texture = "level2/obstacle1", }},
            appearFrom = 1,
            appearTo = 80,

            isWide = true,
        },
        {
            planes = {{ texture = "level2/obstacle8", }},
            appearFrom = 20,
            appearTo = 80,
        },
        {
            planes = {{ texture = "level2/obstacle2", }},
            appearFrom = 1,
            appearTo = 30,

            isWide = true,
        },
        -- Corner hole thing
        {
            planes = {
                { texture = "level2/obstacle7_1", },
                { texture = "level2/obstacle7_2", position = {0, 0, 1} },
            },

            requiredFreeSpace = 0.2,

            appearFrom = 6,
            appearTo = 70,
        },
        -- Long middle hole thing
        {
            planes = {{ texture = "level2/obstacle3", }},
            appearFrom = 3,
            appearTo = 15,
        },

        -- Single minecart
        {
            appearFrom = 40,
            appearTo = 60,

            planes = {
                { texture = "level2/obstacle4_1", position = {0, 0, -2} },
                { texture = "level2/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "level2/obstacle4_3", position = {0, 0, 2} },
            },
        },
        -- Two minecarts
        {
            appearFrom = 50,
            appearTo = 80,

            requiredFreeSpace = 0.5,

            planes = {
                { texture = "level2/obstacle4_1", position = {0, 0, -2} },
                { texture = "level2/obstacle4_2", position = {-20, 0, 0}, velocity = {7, 0, 0} },

                { texture = "level2/obstacle2", position = {0, 0, -5} },

                { texture = "level2/obstacle4_1", position = {0, 0, -10}, rotation = 90 },
                { texture = "level2/obstacle4_2",  position = {-20, 0, -8}, velocity = {8, 0, 0}, rotation = 90 },
            },
        },

        -- Conveyor belts
        {
            appearFrom = 25,
            appearTo = 80,

            planes = {
                { texture = "level2/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "level2/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "level2/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "level2/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "level2/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        }
    },
}