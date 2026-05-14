module top();

        import alu_pkg::*;
        import uvm_pkg::*;

        parameter CYCLE = 10;

        reg clock;

        alu_inf DUT_INF(clock);

        alu DUV (.clock(clock),
                 .a_in(DUT_INF.a_in),
                 .b_in(DUT_INF.b_in),
                 .op_in(DUT_INF.op_in),
                 .result(DUT_INF.result)
                );

        initial
                begin
                        uvm_config_db #(virtual alu_inf)::set(null,"*","vif",DUT_INF);
                        run_test();
                end

        initial
                begin
                        clock = 1'b0;
                        forever
                                #(CYCLE/2) clock = ~clock;

                end

endmodule : top
~
