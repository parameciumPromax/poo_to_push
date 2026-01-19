//test 3-8 decoder
`timescale 1 ns/ 100 ps
module decoder_3to8_Enable_behavioral_tb;

reg[2:0] xin;
reg enable;
wire [7:0] yout;

//unit under test instance and port map
decoder_3to8_Enable_behavioral UUT(
				.x_in(xin), .y_out(yout), .Enable(enable));
		
//wave shape test
integer i;
initial //stimules generation block
	for (i = 0; i <= 24; i = i+1)
		begin
			#20;
			if (i<8)
				enable = 1'b1;
			else
				enable = 1'b0;
			xin = i[2:0];
		end
initial #500 $finish;

initial //response monitoring block
	$monitor($realtime, "ns %b %h %h", enable, xin, yout);
endmodule 