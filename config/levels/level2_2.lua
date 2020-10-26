return {
    name = "Level 2",
    nextLevel = "level3_1",

    fallSpeed = 30,
    fogColor = {0, 0, 0},
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 3,
    playerRotationChangeSpeed = 0.001,

    sidePlanesCount = 45,
    sidePlanesRandomBrightness = true,
    sidePlanes = {
        {
            textures = {
                "levels/level2_2/wall1",
                "levels/level2_2/wall2",
                "levels/level2_2/wall3",
            }
        },
        {
            textures = {
                "levels/level2_2/wall1",
                "levels/level2_2/wall4",
                "levels/level2_2/wall4",
            }
        },
        {
            textures = {
                "levels/level2_2/wall4",
            }
        },
        {
            textures = {
                "levels/level3_1/decorative1",
                "levels/level3_1/decorative2",
                "levels/level3_1/decorative3",
            }
        },
    },

    planeTypes = {
        side_wood1 = {
            planes = {{ texture = "levels/level2_2/obstacle1", }},
        },
        side_wood1_green = {
            planes = {{ texture = "levels/level2_2/obstacle1_1", }},
        },
        middle_bridge = {
            planes = {{ texture = "levels/level2_2/obstacle8", }},
        },
        middle_bridge_green = {
            planes = {{ texture = "levels/level2_2/obstacle8_1", }},
        },
        side_wood2 = {
            planes = {{ texture = "levels/level2_2/obstacle2", }},
        },
        side_wood2_green = {
            planes = {{ texture = "levels/level2_2/obstacle2_1", }},
        },
        -- Corner hole thing
        corner_hole = {
            planes = {
                { texture = "levels/level2_2/obstacle7_1", },
                { texture = "levels/level2_2/obstacle7_2", position = {0, 0, 1} },
            },
        },
        corner_hole_green = {
            planes = {
                { texture = "levels/level2_2/obstacle7_3", },
            },
        },
        -- Long middle hole thing
        middle_hole = {
            planes = {{ texture = "levels/level2_2/obstacle3", }},
        },
        middle_hole_green = {
            planes = {{ texture = "levels/level2_2/obstacle3_1", }},
        },

        -- Single minecart
        minecart = {
            planes = {
                { texture = "levels/level2_2/obstacle4_1", position = {0, 0, -2} },
                { texture = "levels/level2_2/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "levels/level2_2/obstacle4_3", position = {0, 0, 2} },
            },
        },

        -- Conveyor belts
        belts = {
            planes = {
                { texture = "levels/level2_2/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "levels/level2_2/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "levels/level2_2/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/level2_2/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "levels/level2_2/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        },
        belt1 = {
            planes = {
                { texture = "levels/level2_2/obstacle5_1", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/level2_2/obstacle5_1", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        belt2 = {
            planes = {
                { texture = "levels/level2_2/obstacle5_2", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/level2_2/obstacle5_2", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        keep_out = {
            planes = {{ texture = "levels/level2_2/keep_out", }},
        },

        level3_middle_door = {
            planes = {
                { texture = "levels/level3_1/obstacle4_1" },
                { texture = "levels/level3_1/obstacle4_2", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 2, },
            },
        },
    },

    planes = {
        { name = "side_wood1", distance = 50, rotation = 0 },
        { name = "side_wood1", distance = 25, rotation = 180 },
        { name = "side_wood1_green", distance = 25, rotation = 90 },
        { name = "side_wood1_green", distance = 25, rotation = 270 },

        -- 3 seconds

        { name = "middle_bridge_green", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "middle_bridge", distance = 20, rotation = 90 },
        { name = "side_wood2_green", distance = 20, rotation = 0 },

        --

        { name = "side_wood1_green", distance = 20, rotation = 90 },
        { name = "corner_hole_green", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 180 },

        --

        { name = "middle_hole_green", distance = 20, rotation = 0 },
        { name = "side_wood2_green", distance = 10, rotation = 0 },
        { name = "middle_hole", distance = 10, rotation = 90 },
        { name = "middle_bridge_green", distance = 15, rotation = 180 },
        { name = "middle_hole_green", distance = 15, rotation = 90 },

        { name = "side_wood1", distance = 20, rotation = 270 },
        { name = "side_wood1_green", distance = 20, rotation = 0 },

        { name = "middle_hole", distance = 10, rotation = 90 },
        { name = "middle_bridge_green", distance = 20, rotation = 90 },
        { name = "middle_hole_green", distance = 30, rotation = 90 },

        --

        { name = "side_wood1_green", distance = 20, rotation = 90 },
        { name = "corner_hole_green", distance = 20, rotation = 0 },
        { name = "side_wood1_green", distance = 20, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 180 },

        -- 18 seconds

        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "side_wood1_green", distance = 20, rotation = 180 },
        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "side_wood2_green", distance = 20, rotation = 90 },
        { name = "side_wood1_green", distance = 20, rotation = 270 },

        -- Keep out
        { name = "keep_out", distance = 20, rotation = 90, switchSidePlanes = true },

        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "side_wood1_green", distance = 20, rotation = 180 },
        { name = "side_wood1", distance = 20, rotation = 90, switchSidePlanes = true},
        { name = "side_wood1", distance = 20, rotation = 270 },

        { name = "belts", distance = 15, rotation = 0 },
        { name = "middle_bridge", distance = 25, rotation = 90 },

        { name = "side_wood2", distance = 15, rotation = 0 },
        { name = "side_wood2", distance = 15, rotation = 180 },

        { name = "belts", distance = 15, rotation = 90 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 270 },

        -- 25 seconds

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 20, rotation = 0 },
        { name = "middle_hole", distance = 5, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 0 },

        --

        { name = "corner_hole", distance = 15, rotation = 0 },
        { name = "side_wood2", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 15, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 90 },
        { name = "corner_hole", distance = 15, rotation = 180 },
        { name = "side_wood2", distance = 15, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 0 },

        -- TODO: Add rest part

        { name = "belts", distance = 15, rotation = 90 },
        { name = "middle_hole", distance = 15, rotation = 0 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "side_wood2", distance = 20, rotation = 0 },
        { name = "belts", distance = 20, rotation = 270 },
        { name = "side_wood2", distance = 20, rotation = 90 },
        { name = "belts", distance = 20, rotation = 0 },

        { name = "middle_bridge", distance = 25, rotation = 0 },

        { name = "side_wood2", distance = 25, rotation = 0 },
        { name = "belts", distance = 20, rotation = 270 },
        { name = "side_wood2", distance = 20, rotation = 90 },
        { name = "belt1", distance = 20, rotation = 0 },

        { name = "side_wood1", distance = 20, rotation = 0 },
        { name = "side_wood1", distance = 20, rotation = 180 },

        {name = "minecart", distance = 20, rotation = 0 },

        { name = "side_wood1", distance = 20, rotation = 90 },
        { name = "belts", distance = 10, rotation = 0 },
        { name = "side_wood1", distance = 10, rotation = 270 },

        -- 45 seconds

        {name = "minecart", distance = 20, rotation = 180 },
        {name = "minecart", distance = 20, rotation = 270 },
        {name = "side_wood1", distance = 10, rotation = 0 },
        {name = "middle_bridge", distance = 10, rotation = 0 },
        {name = "minecart", distance = 20, rotation = 90 },
        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 20, rotation = 270 },

        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 20, rotation = 0 },

        {name = "middle_hole", distance = 15, rotation = 0 },
        {name = "middle_hole", distance = 5, rotation = 90 },

        {name = "minecart", distance = 15, rotation = 180 },
        {name = "corner_hole", distance = 25, rotation = 0 },
        {name = "middle_bridge", distance = 15, rotation = 0 },
        {name = "corner_hole", distance = 20, rotation = 90 },

        { name = "side_wood1", distance = 30, rotation = 0 },

        -- 55 seconds

        -- Next level transition
        { name = "level3_middle_door", distance = 30, rotation = 0, switchSidePlanes = true },
    },
}