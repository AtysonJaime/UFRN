entity Modulo16Bits is
  port (E16:in bit_vector(15 downto 0);
        SB: in bit;
        Q16: out bit_vector(15 downto 0));
end Modulo16Bits;

Architecture circuito of Modulo16Bits is

  component Mux16Bits is
    port (I1,I0: in bit_vector (15 downto 0);
          SS: in bit;
          d: out bit_vector(15 downto 0));
  end component;
  
  component Sum16Bit is
      port (A16,B16: in bit_vector(15 downto 0);
            C16_in: in bit;
            S16: out bit_vector(15 downto 0);
            C16_out: out bit);
  end component;
  
  
  signal Saida_mux, Com_E2: bit_vector(15 downto 0);
  signal Lixo: bit;
  
  
  begin
  Com_E2 <= not E16;  
  
  Mux01: Mux16Bits port map(
          I0 => E16,
          I1 => Com_E2,
          SS => SB,
          d => Saida_mux);
            
  Somatorio: Sum16bit port map(
          A16 => Saida_mux,
          B16 => "0000000000000000",
          C16_in => SB,
          S16 => Q16,
          C16_out => Lixo);                      
end circuito;