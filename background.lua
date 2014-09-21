local image = display.newImageRect( "bg.png", _W*9, _H )
image.anchorX=1
image.x = _W
image.y =_H/2
local rotationSpeed = 70
local scrollSpeed = 0


function image:rotateRight()
	scrollSpeed = rotationSpeed
	local function stopRotation()
		scrollSpeed = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
end	

function image:rotateLeft()
	scrollSpeed = -rotationSpeed
	local function stopRotation()
		scrollSpeed = 0
	end
	timer.performWithDelay( rotateTime, stopRotation)
end	


local function scroll(event)
	image.x = image.x + scrollSpeed
	if image.x > _W*9 then
		image.x = _W
	end
	if image.x < _W then
		image.x = _W*9
	end
end

Runtime:addEventListener( "enterFrame", scroll )


return image