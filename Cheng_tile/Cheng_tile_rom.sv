module Cheng_tile_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [3:0] q
);

logic [3:0] memory [0:9215] /* synthesis ram_init_file = "./Cheng_tile/Cheng_tile.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
