module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, WAIT=9;
    reg [3:0]state, next;
    reg [9:0]count_1000;
    
    always @(*)begin
        case (state)
            S: next = data? S1 : S;
            S1: next = data? S11 : S;
            S11: next = data? S11 : S110;
            S110: next = data? B0 : S;
            B0: next = B1;
            B1: next = B2;
            B2: next = B3;
            B3: next = COUNT;
            COUNT: next = (count==0 & count_1000==999)? WAIT : COUNT;
            WAIT: next = ack? S : WAIT;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)
            state <= S;
        else
            state <= next;
    end
    
    always @(posedge clk)begin
        case (state)
            B0: count[3] <= data;
            B1: count[2] <= data;
            B2: count[1] <= data;
            B3: count[0] <= data;
            COUNT: begin
                if (count>0)begin
                    if (count_1000==999)begin
                        count_1000 <= 0;
                        count <= count-1;
                    end
                    else
                        count_1000 <= count_1000+1;
                end
                else
                    count_1000 <= count_1000+1;
            end
            default: count_1000 <=0;
        endcase
    end
    
    assign counting = (state==COUNT);
    assign done = (state==WAIT);
endmodule
