import "startScene"
import "credits"

import "closestore"


local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(text)
    Days = Days+1
    CustomerNumber = 0
    CloseStore()
    TotalSolved = TotalSolved+DrinksCorrect
    
    --print("DrinksCorrect:" ..DrinksCorrect)
    local text = "Broken"
    if TotalSolved == 4 then
        text = "Congrats!  It took you "..Days.." days to win."
        
        Startmusic:stop()
        for i = 1,3 do 
            Credits(i)
        end
        Finalmusic:play()
    else
        text = "Day "..Days..". You have made ".. TotalSolved .. " perfect drinks so far."
    end
    
    local gameOverImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(gameOverImage)
        gfx.drawText(text, 0, 0)
    gfx.popContext()
    local gameOverSprite = gfx.sprite.new(gameOverImage)
    gameOverSprite:moveTo(200, 20)
    gameOverSprite:add()

    self:add()
    --DrinksCorrect = 0
end

function GameOverScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        
        local mystartsound = 	pd.sound.fileplayer.new("sounds/Clickonsomethingstart")
        mystartsound:setVolume(1)
        mystartsound:play(1)

        if TotalSolved == 4 then
            SCENE_MANAGER:switchScene(StartScene)
        else
            DrinksCorrect = 0
            
            RandomizeOrder()
            SCENE_MANAGER:switchScene(GameScene)
        end
    end
end