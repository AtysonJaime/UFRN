library ieee ;
use ieee.std_logic_1164.all;

entity ULA is
  port (ULA_A_IN,ULA_B_IN: in std_logic_vector(7 downto 0);
		  ULA_S_IN: in std_logic_vector(3 downto 0); 
        ULA_OUT: out std_logic_vector(7 downto 0);
		  JMP_eq,JMP_hi,JMP_lo,LED_OVRF: out std_logic);
end ULA;

architecture ckt of ULA is
	component SUM_8Bits is
	  port (A8_in,B8_in: in std_logic_vector(7 downto 0);
			  C8_in: in std_logic;
			  S8_out: out std_logic_vector(7 downto 0);
			  C8_out: out std_logic);
	end component;
	
	component SUB_8Bits is
	  port (sub_A8_in,sub_B8_in: in std_logic_vector(7 downto 0);
			  sub_S8_out: out std_logic_vector(7 downto 0));  
	end component;
	
	component Multiplicador8Bits is
	  port (Ma, Mb: in std_logic_vector(7 downto 0);
			  Ms: out std_logic_vector(15 downto 0));
	end component;
	
	component Comparador_8Bits is
	  port (eA8,eB8: in std_logic_vector(7 downto 0);
			  AeqB8,AltB8,AgtB8: out std_logic);
	end component;
	
	component SHR_in_8Bits is
	  port (Ar: in std_logic_vector(7 downto 0);
			  Sr: out std_logic_vector(7 downto 0));
	end component;
	
	component SHL_in_8Bits is
	  port (Al: in std_logic_vector(7 downto 0);
			  Sl: out std_logic_vector(7 downto 0));
	end component;
	
	component MUX12_1_8Bits is
	  port (I12_11,I12_10,I12_9,I12_8,I12_7, I12_6, I12_5, I12_4, I12_3, I12_2, I12_1, I12_0: in std_logic_vector(7 downto 0);
			  S12: in std_logic_vector(3 downto 0); 
			  d12: out std_logic_vector(7 downto 0));
	end component;
	
	signal result_soma, result_soma_ovrf, result_subtracao, result_comparacao, result_mult, result_mult_ovrf: std_logic_vector(7 downto 0);
	signal result_INC, result_DEC, result_AND, result_OR, result_XOR, result_NOT, result_SHR, result_SHL, result_mux: std_logic_vector(7 downto 0);
	signal mux_mult,mux_soma: std_logic_vector(7 downto 0);	
	signal result_mult_total: std_logic_vector(15 downto 0);
	signal bloco_comparador, compara_maior_0_mult, compara_maior_0_sum, compara_mux_soma, compara_mux_mult: std_logic_vector(2 downto 0);
	signal INC_ovrf, ovrf_mult, ovrf_soma: std_logic;
	
	begin
	
	result_soma_ovrf(7 downto 1) <="0000000";
	ADD: SUM_8Bits port map(
		A8_in => ULA_A_IN,
		B8_in => ULA_B_IN,
		C8_in => '0',
		S8_out => result_soma,
		C8_out => result_soma_ovrf(0));
	
	SUB: SUB_8Bits port map(
		sub_A8_in => ULA_A_IN,
		sub_B8_in => ULA_B_IN,
		sub_S8_out => result_subtracao);
	
	result_comparacao(7 downto 3) <= "00000";
	CMP: comparador_8Bits port map(
		eA8 => ULA_A_IN,
		eB8 => ULA_B_IN,
		AeqB8 => bloco_comparador(1),
		AltB8 => bloco_comparador(0),
		AgtB8 => bloco_comparador(2));
	result_comparacao(2 downto 0) <= bloco_comparador;
	
	MULT: multiplicador8Bits port map(
		Ma => ULA_A_IN, 
		Mb => ULA_B_IN,
		Ms => result_mult_total);
	result_mult <= result_mult_total(7 downto 0);
	result_mult_ovrf <= result_mult_total(15 downto 8);
	
	INC: SUM_8Bits port map(
		A8_in => ULA_A_IN,
		B8_in => "00000001",
		C8_in => '0',
		S8_out => result_INC,
		C8_out => INC_ovrf);
	
	DEC: SUB_8Bits port map(
		sub_A8_in => ULA_A_IN,
		sub_B8_in => "00000001",
		sub_S8_out => result_DEC);
	
	result_AND <= ULA_A_IN and ULA_B_IN;
	result_OR <= ULA_A_IN or ULA_B_IN;
	result_XOR <= ULA_A_IN xor ULA_B_IN;
	result_NOT <= not ULA_A_IN;
	
	SHL: SHL_in_8Bits port map(
		Al => ULA_A_IN,
		Sl => result_SHL);
	
	SHR: SHR_in_8Bits port map(
		Ar => ULA_A_IN,
		Sr => result_SHR);
	
	MUX: MUX12_1_8Bits port map(
		I12_11 => result_SHR,
		I12_10 => result_SHL,
		I12_9 => result_NOT,
		I12_8 => result_XOR,
		I12_7 => result_OR, 
		I12_6 => result_AND, 
		I12_5 => result_DEC, 
		I12_4 => result_INC, 
		I12_3 => result_mult,
		I12_2 => result_comparacao, 
		I12_1 => result_subtracao, 
		I12_0 => result_soma,
		S12 => ULA_S_IN, 
		d12 => result_mux);
	
	comparador_mult_ovrf: comparador_8Bits port map(
		eA8 => result_mult_ovrf,
		eB8 => "00000000",
		AeqB8 => compara_maior_0_mult(1),
		AltB8 => compara_maior_0_mult(0),
		AgtB8 => compara_maior_0_mult(2));
	
	comparador_soma_ovrf: comparador_8Bits port map(
		eA8 => result_soma_ovrf,
		eB8 => "00000000",
		AeqB8 => compara_maior_0_sum(1),
		AltB8 => compara_maior_0_sum(0),
		AgtB8 => compara_maior_0_sum(2));
	
	mux_mult(7 downto 4) <= "0000";
	mux_mult(3 downto 0) <= ULA_S_IN;
	mux_soma(7 downto 4) <= "0000";
	mux_soma(3 downto 0) <= ULA_S_IN;
	
	comparador_mux_soma: comparador_8Bits port map(
		eA8 => mux_soma,
		eB8 => "00000000",
		AeqB8 => compara_mux_soma(1),
		AltB8 => compara_mux_soma(0),
		AgtB8 => compara_mux_soma(2));
	comparador_mux_mult: comparador_8Bits port map(
		eA8 => mux_mult,
		eB8 => "00000011",
		AeqB8 => compara_mux_mult(1),
		AltB8 => compara_mux_mult(0),
		AgtB8 => compara_mux_mult(2));
	
	ULA_OUT <= result_mux;
	ovrf_mult <= compara_maior_0_mult(2) and compara_mux_mult(1);
	ovrf_soma <= compara_maior_0_sum(2) and compara_mux_soma(1);
	LED_OVRF <= ovrf_mult or ovrf_soma;
	JMP_hi <= bloco_comparador(2);
	JMP_eq <= bloco_comparador(1);
	JMP_lo <= bloco_comparador(0);

end ckt;