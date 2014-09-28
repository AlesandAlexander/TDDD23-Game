local friend = {}
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
 
function friend.new(position)    -- constructor
    --local self = display.newGroup()

    local powerUp = display.newImageRect( "powerUp.png", 30, 30 )
    powerUp.type = "friend"


    function powerUp:rotateRight()
        local function right()
            powerUp:setPosition((powerUp.position - 1) % numberOfFrames)
        end
        right()
        timer.performWithDelay( rotateTime/((numberOfFrames/4)-1), right, (numberOfFrames/4)-1)
        end

    function powerUp:rotateLeft()
        local function left()
            powerUp:setPosition((powerUp.position + 1) % numberOfFrames)        
        end
        left()
        timer.performWithDelay( rotateTime/((numberOfFrames/4)-1), left, (numberOfFrames/4)-1)
    end

    function powerUp:setPosition(pos)
        if not powerUp.isRemoved then
            powerUp.position = pos


            ------Positions---------
            ----------12------------
            --------13---11---------
            ------14-------10-------
            ----15-----------9------
            ---0--------------8-----
            ----1------------7------
            ------2-------6---------
            --------3---5-----------
            ----------4-------------

            if(pos>=0 and pos<=8)then
                powerUp.x = ((_W/2)-80) + 20*pos
            else
                powerUp.x = -100
            end
        end        
    end

    if position == 0 then
        powerUp.position = 0
        powerUp.x = _W/2 - 80
    elseif position == 1 then
        powerUp.position = 12
        powerUp.x = -100
    elseif position == 2 then
        powerUp.position = 8
        powerUp.x = _W/2 + 80
    else
        powerUp.position = 4
        powerUp.x = _W/2
    end

    return powerUp

end

return friend

