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
        }
    },

    planeTypes = {
        wall_hands = {
            planes = {{ texture = "levels/meat/obstacles/wall_hands", }},
        },
        side_hand = {
            planes = {{ texture = "levels/meat/obstacles/side_hand", }},
        },
    },

    planes = {
        { distance = 100, name = "wall_hands", },
        { distance = 5, name = "wall_hands", rotation = 90 },
        { distance = 5, name = "wall_hands", rotation = 180 },
        { distance = 5, name = "side_hand", },
        { distance = 10, name = "side_hand", rotation = 180 },
        { distance = 100, name = "side_hand", },
        { distance = 100, name = "side_hand", },
        { distance = 100, name = "side_hand", },
        { distance = 100, name = "side_hand", },

        { distance = 5000000 },
    },
}