return {
    name = "Level 1",

    fallSpeed = 25,
    fogColor = {0, 20, 31},
    playerRotationMode = "none",
    playerRotationSpeed = 0,

    sidePlanesCount = 40,
    sidePlanes = {
        {
            planes = {
                { texture = "level1/wall1" },
                { texture = "level1/wall2" },
                { texture = "level1/wall3" },
            },
        }
    },

    planeTypes = {
        -- Collision planes
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
        },
        two_holes = {
            planes = { { texture = "level1/obstacle5",}},
        },
        two_side_planes = {
            planes = { { texture = "level1/obstacle6",}},
        },
        half_plane = {
            planes = { { texture = "level1/obstacle7",}},
        },

        -- Decorative planes
        decorative1 = {
            planes = { { texture = "level1/decorative1", decorative = true }},
        },
        decorative2 = {
            planes = { { texture = "level1/decorative2", decorative = true }},
        },
        decorative3 = {
            planes = { { texture = "level1/decorative3", decorative = true }},
        }
    },

    planes = {
        { name = "decorative1", distance = 100, rotation = 0 },
        { name = "middle_hole", distance = 10, rotation = 0 },
        { name = "decorative1", distance = 5, rotation = 90 },
        { name = "decorative2", distance = 5, rotation = 0 },
        { name = "diagonal_thing", distance = 10, rotation = 0 },
        { name = "middle_hole", distance = 40, rotation = 90 },
        { name = "decorative3", distance = 10, rotation = 90 },
        { name = "decorative2", distance = 10, rotation = 180 },
        { name = "big_side_hole", distance = 10, rotation = 90 },
        { name = "middle_hole", distance = 40, rotation = 180 },
        { name = "big_corner_hole", distance = 20, rotation = 180 },
        { name = "decorative1", distance = 10, rotation = 180 },
        { name = "big_corner_hole", distance = 10, rotation = 90 },
        { name = "decorative1", distance = 10, rotation = 270 },
        { name = "big_corner_hole", distance = 10, rotation = 0 },
        { name = "big_side_hole", distance = 30, rotation = 180 },
        { name = "middle_hole", distance = 50, rotation = 270 },
        { name = "decorative3", distance = 5, rotation = 270 },
        { name = "diagonal_thing", distance = 10, rotation = 90 },
        { name = "decorative1", distance = 15, rotation = 0 },
        { name = "diagonal_thing", distance = 10, rotation = 180 },
        { name = "big_corner_hole", distance = 25, rotation = 270 },
        { name = "middle_hole", distance = 40, rotation = 0 },
        { name = "two_side_planes", distance = 30, rotation = 0 },
        { name = "two_holes", distance = 25, rotation = 0 },
        { name = "half_plane", distance = 35, rotation = 0 },
        { name = "decorative3", distance = 15, rotation = 270 },
        { name = "big_side_hole", distance = 10, rotation = 270 },
        { name = "two_holes", distance = 35, rotation = 90 },
        { name = "decorative1", distance = 20, rotation = 0 },
        { name = "diagonal_thing", distance = 10, rotation = 270 },
        { name = "two_holes", distance = 35, rotation = 180 },
        { name = "decorative2", distance = 10, rotation = 0 },
        { name = "decorative3", distance = 20, rotation = 0 },
        { name = "two_holes", distance = 5, rotation = 270 },

        -- 30 seconds
    },
}