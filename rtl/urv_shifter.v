/*
--------------------------------------------------------------------------------
-- CERN BE-CO-HT
-- uRV - a tiny and dumb RISC-V core
-- https://www.ohwr.org/projects/urv-core
--------------------------------------------------------------------------------
--
-- unit name:   urv_shifter
--
-- description: uRV shifter unit
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

`define reverse_bits(x) { \
		  x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], \
		  x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], \
		  x[16], x[17], x[18], x[19], x[20], x[21], x[22], x[23], \
		  x[24], x[25], x[26], x[27], x[28], x[29], x[30], x[31] }

module urv_shifter
    (
     input 	       clk_i,
     input 	       rst_i,

     input 	       x_stall_i,

     input 	       d_valid_i,
     input [31:0]      d_rs1_i,
     output reg [31:0] w_rd_o,

     input [4:0]       d_shamt_i,
     input [2:0]       d_fun_i,
     input 	       d_shifter_sign_i
   );

   wire 	 extend_sign = ((d_fun_i == `FUNC_SR) && d_shifter_sign_i) ? d_rs1_i[31] : 1'b0;

   reg [31:0] shift_pre, shift_16, shift_8, s1_out;

   // stage 1
   always@*
     begin
	shift_pre <= (d_fun_i == `FUNC_SL) ? `reverse_bits(d_rs1_i) : d_rs1_i;
	shift_16 <= d_shamt_i[4] ? { {16{extend_sign}}, shift_pre[31:16] } : shift_pre;
	shift_8 <= d_shamt_i[3] ? { {8{extend_sign}}, shift_16[31:8] } : shift_16;
     end

   reg s2_extend_sign;
   reg [4:0] s2_shift;
   reg [2:0] s2_func;



   // stage 1 pipe register
   always@(posedge clk_i)
     if (!x_stall_i)
       begin
	  s2_extend_sign <= extend_sign;
	  s2_shift <= d_shamt_i;
	  s2_func <= d_fun_i;
	  s1_out <= shift_8;
       end

   reg [31:0] shift_4, shift_2, shift_1, shift_post;

   // stage 2
   always@*
     begin
	shift_4 <= s2_shift[2] ? { {4{s2_extend_sign}}, s1_out[31:4] } : s1_out;
	shift_2 <= s2_shift[1] ? { {2{s2_extend_sign}}, shift_4[31:2] } : shift_4;
	shift_1 <= s2_shift[0] ? { {1{s2_extend_sign}}, shift_2[31:1] } : shift_2;
	shift_post <= (s2_func == `FUNC_SL) ? `reverse_bits(shift_1) : shift_1;
     end

   always@*
     w_rd_o <= shift_post;

endmodule // urv_shifter
