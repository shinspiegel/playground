import "gamescene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('IngridentText').extends(gfx.sprite)

function IngridentText:init(ingridentnumber)
   
	IngridentText.super.init(self)
    self.ingridentname = ingridentnumber
    local text = "Not working"
    
    
    if ingridentnumber == 1 then 
        
        text = "Chocolate"
    elseif ingridentnumber == 2 then 
        
        text = "Vanilla"
    elseif ingridentnumber == 3 then 
        
        text = "Honey"
    elseif ingridentnumber == 4 then 
        
        text = "Milk"
    elseif ingridentnumber == 5 then 
        
        text = "Pistachio"
    elseif ingridentnumber == 6 then 
        
        text = "Cinnamon"
    elseif ingridentnumber == 7 then 
        
        text = "Caramel"
    elseif ingridentnumber == 8 then 
        
        text = "Sweet Milk"
    end
    
   local gameOverImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(gameOverImage)
        gfx.drawText(text, 0, 0)
    gfx.popContext()
    
    
    self:setImage(gameOverImage)
    
    self:moveTo(200, 230)
    
    self:setZIndex(151)

    self:add()


end




function IngridentText:update()
    if currentingrident ~= self.ingridentname then
        self:remove()
    end
    if #SelectionArray > 2 then
        self:remove() 
    end 
   
end