entity MUX8_1 is
  port (I7,I6,I5,I4,I3,I2,I1,I0,S2,S1,S0: in bit;
        Z: out bit);
end MUX8_1;

Architecture ckt of MUX8_1 is

component MUX2_1 is
  port (I_1,I_0,S: in bit;
        d: out bit);
end component ;

signal Saida_1,Saida_2,Saida_3,Saida_4,Saida_5,Saida_6,Saida_7:bit;

Begin
  PP1: MUX2_1 port map(
    I_0 => I0,
    I_1 => I1,
    S => S0,
    d => Saida_1);
    
  PP2: MUX2_1 port map(
    I_0 => I2,
    I_1 => I3,
    S => S0,
    d => Saida_2);
  
  PP3: MUX2_1 port map(
    I_0 => I4,
    I_1 => I5,
    S => S0,
    d => Saida_3);
  
  PP4: MUX2_1 port map(
    I_0 => I6,
    I_1 => I7,
    S => S0,
    d => Saida_4);
    
  SP1: MUX2_1 port map(
    I_0 => Saida_1,
    I_1 => Saida_2,
    S => S1,
    d => Saida_5);
    
  SP2: MUX2_1 port map(
    I_0 => Saida_3,
    I_1 => Saida_4,
    S => S1,
    d => Saida_6);
  
  TP1: MUX2_1 port map(
    I_0 => Saida_5,
    I_1 => Saida_6,
    S => S2,
    d => Saida_7);
    
  Z <= Saida_7;
     
end ckt;