entity Registrador is
  port( load,shr,shl,set,clr,Clk,shr_in,shl_in: in bit;
       I: in  bit_vector(3 downto 0);
       S: out bit_vector(3 downto 0));
end Registrador;

architecture ckt of Registrador is

component ffd is
  port (clk ,D,P,C: IN BIT ;
        q: OUT BIT );
end component ;

component MUX8_1 is
  port (I7,I6,I5,I4,I3,I2,I1,I0,S2,S1,S0: in bit;
        Z: out bit);
end component;

signal inS2,inS1,inS0: bit;
signal saidaFF, saidaMUX: bit_vector(3 downto 0);
begin
  inS2 <= ((NOT(load)) AND (NOT(shr)) AND (NOT(shl)) AND (set OR clr));
  inS1 <= ((NOT(load)) AND (shr OR shl));
  inS0 <= (load OR ((NOT(shr)) AND shl) OR ((NOT(shr)) AND (NOT(set)) AND clr)); 

  PMUX: MUX8_1 port map(
    I7 => saidaFF(3),
    I6 => saidaFF(3),
    I5 => '0',
    I4 => '1',
    I3 => saidaFF(2),
    I2 => shr_in,
    I1 => I(3), 
    I0 => saidaFF(3),
    S2 => inS2,
    S1 => inS1,
    S0 => inS0,
    Z => saidaMUX(3));
  
  PFFD: ffd port map(
    D => saidaMUX(3),
    P => '1',
    C => '1',
    clk => Clk,
    q => saidaFF(3));
    
  
  SMUX: MUX8_1 port map(
    I7 => saidaFF(2),
    I6 => saidaFF(2),
    I5 => '0',
    I4 => '1',
    I3 => saidaFF(1),
    I2 => saidaFF(3),
    I1 => I(2), 
    I0 => saidaFF(2),
    S2 => inS2,
    S1 => inS1,
    S0 => inS0,
    Z => saidaMUX(2));
  
  SFFD: ffd port map(
    D => saidaMUX(2),
    P => '1',
    C => '1',
    clk => Clk,
    q => saidaFF(2));
    
  TMUX: MUX8_1 port map(
    I7 => saidaFF(1),
    I6 => saidaFF(1),
    I5 => '0',
    I4 => '1',
    I3 => saidaFF(0),
    I2 => saidaFF(2),
    I1 => I(1), 
    I0 => saidaFF(1),
    S2 => inS2,
    S1 => inS1,
    S0 => inS0,
    Z => saidaMUX(1));
  
  TFFD: ffd port map(
    D => saidaMUX(1),
    P => '1',
    C => '1',
    clk => Clk,
    q => saidaFF(1));
  
  QMUX: MUX8_1 port map(
    I7 => saidaFF(0),
    I6 => saidaFF(0),
    I5 => '0',
    I4 => '1',
    I3 => shl_in,
    I2 => saidaFF(1),
    I1 => I(0), 
    I0 => saidaFF(0),
    S2 => inS2,
    S1 => inS1,
    S0 => inS0,
    Z => saidaMUX(0));
    
  QFFD: ffd port map(
    D => saidaMUX(0),
    P => '1',
    C => '1',
    clk => Clk,
    q => saidaFF(0));
    
  S <= saidaFF;

end ckt;
  
  
  
