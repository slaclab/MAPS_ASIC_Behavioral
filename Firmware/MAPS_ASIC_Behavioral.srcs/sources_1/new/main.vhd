library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    generic(
        ROWS_G     : positive := 24;
        COLS_G     : positive := 24;
        BITS_G     : positive := 5 -- 2^BITS_C needs to be greater than ROWS_C or COLS_C
        ); 
    port(        
        InjRst_n   : in std_logic;  --disable injection in all, Active Low
        selRst_n   : in std_logic;  --sets pixel output to 0,0 pixel, Active Low
                
        SelCk      : in std_logic;  --advance which pixel selected in a row
        
        InjClk     : in std_logic;  --combined with injdis in shiftreg      
        InjDis     : in std_logic;  --combined with injclk in shiftreg
        Inj        : in std_logic;  --inject in all enable columns
        
        bline_n    : in std_logic; --PixRST passthrough Active Low
        latchRST   : in std_logic; --PixRST passthrough Active High
        rst        : in std_logic; --PixRST passthrough Active High
        
        PixOut     : out std_logic -- Serial digital output    
    );        
end main;

architecture Behavioral of main is

-- shift register, takes in injdis and injclk to feed inj_en to the pixels
component shiftreg is
    generic (
        WIDTH       : positive := ROWS_G;
        SELECT_BITS : positive := BITS_G
    );
    Port (
        input  : in std_logic;
        clk    : in std_logic;
        rst    : in std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0)
    );
end component shiftreg;

component column is
    port (
        Inj       : in std_logic;
        Inj_en    : in std_logic;
        SelCk     : in std_logic;
        selRst_n  : in std_logic;
        bline_n   : in std_logic; --PixRST passthrough
        latchRST  : in std_logic; --PixRST passthrough
        rstCSA    : in std_logic; --PixRST passthrough              
        col_out   : out std_logic
    );
end component column;

--mux component for use in scanning array
component mux is
    generic (
        WIDTH       : positive := ROWS_G;
        SELECT_BITS : positive := BITS_G;
        MAX_COUNT   : positive := ROWS_G;
        CLK_CYCLES  : positive := 0
    );
    port(
        input   : in std_logic_vector(WIDTH-1 downto 0);
        clk     : in std_logic;
        rst     : in std_logic;
        output  : out std_logic
        );
end component mux;

-- temp signals
    signal inj_en        : std_logic_vector(23 downto 0);
    signal col_out_array : std_logic_vector(23 downto 0);
    signal PixOut_n    : std_logic;

begin

PixOut <= (PixOut_n);

gen_column : for i in 0 to 23 generate
    column_inst : column
        port map(
        Inj      => inj,
        Inj_en   => inj_en(i),
        SelCk    => SelCk,
        selRst_n => selRst_n,
        bline_n  => bline_n,
        latchRST => latchRST,
        rstCSA   => rst,
        col_out  => col_out_array(i)
    );
end generate gen_column;

shiftreg_inst : shiftreg
    generic map(
        WIDTH       => ROWS_G,
        SELECT_BITS => BITS_G
    )
    port map(
        input  => injDis,
        clk    => injClk,
        rst    => injRst_n,
        output => inj_en
    );
    
mux_inst: mux
    generic map(
        WIDTH       =>  COLS_G,
        SELECT_BITS =>  BITS_G,
        MAX_COUNT   => COLS_G,
        CLK_CYCLES  =>  1
    )
    port map(
        input  => col_out_array,
        clk    => SelCk,
        rst    => SelRst_n,
        output => PixOut_n
    );
    
end Behavioral;
