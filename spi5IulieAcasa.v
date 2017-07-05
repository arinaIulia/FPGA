`define RST 2'b00;
`define IDLE 2'b01;
`define RUNNING 2'b10;
module spi5IulieAcasa(input reset,
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
		          if(enable==0)
		            state<=`IDLE;
		            else state<=`RST;
		        end    
		  
		  `IDLE: begin 
		            if(cpol==0)
		              begin 
		                if(cph==0)
		                  always@(posedge clock)
		                    begin
		                      sclk<=cpol;
		                      clk_div_counter<=0;
		                      state<=`RUNNING;
		                    end  
		                else always@(negedge clock)
		                    state<=`RUNNING;
		                end 
              else begin
                    if(cph==0)
                      always@(negedge clock)
                        state<=`RUNNING;
                    else always@(posedge clock)
                        state<=`RUNNING;
                      end 
              
              
      `RUNNING: if(dataIn[0]!=miso)
                begin 
                  if(clk_div_counter==clk_div)
                    begin 
                      sclk<=~cpol;
                      mosi<=dataOut[6];
                      dataIn[7]<=miso;//nu stiu unde sa pun mosi<=dataOut[7]-> adica sa introduc in slave 
                      // prima valoare
                      clk_div_counter<=0;
                       
                    end
                 
                  else clk_div_counter=clk_div_counter+1;
                end 
                
                //luam ultimul caz cu miso=dataIn[1];
                //cand trebuie sa transmit ultimul bit din slave in master
              else begin
                      if(clk_div_counter==clk_div)
                    
                      state<=`IDLE;
                       
                  
                 
                  else begin 
                       clk_div_counter=clk_div_counter+1;
                       state<=`RUNNING;
                       end
                       
                   end   
      default: state<=`RST;
    endcase 
    
  end
end

endmodule