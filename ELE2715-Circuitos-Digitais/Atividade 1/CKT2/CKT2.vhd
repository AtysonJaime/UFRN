entity CKT2 is
  port(A: in bit_vector(3 downto 0);
       S: out bit_vector(1 downto 0));
end CKT2;

architecture circuit of CKT2 is
  begin
    S(1) <= ((A(3) XOR A(2)) OR (A(3) AND (A(2) XNOR A(1))));
    
    S(0) <= ((A(0) AND (A(2) XNOR A(1))) AND (A(3) AND (A(2) XNOR A(1)))); 
end circuit;

