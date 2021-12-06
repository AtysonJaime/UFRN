entity SUB_16B is
port( 

NUM_16B,SUBTRATOR_16B : in bit_vector (15 downto 0);
S_SUB_16B : out bit_vector(15 downto 0)); 

end SUB_16B;


architecture ckt of SUB_16B is
 component SUM_16B is 
 port(
 
  NUM1_16B,NUM2_16B : in bit_vector(15 downto 0);
   CIN_SUM_16B : in bit;
    COUT_SUM_16B : out bit;
     S_SUM_16B : out bit_vector(15 downto 0));
 
end component;  
  
  
  
signal sub_aux : bit_vector(15 downto 0);  
  
  
begin 
  
sub_aux <= not SUBTRATOR_16B;
  


subtra��o : SUM_16B port map(

NUM1_16B=>NUM_16B, 
NUM2_16B=>sub_aux,
CIN_SUM_16B=>'1',
S_SUM_16B=>S_SUB_16B);



end ckt;






