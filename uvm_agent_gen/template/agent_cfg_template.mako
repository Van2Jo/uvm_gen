<%
inst   = attributes['inst']
agent_name = attributes['agent_name']
user = attributes['user_name']
date = attributes['date']
agent_upper = attributes['agent_name'].upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright ${inst} , All right reserved world wide
//
// * Author         : ${user}
// * Create time    : ${date}
// * FileName       : ${agent_name}_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_AGENT_CFG_SV
`define ${agent_upper}_AGENT_CFG_SV

class ${agent_name}_agent_cfg extends uvm_object;

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	virtual ${agent_name}_interface vif;
	`uvm_object_utils_begin(${agent_name}_agent_cfg)
		`uvm_field_enum(uvm_active_passive_enum,is_active,UVM_ALL_ON)
		// Add user cfg here
		//e.g. `uvm_field_int
		// User cfg ends
	`uvm_object_utils_end
	function new(string name="${agent_name}_agent_cfg");
		super.new(name);

		// Add user cfg here
	
		// User new cfg ends

	endfunction

	// Add user method here
	//e.g. function
	// User method ends
endclass

`endif
