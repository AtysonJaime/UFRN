entity MDE IS
  port (Cle,u,y,Clk: in bit;
        PE: out bit_vector(1 downto 0);
        Z: out bit);
end MDE;

architecture ckt of MDE is

component ffjk is
  port ( clk ,J ,K ,P ,C : IN BIT;
          q : OUT BIT );
end component ;

signal JK1_in, JK0_in, JK1_out, JK0_out: bit;

begin  
  JK0_in <= not u;
  JK1_in <= ((not u) AND (JK0_out XNOR y));
  
  FFJK0: ffjk port map(
    clk => Clk,
    J => JK0_in,
    K => JK0_in,
    P => '1',
    C => Cle,
    q => JK0_out);
  
  FFJK1: ffjk port map(
    clk => Clk,
    J => JK1_in,
    K => JK1_in,
    P => '1',
    C => Cle,
    q => JK1_out);
  
  PE(0) <= JK0_out;  
  PE(1) <= JK1_out;
  Z <= u;  
end ckt;