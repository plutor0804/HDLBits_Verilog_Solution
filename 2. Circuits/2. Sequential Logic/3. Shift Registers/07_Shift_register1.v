module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    reg [3:0]dff;
    always @(posedge clk)begin
        if (~resetn)
            dff <= 4'h0;
        else
            dff <= {in, dff[3:1]};
    end
    assign out = dff[0];
endmodule
