/*

 uRV - a tiny and dumb RISC-V core
 Copyright (c) 2015 twl <twlostow@printf.cc>.

 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 3.0 of the License, or (at your option) any later version.

 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public
 License along with this library.

*/

`include "urv_defs.v"
`include "logger.svh"

`timescale 1ns/1ps

`define CFG_WITH_HW_MULH  'h1
`define CFG_WITH_HW_DIV   'h2
`define CFG_WITH_HW_DEBUG 'h4
`define CFG_WITH_COMPRESSED_INSNS 'h8

module ICpuTestWrapper
(
 input clk_i
  );

   reg rst = 1;
   
   
   reg r_with_hw_mulh = 0;
   reg r_with_hw_divide = 0;
   reg r_with_hw_debug = 0;

   reg irq = 0;
   
   parameter int n_configs = 8;
   parameter int mem_size = 16384;
   
   wire [31:0] im_addr_m[n_configs];
   wire [31:0] dm_addr_m[n_configs];
   wire [31:0] dm_data_s_m[n_configs];
   wire [3:0]  dm_data_select_m[n_configs];
   wire        dm_write_m[n_configs];
   wire        irq_m[n_configs];

   int 	       r_active_cpu = 0;
   

   reg [31:0] im_addr;
   reg [31:0] im_data;
   reg        im_valid;

   reg [31:0] dm_addr;
   reg [31:0] dm_data_s;
   reg [31:0] dm_data_l;
   reg [3:0]  dm_data_select;
   reg        dm_write;
   reg 	       dm_valid_l = 1;
   reg        dm_ready;

   reg [31:0]  mem[0:mem_size - 1];

   string current_msg;
   int 	  test_complete = 0;

   task automatic selectConfiguration( int mask );
      r_active_cpu = mask;
   endtask // selectConfiguration
   

   function automatic string getConfigurationString();
      automatic string rv;
      
      if( r_active_cpu & `CFG_WITH_HW_MULH )
	rv = {rv, "hw_mulh"};
      if( r_active_cpu & `CFG_WITH_HW_DIV )
	rv = {rv, " hw_div"};
      if( r_active_cpu & `CFG_WITH_HW_DEBUG )
	rv = {rv, " hw_debug"};

      return rv;
      
   endfunction // getConfigurationString
   
   
   task automatic runTest(string filename);
      int f = $fopen(filename,"r");
      int n, i;

      current_msg = "";
      test_complete = 0;
      
      rst <= 1;
      @(posedge clk_i);
      @(posedge clk_i);

      if( f == 0)
	begin
	   $error("can't open: %s", filename);
	   $stop;
	end

      while(!$feof(f))
        begin
           int addr, data, r;
           string cmd;

           r = $fscanf(f,"%s %08x %08x", cmd,addr,data);

	   if ( r < 0 )
	     break;
	   
           if(cmd == "write")
             begin
                mem[addr % mem_size] = data;
             end

        end
      $fclose(f);
      
      @(posedge clk_i);
      rst <= 0;
      @(posedge clk_i);

   endtask // runProgram

   function automatic string getTestResult();
      return current_msg;
   endfunction // getTestResult

   function automatic int isTestComplete();
      return test_complete;
   endfunction // isTestComplete
   

   int seed = 0;
   

   always@(posedge clk_i)
     begin
        //  Read memory for insn
	if(   $dist_uniform(seed, 0, 100 ) <= 100) begin
	   im_data <= mem[(im_addr / 4) % mem_size];
	   im_valid <= 1;
	end else
	   im_valid <= 0;

        //  Write data memory
	if(dm_write && dm_data_select[0])
	  mem [(dm_addr / 4) % mem_size][7:0] <= dm_data_s[7:0];
	if(dm_write && dm_data_select[1])
	  mem [(dm_addr / 4) % mem_size][15:8] <= dm_data_s[15:8];
	if(dm_write && dm_data_select[2])
	  mem [(dm_addr / 4) % mem_size][23:16] <= dm_data_s[23:16];
	if(dm_write && dm_data_select[3])
	  mem [(dm_addr / 4) % mem_size][31:24] <= dm_data_s[31:24];

        //  Read data memory
        dm_ready <= 1'b1; // $dist_uniform(seed, 0, 100 ) <= 50;
	dm_data_l <= mem[(dm_addr/4) % mem_size];
     end // always@ (posedge clk)


   
   genvar      i;

   
   
   generate
      for(i = 0; i < n_configs; i++)
	begin
	   urv_cpu 
	      #(
		.g_with_hw_mulh( i & `CFG_WITH_HW_MULH ? 1 : 0 ),
		.g_with_hw_div( i & `CFG_WITH_HW_DIV ? 1 : 0 ),
		.g_with_hw_debug( i & `CFG_WITH_HW_DEBUG ? 1 : 0 )
		)
		DUTx
	      (
	       .clk_i(i == r_active_cpu ? clk_i : 1'b0 ),
	       .rst_i(i == r_active_cpu ? rst : 1'b1 ),

	       .irq_i ( irq ),

	       // instruction mem I/F
	       .im_addr_o(im_addr_m[i]),
	       .im_data_i(im_data),
	       .im_valid_i(im_valid),

	       // data mem I/F
	       .dm_addr_o(dm_addr_m[i]),
	       .dm_data_s_o(dm_data_s_m[i]),
	       .dm_data_l_i(dm_data_l),
	       .dm_data_select_o(dm_data_select_m[i]),
	       .dm_store_o(dm_write_m[i]),
	       .dm_load_o(),
	       .dm_store_done_i(1'b1),
	       .dm_load_done_i(1'b1),
	       .dm_ready_i(dm_ready),

	       // Debug
	       .dbg_force_i(1'b0),
	       .dbg_enabled_o(),
	       .dbg_insn_i(32'h0),
	       .dbg_insn_set_i(1'b0),
	       .dbg_insn_ready_o(),

	       // Debug mailbox
	       .dbg_mbx_data_i(0),
	       .dbg_mbx_write_i(1'b0),
	       .dbg_mbx_data_o()
	       );
	end // for (i = 0; i < n_configs; i++)
   endgenerate

   always@*
     begin
	im_addr <= im_addr_m[r_active_cpu];
	dm_addr <= dm_addr_m[r_active_cpu];
	dm_data_s <= dm_data_s_m[r_active_cpu];
	dm_data_select <= dm_data_select_m[r_active_cpu];
	dm_write <= dm_write_m[r_active_cpu];
     end
   
   
   always@(posedge clk_i)
     if(dm_write)
       begin
	  automatic bit [7:0] chr = dm_data_s[7:0];
	  
	  if(dm_addr == 'h100000)
	    begin
	       current_msg = $sformatf("%s%c", current_msg, chr);
	    end
	  else if(DUT.dm_addr == 'h100004)
	    begin
	       test_complete = 1;
	    end
       end
   
endmodule // ICpuTestWrapper




module main;


   reg clk = 0;

   always #5ns clk <= ~clk;

   ICpuTestWrapper DUT ( clk );

class ISATestRunner extends LoggerClient;

   typedef enum 
		{
		 R_OK = 0,
		 R_FAIL = 1,
		 R_TIMEOUT = 2
		 } TestStatus;
   
   
   const time 	c_test_timeout = 1ms;

   task automatic runTest(string filename, ref TestStatus  status, ref int failedTest );
      automatic time t_start = $time;

      DUT.runTest(filename);

      failedTest = 0;
      
      while(!DUT.isTestComplete() )
	begin
	   #1us;
	   if ( $time - t_start > c_test_timeout )
	     begin
		status = R_TIMEOUT;
		return;
	     end
	end

      if ($sscanf( DUT.getTestResult(), "Test %d failed", failedTest ) == 1)
	status = R_FAIL;
      else
	status = R_OK;
   endtask // runTest

   task automatic runAllTests( string test_dir, string list_file );
      automatic string tests[$];
      automatic int n, i, f, failCount = 0;
      automatic string  failedTests = "";
      
      
      f = $fopen( $sformatf("%s/%s", test_dir, list_file ) ,"r");

      while(!$feof(f))
        begin
           automatic string fname;

           void'($fscanf(f,"%s", fname));
	   
	   tests.push_back(fname);
        end

      for (i=0;i<tests.size();i++)
	begin
	   automatic int failedTest;
	   automatic TestStatus status;
	   automatic string s;
	   
           if (tests[i][0] == "#" || tests[i] == "")
             continue;

	   runTest({test_dir,"/",tests[i]}, status, failedTest );
	   
	   if ( status == R_OK )
	     s = "PASS";
	   else if ( status == R_TIMEOUT )
	     begin
		s = "Timeout (likely fail due to CPU freeze)";
		failCount++;
	     end else begin
		s = $sformatf ("FAIL (subtest %d)", failedTest );
		failCount++;
	     end
	   
	   msg(0, $sformatf("%s: %s", tests[i], s ) );
	   
	end

      if(failCount)
	fail ( $sformatf( "%d tests FAILED", failCount ) );
      else
	pass();

   endtask // runAllTests

endclass // ISATestRunner


   const int n_configs = 8;
   
   
   initial begin
      automatic int i;
      automatic ISATestRunner testRunner = new;
      automatic Logger l = Logger::get();

      for(i=0;i<=7;i++)
	begin
	   DUT.selectConfiguration(i);
	   
	   l.startTest($sformatf( "Full ISA Test for feature set [%s]", DUT.getConfigurationString() ) );
	   
	   testRunner.runAllTests("../../sw/testsuite/isa", "tests.lst" );
	end

      l.writeTestReport("report.txt");
      
   end


endmodule // main
