// env class
class env extends uvm_env;

        // factory registration
        `uvm_component_utils(env)

        //object handles
        input_agent in_agent_h;
        output_agent out_agent_h;
        scoreboard scb_h;
        alu_env_config  m_cfg;

        // construction
        function new(string name = "env", uvm_component parent);
                super.new(name, parent);
        endfunction

        // build_phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // getting the config object
                if(!uvm_config_db #(alu_env_config)::get(this,"", "alu_env_config",m_cfg))
                        `uvm_fatal(get_type_name(),"Env config: failed to get config object");

                // creation of input agent
                if(m_cfg.has_input_agent == 1)
                        in_agent_h = input_agent::type_id::create("in_agent_h",this);

                if(m_cfg.has_output_agent == 1)
                        out_agent_h = output_agent::type_id::create("out_agent_h",this);

                if(m_cfg.has_scoreboard == 1)
                        scb_h = scoreboard::type_id::create("scb_h",this);

        endfunction : build_phase

        // connect phase
        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

        //      uvm_top.print_topology();

                if(m_cfg.has_input_agent && m_cfg.has_scoreboard)
                        in_agent_h.mon_h.monitor_port.connect(scb_h.input_mon_fifo.analysis_export);
                if(m_cfg.has_output_agent && m_cfg.has_scoreboard)
                        out_agent_h.mon_h.monitor_port.connect(scb_h.output_mon_fifo.analysis_export);
        endfunction : connect_phase

        // end_of_elaboration phase
        function void end_of_elaboration_phase(uvm_phase phase);
                super.end_of_elaboration_phase(phase);

                uvm_top.print_topology();

        endfunction : end_of_elaboration_phase

endclass : env
