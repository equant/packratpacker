state = "unknown"
ap_tmr    = 0             -- tmr0
--blink_tmr = 1             -- tmr1
ap_check_cadence       =   120000
default_led_cadence    =    20000
default_led_duration   =      300
default_motor_cadence  = 10800000 -- once per three hours
default_motor_duration =    10000 -- 10 seconds

gpio16 = 0  --- Don't use this.  It'e tied up to RST (needed by node.dsleep())
gpio5  = 1
gpio4  = 2
gpio0  = 3
gpio2  = 4
gpio14 = 5
gpio12 = 6
gpio13 = 7
gpio15 = 8

active_timer_count = 0

device_sequences = {
    --led_strip = {
                --{gpio5,  tmr.create(), 0, default_led_cadence, default_led_duration},
                --{gpio4,   tmr.create(), 0, default_led_cadence, default_led_duration},
    --},
    motorcycle = {
                {gpio0,   tmr.create(), 0, default_led_cadence, default_led_duration},
                {gpio2,  tmr.create(), 0, default_led_cadence, default_led_duration},
    },
    vibrating_motor = {
                {gpio12, tmr.create(), 0, default_led_cadence, default_led_duration},
                --{gpio13, tmr.create(), 0, default_motor_cadence, default_motor_duration},
    },
}

function led_off(pin)
    gpio.write(pin, gpio.LOW) -- LED OFF
end

function led_on(pin)
    gpio.write(pin, gpio.HIGH) -- LED OFF
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

function handle_blink_event(tmr)
    --print("Searching for timer: ")
    --print(tmr)
    for name,sequence in pairs(device_sequences) do
        for i, led in pairs(sequence) do
            pin      = device[1]
            tmr      = device[2]
            state    = device[3]
            cadence  = device[4]
            duration = device[5]
            if (t == tmr) then
                print("Turning Off...")
                print("    "..name..":  pin("..pin..")")
                led_off(pin)
            end
        end
    end
    active_timer_count = active_timer_count - 1
end

function start_timer(device)
    pin           = device[1]
    tmr           = device[2]
    state         = device[3]
    mean_cadence  = device[4]
    mean_duration = device[5]
    if state == 1 then
        -- LED is On
        led_off(pin)
        cadence = math.random() * mean_cadence * 2 + 1
        device[3] = 0
    else
        -- LED is Off
        led_on(pin)
        on_duration = math.random() * mean_cadence * 2 + 1
        device[3] = 0
    end
    print("  ..Starting: "..pin.."    Time:"..time_on)
    tmr:alarm(time_on, tmr.ALARM_SINGLE, function(tmr) handle_blink_event(tmr); end)
    active_timer_count = active_timer_count + 1
end


function initialize_devices()
    print("initialize_devices()")
    if state=="home" then
        for name,sequence in pairs(device_sequences) do
            for i, device in pairs(sequence) do
                pin           = device[1]
                --tmr           = device[2]
                --duration      = device[3]
                --r = math.random()
                print("  "..name..":  pin("..pin..")")
                gpio.mode(pin,gpio.OUTPUT)
                led_off(pin)
                start_timer(device)
                --t:register(time_on, tmr.ALARM_SINGLE, function(pin, t) print("expired"); t:unregister(); led_off(pin); end)
            end
        end
    end
end

list_ap()
initialize_devices()
print("Starting timers.")
---tmr.alarm(ap_tmr, ap_check_cadence, tmr.ALARM_AUTO, list_ap)
--tmr.alarm(blink_tmr, blink_cadence, tmr.ALARM_AUTO, blink)
while(active_timer_count > 0) do
    foo = "bar"
end

-- 15 minutes = 900000000 us (9e8)

node.dsleep(900000000)
