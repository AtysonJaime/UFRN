library ieee;
use ieee.std_logic_1164.all;

entity Sum16Bit is
  port (A16,B16: in std_logic_vector(15 downto 0);
        C16_in: in std_logic;
        S16: out std_logic_vector(15 downto 0);
        C16_out: out std_logic);
end Sum16Bit;

architecture somador of Sum16Bit is
  component Sum4Bit is
    port (A4,B4: in std_logic_vector(3 downto 0);
          C4_in: in std_logic;
          S4: out std_logic_vector(3 downto 0);
          C4_out: out std_logic);
  end component;
  
  signal Sum_01_out, sum_02_out, sum_03_out: std_logic;
  
  begin
    SUM01: Sum4Bit port map(
          A4 => A16(3 downto 0),
          B4 => B16(3 downto 0),
          C4_in => C16_in,
          S4 => S16(3 downto 0),
          C4_out => Sum_01_out);
  
    SUM02: Sum4Bit port map(
          A4 => A16(7 downto 4),
          B4 => B16(7 downto 4),
          C4_in => Sum_01_out,
          S4 => S16(7 downto 4),
          C4_out => Sum_02_out);
  
    SUM03: Sum4Bit port map(
          A4 => A16(11 downto 8),
          B4 => B16(11 downto 8),
          C4_in => Sum_02_out,
          S4 => S16(11 downto 8),
          C4_out => Sum_03_out);
  
    SUM04: Sum4Bit port map(
          A4 => A16(15 downto 12),
          B4 => B16(15 downto 12),
          C4_in => Sum_03_out,
          S4 => S16(15 downto 12),
          C4_out => C16_out);
  
end somador;