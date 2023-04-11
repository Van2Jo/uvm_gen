
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

class add_in_item extends hm_base_transaction;
	// Add user data here
	//e.g. rand int addr
	// User data ends
	`uvm_object_utils_begin(add_in_item)
	// Add user data here
	//e.g. `uvm_field_int
	// User data ends
	`uvm_object_utils_end
	function new(string name="add_in_item");
		super.new(name);
	endfunction

	// Add user method here
	//e.g. implement constarins
	// User method ends	
endclass

