local gfx <const> = playdate.graphics
local levelBGs <const> = {
    l1 = gfx.image.new("gfx/bgs/lv1"),
    l2 = gfx.image.new("gfx/bgs/lv2"),
    l3 = gfx.image.new("gfx/bgs/lv3"),
    l4 = gfx.image.new("gfx/bgs/lv4"),
    l5 = gfx.image.new("gfx/bgs/lv5")
}
local levelColls <const> = {
    l1 = {{x=0,y=102,w=200,h=10}},
    l5 = {{x=0,y=89,w=200,h=10},{x=147,y=80,w=40,h=10},{x=185,y=30,w=10,h=90}},
    l2 = {{x=0,y=31,w=16,h=8},{x=0,y=39,w=24,h=8},{x=0,y=47,w=32,h=8},{x=0,y=55,w=40,h=8},{x=0,y=63,w=48,h=8},{x=0,y=71,w=88,h=8},{x=113,y=86,w=87,h=8}},
    l3 = {{x=0,y=112,w=139,h=8},{x=82,y=95,w=23,h=6},{x=44,y=79,w=23,h=6},{x=89,y=71,w=111,h=6}},
    l4 = {{x=0,y=102,w=108,h=10},{x=132,y=102,w=68,h=10},{x=92,y=46,w=16,h=56},{x=70,y=92,w=17,h=10},{x=25,y=76,w=32,h=1},{x=73,y=58,w=19,h=1}}
}
local levelLights <const> = {
    l1 = function()
        Hanglight(60,15,-15,15, 4000, 7)
        Hanglight(110,30,-5,5,2000,3)
    end,
    l5 = function()
        Hanglight(60,10,-15,15, 4000, 7)
        Hanglight(98,20,-5,5,2000,3)
        --Hanglight(20,30,-5,5,2000,3)
        --createFireflies(10,10)
    end,
    l2 = function() 
        Hanglight(15,10,-15,20,3000,5)
        Hanglight(110,25,-5,5,2000,4) 
        Hanglight(61,15,-20,20,1500,5)
    end,
    l3 = function() 
        Hanglight(54,14,-75,75,3000,5)
        Hanglight(110,8,-10,10,2000,4) 
    end,
    l4 = function()
        Hanglight(30,5,-5,5,2000,5.5)
        Hanglight(90,5,-5,5,2000,5.5)
        Hanglight(60,5,-25,25,5000,2)
        --createFireflies()
    end
}
local levelPlayer <const> = {
    l1 = {x=100,y=100},
    l5 = {x=8,y=85},
    l2 = {x=8,y=8},
    l3 = {x=8,y=125},
    l4 = {x=8,y=100}
}

level = 0
curBG = nil
local addedCol = {}

function nextLevel()
    level += 1
    if curBG ~= nil then curBG:remove() end
    curBG = gfx.sprite.new(levelBGs["l"..level])
    local colls = levelColls["l"..level]
    for i = #addedCol, 1, -1 do
        addedCol[i]:remove()
        table.remove(addedCol)
    end
    for i = 1, #colls do
        local coll = colls[i]
        addedCol[#addedCol+1] = gfx.sprite.addEmptyCollisionSprite(coll.x,coll.y+3,coll.w,coll.h)
    end
    rmLights()
    killFireflies()
    levelLights["l"..level]()
    curBG:moveTo(100,60)
    local coords = levelPlayer["l"..level]
    sprPlayer.velocity = {x=0,y=0}
    sprPlayer:moveTo(coords.x,coords.y)
    curBG:add()
    curBG:setZIndex(-1)
end

function reLevel()
    local coords = levelPlayer["l"..level]
    sprPlayer:moveTo(coords.x,coords.y)
    sprPlayer.velocity = {x=0,y=0}
end