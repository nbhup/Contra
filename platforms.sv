module platforms (
input frame_clk,
input [9:0] playerX, playerY, playerS, 
output [9:0] p_Y_max,
output [9:0] p1X, p1Y, p1W, p1H,
output [9:0] p2X, p2Y, p2W, p2H
);


parameter [9:0] p1_x = 200;
parameter [9:0] p1_y = 380;
parameter [9:0] p1_w = 50;
parameter [9:0] p1_h = 5;


parameter [9:0] p2_x = 400;
parameter [9:0] p2_y = 400;
parameter [9:0] p2_w = 30;
parameter [9:0] p2_h = 5;


assign p1X = p1_x;
assign p1Y = p1_y;
assign p1W = p1_w;
assign p1H = p1_h;

assign p2X = p2_x;
assign p2Y = p2_y;
assign p2W = p2_w;
assign p2H = p2_h;

int min1, max1;
int min2, max2;

assign min1 = p1_x - p1_w;
assign max1 = p1_x + p1_w;

assign min2 = p2_x - p2_w;
assign max2 = p2_x + p2_w;


always_ff @ (posedge frame_clk) begin


	if(playerX + playerS >= min1 && playerX - playerS <= max1) begin
		if(playerY + playerS <= p1_y - p1_h)
			p_Y_max <= p1_y - p1_h;
		else
			p_Y_max <= 479;
	end
	else if(playerX + playerS >= min2 && playerX - playerS <= max2) begin
		if(playerY + playerS <= p2_y - p2_h)
			p_Y_max <= p2_y - p2_h;
		else
			p_Y_max <= 479;
	end
	else begin
	
		p_Y_max <= 479;
	
	end

end

endmodule


