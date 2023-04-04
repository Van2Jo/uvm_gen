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

`ifndef ${agent_upper}_PKG__SV
`define ${agent_upper}_PKG__SV
`include "${agent_name}_interface.sv"
package ${agent_name}_pkg;

    import uvm_pkg::*;

    `include "${agent_name}_item.svh"
    `include "${agent_name}_agent_cfg.svh"
    `include "${agent_name}_driver.svh"
    `include "${agent_name}_monitor.svh"
    `include "${agent_name}_sequencer.svh"
    `include "${agent_name}_agent.svh"

endpackage: ${agent_name}_pkg
`endif
