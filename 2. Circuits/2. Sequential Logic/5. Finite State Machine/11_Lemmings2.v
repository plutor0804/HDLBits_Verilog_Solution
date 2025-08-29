module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter L=0, R=1, FL=2, FR=3;
    reg [1:0]state, next;
    
    always @(*)begin
        case (state)
            L: begin
                if (~ground)
                    next = FL;
                else if (ground & bump_left)
                    next = R;
                else
                    next = L;
            end
            R: begin
                if (~ground)
                    next = FR;
                else if (ground & bump_right)
                    next = L;
                else
                    next = R;
            end
            FL: begin
                if (ground)
                    next = L;
                else
                    next = FL;
            end
            FR: begin
                if (ground)
                    next = R;
                else
                    next = FR;
            end
        endcase
    end
    
    always @(posedge clk, posedge areset)begin
        if (areset)
            state <= L;
        else
            state <= next;
    end
    
    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FL) || (state == FR);
                    
endmodule
