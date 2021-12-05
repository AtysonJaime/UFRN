library ieee;
use ieee.std_logic_1164.all;

entity bitToBcd13bits is
  port (bit_in: in std_logic_vector(12 downto 0);
        bcd_out: out std_logic_vector(15 downto 0));
end bitToBcd13bits ;

architecture ckt of bitToBcd13bits is
  component ciBitToBcd is
    port (BtB_in: in std_logic_vector(3 downto 0);
          BtB_out: out std_logic_vector(3 downto 0));
  end component;
  
  signal ciBtB_01_out, ciBtB_02_out, ciBtB_03_out, ciBtB_04_out, ciBtB_05_out, ciBtB_06_out, ciBtB_07_out, ciBtB_08_out, ciBtB_09_out: std_logic_vector(3 downto 0);
  signal ciBtB_10_out, ciBtB_11_out, ciBtB_12_out, ciBtB_13_out, ciBtB_14_out, ciBtB_15_out, ciBtB_16_out, ciBtB_17_out, ciBtB_18_out: std_logic_vector(3 downto 0);
  signal ciBtB_19_out, ciBtB_20_out, ciBtB_21_out: std_logic_vector(3 downto 0);
  
  begin
	  ciBtB01: ciBitToBcd port map(
				  BtB_in(3) => '0',
				  BtB_in(2 downto 0) => bit_in(12 downto 10),
				  BtB_out => ciBtB_01_out);
      
	  ciBtB02: ciBitToBcd port map(
				  BtB_in(3 downto 1) => ciBtB_01_out(2 downto 0),
				  BtB_in(0) => bit_in(9),
				  BtB_out => ciBtB_02_out);
           
	  ciBtB03: ciBitToBcd port map(
				  BtB_in(3 downto 1) => ciBtB_02_out(2 downto 0),
				  BtB_in(0) => bit_in(8),
				  BtB_out => ciBtB_03_out);
				  
	  ciBtB04: ciBitToBcd port map(
				  BtB_in(3) => '0',
				  BtB_in(2) => ciBtB_01_out(3),
				  BtB_in(1) => ciBtB_02_out(3),
				  BtB_in(0) => ciBtB_03_out(3),           
				  BtB_out => ciBtB_04_out);
				  
	  ciBtB05: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_03_out(2 downto 0),
				  BtB_in(0) => bit_in(7),           
				  BtB_out => ciBtB_05_out);
				  
	  ciBtB06: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_04_out(2 downto 0),
				  BtB_in(0) => ciBtB_05_out(3),           
				  BtB_out => ciBtB_06_out);
				  
	  ciBtB07: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_05_out(2 downto 0),
				  BtB_in(0) => bit_in(6),           
				  BtB_out => ciBtB_07_out);
	  
	  ciBtB08: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_06_out(2 downto 0),
				  BtB_in(0) => ciBtB_07_out(3),           
				  BtB_out => ciBtB_08_out);
	  
	  ciBtB09: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_07_out(2 downto 0),
				  BtB_in(0) => bit_in(5),           
				  BtB_out => ciBtB_09_out);
		
	  ciBtB10: ciBitToBcd port map(
				  BtB_in(3) => '0',
				  BtB_in(2) => ciBtB_04_out(3),
				  BtB_in(1) => ciBtB_06_out(3),
				  BtB_in(0) => ciBtB_08_out(3),           
				  BtB_out => ciBtB_10_out);
	  
	  ciBtB11: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_08_out(2 downto 0),
				  BtB_in(0) => ciBtB_09_out(3),           
				  BtB_out => ciBtB_11_out);
	  
	  ciBtB12: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_09_out(2 downto 0),
				  BtB_in(0) => bit_in(4),           
				  BtB_out => ciBtB_12_out);
		
	  ciBtB13: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_10_out(2 downto 0),
				  BtB_in(0) => ciBtB_11_out(3),           
				  BtB_out => ciBtB_13_out);
		
	  ciBtB14: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_11_out(2 downto 0),
				  BtB_in(0) => ciBtB_12_out(3),           
				  BtB_out => ciBtB_14_out);
	
	  ciBtB15: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_12_out(2 downto 0),
				  BtB_in(0) => bit_in(3),           
				  BtB_out => ciBtB_15_out);
	  
	  ciBtB16: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_13_out(2 downto 0),
				  BtB_in(0) => ciBtB_14_out(3),           
				  BtB_out => ciBtB_16_out);
	  
	  ciBtB17: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_14_out(2 downto 0),
				  BtB_in(0) => ciBtB_15_out(3),           
				  BtB_out => ciBtB_17_out);
	
	  ciBtB18: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_15_out(2 downto 0),
				  BtB_in(0) => bit_in(2),           
				  BtB_out => ciBtB_18_out);
	
	  ciBtB19: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_16_out(2 downto 0),
				  BtB_in(0) => ciBtB_17_out(3),           
				  BtB_out => ciBtB_19_out);
	  
	  ciBtB20: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_17_out(2 downto 0),
				  BtB_in(0) => ciBtB_18_out(3),           
				  BtB_out => ciBtB_20_out);
	
	  ciBtB21: ciBitToBcd port map(
				  BtB_in(3 downto 1)=> ciBtB_18_out(2 downto 0),
				  BtB_in(0) => bit_in(1),           
				  BtB_out => ciBtB_21_out);
	
	  bcd_out(15) <= ciBtB_10_out(3);
	  bcd_out(14) <= ciBtB_13_out(3);
	  bcd_out(13) <= ciBtB_16_out(3);
	  bcd_out(12 downto 9) <= ciBtB_19_out;
	  bcd_out(8 downto 5) <= ciBtB_20_out;
	  bcd_out(4 downto 1) <= ciBtB_21_out;
	  bcd_out(0) <= bit_in(0);
		
end ckt;