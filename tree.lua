local Tree = display.newGroup( )
local trunk = display.newGroup( )
local branchManager = require("branchManager")
Tree:insert(trunk)
Tree:insert(branchManager)

local speed = 10
local difficulty = 20
local rotateSpeed = 0;

local treePartOne = display.newImageRect( trunk, "tree.png", 120, 480 )
treePartOne.x = _W/2
treePartOne.y = _H/2

local treePartTwo = display.newImageRect( trunk, "tree.png", 120, 480 )
treePartTwo.x = _W/2
treePartTwo.y = -_H*0.5

local treePartThree = display.newImageRect( trunk, "tree.png", 120, 480 )
treePartThree.x = _W/2 + 120
treePartThree.y = _H/2

local treePartFour = display.newImageRect( trunk, "tree.png", 120, 480 )
treePartFour.x = _W/2 + 120
treePartFour.y = -_H*0.5

local shadow = display.newImageRect(trunk, "shadow.png", 120, 480 )
shadow.x = _W/2
shadow.y = _H/2

local mask = graphics.newMask( "mask.png" )
trunk:setMask( mask )
trunk.maskX = _W/2
trunk.maskY = _H/2



local function scroll(event)
	treePartOne.y = treePartOne.y + speed
	treePartTwo.y = treePartTwo.y + speed
	treePartThree.y = treePartThree.y + speed
	treePartFour.y = treePartFour.y + speed
	if treePartOne.y >= 720 then
		treePartOne.y = -_H*0.5
		treePartThree.y = -_H*0.5
	end
	if treePartTwo.y >= 720 then
		treePartTwo.y = -_H*0.5
		treePartFour.y = -_H*0.5
	end

	if rotateSpeed < 0 then
		if treePartOne.x <= ((_W/2) - 120) then
			treePartOne.x = _W/2 + 120
			treePartTwo.x = _W/2 + 120
		end
		if treePartThree.x <= ((_W/2) - 120) then
			treePartThree.x = _W/2 + 120
			treePartFour.x = _W/2 + 120
		end
	end
	if rotateSpeed > 0 then
		if treePartOne.x >= ((_W/2) + 120) then
			treePartOne.x = _W/2 - 120
			treePartTwo.x = _W/2 - 120
		end
		if treePartThree.x >= ((_W/2) + 120) then
			treePartThree.x = _W/2 - 120
			treePartFour.x = _W/2 - 120
		end
	end
	treePartOne.x = treePartOne.x + rotateSpeed
	treePartTwo.x = treePartTwo.x + rotateSpeed
	treePartThree.x = treePartThree.x + rotateSpeed
	treePartFour.x = treePartFour.x + rotateSpeed
end

function Tree:rotateRight()
	rotateSpeed = -6
	local function stopRotation()
		rotateSpeed = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
	branchManager:rotateRight()
end	

function Tree:rotateLeft()
	rotateSpeed = 6
	local function stopRotation()
		rotateSpeed = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
	branchManager:rotateLeft()
end	

function Tree:start(spd, diff)
	speed = spd
	difficulty = diff
	Runtime:addEventListener( "enterFrame", scroll )
	branchManager:start(speed, difficulty)
end

function Tree:setSpeed(spd)
	speed = spd
	branchManager:setSpeed(spd)
end

function Tree:setDifficulty(diff)
	difficulty = diff
	branchManager:setDifficulty(diff)
end

function Tree:getSpeed()
	return speed
end

function Tree:getDifficulty()
	return difficulty
end

function Tree:dispose()
	branchManager:dispose()
	Runtime:removeEventListener( "enterFrame", scroll )
end

return Tree