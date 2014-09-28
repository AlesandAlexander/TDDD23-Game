local storyboard = require( "storyboard" )
scene = storyboard.newScene()
physics = require("physics")
local Tree = require("tree")
local Player = require("player")
local Background = require("background")
local ScoreManager = require("scoreManager")
local tree
local background
local unlockTimer
local countDownTimer
local scoreTimer

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


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    group = self.view
    local group = group
    -----------------------------------------------------------------------------

    --      CREATE display objects and add them to 'group' here.
    --      Example use-case: Restore 'group' from previously saved state.

    -----------------------------------------------------------------------------
    --local background = require("background")

    --
    local locked = false

    -- 0 = none, 1 = left, 2 = right
    local nextAction = 0


    local runRight
    local runLeft
    background = Background:new()
    group:insert(background)
    tree = Tree:new()
    group:insert(tree)
    local despawner = display.newRect( _W/2, _H+200, _W, 100 )
    local leftButton = display.newRect( _W/4, _H/2, _W/2, _H )
    local rightButton = display.newRect( _W-_W/4, _H/2, _W/2, _H )
    group:insert(rightButton)
    group:insert(leftButton)
    leftButton.alpha = 0.01
    rightButton.alpha = 0.01
    local time = 30
    local timeGraphic = display.newText( "Time: " .. time, _W-50, 20, native.systemFontBold, 25)
    timeGraphic:setFillColor()
    group:insert(timeGraphic)


    local scoreManager = ScoreManager:new()

    local player = Player:new()
    group:insert(player)

    local scoreCounter = display.newEmbossedText( { text=player.score, fontSize=30, align="center", x=_W/2, y=20 } )
    local color = 
    {
        highlight = { r=1, g=1, b=1 },
        shadow = { r=0, g=0, b=0 }
    }
    scoreCounter:setEmbossColor( color )
    group:insert(scoreCounter)


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

    local function updateTime()
        timeGraphic.text = "Time: " .. time
        if (time <= 0) then
            endGame()
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
                display.remove( event.other )
                event.other.isRemoved = true
                time = time + 10
                tree:setSpeed(tree:getSpeed() + 1)
            else
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


    rightButton:addEventListener( "touch", rightClick )
    leftButton:addEventListener( "touch", leftClick )

    physics.addBody( player, "dynamic", {isSensor=true, box={halfWidth=10, halfHeight=10}})
    physics.addBody( despawner, "dynamic", {isSensor=true})

    player.collision = onPlayerCollision
    player:addEventListener( "collision", player )

    despawner.collision = onDespawnerCollision
    despawner:addEventListener( "collision", despawner )


    local function changeTime()
        time = time - 1
        updateTime()
        countDownTimer = timer.performWithDelay( 1000, changeTime )
    end

    countDownTimer = timer.performWithDelay( 1000, changeTime )
    scoreTimer = timer.performWithDelay( 1000, increaseScore, 0)

    tree:start(10, 20)

    function endGame()
        scoreManager:saveScore(player.score)
        storyboard.gotoScene( "menu")
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

    if unlockTimer ~= nil then
        timer.cancel( unlockTimer )
    end
    timer.cancel( countDownTimer )
    timer.cancel( scoreTimer )
    tree:dispose()
    background:dispose()
    Runtime:removeEventListener( "enterFrame", gameLoop )


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


---------------------------------------------------------------------------------

return scene
