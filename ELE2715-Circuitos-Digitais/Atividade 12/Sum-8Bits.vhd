entity Sum8Bits is
  port (A8,B8: in bit_vector(7 downto 0);
        C8_in: in bit;
        S8: out bit_vector(7 downto 0);
        C8_out: out bit);
end Sum8Bits;

architecture display of Sum8Bits is
  component Sum4Bit is
    port (A4,B4: in bit_vector(3 downto 0);
          C4_in: in bit;
          S4: out bit_vector(3 downto 0);
          C4_out: out bit);
  end component;
  
  signal Sum_01_out: bit;
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