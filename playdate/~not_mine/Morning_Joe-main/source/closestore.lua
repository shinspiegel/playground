import "CoreLibs/animation"

import "CoreLibs/animator"
import "backstore"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('CloseStore').extends(gfx.sprite)


function CloseStore:init()
    CloseStore.super.init(self)
    
    BackCloseStore()

    local string = "images/Cafe_Atnight-table-143-194"
    self.imagetable = playdate.graphics.imagetable.new(string)

    self.animation = gfx.animation.loop.new(400, self.imagetable, true)

    self:moveTo(320,140)
    
    self:setZIndex(900)
    self:add()


    

end

function CloseStore:update()
     
    
    self:setImage(self.animation:image())


end