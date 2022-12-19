

if(is_active = 1)begin
    //address write channel
    assign dut.awvaild_m1   = axi_if.master_if[0].awvalid  ;
    assign dut.awaddr_m1    = axi_if.master_if[0].awaddr   ;
    assign dut.awid_m1      = axi_if.master_if[0].awid     ;
    assign dut.awlen_m1     = axi_if.master_if[0].awlen    ;
    assign dut.awsize_m1    = axi_if.master_if[0].awsize   ;
    assign dut.awburst_m1   = axi_if.master_if[0].awburst  ;
    assign dut.awlock_m1    = axi_if.master_if[0].awlock   ;
    assign dut.awcache_m1   = axi_if.master_if[0].awcache  ;
    assign dut.awprot_m1    = axi_if.master_if[0].awprot   ;
    assign axi_if.master_if[1-1].awready      =   awready_m1  ;
    //write channel

    //address read channel

    //data read channel

else begin

end
if(is_active = 1)begin
    //address write channel
    assign dut.awvaild_m2   = axi_if.master_if[1].awvalid  ;
    assign dut.awaddr_m2    = axi_if.master_if[1].awaddr   ;
    assign dut.awid_m2      = axi_if.master_if[1].awid     ;
    assign dut.awlen_m2     = axi_if.master_if[1].awlen    ;
    assign dut.awsize_m2    = axi_if.master_if[1].awsize   ;
    assign dut.awburst_m2   = axi_if.master_if[1].awburst  ;
    assign dut.awlock_m2    = axi_if.master_if[1].awlock   ;
    assign dut.awcache_m2   = axi_if.master_if[1].awcache  ;
    assign dut.awprot_m2    = axi_if.master_if[1].awprot   ;
    assign axi_if.master_if[2-1].awready      =   awready_m2  ;
    //write channel

    //address read channel

    //data read channel

else begin

end
 