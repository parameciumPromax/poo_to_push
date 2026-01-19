//test for inverting-output
//binary to7seg decoder by dataflow
`timescale 1 ns / 100 ps
module bin_7seg_decoder_inv_dataflow_tb;

// signal declaration
reg d3, d2, d1, d0;
wire a, b, c, d, e, f, g;

//Unit Under Test (UUT) instance
bin_7seg_decoder_inv_dataflow uut (
    .D3(d3),
    .D2(d2),
    .D1(d1),
    .D0(d0),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
);

// stimulus generation
integer i;
initial begin
    for (i = 0; i <= 15; i = i + 1) begin
        {d3, d2, d1, d0} = i;
        #10;
    end
end

// finish simulation
initial #200 $finish;

// response monitoring
initial
    $monitor($realtime, " ns input=%b output=%b", {d3,d2,d1,d0}, {g,f,e,d,c,b,a});

endmodule
//I know it is not a good chaged, but to avoid Hiz, it's only one method to get wave
//why i do everything WRONG?