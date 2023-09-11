module New_Seven_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:195] /* synthesis ram_init_file = "./New_Seven/New_Seven.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
