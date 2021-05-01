local mathUtils = require("utils.math")

local levelConfig = {
    name = "Endless",

    fogDistance =  90,

    sidePlanesRandomBrightness = true,
    sidePlanesCount = 70,
    sidePlanes = {},

    planeTypes = {
        obstacle1 = {
            difficulty = 1,
            planes = {{ texture = "levels/endless/obstacles/1" }}
        },
        obstacle2 = {
            difficulty = 0.72,
            planes = {
                { texture = "levels/endless/obstacles/2" },
                { texture = "levels/vents/fan_holder", position = {0, 0, 1}, chance = 0.35 },
            },
            variants = {"obstacle2", "obstacle2_1"},
        },
        obstacle2_1 = {
            excludeFromRandomGeneration = true,
            planes = {
                { texture = "levels/vents/half_hole", rotation = 180 },
                { texture = "levels/vents/fan_holder", position = {0, 0, 1}, chance = 0.35 },
            },
        },
        obstacle3 = {
            difficulty = 0.5,
            planes = {
                { texture = "levels/endless/obstacles/3" },
                { texture = "levels/vents/fan_holder", position = {3.5, 0, 2}, chance = 0.5 },
                { texture = "levels/vents/fan_holder", position = {-3.5, 0, 2}, chance = 0.5 },
                { texture = "levels/vents/long_stick", position = {-3.5, 0, 4}, rotation = 90, chance = 0.25 },
            }
        },
        obstacle4 = {
            difficulty = 0.85,
            planes = {{ texture = "levels/endless/obstacles/4" }}
        },
        obstacle5 = {
            difficulty = 0.82,
            planes = {{ texture = "levels/endless/obstacles/5" }},
            { texture = "levels/vents/fan_holder", position = {3.5, 0, 2}, chance = 0.5 },
            { texture = "levels/vents/fan_holder", position = {-3.5, 0, 2}, chance = 0.5 },
        },
        obstacle6 = {
            difficulty = 0.36,
            planes = {
                { texture = "levels/endless/obstacles/6" },
                { texture = "levels/endless/obstacles/6_sign", position = {0, 0, 0.2}, chance = 0.1 },
                { texture = "levels/vents/long_stick", position = {0, 0, 3}, chance = 0.15 },
                { texture = "levels/vents/fan_holder", position = {0, 0, 5}, chance = 0.25 },
            },
            variants = {"obstacle6", "obstacle6_1"},
        },
        obstacle6_1 = {
            excludeFromRandomGeneration = true,
            planes = {{ texture = "levels/old_mine/obstacle8_1", }},
        },
        obstacle7 = {
            difficulty = 0.9,
            planes = {
                { texture = "levels/endless/obstacles/7", rotationSpeed = 3,},
                { texture = "levels/vents/fan_holder", position = {0, 0, 1} },
                { texture = "levels/vents/fan_holder", position = {0, 0, -2} },
            },
            variants = {"obstacle7", "obstacle7_2", "obstacle7_3"}
        },
        obstacle7_2 = {
            excludeFromRandomGeneration = true,
            planes = {
                { texture = "levels/endless/obstacles/7", rotationSpeed = -3,},
                { texture = "levels/vents/fan_holder", position = {0, 0, 1} },
                { texture = "levels/vents/fan_holder", position = {0, 0, -2} },
                { texture = "levels/vents/fan_holder", position = {0, 0, -2}, rotation = 90 },
            }
        },
        obstacle7_3 = {
            excludeFromRandomGeneration = true,
            planes = {
                { texture = "levels/endless/obstacles/7_2", rotationSpeed = 4, },
                { texture = "levels/vents/fan_holder", position = {0, 0, 1} },
                { texture = "levels/vents/fan_holder", position = {0, 0, -2} },
            }
        },
        obstacle8 = {
            difficulty = 0.4,
            planes = {
                { texture = "levels/vents/long_stick", position = {0, 0, 0}, rotation = 90 },
                { texture = "levels/vents/fan_holder", position = {0, 0, 5}, rotation = 90, chance = 0.5 },
            }
        },

        breakable1 = {
            excludeFromRandomGeneration = true,
            difficulty = 1,
            spaceAfter = 100,
            planes = {{ texture = "levels/endless/obstacles/breakable", breakable = true} }
        },
        breakable2 = {
            excludeFromRandomGeneration = true,
            difficulty = 1,
            spaceAfter = 100,
            planes = {{ texture = "levels/old_mine/obstacle9", breakable = true} }
        }
    },
}

local breakableVariants = {"breakable1", "breakable2"}

local musicVariants = {
    "forest_theme1",
    "forest_theme2",
    "mine_theme1",
    "stone_cave",
    "vents_theme",
    "meat_theme",
}

