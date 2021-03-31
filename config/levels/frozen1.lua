return {
    name = "Frozen",
    nextLevel = "stone_cave2",
    music = "stone_cave",

    fallSpeed = 34,
    fogColor = {5, 50, 100},
    fogDistance = 80,
    playerRotationMode = "constant",
    playerRotationSpeed = 12,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 50,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 1,
    sidePlanes = {
        {
            textures = {
                "levels/frozen/side_planes/1",
                "levels/frozen/side_planes/2",
                "levels/frozen/side_planes/3",
            },
        },
    },

    planeTypes = {
        obstacle1 = {
            planes = {
                { texture = "levels/frozen/obstacles/1"},
            },
        },
        obstacle2 = {
            planes = {
                { texture = "levels/frozen/obstacles/2"},
            },
        },
        obstacle3 = {
            planes = {
                { texture = "levels/frozen/obstacles/3"},
            },
        },
        obstacle4 = {
            planes = {
                { texture = "levels/frozen/obstacles/4", breakable = true},
            },
        },
        obstacle5 = {
            planes = {
                { texture = "levels/frozen/obstacles/5"},
            },
        },
    },

    planes = {
        { distance = 100, tunnelShape = { rotationSpeed = 0.25 } },
        { distance = 10, name = "obstacle3" },
        { distance = 15, name = "obstacle4" },
        { distance = 30, name = "obstacle2" },
        { distance = 30, name = "obstacle1" },
        { distance = 20, name = "obstacle5", rotation = 90 },
        { distance = 20, name = "obstacle3" },
        { distance = 1000 },
    }
}