
import "CoreLibs/sprites"
import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Card').extends(gfx.sprite)

function Card:init(place)
    Card.super.init(self)

    --print("Card.  place:"..place)

    local cardImage = gfx.image.new("images/Chocolate_Small")
    if place == 1 then
        cardImage = gfx.image.new("images/Chocolate_Small")
    elseif place == 2 then
        cardImage = gfx.image.new("images/Vanilla_Small")
    elseif place == 3 then
        cardImage = gfx.image.new("images/Honey_Small")
    elseif place == 4 then
        cardImage = gfx.image.new("images/Milk_Small")
    elseif place == 5 then
        cardImage = gfx.image.new("images/Pistachio_Small")
    elseif place == 6 then
        cardImage = gfx.image.new("images/Cinnamon_Small")
    elseif place == 7 then
        cardImage = gfx.image.new("images/Caramel_Small")
    elseif place == 8 then
        cardImage = gfx.image.new("images/CondensedMilk_Small")
    end
    
    self:setImage(cardImage)
    

    
    
    self:moveTo(25+(50*(place-1)),200)

    self.MyX = self.x
    
    self.MyY = self.Y

    self:setZIndex(150)
    
    self:add()
    self.spot = place

   
   

end


function Card:update()
    
    if SelectionArray[1] == self.spot then
        --self.MyX = 130
        self.MyY = 280 
        
    self:setZIndex(200)
    elseif SelectionArray[2] == self.spot then
        --self.MyX = 180
        self.MyY = 280 
        
    self:setZIndex(200)
    elseif SelectionArray[3] == self.spot then
        --self.MyX = 230
        self.MyY = 280 
        
    self:setZIndex(200)
    else
        if self.spot == currentingrident then
            self.MyX = 25+(50*(self.spot-1))
            self.MyY = 180 
        else
            self.MyX = 25+(50*(self.spot-1))
            self.MyY = 195 
        end

        if #SelectionArray > 2 then
            self.MyY = 280
        end
    end

    
    
    self:moveTo(self.x+(self.MyX-self.x)/2,self.y+(self.MyY-self.y)/2)
end
    
    