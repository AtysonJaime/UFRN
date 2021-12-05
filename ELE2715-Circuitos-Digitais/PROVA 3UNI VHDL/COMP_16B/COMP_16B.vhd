entity COMP_16B is
port(
  
  A_COMP,B_COMP : in bit_vector(15 downto 0);
  A_menor_B,A_igual_B,A_maior_B : out bit);
  
end COMP_16B;


architecture ckt of COMP_16B is
  
signal SA_igual_B15,SA_igual_B14,SA_igual_B13,SA_igual_B12,SA_igual_B11,SA_igual_B10,SA_igual_B9,SA_igual_B8,SA_igual_B7,SA_igual_B6,SA_igual_B5,SA_igual_B4,SA_igual_B3,SA_igual_B2,SA_igual_B1,SA_igual_B0 : bit;
signal SAeqB,SAgtB,SAltB : bit;

 
  
begin
  
A_igual_B <= SAeqB;
A_maior_B <= SAgtB;
A_menor_B <= SAltB;
  
  
  
SA_igual_B0 <= (A_COMP(0) xnor B_COMP(0));   
SA_igual_B1 <= (A_COMP(1) xnor B_COMP(1)); 
SA_igual_B2 <= (A_COMP(2) xnor B_COMP(2)); 
SA_igual_B3 <= (A_COMP(3) xnor B_COMP(3)); 
SA_igual_B4 <= (A_COMP(4) xnor B_COMP(4)); 
SA_igual_B5 <= (A_COMP(5) xnor B_COMP(5)); 
SA_igual_B6 <= (A_COMP(6) xnor B_COMP(6)); 
SA_igual_B7 <= (A_COMP(7) xnor B_COMP(7)); 
SA_igual_B8 <= (A_COMP(8) xnor B_COMP(8)); 
SA_igual_B9 <= (A_COMP(9) xnor B_COMP(9)); 
SA_igual_B10 <= (A_COMP(10) xnor B_COMP(10)); 
SA_igual_B11 <= (A_COMP(11) xnor B_COMP(11)); 
SA_igual_B12 <= (A_COMP(12) xnor B_COMP(12)); 
SA_igual_B13 <= (A_COMP(13) xnor B_COMP(13)); 
SA_igual_B14 <= (A_COMP(14) xnor B_COMP(14)); 
SA_igual_B15 <= (A_COMP(15) xnor B_COMP(15)); 
  
 SAeqB <= (SA_igual_B15 and  SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and SA_igual_B4 and SA_igual_B3 and SA_igual_B2 and SA_igual_B1 and SA_igual_B0);                        
 
 SAgtB <= ((A_COMP(15) and not B_COMP(15))  OR  (SA_igual_B15 and A_COMP(14) and not B_COMP(14))  OR  (SA_igual_B15  and SA_igual_B14 and A_COMP(13) and not B_COMP(13))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and A_COMP(12) and not B_COMP(12))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and A_COMP(11) and not B_COMP(11))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and A_COMP(10) and not B_COMP(10))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and A_COMP(9) and not B_COMP(9)) OR (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and A_COMP(8) and not B_COMP(8))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and A_COMP(7) and not B_COMP(7))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and A_COMP(6) and not B_COMP(6)) OR (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and A_COMP(5) and not B_COMP(5))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and A_COMP(4) and not B_COMP(4))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and SA_igual_B4 and A_COMP(3) and not B_COMP(3))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and SA_igual_B4 and SA_igual_B3 and A_COMP(2) and not B_COMP(2))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and SA_igual_B4 and SA_igual_B3 and SA_igual_B2 and A_COMP(1) and not B_COMP(1))  OR  (SA_igual_B15  and SA_igual_B14 and SA_igual_B13 and SA_igual_B12 and SA_igual_B11 and SA_igual_B10 and SA_igual_B9 and SA_igual_B8 and SA_igual_B7 and SA_igual_B6 and SA_igual_B5 and SA_igual_B4 and SA_igual_B3 and SA_igual_B2 and SA_igual_B1 and A_COMP(0) and not B_COMP(0)));



SAltB <= (SAeqB NOR SAgtB);


end ckt;
