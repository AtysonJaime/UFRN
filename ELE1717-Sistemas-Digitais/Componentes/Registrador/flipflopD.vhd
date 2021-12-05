library ieee ;
use ieee.std_logic_1164.all;

entity flipflopD is
	port (clk,preSet,clr,load,d: in std_logic;
	q : out std_logic);
end flipflopD;
architecture ckt of flipflopD is
	
	signal qs: std_logic;
	
	begin
		process (clk ,preSet,clr)
		begin
			if preSet = '0' then qs <= '1';
			elsif clr = '0' then qs <= '0';
			elsif clk ='1' and clk ' event then
				if load = '1' then
					qs <= d;
				end if;
			end if;
		end process ;
		q <= qs;
end ckt;