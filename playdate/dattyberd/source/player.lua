import "bullet"

local pd <const> = playdate
local gfx <const> = playdate.graphics


class("Player").extends(gfx.sprite)

function Player:init(x, y)
    local playerImage = gfx.image.new("system_assets/player")
    self:setImage(playerImage)
    self:moveTo(x, y)
    self:add()

    self.speed = 6
    self.height = 16
end

function Player:update()
    if pd.buttonIsPressed(pd.kButtonUp) and self.y > 0 + self.height then
        self:moveBy(0, -self.speed)
    end

    if pd.buttonIsPressed(pd.kButtonDown) and self.y < 240 - self.height then
        self:moveBy(0, self.speed)
    end

    if pd.buttonJustPressed(pd.kButtonA) then
        Bullet(self.x, self.y, 5)
    end
end
