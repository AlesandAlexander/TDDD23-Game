local pack = {}

function pack:new()

	local Hint = display.newGroup( )
	local squirrel = display.newImageRect( Hint, "images/hintSquirrel.png", 350, 350 )
	squirrel.x = -40
	squirrel.y = 20
	squirrel:scale( 0.5, 0.5 )

	local bubble = display.newImageRect( Hint, "images/bubble.png", 350, 350 )
	bubble.x = 75
	bubble.y = -95
	bubble:scale( 0.5, 0.4 )

	local textBank = 
	{
		"Don't drink TOO much!", 
		"Energy drinks speeds me up!", 
		"Watch out for branches!",
		"It's hard to climb that fast!",
		"Drink only when you need it!",
		"Ouch, that hurts!", 
		"Drink only to survive!",
		"Don't let the hunter aim at me!"
	}


		local textOptions = 
	{
	    parent = Hint,
	    text = textBank[math.random(1, #textBank)],     
	    x = 70,
	    y = -75,
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
