local pd <const> = playdate
local gfx <const> = playdate.graphics


class("Bullet").extends(gfx.sprite)

function Bullet:init(x, y, speed)
    local bulletSize = 4

    local img = gfx.image.new(bulletSize * 2, bulletSize * 2)

    gfx.pushContext(img)
    gfx.drawCircleAtPoint(bulletSize, bulletSize, bulletSize)
    gfx.popContext()

    self:setImage(img)
    self:setCollideRect(0, 0, self:getSize())

    self.speed = speed
    self:moveTo(x, y)
    self:add()
end

function Bullet:update()
    self:moveWithCollisions(self.x + self.speed, self.y)
end
