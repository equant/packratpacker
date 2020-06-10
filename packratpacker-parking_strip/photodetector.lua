photo = 0
darkness = true

tmr.create():alarm(400, tmr.ALARM_AUTO, function()
    photo = adc.read(0)
    if photo > 743 then
        darkness = false
    end
    if photo < 733 then
        darkness = true
    end
end)
