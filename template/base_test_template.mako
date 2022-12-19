//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: ${user}
//date: ${date}
//Contents:${module}_base_test
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class ${module}_base_test extends uvm_test;
	`uvm_component_utils(${module}_base_test)

	//Components
	${module}_env env;

	//Constructor Function
	function new(string name="${module}_base_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	{{method}}
	// Add user method declare here
	//e.g. task function
	// User method ends
endclass

function void ${module}_base_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	env=${module}_env::type_id::create("env",this);
	{{build_phase}}
	// Add user build here

	// User build ends
endfunction

function void ${module}_base_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	{{connect_phase}}
	// Add user connect here

	// User connect ends
endfunction




task ${module}_base_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)
	phase.raise_objection(this);
	// Add user run here
	#100;
	//e.g. new sequence
	//e.g. start sequence
	// User run ends
	phase.drop_objection(this);
endtask