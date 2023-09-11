module  color_mapper ( 
input pixel_clk, blank, frame_clk, Reset,
input start, play, over, egg, 
input [7:0] keycode, 

input [9:0] playerX, playerY, playerS, playerW, playerH, 
input [11:0] progress, 
output [9:0] p_Y_max,
input [2:0] lives,
input [11:0] psprite,

input [9:0] DrawX, DrawY,
input [9:0] BallX, BallY, b1X, b1Y, b2X, b2Y, b3X, b3Y, b4X, b4Y,
//input [4:0] firing,

input [9:0] eY, eW, eH,
input [12:0] eX,
input eAlive,  
input [9:0] ebX, ebY,
input e1sprite, 

input [9:0] eRY, eRW, eRH,
input [12:0] eRX,
input eRAlive,  
input [9:0] eRbX, eRbY,
input eR1sprite, 
input [11:0] esprite, 

input [7:0] score,

//input [9:0] p1X, p1Y, p1W, p1H,
//input [9:0] p2X, p2Y, p2W, p2H,
output logic [7:0]  Red, Green, Blue);
							  
	
	 logic [2:0] tile;
	 
	 logic [9:0] p_Y_m;
	 
	 background_rom br0 (.DrawX(DrawX), .DrawY(DrawY), .tile, .progress,
								.playerX, .playerY, .p_Y_max(p_Y_m));
								
	 assign p_Y_max = p_Y_m;
	 
	 logic [14:0] rom_address;
	 logic [15:0] start_address;
	 logic [3:0] rom_q_sky, rom_q_grass, rom_q_boulder, rom_q_water, rom_q_wood, rom_q_leaf;
	 logic [3:0] red_sky, green_sky, blue_sky;
	 logic [3:0] red_grass, green_grass, blue_grass;
	 logic [3:0] red_boulder, green_boulder, blue_boulder;
	 logic [3:0] red_water, green_water, blue_water;
	 logic [3:0] red_wood, green_wood, blue_wood;
	 logic [3:0] red_leaf, green_leaf, blue_leaf;
	 logic [4:0] rom_start;
	 logic [3:0] red_start, green_start, blue_start;
	 
	 logic [4:0] rom_cheng;
	 logic [3:0] red_cheng, green_cheng, blue_cheng;
	 
	 assign rom_address = ((DrawX + progress) % 96) + ((DrawY % 96)*96);
	 
	 assign start_address = (DrawX*160/640) + (DrawY*120/480 * 160);
	 
	 
	 Cheng_tile_rom Cheng_tile_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_cheng)
	);

	Cheng_tile_palette Cheng_tile_palette (
	.index (rom_cheng),
	.red   (red_cheng),
	.green (green_cheng),
	.blue  (blue_cheng)
	);
	 
	 Contra_Sky_Tile_96_rom Contra_Sky_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_sky)
   );
	
	Contra_Sky_Tile_96_palette Contra_Sky_Tile_96_palette (
	.index (rom_q_sky),
	.red   (red_sky),
	.green (green_sky),
	.blue  (blue_sky)
	);
	
	Contra_Grass_Tile_96_rom Contra_Grass_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_grass)
	);

	Contra_Grass_Tile_96_palette Contra_Grass_Tile_96_palette (
	.index (rom_q_grass),
	.red   (red_grass),
	.green (green_grass),
	.blue  (blue_grass)
	);
	
	Contra_New_Rock_Tile_96_rom Contra_New_Rock_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_boulder)
	);

	Contra_New_Rock_Tile_96_palette Contra_New_Rock_Tile_96_palette (
	.index (rom_q_boulder),
	.red   (red_boulder),
	.green (green_boulder),
	.blue  (blue_boulder)
	);
	
	Contra_Water_New_Tile_96_rom Contra_Water_New_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_water)
	);

	Contra_Water_New_Tile_96_palette Contra_Water_New_Tile_96_palette (
	.index (rom_q_water),
	.red   (red_water),
	.green (green_water),
	.blue  (blue_water)
	);
	
	Contra_Tree_Group_Tile_96_rom Contra_Tree_Group_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_wood)
	);

	Contra_Tree_Group_Tile_96_palette Contra_Tree_Group_Tile_96_palette (
	.index (rom_q_wood),
	.red   (red_wood),
	.green (green_wood),
	.blue  (blue_wood)
	);
	
	Contra_New_Top_Tile_96_rom Contra_New_Top_Tile_96_rom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q_leaf)
	);

	Contra_New_Top_Tile_96_palette Contra_New_Top_Tile_96_palette (
	.index (rom_q_leaf),
	.red   (red_leaf),
	.green (green_leaf),
	.blue  (blue_leaf)
	);
	
	StartScreen1_rom StartScreen1_rom (
	.clock   (pixel_clk),
	.address (start_address),
	.q       (rom_start)
	);

	StartScreen1_palette StartScreen1_palette (
	.index (rom_start),
	.red   (red_start),
	.green (green_start),
	.blue  (blue_start)
	);
	
	logic [7:0] life_address;
	
	logic [2:0] rom_life;
	
	logic [3:0] red_life, green_life, blue_life;
	
	always_comb begin 
		if(DrawX <= 26) begin
			life_address = (DrawX - 15) + (DrawY - 15)*10;
		end
		else if(DrawX <= 46) begin
			life_address = (DrawX - 35) + (DrawY - 15)*10;
		end
		else begin
			life_address = (DrawX - 55) + (DrawY - 15)*10;
		end
	
	
	end

	
	
	Life_Sprite_rom Life_Sprite_rom (
	.clock   (pixel_clk),
	.address (life_address),
	.q       (rom_life)
	);

	Life_Sprite_palette Life_Sprite_palette (
	.index (rom_life),
	.red   (red_life),
	.green (green_life),
	.blue  (blue_life)
	);
	
	logic [12:0] hero_address;
	logic [3:0] rom_waitL, rom_waitR;
	logic [3:0] rom_L1, rom_L2, rom_L3, rom_L4, rom_L5;
	logic [3:0] rom_R1, rom_R2, rom_R3, rom_R4, rom_R5;

	logic [3:0] red_waitL, blue_waitL, green_waitL;
	logic [3:0] red_waitR, blue_waitR, green_waitR;
	
	logic [3:0] red_L1, blue_L1, green_L1;
	logic [3:0] red_L2, blue_L2, green_L2;
	logic [3:0] red_L3, blue_L3, green_L3;
	logic [3:0] red_L4, blue_L4, green_L4;
	logic [3:0] red_L5, blue_L5, green_L5;
	
	logic [3:0] red_R1, blue_R1, green_R1;
	logic [3:0] red_R2, blue_R2, green_R2;
	logic [3:0] red_R3, blue_R3, green_R3;
	logic [3:0] red_R4, blue_R4, green_R4;
	logic [3:0] red_R5, blue_R5, green_R5;
	
	int pl, pu, h_x, h_y;
	
	assign pl = playerX - playerW;
	assign pu = playerY - playerH;
	
	assign h_x = DrawX - pl;
	assign h_y = DrawY - pu;
	
	
	assign hero_address = (h_x % 40) + (h_y % 66)*40;
	
	
	waitR1_Hero_green_rom waitR1_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_waitR)
	);
	
	waitR1_Hero_green_palette waitR1_Hero_green_palette (
	.index (rom_waitR),
	.red   (red_waitR),
	.green (green_waitR),
	.blue  (blue_waitR)
	);

	waitL1_Hero_green_rom waitL1_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_waitL)
	);

	waitL1_Hero_green_palette waitL1_Hero_green_palette (
	.index (rom_waitL),
	.red   (red_waitL),
	.green (green_waitL),
	.blue  (blue_waitL)
	);
	
	runningR1_Hero_green_rom runningR1_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_R1)
	);

	runningR1_Hero_green_palette runningR1_Hero_green_palette (
	.index (rom_R1),
	.red   (red_R1),
	.green (green_R1),
	.blue  (blue_R1)
	);
	
	runningR2_Hero_green_rom runningR2_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_R2)
	);

	runningR2_Hero_green_palette runningR2_Hero_green_palette (
	.index (rom_R2),
	.red   (red_R2),
	.green (green_R2),
	.blue  (blue_R2)
	);
	
	runningR3_Hero_green_rom runningR3_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_R3)
	);

	runningR3_Hero_green_palette runningR3_Hero_green_palette (
	.index (rom_R3),
	.red   (red_R3),
	.green (green_R3),
	.blue  (blue_R3)
	);
	
	runningR4_Hero_green_rom runningR4_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_R4)
	);

	runningR4_Hero_green_palette runningR4_Hero_green_palette (
	.index (rom_R4),
	.red   (red_R4),
	.green (green_R4),
	.blue  (blue_R4)
	);
	
	runningR5_Hero_green_rom runningR5_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_R5)
	);

	runningR5_Hero_green_palette runningR5_Hero_green_palette (
	.index (rom_R5),
	.red   (red_R5),
	.green (green_R5),
	.blue  (blue_R5)
	);
	
	runningL1_Hero_green_rom runningL1_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_L1)
	);

	runningL1_Hero_green_palette runningL1_Hero_green_palette (
	.index (rom_L1),
	.red   (red_L1),
	.green (green_L1),
	.blue  (blue_L1)
	);
	
	runningL2_Hero_green_rom runningL2_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_L2)
	);

	runningL2_Hero_green_palette runningL2_Hero_green_palette (
	.index (rom_L2),
	.red   (red_L2),
	.green (green_L2),
	.blue  (blue_L2)
	);
	
	runningL3_Hero_green_rom runningL3_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_L3)
	);

	runningL3_Hero_green_palette runningL3_Hero_green_palette (
	.index (rom_L3),
	.red   (red_L3),
	.green (green_L3),
	.blue  (blue_L3)
	);
	
	runningL4_Hero_green_rom runningL4_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_L4)
	);

	runningL4_Hero_green_palette runningL4_Hero_green_palette (
	.index (rom_L4),
	.red   (red_L4),
	.green (green_L4),
	.blue  (blue_L4)
	);

	runningL5_Hero_green_rom runningL5_Hero_green_rom (
	.clock   (pixel_clk),
	.address (hero_address),
	.q       (rom_L5)
	);

	runningL5_Hero_green_palette runningL5_Hero_green_palette (
	.index (rom_L5),
	.red   (red_L5),
	.green (green_L5),
	.blue  (blue_L5)
	);
	
	logic [12:0] enemy1_address;
	logic [3:0] rom_1L, rom_1R;
	
	logic [3:0] red_1L, blue_1L, green_1L;
	logic [3:0] red_1R, blue_1R, green_1R;
	
	int e1l, e1u, e1_x, e1_y;
	
	assign e1l = eX - eW;
	assign e1u = eY - eH;
	
	assign e1_x = DrawX - e1l;
	assign e1_y = DrawY - e1u;
	
	
	assign enemy1_address = (e1_x % 40) + (e1_y % 66)*40;
	
	
	
	StandingL1_Enemy_Green_rom StandingL1_Enemy_Green_rom (
	.clock   (pixel_clk),
	.address (enemy1_address),
	.q       (rom_1L)
	);

	StandingL1_Enemy_Green_palette StandingL1_Enemy_Green_palette (
	.index (rom_1L),
	.red   (red_1L),
	.green (green_1L),
	.blue  (blue_1L)
	);
	
	StandingR1_Enemy_green_rom StandingR1_Enemy_green_rom (
	.clock   (pixel_clk),
	.address (enemy1_address),
	.q       (rom_1R)
	);

	StandingR1_Enemy_green_palette StandingR1_Enemy_green_palette (
	.index (rom_1R),
	.red   (red_1R),
	.green (green_1R),
	.blue  (blue_1R)
	);
	
	logic [12:0] enemyR1_address;
	logic [3:0] rom_R1L, rom_R2L, rom_R3L, rom_R4L, rom_R5L, rom_R6L;
	logic [3:0] rom_R1R, rom_R2R, rom_R3R, rom_R4R, rom_R5R, rom_R6R;
	logic [3:0] rom_SL, rom_SR;
	
	logic [3:0] red_R1L, blue_R1L, green_R1L;
	logic [3:0] red_R2L, blue_R2L, green_R2L;
	logic [3:0] red_R3L, blue_R3L, green_R3L;
	logic [3:0] red_R4L, blue_R4L, green_R4L;
	logic [3:0] red_R5L, blue_R5L, green_R5L;
	logic [3:0] red_R6L, blue_R6L, green_R6L;
	
	logic [3:0] red_R1R, blue_R1R, green_R1R;
	logic [3:0] red_R2R, blue_R2R, green_R2R;
	logic [3:0] red_R3R, blue_R3R, green_R3R;
	logic [3:0] red_R4R, blue_R4R, green_R4R;
	logic [3:0] red_R5R, blue_R5R, green_R5R;
	logic [3:0] red_R6R, blue_R6R, green_R6R;
	
	logic [3:0] red_SL, blue_SL, green_SL;
	logic [3:0] red_SR, blue_SR, green_SR;
	
	int eR1l, eR1u, eR1_x, eR1_y;
	
	assign eR1l = eRX - eRW;
	assign eR1u = eRY - eRH;
	
	assign eR1_x = DrawX - eR1l;
	assign eR1_y = DrawY - eR1u;
	
	
	assign enemyR1_address = (eR1_x % 40) + (eR1_y % 66)*40;
	
	RunningL1_Enemy_green_rom RunningL1_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R1L)
	);
	
	RunningL1_Enemy_green_palette RunningL1_Enemy_green_palette (
	.index	(rom_R1L),
	.red		(red_R1L),
	.green	(green_R1L),
	.blue		(blue_R1L)
	);
	
	RunningL2_Enemy_green_rom RunningL2_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R2L)
	);
	
	RunningL2_Enemy_green_palette RunningL2_Enemy_green_palette (
	.index	(rom_R2L),
	.red		(red_R2L),
	.green	(green_R2L),
	.blue		(blue_R2L)
	);
	
	RunningL3_Enemy_green_rom RunningL3_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R3L)
	);
	
	RunningL3_Enemy_green_palette RunningL3_Enemy_green_palette (
	.index	(rom_R3L),
	.red		(red_R3L),
	.green	(green_R3L),
	.blue		(blue_R3L)
	);
	
	RunningL4_Enemy_green_rom RunningL4_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R4L)
	);
	
	RunningL4_Enemy_green_palette RunningL4_Enemy_green_palette (
	.index	(rom_R4L),
	.red		(red_R4L),
	.green	(green_R4L),
	.blue		(blue_R4L)
	);
	
	RunningL5_Enemy_green_rom RunningL5_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R5L)
	);
	
	RunningL5_Enemy_green_palette RunningL5_Enemy_green_palette (
	.index	(rom_R5L),
	.red		(red_R5L),
	.green	(green_R5L),
	.blue		(blue_R5L)
	);
	
	RunningL6_Enemy_green_rom RunningL6_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R6L)
	);
	
	RunningL6_Enemy_green_palette RunningL6_Enemy_green_palette (
	.index	(rom_R6L),
	.red		(red_R6L),
	.green	(green_R6L),
	.blue		(blue_R6L)
	);
	
	RunningR1_Enemy_green_rom RunningR1_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R1R)
	);
	
	RunningR1_Enemy_green_palette RunningR1_Enemy_green_palette (
	.index	(rom_R1R),
	.red		(red_R1R),
	.green	(green_R1R),
	.blue		(blue_R1R)
	);
	
	RunningR2_Enemy_green_rom RunningR2_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R2R)
	);
	
	RunningR2_Enemy_green_palette RunningR2_Enemy_green_palette (
	.index	(rom_R2R),
	.red		(red_R2R),
	.green	(green_R2R),
	.blue		(blue_R2R)
	);
	
	RunningR3_Enemy_green_rom RunningR3_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R3R)
	);
	
	RunningR3_Enemy_green_palette RunningR3_Enemy_green_palette (
	.index	(rom_R3R),
	.red		(red_R3R),
	.green	(green_R3R),
	.blue		(blue_R3R)
	);
	
	RunningR4_Enemy_green_rom RunningR4_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R4R)
	);
	
	RunningR4_Enemy_green_palette RunningR4_Enemy_green_palette (
	.index	(rom_R4R),
	.red		(red_R4R),
	.green	(green_R4R),
	.blue		(blue_R4R)
	);
	
	RunningR5_Enemy_green_rom RunningR5_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R5R)
	);
	
	RunningR5_Enemy_green_palette RunningR5_Enemy_green_palette (
	.index	(rom_R5R),
	.red		(red_R5R),
	.green	(green_R5R),
	.blue		(blue_R5R)
	);
	
	RunningR6_Enemy_green_rom RunningR6_Enemy_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address),
	.q			(rom_R6R)
	);
	
	RunningR6_Enemy_green_palette RunningR6_Enemy_green_palette (
	.index	(rom_R6R),
	.red		(red_R6R),
	.green	(green_R6R),
	.blue		(blue_R6R)
	);
	
	
	RunningL_Enemy_Shoot_green_rom RunningL_Enemy_Shoot_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address), 
	.q			(rom_SL)
	);
	
	RunningL_Enemy_Shoot_green_palette RunningL_Enemy_Shoot_green_palette (
	.index	(rom_SL),
	.red		(red_SL),
	.green	(green_SL),
	.blue		(blue_SL)
	);
	
	RunningR_Enemy_Shoot_green_rom RunningR_Enemy_Shoot_green_rom (
	.clock	(pixel_clk),
	.address	(enemyR1_address), 
	.q			(rom_SR)
	);
	
	RunningR_Enemy_Shoot_green_palette RunningR_Enemy_Shoot_green_palette (
	.index	(rom_SR),
	.red		(red_SR),
	.green	(green_SR),
	.blue		(blue_SR)
	);
	
	
	logic [13:0] over_address;
	logic [1:0] rom_over;
	logic [3:0] red_over, blue_over, green_over;
	
	int over_x, over_y;
	assign over_x = DrawX - 270;
	assign over_y = DrawY - 150;
	
	assign over_address = over_x + over_y*100;

	Contra_Game_Over_100_rom Contra_Game_Over_100_rom (
	.clock   (pixel_clk),
	.address (over_address),
	.q       (rom_over)
	);

	Contra_Game_Over_100_palette Contra_Game_Over_100_palette (
	.index (rom_over),
	.red   (red_over),
	.green (green_over),
	.blue  (blue_over)
	);
	
	logic [13:0] score_address;
	logic [1:0] rom_score;

	logic [3:0] red_score, green_score, blue_score;
	
	
	int score_x, score_y;
	assign score_x = DrawX - 270;
	assign score_y = DrawY - 240;
	
	assign score_address = score_x + score_y*100;
	
	
	Score_rom Score_rom (
	.clock   (pixel_clk),
	.address (score_address),
	.q       (rom_score)
	);

	Score_palette Score_palette (
	.index (rom_score),
	.red   (red_score),
	.green (green_score),
	.blue  (blue_score)
	);
	
	logic [8:0] number_address;
	logic [1:0] rom_0, rom_1, rom_2, rom_3, rom_4, rom_5, rom_6, rom_7, rom_8, rom_9;
	
	int num;
	
	logic [3:0] red_0, green_0, blue_0;
	logic [3:0] red_1, green_1, blue_1;
	logic [3:0] red_2, green_2, blue_2;
	logic [3:0] red_3, green_3, blue_3;
	logic [3:0] red_4, green_4, blue_4;
	logic [3:0] red_5, green_5, blue_5;
	logic [3:0] red_6, green_6, blue_6;
	logic [3:0] red_7, green_7, blue_7;
	logic [3:0] red_8, green_8, blue_8;
	logic [3:0] red_9, green_9, blue_9;
	
	
	int n_x, n_y;
	
	
	always_comb begin 
		if(DrawX <= 310) begin
			n_x = DrawX - 295;
			n_y = DrawY - 282;
			num = score/100;
		end
		else if(DrawX <= 329) begin
			n_x = DrawX - 314;
			n_y = DrawY - 282;
			num = (score/10)%10;
		end
		else begin
			n_x = DrawX - 333;
			n_y = DrawY - 282;
			num = (score % 10);
		end
	end
	
	assign number_address = (n_x%14) + (n_y%14)*14;
	
	
	New_Zero_rom New_Zero_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_0)
	);

	New_Zero_palette New_Zero_palette (
	.index (rom_0),
	.red   (red_0),
	.green (green_0),
	.blue  (blue_0)
	);
	
	New_One_rom New_One_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_1)
	);

	New_One_palette New_One_palette (
	.index (rom_1),
	.red   (red_1),
	.green (green_1),
	.blue  (blue_1)
	);
	
	New_Two_rom New_Two_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_2)
	);

	New_Two_palette New_Two_palette (
	.index (rom_2),
	.red   (red_2),
	.green (green_2),
	.blue  (blue_2)
	);
	
	New_Three_rom New_Three_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_3)
	);

	New_Three_palette New_Three_palette (
	.index (rom_3),
	.red   (red_3),
	.green (green_3),
	.blue  (blue_3)
	);

	New_Four_rom New_Four_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_4)
	);

	New_Four_palette New_Four_palette (
	.index (rom_4),
	.red   (red_4),
	.green (green_4),
	.blue  (blue_4)
	);
	
	New_Five_rom New_Five_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_5)
	);

	New_Five_palette New_Five_palette (
	.index (rom_5),
	.red   (red_5),
	.green (green_5),
	.blue  (blue_5)
	);
	
	New_Six_rom New_Six_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_6)
	);

	New_Six_palette New_Six_palette (
	.index (rom_6),
	.red   (red_6),
	.green (green_6),
	.blue  (blue_6)
	);
	
	New_Seven_rom New_Seven_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_7)
	);

	New_Seven_palette New_Seven_palette (
	.index (rom_7),
	.red   (red_7),
	.green (green_7),
	.blue  (blue_7)
	);
	
	New_Eight_rom New_Eight_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_8)
	);

	New_Eight_palette New_Eight_palette (
	.index (rom_8),
	.red   (red_8),
	.green (green_8),
	.blue  (blue_8)
	);
	
	New_Nine_rom New_Nine_rom (
	.clock   (pixel_clk),
	.address (number_address),
	.q       (rom_9)
	);

	New_Nine_palette New_Nine_palette (
	.index (rom_9),
	.red   (red_9),
	.green (green_9),
	.blue  (blue_9)
	);

	
	



	
	 
	 
    //local variables for calculation
    logic ball_on, player_on, platform_on, enemy_on, enemy_ball_on, life_on, over_on;
	 logic enemyR_on, enemyR_ball_on, score_on, num_on;
    int b_S, DistX, DistY, db1x, db1y, db2x, db2y, db3x, db3y, db4x, db4y;
	 int pdX, pdY, p_w, p_h;
	 int edX, edY, e_W, e_H;
	 int eRdX, eRdY, eR_W, eR_H;
	 int lifex1, lifey1, lifex2, lifey2, lifex3, lifey3, life_s;
