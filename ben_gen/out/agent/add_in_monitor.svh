
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ADD_IN_MONITOR_SV
`define ADD_IN_MONITOR_SV

class add_in_monitor extends uvm_monitor ;

	`uvm_component_utils(add_in_monitor)

	//Config	//Interface
	virtual add_in_interface vif;
	
	//TLM 
	uvm_analysis_port#(add_in_item) mon_ap;
	
	//Constructor Function
	function new(string name="add_in_monitor",uvm_component parent=null);
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

function void add_in_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	mon_ap=new("mon_ap",this);
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void add_in_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)

	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task add_in_monitor::run_phase(uvm_phase phase);
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

task add_in_monitor::monitor_transation();

	forever
	begin
	    add_in_item tr;
		tr=add_in_item::type_id::create("tr",this);
		// Add user logic here
		#1;
		// User logic ends
		mon_ap.write(tr);
	end
endtask

`endif