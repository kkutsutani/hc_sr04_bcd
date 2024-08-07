library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dynamic is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           Data0 : in STD_LOGIC_VECTOR (3 downto 0);
           Data1 : in STD_LOGIC_VECTOR (3 downto 0);
           Data2 : in STD_LOGIC_VECTOR (3 downto 0);
           Data3 : in STD_LOGIC_VECTOR (3 downto 0);
           LMODE  : in STD_LOGIC_VECTOR(1 downto 0);
           Data : out STD_LOGIC_VECTOR (3 downto 0);
           Tr : out STD_LOGIC_VECTOR (3 downto 0));
end dynamic;

architecture RTL of dynamic is
    signal cnt : std_logic_vector(7 downto 0);
    signal dig : std_logic_vector(2 downto 0);

begin
    process(CLK, RST)
    begin
        if(RST = '1') then
            cnt <= (others => '0');
        elsif(rising_edge(CLK)) then
            cnt <= cnt +1;
        end if;
    end process;

    dig <= cnt(7 downto 5);

    process(dig, data0, data1, data2, data3)
    begin
        case dig is
            when "000" =>
                if(LMODE = "00") then       -- レジスタ値表示モード
                    Data <= Data0;
                elsif(LMODE = "01") then    -- 計測中表示モード
                    Data <= "1010";
                elsif(LMODE = "10") then    -- Err表示モード
                    Data <= "1100";
                end if;
                Tr <= "1110";
            when "010" =>
                if(LMODE = "00") then       -- レジスタ値表示モード
                    Data <= Data1;
                elsif(LMODE = "01") then    -- 計測中表示モード
                    Data <= "1010";
                elsif(LMODE = "10") then    -- Err表示モード
                    Data <= "1100";
                end if;
                Tr <= "1101";
            when "100" =>
                if(LMODE = "00") then       -- レジスタ値表示モード
                    Data <= Data2;
                elsif(LMODE = "01") then    -- 計測中表示モード
                    Data <= "1010";
                elsif(LMODE = "10") then    -- Err表示モード
                    Data <= "1011";
                end if;
                Tr <= "1011";
            when "110" =>
                if(LMODE = "00") then       -- レジスタ値表示モード
                    Data <= Data3;
                elsif(LMODE = "01") then    -- 計測中表示モード
                    Data <= "1010";
                elsif(LMODE = "10") then    -- Err表示モード
                    Data <= "1101";
                end if;
                Tr <= "0111";
            when others =>
                Data <= "1111";
                Tr <= "1111";
        end case;
    end process;

end RTL;
