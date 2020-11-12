return {
    name = "Stone cave",
    nextLevel = "level3_1",

    fallSpeed = 27,
    fogColor = {25, 10, 10},
    fogDistance = 40,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 180,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                -- "levels/level2_1/side_plane1",
                "levels/level2_1/side_plane2",
                "levels/level2_1/side_plane3",
            },
        },
        {
            textures = {
                "levels/level2_1/side_plane4",
            },
        },
        {
            textures = {
                "levels/level2_1/side_plane1",
                "levels/level2_1/side_plane2",
                "levels/level2_1/side_plane3",
            },
        },
    },

    planeTypes = {
        obstacle_half_hole_sharp = {
            planes = { { texture = "levels/level2_1/obstacle_plane1", }},
        },
        obstacle_big_hole_sharp = {
            planes = { { texture = "levels/level2_1/obstacle_plane2", }},
        },
        obstacle_side_hole_sharp = {
            planes = { { texture = "levels/level2_1/obstacle_plane3", }},
        },
        obstacle_two_corner_holes = {
            planes = { { texture = "levels/level2_1/obstacle_plane4", }},
        },
        obstacle_triangle_thing = {
            planes = { { texture = "levels/level2_1/obstacle_plane7", }},
        },
        obstacle_diagonal_thing = {
            planes = { { texture = "levels/level2_1/obstacle_plane5", }},
        },
        obstacle_center_hole = {
            planes = { { texture = "levels/level2_1/obstacle_plane6", }},
        },
        obstacle_long_thing = {
            planes = { { texture = "levels/level2_1/obstacle_plane8", }},
        },
    },

    planes = {
        { name = "obstacle_long_thing", distance = 80, rotation = 0, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 20, rotation = 90, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 20, rotation = 180, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 20, rotation = 270, position = {0, -4, 0} },

        { name = "obstacle_half_hole_sharp", distance = 10, rotation = 0 },
        { name = "obstacle_half_hole_sharp", distance = 20, rotation = 180 },
        { name = "obstacle_half_hole_sharp", distance = 20, rotation = 90 },
        { name = "obstacle_big_hole_sharp", distance = 30, rotation = 90 },
        { name = "obstacle_big_hole_sharp", distance = 10, rotation = 270 },
        { name = "obstacle_side_hole_sharp", distance = 8, rotation = 90 },
        { name = "obstacle_half_hole_sharp", distance = 45, rotation = 180 },
        { name = "obstacle_half_hole_sharp", distance = 20, rotation = 0 },
        { name = "obstacle_side_hole_sharp", distance = 10, rotation = 90 },
        { name = "obstacle_side_hole_sharp", distance = 10, rotation = 90 },
        { name = "obstacle_big_hole_sharp", distance = 10, rotation = 90 },
        { name = "obstacle_big_hole_sharp", distance = 15, rotation = 270 },

        { name = "obstacle_triangle_thing", distance = 30, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 20, rotation = 180, },

        { name = "obstacle_long_thing", distance = 10, rotation = 0, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 10, rotation = 90, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 10, rotation = 0, position = {0, 0, 0} },
        { name = "obstacle_long_thing", distance = 15, rotation = 180, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 35, rotation = 270, position = {0, -4, 0} },

        { name = "obstacle_two_corner_holes", distance = 10, rotation = 0 },
        { name = "obstacle_two_corner_holes", distance = 22, rotation = 90 },
        { name = "obstacle_two_corner_holes", distance = 22, rotation = 180 },
        { name = "obstacle_half_hole_sharp", distance = 60, rotation = 270 },
        { name = "obstacle_half_hole_sharp", distance = 10, rotation = 0 },
        { name = "obstacle_half_hole_sharp", distance = 10, rotation = 90 },
        { name = "obstacle_side_hole_sharp", distance = 10, rotation = 90 },
        { name = "obstacle_two_corner_holes", distance = 15, rotation = 180 },
        { name = "obstacle_two_corner_holes", distance = 15, rotation = 0 },

        { name = "obstacle_long_thing", distance = 10, rotation = 0, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 10, rotation = 90, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 0, position = {0, 0, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 180, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 10, rotation = 270, position = {0, -4, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 90, position = {0, 0, 0} },

        { name = "obstacle_center_hole", distance = 60, rotation = 0, switchSidePlanes = true, },
        { name = "obstacle_triangle_thing", distance = 20, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 20, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 270, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 0 },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 90 },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 180, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 270, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 0, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 90, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 270, },
        { name = "obstacle_center_hole", distance = 20, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 270, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 90, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 0, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 270, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 180, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 90, },
        { name = "obstacle_diagonal_thing", distance = 10, rotation = 0, switchSidePlanes = true,  },
        { name = "obstacle_two_corner_holes", distance = 15, rotation = 0 },

        { name = "obstacle_half_hole_sharp", distance = 30, rotation = 0 },
        { name = "obstacle_half_hole_sharp", distance = 20, rotation = 180 },
        { name = "obstacle_half_hole_sharp", distance = 20, rotation = 90 },

        { name = "obstacle_long_thing", distance = 30, rotation = 0, position = {0, -3, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 180, position = {0, -3, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 0, position = {0, 1, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 270, position = {0, -2, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 90, position = {0, -3, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 180, position = {0, -2, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 90, position = {0, 2, 0} },
        { name = "obstacle_long_thing", distance = 5, rotation = 180, position = {0, -1, 0} },
        { name = "obstacle_two_corner_holes", distance = 10, rotation = 0 },
    },
}