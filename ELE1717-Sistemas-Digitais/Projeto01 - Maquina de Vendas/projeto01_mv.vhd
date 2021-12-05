library ieee ;
use ieee.std_logic_1164.all;

entity projeto01_MV is
	port (clock_27, KEY2, KEY3: in std_logic; 
			SW: in std_logic_vector(7 downto 0);
			LEDR0,LEDR1: out std_logic;
			LHEX2,LHEX1,LHEX0,LHEX5,LHEX4: out std_logic_vector(6 downto 0));
end projeto01_MV;

architecture ckt of projeto01_MV is
	component maquinaVendas is
		port (CLK_mv, C, reset: in std_logic; 
				S, A: in std_logic_vector(7 downto 0);
				D: out std_logic;
				saida_mv: out std_logic_vector(1 downto 0);
				Tot_mv: out std_logic_vector(7 downto 0));
	end component;
	component romMV IS
		PORT(address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			  clock: IN STD_LOGIC  := '1';
			  q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END component;
	component divisorClock is
		port ( clk_in : in std_logic ;
				 clk_out : out std_logic );
	end component ;
	component contador6Bits is
		port ( clk_c6B,ld_c6B,clr_c6B: in std_logic;	
				 out_c6B: out std_logic_vector(5 downto 0));
	end component;
	component botaoSincrono is
		port (clk, b_in: in std_logic ;
				b_out: out std_logic );
	end component;
	component bitToBcdToD7Seg is
		port (SW_in: in std_logic_vector(7 downto 0);
				HEX0,HEX1,HEX2: out std_logic_vector(6 downto 0));
	end component;
	
	signal CLK_1, saida_botao, saida_MV, ld_reverso, clr_reverso: std_logic;
	signal saida_SS: std_logic_vector(1 downto 0);
	signal saida_contador: std_logic_vector(5 downto 0);
	signal entrada_A_mv, total_sum_mv: std_logic_vector(7 downto 0);
	signal saida_hex2, saida_hex1, saida_hex0, saida_hex5, saida_hex4,lixo: std_logic_vector(6 downto 0);
	
	begin
		
		ld_reverso <= not KEY2;
		clr_reverso <= not KEY3;
		
		DivClock: divisorClock port map(
			clk_in => clock_27,
			clk_out => CLK_1);
		
		BS: botaoSincrono port map(
			clk => CLK_1,
			b_in => ld_reverso,
			b_out => saida_botao);
		
		ROM: romMV port map (
			clock => CLK_1,
			address => saida_contador,
			q => entrada_A_mv);
		
		Cont: contador6Bits port map(
			clk_c6B => CLK_1,
			ld_c6B => saida_botao,
			clr_c6B => clr_reverso,
			out_c6B => saida_contador);
		
		MV: maquinaVendas port map(
			CLK_mv => CLK_1,
			C => saida_botao, 
			reset => clr_reverso, 
			S => SW, 
			A => entrada_A_mv,
			D => saida_MV,
			saida_mv => saida_SS,
			Tot_mv => total_sum_mv);
		
		LedTotalMV: bitToBcdToD7Seg port map(
			SW_in => total_sum_mv,
			HEX0 => saida_hex0,
			HEX1 => saida_hex1,
			HEX2 => saida_hex2);
		
		LedROM: bitToBcdToD7Seg port map(
			SW_in => entrada_A_mv,
			HEX0 => saida_hex4,
			HEX1 => saida_hex5,
			HEX2 => lixo);
		
		LEDR0 <= saida_MV;
		LEDR1 <= saida_botao;
		LHEX2 <= saida_hex2;
		LHEX1 <= saida_hex1;
		LHEX0 <= saida_hex0;
		LHEX4 <= saida_hex4;
		LHEX5 <= saida_hex5;
end ckt ;