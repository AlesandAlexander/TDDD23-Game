local storyboard = require( "storyboard" )
scene = storyboard.newScene()
physics = require("physics")
local Tree = require("tree")
local Player = require("player")
local Background = require("background")
local ScoreManager = require("scoreManager")

--physics.setDrawMode( "hybrid" )

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --
local tree
local background
local unlockTimer
local countDownTimer
local scoreTimer
local player
local group
local moveRightHand
local moveLeftHand
local runRight
local runLeft
local showGameOver


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    group = self.view
    -----------------------------------------------------------------------------

    --      CREATE display objects and add them to 'group' here.
    --      Example use-case: Restore 'group' from previously saved state.

    -----------------------------------------------------------------------------
    --local background = require("background")

    --
    local locked = false
    local gameOver = false
    local speedSound = audio.loadSound( "bzzumm.mp3" )
    local crashSound = audio.loadSound( "crash.mp3" )

    -- 0 = none, 1 = left, 2 = right
    local nextAction = 0

    local runRight
    local runLeft
    background = Background:new()
    group:insert(background)
    tree = Tree:new()
    group:insert(tree)
    local despawner = display.newRect(_W/2, _H+200, _W*2, 100 )
    local despawnerRight = display.newRect( _W+200, _H/2-51+200, 100, _H )
    local despawnerLeft = display.newRect( -200, _H/2-51+200, 100, _H )

    local leftButton = display.newRect( _W/4, _H/2, _W/2, _H )
    local rightButton = display.newRect( _W-_W/4, _H/2, _W/2, _H )
    local gameStarter = display.newRect( _W/2, _H/2, _W, _H )
    leftButton.alpha = 0.01
    rightButton.alpha = 0.01
    gameStarter.alpha = 0.01
    local time = 100
    local timeGraphic = display.newText( "Time: " .. time, _W-50, 20, native.systemFontBold, 25)
    timeGraphic:setFillColor()
    group:insert(timeGraphic)

    local leftHand = display.newImageRect( group, "hand.png", 120, 120 )
    leftHand.x = 30
    leftHand.y = _H-80
    leftHand.xScale = -1.07
    leftHand.yScale = 1.07
    leftHand.rotation = 30
    local rightHand = display.newImageRect( group, "hand.png", 120, 120 )
    rightHand.x = _W-30
    rightHand.y = _H-80
    rightHand.xScale = 1.07
    rightHand.yScale = 1.07
    rightHand.rotation = -30

    local scoreManager = ScoreManager:new()

    player = Player:new()
    group:insert(player)

    local scoreCounter = display.newEmbossedText( { text=player.score, fontSize=30, align="center", x=_W/2, y=20 } )
    local color = 
    {
        highlight = { r=1, g=1, b=1 },
        shadow = { r=0, g=0, b=0 }
    }
    scoreCounter:setEmbossColor( color )
    group:insert(scoreCounter)

    group:insert(rightButton)
    group:insert(leftButton)
    group:insert(gameStarter)

    physics.start()
    physics.setGravity( 0, 0 )

    local endGame



    local function unLock()
        if nextAction == 1 then
            runLeft()  
        elseif nextAction == 2 then
            runRight()
        else
            locked = false
        end
        nextAction = 0
    end

    local function rightClick( event )
        if (event.phase == "began") then 
            if not locked then            
                locked = true
                runRight()
            else
                nextAction = 2
            end
        end
    end

    local function leftClick( event )
        if (event.phase == "began") then
            if not locked then
                locked = true
                runLeft()
            else
                nextAction = 1
            end
        end
    end

    function runRight()
        tree:rotateRight()
        background:rotateRight()
        player:rotateRight()
        unlockTimer = timer.performWithDelay( rotateTime+50, unLock )
    end

    function runLeft()
        tree:rotateLeft()
        background:rotateLeft()
        player:rotateLeft()
        unlockTimer = timer.performWithDelay( rotateTime+50, unLock )
    end

    local function updateTime()
        if time < 0 then
            time = 0
        end
        timeGraphic.text = "Time: " .. time
        if (time <= 0 and (not gameOver)) then
            gameOver = true
            scoreManager:saveScore(player.score)
            showGameOver()
        end
    end

    local function changeTime()
        if not gameOver then
            time = time - 1
            updateTime()
            countDownTimer = timer.performWithDelay( 1000, changeTime )
        end
    end

    local function onDespawnerCollision(self, event)
        if (event.phase == "began") then
            display.remove( event.other )
            event.other.isRemoved = true
        end
    end

    local function notifyHit()
        local counter = 10
        local time = 10
        local rep = 5
        local amount = 10
        local rot = 2
        local function shake()
            counter = counter - 1
            if counter >= 0 then
                transition.to( group, {x=math.random(-amount, amount), y=math.random(-amount, amount), rotation = math.random(-rot, rot), time=time, onComplete=shake} )
            else
                transition.to( group, {x=0, y=0, time=time, rotation=0} )
            end
        end
        shake()
    end


    local function onPlayerCollision(self, event)
        if (event.phase == "began") then
            if event.other.type == "friend" then
                local speedSoundChannal = audio.play( speedSound )
                display.remove( event.other )
                event.other.isRemoved = true
                time = time + 10
                tree:setSpeed(tree:getSpeed() + 1)
            elseif (event.other.isRemoved ~= true) then
                local crashSoundChannal = audio.play( crashSound )
                local direction = math.random(0, 1)
                local speed = math.random(30, 40) * tree:getSpeed()
                if (direction > 0.5) then
                    event.other:setLinearVelocity( speed, -tree:getSpeed()*20 )
                else
                    event.other:setLinearVelocity( -1 * speed, -tree:getSpeed()*20 )
                end
                event.other.angularVelocity = math.random(-1000, 1000)
                event.other.isRemoved = true
                notifyHit()
                time = time - 5
                updateTime()
            end
        end
    end

    local function increaseScore()
        player.score = player.score + 1
        scoreCounter.text = player.score
    end


    local function moveHands()
        if (rightHand ~= nil) then
            moveLeftHand = transition.to( leftHand, {xScale=-1/rightHand.xScale, yScale=1/rightHand.yScale, time = 500} )
            moveRightHand = transition.to( rightHand, {xScale=1/rightHand.xScale, yScale=1/rightHand.yScale, time = 500, onComplete=moveHands} )
        end
    end

    local function removeHands()
        local function deleteHands()
            display.remove( rightHand )
            rightHand = nil
            display.remove( leftHand )
            leftHand = nil
        end
        transition.to( rightHand, {xScale=0.01, yScale=0.01, time = 300} )
        transition.to( leftHand, {xScale=0.01, yScale=0.01, time = 300, onComplete=deleteHands} )
    end


    local function startGame(event)
        if (event.phase == "began") then 
            tree:start(10, 20) 
            player:start()
            countDownTimer = timer.performWithDelay( 1000, changeTime )
            scoreTimer = timer.performWithDelay( 1000, increaseScore, 0)
            display.remove( gameStarter )
            gameStarter = nil
            transition.cancel(moveRightHand)
            transition.cancel(moveLeftHand)
            removeHands()
        end
    end

    local function stopTimers()
        if unlockTimer ~= nil then
            timer.cancel( unlockTimer )
        end
        locked = true
        Runtime:removeEventListener( "touch", rightClick )
        Runtime:removeEventListener( "touch", leftClick )
        tree:dispose()
        player:stopSprite()    
        timer.cancel( countDownTimer )
        timer.cancel( scoreTimer )
        Runtime:removeEventListener( "enterFrame", gameLoop )
    end

    function showGameOver()
        stopTimers()
        local popup = display.newRoundedRect( group, _W/2, _H/2, _W-100, _H-200, 5 )
        popup.strokeWidth = 3
        popup:setFillColor(255,255,0)
        popup:setStrokeColor()

        local highScoreText = display.newText(group, "Your score was", _W/2, _H*0.35, native.systemFontBold, 30)
        highScoreText:setFillColor()
        local highScoreNumber = display.newText(group, player.score, _W/2, _H*0.42, native.systemFontBold, 30)
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
            storyboard.gotoScene("reloadScene")
        end

        local function goToMenu()
            storyboard.gotoScene( "menu" )
        end

        restartButton:addEventListener( "tap", restartGame )
        menuButton:addEventListener( "tap", goToMenu )
    end

    moveHands()

    rightButton:addEventListener( "touch", rightClick )
    leftButton:addEventListener( "touch", leftClick )

    gameStarter:addEventListener( "touch", startGame )

    physics.addBody( player, "dynamic", {isSensor=true, box={halfWidth=10, halfHeight=20, x=0, y=-600}})
    physics.addBody( despawner, "dynamic", {isSensor=true})
    physics.addBody( despawnerRight, "dynamic", {isSensor=true})
    physics.addBody( despawnerLeft, "dynamic", {isSensor=true})

    player.collision = onPlayerCollision
    player:addEventListener( "collision", player )

    despawner.collision = onDespawnerCollision
    despawner:addEventListener( "collision", despawner )
    
    despawnerRight.collision = onDespawnerCollision
    despawnerRight:addEventListener( "collision", despawnerRight )

    despawnerLeft.collision = onDespawnerCollision
    despawnerLeft:addEventListener( "collision", despawnerLeft )

    function endGame()
        scoreManager:saveScore(player.score)
        storyboard.gotoScene("menu")
    end

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

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------


end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    --background:dispose()
    --display.remove(self.view)
    --self.view = nil

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
    if unlockTimer ~= nil then
        timer.cancel( unlockTimer )
    end
    background:dispose()
    tree:dispose()
    player:stopSprite()    
    timer.cancel( countDownTimer )
    timer.cancel( scoreTimer )
    Runtime:removeEventListener( "enterFrame", gameLoop )

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------
    
end

function scene:overlayBegan( event )
    local group = self.view
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
