entity Mult_linha is
  port (L: in bit_vector(7 downto 0);
        C: in bit;
        R: out bit_vector(7 downto 0));
end Mult_linha;

Architecture ckt of Mult_linha is
  
Begin
  R(7) <= L(7) and C;
  R(6) <= L(6) and C;
  R(5) <= L(5) and C;
  R(4) <= L(4) and C;
  R(3) <= L(3) and C;
  R(2) <= L(2) and C;
  R(1) <= L(1) and C;
  R(0) <= L(0) and C;    
end ckt;

