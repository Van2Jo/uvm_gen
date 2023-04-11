
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_sequencer
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ADD_IN_SEQUENCER_SV
`define ADD_IN_SEQUENCER_SV
class add_in_sequencer extends uvm_sequencer #(add_in_item);

	`uvm_component_utils(add_in_sequencer)
	//TLM 
	//default seq_item_port

	//Constructor Function
	function new(string name="add_in_sequencer",uvm_component parent=null);
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