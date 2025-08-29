module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    always @(*) begin
        case (sel)
        	4'h0: out = a;
        	4'h1: out = b;
        	4'h2: out = c;
        	4'h3: out = d;
        	4'h4: out = e;
        	4'h5: out = f;
        	4'h6: out = g;
        	4'h7: out = h;
        	4'h8: out = i;
        	4'h9: out = 16'hffff;
        	4'ha: out = 16'hffff;
        	4'hb: out = 16'hffff;
        	4'hc: out = 16'hffff;
        	4'hd: out = 16'hffff;
        	4'he: out = 16'hffff;
        	4'hf: out = 16'hffff;
        endcase
    end
    
endmodule
