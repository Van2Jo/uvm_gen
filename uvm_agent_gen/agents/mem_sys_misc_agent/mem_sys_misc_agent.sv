
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef MEM_SYS_MISC_AGENT_SV
`define MEM_SYS_MISC_AGENT_SV
class mem_sys_misc_agent extends uvm_agent;

	`uvm_component_utils(mem_sys_misc_agent)

	//Config	//Interface
	mem_sys_misc_agent_cfg agt_cfg;
	virtual mem_sys_misc_interface vif;
	
	//TLM 
	uvm_analysis_port#(mem_sys_misc_item) mon_ap;
	
	//Components
	mem_sys_misc_sequencer sqr;
	mem_sys_misc_driver drv;
	mem_sys_misc_monitor mon;
	
	//Constructor Function
	function new(string name="mem_sys_misc_agent",uvm_component parent=null);
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

function void mem_sys_misc_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	if(!uvm_config_db#(mem_sys_misc_agent_cfg)::get(this,"","agt_cfg",agt_cfg))
	begin
		`uvm_fatal(get_name(),"Failed Get mem_sys_misc Agent Config")
	end
	if(!uvm_config_db#(virtual mem_sys_misc_interface)::get(this,"","mem_sys_misc_interface",vif))
	begin
		`uvm_fatal(get_name(),"Failed Get Virtual Interfac mem_sys_misc_inf")
	end
	mon=mem_sys_misc_monitor::type_id::create("mon",this);
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		sqr=mem_sys_misc_sequencer::type_id::create("sqr",this);
		drv=mem_sys_misc_driver::type_id::create("mem_sys_misc_drv",this);
	end
	
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void mem_sys_misc_agent::connect_phase(uvm_phase phase);
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

task mem_sys_misc_agent::run_phase(uvm_phase phase);
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



	
	
	 