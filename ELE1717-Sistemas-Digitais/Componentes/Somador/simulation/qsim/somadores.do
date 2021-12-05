onerror {quit -f}
vlib work
vlog -work work somadores.vo
vlog -work work somadores.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.SUM_2Bits_vlg_vec_tst
vcd file -direction somadores.msim.vcd
vcd add -internal SUM_2Bits_vlg_vec_tst/*
vcd add -internal SUM_2Bits_vlg_vec_tst/i1/*
add wave /*
run -all
