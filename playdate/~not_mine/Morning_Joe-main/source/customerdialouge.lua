import "gamescene"
import "startscene"

import "customer"
import "wordbubble"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('CustomerDialouge').extends(gfx.sprite)

function CustomerDialouge:init(Myindex)
    
   
    Nomoreinput = true
	CustomerDialouge.super.init(self)
    local flavor = "broken"

    WordBubble(false)

    if SelectionArray[Myindex] == 1 then
        flavor = "Chocolate"
    elseif SelectionArray[Myindex] == 2 then
        flavor = "Vanilla"
    elseif SelectionArray[Myindex] == 3 then
        flavor = "Honey"
    elseif SelectionArray[Myindex] == 4 then
        flavor = "Milk"
    elseif SelectionArray[Myindex] == 5 then
        flavor = "Pistachio"
    elseif SelectionArray[Myindex] == 6 then
        flavor = "Cinnamon"
    elseif SelectionArray[Myindex] == 7 then
        flavor = "Caramel"
    elseif SelectionArray[Myindex] == 8 then
        flavor = "Sweet Milk"
    else
        flavor = "broken code"
    end
    --print("flavor: "..flavor)
    

    local text = "I hate "..flavor.."."
    
          
    if Whom == 2 then
        --print("State AnnaFavorites")
        for i = 1,3 do 
            if AnnaFavorites[i] == SelectionArray[Myindex] then
                text = flavor.." better elsewhere."
            end        
        end
        
        if AnnaFavorites[Myindex] == SelectionArray[Myindex] then
            text = "The "..flavor.." is perfect."
        
        end
        
        
        
    elseif Whom == 1 then
        --print("State AbigailFavorites")
        for i = 1,3 do 
            if AbigailFavorites[i] == SelectionArray[Myindex] then
                text = flavor.." better elsewhere."
            end        
        end
        
        if AbigailFavorites[Myindex] == SelectionArray[Myindex] then
            text = "The "..flavor.." is perfect."
        
        end
        
    elseif Whom == 4 then
        --print("State GavinFavorites")
        for i = 1,3 do 
            if GavinFavorites[i] == SelectionArray[Myindex] then
                text = flavor.." better elsewhere."
            end        
        end
        
        if GavinFavorites[Myindex] == SelectionArray[Myindex] then
            text = flavor.." is perfect."
        
        end
       
    elseif Whom == 3 then
        --print("State JaiceFavorites")
        for i = 1,3 do 
            if JaiceFavorites[i] == SelectionArray[Myindex] then
                text = flavor.." better elsewhere."
            end        
        end
        
        if JaiceFavorites[Myindex] == SelectionArray[Myindex] then
           
            
            
            text = "The "..flavor.." is perfect."
        
        end
    
    end

    
    
   local gameOverImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(gameOverImage)
        gfx.drawText(text, 0, 0)
    gfx.popContext()
    
    
    self:setImage(gameOverImage)
    if Myindex == 1 then
        self:moveTo(172+self.width/2, 112)
    end
    if Myindex == 2 then
        self:moveTo(172+self.width/2, 132)
    end
    if Myindex == 3 then
        self:moveTo(172+self.width/2, 152)
    end
    
    self:setZIndex(151)

    self:add()


end


