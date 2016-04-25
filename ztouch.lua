local class=require("middleclass")

local function insideSquare(x,y,s, x2,y2)
    return x2>=x and x2<=x+s and y2>=y and y2>=y+s
end

local function insideCircle(x,y,r, x2,y2)
    --todo
end


local ztouch=class("ztouch")

function ztouch:initialize()
    self.axes={}
    self.buttons={}
end

local button=class("button")
function button:initialize(x,y, shape, r, text)--shape choices: square, circle
    self.x=x            --x position
    self.y=y            --y position
    self.shape=shape    --shape of the button
    self.radius=r       --radius or side length
    self.text=text      --text to display inside the button

end

function button:draw()
    if shape=="circle" then
        love.graphics.circle("fill", self.x, self.y, self.radius)
    elseif shape=="square" then
        love.graphics.rectangle("line", self.x-self.radius/2, self.y-self.radius/2, self.radius, self.radius)
    end
end

function button:detect()
    if self.shape=="circle" then
        return function()
            for _,v in ipairs(love.touch.getTouches()) do
                if insideCircle(self.x, self.y, self.radius, love.touch.getPosition(v)) then
                    return true
                end
            end
            return false
        end
    elseif self.shape=="square" then
        return function()
            for _,v in ipairs(love.touch.getTouches()) do
                if insideSquare(self.x, self.y, self.radius, love.touch.getPosition(v)) then
                    return true
                end
            end
            return false
        end
    end
end


local axis=class("axis")



return ztouch
