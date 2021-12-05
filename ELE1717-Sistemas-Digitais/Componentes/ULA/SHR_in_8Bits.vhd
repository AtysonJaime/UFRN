library ieee ;
use ieee.std_logic_1164.all;

entity SHR_in_8Bits is
  port (Ar: in std_logic_vector(7 downto 0);
        Sr: out std_logic_vector(7 downto 0));
end SHR_in_8Bits;

architecture ckt of SHR_in_8Bits is
   begin
		Sr(7) <= '0';
		Sr(6 downto 0) <= Ar(7 downto 1);
end ckt;