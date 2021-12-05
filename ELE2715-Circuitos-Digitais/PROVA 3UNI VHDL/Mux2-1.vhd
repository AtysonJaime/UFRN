entity MUX2_1 is
  port (I1,I0,S: in bit;
        d: out bit);
end MUX2_1;

Architecture ckt of MUX2_1 is
  
Begin
  d <= (((not S) and I0) or (S and I1));    
end ckt;
