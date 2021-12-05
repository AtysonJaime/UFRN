library ieee;
use ieee.std_logic_1164.all;

entity ciBitToBcd is
  port (BtB_in: in bit_vector(3 downto 0);
        BtB_out: out bit_vector(3 downto 0));
end ciBitToBcd;

architecture ckt of ciBitToBcd is
begin
  BtB_out(3) <= (BtB_in(3) or (BtB_in(2) and (BtB_in(1) or BtB_in(0))));
  BtB_out(2)<= ((BtB_in(2) and (not BtB_in(1)) and (not BtB_in(0))) or (BtB_in(3) and BtB_in(0)));
  BtB_out(1)<= ((BtB_in(3) and (not BtB_in(0))) or (BtB_in(1) and ((not BtB_in(2)) or BtB_in(0))));
  BtB_out(0)<= (((not BtB_in(3)) and (not BtB_in(2)) and BtB_in(0)) or ((not BtB_in(0)) and (BtB_in(3) or (BtB_in(2) and BtB_in(1))))); 
end ckt;
