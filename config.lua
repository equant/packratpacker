state = "unknown"
ap_check_cadence = 1800

gpio16 = 0  --- Don't use this if you want to use node.dsleep())
gpio2  = 4  --- This is the onboard LED For the D1 mini (Low: On)

gpio_wifi_led = 4

led_sequences = {
    -- {PIN,}, Blink_length(us), Repetitions, Cadence (s)
    -- Big LEDs
    {{3,1}, 35, 6, 15},
    -- vibrator -- 90 minutes
    {{6}, 1100, 1, 33},
}
