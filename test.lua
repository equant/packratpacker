all_pins = {}
for i, seq in pairs(led_sequences) do
    for i, pin in pairs(seq[1]) do
        all_pins[#all_pins + 1] = pin
    end
end

test_pin = 7

function turn_all_off()
    for i, p in pairs(all_pins) do
        led_off(p)
    end
end

test_tmr = tmr.create()
test_tmr:register(3000, tmr.ALARM_SEMI, turn_all_off)

function do_test_sequence()
    running, mode = test_tmr:state()
    print("do_test_sequence running: " .. tostring(running) .. ", mode: " .. tostring(mode))
    if running then
        return
    end

    -- Register timer to turn them off after x sec
    test_tmr:start()

    -- Turn them all on
    for i, p in pairs(all_pins) do
        led_on(p)
    end
end


--gpio.mode(7, gpio.INT, gpio.PULLUP)
--gpio.trig(7, "down", do_test_sequence)

function onNegEdge ()
    -- This tmr delays the checking for GPIO state for some time
    -- It's crucial to do this to avoid GPIO picking up noises especially from switching of inductive loads
    tmr.alarm(0, 50, 1,
        function()
            if (gpio.read(test_pin) == 0) then
                -- put your actions here
                print('The test button was pressed')
                do_test_sequence()
        end
    end)

end

gpio.mode(test_pin, gpio.INT, gpio.PULLUP) -- see https://github.com/hackhitchin/esp8266-co-uk/pull/1
gpio.trig(test_pin, 'down', debounce(onNegEdge))
