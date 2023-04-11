
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright Houmo.Ai , All right reserved world wide
//
// * Author         : beng.jiang
// * Create time    : 2023-04-11
// * FileName       : add_in_agent_cfg
//
// * Description    : This interface contains the add_in interface signals.
//      It is instantiated once per add_in bus.  Bus Functional Models,
//      BFM's named add_in_driver, are used to drive signals on the bus.
//      BFM's named add_in_monitor are used to monitor signals on the
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

interface add_in_interface (input logic clk, input logic rst_n);


    clocking drv_cb @(posedge clk);


    endclocking

    clocking mon_cb @(posedge clk);

    endclocking




// Add user logic here
//e.g. assign initial assert
// User logic ends
endinterface