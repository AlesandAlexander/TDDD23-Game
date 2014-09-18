<<<<<<< HEAD
display.setStatusBar( display.HiddenStatusBar )
_W = display.contentWidth
_H = display.contentHeight
_Group = display.newGroup()
_Items = {}

physics = require("physics")
physics.start()
physics.setGravity( 0, 0 )

local tree = require("tree")

local function init( )


	local turnLeftButton = display.newRect( 0.25*_W, 0.5*_H, 0.5*_W, _H )
	local turnRightButton = display.newRect( 0.75*_W, 0.5*_H, 0.5*_W, _H )
	turnLeftButton.alpha = 0
	turnRightButton.alpha = 0
	--right:addEventListener( "touch", rotateRight )
	--left:addEventListener( "touch", rotateLeft )	

local options =
{
    width = 370,
    height = 80,
    numFrames = 7
}

--local myImageSheet = graphics.newImageSheet( "branchsheet.png", options )
local myImageSheet = graphics.newImageSheet( "branchsheet.png", sheetInfo:getSheet() )

local sequenceData = {
 
	{ 
		name = "turn",  --name of animation sequence
		start = 1,  --starting frame index
		count = 8,  --total number of frames to animate consecutively before stopping or looping
		time = 1000,  --optional, in milliseconds; if not supplied, the sprite is frame-based
		loopCount = 2,  --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
		loopDirection = "forward"  --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
	} 
}

local animation = display.newSprite( myImageSheet, sequenceData )
animation.x = _W/2 
animation.y = _H/2 
animation:setFrame( 2 )

local player = display.newRect( _W/2, _H-100, 30, 30 )


local function turnLeft()
	local function left()
		local currentFrame = animation.frame
		if(currentFrame == 8) then
			currentFrame = 0
		end

		animation:setFrame( currentFrame + 1 )
	end
	left()
	timer.performWithDelay( 150, left)
end

local function turnRight()
	local function right()
		local currentFrame = animation.frame
		if(currentFrame == 1) then
			currentFrame = 9
		end
		animation:setFrame( currentFrame - 1 )
	end
	right()
	timer.performWithDelay( 150, right)
end



local left = display.newRect( 0, 300, 100, 100 )
local right = display.newRect( 200, 300, 100, 100 )

local function rightClick( event )
	if (event.phase == "began") then
		turnRight()
	end

end
local function leftClick( event )
	if (event.phase == "began") then
		turnLeft()
	end

end

local function move( event )
	event.target.x = event.x
	event.target.y = event.y
end

local function onLocalCollision( event )
	print("collission")
    --if ( event.phase == "began" ) then
    print (event.other.myName)
    --end
end

player.myName = "player"
animation.myName = "branch"

right:addEventListener( "touch", rightClick )
left:addEventListener( "touch", leftClick )
player:addEventListener( "touch", move )

physics.addBody( animation, "static")
physics.addBody( player, "dynamic", {isSensor=true})

player.collision = onLocalCollision
player:addEventListener( "collision", player )


end


init()
=======
local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true

_W = display.contentWidth
_H = display.contentHeight
>>>>>>> origin/master

storyboard.gotoScene( "game" )
