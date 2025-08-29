module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire c1, c2;
    add16 a1 (a[15:0], (b[15:0]^{16{sub}}), sub, sum[15:0], c1);
    add16 a2 (a[31:16], (b[31:16]^{16{sub}}), c1, sum[31:16], c2);
    
endmodule
