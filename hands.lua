local pack = {}

function pack:new()
	local Hands = display.newGroup( )

    local leftHand = display.newImageRect( Hands, "images/hand.png", 145, 145 )
    leftHand.x = 50
    leftHand.y = _H-90
    leftHand.xScale = -1.1
    leftHand.yScale = 1.1
    leftHand.rotation = 25
    local rightHand = display.newImageRect( Hands, "images/hand.png", 145, 145 )
    rightHand.x = _W-50
    rightHand.y = _H-90
    rightHand.xScale = 0.9
    rightHand.yScale = 0.9
    rightHand.rotation = -25

    local moveRightHand
    local moveLeftHand

    function Hands:removeHands()
        local function deleteHands()
            display.remove( rightHand )
            rightHand = nil
            display.remove( leftHand )
            leftHand = nil
        end
        transition.cancel(moveRightHand)
	    transition.cancel(moveLeftHand)

        transition.to( rightHand, {xScale=0.01, yScale=0.01, time = 300, transition=easing.inBack} )
        transition.to( leftHand, {xScale=0.01, yScale=0.01, time = 300, transition=easing.inBack, onComplete=deleteHands} )
    end


    local function moveHands()

        local moveHandsIn
        local moveHandsOut
        local inTransition = easing.inOutBack
        local outTransition = easing.outQuart
        local time = 800

        function moveHandsIn()
            moveLeftHand = transition.to( leftHand, {
                xScale=-0.9, 
                yScale=0.9, 
                time = time, 
                transition=inTransition
                } )

            moveRightHand = transition.to( rightHand, {
                xScale=1.1, 
                yScale=1.1, 
                time = time, 
                transition=outTransition, 
                onComplete=moveHandsOut} )
        end

        function moveHandsOut()
            moveLeftHand = transition.to( leftHand, {
                xScale=-1.1, 
                yScale=1.1, 
                time = time, 
                transition=outTransition
                } )

            moveRightHand = transition.to( rightHand, {
                xScale=0.9, 
                yScale=0.9, 
                time = time, 
                transition=inTransition, 
                onComplete=moveHandsIn} )

        end


        moveHandsIn()
	end

    moveHands()

	return Hands
end


return pack