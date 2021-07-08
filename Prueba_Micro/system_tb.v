`timescale 	1s	/ 100ps
`include "concatenador.v"
`include "hash.v"
`include "system.v"


module system_tb;

wire clk,reset, selector;
wire [95:0] w_data_entry_12;
wire [31:0] w_data_nonce;
wire [7:0] w_target;
wire [23:0] w_data_out_cond; 
wire [127:0] w_block;

system	system(.clk	(clk),
		.reset	(reset),
		.selector (selector),
		.data_entry_12	(w_data_entry_12),
		.data_nonce (w_data_nonce),
		.data_target (w_target),
		.data_out_cond (w_data_out_cond));



concatenador concatenador(.clk	(clk),
			       .reset	(reset),
			       .selector (selector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));


hash hash(.clk	(clk),
		 .reset (reset),
		 .block (w_block),
		 .target (w_target),
		 .H_out (w_data_out_cond));
		 
endmodule		 
