import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local graphics <const> = playdate.graphics
local playerSprite = nil

function myGameSetUp()
    local playerImage = graphics.image.new("Images/image.png")
    assert(playerImage)           -- make sure the image was where we thought
    playerSprite = graphics.sprite.new(playerImage)
    playerSprite:moveTo(200, 120) -- this is where the center of the sprite is placed; (200,120) is the center of the Playdate screen
    playerSprite:add()            -- This is critical!
end

myGameSetUp()

function playdate.update()
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        playerSprite:moveBy(0, -2)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        playerSprite:moveBy(2, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        playerSprite:moveBy(0, 2)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        playerSprite:moveBy(-2, 0)
    end

    graphics.sprite.update()
    playdate.timer.updateTimers()
end
