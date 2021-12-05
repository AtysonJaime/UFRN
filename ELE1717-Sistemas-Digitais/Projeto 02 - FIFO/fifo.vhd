library ieee ;
use ieee.std_logic_1164.all;

entity fifo is
	port (CLK_fifo, WR, RD, reset: in std_logic; 
			W_data: in std_logic_vector(12 downto 0);
			em,fu: out std_logic;
			R_data: out std_logic_vector(12 downto 0);
			Estados_maquina: out std_logic_vector(2 downto 0));
end fifo;

architecture ckt of fifo is
	
	component blocoDeControleFIFO is 
		port (clk_ff, rst_ff, rd_ff, wr_ff: in std_logic;
				equal_cont_wd_e_rd, equal_cont_wd_1_e_rd, equal_cont_wd_e_rd_1: in std_logic;
				led_vazio_ff, led_cheio_ff,load_wr,load_rd,clr_ff: out std_logic;
				saida_mv_fifo: out std_logic_vector(2 downto 0));
	end component;
	
	component datapathFIFO is
	  port (wr_data_dp: in std_logic_vector(12 downto 0);
			  ld_wr_dp, ld_rd_dp, clr_fifo_dp, clk_fifo_dp: in std_logic;
			  eq_comp_wr_rd,eq_comp_wr1_rd,eq_comp_wr_rd1: out std_logic;
			  rd_data_dp: out std_logic_vector(12 downto 0));
	end component;
	
	
	signal leitura_banco_registradores: std_logic_vector(12 downto 0);
	signal l_vazio, l_cheio, saida_load_wr, saida_load_rd, clr_dt : std_logic;
	signal saida_eq_cont_wr_rd, saida_eq_cont_wr1_rd, saida_eq_cont_wr_rd1: std_logic; 
	signal saida_fifo: std_logic_vector(2 downto 0);
	
	begin
		BlocodeControle: blocoDeControleFIFO port map(
			clk_ff => CLK_fifo, 
			rst_ff => reset,
			rd_ff => RD,
			wr_ff => WR,
			equal_cont_wd_e_rd => saida_eq_cont_wr_rd, 
			equal_cont_wd_1_e_rd => saida_eq_cont_wr1_rd,
			equal_cont_wd_e_rd_1 => saida_eq_cont_wr_rd1,
			led_vazio_ff => l_vazio, 
			led_cheio_ff => l_cheio,
			load_wr => saida_load_wr,
			load_rd => saida_load_rd,
			clr_ff => clr_dt,
			saida_mv_fifo => saida_fifo);
		
		Datapath: datapathFIFO port map(
			clk_fifo_dp => CLK_fifo,
			wr_data_dp => W_data,
			ld_wr_dp => saida_load_wr,
			ld_rd_dp => saida_load_rd,
			clr_fifo_dp => clr_dt,
			eq_comp_wr_rd => saida_eq_cont_wr_rd,
			eq_comp_wr1_rd => saida_eq_cont_wr1_rd,
			eq_comp_wr_rd1 => saida_eq_cont_wr_rd1,
			rd_data_dp => leitura_banco_registradores);
			
		
		
		R_data <= leitura_banco_registradores;
		em <= l_vazio;
		fu <= l_cheio;
		Estados_maquina <= saida_fifo;
		
end ckt ;