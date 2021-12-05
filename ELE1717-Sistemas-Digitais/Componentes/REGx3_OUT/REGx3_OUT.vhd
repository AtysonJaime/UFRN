library ieee ;
use ieee.std_logic_1164.all;

entity REGx3_OUT is
	port (clk_REGx3_OUT: in std_logic;
			dec_F_s: in std_logic_vector(1 downto 0);
			regBR_in: in std_logic_vector(7 downto 0);
			regA_out, regB_out, regC_out: out std_logic_vector(7 downto 0));
end REGx3_OUT;

architecture ckt of REGx3_OUT is

	component reg8Bits is
		port (clk_reg8bits,clr_reg8bits,ld_reg8bits: in std_logic;
				d_in_reg8bits: in std_logic_vector(7 downto 0);
				q_out_reg8bits : out std_logic_vector(7 downto 0));
	end component;
	
	component decodificador1X3 is
		port (i_in: in std_logic_vector(1 downto 0);
				d_out: out std_logic_vector(2 downto 0));
	end component;
	
	signal dec_out: std_logic_vector(2 downto 0);
	signal ld_A, ld_B, ld_C: std_logic;
	signal a_out, b_out, c_out: std_logic_vector(7 downto 0);
	
	begin
		deconder:decodificador1X3 port map( 
			i_in => dec_F_s,
			d_out => dec_out);
		
		ld_A <= dec_out(0);
		ld_B <= dec_out(1);
		ld_C <= dec_out(2);
		
		REGISTRADOR_A: reg8Bits port map(
			clk_reg8bits => clk_REGx3_OUT,
			clr_reg8bits => '0',
			ld_reg8bits => ld_A,
			d_in_reg8bits => regBR_in,
			q_out_reg8bits => a_out);
		
		REGISTRADOR_B: reg8Bits port map(
			clk_reg8bits => clk_REGx3_OUT,
			clr_reg8bits => '0',
			ld_reg8bits => ld_B,
			d_in_reg8bits => regBR_in,
			q_out_reg8bits => b_out);
		
		REGISTRADOR_C: reg8Bits port map(
			clk_reg8bits => clk_REGx3_OUT,
			clr_reg8bits => '0',
			ld_reg8bits => ld_C,
			d_in_reg8bits => regBR_in,
			q_out_reg8bits => c_out);
			
		regA_out <= a_out;
		regB_out <= b_out;
		regC_out <= c_out;
end ckt;