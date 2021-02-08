return {
    name = "Flesh Hell 1",
    nextLevel = nil,

    fallSpeed = 45,
    fogColor = {25, 10, 0},
    fogDistance = 55,
    -- playerRotationMode = "sinusoid",
    -- playerRotationSpeed = 0.2,
    -- playerRotationChangeSpeed = 0.02,

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
                "levels/meat/side_planes/cave3",
                "levels/meat/side_planes/cave4",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/empty"
            },
        }
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
        }
    },

    planes = {
        -- { distance = 100, name = "moving_hands", },
        { distance = 120, name = "wall_hands", rotation = 90 },
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
        { distance = 5, name = "wall_hands", rotation = 180, switchSidePlanes = true },
        { distance = 6, name = "wall_hands", rotation = 90 },
        { distance = 3, name = "wall_hands", rotation = 0 },
        { distance = 8, name = "wall_hands", rotation = 270 },
        { distance = 8, name = "big_skull", rotation = 0 },
        { distance = 50, name = "side_hand", },
        { distance = 10, name = "side_hand", rotation = 180, switchSidePlanes = true},
        { distance = 50, name = "huge_bone", rotation = 0 },
        { distance = 50, name = "huge_bone", rotation = 90 },
        { distance = 50, name = "huge_bone", rotation = 180 },
        { distance = 50, name = "huge_bone", rotation = 270 },
        { distance = 50, name = "huge_bone", rotation = 0 },

        { distance = 5000000 },
    },
}