entity MUX4_1 is
  port (I4: in bit_vector(3 downto 0);
        S4: in bit_vector(1 downto 0);
        d4: out bit);
end MUX4_1;

Architecture ckt of MUX4_1 is
  component MUX2_1 is
      port (I1,I0,S: in bit;
            d: out bit);
  end component;
  
  signal saida_1, saida_2: bit;
  
  begin
   Mux1: MUX2_1 port map(
      I0 => I4(0),
      I1 => I4(1),
      S => S4(0),
      d => saida_1);
   Mux2: MUX2_1 port map(
      I0 => I4(2),
      I1 => I4(3),
      S => S4(0),
      d => saida_2);
   Mux3: MUX2_1 port map(
      I0 => saida_1,
      I1 => saida_2,
      S => S4(1),
      d => d4);

end ckt;
    
  