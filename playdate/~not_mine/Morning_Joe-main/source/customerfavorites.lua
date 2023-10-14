import "gamescene"


local pd <const> = playdate
local gfx <const> = playdate.graphics

class('CustomerFavorites').extends(gfx.sprite)

function CustomerFavorites:init(CustomerName,place)
    --print("CustomerFavorites:place: "..place)
    --print("CustomerFavorites:CustomerName: "..CustomerName)
	CustomerFavorites.super.init(self)
    Favorites = {}
    
    if CustomerName == 2 then
        for i = 1, 3 do
            Favorites[i] = AnnaFavorites[i]
            --print("CustomerFavorites:AnnaFavorites: "..Favorites[i])
        end
    end
    if CustomerName == 1 then
        
        for i = 1, 3 do
            Favorites[i] = AbigailFavorites[i]
            --print("CustomerFavorites:AbigailFavorites: "..Favorites[i])
        end
        
    end
    if CustomerName == 4 then
        
        for i = 1, 3 do
            Favorites[i] = GavinFavorites[i]
            --print("CustomerFavorites:GavinFavorites: "..Favorites[i])
        end
    end
    if CustomerName == 3 then
        
        for i = 1, 3 do
            Favorites[i] = JaiceFavorites[i]
            --print("CustomerFavorites:JaiceFavorites: "..Favorites[i])
        end
    end

     
    -- for i = 1, 3 do
    --      print("Favorites[i]: "..Favorites[i])
    --  end
    
    local cardImage = gfx.image.new("images/Chocolate_Small_SMALL")

    if Favorites[place] == 1 then
        cardImage = gfx.image.new("images/Chocolate_Small_SMALL")
    elseif Favorites[place] == 2 then
        cardImage = gfx.image.new("images/Vanilla_Small_SMALL")
    elseif Favorites[place] == 3 then
        cardImage = gfx.image.new("images/Honey_Small_SMALL")
    elseif Favorites[place] == 4 then
        cardImage = gfx.image.new("images/Milk_Small_SMALL")
    elseif Favorites[place] == 5 then
        cardImage = gfx.image.new("images/Pistachio_Small_SMALL")
    elseif Favorites[place] == 6 then
        cardImage = gfx.image.new("images/Cinnamon_Small_SMALL")
    elseif Favorites[place] == 7 then
        cardImage = gfx.image.new("images/Caramel_Small_SMALL")
    elseif Favorites[place] == 8 then
        cardImage = gfx.image.new("images/CondensedMilk_Small_SMALL")
    end
    
    
    self:setImage(cardImage)
    
    self:moveTo(26+48*(place-1), 21)
    
    self:setZIndex(10)

    self:add()


end


