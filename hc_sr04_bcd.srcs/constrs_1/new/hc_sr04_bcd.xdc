## Configuration options, can be used for all designs
set_property -dict {CONFIG_VOLTAGE 3.3 CFGBVS VCCO} [current_design];
set_property IOSTANDARD LVCMOS33 [get_port *];


## On-board CLK 100MHz
create_clock -name CLK -period 10 [get_nets CLK];
set_property PACKAGE_PIN W5 [get_port CLK];


## Push SW BTNC
set_property PACKAGE_PIN U17 [get_port SW];     #BTND
set_property PACKAGE_PIN U18 [get_port RST];    #BTNC


## SEG
set_property PACKAGE_PIN V7 [get_port {SEG[7]}];
set_property PACKAGE_PIN U7 [get_port {SEG[6]}];
set_property PACKAGE_PIN V5 [get_port {SEG[5]}];
set_property PACKAGE_PIN U5 [get_port {SEG[4]}];
set_property PACKAGE_PIN V8 [get_port {SEG[3]}];
set_property PACKAGE_PIN U8 [get_port {SEG[2]}];
set_property PACKAGE_PIN W6 [get_port {SEG[1]}];
set_property PACKAGE_PIN W7 [get_port {SEG[0]}];


## Tr
set_property PACKAGE_PIN W4 [get_port {Tr[3]}];
set_property PACKAGE_PIN V4 [get_port {Tr[2]}];
set_property PACKAGE_PIN U4 [get_port {Tr[1]}];
set_property PACKAGE_PIN U2 [get_port {Tr[0]}];


## HC-SR04(左側に取り付ける場合)
#set_property PACKAGE_PIN J1 [get_port TRIG];   # JA1
#set_property PACKAGE_PIN L2 [get_port ECHO];   # JA2

## HC-SR04(右側に取り付ける場合)
set_property PACKAGE_PIN L17 [get_port TRIG];   # JC7
set_property PACKAGE_PIN M19 [get_port ECHO];   # JC8

