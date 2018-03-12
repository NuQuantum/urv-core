/*

 uRV - a tiny and dumb RISC-V core
 Copyright (c) 2015 CERN
 Author: Tomasz Włostowski <tomasz.wlostowski@cern.ch>

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

`timescale 1ns/1ps

module urv_fetch
(
 input             clk_i,
 input             rst_i,

 input             f_stall_i,

 //  Instruction memory
 output [31:0]     im_addr_o,
 input [31:0]      im_data_i,
 input             im_valid_i,

 //  Fetched instruction - set on the next cycle.
 output reg        f_valid_o,
 output reg [31:0] f_ir_o,
 output reg [31:0] f_pc_o,

 //  Branch control
 input [31:0]      x_pc_bra_i,
 input             x_bra_i,

 //  Debug mode
 input             dbg_force_i,
 output            dbg_enabled_o,
 input [31:0]      dbg_insn_i,
 output reg        dbg_insn_ready_o,
 input             x_dbg_toggle
);

   reg [31:0] pc;
   reg 	      rst_d;

   reg [31:0]  pc_next;
   reg [31:0]  pc_plus_4;
   reg         dbg_mode;
   reg [2:0]   pipeline_cnt;

   always@*
     if( x_bra_i )
       pc_next <= x_pc_bra_i;
     else if (!rst_d || f_stall_i || !im_valid_i)
       pc_next <= pc;
     else
       pc_next <= pc_plus_4;

   // Start fetching the next instruction
   assign im_addr_o = pc_next;

   assign dbg_enabled_o = dbg_mode;

   always@(posedge clk_i)
     if (rst_i)
       begin
          //  PC = 0 at reset.
	  pc <= 0;
	  pc_plus_4 <= 4;

	  f_ir_o <= 0;
	  f_valid_o <= 0;

          //  Allow to start in debug mode.
          dbg_mode <= dbg_force_i;
          dbg_insn_ready_o <= dbg_force_i;

          pipeline_cnt <= 0;

          //  The instruction won't be valid on the next cycle, as the
          //  instruction memory is registered.
	  rst_d <= 0;
       end
     else
       begin
	  rst_d <= 1;

	  if (!f_stall_i)
            begin
	       f_pc_o <= pc;

               if((dbg_force_i || x_dbg_toggle) && !dbg_mode)
                 begin
                    //  Try to enter in debug mode.
                    f_valid_o <= 0;
                    if (pipeline_cnt == 5)
                      dbg_mode <= 1;
                    else
                      pipeline_cnt <= pipeline_cnt + 1;
                 end
               else if(dbg_mode)
                 begin
                    //  Default: insn not valid
                    f_valid_o <= 0;

                    if (x_dbg_toggle)
                      begin
                         //  Leave debug mode
                         dbg_mode <= 0;
                         pipeline_cnt <= 0;
                         // dbg_insn_ready_o must be 0.
                      end
                    else if (dbg_insn_ready_o)
                      begin
                         f_ir_o <= dbg_insn_i;
                         f_valid_o <= 1;
                         dbg_insn_ready_o <= 0;
                         pipeline_cnt <= 0;
                      end
                    else if (pipeline_cnt == 5)
                      dbg_insn_ready_o <= 1;
                    else
                      pipeline_cnt <= pipeline_cnt + 1;
                 end
               else if(im_valid_i)
                 begin
	            pc_plus_4 <= (x_bra_i ? x_pc_bra_i : pc_plus_4) + 4;
	            f_ir_o <= im_data_i;
	            f_valid_o <= (rst_d && !x_bra_i);
	         end
               else
                 begin// if (i_valid_i)
	            f_valid_o <= 0;
	         end

               pc <= pc_next;
	    end
       end

endmodule // urv_fetch
