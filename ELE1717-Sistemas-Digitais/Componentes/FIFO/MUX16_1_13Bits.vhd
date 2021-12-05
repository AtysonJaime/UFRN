library ieee ;
use ieee.std_logic_1164.all;

entity MUX16_1_13Bits is
  port (I15_16, I14_16, I13_16, I12_16, I11_16, I10_16, I9_16, I8_16, I7_16: std_logic_vector(12 downto 0);
		  I6_16, I5_16, I4_16, I3_16, I2_16, I1_16, I0_16: std_logic_vector(12 downto 0);
		  S_16: in std_logic_vector(3 downto 0); 
		  ld_mux_16: in std_logic;
        d_16: out std_logic_vector(12 downto 0));
end MUX16_1_13Bits;

Architecture ckt of MUX16_1_13Bits is
  component MUX2_1_13Bits is
    port (I_1,I_0: in std_logic_vector(12 downto 0);
			 S,ld_mux: in std_logic;
          d: out std_logic_vector(12 downto 0));
  end component;
  
  signal saida_i0i1, saida_i2i3, saida_i4i5, saida_i6i7, saida_i8i9, saida_i10i11, saida_i12i13, saida_i14i15 : std_logic_vector(12 downto 0);
  signal saida_S0102, saida_S0304, saida_S0506, saida_S0708 : std_logic_vector(12 downto 0);
  signal saida_SS0102, saida_SS0304, saida_final : std_logic_vector(12 downto 0);
  
  begin
		muxI0I1: MUX2_1_13Bits port map(
					I_1 => I1_16,
					I_0 => I0_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i0i1);
		
		muxI2I3: MUX2_1_13Bits port map(
					I_1 => I3_16,
					I_0 => I2_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i2i3);
		
		muxI4I5: MUX2_1_13Bits port map(
					I_1 => I5_16,
					I_0 => I4_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i4i5);
		
		muxI6I7: MUX2_1_13Bits port map(
					I_1 => I7_16,
					I_0 => I6_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i6i7);
					
		muxI8I9: MUX2_1_13Bits port map(
					I_1 => I9_16,
					I_0 => I8_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i8i9);
		
		muxI10I11: MUX2_1_13Bits port map(
					I_1 => I11_16,
					I_0 => I10_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i10i11);
		
		muxI12I13: MUX2_1_13Bits port map(
					I_1 => I13_16,
					I_0 => I12_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i12i13);
		
		muxI14I15: MUX2_1_13Bits port map(
					I_1 => I15_16,
					I_0 => I14_16,
					S => S_16(0),
					ld_mux => ld_mux_16,
					d => saida_i14i15);
		
		muxSaida0102: MUX2_1_13Bits port map(
					I_1 => saida_i2i3,
					I_0 => saida_i0i1,
					S => S_16(1),
					ld_mux => ld_mux_16,
					d => saida_S0102);
		
		muxSaida0304: MUX2_1_13Bits port map(
					I_1 => saida_i6i7,
					I_0 => saida_i4i5,
					S => S_16(1),
					ld_mux => ld_mux_16,
					d => saida_S0304);
		
		muxSaida0506: MUX2_1_13Bits port map(
					I_1 => saida_i10i11,
					I_0 => saida_i8i9,
					S => S_16(1),
					ld_mux => ld_mux_16,
					d => saida_S0506);
		
		muxSaida0708: MUX2_1_13Bits port map(
					I_1 => saida_i14i15,
					I_0 => saida_i12i13,
					S => S_16(1),
					ld_mux => ld_mux_16,
					d => saida_S0708);
		
		muxSSaida0102: MUX2_1_13Bits port map(
					I_1 => saida_S0304,
					I_0 => saida_S0102,
					S => S_16(2),
					ld_mux => ld_mux_16,
					d => saida_SS0102);
		
		muxSSaida0304: MUX2_1_13Bits port map(
					I_1 => saida_S0708,
					I_0 => saida_S0506,
					S => S_16(2),
					ld_mux => ld_mux_16,
					d => saida_SS0304);
		muxFinal: MUX2_1_13Bits port map(
					I_1 => saida_SS0304,
					I_0 => saida_SS0102,
					S => S_16(3),
					ld_mux => ld_mux_16,
					d => saida_final);
		
		
		d_16 <= saida_final;
end ckt;