//	 int p1dx, p1dy, p2dx, p2dy;
//	 int w1, h1, w2, h2;

	 int enemy_ballx, enemy_bally;
	 int enemyR_ballx, enemyR_bally;
	 
	 //ball
	 assign b_S = 2;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
	 assign db1x = DrawX - b1X;
	 assign db1y = DrawY - b1Y;
	 assign db2x = DrawX - b2X;
	 assign db2y = DrawY - b2Y;
	 assign db3x = DrawX - b3X;
	 assign db3y = DrawY - b3Y;
	 assign db4x = DrawX - b4X;
	 assign db4y = DrawY - b4Y;
	 
	 //player
	 assign pdX = DrawX - playerX;
	 assign pdY = DrawY - playerY;
	 assign p_w = playerW;
	 assign p_h = playerH;
	 
	 
	 //lives
	 assign lifex1 = DrawX - 20;
	 assign lifey1 = DrawY - 20;
	 
	 assign lifex2 = DrawX - 40;
	 assign lifey2 = DrawY - 20;
	 
	 assign lifex3 = DrawX - 60;
	 assign lifey3 = DrawY - 20;
	 
	 assign life_s = 5;
	 
	 
	 
	 
	 //enemy
	 
	 assign edX = DrawX - eX;
	 assign edY = DrawY - eY;
	 assign e_W = eW;
	 assign e_H = eH;
	 
	 assign enemy_ballx = DrawX - ebX;
	 assign enemy_bally = DrawY - ebY;
	 
	 //Running Enemy:
	 
	 assign eRdX = DrawX - eRX;
	 assign eRdY = DrawY - eRY;
	 assign eR_W = eRW;
	 assign eR_H = eRH;
	 
	 assign enemyR_ballx = DrawX - eRbX;
	 assign enemyR_bally = DrawY - eRbY;
	 
	 
