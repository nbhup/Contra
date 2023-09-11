module Contra_Bkg_test_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h1, 4'h2, 4'h0};
	palette[01] = {4'h6, 4'hA, 4'h9};
end

endmodule
