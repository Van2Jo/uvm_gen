
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef MEM_SYS_MISC_AGENT_CFG_SV
`define MEM_SYS_MISC_AGENT_CFG_SV

class mem_sys_misc_agent_cfg extends uvm_object;

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	virtual mem_sys_misc_interface vif;
	`uvm_object_utils_begin(mem_sys_misc_agent_cfg)
		`uvm_field_enum(uvm_active_passive_enum,is_active,UVM_ALL_ON)
		// Add user cfg here
		//e.g. `uvm_field_int
		// User cfg ends
	`uvm_object_utils_end
	function new(string name="mem_sys_misc_agent_cfg");
		super.new(name);

		// Add user cfg here
	
		// User new cfg ends

	endfunction

	// Add user method here
	//e.g. function
	// User method ends
endclass

`endif
 