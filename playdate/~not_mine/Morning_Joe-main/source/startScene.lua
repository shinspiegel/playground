import "gameScene"
import "startstore"



local pd <const> = playdate
local gfx <const> = playdate.graphics

class('StartScene').extends(gfx.sprite)

function StartScene:init()
	
    
    local backgroundImage = gfx.image.new("images/Menu_Attempt1")
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
			gfx.setClipRect(x, y, width, height)
			backgroundImage:draw(0,0)
			gfx.clearClipRect()
		end
	)
    StoreAnimation()
    Days = 0
    CustomerNumber = 0
    DrinksCorrect = 0
    CustomerOrder = {1,2,3,4,5,6}
    --local text = "This Will be the Start Screen"
    --local gameOverImage = gfx.image.new(gfx.getTextSize(text))
    --gfx.pushContext(gameOverImage)
    --    gfx.drawText(text, 0, 0)
    --gfx.popContext()
    --local gameOverSprite = gfx.sprite.new(gameOverImage)
    --gameOverSprite:moveTo(200, 120)
    --gameOverSprite:add()
    Solvedlist = {}
    TotalSolved = 0
    self:add()
    RandomizeFavorites()
    
    RandomizeOrder()

    RandomizeCustomers()

    
    if Finalmusic ~= nil then
        
        Finalmusic:stop()
        --print("stop start music")
    else
        Finalmusic = 	pd.sound.fileplayer.new("sounds/soundtrack_1")
        Finalmusic:setVolume(0.6)
    end

    if Startmusic ~= nil then
        
        Startmusic:stop()
        --print("stop start music")
    else
        Startmusic = 	pd.sound.fileplayer.new("sounds/playjam_soundtrack")
        Startmusic:setVolume(0.6)
    end
    if otherStartmusic ~= nil then
        
        otherStartmusic:play()
    else
        
        otherStartmusic = 	pd.sound.fileplayer.new("sounds/soundtrack")
        otherStartmusic:setVolume(1)
        otherStartmusic:play()
    end
    
end
function RandomizeCustomers()
    local a = 100
    local b = 100
    local c = 100
    local d = 100

    a = math.random(1,9)
    b = math.random(1,9)
    while b == a do
        b = math.random(1,9)
    end

    c = math.random(1,9)
    while c == a or c == b do
        c = math.random(1,9)
    end
    
    d = math.random(1,9)
    while d == a or d == b  or d == c do
        d = math.random(1,9)
    end
    customer1 = "images/Dude"
    customer2 = "images/Dude"
    customer3 = "images/Dude"
    customer4 = "images/Dude"

    if a == 1 then
        customer1 = "images/Viking"
    elseif a == 2 then
        customer1 = "images/Cowboy"
    elseif a == 3 then
        customer1 = "images/Scientist"
    elseif a == 4 then
        customer1 = "images/PrettyMan"
    elseif a == 5 then
        customer1 = "images/Stinkygirl"
    elseif a == 6 then
        customer1 = "images/Queen"
    elseif a == 7 then
        customer1 = "images/Astronauht"
    elseif a == 8 then
        customer1 = "images/ArtistGirl"
    elseif a == 9 then
        customer1 = "images/SkeleBbay"
    end

    if b == 1 then
        customer2 = "images/Viking"
    elseif b == 2 then
        customer2 = "images/Cowboy"
    elseif b == 3 then
        customer2 = "images/Scientist"
    elseif b == 4 then
        customer2 = "images/PrettyMan"
    elseif b == 5 then
        customer2 = "images/Stinkygirl"
    elseif b == 6 then
        customer2 = "images/Queen"
    elseif b == 7 then
        customer2 = "images/Astronauht"
    elseif b == 8 then
        customer2 = "images/ArtistGirl"
    elseif b == 9 then
        customer2 = "images/SkeleBbay"
    end


    if c == 1 then
        customer3 = "images/Viking"
    elseif c == 2 then
        customer3 = "images/Cowboy"
    elseif c == 3 then
        customer3 = "images/Scientist"
    elseif c == 4 then
        customer3 = "images/PrettyMan"
    elseif c == 5 then
        customer3 = "images/Stinkygirl"
    elseif c == 6 then
        customer3 = "images/Queen"
    elseif c == 7 then
        customer3 = "images/Astronauht"
    elseif c == 8 then
        customer3 = "images/ArtistGirl"
    elseif c == 9 then
        customer3 = "images/SkeleBbay"
    end


    if d == 1 then
        customer4 = "images/Viking"
    elseif d == 2 then
        customer4 = "images/Cowboy"
    elseif d == 3 then
        customer4 = "images/Scientist"
    elseif d == 4 then
        customer4 = "images/PrettyMan"
    elseif d == 5 then
        customer4 = "images/Stinkygirl"
    elseif d == 6 then
        customer4 = "images/Queen"
    elseif d == 7 then
        customer4 = "images/Astronauht"
    elseif d == 8 then
        customer4 = "images/ArtistGirl"
    elseif d == 9 then
        customer4 = "images/SkeleBbay"
    end



