library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_test is
end main_test;

architecture Behavioral of main_test is
    component main
    port(
        --thr      : in std_logic_vector(2 downto 0);  (Not implemented yet)
        
        InjRst_n   : in std_logic;  --disable injection in all, through main 
           
        SelCk      : in std_logic;  --push row wise
        
        selRst_n   : in std_logic;  --set to 0,0; reset counter inside selck splitter
        InjClk     : in std_logic;  --combined with injdis in shiftreg      
        InjDis     : in std_logic;  --combined with injclk in shiftreg
        Inj        : in std_logic;  --inject in all enable columns
        
        bline_n    : in std_logic; --PixRST passthrough
        latchRST   : in std_logic; --PixRST passthrough
        rst        : in std_logic; --PixRST passthrough
        
        PixOut     : out std_logic -- Goal    
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
    
begin
    
    uut: main port map (
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
    wait for 10ns;
    latchRst_test <= '1';
    wait for 4ns;
    latchRst_test <= '0';
    wait;
end process latchRst_proc;

bline_n_proc : process
begin
    bline_n_test <= '0';
    wait for 13.5ns;
    bline_n_test <= '1';
    wait;
end process bline_n_proc;

rstCSA_proc : process
begin
    rst_test <= '0';
    wait for 10ns;
    rst_test <= '1';
    wait for 3ns;
    rst_test <= '0';
    wait;
end process rstCSA_proc;

    clk : process
    begin
    wait for 2ns;
        for i in 0 to 3 loop
            InjClk_test <= '1'; 
            wait for 1 ns;
            InjClk_test <= '0'; 
            wait for 1 ns;
        end loop;        
        wait;
    end process clk;
    
    injdata : process
    begin
--        injdis_test <= '0';
--        wait for 14 ns;
        injdis_test <= '0';
        wait for 10 ns;
        injdis_test <= '0';
        wait;
    end process injdata;

    injection : process
    begin
        inj_test <= '0';
        wait for 16 ns;
        inj_test <= '1';
        wait;
    end process injection;
    
    selck : process
    begin
        wait for 20 ns;
            for i in 0 to (24*24+4) loop
                selCk_test <= '1'; 
                wait for 1 ns;
                selCk_test <= '0'; 
                wait for 1 ns;
            end loop;
        wait; 
    end process selck;       
end Behavioral;
