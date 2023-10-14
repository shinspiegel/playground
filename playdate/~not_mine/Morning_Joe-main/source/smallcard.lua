
import "CoreLibs/sprites"
import "gameScene"
import "addicon"

import "customerfavorites"


local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Finalcard').extends(gfx.sprite)

function Finalcard:init(myID)
    Finalcard.super.init(self)
   

    local cardImage = gfx.image.new("images/Chocolate_Small_SMALL")
    if SelectionArray[myID] == 1 then
        cardImage = gfx.image.new("images/Chocolate_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 1 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 1 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 2 then
        cardImage = gfx.image.new("images/Vanilla_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 2 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 2 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 3 then
        cardImage = gfx.image.new("images/Honey_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 3 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 3 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 4 then
        cardImage = gfx.image.new("images/Milk_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 4 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 4 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 5 then
        cardImage = gfx.image.new("images/Pistachio_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 5 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 5 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 6 then
        cardImage = gfx.image.new("images/Cinnamon_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 6 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 6 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 7 then
        cardImage = gfx.image.new("images/Caramel_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 7 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 7 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    elseif SelectionArray[myID] == 8 then
        cardImage = gfx.image.new("images/CondensedMilk_Small_SMALL")
        local testingtext = "bad"
        
        
        for i = 1,3 do 
            
            if Favorites[i] == 8 then
                testingtext = "good"
        
            end
        end
        
        
        if Favorites[myID] == 8 then
            testingtext = "great"
        end

        Addicon(myID, testingtext)
    end
    
    self:setImage(cardImage)
    

    
    
    self:moveTo(2+48*(myID-1),74)

    self.MyX = 26+48*(myID-1)
    
    self.MyY = self.Y

    self:setZIndex(20)
    
    self:add()
   
   

end


function Finalcard:update()
    
    
    self:moveTo(self.x+(self.MyX-self.x)/2,74)
end
    
    