module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);

    reg [7:0]last_in;
    always @(posedge clk) begin
        last_in <= in;
        pedge <= (last_in^in)&in;
    end
endmodule
