library ieee ;
use ieee.std_logic_1164.all;

entity MUX6_1_8Bits is
  port (I6_5, I6_4, I6_3, I6_2, I6_1, I6_0: in std_logic_vector(7 downto 0);
		  S6: in std_logic_vector(2 downto 0); 
        d6: out std_logic_vector(7 downto 0));
end MUX6_1_8Bits;

Architecture ckt of MUX6_1_8Bits is
	component MUX2_1_8Bits is
		port (I_1,I_0: in std_logic_vector(7 downto 0);
				S: in std_logic;
				d: out std_logic_vector(7 downto 0));
	end component;
	
	signal first_line_out01,first_line_out02,first_line_out03,second_line_out,last_line_out: std_logic_vector(7 downto 0);

	begin
		first_line_mux_01: MUX2_1_8Bits port map(
			I_0 => I6_0,
			I_1 => I6_1,
			S => S6(0),
			d => first_line_out01);
		first_line_mux_02: MUX2_1_8Bits port map(
			I_0 => I6_2,
			I_1 => I6_3,
			S => S6(0),
			d => first_line_out02);
		first_line_mux_03: MUX2_1_8Bits port map(
			I_0 => I6_4,
			I_1 => I6_5,
			S => S6(0),
			d => first_line_out03);
		second_line_mux_01: MUX2_1_8Bits port map(
			I_0 => first_line_out01,
			I_1 => first_line_out02,
			S => S6(1),
			d => second_line_out);
		last_line_mux: MUX2_1_8Bits port map(
			I_0 => second_line_out,
			I_1 => first_line_out03,
			S => S6(2),
			d => last_line_out);
		
		d6 <= last_line_out;
 end ckt;
 
 