module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    reg [99:0] cout_temp;
    
    generate
        genvar i;
        for (i=0; i<100; i++) begin: adder
            if (i==0)
                bcd_fadd fa (a[3:0], b[3:0], cin, cout_temp[0], sum[3:0]);
            else
                bcd_fadd fa (a[4*i+3:4*i], b[4*i+3:4*i], cout_temp[i-1], cout_temp[i], sum[4*i+3:4*i]);
        end
    endgenerate
       
    assign cout = cout_temp[99];
endmodule
