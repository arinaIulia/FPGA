`define RST 2'b00;
`define IDLE 2'b01;
`define RUNNING 2'b10;
module spi5IulieLaborator(input reset,
            input enable,
            input busy,
            input ss,
            input clk,
            output sclk,
            input [7:0] clk_div,
            input miso,
            input [7:0] dataIn,
            output mosi,
            output [7:0] dataOut
);
  reg [7:0] clk_div_counter;
  reg [1:0] state;
  always@(posedge clock) begin
	if(reset==0) begin
		state <= `RST;
	end else begin
		case(state)
		  `RST: begin 
		          if(reset==0)
		            state<=`RST;
		            else state<=`IDLE;
		        end    
		  
		  `IDLE: begin 
						if(enable==0)
							state<=`IDLE;
						else state<=`RUNNING;
					end
              
      `RUNNING: begin
						if((cpol==0)&&(cpha==0))
							
					end		
      default: state<=`RST;
    endcase 
    
  end
end

endmodule