
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

class mem_sys_misc_item extends uvm_sequence_item;
	// Add user data here
	//e.g. rand int addr
	// User data ends
	`uvm_object_utils_begin(mem_sys_misc_item)
	// Add user data here
	//e.g. `uvm_field_int
	// User data ends
	`uvm_object_utils_end
	function new(string name="mem_sys_misc_item");
		super.new(name);
	endfunction

	// Add user method here
	//e.g. implement constarins
	// User method ends	
endclass

 