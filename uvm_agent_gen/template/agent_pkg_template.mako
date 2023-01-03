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
//Contents:${agent_name}_pkg
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

`ifndef ${agent_upper}_PKG__SV
`define ${agent_upper}_PKG__SV
`include "${agent_name}_interface.sv"
package ${agent_name}_pkg;

    import uvm_pkg::*;

    `include "${agent_name}_item.sv"
    `include "${agent_name}_driver.sv"
    `include "${agent_name}_monitor.sv"
    `include "${agent_name}_sequencer.sv"
    `include "${agent_name}_agent_cfg.sv"
    `include "${agent_name}_agent.sv"

endpackage: ${agent_name}_pkg
`endif
