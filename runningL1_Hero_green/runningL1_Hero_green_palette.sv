module runningL1_Hero_green_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'h0, 4'hE, 4'h1};
	palette[02] = {4'hE, 4'hC, 4'hA};
	palette[03] = {4'h0, 4'h4, 4'hE};
	palette[04] = {4'hE, 4'h3, 4'h0};
	palette[05] = {4'h7, 4'h7, 4'h6};
	palette[06] = {4'h0, 4'h8, 4'h0};
	palette[07] = {4'h6, 4'h1, 4'h0};
end

endmodule
