<%
inst   = attributes['inst']
agent_name = attributes['agent_name']
user = attributes['user_name']
date = attributes['date']
agent_upper = attributes['agent_name'].upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright ${inst} , All right reserved world wide
//
// * Author         : ${user}
// * Create time    : ${date}
// * FileName       : ${agent_name}_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
`ifndef ${agent_upper}_AGENT_SV
`define ${agent_upper}_AGENT_SV
class ${agent_name}_agent extends uvm_agent;

	`uvm_component_utils(${agent_name}_agent)

	//Config	//Interface
	${agent_name}_agent_cfg agt_cfg;
	virtual ${agent_name}_interface vif;
	
	//TLM 
	uvm_analysis_port#(${agent_name}_item) mon_ap;
	
	//Components
	${agent_name}_sequencer sqr;
	${agent_name}_driver drv;
	${agent_name}_monitor mon;
	
	//Constructor Function
	function new(string name="${agent_name}_agent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	//Phase Methods
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);

	// Add user method here
	// e.g. task function
	// User method ends
endclass

function void ${agent_name}_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	if(!uvm_config_db#(${agent_name}_agent_cfg)::get(this,"","agt_cfg",agt_cfg))
	begin
		`uvm_fatal(get_name(),"Failed Get ${agent_name} Agent Config")
	end
	if(!uvm_config_db#(virtual ${agent_name}_interface)::get(this,"","${agent_name}_interface",vif))
	begin
		`uvm_fatal(get_name(),"Failed Get Virtual Interfac ${agent_name}_inf")
	end
	mon=${agent_name}_monitor::type_id::create("mon",this);
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		sqr=${agent_name}_sequencer::type_id::create("sqr",this);
		drv=${agent_name}_driver::type_id::create("${agent_name}_drv",this);
	end
	
	// Add user build here
	//e.g. TLM build
	// User build ends
endfunction

function void ${agent_name}_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_name(),"Connect Phase is Called",UVM_LOW)
	mon.vif=vif;
	mon_ap=mon.mon_ap;
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		drv.vif=vif;
		drv.seq_item_port.connect(sqr.seq_item_export);
	end
	// Add user connect here
	//e.g. TLM  interface connect
	// User connect ends
endfunction

task ${agent_name}_agent::run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_name(),"Run Phase is Called",UVM_LOW)

    forever begin
        @(negedge mon.vif.rst_n);
	    if(agt_cfg.is_active == 1)begin
	        drv.handle_reset(phase);
	    end
        if(sqr != null)begin
            sqr.handle_reset(phase);
        end
        @(posedge mon.vif.rst_n);

	// Add user logic here
    end
	// User logic ends
endtask


`endif



	
	
	