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
        long_meat_middle_thing = {
            planes = {{ texture = "levels/meat/obstacles/long_meat_middle_thing", }},
        },
    },

    planes = {
        { distance = 100, name = "long_meat_middle_thing", },
        { distance = 100, name = "long_meat_middle_thing", },
        { distance = 100, name = "long_meat_middle_thing", },
        { distance = 100, name = "long_meat_middle_thing", },
        { distance = 100, name = "long_meat_middle_thing", },
        { distance = 100, name = "long_meat_middle_thing", },

        { distance = 5000000 },
    },
}