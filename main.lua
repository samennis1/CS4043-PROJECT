local background = display.newImageRect("background.jpg", 650, 360)
background.x = display.contentCenterX
background.y = display.contentCenterY

local grass = display.newImageRect("grass.png", 550, 100)
grass.x = display.contentCenterX
grass.y = display.contentHeight-50


local ratWidth = 70
local ratHeight = 60 
local rat = display.newImageRect("rat.png", ratWidth, ratHeight)
rat.x = display.contentCenterX
rat.y = display.contentCenterY


local physics =  require("physics")
physics.start()

physics.setGravity(0,30)
system.activate("multitouch")
physics.addBody(grass, "static", {friction=0.5})

physics.addBody(rat, "dynamic", {density = 4, bounce = 0 })


rat.sensorOverlaps = 0

rat.isFixedRotation = true

local function onKeyEvent( event )
--right
    if ( event.keyName == "d" ) then
        rat:setLinearVelocity(100, nil)
        if(event.phase == "up") then
            rat:setLinearVelocity(0,nil)
        end
    end
--left
    if ( event.keyName == "a" ) then
        rat:setLinearVelocity(-100, nil) 
        if(event.phase == "up") then
            rat:setLinearVelocity(0,nil)
        end   
    end
--jump
    
if ( event.keyName == "space" and event.phase == "up" ) then
        local vx, vy = rat:getLinearVelocity()
        rat:setLinearVelocity(vx, -300 )       
    end
end
 
-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

local function sensorCollide( self, event )
 
    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then
 
        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
            self.sensorOverlaps = self.sensorOverlaps + 1
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
            self.sensorOverlaps = self.sensorOverlaps - 1
        end
    end
end
-- Associate collision handler function with character
rat.collision = sensorCollide
rat:addEventListener( "collision" )