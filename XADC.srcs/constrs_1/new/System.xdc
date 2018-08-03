# XADC
set_property IOSTANDARD LVCMOS33 [get_ports vauxn14]
set_property IOSTANDARD LVCMOS33 [get_ports vauxp14]
set_property PACKAGE_PIN N16 [get_ports vauxn14]

# Buttons
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_tri_i[0]}]
set_property PACKAGE_PIN Y16 [get_ports {gpio_tri_i[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {gpio_tri_i[1]}]
set_property PACKAGE_PIN V16 [get_ports {gpio_tri_i[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {gpio_tri_i[2]}]
set_property PACKAGE_PIN P16 [get_ports {gpio_tri_i[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {gpio_tri_i[3]}]
set_property PACKAGE_PIN R18 [get_ports {gpio_tri_i[3]}]

#matrix keyboard
set_property IOSTANDARD LVCMOS33 [get_ports {keyIN[0]}]
set_property PACKAGE_PIN V12 [get_ports {keyIN[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyIN[1]}]
set_property PACKAGE_PIN V13 [get_ports {keyIN[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyIN[2]}]
set_property PACKAGE_PIN W16 [get_ports {keyIN[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyIN[3]}]
set_property PACKAGE_PIN U17 [get_ports {keyIN[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyIN[4]}]
set_property PACKAGE_PIN J15 [get_ports {keyIN[4]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyOUT[0]}]
set_property PACKAGE_PIN T17 [get_ports {keyOUT[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyOUT[1]}]
set_property PACKAGE_PIN H15 [get_ports {keyOUT[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyOUT[2]}]
set_property PACKAGE_PIN Y17 [get_ports {keyOUT[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {keyOUT[3]}]
set_property PACKAGE_PIN T14 [get_ports {keyOUT[3]}]

#LCD 16x2 1602A
#DB7
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[5]}]
set_property PACKAGE_PIN U14 [get_ports {lcdOut[5]}]
#DB6
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[4]}]
set_property PACKAGE_PIN T15 [get_ports {lcdOut[4]}]
#DB5
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[3]}]
set_property PACKAGE_PIN U15 [get_ports {lcdOut[3]}]
#DB4
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[2]}]
set_property PACKAGE_PIN P14 [get_ports {lcdOut[2]}]
#Enable
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[0]}]
set_property PACKAGE_PIN V17 [get_ports {lcdOut[0]}]
#RS
set_property IOSTANDARD LVCMOS33 [get_ports {lcdOut[1]}]
set_property PACKAGE_PIN R14 [get_ports {lcdOut[1]}]
#RW force down - write only, no read

##I2S Audio Codec
##IO_L12N_T1_MRCC_35
set_property PACKAGE_PIN K18 [get_ports AC_BCLK]
set_property IOSTANDARD LVCMOS33 [get_ports AC_BCLK]

##IO_25_34
set_property PACKAGE_PIN T19 [get_ports AC_MCLK]
set_property IOSTANDARD LVCMOS33 [get_ports AC_MCLK]

##IO_L23N_T3_34
set_property PACKAGE_PIN P18 [get_ports AC_MUTEN]
set_property IOSTANDARD LVCMOS33 [get_ports AC_MUTEN]

##IO_L8P_T1_AD10P_35
set_property PACKAGE_PIN M17 [get_ports AC_PBDAT]
set_property IOSTANDARD LVCMOS33 [get_ports AC_PBDAT]

##IO_L11N_T1_SRCC_35
set_property PACKAGE_PIN L17 [get_ports AC_PBLRC]
set_property IOSTANDARD LVCMOS33 [get_ports AC_PBLRC]

##IO_L12P_T1_MRCC_35
set_property PACKAGE_PIN K17 [get_ports AC_RECDAT]
set_property IOSTANDARD LVCMOS33 [get_ports AC_RECDAT]

##IO_L8N_T1_AD10N_35
set_property PACKAGE_PIN M18 [get_ports AC_RECLRC]
set_property IOSTANDARD LVCMOS33 [get_ports AC_RECLRC]

##Audio Codec/external EEPROM IIC bus
##IO_L13P_T2_MRCC_34
set_property PACKAGE_PIN N18 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]
set_property PULLUP true [get_ports iic_0_scl_io]

##IO_L23P_T3_34
set_property PACKAGE_PIN N17 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]
set_property PULLUP true [get_ports iic_0_sda_io]

##LEDs
##IO_L23P_T3_35
set_property PACKAGE_PIN M14 [get_ports {led_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_tri_o[0]}]

##IO_L23N_T3_35
set_property PACKAGE_PIN M15 [get_ports {led_tri_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_tri_o[1]}]

##IO_0_35
set_property PACKAGE_PIN G14 [get_ports {led_tri_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_tri_o[2]}]

##IO_L3N_T0_DQS_AD1N_35
set_property PACKAGE_PIN D18 [get_ports {led_tri_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_tri_o[3]}]