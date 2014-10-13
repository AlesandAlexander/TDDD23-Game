local storyboard = require( "storyboard" )
scene = storyboard.newScene()

display.setStatusBar( display.HiddenStatusBar )

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    group = self.view
    local group = group

    local background = display.newImageRect( group, "images/bg.png", _W*9, _W*9 )
    background.x = _W/2
    background.y = -background.height/2+_H

    local playButton = display.newRoundedRect( group, _W/2, _H*0.6, _W*0.8, _H/12, 5 )
    playButton.strokeWidth = 3
    playButton:setFillColor(255,255,0)
    playButton:setStrokeColor()
    local playButtonText = display.newText( group, "Play", _W/2, _H*0.6, native.systemFontBold, 35 )
    playButtonText:setFillColor()

    local highscoreButton = display.newRoundedRect( group, _W/2, _H*0.72, _W*0.8, _H/12, 5 )
    highscoreButton.strokeWidth = 3
    highscoreButton:setFillColor(255,255,0)
    highscoreButton:setStrokeColor()
    local highscoreButtonText = display.newText( group, "Highscore", _W/2, _H*0.72, native.systemFontBold, 35 )
    highscoreButtonText:setFillColor()

    local creditButton = display.newRoundedRect( group, _W/2, _H*0.84, _W*0.8, _H/12, 5 )
    creditButton.strokeWidth = 3
    creditButton:setFillColor(255,255,0)
    creditButton:setStrokeColor()
    local creditButtonText = display.newText( group, "Credit", _W/2, _H*0.84, native.systemFontBold, 35 )
    creditButtonText:setFillColor()

    local function startGame()
        display.remove( group )
        storyboard.gotoScene( "game", {effect="slideLeft", time=400})
    end

    local function showHighscore()
        display.remove( group )
        storyboard.gotoScene( "highscoreScreen", {effect="slideRight", time=400})
    end

    local function showCredit()
        display.remove( group )
        storyboard.gotoScene( "credit", {effect="slideRight", time=400})
    end

    playButton:addEventListener( "tap", startGame )
    highscoreButton:addEventListener( "tap", showHighscore )
    creditButton:addEventListener( "tap", showCredit )

end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    print("Game removed")

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

    -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
    local group = self.view
    local overlay_name = event.sceneName  -- name of the overlay scene

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
    local group = self.view
    local overlay_name = event.sceneName  -- name of the overlay scene

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene
