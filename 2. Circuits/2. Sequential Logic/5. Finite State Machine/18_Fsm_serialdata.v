module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE=0, START=1, DATA=2, STOP=3, ERROR=4;
    reg [2:0]state, next;
    reg [3:0]counter;
    reg [7:0]data;
    
    always @(*)begin
        case (state)
            IDLE: next = in ? IDLE : START;
            START: next = DATA;
            DATA: begin
                if (counter==4'd8)
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
            counter <= 4'd0;
        else if (next==DATA)
            counter <= counter+1;
        else 
            counter <= 4'd0;
    end
    
    always @(posedge clk)begin
        if (reset)
            data <= 8'b00;
        else if (next==DATA)
            data[counter] <= in;
    end
        
    assign done = (state==STOP);
    assign out_byte = (done)? data : 8'b0;

endmodule
