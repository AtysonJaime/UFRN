library ieee;
use ieee.std_logic_1164 .all;

entity blocoDeControleFIFO is
	port (clk_ff , rst_ff, rd_ff, wr_ff: in std_logic;
			equal_cont_wd_e_rd, equal_cont_wd_1_e_rd, equal_cont_wd_e_rd_1: in std_logic;
			led_vazio_ff, led_cheio_ff,load_wr,load_rd: out std_logic;
			saida_mv_fifo: out std_logic_vector(2 downto 0));
end blocoDeControleFIFO;

architecture ckt of blocoDeControleFIFO is
	type st is (start, p_leitura, escrita, p_escrita, leitura);
	signal estado : st;
	signal p_l,p_e: std_logic;
	begin
		process (clk_ff , rst_ff)
		begin
			if rst_ff = '1' then
				estado <= start ;
			elsif (clk_ff'event and clk_ff ='1') then
				case estado is
					when start =>
						estado <= p_leitura;
					when p_leitura =>
						if (equal_cont_wd_e_rd='0') and (rd_ff ='1') and (wr_ff ='0') then estado <= leitura;
						elsif (wr_ff='1') then estado <= escrita;
						else estado <= p_leitura; 
						end if;
					when escrita =>
						if equal_cont_wd_1_e_rd='1' then estado <= p_escrita;
						elsif (wr_ff='1') and (rd_ff='0') then estado <= escrita; 
						else estado <= p_escrita;
						end if;
					when p_escrita =>
						if (equal_cont_wd_e_rd='0') and (wr_ff ='1') and (rd_ff='0') then estado <= escrita;
						elsif (rd_ff='1') then estado <= leitura;
						else estado <= p_escrita; 
						end if;
					when leitura =>
						if equal_cont_wd_e_rd_1='1' then estado <= p_leitura;
						elsif (wr_ff='0') and (rd_ff='1') then estado <= leitura; 
						else estado <= p_leitura;
						end if;
				end case ;
			end if;
		end process;
		load_wr <= '1' when estado = escrita else '0';
		load_rd <= '1' when estado = leitura else '0';
		p_e <= '1' when estado = p_escrita else '0';
		p_l <= '1' when estado = p_leitura else '0';
		
		led_vazio_ff <= p_l and equal_cont_wd_e_rd;
		led_cheio_ff <= p_e and equal_cont_wd_e_rd;
		
		with estado select
			saida_mv_fifo <= "000" when start ,
			"001" when p_leitura,
			"010" when escrita,
			"011" when p_escrita,
			"100" when leitura;
end ckt ;