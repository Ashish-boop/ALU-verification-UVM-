// class output agent
class output_agent extends uvm_agent;

        // factory registration
        `uvm_component_utils(output_agent)

        // monitor handle declaration
        output_mon mon_h;

        // config object
        alu_env_config m_cfg;

        // constructor
        function new(string name = "output_agent", uvm_component parent);
                super.new(name, parent);
        endfunction

        // build_phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // getting config object
                if(!uvm_config_db #(alu_env_config)::get(this,"","alu_env_config",m_cfg))
                        `uvm_fatal(get_type_name()," OUTPUT AGENT : config object failed")
                // monitor object
                if(m_cfg.output_agent_is_active == UVM_PASSIVE)
                        mon_h = output_mon::type_id::create("mon_h",this);

        endfunction : build_phase


endclass : output_agent
