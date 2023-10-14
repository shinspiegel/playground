import "gamescene"
import "startscene"

import "customer"
import "wordbubble"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('PressA').extends(gfx.sprite)

function PressA:init()
    
   
    local text = "Press A to continue"

    
   local gameOverImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(gameOverImage)
        gfx.drawText(text, 0, 0)
    gfx.popContext()
    
    
    self:setImage(gameOverImage)
    
    self:moveTo(200, 230)
    
    
    self:setZIndex(151)

    self:add()


end


