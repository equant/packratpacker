all_pins = {}
for i, seq in pairs(led_sequences) do
    for i, pin in pairs(seq[1]) do
        all_pins[#all_pins + 1] = pin
    end
end

function turn_all_off()
    for i, p in pairs(all_pins) do
        led_off(p)
    end
end

test_tmr = tmr.create()
test_tmr:register(5000, tmr.ALARM_SEMI, turn_all_off)

function do_test_sequence()
    running, mode = test_tmr:state()
    print("do_test_sequence running: " .. tostring(running) .. ", mode: " .. tostring(mode))
    if running then
        return
    end

    -- Register timer to turn them off after 5 sec
    test_tmr:start()

    -- Turn them all on
    for i, p in pairs(all_pins) do
        led_on(p)
    end
end

gpio.mode(5, gpio.INT, gpio.PULLUP)
gpio.trig(5, "down", do_test_sequence)
