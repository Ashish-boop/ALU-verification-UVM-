// input monitor

class input_mon extends uvm_monitor;

        // factory registration
        `uvm_component_utils(input_mon)

        // virtual interface
        virtual alu_inf.INPUT_MON mon_inf;

        // xtn handles
        alu_xtn xtn_h;

        //config object
        alu_env_config m_cfg;

        // tlm port connection
        uvm_analysis_port #(alu_xtn) monitor_port;

        // construction
        function new (string name = "input_mon", uvm_component parent);
                super.new(name,parent);
        endfunction

        // build phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // get config object
                if (!uvm_config_db #(alu_env_config)::get(this,"","alu_env_config", m_cfg))
                        `uvm_fatal(get_type_name(),"INPUT MON: get config object failed")
                // monitor port object instance
                monitor_port = new("monitor_port", this);

        endfunction : build_phase

        // connect phase
        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                // interface
                mon_inf = m_cfg.vif;
        endfunction : connect_phase

        // run phase
        task run_phase (uvm_phase phase);
                super.run_phase(phase);
                repeat (2)
                        @(mon_inf.input_mon_cb);
                        forever
                                monitor();
        endtask : run_phase

        // task monitor
        task monitor();
                begin
                        @(mon_inf.input_mon_cb);
                        // create the object to sample the output from dut
                        xtn_h = alu_xtn::type_id::create("xtn_h");
                        xtn_h.a_in = mon_inf.input_mon_cb.a_in;
                        xtn_h.b_in = mon_inf.input_mon_cb.b_in;
                        xtn_h.op_in = mon_inf.input_mon_cb.op_in;

                        // display (info)
                        `uvm_info(get_type_name(), $sformatf("input monitor has captured \n %s", xtn_h.sprint()), UVM_LOW)

                        // send to the scoreboard
                        monitor_port.write(xtn_h);

                        @(mon_inf.input_mon_cb);
                end
        endtask : monitor


endclass : input_mon
