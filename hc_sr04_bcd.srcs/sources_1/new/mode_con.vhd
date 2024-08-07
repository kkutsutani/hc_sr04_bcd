library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mode_con is
    Port ( CLK    : in  STD_LOGIC;
           RST    : in  STD_LOGIC;
           SW     : in  STD_LOGIC;
           Data3  : in  STD_LOGIC_VECTOR(3 downto 0);
           Data2  : in  STD_LOGIC_VECTOR(3 downto 0);
           Data1  : in  STD_LOGIC_VECTOR(3 downto 0);
           Data0  : in  STD_LOGIC_VECTOR(3 downto 0);
           LMODE  : out STD_LOGIC_VECTOR(1 downto 0);
           RSTC   : out STD_LOGIC;
           TRIG   : out STD_LOGIC;
           DIV_EN : out STD_LOGIC );
end mode_con;

architecture RTL of mode_con is
    type mode_state is ( M_DISP, M_TRIG, M_MEAS );
    signal state : mode_state := M_DISP;
    signal led_mode : std_logic_vector(1 downto 0) := "00";

    constant cnt_t_max : integer := 1000;   -- 10[us]
    signal cnt_t : integer range 0 to cnt_t_max;

    constant cnt_w_max : integer := 10000000;    -- 100[ms]
    signal cnt_w : integer range 0 to cnt_w_max;

begin
    process(CLK, RST)
    begin
        if(RST = '1') then
            RSTC <= RST;
            state <= M_DISP;
            led_mode <= "00";   -- レジスタ値表示
        elsif(rising_edge(CLK)) then
            case state is

                when M_DISP =>
                    if(SW = '1') then
                        cnt_t <= cnt_t_max;
                        state <= M_TRIG;
                        RSTC <= '1';
                        led_mode <= "00";       -- レジスタ値表示
                    end if;

                when M_TRIG =>
                    if( cnt_t = 0 ) then
                        cnt_w <= cnt_w_max;
                        state <= M_MEAS;
                    else
                        RSTC <= '0';
                        cnt_t <= cnt_t - 1;
                    end if;

                when M_MEAS =>
                    if( cnt_w = 0 ) then
                        state <= M_DISP;
                        -- エラー判定
                        if( (Data3 & Data2 & Data1 & Data0) < X"0002" ) then
                            led_mode <= "10";   -- Err表示
                        else
                            led_mode <= "00";   -- レジスタ値表示
                        end if;
                    else
                        led_mode <= "01";       -- 計測中表示
                        cnt_w <= cnt_w - 1;
                    end if;

                when others =>
                    state <= M_DISP;

            end case;
        end if;
    end process;


    TRIG <= '1' when (state = M_TRIG) else '0';
    
    DIV_EN <= '0' when state = M_TRIG else
              '1' when state = M_MEAS else
              '0' when state = M_DISP else
              'X';

    LMODE <= led_mode;

end RTL;
