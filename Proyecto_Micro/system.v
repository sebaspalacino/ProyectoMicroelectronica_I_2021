module system(
	output reg clk, reset, selector,
	output reg  data_entry_12 [7:0] [11:0], 
	output reg  data_nonce [7:0] [3:0],
	output reg [7:0] data_target,
	input  data_out_cond [7:0] [2:0]); //Poner parentesis juntos atras


initial begin
  		$dumpfile("result.vcd");	// Nombre de archivo del "dump"
  		$dumpvars;			// Directiva para "dumpear" variables
  		// Mensaje que se imprime en consola una vez
  		$display ("\t\tclk\treset\tselector\tdata_entry_12\tdata_nonce\tdata_target\tdata_out_cond");
  		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
  		$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b\t%b\t%b\t\t%d", clk, reset, selector, data_entry_12, data_nonce, data_target, data_out_cond);
  		reset <= 1'b0;
		selector <= 1'b0;
		data_entry_12   <=0;
		data_nonce <=0;
		/*
		data_entry_12[0] <=8'h0;
		data_entry_12[1] <=8'h0;
		data_entry_12[2] <=8'h0;
		data_entry_12[3] <=8'h0;
		data_entry_12[4] <=8'h0;
		data_entry_12[5] <=8'h0;
		data_entry_12[6] <=8'h0;
		data_entry_12[7] <=8'h0;
		data_entry_12[8] <=8'h0;
		data_entry_12[9] <=8'h0;
		data_entry_12[10] <=8'h0;
		data_entry_12[11] <=8'h0;
		data_nonce[0] <= 8'h0;
		data_nonce[1] <= 8'h0;
		data_nonce[2] <= 8'h0;
		data_nonce[3] <= 8'h0;
		*/
		data_target <= 8'h0;
		
		@(posedge clk);
		reset <= 1'b1;
		@(posedge clk);
		selector <= 1'b1;
		data_entry_12   <= {8'h39, 8'h7d, 8'h9f, 8'h2f, 8'h40, 8'hca, 8'h9e, 8'h6c, 8'h6b, 8'h1f, 8'h33, 8'h24};
		data_nonce <= {8'hfd, 8'hed, 8'h87, 8'h3c};
		/*
		data_entry_12[0] <=8'h39;
		data_entry_12[1] <=8'h7d;
		data_entry_12[2] <=8'h9f;
		data_entry_12[3] <=8'h2f;
		data_entry_12[4] <=8'h40;
		data_entry_12[5] <=8'hca;
		data_entry_12[6] <=8'h9e;
		data_entry_12[7] <=8'h6c;
		data_entry_12[8] <=8'h6b;
		data_entry_12[9] <=8'h1f;
		data_entry_12[10] <=8'h33;
		data_entry_12[11] <=8'h24;
		data_nonce[0] <= 8'hfd;
		data_nonce[1] <= 8'hed;
		data_nonce[2] <= 8'h87;
		data_nonce[3] <= 8'h3c;
		*/
		data_target <= 8'hff;
		@(posedge clk);
		
		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		repeat (4) begin
      	@(posedge clk);
       end
      $finish;
  end
  // Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk 	<= ~clk;		// Hace "toggle" cada 2*10ns
endmodule
	
