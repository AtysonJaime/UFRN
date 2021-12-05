library ieee ;
use ieee.std_logic_1164.all;

entity decodificador1X16 is
  port (ld_dec: in std_logic;
		  i_in: in std_logic_vector(3 downto 0);
        d_out: out std_logic_vector(15 downto 0));
end decodificador1X16;

architecture ckt of decodificador1X16 is
  begin
    d_out(0) <= (not (i_in(3))) and (not(i_in(2))) and (not (i_in(1))) and (not(i_in(0))) and ld_dec;
	 d_out(1) <= (not (i_in(3))) and (not(i_in(2))) and (not (i_in(1))) and 	 (i_in(0)) and ld_dec;
	 d_out(2) <= (not (i_in(3))) and (not(i_in(2))) and  		(i_in(1)) and  (not(i_in(0))) and ld_dec;
	 d_out(3) <= (not (i_in(3))) and (not(i_in(2))) and  		(i_in(1)) and 	 	 (i_in(0)) and ld_dec;
	 d_out(4) <= (not (i_in(3))) and 	 (i_in(2)) and  (not (i_in(1))) and (not(i_in(0))) and ld_dec;
	 d_out(5) <= (not (i_in(3))) and 	 (i_in(2)) and  (not (i_in(1))) and  	 (i_in(0)) and ld_dec;
	 d_out(6) <= (not (i_in(3))) and 	 (i_in(2)) and  		(i_in(1)) and 	(not(i_in(0))) and ld_dec;
	 d_out(7) <= (not (i_in(3))) and 	 (i_in(2)) and  		(i_in(1)) and 	 	 (i_in(0)) and ld_dec;
	 d_out(8) <=  		(i_in(3)) and (not(i_in(2))) and  (not (i_in(1))) and (not(i_in(0))) and ld_dec;
	 d_out(9) <=  		(i_in(3)) and (not(i_in(2))) and  (not (i_in(1))) and 	 (i_in(0)) and ld_dec;
	 d_out(10) <=  	(i_in(3)) and (not(i_in(2))) and  		(i_in(1)) and  (not(i_in(0))) and ld_dec;
	 d_out(11) <=  	(i_in(3)) and (not(i_in(2))) and  		(i_in(1)) and 	 	 (i_in(0)) and ld_dec;
	 d_out(12) <=  	(i_in(3)) and 	 	(i_in(2)) and 	 (not (i_in(1))) and (not(i_in(0))) and ld_dec;
	 d_out(13) <=  	(i_in(3)) and 	 	(i_in(2)) and   (not (i_in(1))) and 	 (i_in(0)) and ld_dec;
	 d_out(14) <=  	(i_in(3)) and 	 	(i_in(2)) and  	   (i_in(1)) and  (not(i_in(0))) and ld_dec;
	 d_out(15) <=  	(i_in(3)) and 	 	(i_in(2)) and  		(i_in(1)) and  	 (i_in(0)) and ld_dec;
	 
end ckt; 