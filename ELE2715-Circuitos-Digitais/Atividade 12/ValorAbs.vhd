entity V_Abs is
  port(Ain,Bin: in bit_vector(7 downto 0);
       Absout: out bit_vector(7 downto 0));
end V_Abs;

architecture ckt of V_Abs is
  
  component Sum8Bits is
    port (A8,B8: in bit_vector(7 downto 0);
          C8_in: in bit;
          S8: out bit_vector(7 downto 0);
          C8_out: out bit);
  end component;

  component Comparador_8Bits is
    port (eA8,eB8: in bit_vector(7 downto 0);
          AeqB8,AltB8,AgtB8: out bit);
  end component;

  component Mux2_1_Sinal is
    port (X: in bit_vector(7 downto 0);
          z: in bit;
          Y: out bit_vector(7 downto 0));
  end component;
  
  signal inMuxA,inMuxB,eq,lt,gt,lixo: bit;
  signal outMuxA, outMuxB, sumAB: bit_vector(7 downto 0);
  begin
    ComP: Comparador_8Bits port map(
      eA8 => Ain,
      eB8 => Bin,
      AeqB8 => eq,
      AltB8 => lt,
      AgtB8 => gt);
      
    inMuxA <= lt;
    inMuxB <= (eq OR gt);
    
    MUXA: Mux2_1_Sinal port map(
      X => Ain,
      z => inMuxA,
      Y => outMuxA);
    
    MUXB: Mux2_1_Sinal port map(
      X => Bin,
      z => inMuxB,
      Y => outMuxB);
      
    SUM: Sum8Bits port map(
      A8 => outMuxA,
      B8 => outMuxB,
      C8_in => '1',
      S8 => sumAB,
      C8_out => lixo);
    
    Absout <= sumAB;
    
end ckt;