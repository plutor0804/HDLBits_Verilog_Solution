module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire c1, c2, c3;
    add16 add1 (a[15:0], b[15:0], c1, sum[15:0], c2);
    add16 add2 (a[31:16], b[31:16], c2, sum[31:16], c3);
    
endmodule
