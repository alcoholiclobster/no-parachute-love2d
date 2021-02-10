return {
    name = "Flesh Hell 1",
    nextLevel = nil,

    fallSpeed = 47,
    fogColor = {25, 10, 0},
    fogDistance = 70,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 60,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh",
            },
        },
    },

    planeTypes = {
        wall_hands = {
            planes = {{ texture = "levels/meat/obstacles/wall_hands", }},
        },
        big_skull = {
            planes = {
                { texture = "levels/meat/obstacles/big_skull", },
                { texture = "levels/meat/obstacles/big_skull_eyes", position = {0, 0, -4}, decorative = true  }
            },
        },
        side_hand = {
            planes = {{ texture = "levels/meat/obstacles/side_hand", }},
        },
        moving_hands = {
            planes = {
                { texture = "levels/meat/obstacles/big_hand", rotationSpeed = 0.4, position = {-5, 1, 0}},
                { texture = "levels/meat/obstacles/big_hand_right", rotationSpeed = -0.6, position = {5, 2, 0}},
            },
        },
        huge_bone = {
            planes = {
                { texture = "levels/meat/obstacles/huge_bone_test"}
            }
        },

        --
        stone_hole = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle1", }},
        },
        stone_small_hole = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle2", }},
        },
        stone_small_hole2 = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle4", }},
        },
        stone_side_long_hole = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle3", }},
        },
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },
        old_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1, },
            },
        },
    },

    planes = {
        -- { distance = 100, name = "stone_hole", rotation = 0 },
        -- { distance = 20, name = "stone_small_hole", rotation = 0 },
        -- { distance = 27, name = "stone_side_long_hole", rotation = 180 },
        -- { distance = 25, name = "stone_small_hole", rotation = 180 },
        -- { distance = 22, name = "stone_small_hole2", rotation = 180 },
        -- { distance = 22, name = "stone_hole", rotation = 270 },
        -- { distance = 12, name = "stone_breakable_wall", rotation = 0 },
        { distance = 30, name = "wall_hands", rotation = 90 },
        { distance = 5, name = "wall_hands", rotation = 180 },
        { distance = 6, name = "wall_hands", rotation = 90 },
        { distance = 3, name = "wall_hands", rotation = 0 },
        { distance = 8, name = "wall_hands", rotation = 270 },
        { distance = 4, name = "wall_hands", rotation = 180 },
        { distance = 2, name = "wall_hands", rotation = 90 },
        { distance = 10, name = "wall_hands", rotation = 0 },
        { distance = 2, name = "wall_hands", rotation = 90 },
        { distance = 5, name = "wall_hands", rotation = 180 },
        { distance = 6, name = "wall_hands", rotation = 90 },
        { distance = 3, name = "wall_hands", rotation = 0 },
        { distance = 8, name = "wall_hands", rotation = 270 },
        { distance = 4, name = "wall_hands", rotation = 180 },
        { distance = 2, name = "wall_hands", rotation = 90 },
        { distance = 10, name = "wall_hands", rotation = 0 },
        { distance = 6, name = "wall_hands", rotation = 90 },
        { distance = 5, name = "wall_hands", rotation = 180 },
        { distance = 6, name = "wall_hands", rotation = 90 },
        { distance = 3, name = "wall_hands", rotation = 0 },
        { distance = 8, name = "wall_hands", rotation = 270 },
        { distance = 8, name = "old_door", rotation = 0 },
        { distance = 10, name = "stone_breakable_wall", rotation = 0, switchSidePlanes = true, },
        { distance = 40, tunnelShape = { direction = {10, 0}, rotationSpeed = 0.2 },},
        { distance = 100, tunnelShape = { direction = {15, 0}, rotationSpeed = 0.7 },},
        { distance = 10000 },
        -- { distance = 50, name = "side_hand", },
        -- { distance = 10, name = "side_hand", rotation = 180, },
        -- { distance = 50, name = "huge_bone", rotation = 0 },
        -- { distance = 50, name = "huge_bone", rotation = 90 },
        -- { distance = 50, name = "huge_bone", rotation = 180 },
        -- { distance = 50, name = "huge_bone", rotation = 270 },
        -- { distance = 50, name = "huge_bone", rotation = 0 },
    },
}