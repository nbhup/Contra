module Contra_Bkg_test_rom (
	input logic clock,
	input logic [18:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:307199] /* synthesis ram_init_file = "./Contra_Bkg_test/Contra_Bkg_test.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
