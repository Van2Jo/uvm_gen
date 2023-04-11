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
`ifndef ${agent_upper}_MONITOR_SV
`define ${agent_upper}_MONITOR_SV

class ${agent_name}_monitor extends uvm_monitor ;

	`uvm_component_utils(${agent_name}_monitor)

	//Config	//Interface
	virtual ${agent_name}_interface vif;
	
	//TLM 
	uvm_analysis_port#(${agent_name}_item) mon_ap;
	
	//Constructor Function
	function new(string name="${agent_name}_monitor",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	
	//Task Function Methods
	extern task monitor_transation();

	// Add user method here
	//e.g. task function
	// User method ends
endclass

function void ${agent_name}_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	mon_ap=new("mon_ap",this);
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void ${agent_name}_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)

	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task ${agent_name}_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	fork
		monitor_transation();
	// Add user logic here

	// User logic ends

	join
	// Add user logic here
	//e.g. task function `uvm_do_callbacks
	// User logic ends	

endtask

task ${agent_name}_monitor::monitor_transation();

	forever
	begin
	    ${agent_name}_item tr;
		tr=${agent_name}_item::type_id::create("tr",this);
		// Add user logic here
		#1;
		// User logic ends
		mon_ap.write(tr);
	end
endtask

`endif