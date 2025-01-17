ENTITY Up_Down_4bits IS
  port (clk_ud, UD, Cle: in bit;
        S: out bit_vector(3 downto 0));
end Up_Down_4bits;

architecture ckt of Up_Down_4bits is
  
component ffjk IS
  port ( clk ,J ,K ,P ,C : IN BIT;
          q : OUT BIT );
end component;

signal saida_q: bit_vector(3 downto 0);
signal Clear_15,saida_and_1, saida_and_1_barrado, saida_or_1, saida_and_2, saida_and_2_barrado, saida_or_2, saida_and_3, saida_and_3_barrado, saida_or_3: bit;

begin   
    --Clear_15 <= c_ud(0) AND c_ud(1);--
    
    FFJK_1:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => '1',
      K => '1',
      q => saida_q(0));
    
    saida_and_1 <= (UD and saida_q(0));
    saida_and_1_barrado <= (not(UD) and not(saida_q(0)));
    saida_or_1 <= saida_and_1 or saida_and_1_barrado;
  
    FFJK_2:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_1,
      K => saida_or_1,
      q => saida_q(1));
      
    saida_and_2 <= (saida_and_1 and saida_q(1));
    saida_and_2_barrado <= (saida_and_1_barrado and not(saida_q(1)));
    saida_or_2 <= saida_and_2 or saida_and_2_barrado;
    
    FFJK_3:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_2,
      K => saida_or_2,
      q => saida_q(2));
    
    saida_and_3 <= (saida_and_2 and saida_q(2));
    saida_and_3_barrado <= (saida_and_2_barrado and not(saida_q(2)));
    saida_or_3 <= saida_and_3 or saida_and_3_barrado;
    
    FFJK_4:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_3,
      K => saida_or_3,
      q => saida_q(3));
       
    S <= saida_q;
    
end ckt;