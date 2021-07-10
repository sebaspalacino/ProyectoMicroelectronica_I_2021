`timescale 	1s	/ 100ps
//`include "concatenador_in.v"
`include "concatenador_verifier.v"
`include "micro_hash.v"
`include "system.v"

module system_tb;

wire clk,reset, selector;
wire [11:0] [7:0] w_data_entry_12 ;
wire [3:0] [7:0] w_data_nonce ;
wire [7:0] w_target;
wire [2:0] [7:0] w_data_out_cond ; 
wire [15:0] [7:0] w_block ;
wire HASH_done;

system	system(.clk	(clk),
		.reset	(reset),
		.selector (selector),
		.data_entry_12	(w_data_entry_12),
		.data_nonce (w_data_nonce),
		.data_target (w_target),
		.hash_done	(HASH_done),
		.data_out_cond (w_data_out_cond));


/*
concatenador_in concatenador(.clk	(clk),
			       .reset	(reset),
			       .selector (selector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));
			       */

concatenador_verifier concatenador(.clk	(clk),
			       .reset	(reset),
			       .selector (selector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));


micro_hash hash(.clk	(clk),
		 .reset (reset),
		 .block (w_block),
		 .target (w_target),
		 .hash_done	(HASH_done),
		 .H_out (w_data_out_cond));
		 
endmodule		 
