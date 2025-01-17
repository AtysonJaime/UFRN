entity C7Seg is
  port(S_in: in bit_vector(3 downto 0);
       T_out: out bit_vector(6 downto 0));
end C7Seg;

architecture display of C7Seg is
  begin    
    T_out(6) <= (S_in(3) or S_in(1) or (S_in(2) and S_in(0)) or (S_in(2) nor S_in(0)));
        
    T_out(5) <= ((not S_in(2)) or (S_in(1) nor S_in(0)) or (S_in(1) and S_in(0)));
    
    T_out(4) <= ((not(S_in[3]) and ((S_in[1] and S_in[0]) or S_in[2])) or (not(S_in[2] or S_in[1])));
    
    T_out(3) <= (S_in(3) or (S_in(1) and (S_in(2) nand S_in(0))) or (S_in(2) nor S_in(0)) or (S_in(2) and (not S_in(1)) and S_in(0)));
    
    T_out(2) <= ((S_in(1) and (not S_in(0))) or (S_in(2) nor S_in(0)));

    T_out(1) <= (S_in(3) or (S_in(1) nor S_in(0)) or (S_in(2) and (S_in(1) nand S_in(0))));
    
    T_out(0) <= (S_in(3) or (S_in(1) and (not S_in(2))) or (S_in(2) and (S_in(1) nand S_in(0))));  

end display;