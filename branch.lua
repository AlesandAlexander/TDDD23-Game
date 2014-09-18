local enemy = {}
local sheetInfo = require("branchSheet")
--local enemy = {}
--local enemy_mt = { __index = enemy }    -- metatable
 
-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------

function enemy:setPosition(pos)
    if pos == "right" then
        self.x = _W + 50
    elseif pos == "left" then
        self.x = _W - 50
    elseif pos == "front" then
        self.x = _W
    elseif pos == "back" then
        self.x = 0
    end
end
 
-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------
 
function enemy.new(position)    -- constructor
    --local self = display.newGroup()

    local myImageSheet = graphics.newImageSheet( "branchsheet.png", sheetInfo:getSheet() )
    local sequenceData = {
        { 
            name = "turn",  --name of animation sequence
            start = 1,  --starting frame index
            count = 8,  --total number of frames to animate consecutively before stopping or looping
            time = 1000,  --optional, in milliseconds; if not supplied, the sprite is frame-based
            loopCount = 2,  --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
            loopDirection = "forward"  --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
        } 
    }

    local animation = display.newSprite( myImageSheet, sequenceData )
    animation.x = _W/2


    function animation:rotateRight()
        local function right()
            animation:setPosition((animation.position + 1) % 8)        
        end
        right()
        timer.performWithDelay( 120, right)
    end

    function animation:rotateLeft()
        local function left()
            animation:setPosition((animation.position - 1) % 8)
        end
        left()
        timer.performWithDelay( 120, left)
    end

    function animation:setPosition(pos)
        if not animation.isRemoved then
            animation.position = pos
            animation:setFrame( pos+1 )

            ------Positions------
            ----------4----------
            ------3-------5------
            --2---------------6--
            ------1-------7------
            ----------0----------

            -- if pos == 0 or pos == 1 or pos == 7 then
            --     animation.x = _W/2
            -- elseif pos <= 4 then
            --     animation.x = _W/2 - 110
            -- elseif pos > 4 then
            --     animation.x = _W/2 + 110
            -- end

            if pos == 0 then
                animation.x = _W/2
            elseif pos <= 4 then
                animation.x = _W/2 - 110
            elseif pos > 4 then
                animation.x = _W/2 + 110
            end
        end
    end

    animation:setPosition(position*2)

    return animation

end

return enemy

