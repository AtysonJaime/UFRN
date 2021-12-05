library ieee;
use ieee.std_logic_1164.all;

entity contador4Bits is
  port ( clk_c4B,ld_c4B,clr_c4B: in std_logic;	
         out_c4B: out std_logic_vector(3 downto 0));
end contador4Bits ;
architecture ckt of contador4Bits is
	component ffjk is
		port (clk ,J ,K ,P ,C: in std_logic;
				q: out std_logic);
	end component;
	
	signal q0_out,q1_out,q2_out,q3_out, clr_reverso: std_logic;
	signal resp_and: std_logic_vector(2 downto 0);
	
	begin
		
		clr_reverso <= not clr_c4B;
		Q0: ffjk port map(
           clk => clk_c4B,
			  J => ld_c4B,
			  K => ld_c4B,
			  P => '1',
			  C => clr_reverso,
           q => q0_out);
		
		resp_and(0) <= q0_out and ld_c4B;
		
		Q1: ffjk port map(
           clk => clk_c4B,
			  J => resp_and(0),
			  K => resp_and(0),
			  P => '1',
			  C => clr_reverso,
           q => q1_out);
		
		resp_and(1) <= q1_out and resp_and(0);
		
		Q2: ffjk port map(
           clk => clk_c4B,
			  J => resp_and(1),
			  K => resp_and(1),
			  P => '1',
			  C => clr_reverso,
           q => q2_out);
		
		resp_and(2) <= q2_out and resp_and(1);
		
		Q3: ffjk port map(
           clk => clk_c4B,
			  J => resp_and(2),
			  K => resp_and(2),
			  P => '1',
			  C => clr_reverso,
           q => q3_out);
				
		out_c4B(0) <= q0_out;
		out_c4B(1) <= q1_out;
		out_c4B(2) <= q2_out;
		out_c4B(3) <= q3_out;
			
end ckt ;