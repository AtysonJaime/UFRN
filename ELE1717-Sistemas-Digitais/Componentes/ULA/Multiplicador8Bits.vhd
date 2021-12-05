library ieee;
use ieee.std_logic_1164.all;

entity Multiplicador8Bits is
  port (Ma, Mb: in std_logic_vector(7 downto 0);
        Ms: out std_logic_vector(15 downto 0)); 
end Multiplicador8Bits;

architecture CI of Multiplicador8Bits is
  
  component Mult_Linha is
      port (L: in std_logic_vector(7 downto 0);
            C: in std_logic;
            R: out std_logic_vector(7 downto 0));
  end component;
  
  component SUM_16Bits is
      port (A16_in,B16_in: in std_logic_vector(15 downto 0);
            C16_in: in std_logic;
            S16_out: out std_logic_vector(15 downto 0);
            C16_out: out std_logic);
  end component;
  
  signal mul_00_out,mul_01_out, mul_02_out, mul_03_out, mul_04_out, mul_05_out, mul_06_out, mul_07_out: std_logic_vector(7 downto 0);
  signal sum_01_out, sum_02_out, sum_03_out, sum_04_out, sum_05_out, sum_06_out: std_logic_vector(15 downto 0);
  signal c_01_out, c_02_out, c_03_out, c_04_out, c_05_out, c_06_out, c_07_out: std_logic;
  
  begin
    Mult01: Mult_Linha port map(
          L => Ma,
          C => Mb(0),
          R => mul_00_out);
    Mult02: Mult_Linha port map(
          L => Ma,
          C => Mb(1),
          R => mul_01_out);
    Mult03: Mult_Linha port map(
          L => Ma,
          C => Mb(2),
          R => mul_02_out);
    Mult04: Mult_Linha port map(
          L => Ma,
          C => Mb(3),
          R => mul_03_out);
    Mult05: Mult_Linha port map(
          L => Ma,
          C => Mb(4),
          R => mul_04_out);
    Mult06: Mult_Linha port map(
          L => Ma,
          C => Mb(5),
          R => mul_05_out);
    Mult07: Mult_Linha port map(
          L => Ma,
          C => Mb(6),
          R => mul_06_out);
    Mult08: Mult_Linha port map(
          L => Ma,
          C => Mb(7),
          R => mul_07_out);                                                   
   
    Somador01: SUM_16Bits port map(
          A16_in(15 downto 8) => "00000000",
          A16_in(7 downto 0) => mul_00_out,
          B16_in(15 downto 9) => "0000000",
          B16_in(8 downto 1) => mul_01_out,
          B16_in(0) => '0',
          C16_in => '0',
          S16_out => sum_01_out,
          C16_out => c_01_out);
  
  
	Somador02: SUM_16Bits port map(
          A16_in => sum_01_out,
          B16_in(15 downto 10) => "000000", 
          B16_in(9 downto 2) => mul_02_out,
          B16_in(1 downto 0) => "00",
			 C16_in => '0',
          S16_out => sum_02_out,
          C16_out => c_02_out);
  
  
	Somador03: SUM_16Bits port map(
          A16_in => sum_02_out,
          B16_in(15 downto 11) => "00000",
          B16_in(10 downto 3) => mul_03_out,
          B16_in(2 downto 0) => "000",
			 C16_in => '0',
          S16_out => sum_03_out,
          C16_out => c_03_out);

  
	Somador04: SUM_16Bits port map(
          A16_in => sum_03_out,
          B16_in(15 downto 12) => "0000",
          B16_in(11 downto 4) => mul_04_out,
          B16_in(3 downto 0) => "0000",
			 C16_in => '0',
          S16_out => sum_04_out,
          C16_out => c_04_out);

  
	Somador05: SUM_16Bits port map(
          A16_in => sum_04_out,
          B16_in(15 downto 13) => "000",
          B16_in(12 downto 5) => mul_05_out,
          B16_in(4 downto 0) => "00000",
          C16_in => '0',
          S16_out => sum_05_out,
          C16_out => c_05_out);
  
  
	Somador06: SUM_16Bits port map(
          A16_in => sum_05_out,
          B16_in(15 downto 14) => "00",
          B16_in(13 downto 6) => mul_06_out,
          B16_in(5 downto 0) => "000000",
          C16_in => '0',
          S16_out => sum_06_out,
          C16_out => c_06_out);
  
  
	Somador07: SUM_16Bits port map(
          A16_in => sum_06_out,
          B16_in(15) => '0',
          B16_in(14 downto 7) => mul_07_out,
          B16_in(6 downto 0) => "0000000",
          C16_in => '0',
          S16_out => Ms,
          C16_out => c_07_out);          

end CI;