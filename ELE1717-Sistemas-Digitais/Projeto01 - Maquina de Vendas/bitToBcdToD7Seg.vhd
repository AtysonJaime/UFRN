library ieee;
use ieee.std_logic_1164.all;

entity bitToBcdToD7Seg is
  port (SW_in: in std_logic_vector(7 downto 0);
        HEX0,HEX1,HEX2: out std_logic_vector(6 downto 0));
end bitToBcdToD7Seg ;

architecture ckt of bitToBcdToD7Seg is
  component bitToBcd is
    port (bit_in: in std_logic_vector(7 downto 0);
			 bcd_out: out std_logic_vector(11 downto 0));
  end component;
  component d7Seg is
	  port(S_in: in std_logic_vector(3 downto 0);
			 D_out: out std_logic_vector(6 downto 0));
  end component;
  
  signal bcd_ax_out: std_logic_vector(11 downto 0);
  signal hex0_ax_out,hex1_ax_out,hex2_ax_out : std_logic_vector(6 downto 0);
  
  begin 
      BtB: BitToBcd port map(
           bit_in => SW_in,
           bcd_out => bcd_ax_out);
		
		D7S2: d7Seg port map(
				S_in => bcd_ax_out(11 downto 8),
				D_out => hex2_ax_out);
		
		D7S1: d7Seg port map(
				S_in => bcd_ax_out(7 downto 4),
				D_out => hex1_ax_out);
		
		D7S0: d7Seg port map(
				S_in => bcd_ax_out(3 downto 0),
				D_out => hex0_ax_out);
		HEX0 <= hex0_ax_out;
		HEX1 <= hex1_ax_out;
		HEX2 <= hex2_ax_out;     
end ckt;    