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
`ifndef ${agent_upper}_AGENT_SV
`define ${agent_upper}_AGENT_SV
class ${agent_name}_agent extends uvm_agent;

	`uvm_component_utils(${agent_name}_agent)

	//Config	//Interface
	${agent_name}_agent_config agt_cfg;
	virtual ${agent_name}_inf ${agent_name}_inf;
	
	//TLM 
	uvm_analysis_port#(${agent_name}_req) mon_ap;
	
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
	
	{{method}}
	// Add user method here
	// e.g. task function
	// User method ends
endclass

function void ${agent_name}_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(),"Build Phase is Called",UVM_LOW)
	if(!uvm_config_db#(${agent_name}_agent_config)::get(this,"","agt_cfg",agt_cfg))
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
	mon.${agent_name}_inf=${agent_name}_inf;
	mon_ap=${agent_name}_mom.mon_ap;
	if (agt_cfg.is_active==UVM_ACTIVE)
	begin
		drv.${agent_name}_inf=${agent_name}_inf;
		drv.seq_item_port.connect(${agent_name}_sqr.seq_item_export);
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
	    if(drv.is_active == 1)begin
	        drv.handle_reset(phase);
	    end
        if(sqr != null)begin
            sqr.handle_reset(phase)
        end
        @(posedge mon.vif.rst_n)

	// Add user logic here

	// User logic ends
endtask


`endif



	
	
	