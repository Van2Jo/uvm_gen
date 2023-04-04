
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-02-21
// * FileName       : op_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef OP_MISC_MONITOR_SV
`define OP_MISC_MONITOR_SV

class op_misc_monitor extends uvm_monitor ;

	`uvm_component_utils(op_misc_monitor)

	//Config	//Interface
	virtual op_misc_interface vif;
	
	//TLM 
	uvm_analysis_port#(op_misc_item) mon_ap;
	
	//Constructor Function
	function new(string name="op_misc_monitor",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	
	//Task Function Methods
	extern task monitor_transation();

	// Add user method here
	//e.g. task function
	// User method ends
endclass

function void op_misc_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	mon_ap=new("mon_ap",this);
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void op_misc_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)

	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task op_misc_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	fork
		monitor_transation();
	// Add user logic here

	// User logic ends

	join
	// Add user logic here
	//e.g. task function `uvm_do_callbacks
	// User logic ends	

endtask

task op_misc_monitor::monitor_transation();

	forever
	begin
	    op_misc_item tr;
		tr=op_misc_item::type_id::create("tr",this);
		// Add user logic here
		#1;
		// User logic ends
		mon_ap.write(tr);
	end
endtask

`endif 