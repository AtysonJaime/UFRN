vsim Registrador

add wave *


force load 1 0ns, 0 5ns, 1 40ns
force shr 0 0ns, 1 10ns, 0 20ns, 1 40ns
force shl 0 0ns, 1 30ns
force set 0 0ns, 1 25ns
force clr 0 0ns, 1 20ns
force shr_in 1 0ns
force shl_in 0 0ns 
force I "0101" 0ns
force Clk 1 0.1ns, 0 2ns -repeat 5ns


run 43ns