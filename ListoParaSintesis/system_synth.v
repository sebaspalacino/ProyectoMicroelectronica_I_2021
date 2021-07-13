`include "concatenador_verifier.v"
`include "micro_hash.v"

module system(
	input clk, reset, selector,
	input [11:0]  [7:0] data_entry_12  , 
	input [3:0] [7:0]  data_nonce ,
	input [7:0] data_target);
	//input hash_done,
	//input  [2:0] [7:0] data_out_cond); //Poner parentesis juntos atras

wire wclk,wreset, wselector;
wire [11:0] [7:0] w_data_entry_12 ;
wire [3:0] [7:0] w_data_nonce ;
wire [7:0] w_target;
wire [2:0] [7:0] w_data_out_cond ; 
wire [15:0] [7:0] w_block ;
wire HASH_done;

assign wclk = clk;
assign wreset = reset;
assign wselector = selector;
assign w_data_entry_12 = data_entry_12;
assign w_data_nonce = data_nonce;
assign w_target = data_target;

concatenador_verifier concatenador(.clk	(wclk),
			       .reset	(wreset),
			       .selector (wselector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));


micro_hash hash(.clk	(wclk),
		 .reset (wreset),
		 .block (w_block),
		 .target (w_target),
		 .hash_done	(HASH_done),
		 .H_out (w_data_out_cond));



endmodule
	
