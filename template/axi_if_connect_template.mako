<%
num_master = attributes.num_master
num_slave = attributes.num_slave
%>

%for num in range(1,num_master):
if(is_active = 1)begin
    //address write channel
    assign dut.awvaild_m${num}   = axi_if.master_if[${num-1}].awvalid  ;
    assign dut.awaddr_m${num}    = axi_if.master_if[${num-1}].awaddr   ;
    assign dut.awid_m${num}      = axi_if.master_if[${num-1}].awid     ;
    assign dut.awlen_m${num}     = axi_if.master_if[${num-1}].awlen    ;
    assign dut.awsize_m${num}    = axi_if.master_if[${num-1}].awsize   ;
    assign dut.awburst_m${num}   = axi_if.master_if[${num-1}].awburst  ;
    assign dut.awlock_m${num}    = axi_if.master_if[${num-1}].awlock   ;
    assign dut.awcache_m${num}   = axi_if.master_if[${num-1}].awcache  ;
    assign dut.awprot_m${num}    = axi_if.master_if[${num-1}].awprot   ;
    assign axi_if.master_if[${num}-1].awready      =   awready_m${num}  ;
    //write channel

    //address read channel

    //data read channel

else begin

end
%endfor
