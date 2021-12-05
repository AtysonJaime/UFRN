entity Box01 is
  port (A: in bit_vector(3 downto 0);
        S_out: out bit_vector(3 downto 0));
end Box01;


architecture ckt of Box01 is
  
begin
  
  S_out(3)<= (A(3) or (A(2) and (A(1) or A(0))));
  S_out(2)<= ((A(2) and (not A(1)) and (not A(0))) or (A(3) and A(0)));
  S_out(1)<= ((A(3) and (not A(0))) or (A(1) and ((not A(2)) or A(0))));
  S_out(0)<= (((not A(3)) and (not A(2)) and A(0)) or ((not A(0)) and (A(3) or (A(2) and A(1))))); 
end ckt;