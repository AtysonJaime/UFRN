vsim CKT4

add wave *

force A(3) 0 0ns, 1 40ns -repeat 80ns
force A(2) 0 0ns, 1 20ns -repeat 40ns
force A(1) 0 0ns, 1 10ns -repeat 20ns
force A(0) 0 0ns, 1 5ns -repeat 10ns


run 80ns