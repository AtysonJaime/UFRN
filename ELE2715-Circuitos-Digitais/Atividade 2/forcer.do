vsim C7SEG
add wave *

force SW(0) 0 0ns, 1 5ns -repeat 10ns
force SW(1) 0 0ns, 1 10ns -repeat 20ns
force SW(2) 0 0ns, 1 20ns -repeat 40ns
force SW(3) 0 0ns, 1 40ns -repeat 80ns

run 80ns