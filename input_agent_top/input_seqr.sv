// input seqr

class input_seqr extends uvm_sequencer #(alu_xtn);

        //factory registration
        `uvm_component_utils(input_seqr)

        // constructor
        function new(string name = "input_seqr", uvm_component parent);
                super.new(name, parent);
        endfunction
endclass : input_seqr
