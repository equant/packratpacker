-- ESP8266 expects this file to exist on startup.  This version
-- is a decendent of an init.lua found on the internet.  In gives
-- us time to abort so that we can re-flash the device, etc.
-- If we don't abort, then it runs main.lua which is where
-- our main code exists.

collectgarbage()
abort = false

function startup()
    uart.on("data")
    if abort == true then
        print('Aborted')
        return
    end

    dofile('main.lua')
end

print('Press c to abort')
-- if <CR> is pressed, abort
uart.on("data", "c",
    function(data)
        --print("receive from uart:", data)
        if data == "c" then
            abort = true
            uart.on("data")
        end
    end, 0)

tmr.create():alarm(2000, tmr.ALARM_SINGLE, startup)
