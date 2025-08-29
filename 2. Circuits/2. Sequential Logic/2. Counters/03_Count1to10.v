module top_module (
    input clk,
    input reset,
    output [3:0] q);

    always @(posedge clk)begin
        if (reset==1 || q==4'ha)
            q<=4'h1;
        else
            q<=q+1;
     end
            
endmodule
