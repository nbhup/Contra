module game_control (

input Reset, frame_clk, 
input h1, h2, 
input [2:0] lives,
input [7:0] keycode, 
input [9:0] playerX,
output start, play, over, egg, 
output [7:0] score
);

enum logic [2:0] {START, PLAY, OVER, EGG, EGG_L} curr_state, next_state;


logic change;


always_ff @ (posedge frame_clk or posedge Reset) begin
        if (Reset) begin
            curr_state <= START;
				score <= 0;
				change <= 1'b0;
		  end
        else begin
            curr_state <= next_state;
				if(h1 == 1'b1 || h2 == 1'b1) begin
					score <= score + 10;
				end
				if(playerX > 10'd649) begin
					change <= 1'b1;
					
				end
		  end
				
end


always_comb begin

	
	next_state = curr_state;
	unique case(curr_state)
	START : if(keycode == 8'd40)
					next_state = PLAY;
	PLAY :  if(score == 0 && lives == 0 && playerX > 10'd649) begin
					next_state = EGG_L;
			  end
			  else if(lives >= 3'b011 || change) begin
					next_state = OVER;
			  end
	OVER : ;
	
	EGG : if(lives >= 3'b011 || playerX > 10'd649) begin
					next_state = OVER;
			  end
	
	EGG_L : next_state = EGG;
   
	endcase
	
	
	start = 1'b0;
	play = 1'b0;
	over = 1'b0;
	egg = 1'b0;
	if(curr_state == START)
		start = 1'b1;
	else if(curr_state == PLAY)
		play = 1'b1;
	else if(curr_state == OVER)
		over = 1'b1;
	else
		egg = 1'b1;
end

endmodule

