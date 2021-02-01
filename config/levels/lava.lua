return {
    name = "Lava",
    nextLevel = nil,

    fallSpeed = 45,
    fogColor = {25, 10, 0},
    fogDistance = 55,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = 0.2,
    playerRotationChangeSpeed = 0.02,

    sidePlanesCount = 60,
    sidePlanesRandomBrightness = true,
    sidePlanesBrightness = 0.95,
    sidePlanes = {
        {
            textures = {
                "levels/lava/side_plane_red1",
                "levels/lava/side_plane_red2",
                "levels/lava/side_plane_red3",
            },
        },
        {
            textures = {
                "levels/lava/side_plane_blue1",
            },
        },
        {
            textures = {
                "levels/lava/side_plane_red1",
            },
        },
    },

    planeTypes = {
        corner_hole = {
            planes = {{ texture = "levels/lava/corner_hole", }},
        },
        sharp_corner_hole = {
            planes = {{ texture = "levels/lava/sharp_corner_hole", }},
        },
        sharp_middle_thing = {
            planes = {{ texture = "levels/lava/sharp_middle_thing", }},
        },
        sharp_side_things = {
            planes = {{ texture = "levels/lava/sharp_side_things", }},
        },
        wide_middle_thing = {
            planes = {{ texture = "levels/lava/wide_middle_thing", }},
        },
        middle_hole = {
            planes = {
                { texture = "levels/lava/middle_hole" },
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
        { distance = 100, name = "sharp_corner_hole", },
        { distance = 15, name = "sharp_corner_hole", rotation = 90, },
        { distance = 15, name = "sharp_corner_hole", rotation = 180, },
        { distance = 15, name = "sharp_corner_hole", rotation = 270, },

        { distance = 50, name = "wide_middle_thing", },

        { distance = 40, name = "sharp_middle_thing", rotation = 0, },
        { distance = 15, name = "sharp_side_things", rotation = 0, },
        { distance = 10, name = "sharp_middle_thing", rotation = 180, },
        { distance = 10, name = "sharp_side_things", rotation = 180, },

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