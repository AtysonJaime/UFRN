library ieee;
use ieee.std_logic_1164.all;

entity REG_16B is

port ( CLK_REG,CLR_REG,LD_REG,PRE_REG: in std_logic;
        D_16B : in std_logic_vector (15 downto 0);
        Q_16B :out std_logic_vector(15 downto 0));
end REG_16B;


architecture ckt of REG_16B is
 component ffd IS
  port ( clk,D,P,C : IN std_logic;
    q : OUT std_logic );
END component ;

signal Qaux : std_logic_vector (15 downto 0);
signal Daux : std_logic_vector (15 downto 0);


begin 

Daux(15) <= (Qaux(15) and LD_REG) or (D_16B(15) and not LD_REG);
Daux(14) <= (Qaux(14) and LD_REG) or (D_16B(14) and not LD_REG);
Daux(13) <= (Qaux(13) and LD_REG) or (D_16B(13) and not LD_REG);
Daux(12) <= (Qaux(12) and LD_REG) or (D_16B(12) and not LD_REG);
Daux(11) <= (Qaux(11) and LD_REG) or (D_16B(11) and not LD_REG);
Daux(10) <= (Qaux(10) and LD_REG) or (D_16B(10) and not LD_REG);
Daux(9) <= (Qaux(9) and LD_REG) or (D_16B(9) and not LD_REG);
Daux(8) <= (Qaux(8) and LD_REG) or (D_16B(8) and not LD_REG);
Daux(7) <= (Qaux(7) and LD_REG) or (D_16B(7) and not LD_REG);
Daux(6) <= (Qaux(6) and LD_REG) or (D_16B(6) and not LD_REG);
Daux(5) <= (Qaux(5) and LD_REG) or (D_16B(5) and not LD_REG);
Daux(4) <= (Qaux(4) and LD_REG) or (D_16B(4) and not LD_REG);
Daux(3) <= (Qaux(3) and LD_REG) or (D_16B(3) and not LD_REG);
Daux(2) <= (Qaux(2) and LD_REG) or (D_16B(2) and not LD_REG);
Daux(1) <= (Qaux(1) and LD_REG) or (D_16B(1) and not LD_REG);
Daux(0) <= (Qaux(0) and LD_REG) or (D_16B(0) and not LD_REG);

Q_16B <= Qaux; 
       
        
flip15 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(15),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(15));
  
  
flip14 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(14),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(14));
  

flip13 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(13),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(13));


flip12 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(12),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(12));
  

flip11 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(11),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(11));
  
  
flip10 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(10),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(10));
   
  
flip9 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(9),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(9));
  
  
flip8 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(8),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(8));


flip7 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(7),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(7));
  
  
flip6 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(6),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(6));
  


flip5 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(5),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(5));
  


flip4 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(4),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(4));
  

flip3 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(3),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(3));
  
  
flip2 : ffd port map(  

  clk =>CLK_REG,
  D =>Daux(2),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(2));
  
  
  
flip1 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(1),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(1));
  
  
flip0 : ffd port map(  
 
  clk =>CLK_REG,
  D =>Daux(0),
  P =>PRE_REG,
  c =>CLR_REG,
  q =>Qaux(0));
  

end ckt;


