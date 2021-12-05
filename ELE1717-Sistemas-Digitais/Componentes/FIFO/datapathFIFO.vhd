library ieee ;
use ieee.std_logic_1164.all;

entity datapathFIFO is
  port (wr_data_dp: in std_logic_vector(12 downto 0);
		  ld_wr_dp, ld_rd_dp, clr_fifo_dp, clk_fifo_dp: in std_logic;
		  eq_comp_wr_rd,eq_comp_wr1_rd,eq_comp_wr_rd1 : out std_logic;
		  rd_data_dp: out std_logic_vector(12 downto 0));
end datapathFIFO;

architecture ckt of datapathFIFO is
	component bancoDeRegistrador16X13 is
	  port (wr_data: in std_logic_vector(12 downto 0);
			  cont_wr,cont_rd: in std_logic_vector(3 downto 0); 
			  clk_br, ld_wr, ld_rd, clr_reg: in std_logic;
			  rd_data: out std_logic_vector(12 downto 0));
	end component;
	
	component Comparador_4Bits is
	  port (eA,eB: in std_logic_vector(3 downto 0);
			  gt,lt,eq: in std_logic;
			  AeqB,AltB,AgtB: out std_logic);
	end component;
	
	component contador4Bits is
	  port ( clk_c4B,ld_c4B,clr_c4B: in std_logic;	
				out_c4B: out std_logic_vector(3 downto 0));
	end component;
	
	component SUM_4Bits is
	  port (A4_in,B4_in: in std_logic_vector(3 downto 0);
			  C4_in: in std_logic;
			  S4_out: out std_logic_vector(3 downto 0);
			  C4_out: out std_logic);
	end component;
	
	signal saida_cont_wr, saida_cont_rd: std_logic_vector(3 downto 0);
	signal saida_sum_wr, saida_sum_rd: std_logic_vector(3 downto 0);
	signal saida_bancoRegistradores: std_logic_vector(12 downto 0);
	signal clr_reverso_reg: std_logic;
	signal lixo: std_logic_vector(1 downto 0);
	signal saida_eq_comparador_wd_com_rd, saida_ld_comparador_wd_com_rd, saida_gt_comparador_wd_com_rd: std_logic;
	signal saida_eq_comparador_wd1_com_rd, saida_ld_comparador_wd1_com_rd, saida_gt_comparador_wd1_com_rd: std_logic;
	signal saida_eq_comparador_wd_com_rd1, saida_ld_comparador_wd_com_rd1, saida_gt_comparador_wd_com_rd1: std_logic;
	
	begin
		
		clr_reverso_reg <= not clr_fifo_dp;
		
		BancoDeRegistradores: bancoDeRegistrador16X13 port map(
			wr_data => wr_data_dp,
			cont_wr => saida_cont_wr,
			cont_rd => saida_cont_rd, 
			clk_br => clk_fifo_dp, 
			ld_wr => ld_wr_dp,
			ld_rd => ld_rd_dp, 
			clr_reg => clr_reverso_reg,
			rd_data => saida_bancoRegistradores);
		
		Contador_WR: contador4Bits port map(
			clk_c4B => clk_fifo_dp,
			ld_c4B => ld_wr_dp,
			clr_c4B => clr_fifo_dp,	
			out_c4B => saida_cont_wr);
		
		Contador_RD: contador4Bits port map(
			clk_c4B => clk_fifo_dp,
			ld_c4B => ld_rd_dp,
			clr_c4B => clr_fifo_dp,
			out_c4B => saida_cont_rd);
		
		comparador_wr_com_rd: Comparador_4Bits port map(
			eA => saida_cont_wr,
			eB => saida_cont_rd,
			gt => '0',
			lt => '0',
			eq => '1',
			AeqB => saida_eq_comparador_wd_com_rd,
			AltB => saida_ld_comparador_wd_com_rd,
			AgtB => saida_gt_comparador_wd_com_rd);
		
		comparador_wr1_com_rd: Comparador_4Bits port map(
			eA => saida_sum_wr,
			eB => saida_cont_rd,
			gt => '0',
			lt => '0',
			eq => '1',
			AeqB => saida_eq_comparador_wd1_com_rd,
			AltB => saida_ld_comparador_wd1_com_rd,
			AgtB => saida_gt_comparador_wd1_com_rd);
		
		comparador_wr_com_rd1: Comparador_4Bits port map(
			eA => saida_cont_wr,
			eB => saida_sum_rd,
			gt => '0',
			lt => '0',
			eq => '1',
			AeqB => saida_eq_comparador_wd_com_rd1,
			AltB => saida_ld_comparador_wd_com_rd1,
			AgtB => saida_gt_comparador_wd_com_rd1);
		
		somador_wr1: SUM_4Bits port map(
			A4_in => saida_cont_wr,
			B4_in => "0001",
			C4_in => '0',
			S4_out => saida_sum_wr,
			C4_out => lixo(0));
		
		somador_rd1: SUM_4Bits port map(
			A4_in => saida_cont_rd,
			B4_in => "0001",
			C4_in => '0',
			S4_out => saida_sum_rd,
			C4_out => lixo(1));
		
		
		rd_data_dp <= saida_bancoRegistradores;
		eq_comp_wr_rd <= saida_eq_comparador_wd_com_rd;
		eq_comp_wr1_rd <= saida_eq_comparador_wd1_com_rd;
		eq_comp_wr_rd1 <= saida_eq_comparador_wd_com_rd1;
		
end ckt;