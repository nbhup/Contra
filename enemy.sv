module enemy (

input Reset, frame_clk,
input start, play, over, egg, 
input [7:0] keycode, 
input [11:0] progress, 
input scroll, 

input [9:0] bX, bY, b1X, b1Y, b2X, b2Y, b3X, b3Y, b4X, b4Y,

input [9:0] playerX, playerY, playerW,

output [9:0] eY, eW, eH, 
output [12:0] eX,
output eAlive, 

output [9:0] ebX, ebY,

output e1sprite,
output h1
);

//collision
int colx1, coly1;
int colx2, coly2;
int colx3, coly3;
int colx4, coly4;
int colx5, coly5;

//collision
assign colx1 = bX - eX;
assign coly1 = bY - eY;

assign colx2 = b1X - eX;
assign coly2 = b1Y - eY;

assign colx3 = b2X - eX;
assign coly3 = b2Y - eY;

assign colx4 = b3X - eX;
assign coly4 = b3Y - eY;

assign colx5 = b4X - eX;
assign coly5 = b4Y - eY;

logic [12:0] enemyX;
logic [9:0] enemyY;

int enemyW;
int enemyH;
 

logic [12:0] bound_check;
logic hit;
logic fire, d;
logic dead_check;

int pde;
int counter;

logic [7:0] k;

int advance;

assign pde = (playerX + playerW) - enemyX;

always_ff @ (posedge frame_clk or posedge Reset) begin
	if(Reset) begin
		enemyX <= 12'd800;
		enemyY <= 10'd159;
		enemyW <= 20;
		enemyH <= 33;
		eAlive <= 1'b1;
		fire <= 1'b0;
		counter <= 0;
		k <= 8'd40;
		e1sprite <= 1'b0;
		advance <= 0;
		dead_check <= 1'b1;
		h1 <= 1'b0;
	end
	else if(play == 1'b1) begin
	
		h1 <= 1'b0;
	
		if(advance == 0) begin
			enemyX <= 13'd800 - progress;
			enemyY <= 10'd159;
		end
		else if(advance == 1) begin
			enemyX <= 13'd1584 - progress;
			enemyY <= 10'd351;
		end
		else if(advance == 2) begin
			enemyX <= 13'd2352 - progress;
			enemyY <= 10'd255;
		end
		else if(advance == 3) begin
			enemyX <= 13'd3790 - progress;
			enemyY <= 10'd255;
		end
		
		counter <= counter + 1;
		k <= 8'd40;
		
		fire <= 1'b0;
		
		if((bound_check[12] == 1'b1 || hit == 1'b1) && dead_check) begin
			fire <= 1'b0;
			dead_check <= 1'b0;
			advance <= advance + 1;
			if(hit == 1'b1 && eAlive) begin
				h1 <= 1'b1;
			end
			if(advance >= 3) begin
				eAlive <= 1'b0;
			end	
		end
		
		if(dead_check == 1'b0) begin
			dead_check <= 1'b1;
		end

		
		if(enemyX - enemyW <= 639 && eAlive == 1'b1 && dead_check) begin
			fire <= 1'b1;
			if(pde >= 0) begin
				d <= 1'b1;
				e1sprite <= 1'b1;
			end
			else begin
				d <= 1'b0;
				e1sprite <= 1'b0;
			end
		end
		if(counter == 30) begin
			counter <= 0;
			k <= 8'd44;
		end
		
	end
	else if(egg == 1) begin
		eAlive <= 1'b0;
	end
end

always_comb begin

	if(enemyX - enemyW <= 639) begin
		if((colx1 <= enemyW &&  coly1 <= enemyH && colx1 >= (~enemyW)+1 && coly1 >= (~enemyH)+1) ||
			(colx2 <= enemyW &&  coly2 <= enemyH && colx2 >= (~enemyW)+1 && coly2 >= (~enemyH)+1) ||
			(colx3 <= enemyW &&  coly3 <= enemyH && colx3 >= (~enemyW)+1 && coly3 >= (~enemyH)+1) ||
			(colx4 <= enemyW &&  coly4 <= enemyH && colx4 >= (~enemyW)+1 && coly4 >= (~enemyH)+1) ||
			(colx5 <= enemyW &&  coly5 <= enemyH && colx5 >= (~enemyW)+1 && coly5 >= (~enemyH)+1)
		  ) begin
				hit = 1'b1; end
		else begin
				hit = 1'b0; end
	end
	else begin
		hit = 1'b0;
	end
			
	bound_check = enemyX + 20;
end

assign eX = enemyX;
assign eY = enemyY;
assign eW = enemyW;
assign eH = enemyH;

ball	b0 (.Reset, .frame_clk, .keycode(k), .BallX(ebX), .BallY(ebY),
				 .playerX(enemyX), .playerY(enemyY - 23), .f(fire), .direction(d), .scroll);


endmodule

