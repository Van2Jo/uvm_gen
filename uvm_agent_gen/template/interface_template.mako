<%
agent_name = attributes['agent_name']
USER = attributes['user_name']
DATE = attributes['date']
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: ${USER}
//date: ${DATE}
//Contents:${agent_name}_interface
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