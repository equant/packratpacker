
gpio.mode(5, gpio.OUTPUT)   -- AC Relay
gpio.write(5, gpio.HIGH)    -- Relay Board LED OFF
gpio.mode(6, gpio.OUTPUT)   -- AC Relay
gpio.write(6, gpio.HIGH)    -- Relay Board LED OFF

tmr.create():alarm(400, tmr.ALARM_AUTO, function()
    if photo > 743 then
        gpio.write(5, gpio.HIGH)    -- Relay Board LED OFF
        gpio.write(5, gpio.HIGH)    -- Relay Board LED OFF
    end
    if photo < 733 then
        gpio.write(5, gpio.LOW)    -- Relay Board LED ON
        gpio.write(5, gpio.LOW)    -- Relay Board LED ON
    end
end)
