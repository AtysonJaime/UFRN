library ieee ;
use ieee.std_logic_1164.all;

entity MUX2_1_8Bits is
  port (I_1,I_0: std_logic_vector(7 downto 0);
		  S: in std_logic;
        d: out std_logic_vector(7 downto 0));
end MUX2_1_8Bits;

Architecture ckt of MUX2_1_8Bits is
  
Begin
  d(0) <= ((((not S) and I_0(0)) or (S and I_1(0))));
  d(1) <= ((((not S) and I_0(1)) or (S and I_1(1))));
  d(2) <= ((((not S) and I_0(2)) or (S and I_1(2))));
  d(3) <= ((((not S) and I_0(3)) or (S and I_1(3))));
  d(4) <= ((((not S) and I_0(4)) or (S and I_1(4))));
  d(5) <= ((((not S) and I_0(5)) or (S and I_1(5))));
  d(6) <= ((((not S) and I_0(6)) or (S and I_1(6))));
  d(7) <= ((((not S) and I_0(7)) or (S and I_1(7))));
  
end ckt;