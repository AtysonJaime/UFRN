vsim SUMBCD
add wave *

force A "0001" 0ns, "0111" 10ns, "1001" 20ns


force B "0110" 0ns, "0100" 10ns, "1001" 20ns


run 40ns