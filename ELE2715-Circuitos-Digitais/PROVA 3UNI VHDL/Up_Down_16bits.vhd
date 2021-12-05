library ieee;
use ieee.std_logic_1164.all;

ENTITY ContadorUpDown_16bits IS
  port (clk_ud, CUD, Cle, en: in std_logic;
        S: out std_logic_vector(15 downto 0));
end ContadorUpDown_16bits;

architecture ckt of ContadorUpDown_16bits is
  
component ffjk IS
  port ( clk ,J ,K ,P ,C : IN std_logic;
          q : OUT std_logic );
end component;

signal saida_q: std_logic_vector(15 downto 0);
signal UD,eJ,eK: std_logic;
signal saida_and_1, saida_and_1_barrado, saida_or_1, saida_and_2, saida_and_2_barrado, saida_or_2, saida_and_3, saida_and_3_barrado, saida_or_3: std_logic;
signal saida_and_4, saida_and_4_barrado, saida_or_4, saida_and_5, saida_and_5_barrado, saida_or_5, saida_and_6, saida_and_6_barrado, saida_or_6: std_logic;
signal saida_and_7, saida_and_7_barrado, saida_or_7, saida_and_8, saida_and_8_barrado, saida_or_8, saida_and_9, saida_and_9_barrado, saida_or_9: std_logic;
signal saida_and_10, saida_and_10_barrado, saida_or_10, saida_and_11, saida_and_11_barrado, saida_or_11, saida_and_12, saida_and_12_barrado, saida_or_12: std_logic;
signal saida_and_13, saida_and_13_barrado, saida_or_13, saida_and_14, saida_and_14_barrado, saida_or_14, saida_and_15, saida_and_15_barrado, saida_or_15: std_logic;
begin   
    
    UD <= not(CUD);
    eJ <= '1' and not(en);
    eK <= '1' and not(en);

    FFJK_1:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => eJ,
      K => eK,
      q => saida_q(0));
    
    saida_and_1 <= (UD and saida_q(0));
    saida_and_1_barrado <= (not(UD) and not(saida_q(0)));
    saida_or_1 <= (saida_and_1 or saida_and_1_barrado) and not(en);
  
    FFJK_2:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_1,
      K => saida_or_1,
      q => saida_q(1));
      
    saida_and_2 <= (saida_and_1 and saida_q(1));
    saida_and_2_barrado <= (saida_and_1_barrado and not(saida_q(1)));
    saida_or_2 <= (saida_and_2 or saida_and_2_barrado) and not(en);
    
    FFJK_3:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_2,
      K => saida_or_2,
      q => saida_q(2));
    
    saida_and_3 <= (saida_and_2 and saida_q(2));
    saida_and_3_barrado <= (saida_and_2_barrado and not(saida_q(2)));
    saida_or_3 <= (saida_and_3 or saida_and_3_barrado) and not(en);
    
    FFJK_4:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_3,
      K => saida_or_3,
      q => saida_q(3));
    
    saida_and_4 <= (saida_and_3 and saida_q(3));
    saida_and_4_barrado <= (saida_and_3_barrado and not(saida_q(3)));
    saida_or_4 <= (saida_and_4 or saida_and_4_barrado) and not(en);    
    
    FFJK_5:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_4,
      K => saida_or_4,
      q => saida_q(4));
    
    saida_and_5 <= (saida_and_4 and saida_q(4));
    saida_and_5_barrado <= (saida_and_4_barrado and not(saida_q(4)));
    saida_or_5 <= (saida_and_5 or saida_and_5_barrado) and not(en);    
    
    FFJK_6:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_5,
      K => saida_or_5,
      q => saida_q(5));

    saida_and_6 <= (saida_and_5 and saida_q(5));
    saida_and_6_barrado <= (saida_and_5_barrado and not(saida_q(5)));
    saida_or_6 <= (saida_and_6 or saida_and_6_barrado) and not(en);    
    
    FFJK_7:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_6,
      K => saida_or_6,
      q => saida_q(6));    
    
    saida_and_7 <= (saida_and_6 and saida_q(6));
    saida_and_7_barrado <= (saida_and_6_barrado and not(saida_q(6)));
    saida_or_7 <= (saida_and_7 or saida_and_7_barrado) and not(en);    
    
    FFJK_8:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_7,
      K => saida_or_7,
      q => saida_q(7));

    saida_and_8 <= (saida_and_7 and saida_q(7));
    saida_and_8_barrado <= (saida_and_7_barrado and not(saida_q(7)));
    saida_or_8<= (saida_and_8 or saida_and_8_barrado) and not(en);    
    
    FFJK_9:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_8,
      K => saida_or_8,
      q => saida_q(8));
    
    saida_and_9 <= (saida_and_8 and saida_q(8));
    saida_and_9_barrado <= (saida_and_8_barrado and not(saida_q(8)));
    saida_or_9<= (saida_and_9 or saida_and_9_barrado) and not(en);    
    
    FFJK_10:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_9,
      K => saida_or_9,
      q => saida_q(9));     
    
    saida_and_10 <= (saida_and_9 and saida_q(9));
    saida_and_10_barrado <= (saida_and_9_barrado and not(saida_q(9)));
    saida_or_10<= (saida_and_10 or saida_and_10_barrado) and not(en);    
    
    FFJK_11:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_10,
      K => saida_or_10,
      q => saida_q(10));

    saida_and_11 <= (saida_and_10 and saida_q(10));
    saida_and_11_barrado <= (saida_and_10_barrado and not(saida_q(10)));
    saida_or_11<= (saida_and_11 or saida_and_11_barrado) and not(en);    
    
    FFJK_12:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_11,
      K => saida_or_11,
      q => saida_q(11));

    saida_and_12 <= (saida_and_11 and saida_q(11));
    saida_and_12_barrado <= (saida_and_11_barrado and not(saida_q(11)));
    saida_or_12<= (saida_and_12 or saida_and_12_barrado) and not(en);    
    
    FFJK_13:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_12,
      K => saida_or_12,
      q => saida_q(12));

    saida_and_13 <= (saida_and_12 and saida_q(12));
    saida_and_13_barrado <= (saida_and_12_barrado and not(saida_q(12)));
    saida_or_13<= (saida_and_13 or saida_and_13_barrado) and not(en);    
    
    FFJK_14:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_13,
      K => saida_or_13,
      q => saida_q(13));

    saida_and_14 <= (saida_and_13 and saida_q(13));
    saida_and_14_barrado <= (saida_and_13_barrado and not(saida_q(13)));
    saida_or_14<= (saida_and_14 or saida_and_14_barrado) and not(en);    
    
    FFJK_15:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_14,
      K => saida_or_14,
      q => saida_q(14));

    saida_and_15 <= (saida_and_14 and saida_q(14));
    saida_and_15_barrado <= (saida_and_14_barrado and not(saida_q(14)));
    saida_or_15<= (saida_and_15 or saida_and_15_barrado) and not(en);    
    
    FFJK_16:ffjk port map(
      clk => clk_ud,
      C => Cle,
      P => '1',
      J => saida_or_15,
      K => saida_or_15,
      q => saida_q(15));
      
      S <= saida_q;
end ckt;