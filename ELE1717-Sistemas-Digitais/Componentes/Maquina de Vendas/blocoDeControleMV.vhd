library ieee;
use ieee.std_logic_1164 .all;

entity blocoDeControleMV is
	port (clk_mv , rst_mv , c_mv, tot_ld: in std_logic ;
			d_mv, load_tot, clr_tot: out std_logic;
			saida: out std_logic_vector(1 downto 0));
end blocoDeControleMV;

architecture ckt of blocoDeControleMV is
	type st is (E1, E2, E3, E4);
	signal estado : st;
	begin
		process (clk_mv , rst_mv)
		begin
			if rst_mv = '1' then
				estado <= E1 ;
			elsif (clk_mv'event and clk_mv ='1') then
				case estado is
					when E1 =>
						estado <= E2;
					when E2 =>
						if c_mv='1' then estado <= E3;
						elsif tot_ld='0' then estado <= E4;
						else estado <= E2; 
						end if;
					when E3 =>
						estado <= E2;
					when E4 =>
						estado <= E1;
				end case ;
			end if;
		end process;
		d_mv <= '1' when estado = E4 else '0';
		load_tot <= '1' when estado = E3 else '0';
		clr_tot <= '1' when estado = E1 else '0';
		with estado select
			saida <= "00" when E1 ,
			"01" when E2 ,
			"11" when E4 ,
			"10" when E3 ;
end ckt ;