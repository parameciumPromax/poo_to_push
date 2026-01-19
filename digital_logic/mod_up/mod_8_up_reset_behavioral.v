//a mod-8 up counter with reset by behavioral
module mod_8_up_reset_behavioral(
	input clk, reset_n,
	output reg [2:0] q_out);
	
// the body of THIS reset
always @(posedge clk or negedge reset_n)
	if (!reset_n) q_out <= 0;
	else          q_out <= q_out + 3'b001;
endmodule