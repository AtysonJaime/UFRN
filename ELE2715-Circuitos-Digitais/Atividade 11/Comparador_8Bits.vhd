entity Comparador_8Bits is
  port (eA8,eB8: in bit_vector(7 downto 0);
        AeqB8,AltB8,AgtB8: out bit);
end Comparador_8Bits;

architecture ckt of Comparador_8Bits is
  
  component Comparador_4Bits is
    port (eA,eB: in bit_vector(3 downto 0);
          gt,lt,eq: in bit;
          AeqB,AltB,AgtB: out bit);
 	end component;
  
  signal saida_gt,saida_lt,saida_eq: bit;
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