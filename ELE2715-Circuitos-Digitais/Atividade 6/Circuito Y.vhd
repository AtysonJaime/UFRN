ENTITY CircuitoY IS
  port (A_in: in bit_vector(3 downto 0);
        clk_y, c_y, E: in bit;
        S: out bit);
end CircuitoY;
architecture ckt of CircuitoY is
  
  component ffd is
      port (clk ,D,P,C: IN BIT ;
            q: OUT BIT );
  end component;
  
  signal saida_q, CP: bit_vector(3 downto 0);
  
  begin 
    CP(0) <= A_in(0) NAND E; 
    CP(1) <= A_in(1) NAND E;
    CP(2) <= A_in(2) NAND E;
    CP(3) <= A_in(3) NAND E;
     
    FFD_1:ffd port map(
      clk => clk_y,
      D => '0',
      P => CP(0),
      C => c_y,
      q => saida_q(0));
    
    FFD_2:ffd port map(
      clk => clk_y,
      D => saida_q(0),
      P => CP(1),
      C => c_y,
      q => saida_q(1));    
    
    FFD_3:ffd port map(
      clk => clk_y,
      D => saida_q(1),
      P => CP(2),
      C => c_y,
      q => saida_q(2));
    
    FFD_4:ffd port map(
      clk => clk_y,
      D => saida_q(2),
      P => CP(3),
      C => c_y,
      q => saida_q(3));
      
    S <= saida_q(3);

end ckt;      