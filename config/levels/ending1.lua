return {
    name = "Getting Out 1",
    nextLevel = "ending2",
    music = "ending_theme",

    fallSpeed = 55,
    fogColor = {25, 10, 0},
    fogDistance = 90,
    playerRotationMode = "sinusoid",
    playerRotationSpeed = -0.3,
    playerRotationChangeSpeed = 0.012,

    sidePlanesCount = 80,
    sidePlanesRandomBrightness = false,
    sidePlanesBrightness = 0.99,
    sidePlanes = {
        {
            textures = {
                "levels/meat/side_planes/cave1",
                "levels/meat/side_planes/cave2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh_wide2",
            },
        },
        {
            textures = {
                "levels/meat/side_planes/flesh1",
                "levels/meat/side_planes/flesh2",
            },
        },
        {
            textures = {
                "levels/vents/decorative1",
                "levels/vents/decorative2",
                "levels/vents/decorative3",
            }
        },
        {
            textures = {
                "levels/stone_cave/side_plane2",
                "levels/stone_cave/side_plane3",
            },
        },
    },

    planeTypes = {
        -- stone
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },
        stone_side_long_hole = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle3", },
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, 2} },
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 4} },
            },
        },
        stone_long_obstacle = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle5", },
            },
        },
        -- meat
        meat_half_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_decorative_corner_things2", position = {0, 0, 1}, rotation = 180, decorative = true },
                { texture = "levels/meat/obstacles/meat_obstacle_half3", position = {0, 0, 0} },
                { texture = "levels/meat/obstacles/meat_obstacle_half3_2", position = {0, 0, -0.2}, decorative1 = true},
                { texture = "levels/meat/obstacles/meat_obstacle_half2", position = {0, 0, -2} },
                { texture = "levels/meat/obstacles/meat_obstacle_half", position = {0, 0, -4} },
                { texture = "levels/meat/obstacles/meat_obstacle_half_2", position = {0, 0, -4.1}, decorative = true },
            },
        },
        meat_wall = {
            planes = {
                { texture = "levels/meat/obstacles/meat_wall", breakable = true }
            },
        },
        meat_long_middle_thing = {
            planes = {
                { texture = "levels/meat/obstacles/long_meat_middle_thing" },
                { texture = "levels/meat/obstacles/long_meat_middle_thing2", position = {0, 0, -0.25}, decorative = true },
            },
        },

        -- worm
        worm1_big = {
            planes = {
                { texture = "levels/meat/obstacles/worm1", rotationSpeed = 1 }
            }
        },
        worm1_big_head = {
            planes = {
                { texture = "levels/meat/obstacles/worm1_head", rotationSpeed = 1 }
            }
        },
        worm1_wall = {
            planes = {
                { texture = "levels/meat/obstacles/worm_wall", position = {0, 0, 0} },
                { texture = "levels/meat/obstacles/worm_wall", position = {0, 0, -2}, rotation = 90 }
            }
        },
        side_worm_wall = {
            planes = {
                { texture = "levels/meat/obstacles/side_worm_wall", position = {0, 0, 0} },
            }
        },
        worm_smoke = {
            planes = {
                { texture = "levels/meat/obstacles/worm_smoke", position = {0, 1, 0.1}, rotationSpeed = 0.2, velocity = {1, 0, 0}, decorative = true },
                { texture = "levels/meat/obstacles/worm_smoke", position = {1, 0, -2.1}, rotationSpeed = -0.1, velocity = {-0.25, 0.5, 0}, decorative = true },
            }
        },
        worm_smoke2 = {
            planes = {
                { texture = "levels/meat/obstacles/worm_smoke2", position = {0, 1, 0.1}, rotationSpeed = 0.2, velocity = {1, 0, 0}, decorative = true },
                { texture = "levels/meat/obstacles/worm_smoke2", position = {1, 0, -2.1}, rotationSpeed = -0.1, velocity = {-0.25, 0.5, 0}, decorative = true },
            }
        },
        worm_smoke_head = {
            planes = {
                { texture = "levels/meat/obstacles/worm_smoke", position = {0, 6, 0.1}, rotationSpeed = 0.2, velocity = {0, -6, 0}, moveDelay = 0.5, decorative = true },
            }
        },
        meat_big_hole_to_normal = {
            planes = {
                { texture = "levels/meat/obstacles/meat_big_holes_to_normal" },
                { texture = "levels/meat/side_planes/flesh1", position = {0, 0, -2}, rotation = 90 },
                { texture = "levels/meat/side_planes/flesh2", position = {0, 0, -4}, rotation = 0 },
                { texture = "levels/meat/side_planes/flesh1", position = {0, 0, -6}, rotation = 180 },
                { texture = "levels/meat/obstacles/meat_decorative_corner_things", position = {0, 0, -7}, decorative = true },
                { texture = "levels/meat/side_planes/flesh2", position = {0, 0, -8}, rotation = 270 },
            }
        },

        -- vents
        vents_middle_long_stick = {
            planes = {
                { texture = "levels/vents/long_stick", position = {0, 0, 0}, rotation = 180 },
            }
        },
        vents_middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1, },
            },
        },
        vents_middle_small_hole = {
            planes = {
                { texture = "levels/vents/middle_small_hole", position = {0, 0, 0} },
            },
        },
        vents_corner_hole = {
            planes = {
                { texture = "levels/vents/fan_holder", position = {-0.5, 0, 2}},
                { texture = "levels/vents/corner_hole" },
                { texture = "levels/vents/small_fan", position = {-2.96875, -3.125, -0.5}, rotationSpeed = -16, },
            },
        },
        vents_middle_wide_door = {
            planes = {
                { texture = "levels/vents/middle_wide_door_frame" },
                { texture = "levels/vents/middle_wide_door_left", position = {0, 0, -0.5}, velocity = {-4, 0, 0}, moveDelay = 1, },
                { texture = "levels/vents/middle_wide_door_right", position = {0, 0, -0.5}, velocity = {4, 0, 0}, moveDelay = 1, },
            },
        },
        fan_part1 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 6, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },

        fan_part2 = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 6, },
            },
        },
    },

    planes = {
        { distance = 80, name = "stone_long_obstacle" },
        { distance = 20, name = "stone_side_long_hole" },
        { distance = 20, name = "stone_long_obstacle", rotation = 90 },
        { distance = 20, name = "stone_long_obstacle", rotation = 270 },
        { distance = 50, name = "stone_breakable_wall", switchSidePlanes = true },
        { distance = 50, name = "meat_half_wall" },
        { distance = 30, name = "meat_half_wall", rotation = 180 },
        { distance = 6, name = "meat_wall", switchSidePlanes = true },
        { distance = 25, name = "vents_middle_long_stick", rotation = 90 },
        { distance = 20, name = "meat_half_wall" },
        { distance = 10, name = "meat_long_middle_thing", rotation = 90},
        { distance = 10, name = "meat_half_wall", rotation = 90},

        { distance = 30, name = "meat_wall" },
        { distance = 1, switchSidePlanes = true },

        { distance = 70, name = "worm1_wall"},
        { distance = 0, name = "worm_smoke", position = {-8, 8, 0 }},
        { distance = 0, name = "worm_smoke2", position = {10, -10, 0 }},
        { distance = 1, name = "worm1_big", position = {10, 10, 0}},

        { distance = 40, name = "worm1_wall" },
        { distance = 0, name = "worm_smoke", position = {9, 9, 0 }},
        { distance = 0, name = "worm_smoke", position = {-10, -10, 0 }},
        { distance = 1, name = "worm1_big", position = {-8, 8, 0}, rotation = 180},

        { distance = 30, name = "worm1_wall" },
        { distance = 0, name = "worm_smoke2", position = {-2, -9.5, 0 }},
        { distance = 0, name = "worm_smoke", position = {-10, -2, 0 }},
        { distance = 1, name = "worm1_big", position = {15, 15, 0}, rotation = 180},

        { distance = 40, name = "worm1_wall" },
        { distance = 5, name = "meat_big_hole_to_normal" },
        { distance = 1, name = "meat_wall", switchSidePlanes = true, },
        { distance = 10, tunnelShape = { direction = {0, 0}, rotationSpeed = 0 }, },

        { distance = 50, name = "meat_long_middle_thing", rotation = 90},

        { distance = 45, name = "vents_middle_door", switchSidePlanes = true, },

        { distance = 40, name = "vents_middle_small_hole" },
        { distance = 30, name = "fan_part1" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 4, name = "fan_part2" },
        { distance = 20, },
        { distance = 50, name = "vents_corner_hole", rotation = 0, },
        { distance = 35, name = "vents_corner_hole", rotation = 180, },
        { distance = 42, name = "vents_corner_hole", rotation = 0, },
        { distance = 25, name = "vents_middle_long_stick", rotation = 90, },
        { distance = 30, name = "vents_corner_hole", rotation = 180, },
        { distance = 42, name = "vents_corner_hole", rotation = 0, },
        { distance = 25, name = "vents_middle_small_hole", },
        { distance = 25, name = "vents_corner_hole", rotation = 180, },
        { distance = 45, name = "vents_corner_hole", rotation = 0, },
        { distance = 60, name = "vents_middle_wide_door", rotation = 0, },
        { distance = 30, name = "vents_middle_wide_door", rotation = 0, },
        { distance = 30, name = "vents_middle_wide_door", rotation = 0, switchSidePlanes = true, },
    }
}