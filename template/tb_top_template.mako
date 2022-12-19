<%
module = attributes['module_name']
ueser = attributes['user_name']
date = attributes['date']
module_upper = attributes['module_name'].upper()

%>

//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****
//Copyright
//Author        : ${user}
//Create date   : ${date}
//FileName      :tb_top.sv
//***** ***** ***** *****  *****  *****  *****  *****  *****  *****  *****

`timescale 1 ns/1 ps
module tb_top();
    import uvm_pkg::*;
    import ${module}_env_pkg::*;

    bit is_acive = ${is_active};

    //interface
    svt_axi_if axi_if();

    ${module}_top_wrapper u_${module}_top_wrapper();

    //Instance DUT
    ${module} dut();

    //dump fsdb
    initial begin
        $timeformat(-9,5," ns",10);
        if($test$plusargs("DUMP_FSDB"))begin
            if($value$plusargs("FSDB_NAME=%s",fsdb_name))begin
                $fsdbDumpfile(fsdb_name);
            end else begin
                $fsdbDumpfile("wave.fsbd");
            end
            $fsdbDumpvars(0,tv_top,"+mda");
        end
    end

    //Clock and Reset

    bit clk;
    bit reset_n;

    initial begin
        resetn = 1‘h0；
        #${rst_delay_time} reset_n = 1'h1;
    end

    initial begin
        clk = 1'h0;
        forever begin
            #${clk_cycle}/2 ns clk = ~clk;
        end
    end

    //watchdog
    initial begin
        if(!$value$plusargs("TIME_IN_MS=%d",time_in_Ms))begin
            time_in_ms = 1000;
        end
        repeat(time_in_ns) #1ms;
        $display("Time = $t, FATAL ,SIMULATION time reach %0d , i suppose this test failed",$time, time_in_us);
        $finish
    end

