entity CKT3 is
  port(A: in bit_vector(3 downto 0);
       S: out bit_vector(1 downto 0));
end CKT3;

architecture circuit of CKT3 is
  begin
    S(1) <= ((A(3) OR A(2)) XNOR (A(3) XOR (A(2) AND A(1))));
    
    S(0) <= ((A(0) OR (A(2) AND A(1))) OR (A(3) XOR (A(2) AND A(1)))); 
end circuit;
