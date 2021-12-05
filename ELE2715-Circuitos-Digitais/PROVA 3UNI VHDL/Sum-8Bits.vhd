library ieee;
use ieee.std_logic_1164.all;


entity Sum8Bits is
  port (A8,B8: in std_logic_vector(7 downto 0);
        C8_in: in std_logic;
        S8: out std_logic_vector(7 downto 0);
        C8_out: out std_logic);
end Sum8Bits;

architecture display of Sum8Bits is
  component Sum4Bit is
    port (A4,B4: in std_logic_vector(3 downto 0);
          C4_in: in std_logic;
          S4: out std_logic_vector(3 downto 0);
          C4_out: out std_logic);
  end component;
  
  signal Sum_01_out: std_logic;
  begin
    
    SUM01: Sum4Bit port map(
          A4(3 downto 0) => A8(3 downto 0),
          B4(3 downto 0) => B8(3 downto 0),
          C4_in => C8_in,
          S4(3 downto 0) => S8(3 downto 0),
          C4_out => Sum_01_out);
  
    SUM02: Sum4Bit port map(
          A4(3 downto 0) => A8(7 downto 4),
          B4(3 downto 0) => B8(7 downto 4),
          C4_in => Sum_01_out,
          S4(3 downto 0) => S8(7 downto 4),
          C4_out =>C8_out);
  
end display;