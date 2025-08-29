module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0]last_in;
    always @(posedge clk)begin
        last_in <= in;
        if (reset==1)
            out = 32'h00000000;
        else 
            out = out|~in&last_in;
    end
endmodule
