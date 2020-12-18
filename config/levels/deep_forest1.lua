return {
    name = "Deep Forest 1",
    nextLevel = "deep_forest2",

    fallSpeed = 30,
    fogColor = {0, 5, 10},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 150,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.65,
    sidePlanes = {
        {
            textures = {
                "levels/tutorial/side_plane1",
                "levels/tutorial/side_plane3",
                "levels/tutorial/side_plane4",
            },
        },

    },

    planeTypes = {
        obstacle_center_hole = {
            planes = {
                { texture = "levels/deep_forest/obstacle_plane7", },
                { texture = "levels/deep_forest/decorative_plane1", decorative = true, position = {0, 0, 3} },
            },
        },
        obstacle_side_hole = {
            planes = { { texture = "levels/tutorial/obstacle_plane3", }},
        },
        obstacle_corner_hole = {
            planes = {
                { texture = "levels/deep_forest/obstacle_plane1", },
                { texture = "levels/deep_forest/decorative_plane2", decorative = true, position = {0, 0, 4}, rotation = 180 },
                { texture = "levels/deep_forest/decorative_plane2", decorative = true, position = {0, 0, 8}, rotation = 270 },
            },
        },
        obstacle_corner_hole_big = {
            planes = { { texture = "levels/deep_forest/obstacle_plane2", }},
        },
        obstacle_round_thing = {
            planes = { { texture = "levels/deep_forest/obstacle_plane3", }},
        },
        obstacle_diagonal_thing = {
            planes = { { texture = "levels/deep_forest/obstacle_plane4", }},
        },
        obstacle_three_things = {
            planes = {
                { texture = "levels/deep_forest/obstacle_plane5", },
                { texture = "levels/deep_forest/obstacle_plane5_2", position = {0, 0, -3} },
                { texture = "levels/deep_forest/obstacle_plane5_3", position = {0, 0, -3}, decorative = true },
            },
        },
        obstacle_middle_thing = {
            planes = { { texture = "levels/tutorial/obstacle_plane4", }},
        },
        obstacle_half_plane = {
            planes = { { texture = "levels/deep_forest/obstacle_plane6", }},
        },
        obstacle_half_plane2 = {
            planes = { { texture = "levels/deep_forest/obstacle_plane6_2", }},
        },
        obstacle_broken_pipe = {
            planes = { { texture = "levels/tutorial/obstacle_plane6_2", }},
        },
        decorative1 = {
            planes = { { texture = "levels/deep_forest/decorative_plane1", decorative = true }},
        },
        decorative2 = {
            planes = { { texture = "levels/deep_forest/decorative_plane2", decorative = true }},
        },
        breakable1 = {
            planes = { { texture = "levels/tutorial/obstacle_plane8", breakable = true }},
        },
    },

    planes = {
        { name = "obstacle_diagonal_thing", distance = 100, rotation = 0 },
        { name = "obstacle_diagonal_thing", distance = 40, rotation = 90 },
        { name = "obstacle_broken_pipe", distance = 30, rotation = 0 },

        { name = "obstacle_center_hole", distance = 20, rotation = 0 },
        { name = "obstacle_side_hole", distance = 15, rotation = 0 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 0 },
        { name = "obstacle_corner_hole_big", distance = 40, rotation = 0 },
        { name = "obstacle_corner_hole", distance = 20, rotation = 180 },
        { name = "obstacle_corner_hole_big", distance = 20, rotation = 0 },

        { name = "obstacle_round_thing", distance = 35, rotation = 90 },
        { name = "obstacle_round_thing", distance = 25, rotation = 180 },
        { name = "obstacle_diagonal_thing", distance = 20, rotation = 90 },
        { name = "obstacle_round_thing", distance = 20, rotation = 180 },

        { name = "decorative1", distance = 55, rotation = 0, },
        { name = "breakable1", distance = 5, rotation = 0, },

        { name = "obstacle_three_things", distance = 60, rotation = 0 },
        { name = "decorative2", distance = 10, rotation = 0 },
        { name = "obstacle_center_hole", distance = 10, rotation = 0 },
        { name = "obstacle_three_things", distance = 15, rotation = 90 },
        { name = "obstacle_three_things", distance = 20, rotation = 180 },
    },
}