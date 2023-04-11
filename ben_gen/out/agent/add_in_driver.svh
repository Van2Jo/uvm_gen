
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ADD_IN_DRIVER_SV
`define ADD_IN_DRIVER_SV

class add_in_driver extends uvm_driver #(add_in_item);

	`uvm_component_utils(add_in_driver)

	//Config	//Interface
	virtual add_in_interface vif;

	//TLM 
	//default seq_item_port

	//Transaction Sequence item
	add_in_item  tr;

	protected process       process_run_phase;
	
	//Constructor Function
	function new(string name="add_in_driver",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	
	//Task Function Methods
	extern task handle_reset(uvm_phase phase);
	extern task drv_transation();

	// Add user method here
	//e.g. task function
	// User method ends
endclass

function void add_in_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void add_in_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task add_in_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
	process_run_phase = process::self();
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	fork
		drv_transation();
		// Add user logic here

		// User logic ends
	join
	// Add user logic here
	//e.g. task function `uvm_do_callbacks
	// User logic ends	
endtask

task add_in_driver::handle_reset(uvm_phase phase);
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

task add_in_driver::drv_transation();

	forever begin
		// Add user logic here
		// User logic ends
		seq_item_port.get_next_item(tr);

		// Add user logic here
		//e.g. drive interface
		// User logic ends
		seq_item_port.item_done();
	end
endtask

`endif
