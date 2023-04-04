
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-01-11
// * FileName       : mem_sys_misc_agent_cfg
// * Description    :
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

interface mem_sys_misc_interface (input logic clk, input logic rst_n);


    clocking drv_cb @(posedge clk);


    endclocking

    clocking mon_cb @(posedge clk);

    endclocking




// Add user logic here
//e.g. assign initial assert
// User logic ends
endinterface 