library ieee ;
use ieee.std_logic_1164.all;

entity projeto02 is
	port ( clock_27,SW1,SW0,KEY3: in std_logic ;
			 LEDR1,LEDR0: out std_logic;
			 P02HEX5,P02HEX4, P02HEX3, P02HEX2, P02HEX1, P02HEX0: out std_logic_vector(6 downto 0);
			 est_maq_fifo: out std_logic_vector(2 downto 0));
end projeto02;

architecture ckt of projeto02 is
	-- Divisor de Clock
	component divisorClock is
		port (clk_in : in std_logic ;
				clk_out : out std_logic );
	end component;
	
	-- ROM
	component romFIFO is
		PORT (address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
				clock: IN STD_LOGIC  := '1';
				q: OUT STD_LOGIC_VECTOR (12 DOWNTO 0));
	end component;
	
	--FIFO
	component fifo is
		port (CLK_fifo, WR, RD, reset: in std_logic; 
				W_data: in std_logic_vector(12 downto 0);
				em,fu: out std_logic;
				R_data: out std_logic_vector(12 downto 0);
				Estados_maquina: out std_logic_vector(2 downto 0));
	end component;
	
	--Contador
	component contador6Bits is
	  port ( clk_c6B,ld_c6B,clr_c6B: in std_logic;	
				out_c6B: out std_logic_vector(5 downto 0));
	end component;
	
	--BINBCDtoD7SEG
	component bitToBcd13bitsToD7Seg is
	  port (SW_in: in std_logic_vector(12 downto 0);
			  HEX0,HEX1,HEX2,HEX3: out std_logic_vector(6 downto 0));
	end component;
	
	signal CLK_1, led_full, led_empty, clr_reverso: std_logic;
	signal saida_rom, saida_fifo: std_logic_vector(12 downto 0);
	signal saida_contador: std_logic_vector(5 downto 0);
	signal lixo1,lixo0, hx00,hx01,hx02,hx03,hx04,hx05: std_logic_vector(6 downto 0);
	signal estados: std_logic_vector(2 downto 0);
	
	begin
		
		clr_reverso <= not KEY3;
		
		DClock: divisorClock port map(
			clk_in => clock_27,
			clk_out => CLK_1);
		
		FIFO16x13: fifo port map(
			CLK_fifo => CLK_1, 
			WR => SW1, 
			RD => SW0, 
			reset => clr_reverso,
			W_data => saida_rom,
			em => led_empty,
			fu => led_full,
			R_data => saida_fifo,
			Estados_maquina => estados);
		
		ROM: romFIFO port map(
			address => saida_contador,
			clock => CLK_1,
			q => saida_rom);
		
		Contador: contador6Bits port map(
			clk_c6B => CLK_1,
			ld_c6B => SW1,
			clr_c6B => clr_reverso,	
			out_c6B => saida_contador);
		
		DisplayRead: bitToBcd13bitsToD7Seg port map(
			SW_in => saida_fifo,
			HEX0 => hx00,
			HEX1 => hx01,
			HEX2 => hx02,
			HEX3 => hx03);
		
		DisplayContador: bitToBcd13bitsToD7Seg port map(
			SW_in(12 downto 6) =>"0000000",
			SW_in(5 downto 0) => saida_contador,
			HEX0 => hx04,
			HEX1 => hx05,
			HEX2 => lixo0,
			HEX3 => lixo1);
		
		-- HEX
		P02HEX0 <= hx00;
		P02HEX1 <= hx01;
		P02HEX2 <= hx02;
		P02HEX3 <= hx03;
		P02HEX4 <= hx04;
		P02HEX5 <= hx05;
		
		-- Estados da Maquina FIFO
		est_maq_fifo <= estados;
		
		-- Luzes de aviso
		LEDR0 <= led_full;
		LEDR1 <= led_empty;
end ckt;