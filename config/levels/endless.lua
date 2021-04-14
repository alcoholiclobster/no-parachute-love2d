local mathUtils = require("utils.math")

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
        obstacle1 = {
            difficulty = 1,
            planes = {{ texture = "levels/endless/obstacles/1" }}
        },
        obstacle2 = {
            difficulty = 0.75,
            planes = {{ texture = "levels/endless/obstacles/2" }}
        },
        obstacle3 = {
            difficulty = 0.5,
            planes = {{ texture = "levels/endless/obstacles/3" }}
        }
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
    levelConfig.fallSpeed = 90
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
    local planesCache = {
        { distance = 100 }
    }
    local mt = {
        __index  = function (t, index)
            if planesCache[index] then
                return planesCache[index]
            end

            local plane = { distance = 100 }
            if true then
                plane.name = planeTypeNames[math.random(1, #planeTypeNames)]
                local difficulty = levelConfig.planeTypes[plane.name].difficulty
                plane.distance = mathUtils.lerp(levelConfig.fallSpeed * 0.3, levelConfig.fallSpeed * 1, difficulty)
                plane.rotation = math.random(0, 3) * 90
            end

            -- if math.random() > 0.1 then
            --     plane.switchSidePlanes = true
            --     table.insert(levelConfig.sidePlanes, generateSidePlanes())
            -- end

            planesCache[index] = plane

            return plane
        end,
    }
    setmetatable(levelConfig.planes, mt)
end

levelConfig.randomize = randomize

return levelConfig