module runningR4_Hero_green_rom (
	input logic clock,
	input logic [11:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:2639] /* synthesis ram_init_file = "./runningR4_Hero_green/runningR4_Hero_green.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
