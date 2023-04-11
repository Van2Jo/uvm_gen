<%
agent_upper = agent_name.upper()
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright ${inst} , All right reserved world wide
//
// * Author         : ${user}
// * Create time    : ${date}
// * FileName       : ${agent_name}_agent_cfg
//
// * Description    : This interface contains the ${agent_name} interface signals.
//      It is instantiated once per ${agent_name} bus.  Bus Functional Models,
//      BFM's named ${agent_name}_driver, are used to drive signals on the bus.
//      BFM's named ${agent_name}_monitor are used to monitor signals on the
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

interface ${agent_name}_interface (input logic clk, input logic rst_n);


    clocking drv_cb @(posedge clk);


    endclocking

    clocking mon_cb @(posedge clk);

    endclocking




// Add user logic here
//e.g. assign initial assert
// User logic ends
endinterface