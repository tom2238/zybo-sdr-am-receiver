### This file is a general .xdc for the ZYBO Rev B board
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used signals according to the project

###Clock signal
###IO_L11P_T1_SRCC_35	
#set_property PACKAGE_PIN L16 [get_ports clk100]
#set_property IOSTANDARD LVCMOS33 [get_ports clk100]
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports clk100]

###LEDs
###IO_L23P_T3_35
#set_property PACKAGE_PIN M14 [get_ports {adc[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[11]}]

###IO_L23N_T3_35
#set_property PACKAGE_PIN M15 [get_ports {adc[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[10]}]

###IO_0_35
#set_property PACKAGE_PIN G14 [get_ports {adc[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[9]}]

###IO_L3N_T0_DQS_AD1N_35
#set_property PACKAGE_PIN D18 [get_ports {adc[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[8]}]

## XADC channel 14
#set_property PACKAGE_PIN N16 [get_ports vauxn14]
#set_property IOSTANDARD LVCMOS33 [get_ports vauxn14]
###IO_L20P_T3_AD6P_35
#set_property PACKAGE_PIN N15 [get_ports vauxp14]	
#set_property IOSTANDARD LVCMOS33 [get_ports vauxp14]	


###Pmod Header JB
###IO_L15N_T2_DQS_34
#set_property PACKAGE_PIN U20 [get_ports {adc[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[0]}]

###IO_L15P_T2_DQS_34
#set_property PACKAGE_PIN T20 [get_ports {adc[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[1]}]

###IO_L16N_T2_34
#set_property PACKAGE_PIN W20 [get_ports {adc[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[2]}]

###IO_L16P_T2_34
#set_property PACKAGE_PIN V20 [get_ports {adc[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[3]}]

###IO_L17N_T2_34
#set_property PACKAGE_PIN Y19 [get_ports {adc[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[4]}]

###IO_L17P_T2_34
#set_property PACKAGE_PIN Y18 [get_ports {adc[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[5]}]

###IO_L22N_T3_34
#set_property PACKAGE_PIN W19 [get_ports {adc[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[6]}]

###IO_L22P_T3_34
#set_property PACKAGE_PIN W18 [get_ports {adc[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {adc[7]}]