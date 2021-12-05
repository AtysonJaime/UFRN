library ieee;
use ieee.std_logic_1164.all;

entity somadorb1 is 

port ( 

A,B,CIN : in std_logic;
S,CS : out std_logic);
end somadorb1;

architecture logic of somadorb1 is
 begin
  CS<=(( A and B) or (A and CIN) or ( B and CIN)); 
  S<=(A xor B xor CIN);
 
 end logic;
       
