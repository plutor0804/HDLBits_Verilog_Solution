module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always @(posedge clk)begin
        if (reset==1 || (q==4'h9 && slowena))
            q<=0;
        else begin
            if (slowena == 0)
                q<=q;
            else 
                q<=q+1;
        end
    end
            
endmodule
