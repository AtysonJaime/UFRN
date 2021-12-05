entity Modulo is
  port (E:in bit_vector(4 downto 0);
        Q: out bit_vector(4 downto 0));
end Modulo;

Architecture circuito of Modulo is

  component Mux2_1 is
    port(I1,I0,S: in bit;
         d: out bit);
  end component;
  component Sum4Bit is
    port (A4,B4: in bit_vector(3 downto 0);
          C4_in: in bit;
          S4: out bit_vector(3 downto 0);
          C4_out: out bit);
  end component;
  
  
  signal Saida_mux, Com_E2: bit_vector(4 downto 0);
  signal Lixo: bit;
  
  
  begin
  Com_E2 <= not E;  
  
  Bit5: Mux2_1 port map(
            I0 => E(4),
            I1 => Com_E2(4),
            S => E(4),
            d => Saida_mux(4));
  Bit4: Mux2_1 port map(
            I0 => E(3),
            I1 => Com_E2(3),
            S => E(4),
            d => Saida_mux(3));
  Bit3: Mux2_1 port map(
            I0 => E(2),
            I1 => Com_E2(2),
            S => E(4),
            d => Saida_mux(2));
  Bit2: Mux2_1 port map(
            I0 => E(1),
            I1 => Com_E2(1),
            S => E(4),
            d => Saida_mux(1));
  Bit1: Mux2_1 port map(
            I0 => E(0),
            I1 => Com_E2(0),
            S => E(4),
            d => Saida_mux(0));
            
  Somatorio: Sum4bit port map(
          A4 => Saida_mux(3 downto 0),
          B4(3) => '0',
          B4(2) => '0',
          B4(1) => '0',
          B4(0) => '0',
          C4_in => E(4),
          S4 => Q(3 downto 0),
          C4_out => Lixo);
          
  Q(4) <= Saida_mux(4);                      
end circuito;