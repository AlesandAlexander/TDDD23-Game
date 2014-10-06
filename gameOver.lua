-- samplescene.lua

local storyboard = require "storyboard"
local scene = storyboard.newScene()

function scene:createScene( event )
    print("game over create")
    group = self.view
    local group = group
    local popup = display.newRoundedRect( group, _W/2, _H/2, _W-100, _H-200, 5 )
    popup.strokeWidth = 3
    popup:setFillColor(255,255,0)
    popup:setStrokeColor()

    local highScoreText = display.newText(group, "Your score was", _W/2, _H*0.35, native.systemFontBold, 30)
    highScoreText:setFillColor()
    local highScoreNumber = display.newText(group, event.params.score, _W/2, _H*0.42, native.systemFontBold, 30)
    highScoreNumber:setFillColor()

    local restartButton = display.newRoundedRect( group, _W/2, _H*0.6, _W*0.6, _H/12, 5 )
    restartButton.strokeWidth = 3
    restartButton:setFillColor(255,255,0)
    restartButton:setStrokeColor()
    local restartButtonText = display.newText( group, "Retry", _W/2, _H*0.6, native.systemFontBold, 35 )
    restartButtonText:setFillColor()

    local menuButton = display.newRoundedRect( group, _W/2, _H*0.7, _W*0.6, _H/12, 5 )
    menuButton.strokeWidth = 3
    menuButton:setFillColor(255,255,0)
    menuButton:setStrokeColor()
    local menuButtonText = display.newText( group, "Menu", _W/2, _H*0.7, native.systemFontBold, 35 )
    menuButtonText:setFillColor()


    local function restartGame()
        storyboard.hideOverlay( )
        display.remove(group)
        storyboard.reloadScene()
    end

    local function goToMenu()
        display.remove(group)
        storyboard.gotoScene( "menu" )
    end    

    restartButton:addEventListener( "tap", restartGame )
    menuButton:addEventListener( "tap", goToMenu )

end
scene:addEventListener( "createScene" )

return scene