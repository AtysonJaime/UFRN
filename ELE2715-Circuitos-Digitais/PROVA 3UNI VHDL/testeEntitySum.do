vsim Encaps_MUX_SUM

add wave *

force M0 "0000000000000000" 0ns
force M1 "1000000000000000" 0ns
force M2 "0100000000000000" 0ns
force M3 "0010000000000000" 0ns
force M4 "0001000000000000" 0ns
force M5 "0000100000000000" 0ns
force M6 "0000010000000000" 0ns
force M7 "0000001000000000" 0ns
force M8 "0000000100000000" 0ns
force M9 "0000000010000000" 0ns
force M10 "0000000010000000" 0ns
force M11 "0000000001000000" 0ns
force M12 "0000000000100000" 0ns
force M13 "0000000000010000" 0ns
force M14 "0000000000001000" 0ns
force M15 "0000000000000100" 0ns
force N0 "0000000000000000" 0ns
force N1 "1000000000000000" 0ns
force N2 "0100000000000000" 0ns
force N3 "0010000000000000" 0ns
force N4 "0001000000000000" 0ns
force N5 "0000100000000000" 0ns
force N6 "0000010000000000" 0ns
force N7 "0000001000000000" 0ns
force N8 "0000000100000000" 0ns
force N9 "0000000010000000" 0ns
force N10 "0000000010000000" 0ns
force N11 "0000000001000000" 0ns
force N12 "0000000000100000" 0ns
force N13 "0000000000010000" 0ns
force N14 "0000000000001000" 0ns
force N15 "0000000000000100" 0ns
force MX_SUM_A "0010" 0ns, "0000" 10ns, "1111" 20ns
force MX_SUM_B "0100" 0ns, "0000" 10ns, "0001" 20ns
force Cin '0' 0ns

run 30ns;