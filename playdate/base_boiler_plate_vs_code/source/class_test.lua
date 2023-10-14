import 'CoreLibs/object'

class('Dog').extends()
class('Golden').extends(Dog)

-- function Golden:init(age, height)
--     Golden.super.init(self, age)
--     self.height = height
-- end

function Dog:bark()
    print("Bark!")
end


-- oakInstance = Golden(age, height)

-- print(oakInstance.className) -- equals 'Oak'

-- print(oakInstance:isa(Dog)) -- returns true


-- oakInstance:tableDump()

a = Dog()

a.bark()