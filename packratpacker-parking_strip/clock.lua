s=0
m=0
h=0
d=0

tmr.create():alarm(1000, tmr.ALARM_AUTO, function() -- Every second increment clock and display
    s = s+1
    if s==60 then
     s=0
     m=m + 1
    end
    if m==60 then
     m=0
     h=h + 1
    end
    if h==25 then
     h=1
     d=d + 1
    end
    --incrememnt_clock()
end)
