//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: houmo
//date: 2022-09-16
//Contents:engine_3m1s_env
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class engine_3m1s_env extends uvm_env;
	`uvm_component_utils(engine_3m1s_env)
	//Config
	engine_3m1s_env_config cfg;
	
	//Components & Configs

	/** AXI System Env & configuration **/
	svt_axi_system_env  axi_system_env;

	engine_3m1s_axi_system_cfg    cfg;

    /** Virual sequencer **/
	engine_3m1s_virtual_sequencer vsqr;

	//Constructor Function
	function new(string name="engine_3m1s_env",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
    //uesr method

endclass

function void engine_3m1s_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	vsqr = engine_3m1s_virtual_sequencer::type_id::create("vsqr",this);
	axi_system_env = svt_axi_system_env::type_id::create("axi_ststem_env",this);

if (!(uvm_config_db#(engine_3m1s_axi_system_cfg)::get(this, "", "cfg". cfg))) begin
       `uvm_fatal(get_name(),"Could not get engine_3m1s_system_cfg")
end else begin
        uvm_config_db#(svt_axi_system_configuration)::set(this,"axi_system_env","cfg",cfg);
end
endfunction

function void {{MODULE}}_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
endfunction