-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: mux.vhd
-------------------------------------------------------------------------------
-- This file is part of 'MAPS_ASIC_Behavioral'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'MAPS_ASIC_Behavioral', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mux is
    generic (
        WIDTH       : positive := 24;
        SELECT_BITS : positive := 5;
        MAX_COUNT   : positive := 24;
        CLK_CYCLES  : positive := 24
    );
    port(
        input   : in std_logic_vector(WIDTH-1 downto 0);
        clk     : in std_logic;
        rst     : in std_logic;
        output  : out std_logic
        );
end mux;
architecture Behavioral of mux is
    signal sel : std_logic_vector(SELECT_BITS-1 downto 0) := (others => '0');
    signal counter : std_logic_vector(SELECT_BITS-1 downto 0) := (others => '0');
begin
output<=input(to_integer(unsigned(sel)));
mux_proc : process(clk,rst)
  begin
    if rst = '0' then
        sel <= (others => '0');
        counter <= (others => '0');
    elsif rising_edge(clk) then
        if counter = CLK_CYCLES-1 then
            counter <= (others => '0');
            if sel = MAX_COUNT-1 then
                sel <= (others => '0');
            else 
                sel <= sel+1;
            end if;
        else 
            counter <= counter+1;
        end if;
    end if;
end process mux_proc;

end Behavioral;