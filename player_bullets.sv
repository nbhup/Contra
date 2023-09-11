module player_bullets(

input frame_clk, Reset,
input [7:0] keycode,
input start, play, over, 
input direction, 
input scroll, 
//output [4:0] fire
input [9:0] playerX, playerY,

output [9:0] bX, bY, b1X, b1Y, b2X, b2Y, b3X, b3Y, b4X, b4Y
);

int counter;
int firenext;

logic [4:0] f; 



always_ff @ (posedge frame_clk) begin

	if(Reset) begin
		counter <= 0;
		firenext <= 8;
	end
	else begin
		if(keycode == 8'd44 && firenext > 10) begin
			counter <= (counter + 1) % 5;
			firenext <= 0;
		end
		else begin
			firenext <= (firenext + 1);
		end
		
		if(counter == 0 && firenext >= 10)
			f <= 5'b00001;
		else if(counter == 1 && firenext >= 10)
			f <= 5'b00010;
		else if(counter == 2 && firenext >= 10)
			f <= 5'b00100;
		else if(counter == 3 && firenext >= 10)
			f <= 5'b01000;
		else if(counter == 4 && firenext >= 10)
			f <= 5'b10000;

	end

end

//assign fire = f;

	ball	b0 (.Reset, .frame_clk, .keycode, .BallX(bX), .BallY(bY), .scroll, 
				 .playerX, .playerY(playerY - 11), .f(f[0] & play), .direction);
	ball	b1 (.Reset, .frame_clk, .keycode, .BallX(b1X), .BallY(b1Y), .scroll, 
				 .playerX, .playerY(playerY - 11), .f(f[1] & play), .direction);
	ball	b2 (.Reset, .frame_clk, .keycode, .BallX(b2X), .BallY(b2Y), .scroll, 
				 .playerX, .playerY(playerY - 11), .f(f[2] & play), .direction);
	ball	b3 (.Reset, .frame_clk, .keycode, .BallX(b3X), .BallY(b3Y), .scroll, 
				 .playerX, .playerY(playerY - 11), .f(f[3] & play), .direction);
	ball	b4 (.Reset, .frame_clk, .keycode, .BallX(b4X), .BallY(b4Y), .scroll, 
				 .playerX, .playerY(playerY - 11), .f(f[4] & play), .direction);


endmodule