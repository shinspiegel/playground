
import "CoreLibs/sprites"
import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('BigCard').extends(gfx.sprite)

function BigCard:init(MyLocation, place)
    BigCard.super.init(self)
    --print("MyLocation:" ..MyLocation)
    --print("place:" ..place)

    local cardImage = gfx.image.new("images/Chocolate_Big")

    if place == 1 then
        cardImage = gfx.image.new("images/Chocolate_Big")
    elseif place == 2 then
        cardImage = gfx.image.new("images/Vanilla_Big")
    elseif place == 3 then
        cardImage = gfx.image.new("images/Honey_Big")
    elseif place == 4 then
        cardImage = gfx.image.new("images/Milk_Big")
    elseif place == 5 then
        cardImage = gfx.image.new("images/Pistachio_Big")
    elseif place == 6 then
        cardImage = gfx.image.new("images/Cinnamon_Big")
    elseif place == 7 then
        cardImage = gfx.image.new("images/Caramel_Big")
    elseif place == 8 then
        cardImage = gfx.image.new("images/CondensedMilk_Big")
    end
    
    self:setImage(cardImage)
    

    
    
    
    self:moveTo(25+(50*(place-1)),180)

    self.MyX = ((MyLocation-1)*64)-30
    
    self.MyY = 110

    self:setZIndex(150-MyLocation)
    
    self:add()
    self.spot = place
    
    self.newspot = MyLocation-1
    --print("self.newspot"..self.newspot)

   
   

end

function BigCard:update()
    if DrinkBarsLength < 160 then
        if self.newspot == 1 then
            self.MyX = ((self.newspot-1)*64)+32+(DrinkBarsLength/100*40)
        elseif self.newspot == 3 then
            self.MyX = ((self.newspot-1)*64)+32-(DrinkBarsLength/100*40)
        end
    else
        self:remove()
    
    end
   if #SelectionArray ~= nil then
        if self.newspot > #SelectionArray then
            self:remove()
        end
   end
    
    
    self:moveTo(self.x+(self.MyX-self.x)/2,self.y+(self.MyY-self.y)/2)
end
    
    