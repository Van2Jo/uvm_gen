//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
//Auto Generated by UVM-Generator
//Author: Jiacai Yuan
//E-mail: yuan861025184@163.com
//Contents:{{MODULE}}_virtual_sequencer
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
class {{MODULE}}_virtual_sequencer extends uvm_sequencer;
	`uvm_component_utils({{MODULE}}_virtual_sequencer)
	//Config
	{{MODULE}}_env_config env_cfg;
	
	//Sequencer
{%-for agt in agt_list%}
	{{MODULE}}_{{agt.name}}_sequencer {{agt.name}}_sqr; 
{%-endfor%}

	//Constructor Function
	function new(string name="{{MODULE}}_virtual_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	{{method}}
	// Add user method here
	//e.g. task function
	// User method ends
endclass

