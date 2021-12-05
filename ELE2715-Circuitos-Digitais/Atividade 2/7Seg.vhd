entity C7Seg is
  port(SW: in bit_vector(3 downto 0);
       HEX: out bit_vector(6 downto 0));
end C7Seg;

architecture display of C7Seg is
  begin    
    HEX(6) <= ((not(SW(3))) OR ((not(SW(2))) AND SW(1) AND (not(SW(0)))) OR ((not(SW(1))) AND (SW(2) OR SW(0))));
        
    HEX(5) <= not SW(0) OR (not SW(1) AND (SW(3) OR not SW(2)));
    
    HEX(4) <= ((not SW(0)) OR ((not SW(3)) AND ((SW(1) AND (not SW(2))) OR ((not SW(1)) AND SW(2)))));
    
    HEX(3) <= ((SW(3) AND (not SW(1)) AND (not SW(2))) OR ((not SW(3)) AND (SW(1) OR SW(2))) OR (SW(1) AND (SW(3) NAND SW(0))));
    
    HEX(2) <= (((not SW(3)) AND (not SW(0)) AND SW(2)) OR (SW(0) AND (SW(1) OR (not SW(2)))) OR (SW(3) AND (SW(2) NAND SW(1))));

    HEX(1) <= ((SW(0) AND ((not SW(3)) OR SW(2))) OR (SW(3) AND ((SW(1) NOR SW(0)) OR (SW(1) AND (not SW(2))))));
    
    HEX(0) <= ((SW(3) AND (SW(1) NAND SW(0))) OR (SW(2) NOR SW(0)) OR (SW(2) AND (SW(0) OR (not SW(1)))));  

end display;