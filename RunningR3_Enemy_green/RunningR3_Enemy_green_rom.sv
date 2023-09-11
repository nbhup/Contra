module RunningR3_Enemy_green_rom (
	input logic clock,
	input logic [11:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:2639] /* synthesis ram_init_file = "./RunningR3_Enemy_green/RunningR3_Enemy_green.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
