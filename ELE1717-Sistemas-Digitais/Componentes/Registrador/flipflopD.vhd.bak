library ieee ;
use ieee.std_logic_1164.all;

entity reg8Bits is
	port (clk,preSet,clr,load: in std_logic;
	d: in std_logic_vector(7 downto 0);
	q : out std_logic_vector(7 downto 0));
end reg8Bits;
architecture ckt of reg8Bits is
	
	signal qs: std_logic_vector(7 downto 0);
	
	begin
		process (clk ,preSet,clr)
		begin
			if preSet = '0' then qs <= "11111111";
			elsif clr = '0' then qs <= "00000000";
			elsif clk ='1' and clk ' event then
				if load = '1' then
					qs <= d;
				end if;
			end if;
		end process ;
		q <= qs;
end ckt;