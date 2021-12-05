entity Schematic is
  port (S_in: in bit_vector(7 downto 0);
        T_out: out bit_vector(7 downto 0));
end Schematic;

architecture arrangement of Schematic is
  component Box01 is
    port (A_in: in bit_vector(3 downto 0);
          S_out: out bit_vector(3 downto 0));
  end component;
  
  signal box01_01_out, box01_02_out, box01_03_out, box01_04_out, box01_05_out: bit_vector(3 downto 0);

begin
  
  BX01: Box01 port map(
      A_in=>S_in(7 downto 4),
      S_out=> box01_01_out);
  
  BX02: Box01 port map(
      A_in=>S_in(3 downto 0),
      S_out=> box01_02_out);
      
  BX03: Box01 port map(
      A_in(3 downto 2)=>box01_01_out(1 downto 0),
      A_in(1 downto 0)=>box01_02_out(3 downto 2),
      S_out=> box01_03_out);
  
  BX04: Box01 port map(
      A_in(3 downto 2)=>box01_01_out(3 downto 2),
      A_in(1 downto 0)=>box01_02_out(1 downto 0),
      S_out=> box01_04_out);
      
  BX05: Box01 port map(
      A_in(3)=>S_in(7),
      A_in(2)=>S_in(3),
      A_in(1)=>S_in(1),
      A_in(0)=>S_in(6),
      S_out=>box01_05_out);
      
  T_out(7 downto 4)<=box01_03_out;
  T_out(3 downto 2)<=box01_04_out(3 downto 2);
  T_out(1 downto 0)<=box01_04_out(1 downto 0) or box01_05_out(3 downto 2);
  
end arrangement;