import "CoreLibs/graphics"
import "CoreLibs/math"
import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/animator"
import "particles.lua"
import "levels.lua"
import "pdParticles.lua"
import "transition.lua"

local gfx <const> = playdate.graphics

playdate.display.setScale(2)
--playdate.display.setRefreshRate(25)

local imgOverlay = gfx.image.new(240,160,gfx.kColorBlack)

-- 1,2,3,4 yawn    5,6 dance    7,8,9,10 walk    11,12 flying
local tabPlayer = gfx.imagetable.new("gfx/player/goober")
local tabPlayerFace = gfx.imagetable.new("gfx/player/gooberFace")

local playing = true

sprPlayer = gfx.sprite.new(tabPlayer[5])
sprPlayer.frame = 5
sprPlayer.counter = 0
sprPlayer.velocity = {x=0,y=0}
sprPlayer.onFloor = false
sprPlayer.lastFloor = false
sprPlayer.flipped = gfx.kImageUnflipped
sprPlayer:moveTo(100,50)
sprPlayer:add()
sprPlayer:setCollideRect(1,4,10,10)

gfx.sprite.addEmptyCollisionSprite(-10,-10,10,130)

local sJump = playdate.sound.sampleplayer.new("sfx/jump")
local sHurt = playdate.sound.sampleplayer.new("sfx/hurt")

local imgGN = gfx.image.new("gfx/gn")

local pHurt = ParticleCircle(200,120)
pHurt:setSize(5,7)
pHurt:setMode(Particles.modes.DECAY)
pHurt:setSpeed(1,4)
debug = false
playdate.getSystemMenu():addCheckmarkMenuItem("Light Mode", false, function(value) playdate.display.setInverted(value) end)
playdate.getSystemMenu():addCheckmarkMenuItem("Show FPS", false, function(value) debug = value end)
playdate.getSystemMenu():addMenuItem("By PossiblyAx", function() print("https://possiblyaxolotl.itch.io") end)

--createFireflies()

mus = playdate.sound.fileplayer.new("sfx/eepy")
mus:play(0)
local sEnd = playdate.sound.sampleplayer.new("sfx/end")

sgn = false

--transitionTo(function() print("done") end)
function playdate.update()
    sprPlayer.counter += 1
    sprPlayer.velocity.y += 0.4

    if not sprPlayer.onFloor and playing then
        if sprPlayer.counter <= 4 and sprPlayer.frame ~= 11 then
            sprPlayer:setImage(tabPlayer[11])
        elseif sprPlayer.counter <= 8 and sprPlayer.frame ~= 12 then
            sprPlayer:setImage(tabPlayer[12])
        else
            sprPlayer.counter = 1
            sprPlayer:setImage(tabPlayer[11])
        end
    end

    sprPlayer:moveBy(0,sprPlayer.velocity.y)
    sprPlayer.onFloor = false
    if #sprPlayer:overlappingSprites() > 0 then
        while #sprPlayer:overlappingSprites() > 0 do
            local by = -sign(sprPlayer.velocity.y)
            sprPlayer:moveBy(0,by)
            sprPlayer.onFloor = true
        end
        sprPlayer.velocity.y = 2
    end
    if playdate.buttonJustPressed(playdate.kButtonA) and sprPlayer.onFloor and playing then
        sprPlayer.velocity.y = -4
        sprPlayer.lastFloor = false
        sprPlayer.onFloor = false
        sJump:play()
    elseif sprPlayer.lastFloor ~= sprPlayer.onFloor then sprPlayer.velocity.y = 0 end

    if playdate.buttonIsPressed(playdate.kButtonLeft) and playing then
        sprPlayer.velocity.x = -1
        sprPlayer.flipped = gfx.kImageFlippedX
    elseif playdate.buttonIsPressed(playdate.kButtonRight) and playing then
        sprPlayer.velocity.x = 1
        sprPlayer.flipped = gfx.kImageUnflipped
    else
        sprPlayer.velocity.x = playdate.math.lerp(sprPlayer.velocity.x,0,0.2)
    end

    if sprPlayer.x > 204 then
        transitionTo(nextLevel)
        sprPlayer:moveTo(-10,-1000)     
    elseif sprPlayer.y > 120 then
        transitionTo(reLevel)
        pHurt:moveTo(sprPlayer.x,120)
        sprPlayer:moveTo(-10,-1000)
        sHurt:play()
        pHurt:add(25)
    end

    if sprPlayer.onFloor then
        sprPlayer:moveBy(sprPlayer.velocity.x,0)
    else
        sprPlayer:moveBy(sprPlayer.velocity.x * 1.25,0)
    end
    if #sprPlayer:overlappingSprites() > 0 then
        while #sprPlayer:overlappingSprites() > 0 do
            local by = -sign(sprPlayer.velocity.x)
            sprPlayer:moveBy(by,0)
            sprPlayer.onFloor = true
        end
    end

    if sprPlayer.onFloor and playing then
        if sprPlayer.velocity.x < 0.5 and sprPlayer.velocity.x > -0.5 then
            if sprPlayer.counter <= 10 then
                sprPlayer:setImage(tabPlayer[5])
            elseif sprPlayer.counter <= 20 then
                sprPlayer:setImage(tabPlayer[6])
            else
                sprPlayer.counter = 1
            end
        else
            if sprPlayer.counter <= 4 then
                sprPlayer:setImage(tabPlayer[7])
            elseif sprPlayer.counter <= 8 then
                sprPlayer:setImage(tabPlayer[8])
            elseif sprPlayer.counter <= 12 then
                sprPlayer:setImage(tabPlayer[9])
            elseif sprPlayer.counter <= 16 then
                sprPlayer:setImage(tabPlayer[10])
            else
                sprPlayer.counter = 1
            end
        end
    end

    if level > 4 and sprPlayer.x > 165 and playing == true then
        playing = false
        mus:stop()
        sprPlayer:setImage(tabPlayer[1])
        playdate.timer.new(1000,function() sprPlayer:setImage(tabPlayer[2]) playdate.timer.new(1000,function() sprPlayer:setImage(tabPlayer[3]) playdate.timer.new(1000,function() sprPlayer:setImage(tabPlayer[2]) playdate.timer.new(1000,function() sprPlayer:setImage(tabPlayer[1]) playdate.timer.new(3000,function() sprPlayer:setVisible(false) killAll() sgn = true --[[createFireflies()]] sEnd:play() end) end) end) end) end)
    end
    
    gfx.clear()
    
    gfx.pushContext(imgOverlay)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0,0,400,240)
    gfx.setColor(gfx.kColorWhite)
    --gfx.fillRect(5,5,50,50)
    updateFireflies()
    updateBeams()
    gfx.setColor(gfx.kColorBlack)
    updateTransition()
    gfx.popContext()

    sprPlayer.lastFloor = sprPlayer.onFloor

    sprPlayer:setImageFlip(sprPlayer.flipped)
    gfx.sprite.update()

    gfx.setImageDrawMode(gfx.kDrawModeWhiteTransparent)
    imgOverlay:drawBlurred(-20,-20,3,2,gfx.image.kDitherTypeBayer2x2)
    --imgOverlay:draw(-20,-20)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    --updateLights()

    if sgn then
        imgGN:drawCentered(100,60)
    end

    if debug then
    playdate.drawFPS(0,0)
    end
    playdate.timer.updateTimers()
    pHurt:update()
    --tabPlayerFace[sprPlayer.frame]:drawCentered(sprPlayer.x,sprPlayer.y-1)
end