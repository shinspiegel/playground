import "CoreLibs/animation"

import "CoreLibs/animator"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('SmokeScreen').extends(gfx.sprite)


function SmokeScreen:init()
    SmokeScreen.super.init(self)
    
    local string = "images/Puff-table-64-64"
    self.imagetable = playdate.graphics.imagetable.new(string)

    self.animation = gfx.animation.loop.new(80, self.imagetable, true)

    self:moveTo(94,110)
    
    self.myAnimator = gfx.animator.new(300, 0, 240)
    self:setZIndex(900)
    self:add()
    
    self.MyX = 116

    self.MyY = 125 

end

function SmokeScreen:update()
     
    self:moveTo(self.x+(self.MyX-self.x)/2,self.y+(self.MyY-self.y)/2)

    self:setImage(self.animation:image())
     if self.myAnimator:ended() then
      
         self:remove()
    
     end



end