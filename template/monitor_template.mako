<%
agent_name = attributes['agent_name']
user = attributes['user_name']
date = attributes['date']
agent_upper = attributes['agent_name'].upper()

%>

//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Auto Generated by UVM-Generator
//Author: ${user}
//date: ${date}
//Contents:${agent_name}_agent
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_MONITOR_SV
`define ${agent_upper}_MONITOR_SV

class ${agent_name}_monitor extends uvm_monitor ;

	`uvm_component_utils(${agent_name}_monitor)

	//Config	//Interface
	virtual ${agent_name}_interface vif;
	
	//TLM 
	uvm_analysis_port#(${agent_name}_item) mon_port;
	
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
	
	{{method}}
	// Add user method here
	//e.g. task function
	// User method ends
endclass

function void ${agent_name}_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	mon_port=new("mon_port",this);
	{{build_phase}}
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void ${agent_name}_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	{{connect_phase}}
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task ${agent_name}_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	fork
		moi_request();
	// Add user logic here

	// User logic ends
	{{run_phase_fork}}
	join
	// Add user logic here
	//e.g. task function `uvm_do_callbacks
	// User logic ends	
	{{run_phase_main}}
endtask

task ${agent_name}_monitor::monitor_transation();

	forever
	begin
	    ${agent_name}_item tr
		tr=${agent_name}_item::type_id::create("tr",this);
		// Add user logic here
		#1;
		// User logic ends
		mon_port.write(tr);
	end
endtask

`endif