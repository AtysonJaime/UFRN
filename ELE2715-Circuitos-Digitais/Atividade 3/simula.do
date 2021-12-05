vsim TRANSF
add wave *

force SW_in(0) 0 0ns, 1 5ns -repeat 10ns
force SW_in(1) 0 0ns, 1 10ns -repeat 20ns
force SW_in(2) 0 0ns, 1 20ns -repeat 40ns
force SW_in(3) 0 0ns, 1 40ns -repeat 80ns
force SW_in(4) 0 0ns, 1 80ns -repeat 160ns
force SW_in(5) 0 0ns, 1 160ns -repeat 320ns
force SW_in(6) 0 0ns, 1 320ns -repeat 640ns
force SW_in(7) 0 0ns, 1 640ns -repeat 1280ns



run 1280ns