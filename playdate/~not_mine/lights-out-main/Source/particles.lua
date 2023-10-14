local gfx <const> = playdate.graphics

local fireflies = {}
local hanglights = {}

local imgLight = gfx.image.new("gfx/hanglight")

local sins <const> = math.sin
local coss <const> = math.cos
local rads <const> = math.rad

function createFireflies(amnt, _size)
    amnt = amnt or 20
    _size = _size or 15
    for i = 1, amnt do
        local dir = math.random(0,359)
        local firefly = {
            x = math.random(0,200),
            y = math.random(0,120),
            aniOffset = math.random(0,200)/100,
            dx = math.sin(dir),
            dy = -math.cos(dir),
            size = _size
        }
        fireflies[#fireflies+1] = firefly
    end
end

function updateFireflies()
    for i = 1, #fireflies do
        local ffly = fireflies[i]
        gfx.fillCircleAtPoint(ffly.x,ffly.y,math.sin(playdate.getElapsedTime()+ffly.aniOffset)*2+ffly.size)
        ffly.x += ffly.dx * 0.5
        ffly.y += ffly.dy * 0.5

        if ffly.x > 235 then ffly.x = -30 elseif ffly.x < -30 then ffly.x = 235 end
        if ffly.y > 145 then ffly.y = -30 elseif ffly.y < -30 then ffly.y = 145 end
    end
end

function killFireflies()
    fireflies = {}
end

class("Hanglight").extends()

function Hanglight:init(x,y,min,max, time, wid)
    self.x = x * 2
    self.y = y
    self.wid = wid
    self.time = time
    self.min = min
    self.max = max
    self.amount = max-min
    self.animator = gfx.animator.new(time, min, max,  playdate.easingFunctions.inOutQuad)
    self.toMax = true
    hanglights[#hanglights+1] = self
end

function Hanglight:drawBeam()
    local rad = rads(self.animator:currentValue())
    local sin = sins(rad)*self.amount
    gfx.fillTriangle(self.x,self.y*2,self.x+20*self.wid - sin, 200, self.x-20*self.wid - sin,200)
    if self.animator:ended() then
        self.toMax = not self.toMax
        if self.toMax then self.animator = gfx.animator.new(self.time, self.min, self.max,  playdate.easingFunctions.inOutSine) else self.animator = gfx.animator.new(self.time,self.max,self.min,  playdate.easingFunctions.inOutSine) end
    end
end
function Hanglight:drawLight()
    imgLight:drawCentered(self.x/2,self.y)
end

function updateBeams()
    for i = 1, #hanglights do
        local l = hanglights[i]
        l:drawBeam()
    end
end 

function rmLights()
    for i = 1, #hanglights do
        table.remove( hanglights)
    end
end

function updateLights()
    for i = 1, #hanglights do
        local l = hanglights[i]
        l:drawLight()
    end
end

function killAll()
    rmLights()
    curBG:remove()
end