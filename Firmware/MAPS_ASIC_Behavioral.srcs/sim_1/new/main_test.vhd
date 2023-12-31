library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity main_test is
end main_test;

architecture Behavioral of main_test is
    component main
    generic(
        ROWS_G     : positive := 24;
        COLS_G     : positive := 24;
        BITS_G     : positive := 5 -- 2^BITS_C needs to be greater than ROWS_C or COLS_C
    );
    port(        
        InjRst_n   : in std_logic;
           
        SelCk      : in std_logic;
        
        selRst_n   : in std_logic;
        InjClk     : in std_logic;     
        InjDis     : in std_logic;
        Inj        : in std_logic;
        
        bline_n    : in std_logic;
        latchRST   : in std_logic;
        rst        : in std_logic;
        
        PixOut     : out std_logic   
        );        
    end component main;
    
    signal SelCk_test    : std_logic := '0';
    signal InjClk_test   : std_logic := '0';
    signal InjDis_test   : std_logic := '0';
    signal inj_test      : std_logic := '1';
    signal InjRST_n_test : std_logic := '0';
    signal rst_test      : std_logic := '0';
    signal bline_n_test  : std_logic := '0';
    signal latchrst_test : std_logic := '1';
    signal selrst_n_test : std_logic := '0';
    signal PixOut_test   : std_logic := '0';
    
    file output_buf      : text;
    constant num_pixels  : integer := 576;
    constant num_frames  : integer := 1; 
    signal clk_count     : integer := 0;
    
begin
    
    uut: main 
--        generic map (
--        ROWS_G => ROWS_G,
--        COLS_G => COLS_G,
--        BITS_G => BITS_G
--        )
        port map (
        selCk    => selCk_test,
        injclk   => injclk_test,
        injdis   => injdis_test,
        inj      => inj_test,
        rst      => rst_test,
        bline_n  => bline_n_test,
        selRst_n => selRst_n_test,
        latchrst => latchrst_test,
        InjRST_n => InjRST_n_test,
        PixOut   => PixOut_test
    );
 
 
 reset : process
    begin
    injrst_n_test <= '1';
    selRst_n_test <= '1';
    wait for 1ns;    
    injrst_n_test <= '0';
    selRst_n_test <= '0';
    wait for 1ns;
    injrst_n_test <= '1';
    selRst_n_test <= '1';
wait;           
end process reset;

latchRst_proc : process
begin
    latchRst_test <= '0';
    wait for 50ns;
    latchRst_test <= '1';
    wait for 4ns;
    latchRst_test <= '0';
    wait;
end process latchRst_proc;

bline_n_proc : process
begin
    bline_n_test <= '0';
    wait for 53.5ns;
    bline_n_test <= '1';
    wait;
end process bline_n_proc;

rstCSA_proc : process
begin
    rst_test <= '0';
    wait for 50ns;
    rst_test <= '1';
    wait for 3ns;
    rst_test <= '0';
    wait;
end process rstCSA_proc;

    clk : process
    begin
    wait for 2ns;
        for i in 0 to 23 loop
            InjClk_test <= '1'; 
            wait for 1 ns;
            InjClk_test <= '0'; 
            wait for 1 ns;
        end loop;        
        wait;
    end process clk;
    
    injdata : process
    begin
    wait for 2 ns;
            for i in 0 to 23 loop
                injdis_test <= '0';
                wait for 2 ns;
                injdis_test <= '1';
                wait for 2 ns;
            end loop;
        wait;
    end process injdata;

    injection : process
    begin
        inj_test <= '0';
        wait for 56 ns;
        inj_test <= '1';
        wait;
    end process injection;
    
    selck : process
    begin
        wait for 60 ns;
            for i in 0 to (num_pixels*num_frames-1) loop
                selCk_test <= '1'; 
                wait for 1 ns;
                selCk_test <= '0'; 
                wait for 1 ns;
                    if (clk_count = (num_pixels*num_frames-1)) then
                        file_close(output_buf);
                        wait;
                    else
                        clk_count <= clk_count + 1;
                    end if;
            end loop;
        wait; 
    end process selck;
    
    file_open(output_buf, "C:\Users\ahmcg\MAPS_ASIC_Behavioral\Software\pixOut.txt", write_mode);
    pixWrite : process(selck_test)
    variable write_col_to_output_buf : line;
    begin
    if rising_edge(selCk_test) then
        write(write_col_to_output_buf, pixOut_test);
        writeline(output_buf, write_col_to_output_buf);
    end if;
    end process pixWrite;       
end Behavioral;