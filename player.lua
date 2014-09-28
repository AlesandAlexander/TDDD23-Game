local pack = {}

function pack:new()
	local sheetData = { width=43, height=64, numFrames=9, sheetContentWidth=129, sheetContentHeight=192 }
	local sheet = graphics.newImageSheet( "ferret.png", sheetData )
	local sequenceData = {name="normal", frames={7,8,9}, time=800}

	local Player = display.newSprite( sheet, sequenceData )

	Player:scale( 2, 2 )
	Player.score = 0

	Player.x = _W/2
	Player.y = _H*0.75

	Player:play( )

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

	return Player
end


return pack