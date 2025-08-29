module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    always @(posedge clk)begin
        if (reset == 1 || q[15:12]==4'd9 && q[11:8]==4'd9 && q[7:4]==4'd9 && q[3:0]==4'd9)
            q<=16'h0000;
        else if(q[11:8]==4'd9 && q[7:4]==4'd9 && q[3:0]==4'd9)begin
            q[11:0] <= 12'h000;
            q[15:12] <= q[15:12] + 4'h1;
        end
        else if(q[7:4]==4'd9 && q[3:0]==4'd9)begin
            q[7:0] <= 8'h00;
            q[11:8] <= q[11:8] + 4'h1;
        end
        else if(q[3:0]==4'd9)begin
            q[3:0] <= 4'h0;
            q[7:4] <= q[7:4] + 4'h1;
        end
        else 
            q[3:0] <= q[3:0]+4'h1;
    end
    assign ena[1] = (q[3:0]==4'h9)? 1'b1 : 1'b0;
    assign ena[2] = (q[7:4]==4'h9 && q[3:0]==4'h9)? 1'b1 : 1'b0;
    assign ena[3] = (q[11:8]==4'h9 && q[7:4]==4'h9 && q[3:0]==4'h9)? 1'b1 : 1'b0;
endmodule
