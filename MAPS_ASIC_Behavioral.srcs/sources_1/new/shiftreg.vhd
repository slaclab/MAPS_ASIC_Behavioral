library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shiftreg is
    generic (
        WIDTH       : positive := 24;
        SELECT_BITS : positive := 5
    );
    Port (
        input  : in std_logic;
        clk    : in std_logic;
        rst    : in std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0)
    );
end shiftreg;

architecture Behavioral of shiftreg is
    shared variable count : integer range 0 to 2**SELECT_BITS - 1;
begin

inj_en_proc : process(clk)
begin
    if rst = '0' then
        output <= (others => '1');
        count := 0;
    elsif rising_edge(clk) then
        output(count)<= input;-- after 1ns;
        count := count+1;
        if count = WIDTH then
            count := 0;
        end if;
    end if;
end process inj_en_proc;
end Behavioral;
