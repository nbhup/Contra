module player_animation (

input Reset, frame_clk, 
input [7:0] keycode,
input direction, 
input jumping, 
output [11:0] psprite
);

int counter;

enum logic [3:0] {wR, wL, rR1, rR2, rR3, rR4, rR5, rL1, rL2, rL3, rL4, rL5} 
					  curr_state, next_state;


always_ff @ (posedge frame_clk or posedge Reset) begin
   if (Reset) begin
      curr_state <= wR;
	   counter <= 0;
	end
   else begin 
      curr_state <= next_state;
		if(counter == 9) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end
end


always_comb begin

	next_state = curr_state;
	
	
	if(counter == 9) 
	begin
		if(direction == 1'b1) 
		begin
			if(jumping == 1'b1) 
			begin
				next_state = rR1;
			end
			else 
			begin 
				if(keycode == 8'd07) 
				begin
					unique case(curr_state)
						rR1: next_state = rR2;
						rR2: next_state = rR3;
						rR3: next_state = rR4;
						rR4: next_state = rR5;
						default : next_state = rR1;
					endcase
				end
				else if(keycode == 8'd04) 
				begin
					next_state = rL1;
				end
				else 
				begin 
					next_state = wR;
				end
			end
		end
		else 
		begin
			if(jumping == 1'b1) 
			begin
				next_state = rL1;
			end
			else 
			begin 
				if(keycode == 8'd07) 
				begin
					next_state = rR1;
				end
				else if(keycode == 8'd04) 
				begin
					unique case(curr_state)
						rL1: next_state = rL2;
						rL2: next_state = rL3;
						rL3: next_state = rL4;
						rL4: next_state = rL5;
						default : next_state = rL1;
					endcase
				end
				else 
				begin
					next_state = wL;
				end
			end
		end
	end
		
	
	
	unique case(curr_state)
	
	wR: 		 psprite = 12'd1;
	wL: 		 psprite = 12'd2;
	rR1: 		 psprite = 12'd4;
	rR2: 		 psprite = 12'd8;
	rR3: 		 psprite = 12'd16;
	rR4: 		 psprite = 12'd32;
	rR5: 		 psprite = 12'd64;
	rL1: 		 psprite = 12'd128;
	rL2: 		 psprite = 12'd256;
	rL3: 		 psprite = 12'd512;
	rL4: 		 psprite = 12'd1024;
	rL5: 		 psprite = 12'd2048;
	default : psprite = 12'b0;
  endcase
	


end

endmodule

