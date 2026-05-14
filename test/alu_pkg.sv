package alu_pkg;

        int number_of_transactions = 100;
        import uvm_pkg::*;

        `include "uvm_macros.svh"

        `include "alu_xtn.sv"
        `include "alu_env_config.sv"
        `include "input_drv.sv"
        `include "input_mon.sv"
        `include "input_seqr.sv"
        `include "input_agent.sv"
        `include "output_mon.sv"
        `include "output_agent.sv"
        `include "scoreboard.sv"
        `include "env.sv"
        `include "seq_lib.sv"
        `include "alu_base_test.sv"
        `include "alu_test_lib.sv"

endpackage
