// alu_xtn class for generating stimulus

class alu_xtn extends uvm_sequence_item;

        // factory registration
        `uvm_object_utils(alu_xtn)

        // declaration of the signals (properties)
        rand bit [7:0] a_in;
        rand bit [7:0] b_in;
        rand bit [3:0] op_in;

        logic [15:0] result;

        static int no_of_trans;

        //constraints
        constraint A_VALID {a_in inside {[0:225]};}
        constraint B_VALID {b_in inside {[0:225]};}
        constraint OP_VALID {op_in inside {[0:7]};}

        // constructor
        extern function new (string name = "alu_xtn");
        extern function void do_copy(uvm_object rhs);
        extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        extern function void do_print(uvm_printer printer);
        extern function void post_randomize();

endclass : alu_xtn

//================================================================================
// body declaration of the functions
function alu_xtn::new(string name = "alu_xtn");
        super.new(name);
endfunction

//================================================================================
function void alu_xtn::do_copy(uvm_object rhs);

        // declaration of the object handle
        alu_xtn rhs_;

        // cast to compare the object type
        if (!$cast(rhs,rhs_)) begin
                `uvm_fatal(get_type_name,"do copy cast failed");
        end

        // copy the data
        super.do_copy(rhs);
        a_in = rhs_.a_in;
        b_in = rhs_.b_in;
        op_in = rhs_.op_in;

endfunction : do_copy

//=================================================================================

function bit alu_xtn::do_compare(uvm_object rhs, uvm_comparer comparer);

        // declaration of the object handle for comparison
        alu_xtn rhs_;

        // cast to check the object type
        if (!$cast(rhs,rhs_)) begin
                `uvm_fatal(get_type_name,"do compare cast failed")
                return 0;
        end

        // comparison
//      return super.do_compare(rhs_,comparer) &&
        //a_in == rhs_.a_in &&
        //b_in == rhs_.b_in &&
        //op_in == rhs_.op_in &&
//      result == rhs_.result;
