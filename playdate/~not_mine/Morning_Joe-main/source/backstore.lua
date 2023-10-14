import "CoreLibs/animation"

import "CoreLibs/animator"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('BackCloseStore').extends(gfx.sprite)


function BackCloseStore:init()
    BackCloseStore.super.init(self)
    
    local cardImage = gfx.image.new("images/StoreCloseBack")
    
    self:setImage(cardImage)

    self:moveTo(320,140)
    
    self:setZIndex(900)
    self:add()
    

end
