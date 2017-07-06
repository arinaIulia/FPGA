module divizor_06_05_2017(input clk,
					output reg sclk,
					input reset
					
);

reg [7:0] clk_div;

always@(posedge clk)
	 
	if(reset==0)
	begin
		sclk<=0;
		clk_div<=0;
		end
		 //ii dau un reset ca sa am valoarea initiala 
		 // in programul mare ii dau valoarea initiala cu cpol

else if(clk_div<=8'b11111111)
			begin
			sclk=~sclk;
			clk_div<=0;
			end
			else begin 
			 clk_div<=clk_div+1;
			 end
			

endmodule