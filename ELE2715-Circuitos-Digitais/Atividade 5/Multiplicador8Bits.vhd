entity Multiplicador8Bit is
  port (Ma, Mb: in bit_vector(7 downto 0);
        Ms: out bit_vector(15 downto 0)); 
end Multiplicador8Bit;

architecture Caixa of Multiplicador8Bit is
  
  component Mult_Linha is
      port (L: in bit_vector(7 downto 0);
            C: in bit;
            R: out bit_vector(7 downto 0));
  end component;
  
  component Sum16Bit is
      port (A16,B16: in bit_vector(15 downto 0);
            C16_in: in bit;
            S16: out bit_vector(15 downto 0);
            C16_out: out bit);
  end component;
  
  signal mul_01_out, mul_02_out, mul_03_out, mul_04_out, mul_05_out, mul_06_out, mul_07_out, mul_08_out: bit_vector(7 downto 0);
  signal sum_01_out, sum_02_out, sum_03_out, sum_04_out, sum_05_out, sum_06_out, sum_07_out: bit_vector(15 downto 0);
  signal lixo: bit_vector(7 downto 0);
  
  begin
    Mult01: Mult_Linha port map(
          L => Ma,
          C => Mb(0),
          R => mul_01_out);
    Mult02: Mult_Linha port map(
          L => Ma,
          C => Mb(1),
          R => mul_02_out);
    Mult03: Mult_Linha port map(
          L => Ma,
          C => Mb(2),
          R => mul_03_out);
    Mult04: Mult_Linha port map(
          L => Ma,
          C => Mb(3),
          R => mul_04_out);
    Mult05: Mult_Linha port map(
          L => Ma,
          C => Mb(4),
          R => mul_05_out);
    Mult06: Mult_Linha port map(
          L => Ma,
          C => Mb(5),
          R => mul_06_out);
    Mult07: Mult_Linha port map(
          L => Ma,
          C => Mb(6),
          R => mul_07_out);
    Mult08: Mult_Linha port map(
          L => Ma,
          C => Mb(7),
          R => mul_08_out);                                                   
   
    Sum01: Sum16Bit port map(
          A16(15) => '0',
          A16(14) => '0',
          A16(13) => '0',
          A16(12) => '0',
          A16(11) => '0',
          A16(10) => '0',
          A16(9) => '0',
          A16(8) => '0',
          A16(7 downto 0) => mul_01_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13) => '0',
          B16(12) => '0',
          B16(11) => '0',
          B16(10) => '0',
          B16(9) => '0',
          B16(8 downto 1) => mul_02_out,
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_01_out,
          C16_out => lixo(0));
  
  
Sum02: Sum16Bit port map(
          A16 => sum_01_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13) => '0',
          B16(12) => '0',
          B16(11) => '0',
          B16(10) => '0',
          B16(9 downto 2) => mul_03_out,
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_02_out,
          C16_out => lixo(1));
  
  
Sum03: Sum16Bit port map(
          A16 => sum_02_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13) => '0',
          B16(12) => '0',
          B16(11) => '0',
          B16(10 downto 3) => mul_04_out,
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_03_out,
          C16_out => lixo(2));

  
Sum04: Sum16Bit port map(
          A16 => sum_03_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13) => '0',
          B16(12) => '0',
          B16(11 downto 4) => mul_05_out,
          B16(3) => '0',
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_04_out,
          C16_out => lixo(3));

  
Sum05: Sum16Bit port map(
          A16 => sum_04_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13) => '0',
          B16(12 downto 5) => mul_06_out,
          B16(4) => '0',
          B16(3) => '0',
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_05_out,
          C16_out => lixo(4));
  
  
Sum06: Sum16Bit port map(
          A16 => sum_05_out,
          B16(15) => '0',
          B16(14) => '0',
          B16(13 downto 6) => mul_06_out,
          B16(5) => '0',
          B16(4) => '0',
          B16(3) => '0',
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_06_out,
          C16_out => lixo(5));
  
  
Sum07: Sum16Bit port map(
          A16 => sum_06_out,
          B16(15) => '0',
          B16(14 downto 7) => mul_07_out,
          B16(6) => '0',
          B16(5) => '0',
          B16(4) => '0',
          B16(3) => '0',          
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => sum_07_out,
          C16_out => lixo(6));

  
Sum08: Sum16Bit port map(
          A16 => sum_07_out,        
          B16(15 downto 8) => mul_08_out,
          B16(7) => '0',
          B16(6) => '0',
          B16(5) => '0',
          B16(4) => '0',
          B16(3) => '0',
          B16(2) => '0',
          B16(1) => '0',
          B16(0) => '0',
          C16_in => '0',
          S16 => Ms,
          C16_out => lixo(7));           

end Caixa;