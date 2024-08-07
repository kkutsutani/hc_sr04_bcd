library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chat is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SW : in STD_LOGIC;
           SW_o : out STD_LOGIC);
end chat;

architecture RTL of chat is
    constant cnt_max : integer := 50000; -- 500[us]
    signal cnt : integer range 0 to cnt_max;
begin
    process(CLK, RST)
    begin
        if(RST = '1') then
            cnt <= 0;
        elsif(rising_edge(CLK)) then
            if(SW = '1') then
                if(cnt < cnt_max)then
                    cnt <= cnt + 1;
                end if;
            else
                cnt <= 0;
            end if;
        end if;
    end process;

    SW_o <= '1' when cnt = cnt_max - 1 else '0';
end RTL;
