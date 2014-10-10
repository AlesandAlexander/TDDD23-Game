local pack = {}

function pack:new()

	local Laser = display.newGroup()
	Laser.x = _W/2
	Laser.y = _H*2
	local image = display.newCircle(Laser, 0, 0, 8 )
	
	image.strokeWidth = 4
	image:setStrokeColor( 0.9,0.2,0.2 )
	image:setFillColor( 0.8,0,0 )
	image.alpha=0.7

	function Laser:setY(yPos)
		transition.to( Laser, {time=500, y=yPos, transition=easing.OutBack} )
	end

    local time = 1000
    local amount = 3
	local function shake()
		transition.to( image, {x=math.random(-amount, amount), y=math.random(-amount, amount), time=time, onComplete=shake, transition=easing.InOutBack} )
	end
	shake()


	return Laser
end


return pack
