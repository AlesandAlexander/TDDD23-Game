
local Player = display.newGroup( )

local sheetData = { width=43, height=64, numFrames=9, sheetContentWidth=129, sheetContentHeight=192 }
local sheet = graphics.newImageSheet( "ferret.png", sheetData )
local sequenceData = {name="normal", frames={7,8,9}, time=800}

local ferret = display.newSprite( Player, sheet, sequenceData )

ferret:scale( 2, 2 )

ferret.x = _W/2
ferret.y = _H*0.75

ferret:play( )

function playerRotateLeft()
	ferret.rotation = -20
	local function stopRotation()
		ferret.rotation = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
end

function playerRotateRight()
	ferret.rotation = 20
	local function stopRotation()
	ferret.rotation = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
end



return Player