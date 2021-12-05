    library ieee;
    use ieee.std_logic_1164.all;

    entity contador16 is
    port(A: in std_logic_vector(15 downto 0);
        bUD,Clr,load,en,Clock: in std_logic; 
        S: out std_logic_vector(15 downto 0)
            
        );
    end contador16;  -- 0 crescente , 1 decrescente.

    architecture funcionamento of contador16 is

    component JK is
        port (clk,J,K,P,C: IN std_logic;
            q: OUT std_logic
                    
        ); 
    end component; 

        signal inJK, logicPres,logicClr,outJK: std_logic_vector (15 downto 0);
        signal up,down: std_logic_vector(15 downto 0);   
    

    begin       

        
        logicPres(15)<=load nand A(15);
        logicPres(14)<=load nand A(14);
        logicPres(13)<=load nand A(13);
        logicPres(12)<=load nand A(12);
        logicPres(11)<=load nand A(11);
        logicPres(10)<=load nand A(10);
        logicPres(9)<=load nand A(9);
        logicPres(8)<=load nand A(8);
        logicPres(7)<=load nand A(7);
        logicPres(6)<=load nand A(6);
        logicPres(5)<=load nand A(5);
        logicPres(4)<=load nand A(4);
        logicPres(3)<=load nand A(3);
        logicPres(2)<=load nand A(2);
        logicPres(1)<=load nand A(1);
        logicPres(0)<=load nand A(0);


        inJK(0)<=en;

        up(1)<=outJK(0) and not bUD;
        down(1)<=not outJK(0) and bUD;

        inJK(1)<=en and (up(1) or down(1));

        up(2)<=outJK(1) and up(1);
        down(2)<=not outJK(1) and down(1);

        inJK(2)<=en and (up(2) or down(2));

        up(3)<=outJK(2) and up(2);
        down(3)<=not outJK(2) and down(2);

        inJK(3)<=en and (up(3) or down(3));

        up(4)<=outJK(3) and up(3);
        down(4)<=not outJK(3) and down(3);

        inJK(4)<=en and (up(4) or down(4));

        up(5)<=outJK(4) and up(4);
        down(5)<=not outJK(4) and down(4);

        inJK(5)<=en and (up(5) or down(5));

        up(6)<=outJK(5) and up(5);
        down(6)<=not outJK(5) and down(5);

        inJK(6)<=en and (up(6) or down(6));

        up(7)<=outJK(6) and up(6);
        down(7)<=not outJK(6) and down(6);

        inJK(7)<=en and (up(7) or down(7));

        up(8)<=outJK(7) and up(7);
        down(8)<=not outJK(7) and down(7);

        inJK(8)<=en and (up(8) or down(8));

        up(9)<=outJK(8) and up(8);
        down(9)<=not outJK(8) and down(8);

        inJK(9)<=en and (up(9) or down(9));

        up(10)<=outJK(9) and up(9);
        down(10)<=not outJK(9) and down(9);

        inJK(10)<=en and (up(10) or down(10));

        up(11)<=outJK(10) and up(10);
        down(11)<=not outJK(10) and down(10);

        inJK(11)<=en and (up(11) or down(11));

        up(12)<=outJK(11) and up(11);
        down(12)<=not outJK(11) and down(11);

        inJK(12)<=en and (up(12) or down(12));

        up(13)<=outJK(12) and up(12);
        down(13)<=not outJK(12) and down(12);

        inJK(13)<=en and (up(13) or down(13));

        
        up(14)<=outJK(13) and up(13);
        down(14)<=not outJK(13) and down(13);

        inJK(14)<=en and (up(14) or down(14));

        up(15)<=outJK(14) and up(14);
        down(15)<=not outJK(14) and down(14);

        inJK(15)<=en and (up(15) or down(15));

    

    JK15: JK port map (
            clk => Clock,
            J=> inJK(15),
            K => inJK(15),
            P => logicPres(15),
            C=> Clr,
            q => outJK(15)
            
        );

    JK14: JK port map (
            clk => Clock,
            J=> inJK(14),
            K => inJK(14),
            P => logicPres(14),
            C=> Clr,
            q => outJK(14)
            
        );
    
    JK13: JK port map (
            clk => Clock,
            J=> inJK(13),
            K => inJK(13),
            P => logicPres(13),
            C=> Clr,
            q => outJK(13)
            
        );

    JK12: JK port map (
            clk => Clock,
            J=> inJK(12),
            K => inJK(12),
            P => logicPres(12),
            C=> Clr,
            q => outJK(12)
            
        );

    JK11: JK port map (
            clk => Clock,
            J=> inJK(11),
            K => inJK(11),
            P => logicPres(11),
            C=> Clr,
            q => outJK(11)
            
        );

    JK10: JK port map (
            clk => Clock,
            J=> inJK(10),
            K => inJK(10),
            P => logicPres(10),
            C=> Clr,
            q => outJK(10)
            
        );
    
    JK9: JK port map (
            clk => Clock,
            J=> inJK(9),
            K => inJK(9),
            P => logicPres(9),
            C=> Clr,
            q => outJK(9)
            
        );
    
    JK8: JK port map (
            clk => Clock,
            J=> inJK(8),
            K => inJK(8),
            P => logicPres(8),
            C=> Clr,
            q => outJK(8)
            
        );
    
    JK7: JK port map (
            clk => Clock,
            J=> inJK(7),
            K => inJK(7),
            P => logicPres(7),
            C=> Clr,
            q => outJK(7)
            
        );

    JK6: JK port map (
            clk => Clock,
            J=> inJK(6),
            K => inJK(6),
            P => logicPres(6),
            C=> Clr,
            q => outJK(6)
            
        );

    JK5: JK port map (
            clk => Clock,
            J=> inJK(5),
            K => inJK(5),
            P => logicPres(5),
            C=> Clr,
            q => outJK(5)
            
        );

        JK4: JK port map (
            clk => Clock,
            J=> inJK(4),
            K => inJK(4),
            P => logicPres(4),
            C=> Clr,
            q => outJK(4)
            
        );

        JK3: JK port map (
            clk => Clock,
            J=> inJK(3),
            K => inJK(3),
            P => logicPres(3),
            C=> Clr,
            q => outJK(3)
            
        );

        JK2: JK port map (
            clk => Clock,
            J=> inJK(2),
            K => inJK(2),
            P => logicPres(2),
            C=> Clr,
            q => outJK(2)
            
        );

        JK1: JK port map (
            clk => Clock,
            J=> inJK(1),
            K => inJK(1),
            P => logicPres(1),
            C=> Clr,
            q => outJK(1)
            
        );

        JK0: JK port map (
            clk => Clock,
            J=> inJK(0),
            K => inJK(0),
            P => logicPres(0),
            C=> Clr,
            q => outJK(0)
            
        );
            
        S <= outJK;

    end funcionamento;


