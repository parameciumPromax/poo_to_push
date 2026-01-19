module decoder_3to8_Enable_behavioral(
	input [2:0] x_in,
	output reg [7:0] y_out,
	input Enable);
	
	always@(*)
	begin 
		if (Enable == 1'b0)
			case (x_in)
				3'b000: y_out = 8'b1111_1110;//0 out
				3'b001: y_out = 8'b1111_1101;
				3'b010: y_out = 8'b1111_1011;
				3'b011: y_out = 8'b1111_0111;
				3'b100: y_out = 8'b1110_1111;
				3'b101: y_out = 8'b1101_1111;
				3'b110: y_out = 8'b1011_1111;
				3'b111: y_out = 8'b0111_1111;
			endcase
		else 
			y_out = 8'b1111_1111;//for GENIUS
	end		
endmodule 