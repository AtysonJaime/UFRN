vsim CCompleto

add wave *

force A "1001"
force Ebl 1 2ns, 0 3ns
force K "00" 0ns, "11" 1ns 
force clk 1 5ns, 0 7ns -repeat 7ns

run 120ns