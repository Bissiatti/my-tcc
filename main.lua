local semiretas = {}

local retas = {}

local P = {}

local tempLine = {}

local epsilon = 12

local w,h = love.window.getDesktopDimensions()

local function pseudoScalarProduct(x1, y1, x2, y2, x3, y3, x4, y4)
	local dx1, dy1 = x2-x1, y2-y1
	local dx2, dy2 = x4-x3, y4-y3
	-- positive - goes inside, clockwise
	return dx1 * dy2 - dx2 * dy1
end

local function distancia(x1,y1,x2,y2)
	return math.sqrt((x1-x2)^2+(y1-y2)^2)
end

local function drawCutLine (line)

	if #line > 3 then
		love.graphics.line (line)
	end
end

function love.load()
	bg = love.graphics.newImage('t.png')
end

function love.update(dt)
	
end

local function findIntersection(semireta1,semireta2)

	local x1,y1,x2,y2 = semireta1[1],semireta1[2],semireta1[3],semireta1[4]
	local x3,y3,x4,y4 = semireta2[1],semireta2[2],semireta2[3],semireta2[4]

	if not x1 and not x2 and not x3 and not x4 then
		return
	end
	

	local dx1, dy1 = x2-x1, y2-y1
	local dx2, dy2 = x4-x3, y4-y3
	local denominator = dx1*dy2-dy1*dx2
	if denominator == 0 then
		print('Denomenador nulo')
		return
	end

	local dx13, dy13 = (x1 - x3), (y1 - y3)

	local t = (dx13 * (y3 - y4) - dy13 * (x3 - x4)) / denominator
	local u = (dx13 * (y1 - y2) - dy13 * (x1 - x2)) / denominator

	local intersectionX = x1 + t * (x2 - x1)
	local intersectionY = y1 + t * (y2 - y1)
	if #P > 0 then
		for i,p in ipairs(P) do
			local dist = distancia(p[1],p[2],intersectionX,intersectionY)
			if dist > epsilon then
				table.insert(P,{intersectionX,intersectionY,1})
			else
				P[i][3] = P[i][3]+1
			end
		end
	else
		table.insert(P,{intersectionX,intersectionY,1})
	end
	return nil

	-- if 	(unlimStart1 	or t >= 0) and 
	-- (unlimEnd1 		or t <= 1) and
	-- (unlimStart2 	or u >= 0) and 
	-- (unlimEnd2 		or u <= 1) then
	-- 	local intersectionX = x1 + t * (x2 - x1)
	-- 	local intersectionY = y1 + t * (y2 - y1)
	-- 	return intersectionX, intersectionY
	-- end
--	return nil
end

function love.draw()
	love.graphics.setColor (1,1,1)
	love.graphics.draw(bg, w/2-bg:getWidth()/2, h/2-bg:getHeight()/2)
	love.graphics.setLineWidth (3)
	love.graphics.setColor (0.6,0.6,0.6)
	drawCutLine (tempLine)
	love.graphics.setColor (0.8,0.8,1)
	for i,v in ipairs(semiretas) do
		drawCutLine(v)
	end
	love.graphics.setColor(0.7,1,0.8)
	for i,v in ipairs(P) do
		love.graphics.circle("fill",v[1],v[2],10)
	end
end


function love.mousepressed(x, y)
	tempLine = {x, y}
end

function love.mousemoved (x, y)
	tempLine[3] = x
	tempLine[4] = y
	--	tempLine[4] = tempLine[2]
end

function love.mousereleased ( x, y)
	table.insert(semiretas,tempLine)
	if #semiretas > 1 then
		--findIntersection(tempLine,semiretas[#semiretas-1])
		for i,semireta in ipairs(semiretas) do
			if #semiretas < 6 then
				findIntersection(tempLine,semireta)
			elseif math.random() < 6/#semiretas  then
				findIntersection(tempLine,semireta)
			end
		end
	end
	tempLine = {}
	
end

function love.keypressed(key, scancode, isrepeat)
	if false then
	elseif key == "escape" then
		love.event.quit()
	end
end


