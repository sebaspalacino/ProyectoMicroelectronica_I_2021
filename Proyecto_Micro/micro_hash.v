module micro_hash(
	input clk, reset,
	//input [95:0] entry_block,
	//input [31:0] entry_nonce,
	//input [127:0] entry,
	input [7:0] [15:0] block ,
	input [7:0] target,
	//output reg [7:0] H0_out, H1_out, H2_out);
	output reg [7:0] [2:0] H_out );
	
	//reg [7:0] e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15;
	reg [7:0] H0,H1,H2;
	reg [7:0] [2:0] H_hold ;
	reg [7:0] a, b, c;
	reg [7:0] k,x;
	reg [7:0] [31:0] W ;
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
		H0 <= 8'h01;
		H1 <= 8'h89;
		H2 <= 8'hfe;	
		W <=0;
		i<=0;
		j<=0;
		t<=0;
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
			i<=0;
			j<=1; //Signal para decirnos que la iteracion se completo
		end
		//i <= i+1;//Actualizamos contador
	//Inicializamos 3 variables
		
	//Iteramos 32 veces
		a <= H0;
		b <= H1;
		c <= H2;
		if(j==0) begin
			k <=0;
			x <=0;
			t <=0;
		end else begin
			if(0<=t<=16)begin
				k <= 8'h99;
				x <= a^b;
			end 
			else if(17<=t<=31)begin
				k <= 8'ha1;
				x <= a | b;
			end
			else if(t>31) begin
				t<=0;
			end
			
			a <= b^c; //Dentro de la iteracion, pero afuera del condicional de j
			b <= c << 4;
			c <= x+k+W[t];
			t <=t+1;
		end
		
		/*
		for(j=0; j<=31; j=j+1) begin //if(inicializacion completa) haga la siguiente iteracion
			if(j<=15) begin
				
				
			end
			else if(16<=j<=31) begin
				
			end
			
		end	*/
		H0 <= H0 + a;
		H1 <= H1 + b;
		H2 <= H2 + c;
		
	end
end

endmodule

	
