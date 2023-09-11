module RunningR3_Enemy_green_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'hE, 4'h0};
	palette[01] = {4'h5, 4'h4, 4'h4};
	palette[02] = {4'h0, 4'h0, 4'h0};
	palette[03] = {4'hD, 4'hC, 4'hB};
	palette[04] = {4'h0, 4'h8, 4'h0};
	palette[05] = {4'hC, 4'h2, 4'h0};
	palette[06] = {4'h6, 4'h1, 4'h0};
	palette[07] = {4'hA, 4'h8, 4'h7};
end

endmodule
