library ieee ;
use ieee.std_logic_1164.all;

entity MUX2_1_13Bits is
  port (I_1,I_0: std_logic_vector(12 downto 0);
		  S, ld_mux: in std_logic;
        d: out std_logic_vector(12 downto 0));
end MUX2_1_13Bits;

Architecture ckt of MUX2_1_13Bits is
  
Begin
  d(0) <= ((((not S) and I_0(0)) or (S and I_1(0)))) and ld_mux;
  d(1) <= ((((not S) and I_0(1)) or (S and I_1(1)))) and ld_mux;
  d(2) <= ((((not S) and I_0(2)) or (S and I_1(2)))) and ld_mux;
  d(3) <= ((((not S) and I_0(3)) or (S and I_1(3)))) and ld_mux;
  d(4) <= ((((not S) and I_0(4)) or (S and I_1(4)))) and ld_mux;
  d(5) <= ((((not S) and I_0(5)) or (S and I_1(5)))) and ld_mux;
  d(6) <= ((((not S) and I_0(6)) or (S and I_1(6)))) and ld_mux;
  d(7) <= ((((not S) and I_0(7)) or (S and I_1(7)))) and ld_mux;
  d(8) <= ((((not S) and I_0(8)) or (S and I_1(8)))) and ld_mux;
  d(9) <= ((((not S) and I_0(9)) or (S and I_1(9)))) and ld_mux;
  d(10) <= ((((not S) and I_0(10)) or (S and I_1(10)))) and ld_mux;
  d(11) <= ((((not S) and I_0(11)) or (S and I_1(11)))) and ld_mux;
  d(12) <= ((((not S) and I_0(12)) or (S and I_1(12)))) and ld_mux;
  
end ckt;