// sequence class

class alu_base_seq extends uvm_sequence #(alu_xtn);

        // factory registration
        `uvm_object_utils(alu_base_seq)

        // constructor
        extern function new(string name = "alu_base_seq");

endclass : alu_base_seq

        // constructor
function alu_base_seq::new(string name = "alu_base_seq");
                super.new(name);
endfunction

//===================================================================


class alu_seq_1 extends alu_base_seq;

        // factory registration
        `uvm_object_utils(alu_seq_1)

        // constructor
        function new(string name = "alu_base_seq");
                super.new(name);
        endfunction

        // task body
        task body();

                repeat (number_of_transactions) begin
                        // object creation
                        req = alu_xtn::type_id::create("req");

                        // wait for driver
                        start_item(req);

                        // generate transaction
                        assert(req.randomize());

                        // wait for acknowledgment
                        finish_item(req);
                end

        endtask : body
endclass : alu_seq_1

//============================================================================

class alu_seq_arith extends alu_base_seq;

        // factory registration
        `uvm_object_utils(alu_seq_arith)

        // constructor
        function new(string name = "alu_seq_arith");
                super.new(name);
        endfunction

        // task body
        task body();

                repeat (number_of_transactions) begin
                        // object creation
                        req = alu_xtn::type_id::create("req");

                        start_item(req);

                        assert(req.randomize() with {op_in inside {[0:1]};});

                        finish_item(req);
                end

        endtask : body

endclass : alu_seq_arith

//==============================================================================

class alu_seq_logic extends alu_base_seq;

        // factory registration
        `uvm_object_utils(alu_seq_logic)

        function new(string name = "alu_seq_logic");
                super.new(name);
        endfunction

        // task body
        task body();
                repeat (number_of_transactions) begin
                        // object creation
                        req = alu_xtn::type_id::create("req");

                        start_item(req);

                        assert(req.randomize() with {op_in inside {[2:5]};});

                        finish_item(req);

                end

        endtask : body

endclass : alu_seq_logic

//================================================================================

class alu_seq_shift extends alu_base_seq;

        // factory registration
        `uvm_object_utils(alu_seq_shift)

        //constructor
        function new(string name = "alu_seq_shift");
                super.new(name);
        endfunction

        // task body
        task body();
                repeat (number_of_transactions) begin
                        /// object creation
                        req = alu_xtn::type_id::create("req");

                        start_item(req);

                        assert(req.randomize() with {op_in inside {[6:7]};});

                        finish_item(req);
                end

        endtask : body

endclass : alu_seq_shift

//================================================================================
~
~
