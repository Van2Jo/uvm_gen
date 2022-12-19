

//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: bengjiang
//date: 2022-12-15
//Contents:merak_env
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class merak_env extends uvm_env;
	`uvm_component_utils(merak_env)
	//Config
	merak_env_config cfg;
	
	//Components & Configs
    input_agent  input_agt_m;
    output_agent  output_agt_m;

	merak_axi_system_cfg    cfg;

    /** Virual sequencer **/
	merak_virtual_sequencer vsqr;

	/** reference model **//
	merak_ref_model   merak_rm;

	/** scoreborad **/
	merak_scoreboard  merak_scd;

	//Constructor Function
	function new(string name="merak_env",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
    //uesr method

endclass

function void merak_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	vsqr = merak_virtual_sequencer::type_id::create("vsqr",this);

    input_agt = input_agent::type_id::create("input_agt");
    output_agt = output_agent::type_id::create("output_agt");
    if (!(uvm_config_db#(merak_axi_system_cfg)::get(this, "", "cfg". cfg))) begin
        `uvm_fatal(get_name(),"Could not get merak_system_cfg")
    end else begin
        uvm_config_db#(svt_axi_system_configuration)::set(this,"axi_system_env","cfg",cfg);
    end
endfunction

function void {{MODULE}}_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
endfunction
 