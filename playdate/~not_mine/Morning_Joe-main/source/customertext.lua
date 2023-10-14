import "gamescene"


local pd <const> = playdate
local gfx <const> = playdate.graphics

class('CustomerText').extends(gfx.sprite)

function CustomerText:init(CustomerName)
   
	CustomerText.super.init(self)
    
    
    
    NumberCorrect = 0
    
   local gameOverImage = gfx.image.new(gfx.getTextSize(CustomerName))
    gfx.pushContext(gameOverImage)
        gfx.drawText(CustomerName, 0, 0)
    gfx.popContext()
    local FirstBulletTimer = pd.timer.performAfterDelay(300, function ()
        local whoppity = math.random(1,3)
        local swipesound = 	pd.sound.fileplayer.new("sounds/Talking_1")  
        if whoppity == 1 then
            swipesound = 	pd.sound.fileplayer.new("sounds/Talking_1")            
        end
        if whoppity == 2 then
            swipesound = 	pd.sound.fileplayer.new("sounds/Talking_2")            
        end
        
        if whoppity == 3 then
            swipesound = 	pd.sound.fileplayer.new("sounds/Talking_3")            
        end
        
        
        --swipesound:setVolume(0.1)
        swipesound:play(1)
    
		
		end)
    
    
    --self:setImage(gameOverImage)
    
    self:moveTo(398-(self.width)/2, 10)
    
    self:setZIndex(151)

    self:add()


end


