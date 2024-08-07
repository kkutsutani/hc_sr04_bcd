library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_1cm is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           EN : in STD_LOGIC;
           ECHO : in STD_LOGIC;
           CE : out STD_LOGIC);
end div_1cm;

architecture RTL of div_1cm is
    constant cnt_max : integer := 5800;
    signal cnt : integer range 0 to cnt_max;

begin
    process(CLK, RST)
    begin
        if(RST = '1') then
            cnt <= 0;
        elsif(rising_edge(CLK)) then
            if(EN = '1' and ECHO = '1') then

                if(cnt = cnt_max -1) then
                    cnt <= 0;
                else
                    cnt <= cnt + 1;
                end if;

            else
                cnt <= 0;   -- 必ず カウント開始は 0から
            end if;
        end if;
    end process;

    CE <= '1' when cnt = cnt_max - 1 else '0';

end RTL;
