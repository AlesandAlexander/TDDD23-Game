display.setStatusBar( display.HiddenStatusBar )

local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true

_W = display.contentWidth
_H = display.contentHeight

rotateTime = 200

storyboard.gotoScene( "menu", {effect="fade", time=400} )