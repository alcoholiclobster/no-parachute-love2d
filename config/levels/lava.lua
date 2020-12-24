return {
    name = "Lava",
    nextLevel = nil,

    fallSpeed = 45,
    fogColor = {25, 10, 0},
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
        {
            textures = {
                "levels/lava/side_plane2",
            },
        },
        {
            textures = {
                "levels/lava/side_plane1",
            },
        },
    },

    planeTypes = {
        corner_hole = {
            planes = {{ texture = "levels/lava/corner_hole", }},
        },
        corner_hole_big = {
            planes = {
                { texture = "levels/lava/corner_hole_big4", position = {0, 0, 0}},
                { texture = "levels/lava/corner_hole_big3", position = {0, 0, -2}},
                { texture = "levels/lava/corner_hole_big2", position = {0, 0, -4}},
                { texture = "levels/lava/corner_hole_big", position = {0, 0, -6}},
            },
        },
        middle_hole = {
            planes = {
                { texture = "levels/lava/middle_hole4", position = {0, 0, 0}},
                { texture = "levels/lava/middle_hole3", position = {0, 0, -1}},
                { texture = "levels/lava/middle_hole2", position = {0, 0, -2}},
                { texture = "levels/lava/middle_hole", position = {0, 0, -3}},
            },
        },
        breakable_wall = {
            planes = {{ texture = "levels/lava/breakable_wall", breakable = true }},
        },
        breakable_wall_blue = {
            planes = {{ texture = "levels/lava/breakable_wall_blue", breakable = true }},
        },
        projectile_rock = {
            planes = {{ texture = "levels/lava/projectiles/rock", velocity = {0, -2, 10} }},
        },
        projectile_ring = {
            planes = {{ texture = "levels/lava/projectiles/ring", velocity = {0, -2, 10}, rotationSpeed = 3 }},
        },
    },

    planes = {
        { distance = 100, name = "corner_hole_big", rotation = 0, },
        { distance = 19, name = "corner_hole_big", rotation = 90, },
        { distance = 19, name = "corner_hole_big", rotation = 180, },
        { distance = 19, name = "corner_hole_big", rotation = 270, },
        { distance = 19, name = "corner_hole_big", rotation = 0, },
        { distance = 19, name = "corner_hole_big", rotation = 90, },
        { distance = 19, name = "corner_hole_big", rotation = 180, },
        { distance = 19, name = "corner_hole_big", rotation = 270, },
        { distance = 40, name = "corner_hole", rotation = 90, },
        { distance = 25, name = "middle_hole", rotation = 0, },
        { distance = 10, name = "breakable_wall", rotation = 0, switchSidePlanes = true },

        { distance = 100, name = "projectile_rock", position = {-2, 4, 0}, rotation = 90 },
        { distance = 10, name = "projectile_rock", position = {2, -2, 0}, rotation = 180 },
        { distance = 30, name = "projectile_rock", position = {4, 0, 0}, rotation = 0 },
        { distance = 1, name = "projectile_rock", position = {-4, 3, 0}, rotation = 270 },
        { distance = 10, name = "projectile_rock", position = {-3, 2, 0}, rotation = 90 },
        { distance = 1, name = "projectile_rock", position = {-1, -4, 0}, rotation = 180 },
        { distance = 20, name = "projectile_rock", position = {-2, 4, 0}, rotation = 90 },
        { distance = 10, name = "projectile_rock", position = {2, -2, 0}, rotation = 180 },
        { distance = 30, name = "projectile_rock", position = {4, 0, 0}, rotation = 0 },
        { distance = 1, name = "projectile_rock", position = {-4, 3, 0}, rotation = 270 },
        { distance = 10, name = "projectile_rock", position = {-3, 2, 0}, rotation = 90 },
        { distance = 1, name = "projectile_rock", position = {-1, -4, 0}, rotation = 180 },
        { distance = 10, name = "projectile_rock", position = {2, -2, 0}, rotation = 180 },
        { distance = 30, name = "projectile_rock", position = {4, 0, 0}, rotation = 0 },
        { distance = 1, name = "projectile_rock", position = {-1, 3, 0}, rotation = 270 },
        { distance = 10, name = "projectile_rock", position = {-3, 2, 0}, rotation = 90 },
        { distance = 1, name = "projectile_rock", position = {-1, -4, 0}, rotation = 180 },
        { distance = 20, name = "projectile_rock", position = {-2, 4, 0}, rotation = 90 },
        { distance = 10, name = "projectile_rock", position = {2, -2, 0}, rotation = 180 },
        { distance = 30, name = "projectile_rock", position = {4, 0, 0}, rotation = 0 },
        { distance = 1, name = "projectile_rock", position = {-1, 3, 0}, rotation = 270 },
        { distance = 10, name = "projectile_rock", position = {-3, 2, 0}, rotation = 90 },
        { distance = 1, name = "projectile_rock", position = {-1, -4, 0}, rotation = 180 },
        { distance = 20, name = "breakable_wall_blue", rotation = 0, switchSidePlanes = true },
        { distance = 100, name = "projectile_ring", position = {-2, 4, 0}, rotation = 90 },
        { distance = 40, name = "projectile_ring", position = {2, -4, 0}, rotation = 90 },
        { distance = 40, name = "projectile_ring", position = {-2, -4, 0}, rotation = 90 },
        { distance = 40, name = "projectile_ring", position = {2, 4, 0}, rotation = 90 },

        { distance = 5000000 },
    },
}