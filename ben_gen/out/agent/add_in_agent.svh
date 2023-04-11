
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ADD_IN_AGENT_SV
`define ADD_IN_AGENT_SV
class add_in_agent extends hm_base_agent#(.CFG_T(add_in_agent_cfg),
                                                  .SEQUENCER_T(add_in_sequencer),
                                                  .DRIVER_T(add_in_driver),
                                                  .MONITOR_T(add_in_monitor));

	`uvm_component_utils(add_in_agent)
	//TLM 
	uvm_analysis_port#(add_in_item) mon_ap;
	
	//Constructor Function
	function new(string name="add_in_agent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

	// Add user method here
	// e.g. task function
	// User method ends
endclass

function void add_in_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void add_in_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_MEDIUM)
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

`endif



	
	
	