local storyboard = require( "storyboard" )
scene = storyboard.newScene()

display.setStatusBar( display.HiddenStatusBar )
local enemy = require("branch")

_Group = display.newGroup()
_Items = {}
physics = require("physics")
--physics.setDrawMode( "hybrid" )
physics.start()

physics.setGravity( 0, 0 )

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

    local background = require("background")
    group:insert(background)
    local tree = require("tree")
    group:insert(tree)
    local branchGroup = display.newGroup( )
    group:insert(branchGroup)
    local despawner = display.newRect( _W/2, _H+200, _W, 100 )
    local left = display.newRect( _W/4, _H/2, _W/2, _H )
    local right = display.newRect( _W-_W/4, _H/2, _W/2, _H )
    right.alpha = 0.01
    left.alpha = 0.01

    local player = require("player")
    --group:insert(test)

    local function rightClick( event )
        if (event.phase == "began") then        
            for i=branchGroup.numChildren, 1, -1 do
               branchGroup[i]:rotateRight()
            end
            treeRotateRight()
            background:rotateRight()
            playerRotateRight()
            --turnRight()
        end
    end
    local function leftClick( event )
        if (event.phase == "began") then
            for i=branchGroup.numChildren, 1, -1 do
               branchGroup[i]:rotateLeft()
            end
            treeRotateLeft()
            background:rotateLeft()
            playerRotateLeft()
            --turnLeft()
        end
    end

    local function onDespawnerCollision(self, event)
        if (event.phase == "began") then
            display.remove( event.other )
            event.other.isRemoved = true
        end
    end


    local function onPlayerCollision(self, event)
        if (event.phase == "began") then
            --print("hit")
        end
    end


    right:addEventListener( "touch", rightClick )
    left:addEventListener( "touch", leftClick )

    physics.addBody( player, "dynamic", {isSensor=true})
    physics.addBody( despawner, "dynamic", {isSensor=true})

    player.collision = onPlayerCollision
    player:addEventListener( "collision", player )

    despawner.collision = onDespawnerCollision
    despawner:addEventListener( "collision", despawner )

    local function spawnBranch()
        local numberToSpawn = math.random(0,3)
        for i=1,numberToSpawn do
            local branch = enemy.new(math.random(0,3))
            branch.y = -100
            physics.addBody( branch, "dynamic", {isSensor=true, box={halfWidth=80, halfHeight=30}})
            branchGroup:insert(branch)
        end
    end


    local function gameLoop() 
        for i=branchGroup.numChildren, 1, -1 do
          local branch = branchGroup[i]
          branch.y = branch.y + 10
        end
    end

    timer.performWithDelay( 500, spawnBranch, 0)
    Runtime:addEventListener( "enterFrame", gameLoop )

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
