vsim Encaps_TIMER

add wave *

force Timer_EN '1' 0ns, '0' 2ns -repeat 10ns
force Timer_RST '0' 0ns, '1' 1ns
force Timer_CLK '0' 0ns, '1' 1ns -repeat 5ns
force MX_Timer "11" 0ns

run 300ns