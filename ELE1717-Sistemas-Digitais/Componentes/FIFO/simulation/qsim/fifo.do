onerror {quit -f}
vlib work
vlog -work work fifo.vo
vlog -work work fifo.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.datapathFIFO_vlg_vec_tst
vcd file -direction fifo.msim.vcd
vcd add -internal datapathFIFO_vlg_vec_tst/*
vcd add -internal datapathFIFO_vlg_vec_tst/i1/*
add wave /*
run -all
