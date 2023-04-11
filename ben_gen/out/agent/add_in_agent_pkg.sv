
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

`ifndef ADD_IN_PKG__SV
`define ADD_IN_PKG__SV
`include "add_in_interface.sv"
package add_in_pkg;

    import uvm_pkg::*;
    import hm_base_pkg::*;
    parameter int add_width ;

    `include "add_in_item.svh"
    `include "add_in_agent_cfg.svh"
    `include "add_in_driver.svh"
    `include "add_in_monitor.svh"
    `include "add_in_sequencer.svh"
    `include "add_in_agent.svh"

endpackage: add_in_pkg
`endif
