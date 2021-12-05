library ieee;
use ieee.std_logic_1164.all;

entity Encaps_TIMER is
  port (Timer_EN,Timer_RST,Timer_CLK: in std_logic;
        MX_Timer: in std_logic_vector(1 downto 0);
        S_CPM_TIMER: out std_logic);
end Encaps_TIMER;

architecture ckt of Encaps_TIMER is
  component ContadorUpDown_16bits IS
      port (clk_ud, CUD, Cle, en: in std_logic;
            S: out std_logic_vector(15 downto 0));
  end component;
  
  component Comparador_16Bits is
      port (eA16,eB16: in std_logic_vector(15 downto 0);
            AeqB16,AltB16,AgtB16: out std_logic);
  end component;
  
  component MUX4_1_16BITS is
      port (C0,C1,C2,C3: in std_logic_vector(15 downto 0);
            E: in std_logic_vector(1 downto 0);
            O: out std_logic_vector(15 downto 0));
  end component;
  
  signal Saida_CONT, Saida_MUX: std_logic_vector(15 downto 0);
  signal lixo: std_logic_vector(1 downto 0);
  
  begin
    
    Contador: ContadorUpDown_16bits port map(
      Cle =>Timer_RST,
      en => Timer_EN,
      clk_ud => Timer_CLK,
      CUD => '0',
      S => Saida_CONT);
      
    
    MUX: MUX4_1_16BITS port map(
      C0 => "0000000010100000",
      C1 => "0000000111100000",
      C2 => "0000000000000000",
      C3 => "0000000000010000",
      E => MX_Timer,
      O => Saida_MUX);
      
    Comparador: Comparador_16Bits port map(
      eA16 => Saida_CONT,
      eB16 => Saida_MUX,
      AeqB16 => S_CPM_TIMER,
      AltB16 => lixo(0),
      AgtB16 => lixo(1));
end ckt;
           