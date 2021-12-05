library ieee;
use ieee.std_logic_1164.all;

entity ACUMU_16B is 
 port(
    
  CLK_ACUMU : in std_logic;    
  LD_ACUMU,CLR_ACUMU,PRE_ACUMU: in std_logic;
   I_Acumulador : in std_logic_vector(15 downto 0);
    S_acumulador : out std_logic_vector(15 downto 0));
   
end ACUMU_16B;


architecture ckt of ACUMU_16B is

component SUM_16B is 
 port(
 
  NUM1_16B,NUM2_16B : in std_logic_vector(15 downto 0);
   CIN_SUM_16B : in std_logic;
    COUT_SUM_16B : out std_logic;
     S_SUM_16B : out std_logic_vector(15 downto 0));
  
end component;


component REG_16B is

port ( 
    CLK_REG,CLR_REG,LD_REG,PRE_REG: in std_logic;
        D_16B : in std_logic_vector (15 downto 0);
          Q_16B :out std_logic_vector(15 downto 0));

end component;





signal saidasomador : std_logic_vector(15 downto 0);
signal qaux : std_logic_vector(15 downto 0);

begin

    S_acumulador <= qaux;



    incremento : SUM_16B port map(

        S_SUM_16B=>saidasomador,
        NUM1_16B=>I_acumulador,
        NUM2_16B=> qaux,
        CIN_SUM_16B=>'0');
     
     
    registrador : REG_16B port map(
        CLK_REG =>CLK_ACUMU,
        CLR_REG =>CLR_ACUMU,
        LD_REG =>LD_ACUMU,
        PRE_REG =>PRE_ACUMU,
        D_16B =>saidasomador,
        Q_16B =>qaux);      


  
end ckt;



