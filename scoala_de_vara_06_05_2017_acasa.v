`define RST 2'b00;
`define IDLE 2'b01;
`define RUNNING 2'b10;
module scoala_de_vara_06_05_2017_acasa(input reset,
            input enable,
            input busy,
            input ss,
            input clk,
            output sclk,
            input cpol,
            input cpha,
            input miso,
            input [7:0] dataIn,
            output mosi,
            output [7:0] dataOut
);
  reg [7:0] clk_div_counter;
  reg [2:0] bit_pentru_scadere_transmisie;//de atribuit zero in starea de reset, pentru ca apoi sa il tot cresc
  reg [1:0] state;
  divizor(.clk(clk),.sclk(sclk),.reset(reset),.cpol(cpol));
  always@(posedge clk) begin
	if(reset==0)
	 begin 
		state <= `RST;
		end
	 else begin
		case(state)
		  `RST: begin 
		          if(reset==0)
		            state<=`RST;
		            else state<=`IDLE;
		        end    
		  
		  //in starea de reset sa pun clk drept z sau x(ca totusi nu il ignor, dar momentan nu ma intereseaza)
		  //???in starea de reset sa pun miso<=dataOut[7], pentru ca apoi sa il folosesc in RUNNING--(PREGATESC TERENUL)
		  `IDLE: begin 
						    if(enable==0)
							   state<=`IDLE;
						  else 
						    begin 
						      state<=`RUNNING;
						      mosi<=dataOut[7];
						    end
					   end
					//sa atribui lui bit_pentru_scadere_transmisie valoarea 0
              
      `RUNNING: begin
                  if(dataIn[0]<=miso)
                    state<=`IDLE;
                  else state<=`RUNNING;
                end
					
      default: state<=`RST;
    endcase 
    
  end
end


// ACUM FACEM AL DOILEA ALWAYS

always@(posedge clk)
begin
  if(reset==0)
    begin
      
    end
    
  else begin
          case(state)
            `RST:
            
            `IDLE:
            
            `RUNNING: begin
           //  mosi<=dataOut[7]
           // sa atribui valoarea initiala in al doilea always
           //aici doar descriu despre ce se intampla
            if(cpol==0)
              begin
                if(cpha==0)  //daca avem cpha=0, atunci numai daca sclk<=~cpol facem transmisia
                  begin
                    if(sclk=~cpol)
                      begin
                        dataIn[7-bit_pentru_scadere_transmisie]<=miso;
                        //dataIn primeste prin miso
                        mosi<=data[7-bit_pentru_scadere_transmisie-1]
                        bit_pentru_scadere_transmisie<=bit_pentru_scadere_transmisie+1;
                      end 
                  end
                  
               else begin
                        if(sclk=cpol)
                          begin
                            dataIn[3'd7-bit_pentru_scadere_transmisie]<=miso;
                            //dataIn primeste prin miso
                            mosi<=data[3'd7-bit_pentru_scadere_transmisie-1'd1] 
                          end 
                    end 
						
						else
              begin
                if(cpha==0)  
                  begin
                    if(sclk=~cpol)
                      begin
                        dataIn[7-bit_pentru_scadere_transmisie]<=miso;
                        //dataIn primeste prin miso
                        mosi<=data[7-bit_pentru_scadere_transmisie-1]
                        bit_pentru_scadere_transmisie<=bit_pentru_scadere_transmisie+1;
                      end 
                  end
                  
               else begin
                        if(sclk=cpol)
                          begin
                            dataIn[3'd7-bit_pentru_scadere_transmisie]<=miso;
                            //dataIn primeste prin miso
                            mosi<=data[3'd7-bit_pentru_scadere_transmisie-1'd1] 
                          end 
                    end 
							
					end	
					default: state<=`RST;
          
          endcase
       end  
end 



endmodule