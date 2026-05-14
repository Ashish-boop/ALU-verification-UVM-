class scoreboard extends uvm_scoreboard;

        // factory registration
        `uvm_component_utils(scoreboard)

        // port declaration
        uvm_tlm_analysis_fifo #(alu_xtn) input_mon_fifo;
        uvm_tlm_analysis_fifo #(alu_xtn) output_mon_fifo;

        // pkt declaration
        alu_xtn input_mon_pkt;
        alu_xtn output_mon_pkt;
        alu_xtn exp_output_pkt;
        alu_xtn cov_data_pkt;

        // int declaration to count
        int data_verified = 0;
        int input_mon_pkt_count = 0;
        int output_mon_pkt_count = 0;
        int matched_outputs;
        int missmatched_outputs;

        // covergroup
        covergroup alu_coverage;

                option.per_instance = 1;

                A_IN : coverpoint cov_data_pkt.a_in {
                        bins ZERO = {0};
                        bins LOW = {[1:84]};
                        bins MID = {[85:168]};
                        bins HIGH = {[169:254]};
                        bins MAX = {255};
                        }

                B_IN : coverpoint cov_data_pkt.b_in {
                        bins ZERO = {0};
                        bins LOW = {[1:84]};
                        bins MID = {[85:168]};
                        bins HIGH = {[169:254]};
                        bins MAX = {255};
                        }

                OP_IN : coverpoint cov_data_pkt.op_in {
                        bins ARITH = {[0:1]};
                        bins LOGIC = {[2:5]};
                        bins SHIFT = {[6:7]};
                        }

                CROSS : cross A_IN , B_IN, OP_IN;

        endgroup : alu_coverage

        // constructor
        function new(string name = "scoreboard", uvm_component parent);
                super.new(name, parent);

                // object creation for the tlm fifo
                input_mon_fifo = new("input_mon_pkt",this);
                output_mon_fifo = new("output_mon_pkt",this);
                exp_output_pkt = alu_xtn::type_id::create("exp_output_pkt");

                // object for coverage
                alu_coverage = new();

        endfunction

        // run phase
        task run_phase(uvm_phase phase);
                super.run_phase(phase);
                forever
                        begin

                                // getting pkt from input monitor
                                input_mon_fifo.get(input_mon_pkt);
                                input_mon_pkt_count++;
                //              `uvm_info(get_type_name(), $sformatf("DATA_PKT FROM INPUT MONITOR : \n %s", input_mon_pkt.sprint()), UVM_LOW);

                                // getting pkt from output monitor
                                output_mon_fifo.get(output_mon_pkt);
                                output_mon_pkt_count++;
                //              `uvm_info(get_type_name(), $sformatf("DATA_PKT FROM OUTPUT MONITOR : \n %s", output_mon_pkt.sprint()), UVM_LOW);

                                // comparison
                                ref_model_logic();


                                validate_output();
                        end
        endtask : run_phase

        // ref_model_logic
        task ref_model_logic();
                begin
                        case(input_mon_pkt.op_in)
                                3'b000 : exp_output_pkt.result = input_mon_pkt.a_in + input_mon_pkt.b_in;
                                3'b001 : exp_output_pkt.result = input_mon_pkt.a_in - input_mon_pkt.b_in;
                                3'b010 : exp_output_pkt.result = input_mon_pkt.a_in & input_mon_pkt.b_in;
                                3'b011 : exp_output_pkt.result = input_mon_pkt.a_in | input_mon_pkt.b_in;
                                3'b100 : exp_output_pkt.result = input_mon_pkt.a_in ^ input_mon_pkt.b_in;
                                3'b101 : exp_output_pkt.result = ~ input_mon_pkt.a_in;
                                3'b110 : exp_output_pkt.result = input_mon_pkt.a_in << 1;
                                3'b111 : exp_output_pkt.result = input_mon_pkt.a_in >> 1;
                                default : exp_output_pkt.result = 16'd0;
                        endcase
                end
        endtask : ref_model_logic

        // task for comparison of outputs
        task validate_output();
                if(exp_output_pkt.result !=  output_mon_pkt.result)//compare(output_mon_pkt))

                        begin : failed_compare
                                //`uvm_info(get_type_name(), $sformatf("expected pkt: \n %s", exp_output_pkt.sprint()), UVM_LOW)
                                //`uvm_info(get_type_name(), $sformatf("output_mon_pkt: \n %s", output_mon_pkt.sprint()), UVM_LOW)
                                `uvm_info(get_type_name(), $sformatf("DATA MISSMATCHED------------------------------------------------------------"), UVM_LOW)
                                $display("exp_output = %0d", exp_output_pkt.result);
                                missmatched_outputs++;
                                data_verified++;
                        end : failed_compare

                else
                        begin : successful_compare
                                `uvm_info(get_type_name(), $sformatf("DATA MATCHED"), UVM_LOW)
                                $display("exp_output = %0d", exp_output_pkt.result);
                                matched_outputs++;
                                data_verified++;
                        end : successful_compare

                cov_data_pkt = input_mon_pkt;
                alu_coverage.sample();

        endtask : validate_output
        // report phase
        function void report_phase(uvm_phase phase);
                $display("\n ----------------------------------------------------------------------------------------------------------");
                $display(" MATCHED PKT count = %0d", matched_outputs);
                $display(" MISSMATCHED PKT count = %0d", missmatched_outputs);
                $display(" DATA VERIFIED count = %0d", data_verified);
                $display("\n ----------------------------------------------------------------------------------------------------------");
        endfunction : report_phase


endclass : scoreboard
                                              
