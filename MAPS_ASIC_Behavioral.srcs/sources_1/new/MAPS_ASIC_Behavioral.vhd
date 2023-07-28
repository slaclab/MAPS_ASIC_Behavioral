----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2023 12:51:53 PM
-- Design Name: 
-- Module Name: MAPS_ASIC_Behavioral - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAPS_ASIC_Behavioral is
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
end MAPS_ASIC_Behavioral;

architecture Behavioral of MAPS_ASIC_Behavioral is

component main is
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
end component main;
begin
main_inst: main
    port map(
        Injrst_n => injrst_n,
        selrst_n => selrst_n,
        selck => selck,
        injclk => injclk,
        injdis => injdis,
        inj => inj,
        bline_n => bline_n,
        latchrst => latchrst,
        rst => rst,
        pixout => pixout
    );


end Behavioral;
