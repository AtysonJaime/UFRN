ENTITY CCompleto IS
  port (A: in bit_vector(3 downto 0);
        K: in bit_vector(1 downto 0);
        Ebl,clk: in bit;  
        Z: out bit_vector(3 downto 0));
end CCompleto;
architecture ckt of CCompleto is
  
  component CircuitoY is
      port (A_in: in bit_vector(3 downto 0);
            clk_y, c_y, E: in bit;
            S: out bit);
  end component;
  
  component CircuitoX is
      port (S_in, clk_x, c_x: in bit;
            Z_out: out bit_vector(3 downto 0));
  end component;  
  
  signal saida_CY: bit;
  
  begin     
    Circuito_Y:CircuitoY port map(
      A_in => A,
      C_y => K(0),
      E => Ebl,
      clk_y => clk,
      S => saida_CY);
      
    Circuito_X:CircuitoX port map(
      S_in => saida_CY,
      c_X => k(1),
      clk_x => clk,
      Z_out => Z);

end ckt;
