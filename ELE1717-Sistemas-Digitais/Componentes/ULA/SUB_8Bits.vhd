library ieee ;
use ieee.std_logic_1164.all;

entity SUB_8Bits is
  port (sub_A8_in,sub_B8_in: in std_logic_vector(7 downto 0);
        sub_S8_out: out std_logic_vector(7 downto 0));
end SUB_8Bits;

architecture ckt of SUB_8Bits is
  
  component SUM_8Bits is
    port (A8_in,B8_in: in std_logic_vector(7 downto 0);
			C8_in: in std_logic;
			S8_out: out std_logic_vector(7 downto 0);
			C8_out: out std_logic);
 	end component;
  
  signal sub_B8_negado, sub_s8_result: std_logic_vector(7 downto 0);
  signal sub_c_out: std_logic;
  begin
		sub_B8_negado <= not sub_B8_in;
		
		Subtrador: SUM_8Bits port map(
			A8_in => sub_A8_in,
			B8_in => sub_B8_negado,
			C8_in => '1',
			S8_out => sub_s8_result,
			C8_out => sub_c_out);
		
		sub_S8_out <= sub_s8_result;     
end ckt;