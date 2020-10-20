return {
    name = "Forest 2",

    fallSpeed = 27,
    fogColor = {0, 20, 31},
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 40,
    sidePlanes = {
        {
            textures = {
                "levels/level1_1/side_plane1",
                "levels/level1_1/side_plane3",
                "levels/level1_1/side_plane4",
            },
        }
    },

    planeTypes = {
        obstacle_center_hole = {
            planes = { { texture = "levels/level1_1/obstacle_plane2", }},
        },
        obstacle_side_hole = {
            planes = { { texture = "levels/level1_1/obstacle_plane3", }},
        },
        obstacle_corner_hole = {
            planes = { { texture = "levels/level1_2/obstacle_plane1", }},
        },
        obstacle_corner_hole_big = {
            planes = { { texture = "levels/level1_2/obstacle_plane2", }},
        },
        obstacle_round_thing = {
            planes = { { texture = "levels/level1_2/obstacle_plane3", }},
        },
        obstacle_diagonal_thing = {
            planes = { { texture = "levels/level1_2/obstacle_plane4", }},
        },
        obstacle_three_things = {
            planes = { { texture = "levels/level1_2/obstacle_plane5", }},
        },
        obstacle_middle_thing = {
            planes = { { texture = "levels/level1_1/obstacle_plane4", }},
        },
    },

    planes = {
        { name = "obstacle_diagonal_thing", distance = 100, rotation = 0 },
        { name = "obstacle_diagonal_thing", distance = 40, rotation = 90 },

        { name = "obstacle_center_hole", distance = 50, rotation = 0 },
        { name = "obstacle_side_hole", distance = 15, rotation = 0 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 0 },
        { name = "obstacle_corner_hole_big", distance = 40, rotation = 0 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 180 },
        { name = "obstacle_corner_hole_big", distance = 20, rotation = 0 },

        { name = "obstacle_round_thing", distance = 35, rotation = 90 },
        { name = "obstacle_round_thing", distance = 25, rotation = 180 },
        { name = "obstacle_diagonal_thing", distance = 20, rotation = 90 },
        { name = "obstacle_round_thing", distance = 20, rotation = 180 },

        { name = "obstacle_three_things", distance = 50, rotation = 0 },
        { name = "obstacle_center_hole", distance = 20, rotation = 0 },
        { name = "obstacle_three_things", distance = 15, rotation = 90 },
        { name = "obstacle_three_things", distance = 20, rotation = 180 },

        { name = "obstacle_center_hole", distance = 70, rotation = 0 },
        { name = "obstacle_corner_hole_big", distance = 20, rotation = 180 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 0 },
        { name = "obstacle_side_hole", distance = 20, rotation = 0 },
        { name = "obstacle_corner_hole_big", distance = 20, rotation = 90 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 270 },
        { name = "obstacle_side_hole", distance = 20, rotation = 270 },
        { name = "obstacle_center_hole", distance = 15, rotation = 90 },

        { name = "obstacle_diagonal_thing", distance = 50, rotation = 0 },
        { name = "obstacle_middle_thing", distance = 30, rotation = 90 },
        { name = "obstacle_diagonal_thing", distance = 30, rotation = 90 },
        { name = "obstacle_middle_thing", distance = 30, rotation = 180 },

        -- 26 sec
    },
}