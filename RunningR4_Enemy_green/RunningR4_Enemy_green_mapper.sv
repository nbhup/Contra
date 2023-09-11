module RunningR4_Enemy_green_mapper (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [12:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

assign rom_address = (DrawX*40/640) + (DrawY*66/480 * 40);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

RunningR4_Enemy_green_rom RunningR4_Enemy_green_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

RunningR4_Enemy_green_palette RunningR4_Enemy_green_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
