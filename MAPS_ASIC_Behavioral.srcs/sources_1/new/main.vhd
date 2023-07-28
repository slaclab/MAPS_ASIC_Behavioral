library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    port(        
        InjRst_n   : in std_logic;  --disable injection in all, through main Active Low
        selRst_n   : in std_logic;  --set to 0,0; reset counter inside selck splitter Active Low
                
        SelCk      : in std_logic;  --push row wise
        
        InjClk     : in std_logic;  --combined with injdis in shiftreg      
        InjDis     : in std_logic;  --combined with injclk in shiftreg
        Inj        : in std_logic;  --inject in all enable columns
        
        bline_n    : in std_logic; --PixRST passthrough Active Low
        latchRST   : in std_logic; --PixRST passthrough Active High
        rst        : in std_logic; --PixRST passthrough Active High
        
        PixOut     : out std_logic -- Goal    
    );        
end main;

architecture Behavioral of main is

component shiftreg is
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

component mux is
    generic (
        WIDTH       : positive := 24;
        SELECT_BITS : positive := 5;
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
    port map(
        input  => injDis,
        clk    => injClk,
        rst    => injRst_n,
        output => inj_en
    );
    
mux_inst: mux
    generic map(
        WIDTH       =>  24,
        SELECT_BITS =>  5,
        CLK_CYCLES  =>  1
    )
    port map(
        input  => col_out_array,
        clk    => SelCk,
        rst    => SelRst_n,
        output => PixOut_n
    );
    
end Behavioral;
