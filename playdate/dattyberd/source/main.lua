import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"

import "circle"

local pd <const> = playdate
local gfx <const> = playdate.graphics


function playdate.update()
    playdate.drawFPS(0, 0)
    gfx.sprite.update()

    local c = Circle(200, 100, 20)
    c:add()
end
