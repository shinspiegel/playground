import "CoreLibs/animation"

import "CoreLibs/animator"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Steam').extends(gfx.sprite)


function Steam:init()
    Steam.super.init(self)
    
    local string = "images/Steam-table-16-37"
    self.imagetable = playdate.graphics.imagetable.new(string)

    self.animation = gfx.animation.loop.new(200, self.imagetable, true)

    self:moveTo(94,80)
    
    self.myAnimator = gfx.animator.new(300, 0, 240)
    self:setZIndex(21)
    self:add()
    
    self.MyX = 135

    self.MyY = 85 

end

function Steam:update()
     
    self:moveTo(self.x+(self.MyX-self.x)/2,self.y+(self.MyY-self.y)/2)

    self:setImage(self.animation:image())



end