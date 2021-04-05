return {
    name = "Old Mine 2",
    nextLevel = "old_mine3",
    music = "mine_theme1",

    highscores = {
        4900,
        7800,
    },

    fallSpeed = 35,
    fogColor = {0, 0, 0},
    fogDistance = 60,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 3,
    playerRotationChangeSpeed = 0.001,

    sidePlanesCount = 45,
    sidePlanesRandomBrightness = true,
    sidePlanes = {
        {
            textures = {
                "levels/old_mine/wall4",
            }
        },
    },

    planeTypes = {
        side_wood1 = {
            planes = {{ texture = "levels/old_mine/obstacle1", }},
        },
        side_wood1_green = {
            planes = {{ texture = "levels/old_mine/obstacle1_1", }},
        },
        middle_bridge = {
            planes = {{ texture = "levels/old_mine/obstacle8", }},
        },
        middle_bridge_green = {
            planes = {{ texture = "levels/old_mine/obstacle8_1", }},
        },
        side_wood2 = {
            planes = {{ texture = "levels/old_mine/obstacle2", }},
        },
        side_wood2_green = {
            planes = {{ texture = "levels/old_mine/obstacle2_1", }},
        },
        -- Corner hole thing
        corner_hole = {
            planes = {
                { texture = "levels/old_mine/obstacle7_1", },
                { texture = "levels/old_mine/obstacle7_2", position = {0, 0, 1} },
            },
        },
        corner_hole_green = {
            planes = {
                { texture = "levels/old_mine/obstacle7_3", },
            },
        },
        -- Long middle hole thing
        middle_hole = {
            planes = {{ texture = "levels/old_mine/obstacle3", }},
        },
        middle_hole_green = {
            planes = {{ texture = "levels/old_mine/obstacle3_1", }},
        },

        -- Single minecart
        minecart = {
            planes = {
                { texture = "levels/old_mine/obstacle4_1", position = {0, 0, -2} },
                { texture = "levels/old_mine/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "levels/old_mine/obstacle4_3", position = {0, 0, 2} },
            },
        },

        -- Conveyor belts
        belts = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "levels/old_mine/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "levels/old_mine/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        },
        belt1 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        belt2 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_2", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        keep_out = {
            planes = {{ texture = "levels/old_mine/keep_out", }},
        },

        breakable1 = {
            planes = {{ texture = "levels/old_mine/obstacle9", breakable = true }},
        },
    },

    planes = {
        { name = "middle_hole", distance = 100, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 30, rotation = 270 },

        { name = "middle_hole", distance = 30, rotation = 270 },
        { name = "middle_bridge", distance = 20, rotation = 0 },
        { name = "middle_hole", distance = 5, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 0 },

        --

        { name = "belts", distance = 65, rotation = 90 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "belts", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 180 },
        { name = "middle_bridge", distance = 20, rotation = 270 },

        --

        { name = "corner_hole", distance = 15, rotation = 0 },
        { name = "side_wood2", distance = 15, rotation = 0 },
        { name = "corner_hole", distance = 15, rotation = 90 },
        { name = "side_wood1", distance = 15, rotation = 90 },
        { name = "corner_hole", distance = 15, rotation = 180 },
        { name = "side_wood2", distance = 15, rotation = 180 },
        { name = "corner_hole", distance = 15, rotation = 0 },

        { name = "belts", distance = 55, rotation = 90 },
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
    },
}