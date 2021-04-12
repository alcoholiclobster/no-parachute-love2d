local levelConfig = {
    name = "Endless",

    fogColor = {0, 0, 0},
    fogDistance =  90,

    playerRotationMode = "constant",
    playerRotationSpeed = -12,

    sidePlanesRandomBrightness = true,
    sidePlanesCount = 70,
    sidePlanes = {},

    planeTypes = {
        middle_door = {
            planes = {
                { texture = "levels/vents/middle_door_frame" },
            },
        },

        middle_long_stick = {
            planes = {
                { texture = "levels/vents/long_stick", position = {0, 0, 0}, rotation = 180 },
            }
        },

        side_long_sticks = {
            planes = {
                { texture = "levels/vents/long_stick", position = {-3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {3, 0, 0} },
            }
        },

        middle_sticks_hole = {
            planes = {
                { texture = "levels/vents/long_stick", position = {-3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {3, 0, 0} },
                { texture = "levels/vents/long_stick", position = {-3, 0,  1}, rotation = 90 },
                { texture = "levels/vents/long_stick", position = {3, 0, 1}, rotation = 90 },
            }
        },

        half_hole = {
            planes = {
                { texture = "levels/vents/half_hole", position = {0, 0, 0} },
            },
        },

        corner_hole = {
            planes = {
                { texture = "levels/vents/fan_holder", position = {-0.5, 0, 2}},
                { texture = "levels/vents/corner_hole" },
                { texture = "levels/vents/small_fan", position = {-2.96875, -3.125, -0.5}, rotationSpeed = -16, },
            },
        },

        middle_wide_hole = {
            planes = {
                { texture = "levels/vents/middle_wide_hole", position = {0, 0, 0} },
            },
        },

        middle_small_hole = {
            planes = {
                { texture = "levels/vents/middle_small_hole", position = {0, 0, 0} },
            },
        },

        middle_wide_door = {
            planes = {
                { texture = "levels/vents/middle_wide_door_frame" },
            },
        },

        -- TODO: Use in the end
        middle_wide_door_breakable = {
            planes = {
                { texture = "levels/vents/middle_wide_door_frame" },
                { texture = "levels/vents/middle_wide_door_left", position = {0, 0, -0.5}, breakable = true },
                { texture = "levels/vents/middle_wide_door_right", position = {0, 0, -0.5}, },
            },
        },

        fan = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = 3, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },


        fan_reversed = {
            planes = {
                { texture = "levels/vents/fan", rotationSpeed = -4, },
                { texture = "levels/vents/fan_holder", position = {0, 0, -0.5} },
            },
        },
        wall_hands = {
            planes = {{ texture = "levels/meat/obstacles/wall_hands", }},
        },
        stone_hole = {
            planes = {
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, 1} },
                { texture = "levels/meat/obstacles/stone_obstacle1", }
            },
        },
        stone_small_hole = {
            planes = {
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 2} },
                { texture = "levels/meat/obstacles/stone_obstacle2", }
            },
        },
        stone_small_hole2 = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle4", },
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 4}, rotation = 180 },
            },
        },
        stone_side_long_hole = {
            planes = {
                { texture = "levels/meat/obstacles/stone_obstacle3", },
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, 2} },
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 4} },
            },
        },
        stone_breakable_wall = {
            planes = {{ texture = "levels/meat/obstacles/stone_obstacle_breakable", breakable = true }},
        },
        old_door = {
            planes = {
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, 2}, rotation = 0 },
                { texture = "levels/meat/obstacles/web2", decorative = true, position = {0, 0, 4}, rotation = 0 },
                { texture = "levels/vents/middle_door_frame" },
                { texture = "levels/meat/obstacles/web1", decorative = true, position = {0, 0, -2}, rotation = 180 },
                { texture = "levels/vents/middle_door", position = {0, 0, -0.5}, velocity = {-8, 0, 0}, moveDelay = 1, },
            },
        },
        meat_long_middle_thing = {
            planes = {
                { texture = "levels/meat/obstacles/long_meat_middle_thing" },
                { texture = "levels/meat/obstacles/long_meat_middle_thing2", position = {0, 0, -0.25}, decorative = true },
            },
        },
        meat_decorative_corner_things2 = {
            planes = {
                { texture = "levels/meat/obstacles/meat_decorative_corner_things2" },
            },
        },
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
        side_wood1 = {
            planes = {{ texture = "levels/old_mine/obstacle1", }},
        },
        side_wood1_green = {
            planes = {{ texture = "levels/old_mine/obstacle1_1", }},
        },
        middle_bridge = {
            planes = {{ texture = "levels/old_mine/obstacle8", }},
        },
        middle_bridge_green = {
            planes = {{ texture = "levels/old_mine/obstacle8_1", }},
        },
        side_wood2 = {
            planes = {{ texture = "levels/old_mine/obstacle2", }},
        },
        side_wood2_green = {
            planes = {{ texture = "levels/old_mine/obstacle2_1", }},
        },
        -- Corner hole thing
        corner_hole2 = {
            planes = {
                { texture = "levels/old_mine/obstacle7_1", },
                { texture = "levels/old_mine/obstacle7_2", position = {0, 0, 1} },
            },
        },
        corner_hole_green = {
            planes = {
                { texture = "levels/old_mine/obstacle7_3", },
            },
        },
        -- Long middle hole thing
        middle_hole = {
            planes = {{ texture = "levels/old_mine/obstacle3", }},
        },
        middle_hole_green = {
            planes = {{ texture = "levels/old_mine/obstacle3_1", }},
        },

        -- Single minecart
        minecart = {
            planes = {
                { texture = "levels/old_mine/obstacle4_1", position = {0, 0, -2} },
                { texture = "levels/old_mine/obstacle4_2", position = {-15, 0, 0}, velocity = {5, 0, 0} },
                { texture = "levels/old_mine/obstacle4_3", position = {0, 0, 2} },
            },
        },

        -- Conveyor belts
        belts = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, -2.5, 4}, velocity = {-3, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {10-0.16, -2.5, 4}, velocity = {-3, 0, 0} },

                { texture = "levels/old_mine/obstacle5_2", position = {0, 2.5, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 2.5, 0}, velocity = {1.5, 0, 0} },

                { texture = "levels/old_mine/obstacle1", position = {0, 0, -3.5}, velocity = {0, 0, 0}, rotation = 90 },
            },
        },
        belt1 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_1", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_1", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        belt2 = {
            planes = {
                { texture = "levels/old_mine/obstacle5_2", position = {0, 0, 0}, velocity = {1.5, 0, 0} },
                { texture = "levels/old_mine/obstacle5_2", position = {-10+0.16, 0, 0}, velocity = {1.5, 0, 0} },
            },
        },
        keep_out = {
            planes = {{ texture = "levels/old_mine/keep_out", }},
        },

        breakable1 = {
            planes = {{ texture = "levels/old_mine/obstacle9", breakable = true }},
        },
    },
}

