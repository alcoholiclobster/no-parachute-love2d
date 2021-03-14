return {
    name = "Meat 3",
    nextLevel = nil,
    music = "meat_theme",
    ambient = "worm",

    fallSpeed = 55,
    fogColor = {25, 10, 0},
    fogDistance = 50,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.3,
    playerRotationChangeSpeed = 0.01,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
        {
            textures = {
                "levels/core/side_planes/1",
                "levels/core/side_planes/2",
            },
        },
        {
            textures = {
                "levels/core/side_planes/wide1",
            },
        },
        {
            textures = {
                "levels/core/side_planes/1",
                "levels/core/side_planes/2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
    },

    planeTypes = {
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },

        projectile_rock = {
            planes = {{ texture = "levels/core/projectiles/rock", velocity = {0, 0, 20}, rotationSpeed = 5 }},
        },

        wall = {
            planes = {{ texture = "levels/core/obstacles/wall", decorative = true }},
        },
        white_wall = {
            planes = {{ texture = "levels/core/obstacles/white_wall", decorative = true }},
        },
    },

    planes = {
        { distance = 200, name = "stone_breakable_wall", switchSidePlanes = true},
        { distance = 100, name = "stone_breakable_wall", switchSidePlanes = true},
        { distance = 94, fogColor = {255, 200, 100}, fallSpeed = 80},

        { distance = 50, name = "projectile_rock", position = {-3.5, -3.5, 0} },
        { distance = 2, name = "projectile_rock", position = {3, 0, 0} },
        { distance = 2, name = "projectile_rock", position = {-3.5, 3, 0} },
        { distance = 2, name = "projectile_rock", position = {0, -3, 0} },

        { distance = 100, tunnelShape = { direction = {0, 0}, rotationSpeed = 1 }, },
        { distance = 10, name = "projectile_rock", position = {0, 0, 0}, rotation = 90 },
        { distance = 190, tunnelShape = { direction = {10, 0}, rotationSpeed = -1 }, },
        { distance = 2, name = "projectile_rock", position = {-3.5, -3, 0} },
        { distance = 4, name = "projectile_rock", position = {-4, 2, 0} },

        { distance = 50, name = "projectile_rock", position = {0, 2, 0} },
        { distance = 2, name = "projectile_rock", position = {0.2, 0, 0} },
        { distance = 2, name = "projectile_rock", position = {0.5, -3, 0} },

        { distance = 100, name = "projectile_rock", position = {0, 0, 0} },

        { distance = 100, tunnelShape = { direction = {0, 10}, rotationSpeed = 0.5 }, },
        { distance = 100, tunnelShape = { direction = {-5, 0}, rotationSpeed = 4 }, },
        { distance = 100, tunnelShape = { direction = {0, 0}, rotationSpeed = -2 }, },
        { distance = 100, switchSidePlanes = true, name = "wall" },
        { distance = 97, fogColor = {255, 255, 255}, fallSpeed = 20},
        { distance = 200 },
        { distance = 100, switchSidePlanes = true, name = "white_wall" },
        { distance = 97, fogColor = {255, 200, 100}, fallSpeed = 120},
        { distance = 300, switchSidePlanes = true, },
        { distance = 97, fogColor = {0, 0, 0}, fallSpeed = 100},
        { distance = 200, },
    },
}