function led_off(pin)
    gpio.write(pin, gpio.LOW) -- LED OFF
end

function led_on(pin)
    gpio.write(pin, gpio.HIGH) -- LED OFF
end

function make_search(continuation_function)

    function search_ap(t)
        print("Checking APs...")
        state = "unknown"
        for k, v in pairs(t) do
            print(k)
            if (k == "GSO" or k == "ella" or "UAGuest") then
                print("We are home.")
                state = "home"
            end
        end
        print("About to call continuation_function")
        continuation_function()
    end

    return search_ap
end

function get_state(continuation_function)
    wifi.sta.getap(make_search(continuation_function))
end

function go_blinkers()
    print("go_blinkers()")
    for i, pin in pairs(devices) do
        print("i: "..i)
        print("About to turn on pin: "..pin)
        led_on(pin)
    end

    mytimer = tmr.create()
    mytimer:register(5000, tmr.ALARM_SINGLE, stop_everything)
    mytimer:start()
end

function initialize_devices()
    for i, pin in pairs(devices) do
        gpio.mode(pin,gpio.OUTPUT)
        led_off(pin)
    end
end

function stop_everything()
    for i, pin in pairs(devices) do
        led_off(pin)
        gpio.mode(pin,gpio.INPUT)   -- make pin input so it is off during sleep.
    end

    --deep_sleep_duration = 900000000 # (us) == 15 minutes
    deep_sleep_duration = 120000000 -- (us) == 2 minutes
    print("Going to sleep for "..deep_sleep_duration.."us")
    node.dsleep(deep_sleep_duration)
end
