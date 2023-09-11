module Contra_Grass_Tile_96_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h5, 4'h0};
	palette[01] = {4'hE, 4'hA, 4'h2};
	palette[02] = {4'h8, 4'h6, 4'h0};
	palette[03] = {4'h0, 4'h9, 4'h0};
	palette[04] = {4'h7, 4'hC, 4'h0};
	palette[05] = {4'h4, 4'h2, 4'h0};
	palette[06] = {4'h0, 4'h0, 4'h0};
	palette[07] = {4'h5, 4'hA, 4'h0};
end

endmodule
