local pack = {}

function pack:new()
	local TimeGraphics = display.newGroup( )
	local group = display.newGroup( )
	TimeGraphics:insert(group)

	local arrow = display.newImageRect( group, "images/arrow.png", 112, 186 )
	arrow.anchorY=0
	arrow:scale(0.4, 0.4)
	arrow.x = 0
	arrow.y = 0
	arrow.rotation = 20

	local bg = display.newImageRect( group, "images/timebg.png", 200, 200 )
	bg.rotation = 100
	bg:scale(0.4, 0.4)

	local timeText = display.newText( "", 0, 0, native.systemFontBold, 32)
	timeText:setFillColor()
	group:insert(timeText)

    function TimeGraphics:setTime(time)
    	timeText.text = time
    end

    function TimeGraphics:show()
    	TimeGraphics.isVisible = true
    end

    function TimeGraphics:hide()
    	TimeGraphics.isVisible = false
    end

	local function shake()
		transition.to( arrow, {rotation = math.random(20,25), time=1000, onComplete=shake, transition=easing.InOutBack} )
	end

	local amount = 3
	local function move()
		transition.to( group, {x=math.random(-amount, amount), y=math.random(-amount, amount), time=1000, onComplete=move, transition=easing.InOutBack} )
	end
	move()
	shake()


	return TimeGraphics
end

return pack
