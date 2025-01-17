library ieee;
use ieee.std_logic_1164.all;

entity SUM_8Bits is
  port (A8_in,B8_in: in std_logic_vector(7 downto 0);
        C8_in: in std_logic;
        S8_out: out std_logic_vector(7 downto 0);
        C8_out: out std_logic);
end SUM_8Bits;

architecture ckt of SUM_8Bits is
  component SUM_4Bits is
    port (A4_in,B4_in: in std_logic_vector(3 downto 0);
			 C4_in: in std_logic;
          S4_out: out std_logic_vector(3 downto 0); 
			 C4_out: out std_logic);
  end component;
  
  signal Sum_01_out : std_logic;
  
  begin
    SUM01: SUM_4Bits port map(
          A4_in => A8_in(3 downto 0),
          B4_in => B8_in(3 downto 0),
          C4_in => C8_in,
          S4_out => S8_out(3 downto 0),
          C4_out => Sum_01_out);
  
    SUM02: SUM_4Bits port map(
          A4_in => A8_in(7 downto 4),
          B4_in => B8_in(7 downto 4),
          C4_in => Sum_01_out,
          S4_out => S8_out(7 downto 4),
          C4_out => C8_out);
  
end ckt;