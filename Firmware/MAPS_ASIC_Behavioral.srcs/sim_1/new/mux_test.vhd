library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_test is
end mux_test;

architecture Behavioral of mux_test is

        constant WIDTH       : positive := 24;
        constant SELECT_BITS : positive := 5;
        constant CLK_CYCLES  : positive := 4;
        
component mux is
    generic (
        WIDTH       : positive;
        SELECT_BITS : positive;
        CLK_CYCLES  : positive
    );
    port(
        input   : in std_logic_vector(WIDTH-1 downto 0);
        clk     : in std_logic;
        rst     : in std_logic;
        output  : out std_logic
        );
end component mux;

signal input_test  : std_logic_vector(WIDTH-1 downto 0);
signal clk_test    : std_logic;
signal rst_test    : std_logic;
signal output_test : std_logic;

begin
uut: mux
    generic map(
        WIDTH => WIDTH,
        SELECT_BITS => SELECT_BITS,
        CLK_CYCLES  => CLK_CYCLES
    )
    port map(
        input => input_test,
        clk   => clk_test,
        rst   => rst_test,
        output => output_test
    );

reset_proc : process
begin
    rst_test <= '0';
    wait for 1ns;
    rst_test <= '1';
    wait for 1ns;
    rst_test <= '0';
    wait;
end process reset_proc;

clk_proc : process
begin
    for i in 0 to 1000 loop
        clk_test <= '0';
        wait for 5ns;
        clk_test <= '1';
        wait for 5ns;
    end loop;
end process clk_proc;

stim_proc : process
begin
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= X"AAAAAA";
wait for 80 ns;
input_test <= (others =>'0');
wait for 40 ns;
input_test <= X"555555";
wait for 80 ns;
input_test <= (others =>'0');
wait;
end process stim_proc;
end Behavioral;
