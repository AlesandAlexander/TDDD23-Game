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



end


init()

