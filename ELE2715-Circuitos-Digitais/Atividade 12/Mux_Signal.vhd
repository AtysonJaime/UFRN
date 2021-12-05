entity Mux2_1_Sinal is
  port (X: in bit_vector(7 downto 0);
        z: in bit;
        Y: out bit_vector(7 downto 0));
end Mux2_1_Sinal;

architecture ckt of Mux2_1_Sinal is
  
  component MUX2_1 is
    port (I_1,I_0,S: in bit;
          d: out bit);
  end component;
  
  signal notx, outm: bit_vector(7 downto 0);
  begin 
    
    notx <= Not(X);
    
    MUX1: MUX2_1 port map(
      I_0 => X(0),
      I_1 => notx(0),
      S => z,
      d => outm(0));

    MUX2: MUX2_1 port map(
      I_0 => X(1),
      I_1 => notx(1),
      S => z,
      d => outm(1)); 
    
    MUX3: MUX2_1 port map(
      I_0 => X(2),
      I_1 => notx(2),
      S => z,
      d => outm(2));   

    MUX4: MUX2_1 port map(
      I_0 => X(3),
      I_1 => notx(3),
      S => z,
      d => outm(3));  
    
    MUX5: MUX2_1 port map(
      I_0 => X(4),
      I_1 => notx(4),
      S => z,
      d => outm(4));
    
    MUX6: MUX2_1 port map(
      I_0 => X(5),
      I_1 => notx(5),
      S => z,
      d => outm(5));
    
    MUX7: MUX2_1 port map(
      I_0 => X(6),
      I_1 => notx(6),
      S => z,
      d => outm(6));
    
    MUX8: MUX2_1 port map(
      I_0 => X(7),
      I_1 => notx(7),
      S => z,
      d => outm(7));
      
  Y <= outm;
end ckt;
