vsim RTL_SAD

add wave *

force A "00000010" 0ns
force B "00000110" 0ns
force Clk 1 1ns, 0 4ns -repeat 4ns
force CLE 0 0ns, 1 1ns
force c 0 0ns, 1 3ns, 0 6ns, 1 171ns, 0 173ns
 
run 190ns
