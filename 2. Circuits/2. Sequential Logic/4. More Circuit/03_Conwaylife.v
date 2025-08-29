module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [255:0]q_next;
    always @(posedge clk)begin
        if (load)
            q <= data;
        else begin
            for (int i=0; i<16; i++) begin
                for (int j=0; j<16; j++) begin
                    integer ni, nj, count;
                    count = 0;
                    
                    for (ni=-1; ni<=1; ni++)
                        for (nj=-1; nj<=1; nj++)
                            if (!(ni==0 && nj==0))
                                count = count + q[16*((16+i+ni)%16)+((16+j+nj)%16)];
                    if (count<=1)
                        q_next[16*i+j] = 0;
                    else if (count == 2)
                        q_next[16*i+j] = q[16*i+j];
                    else if (count == 3)
                        q_next[16*i+j] = 1;
                    else 
                        q_next[16*i+j] = 0;
                end
            end
            
            q <= q_next;
        end
    end
            
endmodule
