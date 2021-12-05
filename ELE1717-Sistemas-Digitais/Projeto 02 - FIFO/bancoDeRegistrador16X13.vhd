library ieee ;
use ieee.std_logic_1164.all;

entity bancoDeRegistrador16X13 is
  port (wr_data: in std_logic_vector(12 downto 0);
		  cont_wr,cont_rd: in std_logic_vector(3 downto 0); 
		  clk_br, ld_wr, ld_rd, clr_reg: in std_logic;
        rd_data: out std_logic_vector(12 downto 0));
end bancoDeRegistrador16X13;

architecture ckt of bancoDeRegistrador16X13 is
	component MUX16_1_13Bits is
		port (I15_16, I14_16, I13_16, I12_16, I11_16, I10_16, I9_16, I8_16, I7_16: std_logic_vector(12 downto 0);
				I6_16, I5_16, I4_16, I3_16, I2_16, I1_16, I0_16: std_logic_vector(12 downto 0);
				S_16: in std_logic_vector(3 downto 0); 
				ld_mux_16: in std_logic;
				d_16: out std_logic_vector(12 downto 0));
	end component;
	
	component decodificador1X16 is
		port (ld_dec: in std_logic;
				i_in: in std_logic_vector(3 downto 0);
				d_out: out std_logic_vector(15 downto 0));
	end component;
	
	component reg13Bits is
		port (clk,preSet,clr,load: in std_logic;
				d: in std_logic_vector(12 downto 0);
				q: out std_logic_vector(12 downto 0));
	end component;
	

	signal saida_reg_00, saida_reg_01, saida_reg_02, saida_reg_03, saida_reg_04, saida_reg_05, saida_reg_06, saida_reg_07: std_logic_vector(12 downto 0);
	signal saida_reg_08, saida_reg_09, saida_reg_10, saida_reg_11, saida_reg_12, saida_reg_13, saida_reg_14, saida_reg_15, saida_mux: std_logic_vector(12 downto 0);
	signal saida_decod: std_logic_vector(15 downto 0);
	
	begin
		Dec_wr: decodificador1X16 port map(
			ld_dec => ld_wr,
			i_in => cont_wr,
			d_out => saida_decod);
		
		Reg00: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(0),
			d => wr_data,
			q => saida_reg_00);
		
		Reg01: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(1),
			d => wr_data,
			q => saida_reg_01);
		
		Reg02: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(2),
			d => wr_data,
			q => saida_reg_02);
		
		Reg03: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(3),
			d => wr_data,
			q => saida_reg_03);
		
		Reg04: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(4),
			d => wr_data,
			q => saida_reg_04);
		
		Reg05: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(5),
			d => wr_data,
			q => saida_reg_05);
		
		Reg06: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(6),
			d => wr_data,
			q => saida_reg_06);
		
		Reg07: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(7),
			d => wr_data,
			q => saida_reg_07);
		
		Reg08: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(8),
			d => wr_data,
			q => saida_reg_08);
		
		Reg09: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(9),
			d => wr_data,
			q => saida_reg_09);
		
		Reg10: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(10),
			d => wr_data,
			q => saida_reg_10);
		
		Reg11: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(11),
			d => wr_data,
			q => saida_reg_11);
		
		Reg12: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(12),
			d => wr_data,
			q => saida_reg_12);
		
		Reg13: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(13),
			d => wr_data,
			q => saida_reg_13);
		
		Reg14: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(14),
			d => wr_data,
			q => saida_reg_14);
		
		Reg15: reg13Bits port map(
			clk => clk_br,
			preSet => '1',
			clr => clr_reg,
			load => saida_decod(15),
			d => wr_data,
			q => saida_reg_15);
		
		MUX_rd: mux16_1_13Bits port map(
			I15_16 => saida_reg_15,
			I14_16 => saida_reg_14,
			I13_16 => saida_reg_13,
			I12_16 => saida_reg_12,
			I11_16 => saida_reg_11,
			I10_16 => saida_reg_10,
			I9_16 => saida_reg_09,
			I8_16 => saida_reg_08,
			I7_16 => saida_reg_07,
			I6_16 => saida_reg_06,
			I5_16 => saida_reg_05,
			I4_16 => saida_reg_04,
			I3_16 => saida_reg_03,
			I2_16 => saida_reg_02,
			I1_16 => saida_reg_01,
			I0_16 => saida_reg_00,
			S_16 => cont_rd, 
			ld_mux_16 => ld_rd,
			d_16 => saida_mux);
		
		rd_data <= saida_mux;
end ckt;