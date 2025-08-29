module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A=0, B=1;
    reg state, next;
    reg [1:0]cycle, count;
    
    always @(*)begin
        case (state)
            A: next = s? B : A;
            B: next = B;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)
            state <= A;
        else
            state <= next;
    end
    
    always @(posedge clk)begin
        if (reset)begin
            cycle = 2'd0;
            count = 2'd0;
        end
        case (state)
            A: begin
                cycle = 2'd0;
            	count = 2'd0;
            end
            B: begin
                if (cycle==2'd3) begin
                    cycle = 2'd0;
            		count = 2'd0;
                end
                if (w==1)
                    count = count + 1;
                cycle = cycle + 1;
            end
        endcase
    end

    assign z = ((cycle==2'd3) & (count==2'd2));
        
endmodule
