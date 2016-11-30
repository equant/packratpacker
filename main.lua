dofile("config.lua")
dofile("functions.lua")

wifi.setmode(wifi.STATION)
wifi.sleeptype(wifi.MODEM_SLEEP)

print("about to init")
initialize_devices()
print("done init")

state = "unknown"
print("calling get_state()")
get_state(go_blinkers)
print("exited get_state()")

