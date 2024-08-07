library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec7 is
    Port ( Data : in  STD_LOGIC_VECTOR (3 downto 0);
           SEG : out  STD_LOGIC_VECTOR (7 downto 0));
end dec7;

architecture RTL of dec7 is

begin
    SEG <= "11000000" when Data = "0000" else   --0
           "11111001" when Data = "0001" else   --1
           "10100100" when Data = "0010" else   --2
           "10110000" when Data = "0011" else   --3
           "10011001" when Data = "0100" else   --4
           "10010010" when Data = "0101" else   --5
           "10000010" when Data = "0110" else   --6
           "11111000" when Data = "0111" else   --7
           "10000000" when Data = "1000" else   --8
           "10011000" when Data = "1001" else   --9
           "10111111" when Data = "1010" else   --10 -
           "10000110" when Data = "1011" else   --11 E
           "10101111" when Data = "1100" else   --12 r
           "11111111";

end RTL;

