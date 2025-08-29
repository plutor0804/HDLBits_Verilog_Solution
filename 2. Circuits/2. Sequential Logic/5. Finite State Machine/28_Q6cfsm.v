module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    assign Y2 = ~w&y[1];
    assign Y4 = w&y[2] | w&y[3] | w&y[5] | w&y[6] ;
endmodule
