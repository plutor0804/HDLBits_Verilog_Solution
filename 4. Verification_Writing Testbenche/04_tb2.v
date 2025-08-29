module top_module();
	reg clk, in;
    reg [2:0]s;
    wire out;
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        in = 0;
        #20 in = 1;
        #10 in = 0;
        #10 in = 1;
        #30 in = 0;
    end
    
    initial begin
        s = 3'd2;
        #10 s = 3'd6;
        #10 s = 3'd2;
        #10 s = 3'd7;
        #10 s = 3'd0;
    end
    
    q7 inst (clk, in, s, out);
endmodule
