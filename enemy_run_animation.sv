module enemy_run_animation (

input Reset, frame_clk, 
input direction,  
input [7:0] keycode, 
output [11:0] esprite

);

int counter;

enum logic [3:0] { L1, L2, L3, L4, L5, L6, R1, R2, R3, R4, R5, R6, SL, SR } 
					  curr_state, next_state;


always_ff @ (posedge frame_clk or posedge Reset) begin
   if (Reset) begin
      curr_state <= L6;
	   counter <= 0;
	end
   else begin 
      curr_state <= next_state;
		if(counter == 9 || keycode == 8'd44) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end
end


always_comb begin

	next_state = curr_state;
	
	
	if(counter == 9 || keycode == 8'd44) 
	begin
			if(direction == 1'b0) 
			begin
				if(keycode == 8'd44) begin
					next_state = SL;
				end
				else begin
					unique case(curr_state)
						L6: next_state = L1;
						L5: next_state = L2;
						L4: next_state = L3;
						L3: next_state = L4;
						L2: next_state = L5;
						L1: next_state = L6;
						default : next_state = L6;
					endcase
				end
			end
			else begin
				if(keycode == 8'd44) begin
					next_state = SR;
				end
				else begin
					unique case(curr_state)
						R6: next_state = R1;
						R5: next_state = R2;
						R4: next_state = R3;
						R3: next_state = R4;
						R2: next_state = R5;
						R1: next_state = R6;
						default : next_state = R6;
					endcase
				end
			end
	end
		
	
	
	unique case(curr_state)
	
	L1: 		 esprite = 12'd1;
	L2: 		 esprite = 12'd2;
	L3: 		 esprite = 12'd4;
	L4: 		 esprite = 12'd8;
	L5: 		 esprite = 12'd16;
	L6: 		 esprite = 12'd32;
	R1: 		 esprite = 12'd64;
	R2: 		 esprite = 12'd128;
	R3: 		 esprite = 12'd256;
	R4: 		 esprite = 12'd512;
	R5: 		 esprite = 12'd1024;
	R6: 		 esprite = 12'd2048;
	SL: 		 esprite = 12'd2000;
	SR:		 esprite = 12'd2030;
	default : esprite = 12'b0;
  endcase
	


end

endmodule 