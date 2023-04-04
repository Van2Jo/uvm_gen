
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef MEM_SYS_MISC_SEQUENCER_SV
`define MEM_SYS_MISC_SEQUENCER_SV
class mem_sys_misc_sequencer extends uvm_sequencer #(mem_sys_misc_item);

	`uvm_component_utils(mem_sys_misc_sequencer)
	//TLM 
	//default seq_item_port

	//Constructor Function
	function new(string name="mem_sys_misc_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual function void handle_reset(uvm_phase phase);
	    int obj_cnt;
	    uvm_objection objection = phase.get_objection();
	    stop_sequences();
	    obj_cnt = objection.get_objection_count(this);

	    if(obj_cnt > 0 )begin
	        objection.drop_objection(this,$sformatf("Dropping %0d objections at reset",obj_cnt),obj_cnt);
	    end
	    start_phase_sequence(phase);

	endfunction

	// Add user method here
	//e.g. task function
	// User method ends
endclass

`endif 