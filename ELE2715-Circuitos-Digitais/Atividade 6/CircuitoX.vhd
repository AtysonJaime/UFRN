ENTITY CircuitoX IS
  port (S_in, clk_x, c_x: in bit;
        Z_out: out bit_vector(3 downto 0));
end CircuitoX;
architecture ckt of CircuitoX is
  
  component ffd is
      port (clk ,D,P,C: IN BIT ;
            q: OUT BIT );
  end component;
  
  signal saida_q_1, saida_q_2, saida_q_3: bit;
  
  begin    
    FFD_1:ffd port map(
      clk => clk_x,
      D => S_in,
      P => '1',
      C => c_x,
      q => saida_q_1);
    
    FFD_2:ffd port map(
      clk => clk_x,
      D => saida_q_1,
      P => '1',
      C => c_x,
      q => saida_q_2);    
    
    FFD_3:ffd port map(
      clk => clk_x,
      D => saida_q_2,
      P => '1',
      C => c_x,
      q => saida_q_3);
    
    FFD_4:ffd port map(
      clk => clk_x,
      D => saida_q_3,
      P => '1',
      C => c_x,
      q => Z_out(3));
      
      Z_out(0) <= saida_q_1;
      Z_out(1) <= saida_q_2;
      Z_out(2) <= saida_q_3;
end ckt;   