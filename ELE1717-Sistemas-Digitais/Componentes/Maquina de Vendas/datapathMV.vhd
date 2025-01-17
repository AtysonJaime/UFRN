library ieee ;
use ieee.std_logic_1164.all;

entity datapathMV is
	port (clk_dmv , clr_total , ld_total: in std_logic; 
			S_mv, A_mv: in std_logic_vector(7 downto 0);
			total_ld: out std_logic;
			total_mv: out std_logic_vector(7 downto 0));
end datapathMV;

architecture ckt of datapathMV is
	component Comparador_8Bits is
	  port (eA8,eB8: in std_logic_vector(7 downto 0);
			  AeqB8,AltB8,AgtB8: out std_logic);
	end component;
	component reg8Bits is
		port (clk,preSet,clr,load: in std_logic;
				d: in std_logic_vector(7 downto 0);
				q : out std_logic_vector(7 downto 0));
	end component;
	component SUM_8Bits is
		  port (A8_in,B8_in: in std_logic_vector(7 downto 0);
				  C8_in: in std_logic;
				  S8_out: out std_logic_vector(7 downto 0);
				  C8_out: out std_logic);
	end component;
	
	signal result_somador, result_tot: std_logic_vector(7 downto 0);
	signal lixo_sum, result_comp_lt: std_logic;
	signal lixo_comp: std_logic_vector(1 downto 0);
	begin
		Reg: reg8Bits port map(
			clk => clk_dmv,
			preSet => '1',
			clr => not clr_total,
			load => ld_total,
			d => result_somador,
			q => result_tot);
		
		SUM: SUM_8Bits port map(
			A8_in => result_tot,
			B8_in => A_mv,
			C8_in => '0',
			S8_out => result_somador,
			C8_out => lixo_sum);
		
		Comp: Comparador_8Bits port map(
			eA8 => result_tot,
			eB8 => S_mv,
			AeqB8 => lixo_comp(1),
			AltB8 => result_comp_lt,
			AgtB8 =>lixo_comp(0));
		
		total_mv <= result_tot;
		total_ld <= result_comp_lt;
end ckt ;