end
    

function RandomizeFavorites()
    --Woman
        
    local a = 100
    local b = 100
    local c = 100
    a = math.random(1,8)
    b = math.random(1,8)
    while b == a do
        b = math.random(1,8)
    end
    c = math.random(1,8)
    while c == a or c == b do
        c = math.random(1,8)
    end
    AnnaFavorites = {a, b, c}
    
    for i = 1,#AnnaFavorites do 
        --print("AnnaFavorites:"..AnnaFavorites[i])
    end
    
    local a = 100
    local b = 100
    local c = 100
    a = math.random(1,8)
    b = math.random(1,8)
    while b == a do
        b = math.random(1,8)
    end
    c = math.random(1,8)
    while c == a or c == b do
        c = math.random(1,8)
    end
    AbigailFavorites = {a, b, c}
    
    for i = 1,#AbigailFavorites do 
        --print("AbigailFavorites:"..AbigailFavorites[i])
    end
    --Men
    
    local a = 100
    local b = 100
    local c = 100
    a = math.random(1,8)
    b = math.random(1,8)
    while b == a do
        b = math.random(1,8)
    end
    c = math.random(1,8)
    while c == a or c == b do
        c = math.random(1,8)
    end
    GavinFavorites = {a, b, c}
    
    for i = 1,#GavinFavorites do 
        --print("GavinFavorites:"..GavinFavorites[i])
    end
    
    local a = 100
    local b = 100
    local c = 100
    a = math.random(1,8)
    b = math.random(1,8)
    while b == a do
        b = math.random(1,8)
    end
    c = math.random(1,8)
    while c == a or c == b do
        c = math.random(1,8)
    end
    JaiceFavorites = {a, b, c}
    
    for i = 1,#JaiceFavorites do 
        --print("JaiceFavorites:"..JaiceFavorites[i])
    end
    
end
function RandomizeOrder()
    
    local a = 100
    local b = 100
    local c = 100
    local d = 100

    a = math.random(1,4)

    b = math.random(1,4)
    while b == a do
        b = math.random(1,4)
    end

    c = math.random(1,4)
    while c == a or c == b do
        c = math.random(1,4)
    end
    
    d = math.random(1,4)
    while d == a or d == b  or d == c do
        d = math.random(1,4)
    end

    
    CustomerOrder = {a,b,c,d}

    
    for i = 1,#CustomerOrder do 
        --print(i, "CustomerOrder:"..CustomerOrder[i])
    end
end

function StartScene:update()
   
    if pd.buttonJustPressed(pd.kButtonA) then
        otherStartmusic:stop()
        Startmusic:play(0)
        SCENE_MANAGER:switchScene(GameScene)
        
        local mystartsound = 	pd.sound.fileplayer.new("sounds/Clickonsomethingstart")
        mystartsound:setVolume(1)
        mystartsound:play(1)

        
    end

end