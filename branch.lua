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
    local self = display.newGroup()
    self.x = _W/2

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
    self:insert(animation)
    self.animation = animation


    function self:rotateRight()
        local function right()
            self:setPosition((self.position + 1) % 8)        
        end
        right()
        timer.performWithDelay( 120, right)
    end

    function self:rotateLeft()
        local function left()
            self:setPosition((self.position - 1) % 8)
        end
        left()
        timer.performWithDelay( 120, left)
    end

    function self:setPosition(pos)
        self.position = pos
        self.animation:setFrame( pos+1 )

        if pos == 0 then
            self.x = _W/2
        elseif pos <= 4 then
            self.x = _W/2 - 110
        elseif pos > 4 then
            self.x = _W/2 + 110
        end
    end

    self:setPosition(position*2)

    return self

end

return enemy

