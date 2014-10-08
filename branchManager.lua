local pack = {}
local enemy = require("branch")
local powerUpType = require("powerUp")


function pack:new()

	local branchGroup = display.newGroup( )

	local difficulty = 20
	local speed = 10
	local counter = difficulty


	local function spawnBranch()
	    local numberToSpawn = math.random(0,3)
	    local positions = {0,1,2,3}
	    for i=1,numberToSpawn do
	    	local position = math.random(1,#positions)
	        local branch = enemy.new(positions[position])
	    	table.remove( positions, position )
	        branch.y = -100
	        physics.addBody( branch, "dynamic", {isSensor=true, box={halfWidth=80, halfHeight=30}})
	        branchGroup:insert(branch)
	    end
	end

	local function spawnPowerUp()
		local random= math.random(1,100)
		if random > 85 then
			local powerUp = powerUpType.new(math.random(0,3))
			powerUp.isSprite = true
			powerUp.y = -100
			physics.addBody( powerUp, "dynamic", {isSensor=true})
			branchGroup:insert(powerUp)
		end
	end

	local function gameLoop()
		counter = counter-1
		if counter <= 0 then
			counter = difficulty
			spawnBranch()
		end
		if counter == 10 then
			spawnPowerUp()
		end
	    for i=branchGroup.numChildren, 1, -1 do
	      local branch = branchGroup[i]
	      branch.y = branch.y + speed
	    end
	end

	local function setZ()
		for i=branchGroup.numChildren, 1, -1 do
			if (branchGroup[i].position == 5 or 
				branchGroup[i].position == 13) then
				branchGroup[i]:toFront()
			end
		end
		for i=branchGroup.numChildren, 1, -1 do
			if (branchGroup[i].position == 1) then
				branchGroup[i]:toFront()
			end
		end
	end

	function branchGroup:rotateRight()
		setZ()
		for i=branchGroup.numChildren, 1, -1 do
			if not branchGroup[i].isRemoved then
				branchGroup[i]:rotateRight()
			end
		end
	end

	function branchGroup:rotateLeft()
		setZ()
		for i=branchGroup.numChildren, 1, -1 do
			if not branchGroup[i].isRemoved then
				branchGroup[i]:rotateLeft()
			end
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
		--for i=branchGroup.numChildren, 1, -1 do
	    --  local branch = branchGroup[i]
	    --  branch.isRemoved = true
	    --end
	    for i=branchGroup.numChildren, 1, -1 do
	    	if branchGroup[i].isSprite == true then
		    	branchGroup[i]:stopSprite()
		    end
	    end
		Runtime:removeEventListener( "enterFrame", gameLoop )
	end

	return branchGroup
end


return pack