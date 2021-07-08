module hash(
input clk, reset,

	input [127:0] entry,
	//input  block [7:0] [15:0],
	input [7:0] target,
	//output reg [7:0] H0_out, H1_out, H2_out);
	output reg [23:0] H_out);
	
	reg [7:0] block [15:0];
	 
	 
	reg [7:0] H0,H1,H2;
	reg [23:0] H_hold;
	reg [7:0] a, b, c;
	reg [7:0] k,x;
	reg [7:0] W [31:0];
	reg [7:0] i, t; //Usar contadores
	reg j; 

always@(posedge clk) begin
	if(~reset) begin
		H_out <= 0;
		block [0] <= entry [127:120];
	 block [1] <= entry [119:112];
	 block [2] <= entry [111:104];
	 block [3] <= entry [103:96];
	 block [4] <= entry [95:88];
	 block [5] <= entry [87:80];
	 block [6] <= entry [79:72];
	 block [7] <= entry [71:64];
	 block [8] <= entry [63:56];
	 block [9] <= entry [55:48];
	 block [10] <= entry [47:40];
	 block [11] <= entry [39:32];
	 block [12] <= entry [31:24];
	 block [13] <= entry [23:16];
	 block [14] <= entry [15:8];
	 block [15] <= entry [7:0];
	end else begin
		
		H_hold <= {H0, H1, H2};
		//Vemos si los dos primeros bytes son menores al target, si lo son, pasa el dato. De lo contrario H_out tira solo 0's
		if((H_hold[23:16] < target) && (H_hold[15:8] < target))begin
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
		H0<=0;
		H1<=0;
		H2<=0;
		W <=0;
		i<=0;
		j<=0;
		t<=0;
	end else begin
	//Inicializamos 32 variables W 
		if(i<=15)begin
			W[i] <= block[i];	
		end 
		
		else if(i<=31) begin
			W[i] = W[i-3] | W[i-9] ^ W[i-14];
		end
		
		else if(i>31) begin
			i<=0;
			j<=1; //Signal para decirnos que la iteracion se completo
		end
		i <= i+1;//Actualizamos contador
	//Inicializamos 3 variables
		H0 <= 8'h01;
		H1 <= 8'h89;
		H2 <= 8'hfe;	
	//Iteramos 32 veces
		a <= H0;
		b <= H1;
		c <= H2;
		if(j==0) begin
			k <=0;
			x <=0;
			t <=0;
		end else begin
			if(t<=16)begin
				k <= 8'h99;
				x <= a^b;
			end 
			else if(t<=31)begin
				k = 8'ha1;
				x = a | b;
			end
			else if(t>31) begin
				t<=0;
			end
			
			a <= b^c; //Dentro de la iteracion, pero afuera del condicional de j
			b <= c << 4;
			c <= x+k+W[t];
			t <=t+1;
		end
		
		
		H0 <= H0 + a;
		H1 <= H1 + b;
		H2 <= H2 + c;
		
	end
end

endmodule	
