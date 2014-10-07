local pack = {}

function pack:new()

	local sheetInfo = require("squirrel")
	local myImageSheet = graphics.newImageSheet( "squirrel.png", sheetInfo:getSheet() )

	--local sheetData = { width=43, height=64, numFrames=9, sheetContentWidth=129, sheetContentHeight=192 }
	--local sheet = graphics.newImageSheet( "ferret.png", sheetData )
	--local sequenceData = {name="normal", frames={7,8,9}, time=800}

	--local Player = display.newSprite( sheet, sequenceData )
	local Player = display.newSprite( myImageSheet , {frames={1, 2, 3}, time=270, loopDirection="bounce"} )

	Player:scale( 0.6, 0.5 )
	Player.score = 0

	Player.x = _W/2
	Player.y = _H*0.75

	function Player:rotateLeft()
		Player.rotation = -20
		local function stopRotation()
			Player.rotation = 0
		end
		timer.performWithDelay( rotateTime, stopRotation)
	end

	function Player:rotateRight()
		Player.rotation = 20
		local function stopRotation()
		Player.rotation = 0
		end
		timer.performWithDelay( rotateTime, stopRotation)
	end

	function Player:stopSprite()
		Player:pause( )
	end

	function Player:start()
		Player:play()
	end



	return Player
end


return pack