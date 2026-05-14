// interface

interface alu_inf(input bit clock);

        // signal declaration
        logic [7:0] a_in;
        logic [7:0] b_in;
        logic [3:0] op_in;

        logic [15:0] result;

        // driver clocking block
        clocking driver_cb @(posedge clock);
                default input #1 output #1;
                output a_in;
                output b_in;
                output op_in;
        endclocking : driver_cb


        // input monitor clocking block
        clocking input_mon_cb @(posedge clock);
                default input #1 output #1;
                input a_in;
                input b_in;
                input op_in;
        endclocking : input_mon_cb


        // output monitor clocking block
        clocking output_mon_cb @(posedge clock);
                default input #1 output #1;
                input result;
        endclocking : output_mon_cb


        // driver modport
        modport DRIVER_MP (clocking driver_cb);

        // input monitor modport
        modport INPUT_MON (clocking input_mon_cb);

        // output monitor modport
        modport OUTPUT_MON (clocking output_mon_cb);


endinterface : alu_inf
