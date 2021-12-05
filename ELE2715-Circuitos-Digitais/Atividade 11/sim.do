vsim Maquina_de_Vendas

add wave *

force Clk 1 0.1ns, 0 2ns -repeat 5ns
force clr 0 0ns, 1 1ns
force S "01010010" 0ns
force A "00101000" 0ns
force c 0 0ns, 1 10ns, 0 12ns, 1 20ns, 0 21ns, 1 30ns, 0 31ns


run 65ns
