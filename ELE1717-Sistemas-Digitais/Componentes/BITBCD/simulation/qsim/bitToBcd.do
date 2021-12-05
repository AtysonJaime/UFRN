onerror {quit -f}
vlib work
vlog -work work bitToBcd.vo
vlog -work work bitToBcd.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.bitToBcd_vlg_vec_tst
vcd file -direction bitToBcd.msim.vcd
vcd add -internal bitToBcd_vlg_vec_tst/*
vcd add -internal bitToBcd_vlg_vec_tst/i1/*
add wave /*
run -all
