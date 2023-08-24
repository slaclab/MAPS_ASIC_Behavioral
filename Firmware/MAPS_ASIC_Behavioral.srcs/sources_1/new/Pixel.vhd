-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Pixel.vhd
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