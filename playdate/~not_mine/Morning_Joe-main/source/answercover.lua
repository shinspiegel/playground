
import "CoreLibs/sprites"
import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('AnswerCover').extends(gfx.sprite)

function AnswerCover:init()
    
    AnswerCover.super.init(self)

    local Dudeimage = gfx.image.new("images/AnswerCover")
    self:setImage(Dudeimage)
    
    
    
    
    self:moveTo(self.width/2, self.height/2)
    self.MyX = self.width/2
    self.MyY = self.height/2
    self:setZIndex(300)
    self:add()
    



end

function AnswerCover:update() 
    if ThisisCorrect == true then
        self.MyX = -80
    end
    self:moveTo(self.x+(self.MyX-self.x)/4,self.y+(self.MyY-self.y)/4)
end

    
    