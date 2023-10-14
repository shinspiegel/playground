
import "CoreLibs/sprites"
import "gameScene"
import "customer"
import "finalDrink"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('DrinkBar').extends(gfx.sprite)

function DrinkBar:init()
    DrinkBar.super.init(self)
    DrinkBarsLength = 1

    self:moveTo(100+DrinkBarsLength/2, 100)
    
    local RectImage = gfx.image.new(DrinkBarsLength, 6)
    gfx.pushContext(RectImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, DrinkBarsLength, 6)
    gfx.popContext()
    self:setImage(RectImage)
    self:add()
    self.donebefore = false

end


function DrinkBarIncrease(Addition)
    DrinkBarsLength = DrinkBarsLength + math.abs(Addition)

    if math.abs(Addition) > 0 then
        local whoppity = math.random(1,3)
        local swipesound = 	pd.sound.fileplayer.new("sounds/CrankingSound_1")  
        if whoppity == 1 then
            swipesound = 	pd.sound.fileplayer.new("sounds/CrankingSound_1")            
        end
        if whoppity == 2 then
            swipesound = 	pd.sound.fileplayer.new("sounds/CrankingSound_2")            
        end
        
        if whoppity == 3 then
            swipesound = 	pd.sound.fileplayer.new("sounds/CrankingSound_3")            
        end
        
        
        swipesound:setVolume(0.1)
        swipesound:play(1)
    end
    if DrinkBarsLength < 1 then
        DrinkBarsLength = 1
    end
end

function DrinkBar:update()
    
   
    local RectImage = gfx.image.new(DrinkBarsLength, 6)
    gfx.pushContext(RectImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, DrinkBarsLength, 6)
    gfx.popContext()
    self:setImage(RectImage)

    if DrinkBarsLength > 159 then
        DrinkBarsLength = 160
        TasteDrink()
    end
    if DrinkBarsLength==1 then
        self:moveTo(500, 500)
    else
        self:moveTo(100+DrinkBarsLength/2, 130)
    end

    if DrinkBarsLength > 159 and self.donebefore == false then
        DrinkBarsLength = 160
        FinalDrink()
        TasteDrink()
        self.donebefore = true
    end

    if pd.buttonJustPressed(pd.kButtonB) then
        DrinkBarsLength = 1
    end


end
    
    