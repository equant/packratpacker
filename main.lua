print("All Pins Outputs Off")
for pin = 1, 8 do
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, gpio.LOW) -- LED OFF
end

-- turn off led
gpio.write(0, gpio.HIGH)
for pin = 9, 12 do
    gpio.write(pin, gpio.HIGH)
end


dofile("config.lua")
dofile("functions.lua")

print("Configuring GPIO...")
for pin = 1, 8 do
    configure_pin(pin)
end

wifi.setmode(wifi.STATION)
wifi.sleeptype(wifi.MODEM_SLEEP)

check_accesspoint()
print("Starting timers.")
mytimer = tmr.create()
mytimer:register(ap_check_cadence * 1000, tmr.ALARM_AUTO, check_accesspoint)
mytimer:start()
for i, seq in pairs(led_sequences) do
    print("Creating cadence timer for seq #"..i.." (pin #"..seq[1][1]..")")
    t = tmr.create()
    t:register(seq[4] * 1000, tmr.ALARM_AUTO, do_blink(seq))
    t:start()
    do_blink(seq)  -- Blink right away
end
