-- Pins for OLED
sda = 2 -- SDA Pin
scl = 1 -- SCL Pin

sla = 0x3C
i2c.setup(0, sda, scl, i2c.SLOW)
disp = u8g2.ssd1306_i2c_128x32_univision(0, sla)
disp:setFont(u8g2.font_6x10_tf) -- set 6x10 font
disp:setContrast(125)
--disp:setRot180()           -- Rotate Display if needed

disp:clearBuffer() -- start with clean buffer
disp:setContrast(125)
disp:drawStr(0, 12, "Good Morning Augusta")
disp:drawStr(0, 22, "Do you want iced")
disp:drawStr(0, 32, "cream for breakfast?")
disp:sendBuffer() -- sent buffer to display

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
