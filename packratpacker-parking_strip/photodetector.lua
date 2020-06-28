photo = 0

tmr.create():alarm(400, tmr.ALARM_AUTO, function()
    photo = adc.read(0)
end)
