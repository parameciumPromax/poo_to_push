// Inverting-output binary-to-seven-segment decoder dataflow 
module bin_7seg_decoder_inv_dataflow(
    input D3, D2, D1, D0,
    output g, f, e, d, c, b, a
);

// body of decoder
assign a = (~D3 & ~D1 & (D2 ^ D0)) | (D3 & D0 & (D2 ^ D1));
assign b = (D2 & ~D1 & (D3 ^ D0)) | (D3 & D1 & D0) | (D2 & D1 & ~D0);
assign c = (~D3 & ~D2 & D1 & ~D0) | (D3 & D2 & (D1 ^ D0)); 
assign d = (~D3 & ~D1 & (D2 ^ D0)) | (D2 & D1 & D0) | (D3 & ~D2 & D1 & ~D0);
assign e = (~D3 & D2 & ~D1) | (~D2 & ~D1 & D0) | (~D3 & D0);
assign f = (~D3 & ~D2 & (D1 | D0)) | (D2 & D0 & (D3 ^ D1));
assign g = (~D3 & ~D2 & ~D1) | (D3 & D2 & ~D1 & ~D0) | (~D3 & D2 & D1 & D0);

endmodule
//I don't know why it works or not
//is that because it SHOULD add brackets?
//okay, it's my fault 