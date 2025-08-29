module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter IDLE=0, F=1, S0=2, S1=3, S2=4, T0=5, T1=6, ZERO=7, ONE=8;
    reg [3:0]state, next;
    
    always @(*)begin
        case (state)
            IDLE: next = F;
            F: next = S0;
            S0: next = x? S1 : S0;
            S1: next = x? S1 : S2;
            S2: next = x? T0 : S0;
            T0: next = y? ONE : T1;
            T1: next = y? ONE : ZERO;
            ONE: next = ONE;
            ZERO: next = ZERO;
        endcase
    end
    
    always @(posedge clk)begin
        if (~resetn)
            state <= IDLE;
        else 
            state <= next;
    end
    
    assign f = (state==F);
    assign g = (state==T0) | (state==T1) | (state==ONE);
endmodule
