module top_module( 
    input [254:0] in,
    output [7:0] out );

    reg [7:0]temp;
    always @(*) begin
        temp = 8'd0;
        for (int i=0; i<255; i++) begin
            if (in[i]==1)
                temp++;
        end
    end
    assign out = temp;
endmodule
