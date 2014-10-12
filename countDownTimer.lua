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

	local redFlasher = display.newImageRect( group, "images/timebgred.png", 200, 200 )
	redFlasher.rotation = bg.rotation
	redFlasher:scale(0.4, 0.4)
	redFlasher.alpha = 0

	local greenFlasher = display.newImageRect( group, "images/timebggreen.png", 200, 200 )
	greenFlasher.rotation = bg.rotation
	greenFlasher:scale(0.4, 0.4)
	greenFlasher.alpha = 0

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

    function TimeGraphics:flashRed()
		local function flashOut()
			transition.to( redFlasher, {alpha = 0, time=500, transition=easing.InBack} )
		end

		local function flashIn()
			transition.to( redFlasher, {alpha = 1, time=200, onComplete=flashOut, transition=easing.OutBack} )
		end
		flashIn()
    end

    function TimeGraphics:flashGreen()
		local function flashOut()
			transition.to( greenFlasher, {alpha = 0, time=500, transition=easing.InBack} )
		end

		local function flashIn()
			transition.to( greenFlasher, {alpha = 1, time=200, onComplete=flashOut, transition=easing.OutBack} )
		end

		flashIn()
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
