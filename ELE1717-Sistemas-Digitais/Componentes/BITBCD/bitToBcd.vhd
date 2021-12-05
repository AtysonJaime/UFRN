library ieee;
use ieee.std_logic_1164.all;

entity bitToBcd is
  port (bit_in: in std_logic_vector(7 downto 0);
        bcd_out: out std_logic_vector(11 downto 0));
end bitToBcd ;

architecture ckt of bitToBcd is
  component ciBitToBcd is
    port (BtB_in: in std_logic_vector(3 downto 0);
          BtB_out: out std_logic_vector(3 downto 0));
  end component;
  
  signal ciBtB_01_out, ciBtB_02_out, ciBtB_03_out, ciBtB_04_out, ciBtB_05_out, ciBtB_06_out, ciBtB_07_out: std_logic_vector(3 downto 0); 
  
  begin 
      ciBtB01: ciBitToBcd port map(
           BtB_in(3) => '0',
           BtB_in(2 downto 0) => bit_in(7 downto 5),
           BtB_out => ciBtB_01_out);
      
      ciBtB02: ciBitToBcd port map(
           BtB_in(3 downto 1) => ciBtB_01_out(2 downto 0),
           BtB_in(0) => bit_in(4),
           BtB_out => ciBtB_02_out);
           
      ciBtB03: ciBitToBcd port map(
           BtB_in(3 downto 1) => ciBtB_02_out(2 downto 0),
           BtB_in(0) => bit_in(3),
           BtB_out => ciBtB_03_out);
           
      ciBtB04: ciBitToBcd port map(
           BtB_in(3) => '0',
           BtB_in(2) => ciBtB_01_out(3),
           BtB_in(1) => ciBtB_02_out(3),
           BtB_in(0) => ciBtB_03_out(3),           
           BtB_out => ciBtB_04_out);
           
      ciBtB05: ciBitToBcd port map(
           BtB_in(3 downto 1)=> ciBtB_03_out(2 downto 0),
           BtB_in(0) => bit_in(2),           
           BtB_out => ciBtB_05_out);
           
      ciBtB06: ciBitToBcd port map(
           BtB_in(3 downto 1)=> ciBtB_04_out(2 downto 0),
           BtB_in(0) => ciBtB_05_out(3),           
           BtB_out => ciBtB_06_out);
           
      ciBtB07: ciBitToBcd port map(
           BtB_in(3 downto 1)=> ciBtB_05_out(2 downto 0),
           BtB_in(0) => bit_in(1),           
           BtB_out => ciBtB_07_out);  
      
      bcd_out(11) <= '0';
      bcd_out(10) <= '0';
      bcd_out(9) <= ciBtB_04_out(3);
      bcd_out(8 downto 5) <= ciBtB_06_out;
      bcd_out(4 downto 1) <= ciBtB_07_out;
      bcd_out(0) <= bit_in(0);   
      
end ckt;    