// Copyright (c) 2015 Matthew J. Runyan
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

local solutions
local choice=1
local xOffset, yOffset = 0,0

function love.load(args)
	love.window.setTitle("Infinite Strip Packing")
	solutions = loadstring("return " .. args[2])()
end

function love.keypressed(key, repeated)
	if key == "escape" then
		love.event.quit()
	end
	key = tonumber(key)
	if type(key) == "number" then
		if solutions[key] then
			choice = key
		end
	end
end

function love.update()
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		yOffset=yOffset+5
	end if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		yOffset=yOffset-5
	end if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		xOffset=xOffset+5
	end if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		xOffset=xOffset-5
	end
end

function love.draw()
	love.graphics.translate(xOffset,yOffset)
	for i, v in ipairs(solutions[choice][4]) do
		local tmp = 255/#solutions[choice][4]*i
		love.graphics.setColor(tmp,tmp,tmp)
		love.graphics.rectangle("fill", love.window.getWidth()/2 + v[1]-solutions[choice][3][1]/2, 
			love.window.getHeight()-v[2], v[3], -v[4])
		
		love.graphics.setColor(50,0,255)
		love.graphics.print(i, love.window.getWidth()/2 + v[1]-solutions[choice][3][1]/2, 
			love.window.getHeight()-v[2]-v[4])
	end
	love.graphics.setColor(255,255,255)
	
	love.graphics.print(solutions[choice][1],-xOffset,-yOffset)
	love.graphics.print("Efficiency: "..solutions[choice][2]..'%',-xOffset,12-yOffset)
	love.graphics.print("Width:"..solutions[choice][3][1].." Height:"..solutions[choice][3][2],-xOffset,24-yOffset)
	
	love.graphics.print("Failed rects: "..#solutions[choice][5],-xOffset,48-yOffset)
	for i, v in ipairs(solutions[choice][5]) do
		love.graphics.print('{'..v[3]..','..v[4]..'},',-xOffset,(i+4)*12-yOffset)
	end
	
	love.graphics.print("Successful rects: "..#solutions[choice][4],-xOffset,(6+#solutions[choice][5])*12-yOffset)
	for i, v in ipairs(solutions[choice][4]) do
		love.graphics.setColor(50,0,255)
		love.graphics.print(tostring(i)..':',-xOffset,(i+6+#solutions[choice][5])*12-yOffset)
		
		love.graphics.setColor(255,255,255)
		love.graphics.print('{'..v[1]..','..v[2]..','..v[3]..','..v[4]..'},',
			20-xOffset,(i+6+#solutions[choice][5])*12-yOffset)
	end
end
