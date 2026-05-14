class alu_test_1 extends alu_base_test;

        //factory registration
        `uvm_component_utils(alu_test_1);

        // seq handle
        alu_seq_1 seq1_h;

        // constructor
        function new(string name = "alu_test_1", uvm_component parent = null);
                super.new(name,parent);
        endfunction

        //build phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction : build_phase

        // run phase
        task run_phase(uvm_phase phase);
                phase.raise_objection(this);

                        seq1_h = alu_seq_1::type_id::create("seq1_h");

                        seq1_h.start(env_h.in_agent_h.seqr_h);

                        #30;
                phase.drop_objection(this);
        endtask : run_phase
endclass : alu_test_1

//======================================================================================

class alu_test_2 extends alu_base_test;

        // factory registration
        `uvm_component_utils(alu_test_2)

        // seq handle
        alu_seq_arith seq2_h;

        //constructor
        function new(string name = "alu_test_2", uvm_component parent = null);
                super.new(name, parent);
        endfunction

        // run phase
        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);
                        seq2_h = alu_seq_arith::type_id::create("seq2_h");

                        seq2_h.start(env_h.in_agent_h.seqr_h);

                        #30;
                phase.drop_objection(this);

        endtask : run_phase
endclass : alu_test_2

//=========================================================================================

class alu_test_3 extends alu_base_test;

        // factory registration
        `uvm_component_utils(alu_test_3)

        // seq handle
        alu_seq_logic seq3_h;

        // constructor
        function new(string name = "alu_test_3", uvm_component parent = null);
                super.new(name, parent);
        endfunction

        // run_phase
        task run_phase(uvm_phase phase);
                //super.task_phase(phase);

                phase.raise_objection(this);
                        seq3_h = alu_seq_logic::type_id::create("seq_3h");

                        seq3_h.start(env_h.in_agent_h.seqr_h);

                        #30;
                phase.drop_objection(this);

        endtask : run_phase

endclass : alu_test_3

//=======================================================================================

class alu_test_4 extends alu_base_test;

        // factory registration
        `uvm_component_utils(alu_test_4)

        // seq handle
        alu_seq_shift seq4_h;

        // constructor
        function new(string name = "alu_test_4", uvm_component parent);
                super.new(name, parent);
        endfunction

        //run_phase
        task run_phase(uvm_phase phase);
                //super.task_phase(phase);

                phase.raise_objection(this);
                        seq4_h = alu_seq_shift::type_id::create("seq4_h");

                        seq4_h.start(env_h.in_agent_h.seqr_h);

                        #30;
                phase.drop_objection(this);

        endtask : run_phase

endclass : alu_test_4

//==========================================================================================

