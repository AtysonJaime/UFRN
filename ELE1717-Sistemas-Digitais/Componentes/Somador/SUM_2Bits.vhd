library ieee;
use ieee.std_logic_1164.all;

entity SUM_2Bits is
  port (A2_in,B2_in: in std_logic_vector(1 downto 0);
        C2_in: in std_logic;
        S2_out: out std_logic_vector(1 downto 0);
        C2_out: out std_logic);
end SUM_2Bits;

architecture ckt of SUM_2Bits is
  component SUM_1Bit is
    port (A_in,B_in,C_in: in std_logic;
          S_out, C_out: out std_logic);
  end component;
  
  signal Sum_01_out : std_logic;
  
  begin
    SUM01: SUM_1Bit port map(
          A_in => A2_in(0),
          B_in => B2_in(0),
          C_in => C2_in,
          S_out => S2_out(0),
          C_out => Sum_01_out);
  
    SUM02: SUM_1Bit port map(
          A_in => A2_in(1),
          B_in => B2_in(1),
          C_in => Sum_01_out,
          S_out => S2_out(1),
          C_out => C2_out);
  
end ckt;