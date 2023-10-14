import "gameOverScene"
import "card"
import "drinkBar"

import "startScene"

import "answercover"
import "customer"
import "customerfavorites"

import "customerdialouge"
import "bigCard"


import "table"
import "hello"
import "ingridenttext"

import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    CustomerNumber = CustomerNumber+1
    HelloText()
    Table()

    local backgroundImage = gfx.image.new("images/BackgrounWithchairsandTablesd")
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
			gfx.setClipRect(x, y, width, height)
			backgroundImage:draw(0,0)
			gfx.clearClipRect()
		end
	)

    backsound = 	pd.sound.fileplayer.new("sounds/cafe_enviroment_sound")
    backsound:setVolume(0.1)
    backsound:play(0)


    NumberCorrect = 0
    Nomoreinput = false
    crankinstruction = false
	GameScene.super.init(self)
    currentingrident = 1
    SelectionArray = {0}
    AnswerCover()
    

    self:add()
    self.currentpick = 1
    self.drinkmade = false
    MyMax = 8
    CreateDecks(MyMax)
    
    for i = 1,#Solvedlist do 
        if Solvedlist[i] == CustomerOrder[#CustomerOrder] then
            table.remove(CustomerOrder, #CustomerOrder)
        end
    end


    IngridentText(currentingrident)
    DrinkBar()
    --print("CustomerOrder[#CustomerOrder]")
    --print(CustomerOrder[#CustomerOrder])
    Whom = CustomerOrder[#CustomerOrder]
    Customer(CustomerOrder[#CustomerOrder])

    table.remove(CustomerOrder, #CustomerOrder)
    
    CreateFavorites(Whom)
    ThisisCorrect = false
    self.done = false

end

function CreateFavorites(CustomerID) 
    for i = 1,3 do 
        CustomerFavorites(CustomerID,i) 
    end
end

function CreateDecks(Max) 
    for i = 1,Max do 
        Card(i) 
    end
end

function Ingrident(NewValue) 
    currentingrident = currentingrident + NewValue
    
    if currentingrident > MyMax then
        currentingrident = 1
    elseif currentingrident < 1 then
        currentingrident = MyMax
    end

    while currentingrident == SelectionArray[1] or currentingrident == SelectionArray[2] or currentingrident == SelectionArray[3] do
        currentingrident = currentingrident + NewValue
        
        if currentingrident > MyMax then
            currentingrident = 1
        elseif currentingrident < 1 then
            currentingrident = MyMax
        end
    end 

    --print("Ingrident:"..currentingrident)
    if #SelectionArray < 3 then
        
        IngridentText(currentingrident)
    end
    
end


-- function SelectThis() 
        
-- end


function GameScene:update()

   
    if pd.buttonJustPressed(pd.kButtonRight) then
        Ingrident(1)
        
        local swipesound = 	pd.sound.fileplayer.new("sounds/Slide")
        swipesound:setVolume(0.2)
        swipesound:play(1)
    end

    if pd.buttonJustPressed(pd.kButtonLeft) then
        Ingrident(-1)
        
        local swipesound = 	pd.sound.fileplayer.new("sounds/Slide")
        swipesound:setVolume(0.2)
        swipesound:play(1)
    end
    --add drink made

    if Nomoreinput == true then
        if Whom == 1 then
            if AbigailFavorites[1] == SelectionArray[1] and AbigailFavorites[2] == SelectionArray[2] and AbigailFavorites[3] == SelectionArray[3] then
                
                ThisisCorrect = true
            end
        elseif Whom == 2 then
        
            if AnnaFavorites[1] == SelectionArray[1] and AnnaFavorites[2] == SelectionArray[2] and AnnaFavorites[3] == SelectionArray[3] then
                
                ThisisCorrect = true
            end
        elseif Whom == 3 then
            if JaiceFavorites[1] == SelectionArray[1] and JaiceFavorites[2] == SelectionArray[2] and JaiceFavorites[3] == SelectionArray[3] then
                
                ThisisCorrect = true
            end
            
        elseif Whom == 4 then
        
            if GavinFavorites[1] == SelectionArray[1] and GavinFavorites[2] == SelectionArray[2] and GavinFavorites[3] == SelectionArray[3] then
                
                ThisisCorrect = true
            end
        
        end
    end
    if pd.buttonJustPressed(pd.kButtonA) and Nomoreinput == true and self.done == false then
       
        local mystartsound = 	pd.sound.fileplayer.new("sounds/Clickonsomethingstart")
        mystartsound:setVolume(1)
        mystartsound:play(1)

        self.drinkmade = true 
        crankinstruction = false
        
        if Whom == 1 then
            --print("Check AbigailFavorites")
            if AbigailFavorites[1] == SelectionArray[1] and AbigailFavorites[2] == SelectionArray[2] and AbigailFavorites[3] == SelectionArray[3] then
                DrinksCorrect = DrinksCorrect + 1
                ThisisCorrect = true
                table.insert(Solvedlist, Whom)

            end
        elseif Whom == 2 then
            --print("Check AnnaFavorites")
            if AnnaFavorites[1] == SelectionArray[1] and AnnaFavorites[2] == SelectionArray[2] and AnnaFavorites[3] == SelectionArray[3] then
                DrinksCorrect = DrinksCorrect + 1
                ThisisCorrect = true
                table.insert(Solvedlist, Whom)
            end
        elseif Whom == 3 then
            --print("Check JaiceFavorites")
            if JaiceFavorites[1] == SelectionArray[1] and JaiceFavorites[2] == SelectionArray[2] and JaiceFavorites[3] == SelectionArray[3] then
                DrinksCorrect = DrinksCorrect + 1
                ThisisCorrect = true
                table.insert(Solvedlist, Whom)
            end
        elseif Whom == 4 then
            --print("Check GavinFavorites")
            if GavinFavorites[1] == SelectionArray[1] and GavinFavorites[2] == SelectionArray[2] and GavinFavorites[3] == SelectionArray[3] then
                DrinksCorrect = DrinksCorrect + 1
                ThisisCorrect = true
                table.insert(Solvedlist, Whom)
            end
        end
        -- if AnnaFavorites[1] == SelectionArray[1] and AnnaFavorites[2] == SelectionArray[2] and AnnaFavorites[3] == SelectionArray[3] then
        --     DrinksCorrect = DrinksCorrect + 1
        -- end


        --print("DrinksCorrect:" ..DrinksCorrect)
        
        
        if CustomerNumber == 4-TotalSolved then
            SCENE_MANAGER:switchScene(GameOverScene)
            backsound:stop()
            self.done = true
        else
            backsound:stop()
            SCENE_MANAGER:switchScene(GameScene)
            self.done = true
        end
       
    end

    if pd.buttonJustPressed(pd.kButtonA) and self.currentpick < 4 then
        --SCENE_MANAGER:switchScene(GameOverScene)
        SelectionArray[self.currentpick] = currentingrident
        
        BigCard(#SelectionArray+1, currentingrident)
        
        local swipesound = 	pd.sound.fileplayer.new("sounds/Swipe")
        swipesound:setVolume(0.8)
        swipesound:play(1)
        
        for i = 1,#SelectionArray do 
            --print("SelectionArray:"..SelectionArray[i])
        end
        self.currentpick = self.currentpick + 1
        Ingrident(1)


    end
    
    
    
    if pd.buttonJustPressed(pd.kButtonB) and self.currentpick > 1 and Nomoreinput == false then
        self.currentpick = self.currentpick - 1

        table.remove(SelectionArray,self.currentpick)

        
        for i = 1,#SelectionArray do 
            --print("SelectionArray:"..SelectionArray[i])
        end
        local swipesound = 	pd.sound.fileplayer.new("sounds/Swipe")
            --platformlanding:setVolume(0.01)
            swipesound:play(1)


    end
    if #SelectionArray == 3 and self.drinkmade == false  and Nomoreinput == false then
        crankinstruction = true
        local currentcranks = pd.getCrankTicks(36)
        --print("currentcranks: "..currentcranks)
        DrinkBarIncrease(currentcranks)
    else
        crankinstruction = false
    end
    
    
    
end