
function update_diplay()
    disp:setFont(u8g2.font_unifont_t_symbols) -- set 6x10 font
    disp:setFontPosTop()
    disp:clearBuffer() -- start with clean buffer
    disp:drawStr(1, 5,  string.format("%04d:%02d:%02d:%02d",d,h,m,s))
    disp:drawStr(1, 21,  string.format("%04d",photo))
    disp:sendBuffer() -- sent buffer to display
end

tmr.create():alarm(300, tmr.ALARM_AUTO, function()
    photo = adc.read(0)
    update_diplay()
end)
