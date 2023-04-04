
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef MEM_SYS_MISC_DRIVER_SV
`define MEM_SYS_MISC_DRIVER_SV

class mem_sys_misc_driver extends uvm_driver #(mem_sys_misc_item);

	`uvm_component_utils(mem_sys_misc_driver)

	//Config	//Interface
	virtual mem_sys_misc_interface vif;

	//TLM 
	//default seq_item_port

	//Transaction Sequence item
	mem_sys_misc_item  tr;

	protected process       process_run_phase;
	
	//Constructor Function
	function new(string name="mem_sys_misc_driver",uvm_component parent=null);
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

function void mem_sys_misc_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void mem_sys_misc_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task mem_sys_misc_driver::run_phase(uvm_phase phase);
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

task mem_sys_misc_driver::handle_reset(uvm_phase phase);
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

task mem_sys_misc_driver::drv_transation();

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
 