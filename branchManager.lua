local enemy = require("branch")
local branchGroup = display.newGroup( )

local difficulty = 20
local speed = 10
local counter = difficulty


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
	counter = counter-1
	if counter <= 0 then
		counter = difficulty
		spawnBranch()
	end
    for i=branchGroup.numChildren, 1, -1 do
      local branch = branchGroup[i]
      branch.y = branch.y + speed
    end
end

function branchGroup:rotateRight()
	for i=branchGroup.numChildren, 1, -1 do
	  branchGroup[i]:rotateRight()
	end
end

function branchGroup:rotateLeft()
	for i=branchGroup.numChildren, 1, -1 do
	  branchGroup[i]:rotateLeft()
	end
end

function branchGroup:start(spd, diff)
	speed = spd
	difficulty = diff
	Runtime:addEventListener( "enterFrame", gameLoop )
end

function branchGroup:setSpeed(spd)
	speed = spd
end

function branchGroup:setDifficulty(diff)
	difficulty = diff
end

function branchGroup:dispose()
	Runtime:removeEventListener( "enterFrame", gameLoop )
end

return branchGroup