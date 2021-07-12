/*
module concatenador_in(
	input clk, reset,
	input selector,
	input [11:0] [7:0] entry_12 ,
	input [3:0] [7:0] nonce ,
	output reg [15:0] [7:0]  block_out);
	
	reg [7:0] i,j,k,s,t;
	
	reg [11:0] [7:0] hold_entry_12 ;
	reg [3:0] [7:0] hold_nonce ;
	
always @(posedge clk) begin
	if(~reset)begin
	//Llenamos de 0 los arreglos
			block_out <=0;		
	end else begin
	//Con el reset en 1, agarramos los valores de los registros de hold para concatenarlos y pasarselos a la salida
		block_out <= {hold_nonce, hold_entry_12};
		//block_out <= { hold_entry_12, hold_nonce};
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

*/

// Code your design here
module micro_hash(
	input clk, reset,
	//input [95:0] entry_block,
	//input [31:0] entry_nonce,
	//input [127:0] entry,
  //OSCAR: primero va el index [15:0] luego el tamanno de un byte 7:0
    input [15:0] [7:0] block,
	input [7:0] target,
  	output reg hash_done,
	//output reg [7:0] H0_out, H1_out, H2_out);
    output reg [2:0] [7:0] H_out );
	
	//reg [7:0] e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15;
	reg [7:0] H0,H1,H2;
	reg [7:0] [2:0] H_hold ;
	reg [7:0] a, b, c;
	reg [7:0] k,x;
        reg [31:0] [7:0] W ;
	reg [7:0] i, t; //Usar contadores
	reg j;
  
always@(posedge clk) begin
	if(~reset) begin
		H_out <= 0;
		
	end else begin
		//H0_out <= H0;
		//H1_out <= H1;
		//H2_out <= H2;
		H_hold <= {H0, H1, H2};
		//Vemos si los dos primeros bytes son menores al target, si lo son, pasa el dato. De lo contrario H_out tira solo 0's
		if((H_hold[0] < target) && (H_hold[1] < target))begin
			H_out <= H_hold;
		end else begin
			H_out <=0;
		end
	end
end

always@(posedge clk) begin //Cambiar asignaciones
	if(~reset) begin
		//for(i=0; i<=31; i=i+1) begin //inicializacion en 0 al inicio //mismo contador, 
		//	W[i] = 0;
		//end
		a<=0;
		b<=0;
		c<=0;
		k<=0;
		x<=0;
        //OSCAR: estos valores se inicializan una unica vez
		H0 <= 8'h01;
		H1 <= 8'h89;
		H2 <= 8'hfe;	
		W <=0;
		i<=0;
		j<=0;
		t<=0;
        hash_done <= 0;
	end else begin
	//Inicializamos 32 variables W 
	/*
		for(i=0; i<=31; i=i+1) begin //mismo if, si no hay inicializacion
			if(i<=15) begin
				W[i] = block[i];	
			end
			else if(16<=i<=31) begin
				
			end
		end*/
		
		
		if(i<=15)begin
			W[i] <= block[i];
				i <= i+1;
		end 
		
		else if(i<=31) begin
			W[i] = W[i-3] | W[i-9] ^ W[i-14];
			i <= i+1;
		end
		
		else if(i>31) begin
			j<=1; //Signal para decirnos que la iteracion se completo
		end
		//i <= i+1;//Actualizamos contador
	//Inicializamos 3 variables
		
	//Iteramos 32 veces
		if(j==0) begin
			k =0;
			x =0;
			t =0;
            		a = H0;
			b = H1;
			c = H2;
        end 
      else if (~ hash_done) begin
        
			if(t<=16)begin
				k = 8'h99;
				x = a^b;
			end 
			else if(t<=31)begin
				k = 8'ha1;
				x = a | b;
			end
			else begin
				H0 = H0 + a;
				H1 = H1 + b;
				H2 = H2 + c;
              	hash_done = 1;
			end
			
			a = b^c; //Dentro de la iteracion, pero afuera del condicional de j
			b = c << 4;
			c = x+k+W[t];
			t = t+1;
		end
		
		/*
		for(j=0; j<=31; j=j+1) begin //if(inicializacion completa) haga la siguiente iteracion
			if(j<=15) begin
				
				
			end
			else if(16<=j<=31) begin
				
			end
			
		end	*/
	end
end

endmodule

module concatenador_verifier(
	input clk, reset,
	input selector,
	input [11:0] [7:0] entry_12 ,
	input [3:0] [7:0] nonce ,
	output reg [15:0] [7:0]  block_out);
	
	reg [7:0] i,j,k,s,t;
	
	reg [11:0] [7:0] hold_entry_12 ;
	reg [3:0] [7:0] hold_nonce ;
	
	reg entry_valid;
	reg nonce_valid;
	
always @(posedge clk) begin
	if(~reset)begin
	//Llenamos de 0 los arreglos
			block_out <=0;		
	end else begin
	//Con el reset en 1, agarramos los valores de los registros de hold para concatenarlos y pasarselos a la salida
		if(entry_valid==1 && nonce_valid==1)begin
			block_out <= {hold_nonce, hold_entry_12};
		//block_out <= { hold_entry_12, hold_nonce};
		end else begin
			block_out <=0;	
		end
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
				entry_valid =0;	
				hold_nonce =0;
				nonce_valid =0;
			
		end else begin
		//Ahora como el selector==1 si podemos bretear en el arroz
			hold_entry_12 = entry_12;
			entry_valid =1;
			hold_nonce = nonce;
			nonce_valid =1;
		end
	end
end	

endmodule

module system(
	output reg clk, reset, selector,
	output reg [11:0]  [7:0] data_entry_12  , 
	output reg [3:0] [7:0]  data_nonce ,
	output reg [7:0] data_target,
	input hash_done,
	input  [2:0] [7:0] data_out_cond); //Poner parentesis juntos atras


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
		data_entry_12   <= {8'h24, 8'h33,  8'h1f, 8'h6b,8'h6c, 8'h9e, 8'hca,8'h40,8'h2f,8'h9f,8'h7d,8'h39};
		data_nonce <= {8'h3c, 8'h87, 8'hed, 8'hfd};
		//data_entry_12 <= {8'h39, 8'h7d, 8'h9f,8'h2f, 8'h40, 8'hca,  8'h9e, 8'h6c, 8'h6b,8'h1f,  8'h33,8'h24};
		//data_nonce <= {8'hfd, 8'hed, 8'h87, 8'h3c};
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


`timescale 	1s	/ 100ps
//`include "concatenador_in.v"
//`include "concatenador_verifier.v"
//`include "micro_hash.v"
//`include "system.v"

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
