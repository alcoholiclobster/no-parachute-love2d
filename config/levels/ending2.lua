return {
    name = "Deep Way Up 2",
    nextLevel = nil,
    music = "ending_theme",

    highscores = {
        4000,
        5000,
    },

    fallSpeed = 57,
    fogColor = {0, 0, 0},
    fogDistance = 90,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = -0.3,
    playerRotationChangeSpeed = 0.012,

    finishCutscene = "EndingCutscene",

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/stone_cave/side_plane1",
                "levels/stone_cave/side_plane2",
                "levels/stone_cave/side_plane3",
            },
        },
        {
            textures = {
                "levels/stone_cave/side_plane4",
            },
        },
        -- {
        --     textures = {
        --         "levels/old_mine/wall4",
        --     }
        -- },
        {
            textures = {
                "levels/old_mine/wall1",
                "levels/old_mine/wall2",
                "levels/old_mine/wall3",
            }
        },
        {
            textures = {
                "levels/tutorial/side_plane1",
                "levels/tutorial/side_plane3",
                "levels/tutorial/side_plane4",
            },
        },
        {
            textures = {
                "levels/tutorial/side_plane1",
                "levels/tutorial/side_plane2",
                "levels/tutorial/side_plane3",
                "levels/tutorial/side_plane4",
            },
        },
        {
            textures = {
                "levels/sky/side_plane2",
            },
        },
    },

    planeTypes = {
        stone_obstacle_side_hole_sharp = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane3", position = {0, 0, -6}},
                { texture = "levels/stone_cave/obstacle_plane3_2", position = {0, 0, -4}},
                { texture = "levels/stone_cave/obstacle_plane3_3", position = {0, 0, -2}},
                { texture = "levels/stone_cave/obstacle_plane3_4", position = {0, 0, 0}},
            },
        },
        stone_obstacle_two_corner_holes = {
            planes = {
                { texture = "levels/stone_cave/obstacle_plane4", position = {0, 0, -6} },
                { texture = "levels/stone_cave/obstacle_plane4_2", position = {0, 0, -4} },
                { texture = "levels/stone_cave/obstacle_plane4_3", position = {0, 0, -2} },
                { texture = "levels/stone_cave/obstacle_plane4_4", position = {0, 0, -0} },
            },
        },
        stone_breakable1 = {
            planes = { { texture = "levels/stone_cave/obstacle_plane9", breakable = true }},
        },
        stone_obstacle_triangle_thing = {
            planes = { { texture = "levels/stone_cave/obstacle_plane7", }},
        },
        stone_obstacle_diagonal_thing = {
            planes = { { texture = "levels/stone_cave/obstacle_plane5", }},
        },
        stone_obstacle_center_hole = {
            planes = { { texture = "levels/stone_cave/obstacle_plane6", }},
        },

        mine_breakable1 = {
            planes = {{ texture = "levels/old_mine/obstacle9", breakable = true }},
        },
        mine_side_wood2_green = {
            planes = {{ texture = "levels/old_mine/obstacle2_1", }},
        },
        mine_middle_bridge = {
            planes = {{ texture = "levels/old_mine/obstacle8", }},
        },
        mine_side_wood1 = {
            planes = {{ texture = "levels/old_mine/obstacle1", }},
        },
        mine_side_wood1_green = {
            planes = {{ texture = "levels/old_mine/obstacle1_1", }},
        },
        mine_middle_bridge_green = {
            planes = {{ texture = "levels/old_mine/obstacle8_1", }},
        },
        mine_corner_hole = {
            planes = {
                { texture = "levels/old_mine/obstacle7_1", },
                { texture = "levels/old_mine/obstacle7_2", position = {0, 0, 1} },
            },
        },
        mine_corner_hole_green = {
            planes = {
                { texture = "levels/old_mine/obstacle7_3", },
            },
        },
    },

    planes = {
        { distance = 80, name = "stone_obstacle_side_hole_sharp" },
        { distance = 40, name = "stone_obstacle_side_hole_sharp", rotation = 180 },
        { distance = 40, name = "stone_obstacle_two_corner_holes", rotation = 180 },
        { distance = 40, name = "stone_obstacle_two_corner_holes", rotation = 90 },
        { distance = 30, name = "stone_breakable1", switchSidePlanes = true },

        { name = "stone_obstacle_center_hole", distance = 30, rotation = 0, tunnelShape = { direction = {2, 0}, rotationSpeed = 0.75 } },
        { name = "stone_obstacle_triangle_thing", distance = 30, rotation = 0, },
        { name = "stone_obstacle_triangle_thing", distance = 30, rotation = 180, },
        { name = "stone_obstacle_triangle_thing", distance = 40, rotation = 270, },
        { name = "stone_obstacle_triangle_thing", distance = 25, rotation = 0 },
        { name = "stone_obstacle_diagonal_thing", distance = 25, rotation = 90 },
        { name = "stone_obstacle_diagonal_thing", distance = 25, rotation = 180, },
        { name = "stone_obstacle_diagonal_thing", distance = 25, rotation = 270, },
        { name = "stone_obstacle_diagonal_thing", distance = 25, rotation = 0, },
        { name = "stone_obstacle_diagonal_thing", distance = 25, rotation = 90, },
        { name = "stone_obstacle_triangle_thing", distance = 25, rotation = 180, },
        { name = "stone_obstacle_triangle_thing", distance = 25, rotation = 270, },

        { distance = 30, name = "stone_breakable1", switchSidePlanes = true,  tunnelShape = { direction = {0, 0}, rotationSpeed = 0 } },

        { name = "mine_side_wood1_green", distance = 50, rotation = 90 },
        { name = "mine_corner_hole_green", distance = 20, rotation = 0 },
        { name = "mine_side_wood1", distance = 20, rotation = 180 },
        { name = "mine_corner_hole", distance = 15, rotation = 180 },

        { name = "mine_middle_bridge_green", distance = 50, rotation = 0 },
        { name = "mine_side_wood1", distance = 20, rotation = 0 },
        { name = "mine_middle_bridge", distance = 20, rotation = 90 },
        { name = "mine_side_wood2_green", distance = 20, rotation = 0 },

        { distance = 50, name = "mine_breakable1", switchSidePlanes = true},
        { distance = 97, fogColor = {124, 213, 255}, emit = { name = "stopMusicEvent" } },
        { distance = 150, switchSidePlanes = true},
        { distance = 100, switchSidePlanes = true, emit = { name = "playMusicEvent", args = {"final_theme"} } },
    }
}