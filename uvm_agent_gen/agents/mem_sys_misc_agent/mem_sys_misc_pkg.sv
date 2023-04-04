
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

`ifndef MEM_SYS_MISC_PKG__SV
`define MEM_SYS_MISC_PKG__SV
`include "mem_sys_misc_interface.sv"
package mem_sys_misc_pkg;

    import uvm_pkg::*;

    `include "mem_sys_misc_item.sv"
    `include "mem_sys_misc_driver.sv"
    `include "mem_sys_misc_monitor.sv"
    `include "mem_sys_misc_sequencer.sv"
    `include "mem_sys_misc_agent_cfg.sv"
    `include "mem_sys_misc_agent.sv"

endpackage: mem_sys_misc_pkg
`endif
 