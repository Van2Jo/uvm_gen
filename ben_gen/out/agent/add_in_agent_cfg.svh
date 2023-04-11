
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * Fileagent_name       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ADD_IN_AGENT_CFG_SV
`define ADD_IN_AGENT_CFG_SV

class add_in_agent_cfg extends hm_base_agent_cfg #(.VIF(virtual add_in_interface));

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	virtual add_in_interface vif;
	`uvm_object_utils_begin(add_in_agent_cfg)
		`uvm_field_enum(uvm_active_passive_enum,is_active,UVM_ALL_ON)
		// Add user cfg here
		//e.g. `uvm_field_int
		// User cfg ends
	`uvm_object_utils_end
	function new(string agent_name="add_in_agent_cfg");
		super.new(agent_name);

		// Add user cfg here
	
		// User new cfg ends

	endfunction

	// Add user method here
	//e.g. function
	// User method ends
endclass

`endif
