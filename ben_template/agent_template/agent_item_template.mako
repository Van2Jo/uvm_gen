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

class ${agent_name}_item extends hm_base_transaction;
	// Add user data here
	//e.g. rand int addr
	// User data ends
	`uvm_object_utils_begin(${agent_name}_item)
	// Add user data here
	//e.g. `uvm_field_int
	// User data ends
	`uvm_object_utils_end
	function new(string name="${agent_name}_item");
		super.new(name);
	endfunction

	// Add user method here
	//e.g. implement constarins
	// User method ends	
endclass

