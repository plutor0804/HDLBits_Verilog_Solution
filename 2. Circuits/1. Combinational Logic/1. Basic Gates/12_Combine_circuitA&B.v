module top_module (input x, input y, output z);

    wire w1, w2, w3, w4;
    assign {w1, w2} = {(x^y) & x, ~(x^y)};
    assign z = (w1|w2)^(w1&w2);
endmodule
