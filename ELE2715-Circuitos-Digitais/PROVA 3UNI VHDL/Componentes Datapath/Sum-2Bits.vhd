library ieee;
use ieee.std_logic_1164.all;

entity Sum2Bit is
  port (A_in,B_in,C_in: in std_logic;
        S_out, C_out: out std_logic);
end Sum2Bit;

Architecture ckt of Sum2Bit is
  
Begin
  
  S_out <= ((B_in and ((C_in nor A_in) or (C_in and A_in))) or ((not B_in) and (((not C_in) and A_in) or (C_in and (not A_in)))));
  C_out <= ((C_in and (A_in or B_in)) or (A_in and B_in)); 
  
end ckt;