//	 //platform1 
//	 assign p1dx = DrawX - p1X;
//	 assign p1dy = DrawY - p1Y;
//	 assign w1 = p1W;
//	 assign h1 = p1H;
//	 
//	 //platform2
//	 assign p2dx = DrawX - p2X;
//	 assign p2dy = DrawY - p2Y;
//	 assign w2 = p2W;
//	 assign h2 = p2H;
	  
    always_comb
    begin
        if (( DistX*DistX + DistY*DistY) <= (b_S * b_S) || (db1x*db1x + db1y*db1y) <= (b_S * b_S) ||
				(db2x*db2x + db2y*db2y) <= (b_S * b_S) || (db3x*db3x + db3y*db3y) <= (b_S * b_S) ||
				(db4x*db4x + db4y*db4y) <= (b_S * b_S)) begin
            ball_on = 1'b1; end
        else begin
            ball_on = 1'b0; end
		
		  if(pdX <= p_w &&  pdY <= p_h && pdX >= (~p_w)+1 && pdY >= (~p_h)+1) begin
				player_on = 1'b1; end
		  else begin
				player_on = 1'b0; end
				
				
		  if(edX <= e_W &&  edY <= e_H && edX >= (~e_W)+1 && edY >= (~e_H)+1) begin
				enemy_on = 1'b1; end
		  else begin
				enemy_on = 1'b0; end
				
		  if(eRdX <= eR_W &&  eRdY <= eR_H && eRdX >= (~eR_W)+1 && eRdY >= (~eR_H)+1) begin
				enemyR_on = 1'b1; end
		  else begin
				enemyR_on = 1'b0; end	
				
		  if((enemy_ballx * enemy_ballx) +  (enemy_bally * enemy_bally) <= (b_S * b_S)) begin
				enemy_ball_on = 1'b1; end
		  else begin
				enemy_ball_on = 1'b0; end
				
		  if((enemyR_ballx * enemyR_ballx) +  (enemyR_bally * enemyR_bally) <= (b_S * b_S)) begin
				enemyR_ball_on = 1'b1; end
		  else begin
				enemyR_ball_on = 1'b0; end
				
		  if(lives < 3'd3 && lifex1 <= life_s &&  lifey1 <= life_s && lifex1 >= (~life_s)+1 && lifey1 >= (~life_s)+1) begin
				life_on = 1'b1; end
		  else begin
				life_on = 1'b0; end
			
		  if(life_on == 1'b1 || (lives < 3'd2 && lifex2 <= life_s &&  lifey2 <= life_s && lifex2 >= (~life_s)+1 && lifey2 >= (~life_s)+1)) begin
				life_on = 1'b1; end
		  else begin
				life_on = 1'b0; end
				
			if(life_on == 1'b1 || (lives == 3'd0 && lifex3 <= life_s &&  lifey3 <= life_s && lifex3 >= (~life_s)+1 && lifey3 >= (~life_s)+1)) begin
				life_on = 1'b1; end
		  else begin
				life_on = 1'b0; end
				
		  if(DrawX >= 270 && DrawX <= 370 && DrawY >= 150 && DrawY <= 225) begin
				over_on = 1'b1; end
		  else begin
				over_on = 1'b0; end
				
				
			if(DrawX >= 270 && DrawX <= 370 && DrawY >= 240 && DrawY <= 280) begin
				score_on = 1'b1; end
		  else begin
				score_on = 1'b0; end
				
			if((DrawY >= 282 && DrawY <= 296) && ((DrawX >= 295 && DrawX <= 309) || 
			   (DrawX >= 314 && DrawX <= 328) || (DrawX >= 333 && DrawX <= 347))) begin
				num_on = 1'b1; end
			else begin
				num_on = 1'b0; end

		
				
