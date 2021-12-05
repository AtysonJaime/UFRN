entity Maquina_de_Vendas is
  port (c, Clk, clr: in bit;
        S,A: in bit_vector(7 downto 0);
        d: out bit);
end Maquina_de_Vendas;

architecture display of Maquina_de_Vendas is
  component Sum8Bits is
    port (A8,B8: in bit_vector(7 downto 0);
          C8_in: in bit;
          S8: out bit_vector(7 downto 0);
          C8_out: out bit);
  end component;
  
  component Comparador_8Bits is
    port (eA8,eB8: in bit_vector(7 downto 0);
          AeqB8,AltB8,AgtB8: out bit);
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
  
  signal Tot, Reg_out:  bit_vector(7 downto 0);
  signal ld,cl,lixo,leq,llt,MD, J1,K0: bit;
  signal ffd_out: bit_vector(1 downto 0);
  begin
    -- DataPath --
    REG: Registrador8bits_Mux2_1 port map(
      I8 => Tot,
      LD => ld,
      CLR => cl,
      CLK => Clk,
      I8_out => Reg_out);
      
    SUM: Sum8Bits port map(
      A8 => Reg_out,
      B8 => A,
      C8_in => '0',
      S8 => Tot,
      C8_out => lixo);
    COMP: Comparador_8Bits port map(
      eA8 => S,
      eB8 => Reg_Out,
      AeqB8 =>  leq,
      AltB8 => llt,
      AgtB8 => MD);
    
    -- Controlador --
    
    J1 <= (ffd_out(0) AND (c OR (NOT(MD))));
    K0 <= (ffd_out(1) OR c);
    
    FFJK1: ffjk port map(
      clk => Clk,
      J => J1,
      K => '1',
      P => '1',
      C => clr,
      q => ffd_out(1));
    
    FFJK0: ffjk port map(
      clk => Clk,
      J => '1',
      K => K0,
      P => '1',
      C => clr,
      q => ffd_out(0));   
    
    ld <= (ffd_out(1) AND (NOT(ffd_out(0))));
    cl <=NOT(((NOT(ffd_out(1))) AND (NOT(ffd_out(0)))));
    d <= (ffd_out(1) AND ffd_out(0));
    
end display;