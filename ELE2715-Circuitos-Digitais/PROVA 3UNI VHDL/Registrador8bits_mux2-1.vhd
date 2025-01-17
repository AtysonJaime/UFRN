entity Registrador8bits_Mux2_1 is
  port (LD,CLR, CLK: in bit;
        I8: in bit_vector(7 downto 0);
        I8_out: out bit_vector(7 downto 0));
end Registrador8bits_Mux2_1;

architecture display of Registrador8bits_Mux2_1 is
  component MUX2_1 is
    port (I_1,I_0,S: in bit;
          d: out bit);
  end component;
  component ffd is
    port (clk ,D,P,C: IN BIT ;
          q: OUT BIT );
  end component;
  
  signal ffd_out, mux_out:bit_vector(7 downto 0);
  
  begin
    
    Mux1: MUX2_1 port map(
      I_1 => I8(7),
      I_0 => ffd_out(7),
      S => LD,
      d => mux_out(7));
    FFD1: ffd port map(
      clk => CLK,
      D => mux_out(7),
      P => '1',
      C => CLR,
      q => ffd_out(7));
    
    Mux2: MUX2_1 port map(
      I_1 => I8(6),
      I_0 => ffd_out(6),
      S => LD,
      d => mux_out(6));
    FFD2: ffd port map(
      clk => CLK,
      D => mux_out(6),
      P => '1',
      C => CLR,
      q => ffd_out(6));
    
    Mux3: MUX2_1 port map(
      I_1 => I8(5),
      I_0 => ffd_out(5),
      S => LD,
      d => mux_out(5));
    FFD3: ffd port map(
      clk => CLK,
      D => mux_out(5),
      P => '1',
      C => CLR,
      q => ffd_out(5));
    
    Mux4: MUX2_1 port map(
      I_1 => I8(4),
      I_0 => ffd_out(4),
      S => LD,
      d => mux_out(4));
    FFD4: ffd port map(
      clk => CLK,
      D => mux_out(4),
      P => '1',
      C => CLR,
      q => ffd_out(4));
    
    Mux5: MUX2_1 port map(
      I_1 => I8(3),
      I_0 => ffd_out(3),
      S => LD,
      d => mux_out(3));
    FFD5: ffd port map(
      clk => CLK,
      D => mux_out(3),
      P => '1',
      C => CLR,
      q => ffd_out(3));
    
    Mux6: MUX2_1 port map(
      I_1 => I8(2),
      I_0 => ffd_out(2),
      S => LD,
      d => mux_out(2));
    FFD6: ffd port map(
      clk => CLK,
      D => mux_out(2),
      P => '1',
      C => CLR,
      q => ffd_out(2));
    
    Mux7: MUX2_1 port map(
      I_1 => I8(1),
      I_0 => ffd_out(1),
      S => LD,
      d => mux_out(1));
    FFD7: ffd port map(
      clk => CLK,
      D => mux_out(1),
      P => '1',
      C => CLR,
      q => ffd_out(1));
    
    Mux8: MUX2_1 port map(
      I_1 => I8(0),
      I_0 => ffd_out(0),
      S => LD,
      d => mux_out(0));
    FFD8: ffd port map(
      clk => CLK,
      D => mux_out(0),
      P => '1',
      C => CLR,
      q => ffd_out(0));

  I8_out <= ffd_out;      
end display;
    
            
  