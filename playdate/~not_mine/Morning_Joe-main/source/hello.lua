import "gamescene"
import "wordbubble"
import "randomhello"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('HelloText').extends(gfx.sprite)

function HelloText:init(CustomerName)
   
	HelloText.super.init(self)
    
    local hellomynameis = "Mornin' Joe!"

    
    
    local gameOverImage = gfx.image.new(gfx.getTextSize(hellomynameis))
    gfx.pushContext(gameOverImage)
        gfx.drawText(hellomynameis, 0, 0)
    gfx.popContext()
    
    
    self:setImage(gameOverImage)
    
    self:moveTo(180+self.width/2, 120)
    
    self:setZIndex(16)

    self:add()
    self.destruction = pd.timer.new(3000)
    WordBubble(true)
    RandomHello()


end

function HelloText:update()
    --print(self.destruction.currentTime)
    if self.destruction.currentTime == 3000 then
        self:remove()
    end
end

