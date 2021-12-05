library ieee;
use ieee.std_logic_1164.all;

entity Comparador_8Bits is
  port (eA8,eB8: in std_logic_vector(7 downto 0);
        AeqB8,AltB8,AgtB8: out std_logic);
end Comparador_8Bits;

architecture ckt of Comparador_8Bits is
  
  component Comparador_4Bits is
    port (eA,eB: in std_logic_vector(3 downto 0);
          gt,lt,eq: in std_logic;
          AeqB,AltB,AgtB: out std_logic);
 	end component;
  
  signal saida_gt,saida_lt,saida_eq: std_logic;
  begin
  Comp1:Comparador_4Bits port map(
        gt => '0',
        lt => '0',
        eq => '1',
        eA(3 downto 0) => eA8(7 downto 4),
        eB(3 downto 0) => eB8(7 downto 4),
        AeqB => saida_eq,
        AgtB => saida_gt,
        AltB => saida_lt);
  
  Comp2: Comparador_4Bits port map(
        gt => saida_gt,
        lt => saida_lt,
        eq => saida_eq,
        eA(3 downto 0) => eA8(3 downto 0),
        eB(3 downto 0) => eB8(3 downto 0),
        AeqB => AeqB8,
        AgtB => AgtB8,
        AltB => AltB8);
        
end ckt;