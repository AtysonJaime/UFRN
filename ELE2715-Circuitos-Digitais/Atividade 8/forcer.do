vsim CircuitoCompleto

add wave *

force A "0001"
force B "1011"
force EN 1 2ns, 0 3ns
force Cle 0 0ns, 1 1ns
force clk 1 5ns, 0 7ns -repeat 7ns

run 200ns