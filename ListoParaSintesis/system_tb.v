`timescale 	1s	/ 100ps
//`include "concatenador_in.v"
//`include "concatenador_verifier.v"
//`include "micro_hash.v"
`include "system.v"

module system_tb;

reg clk,reset, selector;
reg [11:0] [7:0] w_data_entry_12 ;
reg [3:0] [7:0] w_data_nonce ;
reg [7:0] w_target;

system	system(.clk	(clk),
		.reset	(reset),
		.selector (selector),
		.data_entry_12	(w_data_entry_12),
		.data_nonce (w_data_nonce),
		.data_target (w_target));

  always 
    #1 clk = !clk;

initial begin
		$dumpfile("result.vcd");	// Nombre de archivo del "dump"
  		$dumpvars;			// Directiva para "dumpear" variables
  		// Mensaje que se imprime en consola una vez
  		//$display ("\t\tclk\treset\tselector\tdata_entry_12\tdata_nonce\tdata_target\tdata_out_cond");
  		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
  		//$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b\t%b\t%b\t\t%d", clk, reset, selector, data_entry_12, data_nonce, data_target, data_out_cond);
		clk <=1'b0;
		reset <= 1'b0;
		selector <= 1'b1;
		w_data_entry_12   <= {8'h24, 8'h33,  8'h1f, 8'h6b,8'h6c, 8'h9e, 8'hca,8'h40,8'h2f,8'h9f,8'h7d,8'h39};
		w_data_nonce <= {8'h3c, 8'h87, 8'hed, 8'hfd};
		w_target <= 8'hff;
		
		#4 reset<=1;
		
		#200;
		
		$finish;
end
endmodule

/*
concatenador_in concatenador(.clk	(clk),
			       .reset	(reset),
			       .selector (selector),
			       .entry_12 (w_data_entry_12),
			       .nonce (w_data_nonce),
			       .block_out (w_block));
			       */
/*
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
		 
		 */
		 
		 
