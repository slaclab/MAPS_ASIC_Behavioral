library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pix_test is
end pix_test;

architecture Behavioral of pix_test is

component pixel is
    port (
        inj       : in std_logic;
        inj_en    : in std_logic;
        latchRST  : in std_logic;
        pixelOut  : out std_logic
    );
end component pixel;

signal inj_test : std_logic := '0';
signal inj_en_test : std_logic := '0';
signal latchRST_test : std_logic := '0';
signal pixelOut_test : std_logic;
begin
uut: pixel
    port map(
        inj => inj_test,
        inj_en => inj_en_test,
        latchRST => latchRST_test,
        pixelOut => pixelOut_test
    );
    
reset_proc: process
begin
    latchRST_test <= '0';
    wait for 1ns;
    latchRst_test <= '1';
    wait for 1ns;
    latchRst_test <= '0';
    wait;
end process reset_proc;

clk_process : process
begin
    for i in 0 to 100 loop
        inj_test <= '0';
        wait for 5ns;
        inj_test <= '1';
        wait for 5ns;
    end loop;
wait;
end process clk_process;

stim_proc : process
begin
    inj_en_test <= '0';
    wait for 20 ns;
    inj_en_test <= '1';
    wait for 40 ns;
    inj_en_test <= '0';
    wait;
end process stim_proc;
end Behavioral;
