library ieee; 
use ieee.std_logic_1164.all;

entity MaqVenda is 
    port(clk,comp_gt,r,comp_lt,cancel,moeda:in std_logic;
         produto: in std_logic_vector(0 to 19);
         hex_a: out std_logic_vector(7 downto 0);
         hex_b: out std_logic_vector(15 downto 0));
         
end MaqVenda;

architecture ckt of MaqVenda is
    type state_type is (espera,A0,A1,B0,E0,B1,B2,B3,E2,B4,C0,C1_1,C1_2,C1_3,C1_4,C2_1,C2_2,C2_3,C2_4,C3_1,C3_2,C3_3,C3_4,C4_1,C4_2,C4_3,C4_4,C5_1,C5_2,C5_3,C5_4,D0); 
    signal y_present, y_next: state_type;
    signal timer_rst,rs_banco, clr_p_aux,ram_rw, acum_clr,s_cmp_timer,pont_en,pont_ld,ld_p_aux,acum_ld,comp_eq,en_banco,banco_ud, c_in: std_logic;
    signal  mx_comp_A, mx_comp_B, mx_adrs_ram, mx_data_ram, mx_sum_A, mx_sum_B,end_banco: std_logic_vector(3 downto 0);
    signal acum_out,s_p_aux,ram_data_out: std_logic_vector(15 downto 0);
