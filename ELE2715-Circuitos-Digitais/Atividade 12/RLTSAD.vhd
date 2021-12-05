entity RTL_SAD is
  port(A,B:in bit_vector(7 downto 0);
       Clk,CLE,c: in bit;
       SAD: out bit_vector(7 downto 0);
       D: out bit);
end RTL_SAD;

architecture ckt of RTL_SAD is
  component V_Abs is
    port(Ain,Bin: in bit_vector(7 downto 0);
         Absout: out bit_vector(7 downto 0));
  end component;
  
  component ContadorUpDown_4bits is
    port (clk_ud, UD, Cle: in bit;
          S: out bit_vector(3 downto 0));
  end component;
  
  component Sum8Bits is
    port (A8,B8: in bit_vector(7 downto 0);
          C8_in: in bit;
          S8: out bit_vector(7 downto 0);
          C8_out: out bit);
  end component;
  
  component Registrador8bits_Mux2_1 is
    port (LD,CLR, CLK: in bit;
          I8: in bit_vector(7 downto 0);
          I8_out: out bit_vector(7 downto 0));
  end component;
  
  component ffjk is
    port ( clk ,J ,K ,P ,C : IN BIT;
          q : OUT BIT );
  end component;
  
  component Comparador_4Bits is
    port (eA,eB: in bit_vector(3 downto 0);
        gt,lt,eq: in bit;
        AeqB,AltB,AgtB: out bit);
  end component;
  
  signal lds,ldi,ldr,cli,clr,ci,J2,J1,J0,K1,K0: bit;
  signal Tot,AabsB, REGoutR:  bit_vector(7 downto 0);
  signal outCont: bit_vector(3 downto 0);
  signal OutJK: bit_vector(2 downto 0);
  signal l: bit_vector(2 downto 0);
  begin
    --Controlador--
    J2 <= (OutJK(1) AND OutJK(0) AND ci);
    J1 <= OutJK(0);
    J0 <= ((NOT(OutJK(1))) AND c);
    K1 <= NOT(OutJK(0));
    K0 <= ((NOT(OutJK(2))) AND OutJK(1) AND (NOT(ci)));
    
    FFJD2: ffjk port map(
    clk => Clk,
    J => J2,
    k =>'1',
    P => '1',
    C => CLE,
    q => OutJK(2));
    
    FFJD1: ffjk port map(
    clk => Clk,
    J => J1,
    k => K1,
    P => '1',
    C => CLE,
    q => OutJK(1));
    
    FFJD0: ffjk port map(
    clk => Clk,
    J => J0,
    k => K0,
    P => '1',
    C => CLE,
    q => OutJK(0));
    
    cli <= NOT((NOT(OutJK(1))) AND OutJK(0));
    clr <= NOT((NOT(OutJK(1))) AND OutJK(0));
    D <= (OutJK(1) AND (NOT(OutJK(0))));
    lds <= (OutJK(1) AND (NOT(OutJK(0))));
    ldr <= OutJK(2);
    ldi <= OutJK(2);
    
    --DATAPATH--
    
    --Incrementador--
    Cont: ContadorUpDown_4bits port map(
        clk_ud => ldi,
        UD => '1',
        Cle => cli,
        S => outCont);
    
    CompM15: Comparador_4Bits port map(
        eA => outCont,
        eB => "1111",
        gt => '0',
        lt => '0',
        eq => '1',
        AeqB => l(0),
        AltB => ci,
       
AgtB => l(1));
       
   
--Registrador r--
    RegR: Registrador8bits_Mux2_1 port map(
      LD => ldr,
      CLR => clr,
      CLK => Clk,
      I8 => Tot,
      I8_out => REGoutR);
    
    VAbsoluto: V_Abs port map(
      Ain => A,
      Bin => B,
      Absout => AabsB);
    
    SUM: Sum8Bits port map(
      A8 =>REGoutR,
      B8 =>AabsB,
      C8_in =>'0',
      S8 =>Tot,
      C8_out =>l(2));
    
    --Registrador s--
    RegS: Registrador8bits_Mux2_1 port map(
      LD => lds,
      CLR => '1',
      CLK => Clk,
      I8 => REGoutR,
      I8_out => SAD);
 
end ckt;