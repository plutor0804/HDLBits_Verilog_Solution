module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [2:0]counter;
    
    always @(posedge clk)begin
        if (reset)
            counter = 4;
        else if (counter==0)
            counter = 0;
        else 
            counter = counter-1;
    end
    
    assign shift_ena = (counter != 0);    
endmodule
