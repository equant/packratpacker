state = "unknown"
ap_check_cadence = 1800

gpio16 = 0  --- Don't use this if you want to use node.dsleep())
gpio5  = 1
gpio4  = 2
gpio0  = 3
gpio2  = 4  --- This is the onboard LED For the D1 mini (Low: On)
gpio14 = 5
gpio12 = 6
gpio13 = 7
gpio15 = 8

led_sequences = {
    -- PINS, Blink_length(us), Repetitions, Cadence (s)
    -- rgb_hood
    {{gpio5, gpio4, gpio0}, 35, 6, 15},
    -- blinking_taillight
    --{{gpio2, gpio14}, 1000, 2, 302},
    -- vibrator -- 90 minutes
    {{gpio12}, 1100, 1, 33},
    -- rgb_hood reversed
    --{{gpio0, gpio4, gpio5}, 35, 6, 15},
}
