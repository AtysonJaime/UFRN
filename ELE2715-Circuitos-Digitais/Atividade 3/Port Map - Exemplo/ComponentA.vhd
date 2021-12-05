entity Box01 is
  port (A_in: in bit_vector(3 downto 0);
        S_out: out bit_vector(3 downto 0));
end Box01;


architecture ckt of Box01 is
  
begin
  
  S_out(3)<= A_in(3) or A_in(2);
  S_out(2)<= A_in(2) xor A_in(1);
  S_out(1)<= A_in(0) nor A_in(2);
  S_out(0)<= A_in(1) xnor A_in(0);
  
end ckt;