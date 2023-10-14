
import "CoreLibs/sprites"
import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Addicon').extends(gfx.sprite)

function Addicon:init(whatisaname, AMIWRONGSON)
    Addicon.super.init(self)

    local cardImage = gfx.image.new("images/exs")

    if AMIWRONGSON == "bad" then
        cardImage = gfx.image.new("images/exs")
    end
    
    if AMIWRONGSON == "good" then
        cardImage = gfx.image.new("images/arrows")
    end
   
    if AMIWRONGSON == "great" then
        cardImage = gfx.image.new("images/checks")
    end
   
   
    
    self:setImage(cardImage)
    

    
    
    self:moveTo(10+48*(whatisaname-1),94)

    self.MyX = 10+48*(whatisaname-1)
    
    self.MyY = self.Y

    self:setZIndex(21)
    
    self:add()
   
   

end


function Addicon:update()
    
    
    self:moveTo(self.x+(self.MyX-self.x)/2,94)
end
    
    