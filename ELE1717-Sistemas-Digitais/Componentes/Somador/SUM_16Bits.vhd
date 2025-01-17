library ieee;
use ieee.std_logic_1164.all;

entity SUM_16Bits is
  port (A16_in,B16_in: in std_logic_vector(15 downto 0);
        C16_in: in std_logic;
        S16_out: out std_logic_vector(15 downto 0);
        C16_out: out std_logic);
end SUM_16Bits;

architecture ckt of SUM_16Bits is
  component SUM_8Bits is
    port (A8_in,B8_in: in std_logic_vector(7 downto 0);
			 C8_in: in std_logic;
          S8_out: out std_logic_vector(7 downto 0); 
			 C8_out: out std_logic);
  end component;
  
  signal Sum_01_out : std_logic;
  
  begin
    SUM01: SUM_8Bits port map(
          A8_in => A16_in(7 downto 0),
          B8_in => B16_in(7 downto 0),
          C8_in => C16_in,
          S8_out => S16_out(7 downto 0),
          C8_out => Sum_01_out);
  
    SUM02: SUM_8Bits port map(
          A8_in => A16_in(15 downto 8),
          B8_in => B16_in(15 downto 8),
          C8_in => Sum_01_out,
          S8_out => S16_out(15 downto 8),
          C8_out => C16_out);
  
end ckt;