local sidePlanesVariants = {
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
    {
        textures = {
            "levels/meat/side_planes/cave1",
            "levels/meat/side_planes/cave2",
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
            "levels/tutorial/side_plane1",
            "levels/tutorial/side_plane3",
            "levels/tutorial/side_plane4",
        },
    },
    {
        textures = {
            "levels/tutorial/side_plane1",
            "levels/tutorial/side_plane2",
            "levels/tutorial/side_plane3",
            "levels/tutorial/side_plane4",
        },
    },
    {
        textures = {
            "levels/old_mine/wall1",
            "levels/old_mine/wall2",
            "levels/old_mine/wall3",
        }
    },
    {
        textures = {
            "levels/old_mine/wall4",
        }
    },
    {
        textures = {
            "levels/stone_cave/side_plane4",
        },
    },
    {
        textures = {
            "levels/vents/dt1",
            "levels/vents/dt2",
            "levels/vents/dt3",
            "levels/vents/dt4",
            "levels/vents/dt5",
            "levels/vents/dt6",
        },
        pattern = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5 },
    },
}

local function generateSidePlanes()
    return sidePlanesVariants[math.random(1, #sidePlanesVariants)]
end

local function randomize()
    levelConfig.fallSpeed = 45
    levelConfig.totalHeight = math.huge
    levelConfig.endless = true

    levelConfig.sidePlanes = {
        generateSidePlanes()
    }

    -- Random planes
    local planeTypeNames = {}
    for name in pairs(levelConfig.planeTypes) do
        table.insert(planeTypeNames, name)
    end
    levelConfig.planes = {}
    local mt = {
        __index  = function (t, index)
            if index == 1 then
                return { distance = 100 }
            end
            local plane = { distance = 20 }
            if math.random() > 0.5 then
                plane.name = planeTypeNames[math.random(1, #planeTypeNames)]
            end
            if math.random() > 0.1 then
                plane.switchSidePlanes = true
                table.insert(levelConfig.sidePlanes, generateSidePlanes())
            end

            return plane
        end,
    }
    setmetatable(levelConfig.planes, mt)
end

levelConfig.randomize = randomize

return levelConfig