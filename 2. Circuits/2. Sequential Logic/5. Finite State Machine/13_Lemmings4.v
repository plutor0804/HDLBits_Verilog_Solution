module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5, S=6;
    reg[2:0]state, next;
    reg[6:0]count;
    
    always @(*)begin
        case (state)
        	L: begin
                if (~ground)
                    next = FL;
                else begin
                    if (dig)
                        next = DL;
                    else if (bump_left)
                        next = R;
                    else 
                        next = L;
                end
            end
            R: begin
                if (~ground)
                    next = FR;
                else begin
                    if (dig)
                        next = DR;
                    else if (bump_right)
                        next = L;
                    else 
                        next = R;
                end
            end
            FL: next = (ground)? ((count>19)? S : L) : FL;
            FR: next = (ground)? ((count>19)? S : R) : FR;
            DL: next = (ground)? DL : FL;
            DR: next = (ground)? DR : FR;
            S: next = S;
        endcase
    end
    
    always @(posedge clk, posedge areset)begin
        if(areset)
            state <= L;
        else if (state==FL || state==FR)begin
            count <= count + 1;
            state <= next;
        end
        else begin
            state <= next;
            count <= 0;
        end
    end
    
    assign walk_left = (state==L);
    assign walk_right = (state==R);
    assign aaah = (state==FL) | (state==FR);
    assign digging = (state==DL) | (state==DR);
endmodule
