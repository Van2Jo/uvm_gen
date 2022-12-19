<%
MODULE = attributes['module_name']
USER = attributes['user_name']
DATE = attributes['date']
vip =  attributes['vip']
%>
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author: ${USER}
//date: ${DATE}
//Contents:${MODULE}_env
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  ***** 
interface ${MODULE}_${agent_name}_inf#(
{%-for param in param_list-%}
	{{param.type}} {{param.key}}={{param.value}}
	{%-if not loop.last-%},{%endif%}
{%-endfor-%})(
{%-for port in clk_rst-%} 
	{{port.direction}} logic {{port.bit_info}} {{port.name}}
	{%-if not loop.last-%},{%endif%}
{%-endfor-%});

{%for port in port_list-%}
	logic {{port.bit_info}} {{port.name}};
{%endfor%}

modport ${MODULE}_${agent_name}_dut(
{%for port in clk_rst+port_list-%}
	{{port.direction}} {{port.name}}
	{%-if not loop.last-%},{%endif%}
{%endfor%});

modport ${MODULE}_${agent_name}_driver(
{%for port in clk_rst+port_list-%}
	{%-if port not in port_list-%} {{port.direction}} {{port.bit_info}} {{port.name}}
	{%-elif port.direction=="input"-%} output {{port.name}}{#port in port_list and direction=input #} 
	{%-elif port.direction=="output"-%} input {{port.name}}{#port in port_list and direction=output #} 	
	{%-else-%} {{port.direction}} {{port.name}}
	{%-endif-%}
	{%-if not loop.last-%},{%endif%}
{%endfor%});

modport ${MODULE}_${agent_name}_monitor(
{%for port in clk_rst+port_list-%}
	input {{port.name}}
	{%-if not loop.last-%},{%endif%}
{%endfor%});


// Add user logic here
//e.g. assign initial assert
// User logic ends
endinterface