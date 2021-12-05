library ieee ;
use ieee.std_logic_1164.all;

entity MUX12_1_8Bits is
  port (I12_11,I12_10,I12_9,I12_8,I12_7, I12_6, I12_5, I12_4, I12_3, I12_2, I12_1, I12_0: in std_logic_vector(7 downto 0);
		  S12: in std_logic_vector(3 downto 0); 
        d12: out std_logic_vector(7 downto 0));
end MUX12_1_8Bits;

Architecture ckt of MUX12_1_8Bits is
  component MUX2_1_8Bits is
    port (I_1,I_0: in std_logic_vector(7 downto 0);
			 S: in std_logic;
          d: out std_logic_vector(7 downto 0));
  end component;
  
  signal first_out_mux_1, first_out_mux_2,first_out_mux_3,first_out_mux_4, first_out_mux_5,first_out_mux_6: std_logic_vector(7 downto 0);
  signal second_out_mux_1, second_out_mux_2, second_out_mux_3: std_logic_vector(7 downto 0);
  signal third_out_mux, last_out_mux: std_logic_vector(7 downto 0);
  
  begin
	first_line_mux_01: MUX2_1_8Bits port map(
		I_0 => I12_0,
		I_1 => I12_1,
		S => S12(0),
		d => first_out_mux_1);
	first_line_mux_02: MUX2_1_8Bits port map(
		I_0 => I12_2,
		I_1 => I12_3,
		S => S12(0),
		d => first_out_mux_2);
	first_line_mux_03: MUX2_1_8Bits port map(
		I_0 => I12_4,
		I_1 => I12_5,
		S => S12(0),
		d => first_out_mux_3);
	first_line_mux_04: MUX2_1_8Bits port map(
		I_0 => I12_6,
		I_1 => I12_7,
		S => S12(0),
		d => first_out_mux_4);
	first_line_mux_05: MUX2_1_8Bits port map(
		I_0 => I12_8,
		I_1 => I12_9,
		S => S12(0),
		d => first_out_mux_5);
	first_line_mux_06: MUX2_1_8Bits port map(
		I_0 => I12_10,
		I_1 => I12_11,
		S => S12(0),
		d => first_out_mux_6);
	second_line_mux_01: MUX2_1_8Bits port map(
		I_0 => first_out_mux_1,
		I_1 => first_out_mux_2,
		S => S12(1),
		d => second_out_mux_1);
	second_line_mux_02: MUX2_1_8Bits port map(
		I_0 => first_out_mux_3,
		I_1 => first_out_mux_4,
		S => S12(1),
		d => second_out_mux_2);
	second_line_mux_03: MUX2_1_8Bits port map(
		I_0 => first_out_mux_5,
		I_1 => first_out_mux_6,
		S => S12(1),
		d => second_out_mux_3);
	third_line_mux_03: MUX2_1_8Bits port map(
		I_0 => second_out_mux_1,
		I_1 => second_out_mux_2,
		S => S12(2),
		d => third_out_mux);
	last_line_mux: MUX2_1_8Bits port map(
		I_0 => third_out_mux,
		I_1 => second_out_mux_3,
		S => S12(3),
		d => last_out_mux);
		
	d12 <= last_out_mux;
 end ckt;
	