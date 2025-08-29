module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
    reg [2:0]state, next;
    
    always @(*)begin
        case (state)
            S0: next = x? S1 : S0;
            S1: next = x? S4 : S1;
            S2: next = x? S1 : S2;
            S3: next = x? S2 : S1;
            S4: next = x? S4 : S3;
            default: next = S0;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)
            state <= S0;
        else
            state <= next;
    end
    
    assign z = (state==S3) | (state==S4);
    
endmodule
