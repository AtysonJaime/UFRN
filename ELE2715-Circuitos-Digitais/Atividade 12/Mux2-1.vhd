entity MUX2_1 is
  port (I_1,I_0,S: in bit;
        d: out bit);
end MUX2_1;

Architecture ckt of MUX2_1 is
  
Begin
  d <= (((not S) and I_0) or (S and I_1));    
end ckt;
