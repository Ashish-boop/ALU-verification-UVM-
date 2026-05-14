// configuration class

class alu_env_config extends uvm_object;

        // factory registration
        `uvm_object_utils(alu_env_config)

        // properties for has_component
        bit has_input_agent;
        bit has_output_agent;
        bit has_scoreboard;

        uvm_active_passive_enum input_agent_is_active;
        uvm_active_passive_enum output_agent_is_active;

        virtual alu_inf vif;

        // constructor
        function new (string name = "alu_env_config");
                super.new(name);
        endfunction

endclass : alu_env_config
