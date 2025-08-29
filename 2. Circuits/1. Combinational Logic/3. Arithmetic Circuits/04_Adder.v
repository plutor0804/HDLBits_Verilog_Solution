module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire c1, c2, c3;
    assign {c1, sum[0]} = x[0]+y[0];
    assign {c2, sum[1]} = x[1]+y[1]+c1;
    assign {c3, sum[2]} = x[2]+y[2]+c2;
    assign {sum[4], sum[3]} = x[3]+y[3]+c3;
endmodule
