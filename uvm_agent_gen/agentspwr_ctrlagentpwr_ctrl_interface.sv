
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: beng.jiang
//date: 2022-12-23
//Contents:pwr_ctrl_interface
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

interface pwr_ctrl_interface (input logic clk, input logic rst_n);


    clocking drv_cb @(posedge clk);


    endclocking

    clocking mon_cb @(posedge clk);

    endclocking




// Add user logic here
//e.g. assign initial assert
// User logic ends
endinterface 