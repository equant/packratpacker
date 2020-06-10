
-- Outlet used for constant illumination
gpio.mode(5, gpio.OUTPUT)   -- AC Relay
gpio.write(5, gpio.HIGH)    -- Relay Board LED OFF
-- Outlet used for added intensity and flashing.
gpio.mode(6, gpio.OUTPUT)   -- AC Relay
gpio.write(6, gpio.HIGH)    -- Relay Board LED OFF

-- If it's dark out.  Turn on one of the outlets.
tmr.create():alarm(400, tmr.ALARM_AUTO, function()
    if darkness == false then
        gpio.write(5, gpio.HIGH)    -- Relay Board LED OFF
    else
        gpio.write(5, gpio.LOW)    -- Relay Board LED ON
    end
end)
