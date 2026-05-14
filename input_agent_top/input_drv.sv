// driver

class input_drv extends uvm_driver #(alu_xtn);

        // factory registration
        `uvm_component_utils(input_drv)

        // declaration of the interface
        virtual alu_inf.DRIVER_MP drv_inf;

        // declaration of the config db
        alu_env_config m_cfg;

        // xtn handle declaration for the packet
        alu_xtn xtn_h;

        function new(string name = "driver", uvm_component parent);
                super.new(name,parent);
        endfunction

        // build_phase
        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                // getting config object interface info
                if(!uvm_config_db #(alu_env_config)::get(this,"", "alu_env_config", m_cfg))
                        `uvm_fatal(get_type_name,"Config get() failed")
        endfunction : build_phase


        // connect phase
        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                drv_inf = m_cfg.vif;

        endfunction : connect_phase

        // task run phase
        task run_phase (uvm_phase phase);
                super.run_phase(phase);
                forever
                        begin
                                //@(drv_inf.driver_cb);
                                seq_item_port.get_next_item(req);
                                send_to_dut(req);
                                seq_item_port.item_done();
                                @(drv_inf.driver_cb);
                        end
        endtask : run_phase


        // task send to dut
        virtual task send_to_dut(alu_xtn xtn_h);
                @(drv_inf.driver_cb);
                drv_inf.driver_cb.a_in <= xtn_h.a_in;
                drv_inf.driver_cb.b_in <= xtn_h.b_in;
                drv_inf.driver_cb.op_in <= xtn_h.op_in;
        endtask : send_to_dut


endclass : input_drv
