library ieee;
use ieee.std_logic_1164.all;

entity MUX16_1_16BITS is
  port (C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15: in std_logic_vector(15 downto 0);
        E: in std_logic_vector(3 downto 0);
        O: out std_logic_vector(15 downto 0));
end MUX16_1_16BITS;

Architecture ckt of MUX16_1_16BITS is
  component MUX16Bits is
      port (I1,I0: in std_logic_vector (15 downto 0);
            SS: in std_logic;
            d: out std_logic_vector(15 downto 0));
  end component;
  
  signal SaidaMux1,SaidaMux2,SaidaMux3,SaidaMux4,SaidaMux5,SaidaMux6,SaidaMux7,SaidaMux8,SaidaSegMux1,SaidaSegMux2,SaidaSegMux3,SaidaSegMux4,SaidaFinalMux1,SaidaFinalMux2: std_logic_vector(15 downto 0);
  
  begin
    --Primeira Intera��o do Mux--
    MUX1: MUX16Bits port map(
      I0 => C0,
      I1 => C1,
      SS => E(0),
      d => SaidaMux1);
    MUX2: MUX16Bits port map(
      I0 => C2,
      I1 => C3,
      SS => E(0),
      d => SaidaMux2);
    MUX3: MUX16Bits port map(
      I0 => C4,
      I1 => C5,
      SS => E(0),
      d => SaidaMux3);
    MUX4: MUX16Bits port map(
      I0 => C6,
      I1 => C7,
      SS => E(0),
      d => SaidaMux4);
    MUX5: MUX16Bits port map(
      I0 => C8,
      I1 => C9,
      SS => E(0),
      d => SaidaMux5);
    MUX6: MUX16Bits port map(
      I0 => C10,
      I1 => C11,
      SS => E(0),
      d => SaidaMux6);
    MUX7: MUX16Bits port map(
      I0 => C12,
      I1 => C13,
      SS => E(0),
      d => SaidaMux7);
    MUX8: MUX16Bits port map(
      I0 => C14,
      I1 => C15,
      SS => E(0),
      d => SaidaMux8);
    
    --Segunda intera��o do Mux--
    MUX9: MUX16Bits port map(
      I0 => SaidaMux1,
      I1 => SaidaMux2,
      SS => E(1),
      d => SaidaSegMux1);
    MUX10: MUX16Bits port map(
      I0 => SaidaMux3,
      I1 => SaidaMux4,
      SS => E(1),
      d => SaidaSegMux2); 
    MUX11: MUX16Bits port map(
      I0 => SaidaMux5,
      I1 => SaidaMux6,
      SS => E(1),
      d => SaidaSegMux3); 
    MUX12: MUX16Bits port map(
      I0 => SaidaMux7,
      I1 => SaidaMux8,
      SS => E(1),
      d => SaidaSegMux4);
      
    --Terceira Intera��o do Mux--
    MUX13: MUX16Bits port map(
      I0 => SaidaSegMux1,
      I1 => SaidaSegMux2,
      SS => E(2),
      d => SaidaFinalMux1);
    MUX14: MUX16Bits port map(
      I0 => SaidaSegMux3,
      I1 => SaidaSegMux4,
      SS => E(2),
      d => SaidaFinalMux2);
   
   --Quarta Intera��o do Mux--
    MUX15: MUX16Bits port map(
      I0 => SaidaFinalMux1,
      I1 => SaidaFinalMux2,
      SS => E(3),
      d => O);
      
end ckt;           