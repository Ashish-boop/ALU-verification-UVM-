// input agent top

class input_agent extends uvm_agent;

        // factory registration
        `uvm_component_utils(input_agent)

        // declaration of the alu_env config
        alu_env_config m_cfg;

        // declaration of the monitor driver sequencer
        input_drv drv_h;
        input_mon mon_h;
        input_seqr seqr_h;

        // construction
        function new(string name = "input_agent", uvm_component parent = null);
                super.new(name,parent);
        endfunction

        // build phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // getting config db
                if(!uvm_config_db #(alu_env_config)::get(this, "", "alu_env_config", m_cfg))
                        `uvm_fatal(get_type_name(), "INPUT AGENT: object config get failed")
                // monitor object creation
                mon_h = input_mon::type_id::create("mon_h",this);

                if (m_cfg.input_agent_is_active == UVM_ACTIVE)
                        begin
                                // creating drv and sequencer
                                drv_h = input_drv::type_id::create("drv_h",this);
                                seqr_h = input_seqr::type_id::create("seqr_h",this);
                        end
        endfunction : build_phase

        // connect phase
        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                if (m_cfg.input_agent_is_active == UVM_ACTIVE)
                        begin
                                // port connection
                                drv_h.seq_item_port.connect(seqr_h.seq_item_export);
                        end
        endfunction : connect_phase

endclass : input_agent
