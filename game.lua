local storyboard = require( "storyboard" )
scene = storyboard.newScene()
physics = require("physics")
local Tree = require("tree")
local Player = require("player")
local Laser = require("laser")
local Background = require("background")
local GameOver = require("gameOver")
local Hands = require("hands")
local CountDownTimer = require("countDownTimer")

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
local runRight
local runLeft
local showGameOver
local onKeyEvent



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

    local speedSound = audio.loadSound( "sound/bzzumm.mp3" )
    local crashSound = audio.loadSound( "sound/crash.mp3" )
    local heheSound = audio.loadSound( "sound/hehe.mp3" )
    local deathSound = audio.loadSound( "sound/death.mp3" )


    -- 0 = none, 1 = left, 2 = right
    local nextAction = 0

    local runRight
    local runLeft
    background = Background:new()
    tree = Tree:new()
    local despawner = display.newRect(_W/2, _H+200, _W*2, 100 )
    local despawnerRight = display.newRect( _W+200, _H/2-51+200, 100, _H )
    local despawnerLeft = display.newRect( -200, _H/2-51+200, 100, _H )

    local leftButton = display.newRect( _W/4, _H/2, _W/2, _H )
    local rightButton = display.newRect( _W-_W/4, _H/2, _W/2, _H )
    local gameStarter = display.newRect( _W/2, _H/2, _W, _H )
    leftButton.alpha = 0.01
    rightButton.alpha = 0.01
    gameStarter.alpha = 0.01
    local time = 15

    local timerGraphics = CountDownTimer:new()
    timerGraphics:setTime(time)
    timerGraphics.x = _W-50
    timerGraphics.y = 250

    --local timeGraphic = display.newText( "Time: " .. time, _W-50, 20, native.systemFontBold, 25)
    --timeGraphic:setFillColor()

    hands = Hands:new()
    player = Player:new()
    laser = Laser:new()
    laser:setY(player.y+time*12-40)

    local scoreText = display.newText( { text="Score: " .. player.score, fontSize=25, align="right", font=native.systemFontBold, width = 200, x=_W*0.80, y=20 } )
    scoreText.anchorX = 1
    scoreText.anchorY = 0
    scoreText.x = _W-10
    scoreText.y = 0
    scoreText:setFillColor(  )

    local scorebg = display.newRoundedRect( _W, 0, 260, 70, 5 )
    scorebg.strokeWidth = 6
    scorebg:setFillColor(255,255,0)
    scorebg:setStrokeColor()



    group:insert(background)
    group:insert(tree)
    group:insert(player)
    group:insert(laser)
    group:insert(scorebg)
    group:insert(scoreText)
    group:insert(timerGraphics)
    group:insert(hands)
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
        timerGraphics:setTime(time)
        laser:setY(player.y+time*12-40)
        if (time <= 0 and (not gameOver)) then
            gameOver = true
            showDeath()
        elseif (time == 2) then
            local heheSoundChannel = audio.play( heheSound )
            audio.setVolume( 1, { channel=heheSoundChannel } ) 
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
                local speedSoundChannel = audio.play( speedSound )
                audio.setVolume( 0.7, { channel=speedSoundChannel } ) 
                display.remove( event.other )
                event.other.isRemoved = true
                timerGraphics:flashGreen()
                time = time + 10
                tree:setSpeed(tree:getSpeed() + 1)
            elseif (event.other.isRemoved ~= true) then
                local crashSoundChannel = audio.play( crashSound )
                audio.setVolume( 1, { channel=crashSoundChannel } ) 
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
                timerGraphics:flashRed()
                time = time - 5
            end
            updateTime()

        end
    end

    local function increaseScore()
        player.score = player.score + 1
        scoreText.text = "Score: " .. player.score
    end


    local function startGame(event)
        if (event.phase == "began") then 
            tree:start(10, 20) 
            player:start()
            background:start()
            countDownTimer = timer.performWithDelay( 1000, changeTime )
            scoreTimer = timer.performWithDelay( 1000, increaseScore, 0)
            display.remove( gameStarter )
            gameStarter = nil
            hands:removeHands()
        end
    end

    local function stopTimers()
        if unlockTimer ~= nil then
            timer.cancel( unlockTimer )
        end
        locked = true
        Runtime:removeEventListener( "touch", rightClick )
        Runtime:removeEventListener( "touch", leftClick )
        Runtime:removeEventListener("key", onKeyEvent)
        tree:dispose()  
        player:stopSprite() 
        background:stop()
        if (countDownTimer ~= nil) then
            timer.cancel( countDownTimer )
        end
        if (scoreTimer ~= nil) then
            timer.cancel( scoreTimer )
        end
        Runtime:removeEventListener( "enterFrame", gameLoop )
    end

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

    function showDeath()
        local gameOver = GameOver:new()
        group:insert(gameOver)

        local deathSoundChannel = audio.play( deathSound )
        audio.setVolume( 1, { channel=deathSoundChannel } ) 
        timer.performWithDelay( 1300,         
            function() 
                stopTimers()
                player:stopSprite() 
                display.remove( player )
                notifyHit()
                gameOver:explode(player.x, player.y)
            end )

        timer.performWithDelay( 2800,         
            function() 
                gameOver:showMenu(player.score)
            end )
    end


    function onKeyEvent( event )
        if ((event.keyName == "back") and (system.getInfo("platformName") == "Android")) or 
            ((event.keyName == "q") and (system.getInfo("environment") == "simulator" )) then
            stopTimers()
            storyboard.gotoScene( "menu" )
            return true
        end
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
    Runtime:addEventListener( "key", onKeyEvent );

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
    --player:stopSprite()   
    if( countDownTimer ~= nil) then 
        timer.cancel( countDownTimer )
    end
    if( scoreTimer ~= nil) then 
        timer.cancel( scoreTimer )
    end
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
