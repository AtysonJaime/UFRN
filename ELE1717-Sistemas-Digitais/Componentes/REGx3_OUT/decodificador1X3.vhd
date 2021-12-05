library ieee ;
use ieee.std_logic_1164.all;

entity decodificador1X3 is
  port (i_in: in std_logic_vector(1 downto 0);
        d_out: out std_logic_vector(2 downto 0));
end decodificador1X3;

architecture ckt of decodificador1X3 is
  begin
	d_out(0) <= (not i_in(1)) and (not i_in(0));
	d_out(1) <= (not i_in(1)) and (i_in(0));
	d_out(2) <= (i_in(1)) and (not i_in(0));
 end ckt;