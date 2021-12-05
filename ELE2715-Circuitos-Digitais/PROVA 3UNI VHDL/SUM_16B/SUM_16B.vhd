library ieee;
use ieee.std_logic_1164.all;

entity SUM_16B is 
 port(
 
  NUM1_16B,NUM2_16B : in std_logic_vector(15 downto 0);
  CIN_SUM_16B : in std_logic;
  COUT_SUM_16B : out std_logic;
  S_SUM_16B : out std_logic_vector(15 downto 0));
 
end SUM_16B;


architecture encapss4 of SUM_16B is
 component somadorb1 is 
  port ( 
 
  A,B,CIN : in std_logic;
   S,CS : out std_logic);
  
end component;


signal conect : std_logic_vector(14 downto 0);


begin 

lsb : somadorb1 port map(
   S=>S_SUM_16B(0),
   A=>NUM1_16B(0),
   B=>NUM2_16B(0),
   CIN=>CIN_SUM_16B,
   CS=>conect(0));
     
lsb1 : somadorb1 port map(
   S=>S_SUM_16B(1),
   A=>NUM1_16B(1),
   B=>NUM2_16B(1),
   CIN=>conect(0),
   CS=>conect(1));
 
lsb2 : somadorb1 port map(
   S=>S_SUM_16B(2),
   A=>NUM1_16B(2),
   B=>NUM2_16B(2),
   CIN=>conect(1),
   CS=>conect(2));

lsb3 : somadorb1 port map(
   S=>S_SUM_16B(3),
   A=>NUM1_16B(3),
   B=>NUM2_16B(3),
   CIN=>conect(2),
   CS=>conect(3));
    
lsb4 : somadorb1 port map(
   S=>S_SUM_16B(4),
   A=>NUM1_16B(4),
   B=>NUM2_16B(4),
   CIN=>conect(3),
   CS=>conect(4));

lsb5 : somadorb1 port map(
   S=>S_SUM_16B(5),
   A=>NUM1_16B(5),
   B=>NUM2_16B(5),
   CIN=>conect(4),
   CS=>conect(5));
  
lsb6 : somadorb1 port map(
   S=>S_SUM_16B(6),
   A=>NUM1_16B(6),
   B=>NUM2_16B(6),
   CIN=>conect(5),
   CS=>conect(6));

lsb7 : somadorb1 port map(
   S=>S_SUM_16B(7),
   A=>NUM1_16B(7),
   B=>NUM2_16B(7),
   CIN=>conect(6),
   CS=>conect(7));

lsb8 : somadorb1 port map(
   S=>S_SUM_16B(8),
   A=>NUM1_16B(8),
   B=>NUM2_16B(8),
   CIN=>conect(7),
   CS=>conect(8));

lsb9 : somadorb1 port map(
   S=>S_SUM_16B(9),
   A=>NUM1_16B(9),
   B=>NUM2_16B(9),
   CIN=>conect(8),
   CS=>conect(9));
       
lsb10 : somadorb1 port map(
   S=>S_SUM_16B(10),
   A=>NUM1_16B(10),
   B=>NUM2_16B(10),
   CIN=>conect(9),
   CS=>conect(10));
       
lsb11 : somadorb1 port map(
   S=>S_SUM_16B(11),
   A=>NUM1_16B(11),
   B=>NUM2_16B(11),
   CIN=>conect(10),
   CS=>conect(11));
       
lsb12 : somadorb1 port map(
   S=>S_SUM_16B(12),
   A=>NUM1_16B(12),
   B=>NUM2_16B(12),
   CIN=>conect(11),
   CS=>conect(12));

lsb13 : somadorb1 port map(
   S=>S_SUM_16B(13),
   A=>NUM1_16B(13),
   B=>NUM2_16B(13),
   CIN=>conect(12),
   CS=>conect(13));

lsb14 : somadorb1 port map(
   S=>S_SUM_16B(14),
   A=>NUM1_16B(14),
   B=>NUM2_16B(14),
   CIN=>conect(13),
   CS=>conect(14));

HSB : somadorb1 port map(
   S=>S_SUM_16B(15),
   A=>NUM1_16B(15),
   B=>NUM2_16B(15),
   CIN=>conect(14),
   CS=>COUT_SUM_16B);       
       
  
end encapss4;
 

