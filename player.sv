module player (

input Reset, frame_clk,
input start, play, over,
input [7:0] keycode,
input [9:0] p_Y_max,
output [9:0]  playerX, playerY, playerS,
output [9:0] playerW, playerH, 
output [11:0] progress, 
output [2:0] lives, 
output direction, 
output scroll, 
input egg, 
input [9:0] ebX, ebY,
input [9:0] eRbX, eRbY,

output [11:0] psprite 
);

logic [9:0] p_X_Pos, p_X_Motion, p_Y_Pos, p_Y_Motion;

logic [9:0] p_Size;

logic [9:0] pheight, pwidth;

logic [11:0] p;

logic jumping;

logic [2:0] l;

logic hit, c, dir;

parameter [9:0] p_Y_step = 16;  

parameter [9:0] min = 0;

int minD;

int p_S, p_W, p_H;

logic egg_check;


assign p_Size = 10'd20;	 

assign pwidth = 10'd20;

assign pheight = 10'd33;

assign p_S = p_Size;

assign minD = p_X_Pos - pwidth;

assign p_W = pwidth;
assign p_H = pheight;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if(Reset)  // Asynchronous Reset
        begin 
            p_Y_Motion <= 10'd0; 
				p_X_Motion <= 10'd0;
				p_Y_Pos <= 10'd100;
				p_X_Pos <= 10'd20;
				jumping <= 1'b0;
				p <= 12'b0;
				l <= 3'b000;
				c <= 1'b1;
				dir <= 1'b1;
				egg_check <= 1'b1;
        end
           
        else if(play == 1'b1 || egg == 1'b1)
        begin
				 if(c && hit) begin
					l <= l + 1;
					c <= 1'b0;
				 end
				 if(~hit) begin
					c <= 1'b1;
				 end
				 
				 if(keycode == 8'd07)
					dir <= 1'b1;
				 else if(keycode == 8'd04)
					dir <= 1'b0;
					
				scroll <= 1'b0;
				 
				case (keycode)
					8'h07 : begin
							   
									
								if(p_X_Pos < 10'd320 || p >= 12'd3200) begin
									p_X_Motion <= 5;
								end 
								else begin
									p <= p + 5;
									p_X_Motion <= 0;
									scroll <= 1'b1;
								end
								
		 				    end
					        
					8'h04 : begin
							  if(minD > 0)
									p_X_Motion <= -5;
								else
									p_X_Motion <= 0;
							  end
					default: p_X_Motion <= 10'd0;
			   endcase
				
				
				
				if(keycode == 10'd26 && jumping == 1'b0 && p_Y_Pos + pheight + 2 > p_Y_max) begin
					p_Y_Motion <= (~p_Y_step) + 10'd1;
					jumping <= 1'b1;
				end
				else begin 
					p_Y_Motion <= p_Y_Motion + 10'd1;
				end
				
				if(p_Y_Motion[9] == 0 && p_Y_Pos + pheight + p_Y_Motion > p_Y_max) begin
					p_Y_Motion <= 10'd0;
					p_Y_Pos <= p_Y_max - pheight;
					jumping <= 1'b0;
					
				end
				else begin
					p_Y_Pos <= (p_Y_Pos + p_Y_Motion);
				end
					
					
				p_X_Pos <= (p_X_Pos + p_X_Motion);
				
				
				if(p_Y_Pos > 479 && p_Y_Pos[9] == 0) begin
					l <= l + 1;
					p_Y_Pos <= 100;
					if(p >= 2860) begin
						p_X_Pos <= 144;
					end
					else begin
						p_X_Pos <= 20;
					end
					p_Y_Motion <= 10'd0;
				end
				
				if(egg && egg_check) begin
					p_Y_Motion <= 10'd0; 
					p_X_Motion <= 10'd0;
					p_Y_Pos <= 10'd100;
					p_X_Pos <= 10'd20;
					jumping <= 1'b0;
					p <= 12'b0;
					c <= 1'b1;
					dir <= 1'b1;
					egg_check <= 1'b0;
				end
				
			
		end  
    end
	 
	 
	 int colx1, coly1;
	 int colx2, coly2;
	 assign colx1 = ebX - p_X_Pos;
	 assign coly1 = ebY - p_Y_Pos;
	 assign colx2 = eRbX - p_X_Pos;
	 assign coly2 = eRbY - p_Y_Pos;
 
	 always_comb begin
		if((colx1 <= p_W &&  coly1 <= p_H && colx1 >= (~p_W)+1 && coly1 >= (~p_H)+1)) begin
			hit = 1'b1; end
		else if ((colx2 <= p_W &&  coly2 <= p_H && colx2 >= (~p_W)+1 && coly2 >= (~p_H)+1)) begin
			hit = 1'b1; end
		else begin
			hit = 1'b0; end
	  
	 end
       
    assign playerX = p_X_Pos;
   
    assign playerY = p_Y_Pos;
   
    assign playerS = p_Size;
	 
	 assign playerW = pwidth;
	 
	 assign playerH = pheight;
	 
	 assign progress = p;
	 
	 assign lives = l;
	 
	 assign direction = dir;
	 
	 player_animation pa0 (.Reset, .frame_clk, .keycode, .direction(dir), .jumping, .psprite);
	 

endmodule