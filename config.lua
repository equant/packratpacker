state = "unknown"

--- maximum modem suspend is 268.435 seconds (4.47 minutes)
ap_check_cadence = 268.435     -- Check every 10 minuntes

gpio16 = 0  --- Don't use this if you want to use node.dsleep())
gpio2  = 4  --- This is the onboard LED For the D1 mini (Low: On)

gpio_wifi_led = 4

-- maximum seconds is 6870.947.  Otherwise Nodelua barfs.
-- 6870s == 1.9 hours.

led_sequences = {
    -- {PIN,}, Blink_length(us), Repetitions, Cadence (s)
    -- Big LEDs -- Every hour
    {{3,1}, 35, 6, 36},     --- values for testing
    --{{3,1}, 35, 6, 3600}, --- values for real world
    -- LED Strip -- 
    {{5}, 3500, 1, 26},     --- values for testing
    -- vibrator -- Every 1.9 hours
    {{6}, 1100, 1, 68}      --- values for testing
    --{{6}, 1100, 1, 6870}  --- values for real world
}
