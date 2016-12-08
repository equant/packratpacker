dofile("config.lua")
dofile("functions.lua")

print("Configuring GPIO...")
for pin = 0, 8 do
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
