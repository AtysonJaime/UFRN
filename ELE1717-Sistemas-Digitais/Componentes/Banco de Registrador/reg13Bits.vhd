library ieee ;
use ieee.std_logic_1164.all;

entity reg13Bits is
	port (clk,preSet,clr,load: in std_logic;
	d: in std_logic_vector(12 downto 0);
	q : out std_logic_vector(12 downto 0));
end reg13Bits;
architecture ckt of reg13Bits is
	
	signal qs: std_logic_vector(12 downto 0);
	
	begin
		process (clk ,preSet,clr)
		begin
			if preSet = '0' then qs <= "1111111111111";
			elsif clr = '0' then qs <= "0000000000000";
			elsif clk ='1' and clk ' event then
				if load = '1' then
					qs <= d;
				end if;
			end if;
		end process ;
		q <= qs;
end ckt;