local sidePlanesVariants = {
    {
        textures = {
            "levels/stone_cave/side_plane2",
        },
    },
    {
        textures = {
            "levels/stone_cave/side_plane3",
        },
    },
    {
        textures = {
            "levels/stone_cave/side_plane1",
        },
    },
    {
        textures = {
            "levels/stone_cave/side_plane4",
            "levels/stone_cave/side_plane3",
            "levels/stone_cave/side_plane2",
            "levels/stone_cave/side_plane1",
            "levels/meat/side_planes/cave1",
            "levels/meat/side_planes/cave2",
        },
    },
    {
        textures = {
            "levels/gears/decorative1",
            "levels/gears/decorative3",
        },
        pattern = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2 },
    },
    {
        textures = {
            "levels/gears/decorative2",
            "levels/gears/decorative3",
        },
        pattern = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2 },
    },
    {
        textures = {
            "levels/gears/decorative1",
            "levels/gears/decorative2",
            "levels/gears/decorative3",
        },
        pattern = { 1, 1, 1, 1, 1, 3, 2, 2, 2, 2, 2, 3 },
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

local function generateSidePlanes(seed, index)
    math.randomseed(seed + index)
    return sidePlanesVariants[math.random(1, #sidePlanesVariants)]
end

local function getRandomObstacleName(planeTypeNames, maxDifficulty)
    if not maxDifficulty then
        return planeTypeNames[math.random(1, #planeTypeNames)]
    end

    local matchingItems = {}
    for _, name in ipairs(planeTypeNames) do
        local difficulty = levelConfig.planeTypes[name].difficulty
        if difficulty <= maxDifficulty then
            table.insert(matchingItems, name)
        end
    end

    return matchingItems[math.random(1, #matchingItems)]
end

local function randomize(seed)
    if not seed then
        seed = os.time()
    end

    math.randomseed(seed)

    local baseFallSpeed = 30

    levelConfig.fallSpeed = baseFallSpeed
    levelConfig.totalHeight = math.huge
    levelConfig.endless = true
    levelConfig.fogColor = {0, 0, 0}
    levelConfig.music = musicVariants[math.random(1, #musicVariants)]

    levelConfig.playerRotationMode = "constant"
    levelConfig.playerRotationSpeed = math.random() > 0.5 and 12 or -12
    levelConfig.sidePlanes = {
        generateSidePlanes(seed, 1)
    }

    -- Random planes
    local planeTypeNames = {}
    local minDifficulty = 1
    for name, planeConfig in pairs(levelConfig.planeTypes) do
        if not planeConfig.excludeFromRandomGeneration then
            table.insert(planeTypeNames, name)

            if planeConfig.difficulty < minDifficulty then
                minDifficulty = planeConfig.difficulty
            end
        end
    end
    levelConfig.planes = {}

    -- Generation
    local lastIndex = 0
    local totalDistance = 0
    local planesCache = {
        { distance = 80, tunnelShape = { direction = {math.random() * 6 - 3, math.random() * 6 - 3} }}
    }
    local currentFallSpeed = levelConfig.fallSpeed
    local breakablePlaneIn = 2
    local easySpaceIn = 10
    local maxDifficulty = minDifficulty
    local planesToMaxDifficulty = 20
    local forceEmptySpace = false
    local function getPlane(index)
        if planesCache[index] then
            return planesCache[index]
        end

        math.randomseed(seed + index)

        local plane = { distance = 100 }

        if forceEmptySpace and forceEmptySpace > 0 then
            plane.distance = forceEmptySpace
            plane.tunnelShape = { direction = {0, 0}, rotationSpeed = 0 }
            forceEmptySpace = false
        elseif easySpaceIn <= 0 then
            easySpaceIn = math.random(5, 15)
            plane.distance = math.random(10, 50) + currentFallSpeed

            breakablePlaneIn = breakablePlaneIn - 1
            if breakablePlaneIn <= 0 then
                breakablePlaneIn = 3
                plane.name = breakableVariants[math.random(1, #breakableVariants)]
                table.insert(levelConfig.sidePlanes, generateSidePlanes(seed, index))
                plane.switchSidePlanes = true
                forceEmptySpace = math.random(20, 60) + currentFallSpeed
            else
                forceEmptySpace = 5
            end
        else
            local distanceMultiplier = 1 + (1 - maxDifficulty)
            plane.name = getRandomObstacleName(planeTypeNames, maxDifficulty)
            if not plane then
                print("[ERROR] No plane name")
                return { distance = 100 }
            end
            local planeConfig = levelConfig.planeTypes[plane.name]
            if planeConfig.variants then
                plane.name = planeConfig.variants[math.random(1, #planeConfig.variants)]
            end
            local distance = levelConfig.fallSpeed * 1.2
            plane.distance = mathUtils.lerp(distance * 0.3, distance * 1, planeConfig.difficulty) * distanceMultiplier
            plane.rotation = math.random(0, 3) * 90

            currentFallSpeed = baseFallSpeed + totalDistance * 0.00002
            plane.fallSpeed = currentFallSpeed

            if planeConfig.spaceAfter then
                forceEmptySpace = planeConfig.spaceAfter
            end

            easySpaceIn = easySpaceIn - 1

            if easySpaceIn <= 0 then
                plane.tunnelShape = {
                    direction = {math.random() * 6 - 3, math.random() * 6 - 3},
                }
            end

            if maxDifficulty < 1 then
                maxDifficulty = maxDifficulty + (1 - minDifficulty) / planesToMaxDifficulty
                if maxDifficulty >= 1 then
                    maxDifficulty = 1
                end
            end
        end

        planesCache[index] = plane

        return plane
    end
    local mt = {
        __index  = function (_, index)
            local plane = getPlane(index)
            if index > lastIndex then
                totalDistance = totalDistance + plane.distance
            end

            return plane
        end,
    }
    setmetatable(levelConfig.planes, mt)
end

randomize()
levelConfig.randomize = randomize

return levelConfig