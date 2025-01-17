library ieee;
use ieee.std_logic_1164.all;

entity SUM_4Bits is
  port (A4_in,B4_in: in std_logic_vector(3 downto 0);
        C4_in: in std_logic;
        S4_out: out std_logic_vector(3 downto 0);
        C4_out: out std_logic);
end SUM_4Bits;

architecture ckt of SUM_4Bits is
  component SUM_2Bits is
    port (A2_in,B2_in: in std_logic_vector(1 downto 0);
			 C2_in: in std_logic;
          S2_out: out std_logic_vector(1 downto 0); 
			 C2_out: out std_logic);
  end component;
  
  signal Sum_01_out : std_logic;
  
  begin
    SUM01: SUM_2Bits port map(
          A2_in => A4_in(1 downto 0),
          B2_in => B4_in(1 downto 0),
          C2_in => C4_in,
          S2_out => S4_out(1 downto 0),
          C2_out => Sum_01_out);
  
    SUM02: SUM_2Bits port map(
          A2_in => A4_in(3 downto 2),
          B2_in => B4_in(3 downto 2),
          C2_in => Sum_01_out,
          S2_out => S4_out(3 downto 2),
          C2_out => C4_out);
  
end ckt;