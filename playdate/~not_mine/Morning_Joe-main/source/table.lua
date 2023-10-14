

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Table').extends(gfx.sprite)

function Table:init(place)
    Card.super.init(self)

    local cardImage = gfx.image.new("images/Table")
    
    self:setImage(cardImage)
    
    
    
    self:moveTo(200,160)


    self:setZIndex(10)
    
    self:add()



end
