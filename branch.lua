local enemy = {}
local sheetInfo = require("branchSheet")
local numberOfFrames = 16
--local enemy = {}
--local enemy_mt = { __index = enemy }    -- metatable
 
-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------
 
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
            count = numberOfFrames,  --total number of frames to animate consecutively before stopping or looping
            time = 1000,  --optional, in milliseconds; if not supplied, the sprite is frame-based
            loopCount = 2,  --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
            loopDirection = "forward"  --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
        } 
    }

    local animation = display.newSprite( myImageSheet, sequenceData )
    animation.x = _W/2


    function animation:rotateRight()
        local function right()
            animation:setPosition((animation.position + 1) % numberOfFrames)        
        end
        right()
        timer.performWithDelay( rotateTime/((numberOfFrames/4)-1), right, (numberOfFrames/4)-1)
    end

    function animation:rotateLeft()
        local function left()
            animation:setPosition((animation.position - 1) % numberOfFrames)
        end
        left()
        timer.performWithDelay( rotateTime/((numberOfFrames/4)-1), left, (numberOfFrames/4)-1)
    end

    function animation:setPosition(pos)
        if not animation.isRemoved then
            animation.position = pos
            animation:setFrame( pos+1 )


            ------Positions--------
            ----------9------------
            --------8---10---------
            ------7-------11-------
            ----6-----------12-----
            --5---------------13---
            ----4-----------14-----
            ------3-------15-------
            --------2---0----------
            ----------1------------


            if pos <= 2 then
                animation.x = _W/2
            elseif pos <= 9 then
                animation.x = _W/2 - 116
            elseif pos > 9 then
                animation.x = _W/2 + 116
            end
        end
    end

    animation:setPosition(position*4+1)

    return animation

end

return enemy

