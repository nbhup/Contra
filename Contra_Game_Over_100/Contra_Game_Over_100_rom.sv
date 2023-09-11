module Contra_Game_Over_100_rom (
	input logic clock,
	input logic [12:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:7499] /* synthesis ram_init_file = "./Contra_Game_Over_100/Contra_Game_Over_100.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
