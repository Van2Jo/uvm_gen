
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-02-21
// * FileName       : op_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef OP_MISC_AGENT_SV
`define OP_MISC_AGENT_SV
class op_misc_agent extends uvm_agent;

	`uvm_component_utils(op_misc_agent)

	//Config	//Interface
	op_misc_agent_cfg agt_cfg;
	virtual op_misc_interface vif;
	
	//TLM 
	uvm_analysis_port#(op_misc_item) mon_ap;
	
	//Components
	op_misc_sequencer sqr;
	op_misc_driver drv;
	op_misc_monitor mon;
	
	//Constructor Function
	function new(string name="op_misc_agent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);

	// Add user method here
	// e.g. task function
	// User method ends
endclass

function void op_misc_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	if(!uvm_config_db#(op_misc_agent_cfg)::get(this,"","agt_cfg",agt_cfg))
	begin
		`uvm_fatal(get_name(),"Failed Get op_misc Agent Config")
	end
	if(!uvm_config_db#(virtual op_misc_interface)::get(this,"","op_misc_interface",vif))
	begin
		`uvm_fatal(get_name(),"Failed Get Virtual Interfac op_misc_inf")
	end
	mon=op_misc_monitor::type_id::create("mon",this);
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		sqr=op_misc_sequencer::type_id::create("sqr",this);
		drv=op_misc_driver::type_id::create("op_misc_drv",this);
	end
	
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void op_misc_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	mon.vif=vif;
	mon_ap=mon.mon_ap;
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		drv.vif=vif;
		drv.seq_item_port.connect(sqr.seq_item_export);
	end
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task op_misc_agent::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)

    forever begin
        @(negedge mon.vif.rst_n);
	    if(agt_cfg.is_active == 1)begin
	        drv.handle_reset(phase);
	    end
        if(sqr != null)begin
            sqr.handle_reset(phase);
        end
        @(posedge mon.vif.rst_n);

	// Add user logic here
    end
	// User logic ends
endtask


`endif



	
	
	 