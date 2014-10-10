local pack = {}

function pack:new()

	local Hint = display.newGroup( )
	local squirrel = display.newRect( _W/2-20, _H/2+50, 50, 50 )
	local bubble = display.newRoundedRect( _W/2, _H/2, 150, 100, 5 )
	Hint:insert( squirrel )
	Hint:insert( bubble )
	
	return Hint
end


return pack
