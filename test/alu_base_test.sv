// base test alu

import alu_pkg::*;

class alu_base_test extends uvm_test;

        // factory registration
        `uvm_component_utils(alu_base_test)

        // env object
        env env_h;

        // config object
        alu_env_config m_cfg;

        // constructor
        function new(string name = "alu_base_test", uvm_component parent = null);
                super.new(name,parent);
        endfunction

        // build phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // getting the config object
                m_cfg = alu_env_config::type_id::create("m_cfg");
                if(!uvm_config_db #(virtual alu_inf)::get(this,"","vif",m_cfg.vif))
                        `uvm_fatal(get_type_name(), "CANNOT GET OBJECT");

                // declaration of the config parameters
                m_cfg.has_input_agent = 1;
                m_cfg.has_output_agent = 1;
                m_cfg.has_scoreboard = 1;
                m_cfg.input_agent_is_active = UVM_ACTIVE;
                m_cfg.output_agent_is_active = UVM_PASSIVE;

                // SETTING THE CONFIG OBJECT
                uvm_config_db #(alu_env_config)::set(this,"*", "alu_env_config",m_cfg);

                // creation of the env
                env_h = env::type_id::create("env_h",this);

        endfunction :build_phase

endclass : alu_base_test
~
