local pack = {}

function pack:new()

	local sheetInfo = require("squirrel")
	local myImageSheet = graphics.newImageSheet( "images/squirrel.png", sheetInfo:getSheet() )
	local soundChannel

	--local sheetData = { width=43, height=64, numFrames=9, sheetContentWidth=129, sheetContentHeight=192 }
	--local sheet = graphics.newImageSheet( "ferret.png", sheetData )
	--local sequenceData = {name="normal", frames={7,8,9}, time=800}

	--local Player = display.newSprite( sheet, sequenceData )
	local Player = display.newSprite( myImageSheet , {frames={1, 2, 3}, time=270, loopDirection="bounce"} )

	Player:scale( 0.65, 0.65 )
	Player.score = 0

	Player.x = _W/2
	Player.y = _H*0.75

	local function startSound()
		local runSound = audio.loadSound( "sound/run.mp3" )
        soundChannel = audio.play( runSound, { loops=-1, volume=0 } )
        audio.setVolume( 0.2, { channel=soundChannel } ) 
	end

	local function stopSound()
    	audio.stop(soundChannel)
	end

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
		stopSound()
	end

	function Player:start()
		Player:play()
		startSound()
	end



	return Player
end


return pack