onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/clk_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rst_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/x_stall_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/x_kill_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/x_stall_req_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_pc_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_rd_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_fun_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rf_rs1_value_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rf_rs2_value_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_valid_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_opcode_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_shifter_sign_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_csr_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_mret_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_ebreak_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_dbg_mode_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_csr_imm_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_csr_sel_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_imm_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_signed_alu_op_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_add_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_load_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_store_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_divide_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_multiply_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_is_undef_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_alu_op1_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_alu_op2_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_use_op1_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_use_op2_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_rd_source_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/d_rd_write_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/f_branch_target_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/f_branch_take_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/f_dbg_toggle_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/irq_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_fun_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_load_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_store_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_valid_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_value_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_write_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_dm_addr_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_source_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_shifter_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/w_rd_multiply_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_addr_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_data_s_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_data_select_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_store_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_load_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_ready_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_time_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_cycles_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/timer_tick_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dbg_mbx_data_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dbg_mbx_write_i}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dbg_mbx_data_o}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rs1}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rs2}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_op1}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_op2}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_result}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rd_value}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/x_exception}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/x_exception_cause}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/branch_take}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/branch_condition_met}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/branch_target}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_addr}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_data_s}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/dm_select_s}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/cmp_op1}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/cmp_op2}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/cmp_rs}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/cmp_equal}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/cmp_lt}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/f_branch_take}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rd_csr}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rd_mulh}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_mie}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_mip}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_mepc}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_mstatus}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_mcause}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/csr_write_value}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/exception_address}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/exception_vector}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/exception_pc}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_addsub_op1}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_addsub_op2}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/alu_addsub_result}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/divider_stall_req}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/multiply_stall_req}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/rd_divide}
add wave -noupdate -group X4 {/main/DUT/genblk1[3]/DUTx/execute/unaligned_addr}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/clk_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/rst_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/x_stall_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/x_kill_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/x_stall_req_o}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_valid_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_is_divide_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_rs1_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_rs2_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_fun_i}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/x_rd_o}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/q}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/r}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/n}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/n_sign}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/d_sign}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/state}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/alu_result}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/alu_op1}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/alu_op2}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/is_rem}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/r_next}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/alu_sub}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/alu_ge}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/done}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/busy}
add wave -noupdate -expand -group DivX4 {/main/DUT/genblk1[3]/DUTx/execute/genblk1/divider/start_divide}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {921711787 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {425405440 ps} {3291294720 ps}
