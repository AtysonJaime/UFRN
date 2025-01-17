library ieee ;
use ieee.std_logic_1164.all;

entity SHL_in_8Bits is
  port (Al: in std_logic_vector(7 downto 0);
        Sl: out std_logic_vector(7 downto 0));
end SHL_in_8Bits;

architecture ckt of SHL_in_8Bits is
   begin
		Sl(0) <= '0';
		Sl(7 downto 1) <= Al(6 downto 0);
end ckt;