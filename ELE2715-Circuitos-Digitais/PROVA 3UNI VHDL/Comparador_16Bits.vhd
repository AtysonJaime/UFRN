library ieee;
use ieee.std_logic_1164.all;

entity Comparador_16Bits is
  port (eA16,eB16: in std_logic_vector(15 downto 0);
        AeqB16,AltB16,AgtB16: out std_logic);
end Comparador_16Bits;

architecture ckt of Comparador_16Bits is
  
  component Comparador_4Bits is
    port (eA,eB: in std_logic_vector(3 downto 0);
          gt,lt,eq: in std_logic;
          AeqB,AltB,AgtB: out std_logic);
 	end component;
  
  signal saida_gt,saida_lt,saida_eq: std_logic_vector(2 downto 0);
  begin
  Comp1:Comparador_4Bits port map(
        gt => '0',
        lt => '0',
        eq => '1',
        eA(3 downto 0) => eA16(15 downto 12),
        eB(3 downto 0) => eB16(15 downto 12),
        AeqB => saida_eq(2),
        AgtB => saida_gt(2),
        AltB => saida_lt(2));
  
  Comp2: Comparador_4Bits port map(
        gt => saida_gt(2),
        lt => saida_lt(2),
        eq => saida_eq(2),
        eA(3 downto 0) => eA16(11 downto 8),
        eB(3 downto 0) => eB16(11 downto 8),
        AeqB => saida_eq(1),
        AgtB => saida_gt(1),
        AltB => saida_lt(1));
  
  Comp3:Comparador_4Bits port map(
        gt => saida_gt(1),
        lt => saida_lt(1),
        eq => saida_eq(1),
        eA(3 downto 0) => eA16(7 downto 4),
        eB(3 downto 0) => eB16(7 downto 4),
        AeqB => saida_eq(0),
        AgtB => saida_gt(0),
        AltB => saida_lt(0));
  
  Comp4: Comparador_4Bits port map(
        gt => saida_gt(0),
        lt => saida_lt(0),
        eq => saida_eq(0),
        eA(3 downto 0) => eA16(3 downto 0),
        eB(3 downto 0) => eB16(3 downto 0),
        AeqB => AeqB16,
        AgtB => AgtB16,
        AltB => AltB16);
        
end ckt;