return {
    name = "Level 1",

    fallSpeed = 25,
    fogColor = {0, 41, 63},
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    decorationPlanesCount = 40,

    decorations = {
        { texture = "level1/decorative1" },
        { texture = "level1/decorative2" },
        { texture = "level1/decorative3" },
    },

    distanceBetweenObstacles = 30,

    obstacleTypes = {
        middle_hole = {
            planes = { { texture = "level1/obstacle1", }},
        },
        diagonal_thing = {
            planes = { { texture = "level1/obstacle2" }},
        },
        big_corner_hole = {
            planes = { { texture = "level1/obstacle3",}},
        },
        big_side_hole = {
            planes = { { texture = "level1/obstacle4",}},
            freeSpaceBefore = 30,
        },
        two_holes = {
            planes = { { texture = "level1/obstacle5",}},
            freeSpaceBefore = 30,
        },
        two_side_planes = {
            planes = { { texture = "level1/obstacle6",}},
        },
        half_plane = {
            planes = { { texture = "level1/obstacle7",}},
        }
    },

    obstacles = {
        { name = "middle_hole", distance = 100, rotation = 0 },
        { name = "middle_hole", distance = 30, rotation = 90 },
        { name = "middle_hole", distance = 30, rotation = 90 },
        { name = "middle_hole", distance = 30, rotation = 180 },
    }
}