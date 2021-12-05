ENTITY CircuitoCompleto IS
  port (Au, Ad: in bit_vector(3 downto 0);
        clk, Cle, UpDown, LD: in bit;
        Cu, Cd: out bit_vector(3 downto 0));
end CircuitoCompleto;

architecture ckt of CircuitoCompleto is
  
component ContadorUpDown_4bits IS
  port (A_in: in bit_vector(3 downto 0);
        clk_ud, UD: in bit;
        c_ud: in bit_vector(1 downto 0);
        S: out bit_vector(3 downto 0));
end component;
signal ClearU_1, ClearU_2, ClearD_1, ClearD_2, CLK_2, resultLD_1: bit;
signal saida_1, saida_2, CPU, CPD: bit_vector(3 downto 0);
begin 
    
    ClearU_1 <= (NOT (UpDown AND saida_1(3) AND (NOT saida_1(2)) AND saida_1(1) AND (NOT saida_1(0)))) AND Cle;
    ClearU_2 <= (NOT ((NOT UpDown) AND saida_1(3) AND  saida_1(2) AND saida_1(1) AND saida_1(0))) AND Cle;
    CPU(0) <= Au(0) NAND LD; 
    CPU(1) <= Au(1) NAND LD;
    CPU(2) <= Au(2) NAND LD;
    CPU(3) <= Au(3) NAND LD;
    
    
    ContUni: ContadorUpDown_4bits port map(
      A_in => CPU,
      clk_ud => clk,
      c_ud(0) => ClearU_1,
      c_ud(1) => ClearU_2,
      UD => UpDown,
      S => saida_1);
      
    Cu <= saida_1;
    
    ClearD_1 <= (NOT (UpDown AND saida_2(3) AND (NOT saida_2(2)) AND saida_2(1) AND (NOT saida_2(0)))) AND Cle;
    ClearD_2 <= (NOT ((NOT UpDown) AND saida_2(3) AND  saida_2(2) AND saida_2(1) AND saida_2(0))) AND Cle;
    
    CLK_2 <= ((NOT ClearU_1) OR (NOT ClearU_2));
    
    CPD(0) <= Ad(0) NAND LD; 
    CPD(1) <= Ad(1) NAND LD;
    CPD(2) <= Ad(2) NAND LD;
    CPD(3) <= Ad(3) NAND LD;
    
    
    ContDeze: ContadorUpDown_4bits port map(
      A_in => CPD,
      clk_ud => CLK_2,
      c_ud(0) => ClearD_1,
      c_ud(1) => ClearD_2,
      UD => UpDown,
      S => saida_2);
      
    Cd <= saida_2;
end ckt;