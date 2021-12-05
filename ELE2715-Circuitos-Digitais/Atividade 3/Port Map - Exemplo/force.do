vsim Schematic
add wave *

force S_in "00001111" 0ns, "11110000" 10ns, "10100011" 20ns

run 20ns
