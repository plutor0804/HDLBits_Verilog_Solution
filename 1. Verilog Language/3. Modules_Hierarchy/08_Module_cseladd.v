module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire cout_1,cout_2,cout_3;
    wire [15:0] out_0, out_1;
    add16 a1 (a[15:0], b[15:0], 0, sum[15:0], cout_1);
    add16 a2 (a[31:16], b[31:16], 0, out_0, cout_2);
    add16 a3 (a[31:16], b[31:16], 1, out_1, cout_3);
    
    always @(cout_1, out_0, out_1) begin
        case (cout_1)
            1'b0: sum[31:16] = out_0;
            1'b1: sum[31:16] = out_1;
        endcase
    end
    
endmodule
