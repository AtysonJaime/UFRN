vsim ContadorUpDown_4bits

add wave *

force A_in "1111"
force Cle 0 0ns, 1 10ns, 0 15ns, 1 17ns
force UD 1 0ns 
force clk_ud 1 5ns, 0 7ns -repeat 15ns

run 120ns