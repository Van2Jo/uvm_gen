<%
agent_upper = agent_name.upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright ${inst} , All right reserved world wide
//
// * Author         : ${user}
// * Create time    : ${date}
// * FileName       : ${agent_name}_sequencer
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_SEQUENCER_SV
`define ${agent_upper}_SEQUENCER_SV
class ${agent_name}_sequencer extends uvm_sequencer #(${agent_name}_item);

	`uvm_component_utils(${agent_name}_sequencer)
	//TLM 
	//default seq_item_port

	//Constructor Function
	function new(string name="${agent_name}_sequencer",uvm_component parent=null);
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