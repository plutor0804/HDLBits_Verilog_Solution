module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter B1=0, B2=1, B3=2, DONE=3;
    reg[2:0]state, next;
    reg [23:0]data;
    // FSM from fsm_ps2
    always @(*)begin
        case (state)
            B1: next = in[3] ? B2 : B1;
            B2: next = B3;
            B3: next = DONE;
            DONE: next = in[3] ? B2 : B1;
            default: next = B1;
        endcase
    end
    // New: Datapath to store incoming bytes.
    always @(posedge clk)begin
        if (reset)begin
            state <= B1;
        	data <= 24'b0;
        end
        else begin
            state <= next;
            data <= {data[15:0], in};
        end
    end
            
    assign done = (state==DONE);
    assign out_bytes = done ? data : 24'bx;
endmodule
