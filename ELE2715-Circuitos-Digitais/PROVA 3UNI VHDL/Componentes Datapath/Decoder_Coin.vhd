LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity DecoderCoin is
    port(   Coin: in std_logic_vector(7 downto 0);
            Coin_address: out std_logic_vector(7 downto 0));
end DecoderCoin;

architecture bhv of DecoderCoin is
begin
    PRC00: process(Coin)
    begin
        if(Coin="00000101") then Coin_address<="00101100"; --5 returns 44
        elsif(Coin="00001010") then Coin_address<="00101011"; --10 returns 43
        elsif(Coin="00011001") then Coin_address<="00101010"; --25 returns 42
        elsif(Coin="00110010") then Coin_address<="00101001"; --50 returns 41
        elsif(Coin="01100100") then Coin_address<="00101000"; --100 returns 40
        else Coin_address<="11111111";
        end if;
    end process PRC00;
end bhv;
