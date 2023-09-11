module Contra_Grass_Tile_96_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:9215] /* synthesis ram_init_file = "./Contra_Grass_Tile_96/Contra_Grass_Tile_96.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