begin
    process(produto,clk,comp_gt,y_present,moeda,comp_lt,s_cmp_timer,cancel,comp_eq) --CANCEL SERÁ ENTRADA DA MAQUINA OU SINAL?
    begin   
        case y_present is  
            when espera =>
                if produto /="00000000000000000000" then y_next <= A0;
                else                y_next <= espera; 
                end if;
            when A0 =>
                y_next <= A1;
            when A1 =>
                if comp_gt = '1' then y_next <= B0;
                else                  y_next <= E0;
                end if;
            when B0 =>
                y_next <= B1;
            when B1 =>
                y_next <= B2;
            when B2 => --REVER ESSE ESTADO DEVIDO SER MEALY
                if ((moeda = '0') and comp_lt ='1' and (s_cmp_timer = '0'))  then y_next <= B2; 
                elsif (s_cmp_timer = '1' or cancel = '1')                    then y_next <= E2; -- ERRO 2 QUAL A CODIFICAÇÃO?
                elsif(moeda = '1' and s_cmp_timer ='0')                      then y_next <= B3;
                elsif (moeda = '0' and comp_lt = '0'  and s_cmp_timer = '1') then y_next<= C0; 
                end if;  
            when B3 =>
                y_next <= B4; 
            when B4 =>
                y_next <= B2;
            when E0 =>  
                y_next <= E0;
            when E2 =>
                y_next <= E2;
            when C0 =>
                if(comp_eq = '0')                                              then y_next <= C1_1;
                else                                                                y_next <= D0;
                end if;
            when C1_1 => 
                if(comp_lt = '1')                                              then y_next <= C2_1;
                else                                                            y_next <= C1_2;
                end if;
            when C1_2 =>
                if(comp_gt = '1')                                              then y_next <= C1_3;
                else                                                            y_next <= C2_1;  
                end if;  
            when C1_3 =>
                y_next <= C1_4;
            when C1_4 =>
                y_next <= C1_1;
            when C2_1 =>
                if(comp_lt = '1')                                              then y_next <= C3_1;
                else                                                           y_next <= C2_2;
                end if;
            when C2_2 =>
                if(comp_gt = '1')                                              then y_next <= C2_3;
                else                                                            y_next <= C3_1;
                end if;
            when C2_3 =>
                y_next <= C2_4;
            when C2_4 =>
                y_next <= C2_1;


            when C3_1 =>
                if(comp_gt = '1')                                              then y_next <= C4_1;
                else                                                            y_next <= C3_2;
                end if;

            when C3_2 =>
                if(comp_gt = '1')                                              then y_next <= C3_3;
                else                                                            y_next <= C4_1;
                end if;

            when C3_3 =>
                y_next <= C3_4;

            when C3_4 =>
                y_next <= C3_1;

            
            when C4_1 =>
                if(comp_gt = '1')                                              then y_next <= C5_1;
                else                                                            y_next <= C4_2;
                end if;

            when C4_2 =>
                if(comp_gt = '1')                                              then y_next <= C4_3;
                else                                                            y_next <= C5_1;
                end if;

            when C4_3 =>
                y_next <= C4_4;

            when C4_4 =>
                y_next <= C4_1;


            
            when C5_1 =>
                if(comp_gt = '1')                                              then y_next <= D0;
                else                                                            y_next <= C5_2;
                end if;

            when C5_2 =>
                if(comp_gt = '1')                                              then y_next <= C5_3;
                else                                                            y_next <= D0;
                end if;

            when C5_3 =>
                y_next <= C5_4;

            when C5_4 =>
                y_next <= C5_1;

            when D0 =>
                y_next <= D0;
                
                

        end case;
    end process;

    process (clk,r) 
    begin 
        if r = '0' then 
           y_present <= espera; 
        elsif (clk'event and clk = '1') then 
            y_present <= y_next; 
        end if; 
    end process;

    process (y_present)
    begin
        if (y_present = espera) then  
            timer_rst <= '0';     
            pont_ld <= '0';
            rs_banco <= '0';
            clr_p_aux <= '0';
            hex_a <= "00000000";

        elsif (y_present = A0) then
            mx_adrs_ram <= "0000";
            ram_rw <= '0';
            hex_a <= "10100000";
            hex_b <= "0000000000000000";

        elsif (y_present = A1) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "10100000";
            hex_b <= "0000000000000000";
            timer_rst <= '0';
        
        elsif (y_present = B1) then
            mx_adrs_ram <= "0001";
            ram_rw <= '0';
            hex_a <= "10110000";
            hex_b <= "0000000000000000";
        
        elsif (y_present = B2) then
            ld_p_aux <= '0';
            timer_rst <= '0';
            acum_clr <= '0';
            hex_a <= "10110010";
            hex_b <= "0000000000000000";
            if(acum_out = "0000000000000000") then 
                hex_b <=s_p_aux;
            else 
                hex_b <= acum_out;
            end if; 
        
       

        elsif (y_present = B3) then
            mx_adrs_ram <= "0010";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "0000";
            ram_rw <= '1';
            timer_rst <= '0';
            hex_a <= "10110011";
            hex_b <= acum_out;
        
        elsif (y_present  = B4) then
            mx_adrs_ram <= "0011";
            mx_data_ram <= "0001";
            ram_rw <= '1';
            mx_sum_A <= "0001";
            mx_sum_B <= "0001";
            acum_ld <= '0';
            pont_en <= '0';
            hex_a <= "10110100";
            hex_b <= acum_out;

        elsif (y_present = C0) then
            mx_comp_A <= "0001";
            mx_comp_B <= "0001";
            mx_sum_A <= "0001";
            mx_sum_B <= "0010";
            acum_ld <= '0';
            c_in <= '1';
            hex_a <= "11000000";
            hex_b <= acum_out;

        elsif (y_present = C1_1) then 
            mx_comp_A <= "0001";
            mx_comp_B <= "0010";
            mx_adrs_ram <= "0100";
            ram_rw <= '0';
            hex_a <="11000001";
        
        elsif (y_present = C1_2) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "11000001";
        
        elsif (y_present = C1_3) then
            mx_sum_A <= "0001";
            mx_sum_B <= "0011";
            acum_ld <= '0';
            end_banco <= "0000";
            en_banco <= '0';
            banco_ud <= '0';
            mx_adrs_ram <= "0100";
            ram_rw <= '0';
            hex_a <= "11000001"; 
        
        elsif (y_present = C1_4) then
            mx_adrs_ram <= "0100";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "1000";
            ram_rw <= '1';
            hex_a <= "11000001";
        
        elsif (y_present = C2_1) then
            mx_comp_A <= "0001";
            mx_comp_B <= "0011";
            mx_adrs_ram <= "0101";
            ram_rw <= '0';
            hex_a <="11000010";

        elsif (y_present = C2_2) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "11000010";
        
        elsif (y_present = C2_3) then
            mx_sum_A <= "0001";
            mx_sum_B <= "0100";
            acum_ld <= '0';
            end_banco <= "0001";
            en_banco <= '0';
            banco_ud <= '0';
            mx_adrs_ram <= "0101";
            ram_rw <= '0';
            hex_a <= "11000010"; 

        elsif (y_present = C2_4) then
            mx_adrs_ram <= "0101";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "1000";
            ram_rw <= '1';
            hex_a <= "11000010";



        elsif (y_present = C3_1) then
            mx_comp_A <= "0001";
            mx_comp_B <= "0100";
            mx_adrs_ram <= "0100";
            ram_rw <= '0';
            hex_a <="11000010";

        elsif (y_present = C3_2) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "11000010";
        
        elsif (y_present = C3_3) then
            mx_sum_A <= "0001";
            mx_sum_B <= "0101";
            acum_ld <= '0';
            end_banco <= "0010";
            en_banco <= '0';
            banco_ud <= '0';
            mx_adrs_ram <= "0110";
            ram_rw <= '0';
            hex_a <= "11000010"; 

        elsif (y_present = C3_4) then
            mx_adrs_ram <= "0110";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "1000";
            ram_rw <= '1';
            hex_a <= "11000010";



        elsif (y_present = C4_1) then
            mx_comp_A <= "0001";
            mx_comp_B <= "0101";
            mx_adrs_ram <= "0101";
            ram_rw <= '0';
            hex_a <="11000010";

        elsif (y_present = C4_2) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "11000010";
        
        elsif (y_present = C4_3) then
            mx_sum_A <= "0001";
            mx_sum_B <= "0110";
            acum_ld <= '0';
            end_banco <= "0011";
            en_banco <= '0';
            banco_ud <= '0';
            mx_adrs_ram <= "0111";
            ram_rw <= '0';
            hex_a <= "11000010"; 

        elsif (y_present = C4_4) then
            mx_adrs_ram <= "0111";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "1000";
            ram_rw <= '1';
            hex_a <= "11000010";



        elsif (y_present = C5_1) then
            mx_comp_A <= "0001";
            mx_comp_B <= "0110";
            mx_adrs_ram <= "0101";
            ram_rw <= '0';
            hex_a <="11000010";

        elsif (y_present = C5_2) then
            mx_comp_A <= "0000";
            mx_comp_B <= "0000";
            hex_a <= "11000010";
        
        elsif (y_present = C5_3) then
            mx_sum_A <= "0001";
            mx_sum_B <= "0111";
            acum_ld <= '0';
            end_banco <= "0100";
            en_banco <= '0';
            banco_ud <= '0';
            mx_adrs_ram <= "1000";
            ram_rw <= '0';
            hex_a <= "11000010"; 

        elsif (y_present = C5_4) then
            mx_adrs_ram <= "1000";
            mx_data_ram <= "0000";
            mx_sum_A <= "0000";
            mx_sum_B <= "1000";
            ram_rw <= '1';
            hex_a <= "11000010";


        end if;
    end process;
end ckt;   
                                     
        
          




