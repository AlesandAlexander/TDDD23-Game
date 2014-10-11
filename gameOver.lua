local pack = {}
local HintSquirrel = require("hintSquirrel")
local storyboard = require( "storyboard" )


function pack:new()

    local Group = display.newGroup( )

    function Group:explode(xPos, yPos)
        local crashGroup = display.newGroup( )
        Group:insert(crashGroup)
        local part1 = display.newImageRect( crashGroup, "images/part1.png", 56, 90 )
        part1.x = xPos
        part1.y = yPos
        local part2 = display.newImageRect( crashGroup, "images/part2.png", 56, 90 )
        part2.x = xPos
        part2.y = yPos
        local part3 = display.newImageRect( crashGroup, "images/part3.png", 56, 90 )
        part3.x = xPos
        part3.y = yPos
        local part4 = display.newImageRect( crashGroup, "images/part4.png", 56, 90 )
        part4.x = xPos
        part4.y = yPos
        local part5 = display.newImageRect( crashGroup, "images/part5.png", 56, 90 )
        part5.x = xPos
        part5.y = yPos
        local part6 = display.newImageRect( crashGroup, "images/part6.png", 56, 90 )
        part6.x = xPos
        part6.y = yPos
        physics.setGravity( 0, 10 )
        physics.addBody( part1, "dynamic" )
        physics.addBody( part2, "dynamic" )
        physics.addBody( part3, "dynamic" )
        physics.addBody( part4, "dynamic" )
        physics.addBody( part5, "dynamic" )
        physics.addBody( part6, "dynamic" )

        for i=1,60 do
            local blood = display.newCircle( xPos+math.random(-50,50), yPos+math.random(-50,50), 3 )
            blood:setFillColor( 0.8,0,0 )
            crashGroup:insert( blood )
            physics.addBody( blood, "dynamic" )
        end

        for i=crashGroup.numChildren, 1, -1 do
            crashGroup[i]:setLinearVelocity( math.random(-50,50), math.random(-500, 100) )
            crashGroup[i].angularVelocity = math.random(-500, 500)
        end
    end

    function Group:showMenu(score)
        local transitionGroup = display.newGroup( )
        Group:insert(transitionGroup)
        transitionGroup.y = 100

        local rope = display.newImageRect( transitionGroup, "images/rope.png", 70, 720)
        rope:scale( 0.5, 0.5 )
        rope.x = _W/2
        rope.y = -100

        local popup = display.newRoundedRect( transitionGroup, _W/2, _H/2, _W-80, _H-250, 5 )
        popup.strokeWidth = 3
        popup:setFillColor(255,255,0)
        popup:setStrokeColor()


        local highScoreText = display.newText(transitionGroup, "You survived", _W/2, _H*0.35, native.systemFontBold, 30)
        highScoreText:setFillColor()
        local highScoreNumber = display.newText(transitionGroup, score .. " seconds", _W/2, _H*0.42, native.systemFontBold, 30)
        transitionGroup:insert(highScoreNumber)
        highScoreNumber:setFillColor()

        local restartButton = display.newRoundedRect( transitionGroup, _W/2, _H*0.55, _W*0.6, _H/12, 5 )
        restartButton.strokeWidth = 3
        restartButton:setFillColor(255,255,0)
        restartButton:setStrokeColor()
        local restartButtonText = display.newText( transitionGroup, "Retry", _W/2, _H*0.55, native.systemFontBold, 35 )
        transitionGroup:insert(restartButtonText)
        restartButtonText:setFillColor()

        local menuButton = display.newRoundedRect( transitionGroup, _W/2, _H*0.65, _W*0.6, _H/12, 5 )
        transitionGroup:insert(menuButton)
        menuButton.strokeWidth = 3
        menuButton:setFillColor(255,255,0)
        menuButton:setStrokeColor()
        local menuButtonText = display.newText( transitionGroup, "Menu", _W/2, _H*0.65, native.systemFontBold, 35 )
        menuButtonText:setFillColor()

        local hint = HintSquirrel:new()
        hint.x = 200
        hint.y = 70
        transitionGroup:insert(hint)

        local function restartGame()
            storyboard.gotoScene("reloadScene")
        end

        local function goToMenu()
            storyboard.gotoScene( "menu" )
        end
        transition.from( transitionGroup, {time = 800, y = (-_H/2), transition=easing.outBounce} )
        restartButton:addEventListener( "tap", restartGame )
        menuButton:addEventListener( "tap", goToMenu )
    end

    --timer.performWithDelay( 10, explode )
    --timer.performWithDelay( 1500, menu )

    return Group
end

return pack
