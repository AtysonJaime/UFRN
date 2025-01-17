library ieee ;
use ieee.std_logic_1164.all;

entity maquinaVendas is
	port (CLK_mv, C, reset: in std_logic; 
			S, A: in std_logic_vector(7 downto 0);
			D: out std_logic;
			saida_mv: out std_logic_vector(1 downto 0);
			Tot_mv: out std_logic_vector(7 downto 0));
end maquinaVendas;

architecture ckt of maquinaVendas is
	component blocoDeControleMV is
		port (clk_mv , rst_mv , c_mv, tot_ld: in std_logic ;
				d_mv, load_tot, clr_tot: out std_logic;
				saida: out std_logic_vector(1 downto 0));
	end component;
	component datapathMV is
		port (clk_dmv , clr_total , ld_total: in std_logic; 
				S_mv, A_mv: in std_logic_vector(7 downto 0);
				total_ld: out std_logic;
				total_mv: out std_logic_vector(7 downto 0));
	end component;
	
	signal result_total: std_logic_vector(7 downto 0);
	signal result_comp_lt, result_despacho, sinal_somar_tot, clear_tot: std_logic;
	signal saida_mc: std_logic_vector(1 downto 0);
	begin
		BlocodeControle: blocoDeControleMV port map(
			clk_mv => CLK_mv,
			rst_mv => reset,
			c_mv => C,
			tot_ld => result_comp_lt,
			d_mv => result_despacho,
			load_tot => sinal_somar_tot,
			clr_tot => clear_tot,
			saida => saida_mc);
		
		Datapath: datapathMV port map(
			clk_dmv => CLK_mv,
			clr_total => clear_tot,
			ld_total => sinal_somar_tot,
			S_mv => S,
			A_mv => A,
			total_ld => result_comp_lt,
			total_mv => result_total);
			
		D <= result_despacho;
		Tot_mv <= result_total;
		saida_mv <= saida_mc;
end ckt ;