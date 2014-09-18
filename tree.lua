
local tree = require("treeSprite")

local Tree = display.newGroup( )


local treePartOne = display.newImageRect( Tree, "tree.png", 120, 480 )
treePartOne.x = _W/2
treePartOne.y = _H/2

local treePartTwo = display.newImageRect( Tree, "tree.png", 120, 480 )
treePartTwo.x = _W/2
treePartTwo.y = -_H*0.5

local treePartThree = display.newImageRect( Tree, "tree.png", 120, 480 )
treePartThree.x = _W/2 + 120
treePartThree.y = _H/2

local treePartFour = display.newImageRect( Tree, "tree.png", 120, 480 )
treePartFour.x = _W/2 + 120
treePartFour.y = -_H*0.5



--local sequenceData = {
--	{
--		name = "run",
--		start = 1,
--		count = 10,
--		time = 5000,
--		loopCount = 0
--	}
--}



--local image = graphics.newImageSheet( "treesheet.png", options )

--local animation = display.newSprite( image, sequenceData )

--animation.x = _W/2
--animation.y = _H/2

--animation:play()

local function scroll(event)
	treePartOne.y = treePartOne.y + 10
	treePartTwo.y = treePartTwo.y + 10
	treePartThree.y = treePartThree.y + 10
	treePartFour.y = treePartFour.y + 10
	if treePartOne.y >= 720 then
		treePartOne.y = -_H*0.5
	end
	if treePartTwo.y >= 720 then
		treePartTwo.y = -_H*0.5
	end
	if treePartThree.y >= 720 then
		treePartThree.y = -_H*0.5
	end
	if treePartFour.y >= 720 then
		treePartFour.y = -_H*0.5
	end

	treePartOne.x = treePartOne.x -2
	treePartTwo.x = treePartTwo.x -2
	treePartThree.x = treePartThree.x -2
	treePartFour.x = treePartFour.x -2
	if treePartOne.x <= ((_W/2) - 120) then
		treePartOne.x = _W/2 + 120
	end
	if treePartTwo.x <= ((_W/2) - 120) then
		treePartTwo.x = _W/2 + 120
	end
	if treePartThree.x <= ((_W/2) - 120) then
		treePartThree.x = _W/2 + 120
	end
	if treePartFour.x <= ((_W/2) - 120) then
		treePartFour.x = _W/2 + 120
	end

end

Runtime:addEventListener( "enterFrame", scroll )

local shadow = display.newImageRect( "shadow.png", 120, 480 )
shadow.x = _W/2
shadow.y = _H/2

local mask = graphics.newMask( "mask.png" )

Tree:setMask( mask )

Tree.maskX = _W/2
Tree.maskY = _H/2

--local function sweep(obj, time)
--	transition.from( obj, { time=3000, x=(_W/2), y=(-_H*0.5), 
--		onComplete=function(obj)
--			sweep(obj, time)
--		end
--			} )
--end

--function Tree:start(time)
--	transition.to( treePartOne, { time=time/2, x=(_W/2), y=(_H*1.5), 
--		onComplete=function(obj)
--			sweep(obj, time)
--		end
--		} )
--
--	transition.from( treePartTwo, { time=time, x=(_W/2), y=(-_H*0.5), 
--		onComplete=function(obj)
--			sweep(obj, time)
--		end
--		} )
	--transition.from( treePartOne, { time=time, x=(_W/2), y=(-_H*0.5) } )
--end

return Tree