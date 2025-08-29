module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter IDLE=0, START=1, DATA=2, STOP=3, ERROR=4;
    reg [2:0]state, next;
    reg [2:0]counter;
    
    always @(*)begin
        case (state)
            IDLE: next = in ? IDLE : START;
            START: next = DATA;
            DATA: begin
                if (counter==3'd7)
                    next = in ? STOP : ERROR;
                else 
                    next = DATA;
            end
            STOP: next = in? IDLE : START;
            ERROR: next = in? IDLE : ERROR;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)
            state <= IDLE;
        else
            state <= next;
    end
    
    always @(posedge clk)begin
        if (reset)
            counter <= 3'd0;
        else if (state==DATA)
            counter <= counter+1;
        else
            counter <= 3'd0;
    end
        
    assign done = (state==STOP);
            
                    
endmodule
