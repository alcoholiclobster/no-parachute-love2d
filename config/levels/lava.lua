return {
    name = "Lava",
    nextLevel = nil,

    fallSpeed = 45,
    fogColor = {25, 10, 10},
    fogDistance = 55,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 180,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/lava/side_plane1",
            },
        },
    },

    planeTypes = {

    },

    planes = {
        { distance = 5000000 },
    },
}