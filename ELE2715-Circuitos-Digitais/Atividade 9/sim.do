vsim MDE

add wave *


force u 0 0ns, 1 5ns -repeat 10ns
force y 1 0ns, 0 40ns
force Cle 0 0ns, 1 0.05ns
force Clk 1 0.1ns, 0 1.0ns -repeat 5ns


run 80ns
