<%
agent_upper = agent_name.upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright ${inst} , All right reserved world wide
//
// * Author         : ${user}
// * Create time    : ${date}
// * FileName       : ${agent_name}_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_AGENT_SV
`define ${agent_upper}_AGENT_SV
class ${agent_name}_agent extends hm_base_agent#(.CFG_T(${agent_name}_agent_cfg),
                                                  .SEQUENCER_T(${agent_name}_sequencer),
                                                  .DRIVER_T(${agent_name}_driver),
                                                  .MONITOR_T(${agent_name}_monitor));

	`uvm_component_utils(${agent_name}_agent)
	//TLM 
	uvm_analysis_port#(${agent_name}_item) mon_ap;
	
	//Constructor Function
	function new(string name="${agent_name}_agent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

	// Add user method here
	// e.g. task function
	// User method ends
endclass

function void ${agent_name}_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void ${agent_name}_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_MEDIUM)
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

`endif



	
	
	