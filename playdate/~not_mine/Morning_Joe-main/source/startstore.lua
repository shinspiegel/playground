import "CoreLibs/animation"

import "CoreLibs/animator"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('StoreAnimation').extends(gfx.sprite)


function StoreAnimation:init()
    StoreAnimation.super.init(self)
    --local bahbahblacksheep = math.random(1,2)

    --print("bahbahblacksheep: "..bahbahblacksheep)
    local string = "images/Cafe_Day-table-143-194"
    
    self.imagetable = playdate.graphics.imagetable.new(string)

    self.animation = gfx.animation.loop.new(400, self.imagetable, true)

    self:moveTo(320,110)
    self:setZIndex(900)
    self:add()
    

end


function StoreAnimation:update()
     

    self:setImage(self.animation:image())


end