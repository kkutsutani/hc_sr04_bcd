library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hc_sr04_top is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SW : in STD_LOGIC;
           ECHO : in STD_LOGIC;
           TRIG : out STD_LOGIC;
           Tr : out STD_LOGIC_VECTOR (3 downto 0);
           SEG : out STD_LOGIC_VECTOR (7 downto 0));
end hc_sr04_top;

architecture RTL of hc_sr04_top is
    -- chat 
    component chat
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               SW : in STD_LOGIC;
               SW_o : out STD_LOGIC);
    end component;

    -- div_1cm 
    component div_1cm
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               EN : in STD_LOGIC;
               ECHO : in STD_LOGIC;
               CE : out STD_LOGIC);
    end component;

    -- mode_con 
    component mode_con
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
    end component;

    -- cnt10
    component cnt10
        Port ( CLK : in  STD_LOGIC;
               RST : in  STD_LOGIC;
               CE : in  STD_LOGIC;
               Data : out  STD_LOGIC_VECTOR (3 downto 0);
               CRR  : out  STD_LOGIC );
    end component;

    -- dynamic
    component dynamic
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Data0 : in STD_LOGIC_VECTOR (3 downto 0);
               Data1 : in STD_LOGIC_VECTOR (3 downto 0);
               Data2 : in STD_LOGIC_VECTOR (3 downto 0);
               Data3 : in STD_LOGIC_VECTOR (3 downto 0);
               LMODE  : in STD_LOGIC_VECTOR(1 downto 0);
               Data : out STD_LOGIC_VECTOR (3 downto 0);
               Tr : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- dec7
    component dec7
        Port ( Data : in  STD_LOGIC_VECTOR (3 downto 0);
               SEG : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- signal
    signal sw_w     : std_logic;
    signal div_en_w : std_logic;
    signal data0_w  : std_logic_vector (3 downto 0);
    signal data1_w  : std_logic_vector (3 downto 0);
    signal data2_w  : std_logic_vector (3 downto 0);
    signal data3_w  : std_logic_vector (3 downto 0);
    signal data_w   : std_logic_vector (3 downto 0);
    signal lmode_w  : std_logic_vector (1 downto 0);
    signal rstc_w   : std_logic;
    signal ce_w     : std_logic;
    signal crr0_w   : std_logic;
    signal crr1_w   : std_logic;
    signal crr2_w   : std_logic;

begin
    U1 : chat
        port map(CLK => CLK, RST => RST, SW => SW, SW_o => sw_w);

    U2 : div_1cm
        port map(CLK => CLK, RST => RST, EN => div_en_w, ECHO => ECHO, CE => ce_w);

    U3 : mode_con
        port map(CLK => CLK, RST => RST, SW => sw_w, Data3 => data3_w, Data2 => data2_w, Data1 => data1_w, Data0 => data0_w,
                    LMODE => lmode_w, RSTC => rstc_w, TRIG => TRIG, DIV_EN => div_en_w);

    U40 : cnt10
        port map(CLK => CLK, RST => rstc_w, CE => ce_w, Data => data0_w, CRR => crr0_w);
    U41 : cnt10
        port map(CLK => CLK, RST => rstc_w, CE => crr0_w, Data => data1_w, CRR => crr1_w);
    U42 : cnt10
        port map(CLK => CLK, RST => rstc_w, CE => crr1_w, Data => data2_w, CRR => crr2_w);
    U43 : cnt10
        port map(CLK => CLK, RST => rstc_w, CE => crr2_w, Data => data3_w, CRR => open);

    U5 : dynamic
        port map(CLK => CLK, RST => RST, Data0 => data0_w, Data1 => data1_w, Data2 => data2_w, Data3 => data3_w,
                    LMODE => lmode_w, Data => data_w, Tr => Tr);

    U6 : dec7
        port map(Data => data_w, SEG => SEG);

end RTL;
