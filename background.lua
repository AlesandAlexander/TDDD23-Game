local pack = {}

function pack:new()

	local image = display.newImageRect( "images/bg.png", _W*9, _W*9 )
	image.x = _W*4
	image.y = -image.height/2+_H
	

	image.anchorX=1
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

	local function scrollVertical(event)
		if (image.y < image.height/2) then
			image.y = image.y + 0.3
		end
	end

	function image:dispose()
		Runtime:removeEventListener( "enterFrame", scrollVertical )
		Runtime:removeEventListener( "enterFrame", scroll )
		image:removeSelf( )
		image = nil
	end


	function image:start()
		Runtime:addEventListener( "enterFrame", scrollVertical )
	end


	Runtime:addEventListener( "enterFrame", scroll )
	return image

end

return pack