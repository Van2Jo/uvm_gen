//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
//Auto Generated by UVM-Generator
//Author: Jiacai Yuan
//E-mail: yuan861025184@163.com
//Contents:{{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter 
//         {{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_predictor
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class {{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter extends uvm_reg_adapter;

	`uvm_object_utils({{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter)

	//Config
	{{MASTER_SLAVE_BUS}}_ral_config reg_adp_cfg;
	
	//default attributes
	//bit provides_responses=0
	//bit supports_byte_enable=0
	
	//Constructor Function
	function new(string name="{{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter");
		super.new(name);
	{%-if response%}
		provides_responses=1;
	{%-endif%}
	endfunction
	
	// Methods
	extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
	extern virtual function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);	
	{{adp_method}}
	// Add user method here
	//e.g. task function
	// User method ends
endclass


function uvm_sequence_item {{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter::reg2bus(const ref uvm_reg_bus_op rw);
	//Add user logic here
	//e.g. rw.addr,rw.data,rw.kind,rw.b_bits,rw.byte_en,rw.status
	// User logic ends
endfunction
	
function void {{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_adapter::bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
	//Add user logic here
	//e.g. rw.addr,rw.data,rw.kind,rw.b_bits,rw.byte_en,rw.status
	// User logic ends
endfunction

{%if not ral.auto_predict%}
class {{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_predictor extends uvm_reg_predictor#({{MASTER_SLAVE_BUS}}_req);
	`uvm_component_utils({{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_predictor)
	//Constructor Function
	function new(string name="{{MODULE}}_{{MASTER_SLAVE_BUS}}_reg_predictor",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	{{prd_method}}
	// Add user method here
	//e.g. task function
	// User method ends
endclass
{%endif%}
