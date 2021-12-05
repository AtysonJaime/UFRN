vsim Encaps_BancoContador

add wave *

force End_Banco "0000" 0ns, "0001" 10ns, "0010" 20ns, "0011" 30ns, "0100" 40ns -repeat 80ns
force En_Banco '1' 0ns, '0' 2ns
force RST_Banco '0' 0ns,'1' 1ns
force UD_Banco '0' 0ns
force CLK_Banco '0' 0ns, '1' 1ns -repeat 5ns

run 200ns