@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.2.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Fri Jul 28 11:46:28 -0700 2023
REM SW Build 3788238 on Tue Feb 21 20:00:34 MST 2023
REM
REM IP Build 3783773 on Tue Feb 21 23:41:56 MST 2023
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim main_test_behav -key {Behavioral:sim_1:Functional:main_test} -tclbatch main_test.tcl -view C:/Users/ahmcg/MAPS_ASIC_Behavioral/main_test_behav1.wcfg -log simulate.log"
call xsim  main_test_behav -key {Behavioral:sim_1:Functional:main_test} -tclbatch main_test.tcl -view C:/Users/ahmcg/MAPS_ASIC_Behavioral/main_test_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
