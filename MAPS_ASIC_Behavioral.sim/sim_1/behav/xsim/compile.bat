@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.2.2 (64-bit)
REM
REM Filename    : compile.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for compiling the simulation design source files
REM
REM Generated by Vivado on Mon Aug 07 10:06:37 -0700 2023
REM SW Build 3788238 on Tue Feb 21 20:00:34 MST 2023
REM
REM IP Build 3783773 on Tue Feb 21 23:41:56 MST 2023
REM
REM usage: compile.bat
REM
REM ****************************************************************************
REM compile VHDL design sources
echo "xvhdl --incr --relax -prj main_test_vhdl.prj"
call xvhdl  --incr --relax -prj main_test_vhdl.prj -log xvhdl.log
call type xvhdl.log > compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
