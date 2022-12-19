<%
MODULE = attributes['module_name']
USER = attributes['user_name']
DATE = attributes['date']
vip =  attributes['vip']
%>

//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: ${USER}
//date: ${DATE}
//Contents:${MODULE}_env
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class ${MODULE}_env extends uvm_env;
	`uvm_component_utils(${MODULE}_env)
	//Config
	${MODULE}_env_config cfg;
	
	//Components & Configs
%for agent in agents:
    ${agent}_agent  ${agent}_agt_m;
%endfor
%if vip == "axi":
	/** AXI System Env & configuration **/
	svt_axi_system_env  axi_system_env;
%elif vip == "apb":
    /** APB System Env & configuration **/
    svt_apb_system_env  axi_system_env;
%endif

	${MODULE}_axi_system_cfg    cfg;

    /** Virual sequencer **/
	${MODULE}_virtual_sequencer vsqr;

	/** reference model **//
	${MODULE}_ref_model   ${MODULE}_rm;

	/** scoreborad **/
	${MODULE}_scoreboard  ${MODULE}_scd;

	//Constructor Function
	function new(string name="${MODULE}_env",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
    //uesr method

endclass

function void ${MODULE}_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	vsqr = ${MODULE}_virtual_sequencer::type_id::create("vsqr",this);
%if vip == "axi":
	axi_system_env = svt_axi_system_env::type_id::create("axi_ststem_env",this);
%endif

%for agent in agents:
    ${agent}_agt = ${agent}_agent::type_id::create("${agent}_agt");
%endfor
    if (!(uvm_config_db#(${MODULE}_axi_system_cfg)::get(this, "", "cfg". cfg))) begin
        `uvm_fatal(get_name(),"Could not get ${MODULE}_system_cfg")
    end else begin
        uvm_config_db#(svt_axi_system_configuration)::set(this,"axi_system_env","cfg",cfg);
    end
endfunction

function void ${MODULE}_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
endfunction
