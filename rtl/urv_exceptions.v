/*
--------------------------------------------------------------------------------
-- CERN BE-CO-HT
-- uRV - a tiny and dumb RISC-V core
-- https://www.ohwr.org/projects/urv-core
--------------------------------------------------------------------------------
--
-- unit name:   urv_exceptions
--
-- description: uRV exceptions unit
--
--------------------------------------------------------------------------------
-- Copyright CERN 2015-2018
--------------------------------------------------------------------------------
-- Copyright and related rights are licensed under the Solderpad Hardware
-- License, Version 2.0 (the "License"); you may not use this file except
-- in compliance with the License. You may obtain a copy of the License at
-- http://solderpad.org/licenses/SHL-2.0.
-- Unless required by applicable law or agreed to in writing, software,
-- hardware and materials distributed under this License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
-- or implied. See the License for the specific language governing permissions
-- and limitations under the License.
--------------------------------------------------------------------------------
*/

`include "urv_defs.v"

`timescale 1ns/1ps

module urv_exceptions
  (
   input         clk_i,
   input         rst_i,

   input         x_stall_i,
   input         x_kill_i,

   input         d_is_csr_i,
   input         d_is_mret_i,

   input [4:0]   d_csr_imm_i,
   input [11:0]  d_csr_sel_i,

   input         exp_irq_i,
   input         exp_tick_i,
   input         exp_breakpoint_i,
   input         exp_unaligned_load_i,
   input         exp_unaligned_store_i,
   input         exp_invalid_insn_i,

   input [31:0]  x_csr_write_value_i,

   input         x_exception_i,
   input [3:0]   x_exception_cause_i,

   input [31:0]  x_exception_pc_i,
   output [31:0] x_exception_pc_o,

   output [31:0] csr_mstatus_o,
   output [31:0] csr_mip_o,
   output [31:0] csr_mie_o,
   output [31:0] csr_mepc_o,
   output [31:0] csr_mcause_o
   );


   reg [31:0] 	 csr_mepc;
   reg [31:0]    csr_mie;
   reg 		 csr_ie;

   reg [3:0] 	 csr_mcause;

   reg [5:0] 	 except_vec_masked;

   assign csr_mcause_o = {28'h0, csr_mcause};
   assign csr_mepc_o = csr_mepc;
   assign csr_mie_o = csr_mie;
   assign csr_mstatus_o[0] = csr_ie;
   assign csr_mstatus_o[31:1] = 0;

   assign csr_mip_o = 0;

   always@(posedge clk_i)
     if (rst_i)
       except_vec_masked <= 0;
     else begin
	if(!x_stall_i && !x_kill_i && d_is_csr_i && d_csr_sel_i == `CSR_ID_MIP)
          begin
	     except_vec_masked[4] <= x_csr_write_value_i [`EXCEPT_TIMER];
	     except_vec_masked[5] <= x_csr_write_value_i [`EXCEPT_IRQ];
	  end
        else begin
	   if ( exp_tick_i )
	     except_vec_masked[4] <= csr_mie[`EXCEPT_TIMER] & csr_ie;

	   if( exp_irq_i )
	     except_vec_masked[5] <= csr_mie[`EXCEPT_IRQ] & csr_ie;
	end
     end

   always@(posedge clk_i)
     if(rst_i)
       begin
          csr_mcause <= 0;
	  csr_mepc <= 0;
	  csr_mie <= 0;
	  csr_ie <= 0;
       end
     else
       begin
          if (x_exception_i)
	    begin
	       csr_mepc <= x_exception_pc_i;
	       csr_mcause <= x_exception_cause_i;
	    end

          if (!x_stall_i && !x_kill_i && d_is_csr_i)
	    case (d_csr_sel_i)
	      `CSR_ID_MSTATUS:
		csr_ie <= x_csr_write_value_i[0];
	      `CSR_ID_MEPC:
		csr_mepc <= x_csr_write_value_i;
	      `CSR_ID_MIE:
		begin
		   csr_mie[`EXCEPT_TIMER] <= x_csr_write_value_i[`EXCEPT_TIMER];
		   csr_mie[`EXCEPT_IRQ] <= x_csr_write_value_i[`EXCEPT_IRQ];
		end
	    endcase // case (d_csr_sel_i)
       end // if (d_is_csr_i)


   assign x_exception_pc_o = csr_mepc;

endmodule // urv_exceptions
