entity TRANSF is
  port (SW_in: in bit_vector(7 downto 0);
        HEX0: out bit_vector(6 downto 0);
        HEX1: out bit_vector(6 downto 0);
        HEX2: out bit_vector(6 downto 0));
end TRANSF;

architecture circuit of TRANSF is
  
  component BINBCD is
    port (SW: in bit_vector(7 downto 0);
          bcd_out: out bit_vector(11 downto 0));
  end component;
  
  component C7seg is
    port (S_in: in bit_vector(3 downto 0);
          T_out: out bit_vector(6 downto 0));
  end component;
      
  signal bct_box_out: bit_vector(11 downto 0);

  begin
      TRANS01: BINBCD port map(
        SW => SW_in,
        bcd_out => bct_box_out);
      
      HEX02: C7seg port map(
           S_in(3 downto 0)=> bct_box_out(11 downto 8),          
           T_out=> HEX2);
      
      HEX01: C7seg port map(
           S_in(3 downto 0)=> bct_box_out(7 downto 4),           
           T_out=> HEX1);
      
      HEX00: C7seg port map(
           S_in(3 downto 0)=> bct_box_out(3 downto 0),          
           T_out=> HEX0); 


end circuit;