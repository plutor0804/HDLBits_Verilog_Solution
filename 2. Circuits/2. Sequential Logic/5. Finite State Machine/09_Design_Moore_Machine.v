module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0]state, next_state;
    
    always @(*)begin
        case(state)
            A: next_state = (s==3'b111)? A : B;
            B: next_state = (s==3'b111)? A : ((s==3'b011)? B : C);
            C: next_state = (s==3'b011)? B : ((s==3'b001)? C : D);
            D: next_state = (s==3'b000)? D : C;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)
            state <= D;
        else
            state <= next_state;
    end
    
    always @(posedge clk)begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
        else begin
            case (next_state)
                A: begin
                    fr3 <= 0;
            		fr2 <= 0;
            		fr1 <= 0;
            		dfr <= 0;
                end
                B: begin
                    fr3 <= 0;
            		fr2 <= 0;
            		fr1 <= 1;
                    dfr <= (state==C)? 0 : ((state==A)? 1:dfr);
                end
                C: begin
                    fr3 <= 0;
            		fr2 <= 1;
            		fr1 <= 1;
                    dfr <= (state==D)? 0 : ((state==B)? 1:dfr);
                end
                D: begin
                    fr3 <= 1;
            		fr2 <= 1;
            		fr1 <= 1;
            		dfr <= 1;
                end
            endcase
        end
    end
endmodule
