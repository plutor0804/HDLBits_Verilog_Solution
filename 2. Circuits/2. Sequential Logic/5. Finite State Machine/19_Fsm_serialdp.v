module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE=0, START=1, DATA=2, CHECK=3, STOP=4, ERROR=5;
    reg [2:0]state, next;
    reg [3:0]counter;
    reg [7:0]data;
    reg odd_reg, odd_reset;
    wire odd;
    // Modify FSM and datapath from Fsm_serialdata
    always @(*)begin
        case (state)
            IDLE: next = in? IDLE : START;
            START: next = DATA;
            DATA: begin 
                if (counter==4'd8)
                    next = CHECK;
                else
                    next = DATA;
            end
            CHECK: next = in? STOP : ERROR;
            STOP: next = in? IDLE : START;
            ERROR: next = in ? IDLE : ERROR;
            default: next = IDLE;
        endcase
    end
    
    always @(posedge clk)begin
        if (reset)begin
            state <= IDLE;
            counter <= 4'd0;
        end
        else if (next==DATA)begin
            counter <= counter + 1;
            data[counter] <= in;
            state <= next;
        end
        else begin
            counter <= 4'd0;
            state <= next;
        end
    end
    // New: Add parity checking.
    parity check (.clk(clk), .in(in), .reset(odd_reset | reset), .odd(odd));
    
    always @(posedge clk)begin
        case (next)
            IDLE, STOP: odd_reset <= 1;
            default: odd_reset <= 0;
        endcase
    end
    
    always @(posedge clk) begin
    	if(reset) odd_reg <= 0;
    	else odd_reg <= odd; 
    end
    
    assign done = (state==STOP) && odd_reg;
    assign out_byte = (done)? data : 8'b0;
endmodule
