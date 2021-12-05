LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity DecoderProduto is
    port(   pannel_product: in std_logic_vector(0 to 19);
            product_qt, product_price: out std_logic_vector(7 downto 0));
end DecoderProduto;

architecture bhv of DecoderProduto is

begin

    PRC00: process(pannel_product)
    begin
        if(pannel_product="10000000000000000000") then
            product_qt<="00000000";
            product_price<="00010100";
        elsif(pannel_product="01000000000000000000") then
            product_qt<="00000001";
            product_price<="00010101";
        elsif(pannel_product="00100000000000000000") then
            product_qt<="00000010";
            product_price<="00010110";
        elsif(pannel_product="00010000000000000000") then
            product_qt<="00000011";
            product_price<="00010111";
        elsif(pannel_product="00001000000000000000") then
            product_qt<="00000100";
            product_price<="00011000";
        elsif(pannel_product="00000100000000000000") then
            product_qt<="00000101";
            product_price<="00011001";
        elsif(pannel_product="00000010000000000000") then
            product_qt<="00000110";
            product_price<="00011010";
        elsif(pannel_product="00000001000000000000") then
            product_qt<="00000111";
            product_price<="00011011";
        elsif(pannel_product="00000000100000000000") then
            product_qt<="00001000";
            product_price<="00011100";
        elsif(pannel_product="00000000010000000000") then
            product_qt<="00001001";
            product_price<="00011101";
        elsif(pannel_product="00000000001000000000") then
            product_qt<="00001010";
            product_price<="00011110";
        elsif(pannel_product="00000000000100000000") then
            product_qt<="00001011";
            product_price<="00011111";
        elsif(pannel_product="00000000000010000000") then
            product_qt<="00001100";
            product_price<="00100000";
        elsif(pannel_product="00000000000001000000") then
            product_qt<="00001101";
            product_price<="00100001";
        elsif(pannel_product="00000000000000100000") then
            product_qt<="00001110";
            product_price<="00100010";
        elsif(pannel_product="00000000000000010000") then
            product_qt<="00001111";
            product_price<="00100011";
        elsif(pannel_product="00000000000000001000") then
            product_qt<="00010000";
            product_price<="00100100";
        elsif(pannel_product="00000000000000000100") then
            product_qt<="00010001";
            product_price<="00100101";
        elsif(pannel_product="00000000000000000010") then
            product_qt<="00010010";
            product_price<="00100110";
        elsif(pannel_product="00000000000000000001") then
            product_qt<="00010011";
            product_price<="00100111";
        else 
            product_qt<="11111111";
            product_price<="11111111";
        end if;
    end process PRC00;
end bhv;