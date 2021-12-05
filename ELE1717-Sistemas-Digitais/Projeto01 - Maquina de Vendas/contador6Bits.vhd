library ieee;
use ieee.std_logic_1164.all;

entity contador6Bits is
  port ( clk_c6B,ld_c6B,clr_c6B: in std_logic;	
         out_c6B: out std_logic_vector(5 downto 0));
end contador6Bits ;
architecture ckt of contador6Bits is
	component ffjk is
		port (clk ,J ,K ,P ,C: in std_logic;
				q: out std_logic);
	end component;
	
	signal q0_out,q1_out,q2_out,q3_out,q4_out,q5_out, clr_reverso: std_logic;
	signal resp_and: std_logic_vector(4 downto 0);
	
	begin
		
		clr_reverso <= not clr_c6B;
		Q0: ffjk port map(
           clk => clk_c6B,
			  J => ld_c6B,
			  K => ld_c6B,
			  P => '1',
			  C => clr_reverso,
           q => q0_out);
		
		resp_and(0) <= q0_out and ld_c6B;
		
		Q1: ffjk port map(
           clk => clk_c6B,
			  J => resp_and(0),
			  K => resp_and(0),
			  P => '1',
			  C => clr_reverso,
           q => q1_out);
		
		resp_and(1) <= q1_out and resp_and(0);
		
		Q2: ffjk port map(
           clk => clk_c6B,
			  J => resp_and(1),
			  K => resp_and(1),
			  P => '1',
			  C => clr_reverso,
           q => q2_out);
		
		resp_and(2) <= q2_out and resp_and(1);
		
		Q3: ffjk port map(
           clk => clk_c6B,
			  J => resp_and(2),
			  K => resp_and(2),
			  P => '1',
			  C => clr_reverso,
           q => q3_out);
		
		resp_and(3) <= q3_out and resp_and(2);
		
		Q4: ffjk port map(
           clk => clk_c6B,
			  J => resp_and(3),
			  K => resp_and(3),
			  P => '1',
			  C => clr_reverso,
           q => q4_out);
		
		resp_and(4) <= q4_out and resp_and(3);
		
		Q5: ffjk port map(
           clk => clk_c6B,
			  J => resp_and(4),
			  K => resp_and(4),
			  P => '1',
			  C => clr_reverso,
           q => q5_out);
		
		out_c6B(0) <= q0_out;
		out_c6B(1) <= q1_out;
		out_c6B(2) <= q2_out;
		out_c6B(3) <= q3_out;
		out_c6B(4) <= q4_out;
		out_c6B(5) <= q5_out;
		
		
end ckt ;