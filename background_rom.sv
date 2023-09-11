module background_rom ( 
input [9:0]	DrawX, DrawY, playerX, playerY,
input [11:0] progress, 	
output [9:0] p_Y_max,					
output [2:0] tile
);
	
	logic[11:0] x_address;
	logic[11:0] y_address;
	logic[11:0] rom_address;
	
	logic[11:0] p_x;
	logic[11:0] p_y;
	
	
	
	// TILE DEFINITION:
	
	// 0 = SKY
	// 1 = WATER
	// 2 = PLATFORM/GRASS
	// 3 = ROCKS/BOULDER
	// 4 = wood
	// 5 = leaves
	
	// DIMENSIONS:
	
	// X = 3840
	// Y = 480
				
	// 2D			
//	logic [1:0] ROM [5][40] = '{
//	
//		  // TEMPLATE
//		  
//        '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, // 0
//        '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, // 1 // Top Platforms omitted.
//        '{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,2,2,2,2,3,3,3,2,2,0,2,0,0,0,0,0,0,2,2}, // 2 // Sky replaces Trees.
//        '{3,3,2,2,3,3,3,2,2,1,1,1,3,3,3,3,3,3,3,3,3,3,2,3,2,2,3,3,2,2,0,3,2,2,2,0,0,2,3,2}, // 3 // Water Blocks should be placed lower?
//        '{1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,0,3,3,3,2,2,0,3,2,2} // 4 // Extension of bottommost platforms.
//		  			
//        };

//1D
		  
	logic [2:0] ROM [200] = '{
	
			  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,0,0,0,0,5,5,5,0,0,5,5,5,5,5,5,5,0,0,0, // 0
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,4,4,4,0,0,4,4,4,4,4,4,4,0,0,0, // 1 // Top Platforms omitted.
           2,2,0,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,4,4,4,2,2,2,2,4,4,4,2,2,4,2,4,4,4,4,4,0,2,2, // 2 // Sky replaces Trees.
           3,3,2,2,3,3,3,2,2,2,2,2,3,3,3,3,3,3,4,4,4,3,2,3,2,2,2,2,2,2,4,3,2,2,2,4,4,2,3,2, // 3 // Water Blocks should be placed lower?
           1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,4,3,3,3,2,2,4,3,2,2 	

			};
		  
	always_comb begin
//		x_address = 3;
//		y_address = 3;
		
		x_address = (DrawX + progress)/96;
		y_address = DrawY/96;
		
		rom_address = x_address + y_address*40;
		
		tile = ROM[rom_address];
		//tile = ROM[y_address][x_address];
		
		p_x = (playerX + progress)/96;
		p_y = playerY/96;
		
		if(p_y < 4 && (p_y+1) < 5 && ROM[(p_x + (p_y+1)*40)] == 2) begin
			p_Y_max = (p_y+1)*96;
		end
		else if(p_y < 4 && (p_y+2) < 5 && ROM[(p_x + (p_y+2)*40)] == 2) begin
			p_Y_max = (p_y+2)*96;
		end
		else if(p_y < 4 && (p_y+3) < 5 && ROM[(p_x + (p_y+3)*40)] == 2) begin
			p_Y_max = (p_y+3)*96;
		end
		else if(p_y < 4 && (p_y+4) < 5 && ROM[(p_x + (p_y+4)*40)] == 2) begin
			p_Y_max = (p_y+4)*96;
		end
		else begin
			p_Y_max = 540;
		end
		
		
  
	end

endmodule  