entity Potencia is
  port (A: in bit_vector(4 downto 0);
        B: in bit_vector(1 downto 0);
        C: out bit_vector(15 downto 0));
end Potencia;

architecture Circuito of Potencia is
  
  component Mux16Bits is
    port (I1,I0: in bit_vector (15 downto 0);
          SS: in bit;
          d: out bit_vector(15 downto 0));
  end component;
  
  component Modulo is
        port (E:in bit_vector(4 downto 0);
              Q: out bit_vector(4 downto 0));
  end component;
  
  component Modulo16Bits is
        port (E16:in bit_vector(15 downto 0);
              SB: in bit;
              Q16: out bit_vector(15 downto 0));
  end component;
  
  component Multiplicador8Bit is
        port (Ma, Mb: in bit_vector(7 downto 0);
              Ms: out bit_vector(15 downto 0)); 
  end component;
  
  signal modulo_A: bit_vector(4 downto 0);
  signal A8_Bits, A2_8Bits: bit_vector(7 downto 0);
  signal S0,S1,S2,S3, Saida_01_Mux, Saida_02_Mux, modulo_A3: bit_vector(15 downto 0);
    
  begin
    
    FModulo: Modulo port map(
      E => A,
      Q => modulo_A);
    
    A8_Bits(7) <= modulo_A(4);
    A8_Bits(6) <= modulo_A(4);
    A8_Bits(5) <= modulo_A(4);
    A8_Bits(4 downto 0) <= modulo_A(4 downto 0);
    
    Multiplicacao_A_com_A: Multiplicador8Bit port map(
      Ma => A8_Bits,
      Mb => A8_Bits,
      Ms => S2);
    
    A2_8Bits <= S2(7 downto 0);
  
    Multiplicacao_A2_com_A: Multiplicador8Bit port map(
      Ma => A2_8Bits,
      Mb => A8_Bits,
      Ms => S3);
    

    
    ModuloA3: Modulo16Bits port map(
      E16 => S3,
      SB => A(4),
      Q16 => modulo_A3);
    
    
    S0 <= "0000000000000001";
    S1(15) <= A(4);
    S1(14) <= A(4);
    S1(13) <= A(4);
    S1(12) <= A(4);
    S1(11) <= A(4);
    S1(10) <= A(4);
    S1(9) <= A(4);
    S1(8) <= A(4);
    S1(7) <= A(4);
    S1(6) <= A(4);
    S1(5) <= A(4);
    S1(4) <= A(4);  
    S1(3 downto 0) <= A(3 downto 0);
    
    MuxSaida01: Mux16Bits port map(
      I0 => S0,
      I1 => S1,
      SS => B(0),
      d => Saida_01_Mux);
    
    MuxSaida02: Mux16Bits port map(
      I0 => S2,
      I1 => Modulo_A3,
      SS => B(0),
      d => Saida_02_Mux);
    
    MuxSaidaFinal: Mux16Bits port map(
      I0 => Saida_01_Mux,
      I1 => Saida_02_Mux,
      SS => B(1),
      d => C);          
    
    
end Circuito;