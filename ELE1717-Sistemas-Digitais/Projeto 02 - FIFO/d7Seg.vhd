library ieee;
use ieee.std_logic_1164.all;

entity d7Seg is
  port(S_in: in std_logic_vector(3 downto 0);
       D_out: out std_logic_vector(6 downto 0));
end d7Seg;

architecture display of d7Seg is
  begin    
    D_out(0) <= not ((S_in(3) or S_in(1) or (S_in(2) and S_in(0)) or (S_in(2) nor S_in(0))));
        
    D_out(1) <= not (((not S_in(2)) or (S_in(1) nor S_in(0)) or (S_in(1) and S_in(0))));
    
    D_out(2) <= not (((not(S_in(3)) and ((S_in(1) and S_in(0)) or S_in(2))) or (not(S_in(2) or S_in(1)))));
    
    D_out(3) <= not((S_in(3) or (S_in(1) and (S_in(2) nand S_in(0))) or (S_in(2) nor S_in(0)) or (S_in(2) and (not S_in(1)) and S_in(0))));
    
    D_out(4) <= not (((S_in(1) and (not S_in(0))) or (S_in(2) nor S_in(0))));

    D_out(5) <= not ((S_in(3) or (S_in(1) nor S_in(0)) or (S_in(2) and (S_in(1) nand S_in(0)))));
    
    D_out(6) <= not ((S_in(3) or (S_in(1) and (not S_in(2))) or (S_in(2) and (S_in(1) nand S_in(0)))));  

end display;