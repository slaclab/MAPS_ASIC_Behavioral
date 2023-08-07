library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pixel is
    port (
        inj       : in std_logic;
        inj_en    : in std_logic;
        rstCSA    : in std_logic;
        latchRST  : in std_logic;
        pixelOut  : out std_logic
    );
end pixel;
          
architecture Behavioral of pixel is
begin
    pixel_proc: process(inj,latchRST,rstCSA)
    begin
        if latchRST = '1' then
            pixelOut <= '1'; -- after 1ns;
        elsif rising_edge(inj) then
            pixelOut <= inj_en; --after 1ns;
        end if;
    end process pixel_proc;
end Behavioral;             