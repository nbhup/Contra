module RunningR_Enemy_Shoot_green_rom (
	input logic clock,
	input logic [11:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:2639] /* synthesis ram_init_file = "./RunningR_Enemy_Shoot_green/RunningR_Enemy_Shoot_green.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
