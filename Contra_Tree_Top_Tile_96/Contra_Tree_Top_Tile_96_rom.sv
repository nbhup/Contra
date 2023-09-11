module Contra_Tree_Top_Tile_96_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:9215] /* synthesis ram_init_file = "./Contra_Tree_Top_Tile_96/Contra_Tree_Top_Tile_96.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
