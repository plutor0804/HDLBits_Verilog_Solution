module top_module ();
	reg clk, reset, t;
    wire q;
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        reset = 1;
        #10 reset = 0;
    end
    
    initial begin
        t = 0;
        #10 t = 1;
    end
    
    tff ff (clk, reset, t, q);
endmodule
