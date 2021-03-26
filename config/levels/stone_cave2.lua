return {
    name = "Stone cave 2",
    nextLevel = "vents1",
    music = "stone_cave",

    highscores = {
        5300,
        7500,
    },

    fallSpeed = 35,
    fogColor = {25, 10, 10},
    fogDistance = 55,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.25,
    playerRotationChangeSpeed = 0.015,

    sidePlanesCount = 65,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/stone_cave/side_plane2",
                "levels/stone_cave/side_plane3",
            },
        },
        {
            textures = {
                "levels/stone_cave/side_plane4",
            },
        },
        {
            textures = {
                "levels/stone_cave/side_plane1",
                "levels/stone_cave/side_plane2",
                "levels/stone_cave/side_plane3",
            },
        },
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
        },
    },

    planeTypes = {
        obstacle_half_hole_sharp = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane1", position = {0, 0, -4}},
                { texture = "levels/stone_cave/obstacle_plane1_2", position = {0, 0, -2}},
                { texture = "levels/stone_cave/obstacle_plane1_3", },
            },
        },
        obstacle_big_hole_sharp = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane2",  position = {0, 0, -3} },
                { texture = "levels/stone_cave/obstacle_plane2_2", position = {0, 0, 0} }
            },
        },
        obstacle_side_hole_sharp = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane3", position = {0, 0, -6}},
                { texture = "levels/stone_cave/obstacle_plane3_2", position = {0, 0, -4}},
                { texture = "levels/stone_cave/obstacle_plane3_3", position = {0, 0, -2}},
                { texture = "levels/stone_cave/obstacle_plane3_4", position = {0, 0, 0}},
            },
        },
        obstacle_two_corner_holes = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane4", position = {0, 0, -6} },
                { texture = "levels/stone_cave/obstacle_plane4_2", position = {0, 0, -4} },
                { texture = "levels/stone_cave/obstacle_plane4_3", position = {0, 0, -2} },
                { texture = "levels/stone_cave/obstacle_plane4_4", position = {0, 0, -0} },
            },
        },
        obstacle_triangle_thing = {
            planes = { { texture = "levels/stone_cave/obstacle_plane7", }},
        },
        obstacle_diagonal_thing = {
            planes = { { texture = "levels/stone_cave/obstacle_plane5", }},
        },
        obstacle_center_hole = {
            planes = { { texture = "levels/stone_cave/obstacle_plane6", }},
        },
        obstacle_long_thing = {
            planes = { { texture = "levels/stone_cave/obstacle_plane8", }},
        },
        breakable1 = {
            planes = { { texture = "levels/stone_cave/obstacle_plane9", breakable = true }},
        },
        vents_middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1.5, },
            },
        },
    },

    planes = {
        { name = "obstacle_big_hole_sharp", distance = 100, rotation = 0},
        { name = "obstacle_half_hole_sharp", distance = 7, rotation = 0},
        { name = "obstacle_big_hole_sharp", distance = 10, rotation = 90},
        { name = "obstacle_half_hole_sharp", distance = 7, rotation = 180},
        { name = "obstacle_side_hole_sharp", distance = 20, rotation = 180},
        { name = "obstacle_long_thing", distance = 20, rotation = 0},
        { name = "obstacle_side_hole_sharp", distance = 20, rotation = 0},

        { name = "obstacle_center_hole", distance = 75, rotation = 0, switchSidePlanes = true, },
        { name = "breakable1", distance = 15, rotation = 0 },
        { name = "obstacle_center_hole", distance = 30, rotation = 0, tunnelShape = { direction = {2, 0}, rotationSpeed = 0.75 } },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 40, rotation = 270, },
        { name = "obstacle_triangle_thing", distance = 15, rotation = 0 },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 90 },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 180, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 270, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 0, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 90, },
        { name = "obstacle_triangle_thing", distance = 15, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 15, rotation = 270, },
        { name = "obstacle_center_hole", distance = 20, rotation = 0, tunnelShape = { direction = {-4, 0}, rotationSpeed = 0.25 } },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 0, },
        { name = "obstacle_triangle_thing", distance = 10, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 30, rotation = 270},
        { name = "obstacle_triangle_thing", distance = 15, rotation = 180, },
        { name = "obstacle_triangle_thing", distance = 15, rotation = 90, },
        { name = "obstacle_triangle_thing", distance = 15, rotation = 0, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 270, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 180, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 90, },
        { name = "obstacle_diagonal_thing", distance = 15, rotation = 0, switchSidePlanes = true, tunnelShape = { direction = {0, 0}, rotationSpeed = 0.0 }   },
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

        -- Next level transition
        { name = "vents_middle_door", distance = 70, rotation = 90, switchSidePlanes = true },
    },
}