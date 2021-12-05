entity BINBCD is
  port (SW: in bit_vector(7 downto 0);
        bcd_out: out bit_vector(11 downto 0));
end BINBCD ;

architecture display of BINBCD is
  component Box01 is
    port (A: in bit_vector(3 downto 0);
          S_out: out bit_vector(3 downto 0));
  end component;
  
  component C7seg is
    port (S_in: in bit_vector(3 downto 0);
          T_out: out bit_vector(6 downto 0));
  end component;
  
  signal box01_01_out, box01_02_out, box01_03_out, box01_04_out, box01_05_out, box01_06_out, box01_07_out: bit_vector(3 downto 0); 
  
  begin 
      BX01: Box01 port map(
           A(3)=>'0',
           A(2 downto 0) => SW(7 downto 5),
           S_out=> box01_01_out);
      
      BX02: Box01 port map(
           A(3 downto 1)=> box01_01_out(2 downto 0),
           A(0) => SW(4),
           S_out=> box01_02_out);
           
      BX03: Box01 port map(
           A(3 downto 1)=> box01_02_out(2 downto 0),
           A(0) => SW(3),
           S_out=> box01_03_out);
           
      BX04: Box01 port map(
           A(3)=>'0',
           A(2) => box01_01_out(3),
           A(1) => box01_02_out(3),
           A(0) => box01_03_out(3),           
           S_out=> box01_04_out);
           
      BX05: Box01 port map(
           A(3 downto 1)=> box01_03_out(2 downto 0),
           A(0) => SW(2),           
           S_out=> box01_05_out);
           
      BX06: Box01 port map(
           A(3 downto 1)=> box01_04_out(2 downto 0),
           A(0) => box01_05_out(3),           
           S_out=> box01_06_out);
           
      BX07: Box01 port map(
           A(3 downto 1)=> box01_05_out(2 downto 0),
           A(0) => SW(1),           
           S_out=> box01_07_out);  
      
      bcd_out(11) <= '0';
      bcd_out(10) <= '0';
      bcd_out(9) <= box01_04_out(3);
      bcd_out(8 downto 5) <= box01_06_out;
      bcd_out(4 downto 1) <= box01_07_out;
      bcd_out(0) <= SW(0);   
      
end display;    