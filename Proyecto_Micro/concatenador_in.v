module concatenador_in(
	input clk, reset,
	input selector,
	input  entry_12 [7:0] [11:0],
	input  nonce [7:0] [3:0],
	output reg  block_out [7:0] [15:0]);
	
	reg [7:0] i,j,k,s,t;
	
	reg [7:0] hold_entry_12 [11:0];
	reg [7:0] hold_nonce [3:0];
	
always @(posedge clk) begin
	if(~reset)begin
	//Llenamos de 0 los arreglos
		
			entry_12 <=0;
		
			nonce <=0;
		
			block_out <=0;
		
			
	end else begin
	//Con el reset en 1, agarramos los valores de los registros de hold para concatenarlos y pasarselos a la salida
		block_out <= {hold_entry12, hold_nonce};
	end
end

always @(*) begin
	if(~reset) begin
	//Llenamos de 0 los arreglos
		
			hold_entry_12 =0;
		
		
		
			hold_nonce =0;
		
	end else begin
		if(selector==0) begin
		//Llenamos de 0 los arreglos porque el selector es 0 y no nos interesa
		
				hold_entry_12 =0;
			
		
			
				hold_nonce =0;
			
		end else begin
		//Ahora como el selector==1 si podemos bretear en el arroz
			hold_entry_12 = entry_12;
			hold_nonce = nonce;
		end
	end
end	

endmodule
