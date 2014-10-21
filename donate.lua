local storyboard = require( "storyboard" )
scene = storyboard.newScene()


----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --
local onKeyEvent

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    group = self.view
    local group = group

    local background = display.newImageRect( group, "images/bg.png", _W*9, _W*9 )
    background.x = _W/2+_W
    background.y = -background.height/2+_H

    local donateBackground = display.newRoundedRect( group, _W/2, _H*0.40, 290, 420, 5 )
    donateBackground.strokeWidth = 3
    donateBackground:setFillColor(255,255,0)
    donateBackground:setStrokeColor()

    local bitcoinQr = display.newImageRect( group, "images/bitcoin.png", 500, 500 )
    bitcoinQr:scale( 0.45, 0.45 )
    bitcoinQr.x = _W/2
    bitcoinQr.y = donateBackground.y+70

    local creditText = display.newEmbossedText( { parent=group, text="Donate bitcoin by scanning the QR code below or tap it to open your local bitcoin app.", fontSize=22, align="center", x=_W/2, y=_H*0.19, width = 280, font=native.systemFont } )
    creditText:setFillColor(  )

    local backButton = display.newRoundedRect( group, _W/2, _H*0.8, _W*0.8, _H/12, 5 )
    backButton.strokeWidth = 3
    backButton:setFillColor(255,255,0)
    backButton:setStrokeColor()
    local backButtonText = display.newText( group, "Back", _W/2, _H*0.8, native.systemFontBold, 35 )
    backButtonText:setFillColor()


    local function showMenu()
        display.remove( group )
        storyboard.gotoScene( "menu", {effect="slideLeft", time=400})
    end

    function onKeyEvent( event )
        if ((event.keyName == "back") and (system.getInfo("platformName") == "Android")) or 
            ((event.keyName == "q") and (system.getInfo("environment") == "simulator" )) then
            showMenu()
            return true
        end
    end

    function donateBitcoin()
		system.openURL( "bitcoin:1Ah8zgpBDystRbcMnfZrUKdr5wcbiQJQk9" )
    end

    bitcoinQr:addEventListener( "tap", donateBitcoin )
    backButton:addEventListener( "tap", showMenu )

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
    Runtime:addEventListener( "key", onKeyEvent );

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
    Runtime:removeEventListener("key", onKeyEvent)

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
