function led_off(pin)
    print("OFF: "..pin)
    gpio.write(pin, gpio.LOW) -- LED OFF
end

function led_on(pin)
    print("ON:  "..pin)
    gpio.write(pin, gpio.HIGH) -- LED ON
end

function configure_pin(pin)
    print("configuring pin("..pin..")")
    gpio.mode(pin, gpio.OUTPUT)
    --gpio.write(pin, gpio.HIGH) -- LED OFF
    led_off(pin)
end

function check_accesspoint()
    function search_ap(t)
        print("Checking APs...")
        state = "unknown"
        for k, v in pairs(t) do
            print(k)
            if (k == "GSO" or k == "ella" or k == "UAGuest") then
                print("We are home.")
                state = "home"
                led_off(gpio_wifi_led) -- off because it's low on?
            end
        end
        if (state == "unknown") then
            led_on(gpio_wifi_led) -- on because it's high off?
        end
    end

    wifi.sta.getap(search_ap)
end

function blink(t, seq, ix, rep)
    pins = seq[1]
    print("Blink: pins[1](" .. pins[1] .. "), ix(" .. ix .. "), #pins(" .. #pins .. ", rep(" .. rep .. ")")
    if ix > 0 then
        led_off(pins[ix])
    end

    ix = ix + 1

    if ix > #pins then
        -- Done with this repeat, start back at first pin again
        ix = 1
        rep = rep + 1
    end

    if rep == seq[3] then
        -- Done blinking, quit until blink timer kicks us off again
        print("END OF CADENCE (" .. pins[1] .. ")")
        return
    end

    local pin = pins[ix]
    time_on = seq[2]
    led_on(pin)
    function next_blink()
        blink(t, seq, ix, rep)
    end
    t:register(time_on, tmr.ALARM_SINGLE, next_blink)
    t:start()
end

function do_blink(seq)
    function c()
        if state == "home" then
            print("Starting up seq starting with pin #"..seq[1][1])
            blink(tmr.create(), seq, 0, 0)
        end
    end
    return c
end
