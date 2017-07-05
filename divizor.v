module divizor(input clk,
					output sclk,
					input reset
)

reg [7:0] clk_div;
always@(posedge clock)
	begin 
	if(reset==0)
	begin
		sclk<=0;
		clk_div<=0;
		end
		else 

else if(clk_div<=8'b11111111)
			begin
			slck=~slck;
			clk_div<=0;
			end
			else clk_div=clk_div+1;
			
end

endmodule