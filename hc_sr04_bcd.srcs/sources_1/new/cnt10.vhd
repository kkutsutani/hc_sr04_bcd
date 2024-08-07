library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt10 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (3 downto 0);
           CRR  : out  STD_LOGIC );
end cnt10;

architecture RTL of cnt10 is
    signal q : std_logic_vector(3 downto 0);
begin
    process(CLK, RST)
    begin
        if(RST = '1')then
            q <= (others => '0');           -- reset
        elsif(rising_edge(CLK))then
            if(CE = '1')then
                if(q = 9)then               -- 9 cnt
                    q <= (others => '0');   -- reset
                else
                    q <= q + 1;
                end if;
            end if;
        end if;
    end process;

    Data <= q;
    CRR <= CE when q = 9 else '0';

end RTL;

