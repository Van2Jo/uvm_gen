<%
agent_name = attributes['agent_name']
USER = attributes['user_name']
DATE = attributes['date']
agent_upper = attributes['agent_name'].upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: ${USER}
//date: ${DATE}
//Contents:${agent_name}_interface
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_DRIVER_SV
`define ${agent_upper}_DRIVER_SV

class ${agent_name}_driver extends uvm_driver ;

	`uvm_component_utils(${agent_name}_driver)

	//Config	//Interface
	${agent_name}_driver_cfg drv_cfg;
	virtual ${agent_name}_infterface vif;

	//TLM 
	//default seq_item_port

	//Transaction Sequence item
	${agent_name}_item  tr;

	protected process       process_run_phase;
	
	//Constructor Function
	function new(string name="${agent_name}_driver",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	
	//Task Function Methods
	extern task handle_reset();
	extern task drv_transation();
	
	{{method}}
	// Add user method here
	//e.g. task function
	// User method ends
endclass

function void ${agent_name}_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void ${agent_name}_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	{{connect_phase}}
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task ${agent_name}_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
	process_run_phase = process::self();
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	fork
		drv_tranction();
		// Add user logic here

		// User logic ends
	join
	// Add user logic here
	//e.g. task function `uvm_do_callbacks
	// User logic ends	
endtask

task ${agent_name}_driver::handle_reset(uvm_phase phase);
    if(process_run_phase != null)begin
        process_run_phase.kill();
        //sign reset

        fork
            run_phase(phase);
        join_none

    end

	// Add user logic here
	//e.g. initialize interface
	// User logic ends	
endtask

task ${agent_name}_driver::drv_transation();

	forever begin
		// Add user logic here
		// User logic ends
		seq_item_port.get_next_item(tr);

		// Add user logic here
		//e.g. drive interface
		// User logic ends
	end
endtask

`endif
