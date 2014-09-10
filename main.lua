display.setStatusBar( display.HiddenStatusBar )
_W = display.contentWidth
_H = display.contentHeight
_Group = display.newGroup()
_Items = {}

local function init( )
	for i=1,100 do
		local car = display.newImage( "car.png" )
		local frontWheel = display.newImage( "wheel.png" )
		local backWheel = display.newImage( "wheel.png" )

		_Group:insert( car )
		_Group:insert( frontWheel )
		_Group:insert( backWheel )

		table.insert( _Items, car )
		table.insert( _Items, frontWheel )
		table.insert( _Items, backWheel )

		car.x = _W*math.random() 
		car.y = _H*math.random() 
		car:rotate( 360*math.random() )
		frontWheel.x = _W*math.random() 
		frontWheel.y = _H*math.random() 
		frontWheel:rotate( 360*math.random() )
		backWheel.x = _W*math.random() 
		backWheel.y = _H*math.random() 
		backWheel:rotate( 360*math.random() )
	end

end

local function moveItem( event )
	local item = _Items[math.random(#_Items)]
	transition.to( item, { x = _W*math.random(), y = _H*math.random(), rotation=math.random(-1080, 1080), time=math.random(1000, 8000), transition=easing.inOutCubic } )
end

init()
timer.performWithDelay( 1, moveItem, 0 )

