##Makefile for UVM Testbench
RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../agent_input_top +incdir+../agent_output_top
SVTB2 = ../test/alu_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;run -all; exit"

help:
        @echo =============================================================================================================
        @echo "! USAGE                  --  make target                                                                                                                                                                                 !"
        @echo "! clean                  =>  clean the earlier log and intermediate files.                                                                                                               !"
        @echo "! sv_cmp         =>  Create library and compile the code.                                                                                                                !"
        @echo "! run_sim    =>  run the simulation in batch mode.                                                                                                                       !"
        @echo "! run_test               =>  clean, compile & run the simulation for alu_test_1 in batch mode.   !"
        @echo "! run_test1      =>  clean, compile & run the simulation for alu_test_arith in batch mode.                       !"
        @echo "! run_test2      =>  clean, compile & run the simulation for alu_test_logic in batch mode.                       !"
        @echo "! run_test3      =>  clean, compile & run the simulation for alu_test_shift in batch mode.               !"
        @echo "! view_wave1 =>  To view the waveform of alu_test_1                                                                                                                      !"
        @echo "! view_wave2 =>  To view the waveform of alu_test_arith                                                                                                                                  !"
        @echo "! view_wave3 =>  To view the waveform of alu_test_logic                                                                                                                                  !"
        @echo "! view_wave4 =>  To view the waveform of alu_test_shift                                                                                                                          !"
        @echo ====================================================================================================================

sv_cmp:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=alu_test_1

run_test1:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=alu_test_2

run_test2:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=alu_test_3

run_test3:sv_cmp                                                                                                                                    
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=alu_test_4

view_wave1:
        vsim -view wave_file1.wlf

view_wave2:
        vsim -view wave_file2.wlf

view_wave3:
        vsim -view wave_file3.wlf

view_wave4:
        vsim -view wave_file4.wlf

clean:
        rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini
        clear
