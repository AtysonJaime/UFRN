entity CircuitoCompleto IS
  port (A, B: in bit_vector(3 downto 0);
        Clk, Cle, EN: in bit;
        C: out bit_vector(3 downto 0));
end CircuitoCompleto;

architecture ckt of CircuitoCompleto is
  
component ContadorUpDown_4bits is
  port (A_in: in bit_vector(3 downto 0);
        clk_ud,c_ud, UD: in bit;
        S: out bit_vector(3 downto 0));
end component;

component ffjk is
  port ( clk ,J ,K ,P ,C : IN BIT;
          q : OUT BIT );
end component ;

component Comparador_4Bits is
  port (eA,eB: in bit_vector(3 downto 0);
        AeqB,AltB,AgtB: out bit);
end component;

component Sum4Bit is
    port (A4,B4: in bit_vector(3 downto 0);
          C4_in: in bit;
          S4: out bit_vector(3 downto 0);
          C4_out: out bit);
end component;

signal VInicialCP, saidaFF,novoA,novoB: bit_vector(3 downto 0);
signal LixoA, LixoB, LixoSum:bit_vector(1 downto 0);
signal saidaComA, saidaComB, outUD, notUD: bit;
begin
  VInicialCP(3) <= A(3) NAND EN;
  VInicialCP(2) <= A(2) NAND EN;
  VInicialCP(1) <= A(1) NAND EN;
  VInicialCP(0) <= A(0) NAND EN;
  
  
  Dim1Maior: Sum4Bit port map(
      A4 => B,
      B4 => "1111",
      C4_in => '0',
      S4 => novoB,
      C4_out => LixoSum(0));
  Sum1Menor: Sum4Bit port map(
      A4 => A,
      B4 => "0001",
      C4_in => '0',
      S4 => novoA,
      C4_out => LixoSum(1));
   
  ComA: Comparador_4Bits port map(
    eA => novoA,
    eB => saidaFF,
    AeqB => saidaComA,
    AltB => LixoA(0),
    AgtB => LixoA(1));
  
  ComB: Comparador_4Bits port map(
    eA => novoB,
    eB => saidaFF,
    AeqB => saidaComB,
    AltB => LixoB(0),
    AgtB => LixoB(1));
  
  FlipFlop:ffjk port map(
    clk => Clk,
    J => saidaComB,
    K => saidaComA,
    P => '1',
    C => Cle,
    q => outUD);
  notUD <= (NOT outUD);
  Contador:ContadorUpDown_4bits port map(
    A_in => VInicialCP,
    clk_ud => Clk,
    UD => notUD,
    c_ud => Cle,
    S => saidaFF);
    
    
  C <= saidaFF;

end ckt;