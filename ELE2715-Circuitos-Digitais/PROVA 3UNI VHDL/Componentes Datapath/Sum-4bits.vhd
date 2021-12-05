library ieee;
use ieee.std_logic_1164.all;

entity Sum4Bit is
  port (A4,B4: in std_logic_vector(3 downto 0);
        C4_in: in std_logic;
        S4: out std_logic_vector(3 downto 0);
        C4_out: out std_logic);
end Sum4Bit;

architecture display of Sum4Bit is
  component Sum2Bit is
    port (A_in,B_in,C_in: in std_logic;
          S_out, C_out: out std_logic);
  end component;
  
  signal Sum_01_out, sum_02_out, sum_03_out: std_logic;
  
  begin
    SUM01: Sum2Bit port map(
          A_in => A4(0),
          B_in => B4(0),
          C_in => C4_in,
          S_out => S4(0),
          C_out => Sum_01_out);
  
    SUM02: Sum2Bit port map(
          A_in => A4(1),
          B_in => B4(1),
          C_in => Sum_01_out,
          S_out => S4(1),
          C_out => Sum_02_out);
  
    SUM03: Sum2Bit port map(
          A_in => A4(2),
          B_in => B4(2),
          C_in => Sum_02_out,
          S_out => S4(2),
          C_out => Sum_03_out);
  
    SUM04: Sum2Bit port map(
          A_in => A4(3),
          B_in => B4(3),
          C_in => Sum_03_out,
          S_out => S4(3),
          C_out => C4_out);
  
end display;