entity SUMBCD is
  port (A,B: in bit_vector(3 downto 0);
        C_in: in bit;
        S: out bit_vector(7 downto 0));
end SUMBCD;

architecture somador of SUMBCD is
  component Sum4Bit is
    port (A4,B4: in bit_vector(3 downto 0);
          C4_in: in bit;
          S4: out bit_vector(3 downto 0);
          C4_out: out bit);
  end component;
  
  signal corrige_c, c_out, lixo: bit;
  signal S1_out: bit_vector(3 downto 0);
  
  begin
    SUM1: Sum4Bit port map(
          A4 => A,
          B4 => B,
          C4_in => C_in,
          S4 => S1_out,
          C4_out => c_out);
    corrige_c <= (c_out or (S1_out(3) and S1_out(2)) or (S1_out(3) and S1_out(1))); 
    
    SUM2: Sum4Bit port map(
        A4(3) => '0',
        A4(2) => corrige_c,
        A4(1) => corrige_c,
        A4(0) => '0',
        B4 => S1_out,
        C4_in => '0',
        S4 => S(3 downto 0),
        C4_out => lixo);
    
    s(4) <= corrige_c;
    S(7) <= '0';
    S(6) <= '0';
    S(5) <= '0';
  
end somador;