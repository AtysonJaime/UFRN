library ieee;
use ieee.std_logic_1164.all;

entity Encaps_BancoContador is
  port (End_Banco: in std_logic_vector(3 downto 0);
        En_Banco, RST_Banco, UD_Banco, CLK_Banco: in std_logic;
        S_Banco: out std_logic_vector(15 downto 0));
end Encaps_BancoContador;

Architecture ckt of Encaps_BancoContador is
  component MUX16_1_16BITS is
      port (C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15: in std_logic_vector(15 downto 0);
            E: in std_logic_vector(3 downto 0);
            O: out std_logic_vector(15 downto 0));
  end component;
  
  component ContadorUpDown_16bits IS
      port (clk_ud, CUD, Cle, en: in std_logic;
            S: out std_logic_vector(15 downto 0));
  end component;
  
  signal E100,E50,E25,E10,E5,NEn_Banco:std_logic;
  signal S100,S50,S25,S10,S5,zero: std_logic_vector(15 downto 0);
  begin
    NEn_Banco <= not(En_Banco);
    E100 <= not((not(End_Banco(0)) and not(End_Banco(1)) and not(End_Banco(2))) and (NEn_Banco)); 
    E50 <= not(((End_Banco(0)) and not(End_Banco(1)) and not(End_Banco(2))) and (NEn_Banco));
    E25 <= not((not(End_Banco(0)) and (End_Banco(1)) and not(End_Banco(2))) and (NEn_Banco));
    E10 <= not(((End_Banco(0)) and (End_Banco(1)) and not(End_Banco(2))) and (NEn_Banco));
    E5 <= not((not(End_Banco(0)) and not(End_Banco(1)) and (End_Banco(2))) and (En_Banco));
    zero <= "0000000000000000";
    
    Cont100: ContadorUpDown_16bits port map(
      clk_ud => CLK_Banco,
      CUD => UD_Banco,
      Cle => RST_Banco,
      en => E100,
      S => S100);

    Cont50: ContadorUpDown_16bits port map(
      clk_ud => CLK_Banco,
      CUD => UD_Banco,
      Cle => RST_Banco,
      en => E50,
      S => S50);

    Cont25: ContadorUpDown_16bits port map(
      clk_ud => CLK_Banco,
      CUD => UD_Banco,
      Cle => RST_Banco,
      en => E25,
      S => S25);
      
    Cont10: ContadorUpDown_16bits port map(
      clk_ud => CLK_Banco,
      CUD => UD_Banco,
      Cle => RST_Banco,
      en => E10,
      S => S10);
  
    Cont5: ContadorUpDown_16bits port map(
      clk_ud => CLK_Banco,
      CUD => UD_Banco,
      Cle => RST_Banco,
      en => E5,
      S => S5);
      
    MUX: MUX16_1_16BITS port map(
      C0 =>S100,
      C1 =>S50,
      C2 =>S25,
      C3 =>S10,
      C4 =>S5,
      C5 =>zero,
      C6 =>zero,
      C7 =>zero,
      C8 =>zero,
      C9 =>zero,
      C10 =>zero,
      C11 =>zero,
      C12 =>zero,
      C13 =>zero,
      C14 =>zero,
      C15 =>zero,
      E => End_Banco,
      O => S_Banco); 
end ckt;