//		  if((p1dx <= w1 && p1dy <= h1 && p1dx >= (~w1)+1 && p1dy >= (~h1)+1) ||
//				(p2dx <= w2 && p2dy <= h2 && p2dx >= (~w2)+1 && p2dy >= (~h2)+1)) begin
//				platform_on = 1'b1; end
//		  else begin
//				platform_on = 1'b0; end
			
			
     end 

//	 logic e_on, b_on;
//	 
//	 always_ff @ (posedge frame_clk) begin
//		 if(Reset) begin
//			hit <= 1'b0;
//			e_on <= 1'b0;
//			b_on <= 1'b0;
//		 end
//		 else begin
//			e_on <= enemy_on;
//			b_on <= ball_on;
//			hit <= e_on & b_on;
//		 end
//	 end	
	 
	     
    always_ff @ (posedge pixel_clk)
    begin:RGB_Display
		  if(~blank) begin
				Red <= 8'h00;
            Green <= 8'h00;
            Blue <= 8'h00;
		  
		  end 
		  else if(start == 1'b1) begin
				if(DrawX <= 10) begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
				end
				else begin
					Red <= red_start;
					Green <= green_start;
					Blue <= blue_start;
				end
		  end
		  else if(over == 1'b1) begin
				Red <= 8'h00;
				Green <= 8'h00;
				Blue <= 8'h00;
				
				if(over_on) begin
					Red <= red_over;
					Green <= green_over;
					Blue <= blue_over;
				end
				if(score_on) begin
					Red <= red_score;
					Green <= green_score;
					Blue <= blue_score;
				end
				if(num_on) begin
					if(n_x > 0 && n_y > 0 && n_y < 13) begin
						if(num == 0) begin
							Red <= red_0;
							Green <= green_0;
							Blue <= blue_0;
						end
						else if(num == 1) begin
							Red <= red_1;
							Green <= green_1;
							Blue <= blue_1;
						end
						else if(num == 2) begin
							Red <= red_2;
							Green <= green_2;
							Blue <= blue_2;
						end
						else if(num == 3) begin
							Red <= red_3;
							Green <= green_3;
							Blue <= blue_3;
						end
						else if(num == 4) begin
							Red <= red_4;
							Green <= green_4;
							Blue <= blue_4;
						end
						else if(num == 5) begin
							Red <= red_5;
							Green <= green_5;
							Blue <= blue_5;
						end
						else if(num == 6) begin
							Red <= red_6;
							Green <= green_6;
							Blue <= blue_6;
						end
						else if(num == 7) begin
							Red <= red_7;
							Green <= green_7;
							Blue <= blue_7;
						end
						else if(num == 8) begin
							Red <= red_8;
							Green <= green_8;
							Blue <= blue_8;
						end
						else if(num == 9) begin
							Red <= red_9;
							Green <= green_9;
							Blue <= blue_9;
						end
					end
				end
		  end
        else if(play == 1'b1 || egg == 1'b1) begin 
				if(tile == 3'b010) begin
						Red <= red_grass;
						Green <= green_grass;
						Blue <= blue_grass;
				end
				else if(egg == 1'b1) begin
					Red <= red_cheng;
					Green <= green_cheng;
					Blue <= blue_cheng;
				
				end
				else if(tile == 3'b000) begin
						Red <= red_sky;
						Green <= green_sky;
						Blue <= blue_sky;
				end
				else if(tile == 3'b001) begin
						Red <= red_water;
						Green <= green_water;
						Blue <= blue_water;				
				end
			   else if(tile == 3'b011) begin
						Red <= red_boulder;
						Green <= green_boulder;
						Blue <= blue_boulder;
				end	
				else if(tile == 3'b100) begin
						Red <= red_wood;
						Green <= green_wood;
						Blue <= blue_wood;
				end	
				else if(tile == 3'b101) begin
						if(red_leaf != 0 || green_leaf != 0 || blue_leaf != 0) begin
							Red <= red_leaf;
							Green <= green_leaf;
							Blue <= blue_leaf;
						end
						else begin
							Red <= red_wood;
							Green <= green_wood;
							Blue <= blue_wood;		
						end
				end
				
				if(ball_on) begin
					Red <= 8'hff;
               Green <= 8'hff;
               Blue <= 8'hff;
				end
				if(enemy_ball_on && play) begin
					Red <= 8'hff;
               Green <= 8'h00;
               Blue <= 8'h00;
				end
				if(enemyR_ball_on && play) begin
					Red <= 8'hff;
               Green <= 8'h00;
               Blue <= 8'h00;
				end
//				if(platform_on) begin
//					Red <= 8'h00;
//               Green <= 8'h00;
//               Blue <= 8'h00;
//				
//				end
				if(enemy_on & eAlive) begin
					if(e1_x > 0 && e1_y > 0 && e1_y < 65) begin
						if(e1sprite == 1'b1) begin
							if(red_1R != 4'h0 || green_1R < 4'h5) begin
								Red <= red_1R;
								Green <= green_1R;
								Blue <= blue_1R;
							end
						end
						else begin
							if(red_1L != 4'h0 || green_1L < 4'h7) begin
								Red <= red_1L;
								Green <= green_1L;
								Blue <= blue_1L;
							end
						end
					end
				end
				if(enemyR_on & eRAlive) begin
					if(eR1_x > 0 && eR1_y > 0 && eR1_y < 65) begin
						if(eR1sprite == 1'b1) begin
							if(esprite == 12'd1) begin
								if(red_R1L != 4'h0 || green_R1L < 4'h5) begin
									Red <= red_R1L;
									Green <= green_R1L;
									Blue <= blue_R1L;
								end
							end
							else if(esprite == 12'd2) begin
								if(red_R2L != 4'h0 || green_R2L < 4'h5) begin
									Red <= red_R2L;
									Green <= green_R2L;
									Blue <= blue_R2L;
								end
							end
							else if(esprite == 12'd4) begin
								if(red_R3L != 4'h0 || green_R3L < 4'h5) begin
									Red <= red_R3L;
									Green <= green_R3L;
									Blue <= blue_R3L;
								end
							end
							else if(esprite == 12'd8) begin
								if(red_R4L != 4'h0 || green_R4L < 4'h5) begin
									Red <= red_R4L;
									Green <= green_R4L;
									Blue <= blue_R4L;
								end
							end
							else if(esprite == 12'd16) begin
								if(red_R5L != 4'h0 || green_R5L < 4'h5) begin
									Red <= red_R5L;
									Green <= green_R5L;
									Blue <= blue_R5L;
								end
							end
							else if(esprite == 12'd32) begin
								if(red_R6L != 4'h0 || green_R6L < 4'h5) begin
									Red <= red_R6L;
									Green <= green_R6L;
									Blue <= blue_R6L;
								end
							end
							else if(esprite == 12'd64) begin
								if(red_R1R != 4'h0 || green_R1R < 4'h5) begin
									Red <= red_R1R;
									Green <= green_R1R;
									Blue <= blue_R1R;
								end
							end
							else if(esprite == 12'd128) begin
								if(red_R2R != 4'h0 || green_R2R < 4'h5) begin
									Red <= red_R2R;
									Green <= green_R2R;
									Blue <= blue_R2R;
								end
							end
							else if(esprite == 12'd256) begin
								if(red_R3R != 4'h0 || green_R3R < 4'h5) begin
									Red <= red_R3R;
									Green <= green_R3R;
									Blue <= blue_R3R;
								end
							end
							else if(esprite == 12'd512) begin
								if(red_R4R != 4'h0 || green_R4R < 4'h5) begin
									Red <= red_R4R;
									Green <= green_R4R;
									Blue <= blue_R4R;
								end
							end
							else if(esprite == 12'd1024) begin
								if(red_R5R != 4'h0 || green_R5R < 4'h5) begin
									Red <= red_R5R;
									Green <= green_R5R;
									Blue <= blue_R5R;
								end
							end
							else if(esprite == 12'd2048) begin
								if(red_R6R != 4'h0 || green_R6R < 4'h5) begin
									Red <= red_R6R;
									Green <= green_R6R;
									Blue <= blue_R6R;
								end
							end
							else if(esprite == 12'd2000) begin
								if(red_SL != 4'h0 || green_SL < 4'h5) begin
									Red <= red_SL;
									Green <= green_SL;
									Blue <= blue_SL;
								end
							end
							else if(esprite == 12'd2030) begin
								if(red_SR != 4'h0 || green_SR < 4'h5) begin
									Red <= red_SR;
									Green <= green_SR;
									Blue <= blue_SR;
								end
							end
						end
					end
				end
				if(player_on) begin
					if(h_x > 0 && h_y > 0 && h_y < 65) begin
						if(psprite == 12'd1) begin
							if(red_waitR != 4'h0 || green_waitR < 4'h7) begin
								Red <= red_waitR;
								Green <= green_waitR;
								Blue <= blue_waitR;
							end	
						end
						else if(psprite == 12'd2) begin
							if(red_waitL != 4'h0 || green_waitL < 4'h7) begin
								Red <= red_waitL;
								Green <= green_waitL;
								Blue <= blue_waitL;
							end	
						end
						else if(psprite == 12'd4) begin
							if(red_R1 != 4'h0 || green_R1 < 4'h7) begin
								Red <= red_R1;
								Green <= green_R1;
								Blue <= blue_R1;
							end	
						end
						else if(psprite == 12'd8) begin
							if(red_R2 != 4'h0 || green_R2 < 4'h7) begin
								Red <= red_R2;
								Green <= green_R2;
								Blue <= blue_R2;
							end	
						end
						else if(psprite == 12'd16) begin
							if(red_R3 != 4'h0 || green_R3 < 4'h7) begin
								Red <= red_R3;
								Green <= green_R3;
								Blue <= blue_R3;
							end	
						end
						else if(psprite == 12'd32) begin
							if(red_R4 != 4'h0 || green_R4 < 4'h7) begin
								Red <= red_R4;
								Green <= green_R4;
								Blue <= blue_R4;
							end	
						end
						else if(psprite == 12'd64) begin
							if(red_R5 != 4'h0 || green_R5 < 4'h7) begin
								Red <= red_R5;
								Green <= green_R5;
								Blue <= blue_R5;
							end	
						end
						else if(psprite == 12'd128) begin
							if(red_L1 != 4'h0 || green_L1 < 4'h7) begin
								Red <= red_L1;
								Green <= green_L1;
								Blue <= blue_L1;
							end	
						end
						else if(psprite == 12'd256) begin
							if(red_L2 != 4'h0 || green_L2 < 4'h7) begin
								Red <= red_L2;
								Green <= green_L2;
								Blue <= blue_L2;
							end	
						end
						else if(psprite == 12'd512) begin
							if(red_L3 != 4'h0 || green_L3 < 4'h7) begin
								Red <= red_L3;
								Green <= green_L3;
								Blue <= blue_L3;
							end	
						end
						else if(psprite == 12'd1024) begin
							if(red_L4 != 4'h0 || green_L4 < 4'h7) begin
								Red <= red_L4;
								Green <= green_L4;
								Blue <= blue_L4;
							end	
						end
						else if(psprite == 12'd2048) begin
							if(red_L5 != 4'h0 || green_L5 < 4'h7) begin
								Red <= red_L5;
								Green <= green_L5;
								Blue <= blue_L5;
							end	
						end		
					end
				end
				
				if(life_on) begin
					if(red_life != 0 || green_life != 0 || blue_life != 0) begin
						Red <= red_life;
						Green <= green_life;
						Blue <= blue_life;
					end
				end
        end      
    end 
    
endmodule
