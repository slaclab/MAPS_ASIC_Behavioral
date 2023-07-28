library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity column is
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
end entity column;

architecture Behavioral of column is
component pixel is
    port (
        inj       : in std_logic;
        inj_en    : in std_logic;
        rstCSA       : in std_logic;
        latchRST  : in std_logic;
        pixelOut  : out std_logic
    );
end component pixel;

component mux is
    generic (
        WIDTH       : positive := 24;
        SELECT_BITS : positive := 5;
        CLK_CYCLES  : positive := 24
    );
    port(
        input   : in std_logic_vector(WIDTH-1 downto 0);
        clk     : in std_logic;
        rst     : in std_logic;
        output  : out std_logic
        );
end component mux;

signal pix_output_array : std_logic_vector(23 downto 0);

begin
gen_pixel : for i in 0 to 23 generate
    pixel_inst : pixel
        port map(
            inj      => inj,
            inj_en   => inj_en,
            rstCSA      => rstCSA,
            latchRST => latchRST,
            pixelOut => pix_output_array(i)
            );
end generate gen_pixel;

mux_inst : mux
    port map(
        input  => pix_output_array,
        clk    => SelCk,
        rst    => selRst_n,
        output => col_out
        );
end Behavioral;
