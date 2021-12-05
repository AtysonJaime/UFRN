vsim Potencia

add wave *

force A "10001" 0ns, "01111" 40ns
force B "00" 0ns, "01" 10ns, "10" 20ns, "11" 30ns, "00" 40ns, "01" 50ns, "10" 60ns, "11" 70ns

run 80ns