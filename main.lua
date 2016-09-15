state = "home"
ap_tmr    = 0             -- tmr0
blink_tmr = 1             -- tmr1
ap_check_cadence = 120000
blink_cadence = 20000
blink_length = 500

gpio0  = 3
gpio2  = 4
gpio4  = 2
gpio5  = 1
gpio12 = 6
gpio13 = 7

led_sequences = {
    rgb_hood = {
                {gpio0,  tmr.create()},
                {gpio2,  tmr.create()},
                {gpio4,  tmr.create()},
    },
    battery  = {
                {gpio5,  tmr.create()},
                {gpio12, tmr.create()},
    },
}

function led_off(pin)
    gpio.write(pin, gpio.LOW) -- LED OFF
end

function led_on(pin)
    gpio.write(pin, gpio.HIGH) -- LED OFF
end

print("Configuring GPIO...")
for name,sequence in pairs(led_sequences) do
    for i, led in pairs(sequence) do
        pin = led[1]
        print(name..":  pin("..pin..")")
        gpio.mode(pin,gpio.OUTPUT)
        --gpio.write(pin, gpio.HIGH) -- LED OFF
        led_off(pin)
    end
end

wifi.setmode(wifi.STATION)
wifi.sleeptype(wifi.MODEM_SLEEP)

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
end

function list_ap()
    wifi.sta.getap(search_ap)
end

function turn_off_associated_led(tmr)
    --print("Searching for timer: ")
    --print(tmr)
    for name,sequence in pairs(led_sequences) do
        for i, led in pairs(sequence) do
            pin = led[1]
            t = led[2]
            if (t == tmr) then
                print("Turning Off...")
                print("    "..name..":  pin("..pin..")")
                led_off(pin)
            end
        end
    end
end


function blink()
    print("blink()")
    if state=="home" then
        for name,sequence in pairs(led_sequences) do
            for i, led in pairs(sequence) do
                r = math.random()
                if r > 0.3 then
                    local pin = led[1]
                    t = led[2]
                    time_on = math.random() * blink_length * 2
                    led_on(pin)
                    print("BLINK ON: "..pin.."    Time:"..time_on)
                    t:alarm(time_on, tmr.ALARM_SINGLE, function(t) turn_off_associated_led(t); end)
                    --t:register(time_on, tmr.ALARM_SINGLE, function(pin, t) print("expired"); t:unregister(); led_off(pin); end)
                end
            end
        end
    end
end

list_ap()
blink()
print("Starting timers.")
tmr.alarm(ap_tmr, ap_check_cadence, tmr.ALARM_AUTO, list_ap)
tmr.alarm(blink_tmr, blink_cadence, tmr.ALARM_AUTO, blink)

