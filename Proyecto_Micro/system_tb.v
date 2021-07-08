`timescale 	1s	/ 100ps
`include "concatenador_in.v"
`include "micro_hash.v"
`include "system.v"

module system_tb;

wire clk,reset, selector;
wire [7:0] [11:0] w_data_entry_12 ;
wire [7:0] [3:0] w_data_nonce ;
wire [7:0] w_target;
wire [7:0] [2:0] w_data_out_cond ; 
wire [7:0] [15:0] w_block ;

system	system(.clk	(clk),
		.reset	(reset),
		.selector (selector),
		.data_entry_12	(w_data_entry_12),
		.data_nonce (w_data_nonce),
		.data_target (w_target),
		.data_out_cond (w_data_out_cond));



concatenador_in concatenador(.clk	(clk),
			       .reset	(reset),
			       .selector (selector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));


micro_hash hash(.clk	(clk),
		 .reset (reset),
		 .block (w_block),
		 .target (w_target),
		 .H_out (w_data_out_cond));
		 
endmodule		 
