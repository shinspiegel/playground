import "gamescene"
import "wordbubble"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('RandomHello').extends(gfx.sprite)

function RandomHello:init(CustomerName)
   
	RandomHello.super.init(self)
    local whoppity = math.random(1,6)
    local hellomynameis = "Lovely weather today."
    if whoppity == 1 then
        hellomynameis = "Lovely weather today."
    end
    if whoppity == 2 then
        hellomynameis = "Give me a cup of your finest."
    end
    
    if whoppity == 3 then
        hellomynameis = "Always a pleasure."
    end
    
    if whoppity == 4 then
        hellomynameis = "No sleeping in for me today!"
    end
    
    if whoppity == 5 then
        hellomynameis = "Did you get a haircut?"
    end

    
    if whoppity == 6 then
        hellomynameis = "You look extra happy today."
    end

    local gameOverImage = gfx.image.new(gfx.getTextSize(hellomynameis))
    gfx.pushContext(gameOverImage)
        gfx.drawText(hellomynameis, 0, 0)
    gfx.popContext()
    
    
    self:setImage(gameOverImage)
    
    self:moveTo(180+self.width/2, 140)
    
    self:setZIndex(16)

    self:add()
    self.destruction = pd.timer.new(3000)
    

end

function RandomHello:update()
    --print(self.destruction.currentTime)
    if self.destruction.currentTime == 3000 then
        self:remove()
    end
end

