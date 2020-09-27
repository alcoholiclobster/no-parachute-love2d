return {
    name = "Level 1",

    fallSpeed = 32,
    fogColor = {15, 0, 0},
    playerRotationMode = "none",
    playerRotationSpeed = 0,

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
            planes = {{ texture = "level3/decorative1", }},
            appearFrom = 1,
            appearTo = 999,
        },
    }
}