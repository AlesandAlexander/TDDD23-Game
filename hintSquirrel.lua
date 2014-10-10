local pack = {}

function pack:new()

	local Hint = display.newGroup( )
	local squirrel = display.newImageRect( Hint, "hintSquirrel.png", 350, 350 )
	squirrel.x = -40
	squirrel.y = 20
	squirrel:scale( 0.4, 0.35 )

	local bubble = display.newImageRect( Hint, "bubble.png", 350, 350 )
	bubble.x = 45
	bubble.y = -75
	bubble:scale( 0.4, 0.3 )

	local textBank = 
	{
		"Don't drink TOO much!", 
		"Energy drinks speeds me up!", 
		"Watch out for branches!",
		"It's hard to climb that fast!",
		"Drink only when you need it!",
		"Ouch, that hurts!"
	}


		local textOptions = 
	{
	    parent = Hint,
	    text = textBank[math.random(1, #textBank)],     
	    x = 40,
	    y = -55,
	    width = bubble.width*0.4-30,
	    height = bubble.height*0.4-30,
	    font = native.systemFont,   
	    fontSize = 18,
	    align = "center"
	}

	local text = display.newText( textOptions )
	Hint:insert(text)
	text:setFillColor( black )

	return Hint
end


return pack
