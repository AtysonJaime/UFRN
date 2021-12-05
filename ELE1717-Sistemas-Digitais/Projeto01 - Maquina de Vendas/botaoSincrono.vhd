library ieee ;
use ieee.std_logic_1164.all;
entity botaoSincrono is
	port (clk, b_in: in std_logic ;
			b_out: out std_logic );
end botaoSincrono ;

architecture ckt of botaoSincrono is
	type state_type is (E1, E2, E3); 
	signal y_present , y_next : state_type ;
	begin
		process (b_in, y_present )
		begin
			case y_present is
				when E1 =>
					if b_in = '0' then y_next <= E1;
					else y_next <= E2; end if;
				when E2 =>
					if b_in = '0' then y_next <= E1;
					else y_next <= E3; end if;
				when E3 =>
					if b_in = '0' then y_next <= E1;
					else y_next <= E3; end if;
			end case ;
		end process ;
		process (clk)
		begin
			if (clk'event and clk = '1') then
				y_present <= y_next;
			end if;
		end process;
		b_out <= '1' when y_present = E2 else '0';
end ckt;