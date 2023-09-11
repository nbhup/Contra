module enemy_run (

input Reset, frame_clk,
input start, play, over, egg, 
input [7:0] keycode, 
input [11:0] progress, 
input scroll, 

input [9:0] bX, bY, b1X, b1Y, b2X, b2Y, b3X, b3Y, b4X, b4Y,

input [9:0] playerX, playerY, playerW,

output [9:0] eRY, eRW, eRH, 
output [12:0] eRX,
output eRAlive, 

output [9:0] eRbX, eRbY,

output eR1sprite,

output [11:0] esprite, 
output h2
);

//collision
int colx1, coly1;
int colx2, coly2;
int colx3, coly3;
int colx4, coly4;
int colx5, coly5;

//collision
assign colx1 = bX - eRX;
assign coly1 = bY - eRY;

assign colx2 = b1X - eRX;
assign coly2 = b1Y - eRY;

assign colx3 = b2X - eRX;
assign coly3 = b2Y - eRY;

assign colx4 = b3X - eRX;
assign coly4 = b3Y - eRY;

assign colx5 = b4X - eRX;
assign coly5 = b4Y - eRY;

logic [12:0] enemyRX;
logic [9:0] enemyRY;

int enemyRW;
int enemyRH;
 

logic [12:0] bound_check;
logic hit;
logic fire, d;
logic dead_check;
logic switch_dir;
logic still;

int pde;
int counter;
int frame_counter;
logic [12:0] move = 13'd0; // Movement variable to scroll enemy across screen in tandem with player.

logic [7:0] k;

int advance;

int still_c;

assign pde = (playerX + playerW) - enemyRX;

always_ff @ (posedge frame_clk or posedge Reset) begin
	if(Reset) begin
		enemyRX <= 12'd1088;
		enemyRY <= 10'd159;
		enemyRW <= 20;
		enemyRH <= 33;
		eRAlive <= 1'b1;
		fire <= 1'b0;
		counter <= 0;
		frame_counter <= 0;
		k <= 8'd40;
		eR1sprite <= 1'b0;
		advance <= 0;
		dead_check <= 1'b1;
		switch_dir <= 1'b0;
		move <= 13'd0;
		still <= 1'b0;
		still_c <= 10;
		h2 <= 1'b0;
	end
	else if(play == 1'b1) begin
	
			h2 <= 1'b0;
	
			still_c <= still_c + 1;
			if(still_c >= 9) begin
				still <= 1'b0;
			end
	
			if (frame_counter == 166) begin
				switch_dir <= 1'b1;
				move <= 13'd0;
			end
			else if (frame_counter == 0) begin
				switch_dir <= 1'b0;
				move <= 13'd0;
			end
			
			if(still == 1'b1) begin
				move <= move;
			end
			else if (switch_dir == 1'b1) begin
				move <= move - 13'd02;
			end
			else begin
				move <= move + 13'd02;
			end
	
		if(advance == 0) begin
			enemyRX <= (13'd1088 - move) - progress;
			enemyRY <= 10'd255;
		end
//		else if(advance == 1) begin
//			enemyRX <= (13'd1968 - move) - progress;
//			enemyRY <= 10'd351;
//		end
		else if(advance == 1) begin
			enemyRX <= (13'd2362 - move ) - progress;
			enemyRY <= 10'd159;
		end
		/*else if(advance == 3) begin
			enemyRX <= (13'd3790 - move) - progress;
			enemyRY <= 10'd255;
		end*/
		
		counter <= counter + 1;
		
		if (switch_dir == 1'b1) begin
			frame_counter <= frame_counter - 1;
		end
		else begin
			frame_counter <= frame_counter + 1;
		end
		
		k <= 8'd40;
		
		fire <= 1'b0;
		
		if((bound_check[12] == 1'b1 || hit == 1'b1) && dead_check) begin
			fire <= 1'b0;
			dead_check <= 1'b0;
			if(hit == 1'b1 && eRAlive) begin
				h2 <= 1'b1;
			end
			advance <= advance + 1;
			if(advance >= 1) begin
				eRAlive <= 1'b0;
			end	
		end
		
		if(dead_check == 1'b0) begin
			dead_check <= 1'b1;
		end

		
		if(enemyRX - enemyRW <= 639 && eRAlive == 1'b1 && dead_check) begin
			
			fire <= 1'b1;
			if(pde >= 0) begin
				d <= 1'b1;
				eR1sprite <= 1'b1;
			end
			else begin
				d <= 1'b0; // ************************** CHANGE BACK to 1'b0
				eR1sprite <= 1'b1; // *********************** CHANGE BACK 1'b0
			end
		end
		if(counter == 120) begin
			counter <= 0;
			k <= 8'd44;
			still <= 1'b1;
			still_c <= 1'b0;
		end
		
	end
	else if(egg == 1) begin
		eRAlive <= 1'b0;
	end
end

always_comb begin

	if(enemyRX - enemyRW <= 639) begin
		if((colx1 <= enemyRW &&  coly1 <= enemyRH && colx1 >= (~enemyRW)+1 && coly1 >= (~enemyRH)+1) ||
			(colx2 <= enemyRW &&  coly2 <= enemyRH && colx2 >= (~enemyRW)+1 && coly2 >= (~enemyRH)+1) ||
			(colx3 <= enemyRW &&  coly3 <= enemyRH && colx3 >= (~enemyRW)+1 && coly3 >= (~enemyRH)+1) ||
			(colx4 <= enemyRW &&  coly4 <= enemyRH && colx4 >= (~enemyRW)+1 && coly4 >= (~enemyRH)+1) ||
			(colx5 <= enemyRW &&  coly5 <= enemyRH && colx5 >= (~enemyRW)+1 && coly5 >= (~enemyRH)+1)
		  ) begin
				hit = 1'b1; end
		else begin
				hit = 1'b0; end
	end
	else begin
		hit = 1'b0;
	end
			
	bound_check = enemyRX + 60;
end

assign eRX = enemyRX;
assign eRY = enemyRY;
assign eRW = enemyRW;
assign eRH = enemyRH;

ball	b0 (.Reset, .frame_clk, .keycode(k), .BallX(eRbX), .BallY(eRbY),
				 .playerX(enemyRX), .playerY(enemyRY - 20), .f(fire), .direction(switch_dir), .scroll);

enemy_run_animation era0 (.Reset, .frame_clk, .direction(switch_dir), .esprite, .keycode(k));
				 
				 
endmodule

