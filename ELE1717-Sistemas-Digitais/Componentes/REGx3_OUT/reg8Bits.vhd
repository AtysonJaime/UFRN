library ieee ;
use ieee.std_logic_1164.all;

entity reg8Bits is
	port (clk_reg8bits,clr_reg8bits,ld_reg8bits: in std_logic;
			d_in_reg8bits: in std_logic_vector(7 downto 0);
			q_out_reg8bits : out std_logic_vector(7 downto 0));
end reg8Bits;
architecture ckt of reg8Bits is
	
	component flipflopD is
		port (clk,preSet,clr,load,d: in std_logic;
				q : out std_logic);
	end component;
	signal reg_out: std_logic_vector(7 downto 0);
	
	begin
		ffd00: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(0),
			q => reg_out(0));
		ffd01: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(1),
			q => reg_out(1));
		ffd02: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(2),
			q => reg_out(2));
		ffd03: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(3),
			q => reg_out(3));
		ffd04: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(4),
			q => reg_out(4));
		ffd05: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(5),
			q => reg_out(5));
		ffd06: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(6),
			q => reg_out(6));
		ffd07: flipflopD port map(
			clk => clk_reg8bits,
			preSet => '1',
			clr => not clr_reg8bits,
			load => ld_reg8bits,
			d => d_in_reg8bits(7),
			q => reg_out(7));
			
		
		q_out_reg8bits <= reg_out;	
end ckt;