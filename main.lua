local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true

_W = display.contentWidth
_H = display.contentHeight

rotateTime = 250

--
locked = false

-- 0 = none, 1 = left, 2 = right
nextAction = 0


storyboard.gotoScene( "game" )