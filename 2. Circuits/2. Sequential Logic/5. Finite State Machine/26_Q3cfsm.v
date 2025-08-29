module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
    reg [2:0]next;
    
    always @(*)begin
        case (y)
            S0: next = x? S1 : S0;
            S1: next = x? S4 : S1;
        	S2: next = x? S1 : S2;
            S3: next = x? S2 : S1;
            S4: next = x? S4 : S3;
            default: next = S0;
        endcase
    end
    
    assign z = (y==S3) | (y==S4);
    assign Y0 = next[0];
endmodule
